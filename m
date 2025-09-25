Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94AACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZA-0001qN-77; Thu, 25 Sep 2025 05:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYp-0001Vx-Fg
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYV-0001j2-8I
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eqRD9Zdeyk92VWPnwKxNF1eluR+jCOfRnC3AfnbZNU=;
 b=h1N3KmE0bsOGaxs28R2QgUS4Rl/UtunOnYCt4xZNZWQxdPEYm0gaB6VlxmTRAxS5t2ZXC5
 Bih3ZhWByqk/ybpsuG29qBTZe3bolCWbivCzPwvAxGRpLU9Xkiy/Qj1pfyR6HkLp3vt8bc
 UUp3hnRUEKqfprNN0Zhylgy58txc+Bc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-t0MUrkWyNHW2HU3sj-E1Ag-1; Thu,
 25 Sep 2025 05:46:18 -0400
X-MC-Unique: t0MUrkWyNHW2HU3sj-E1Ag-1
X-Mimecast-MFC-AGG-ID: t0MUrkWyNHW2HU3sj-E1Ag_1758793577
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A374180057D; Thu, 25 Sep 2025 09:46:17 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B185730002D2; Thu, 25 Sep 2025 09:46:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 15/23] util: don't skip error prefixes when QMP is active
Date: Thu, 25 Sep 2025 10:44:33 +0100
Message-ID: <20250925094441.1651372-16-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The vreport() function will print to HMP if available, otherwise
to stderr. In the event that vreport() is called during execution
of a QMP command, it will print to stderr, but mistakenly omit the
message prefixes (timestamp, guest name, program name).

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/error-report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index b262ad01cb..872158ad90 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -159,7 +159,7 @@ static void print_loc(void)
     int i;
     const char *const *argp;
 
-    if (!monitor_cur() && g_get_prgname()) {
+    if (!monitor_cur_is_hmp() && g_get_prgname()) {
         error_printf("%s:", g_get_prgname());
         sep = " ";
     }
@@ -203,14 +203,14 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 {
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur()) {
+    if (message_with_timestamp && !monitor_cur_is_hmp()) {
         timestr = real_time_iso8601();
         error_printf("%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur()) {
+    if (error_with_guestname && error_guest_name && !monitor_cur_is_hmp()) {
         error_printf("%s ", error_guest_name);
     }
 
-- 
2.50.1


