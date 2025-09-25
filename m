Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E61CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZ6-0001h0-TF; Thu, 25 Sep 2025 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYd-0001LB-6q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYD-0001fp-D4
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ugudzj32e/ssPp8BKwBNNrrfFJbjTzUZnBF82CHpjVU=;
 b=abwDldbRlAYjWIWJ2IY1871q7ZGBtAOlFIU/3z8cG4Y6ZpUW48Z+JB8iRTZnMRRI9J1W3r
 DatpBx/sII5cU/DwWUFzbyXggB98v08ufTcXzgn2tnIYgBBpSZXLqbQ/903Bq7FcRrD1lb
 8Os++n/BnTTT6AsMGs8bUUxZwpn1170=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-Xxa35lJBMXGKZZbOj_1S8w-1; Thu,
 25 Sep 2025 05:46:01 -0400
X-MC-Unique: Xxa35lJBMXGKZZbOj_1S8w-1
X-Mimecast-MFC-AGG-ID: Xxa35lJBMXGKZZbOj_1S8w_1758793560
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08F9180057A; Thu, 25 Sep 2025 09:45:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3567D300021A; Thu, 25 Sep 2025 09:45:53 +0000 (UTC)
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
Subject: [PATCH v4 12/23] monitor: refactor error_vprintf()
Date: Thu, 25 Sep 2025 10:44:30 +0100
Message-ID: <20250925094441.1651372-13-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The monitor_vprintf() code will return -1 if either the monitor
is NULL, or the monitor is QMP. The error_vprintf() code can
take advantage of this to avoid having to duplicate the same
checks, and instead simply look at the return value.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 03dbe5d131..c00f4aac5a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -268,17 +268,19 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
-/*
- * Print to current monitor if we have one, else to stderr.
- */
 int error_vprintf(const char *fmt, va_list ap)
 {
     Monitor *cur_mon = monitor_cur();
-
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
+    /*
+     * This will return -1 if 'cur_mon' is NULL, or is QMP.
+     * IOW this will only print if in HMP, otherwise we
+     * fallback to stderr for QMP / no-monitor scenarios.
+     */
+    int ret = monitor_vprintf(cur_mon, fmt, ap);
+    if (ret == -1) {
+        ret = vfprintf(stderr, fmt, ap);
     }
-    return vfprintf(stderr, fmt, ap);
+    return ret;
 }
 
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
-- 
2.50.1


