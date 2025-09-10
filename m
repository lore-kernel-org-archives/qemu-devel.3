Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECA3CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBr-0008MR-KB; Wed, 10 Sep 2025 14:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBq-0008LI-Jt
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBo-0004qL-PV
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwEMMHbEmgJDVB/xeKh2fCOUkpEHTfgjT4rA2HHkxBw=;
 b=JeL64Y3Z1o8xsyRdlwckV4picjjwpl7ZyZzA6am835BJ6ERgLbvYzB+K/+LtKY0dWjeW19
 hXKDlEB6S/YPVXxjNDr2GVvOsTsGUzZQFlL08qafsj8mEH018Pcz/rZsJZvcy8IU+u7iCY
 1kiQhYKH0RUpQyJrzip/jT/lYRz0/nw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-4zM5zn98N_aiYc2J0fCGug-1; Wed,
 10 Sep 2025 14:05:00 -0400
X-MC-Unique: 4zM5zn98N_aiYc2J0fCGug-1
X-Mimecast-MFC-AGG-ID: 4zM5zn98N_aiYc2J0fCGug_1757527499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC3401956087; Wed, 10 Sep 2025 18:04:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C5211800446; Wed, 10 Sep 2025 18:04:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 13/20] util: don't skip error prefixes when QMP is active
Date: Wed, 10 Sep 2025 19:03:50 +0100
Message-ID: <20250910180357.320297-14-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 util/error-report.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index 79b6f23e64..c0fcf388de 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -34,9 +34,9 @@ const char *error_guest_name;
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
+    Monitor *cur_mon = monitor_cur_hmp();
 
-    if (cur_mon && !monitor_cur_is_qmp()) {
+    if (cur_mon) {
         return monitor_vprintf(cur_mon, fmt, ap);
     }
     return vfprintf(stderr, fmt, ap);
@@ -157,7 +157,7 @@ static void print_loc(void)
     int i;
     const char *const *argp;
 
-    if (!monitor_cur() && g_get_prgname()) {
+    if (!monitor_cur_hmp() && g_get_prgname()) {
         error_printf("%s:", g_get_prgname());
         sep = " ";
     }
@@ -201,14 +201,14 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 {
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur()) {
+    if (message_with_timestamp && !monitor_cur_hmp()) {
         timestr = real_time_iso8601();
         error_printf("%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur()) {
+    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
         error_printf("%s ", error_guest_name);
     }
 
-- 
2.50.1


