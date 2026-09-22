Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A2C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yN-00052X-0j; Tue, 22 Sep 2026 16:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xn-0004GO-Rb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xm-00083r-7H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zITn74UA8P4zpzsh9dZZf0zY8iFD58J6Rtd4+E08IZQ=;
 b=bNDVba6Zsmn+LmRd2bwkLkI9JC7mLhUF5bSZSvlUISqwvVmjaoZsGg6GdnTiHqCNAKS2Xi
 1ENQ4+SxU8yxacIMmwv1gbr3jv5xRRxHKx6hHGZaDIBHIvuIcu5hI2fffHQTtWBJ7WQovx
 CHdu5R5+qjhdyYIoN9JVaYKTO4Si0zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-NinC_KgGPBqcDTom4EyGgQ-1; Tue,
 22 Sep 2026 16:19:36 -0400
X-MC-Unique: NinC_KgGPBqcDTom4EyGgQ-1
X-Mimecast-MFC-AGG-ID: NinC_KgGPBqcDTom4EyGgQ_1790108375
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A45318005A1; Tue, 22 Sep 2026 20:19:35 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 164521800446; Tue, 22 Sep 2026 20:19:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:14 +0400
Subject: [PATCH 07/88] qemu-print: use monitor_puts() for any non-QMP monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-7-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UGcbFthFg1o910LN1ITwHs7jzoQGUbuOX/XNgbfh37A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuQymoL8P3d/muMi7Pg8a1TBHjE80Q4Mffk
 u+VeTcSK76JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5aoHD/9Uh4USghAPf5JqmiLtWKUzQ18nLGKdSpkrGZCo0igumLped3yS8MeUwvhzbP8hsN8+8hP
 ETuOlrAYKP8YTQPnx+EeeTgaPt3G4VgOgqY+VttAh/M/pS3d+VujvuPwO1ClPAkKHx1XogrwJAC
 gb9nyZz3SqI9efdgs6s1GhxmUD1+0DzTEQA01cngTADrLlz2ivAbgKUoyitE3One6AXt5Fd4OXZ
 YkqXIqr7ES4dVR3ghqe9pN4Da69GWSE3dFINkpSOJdlMiM8cJWPeIMH2HYf7oCWY4BNsyFK2270
 9OhDA5EQqiHkbENuz3/QNBgIpT3D9IV5IC80ZEEEaXkbWiodMWJJEuDSd4mTb06DD3lVv2IKO2I
 0dBrxnrkA0vJ1aRjMeiPDQReB8bTXzekLcxnrA4QcYNCLcpk1CSbv1/iTuD3oO5Z+DrqItksGOz
 7cQzPvwvIfihkxKOyeiVlseKE6V6pjr1sem1hUsAP3RSwOSDVBAdG+YIub3Bk5JeG01EOEyjBUl
 KEreJ3AF17IoWRe1f/yjK/OAE4jQRkpRqCVKdTX+aiJfAyqE8wLJ0UTAGrY1I4ZEmrnVwCcB+dx
 7LCUyR5sTY3hMXYQvMS9WgrO+2Vo+li79YRxp33ZgXV0cwRUFx3ItLTaAYCvXLW0m2PECiI5Ww/
 h+QT8h5WVDyeZOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of requiring a MonitorHMP and going through
monitor_hmp_vprintf(), use monitor_puts() on the base Monitor class.
This allows qemu_printf() to work with any monitor type that
isn't QMP, which will be needed to capture output via a bare
Monitor used as a buffer.

Add monitor_puts() since qemu_printf() is in libqemuutil.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 stubs/meson.build    |  1 +
 stubs/monitor-puts.c |  9 +++++++++
 util/qemu-print.c    | 16 +++++-----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b2549..52c733e32a91 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -9,6 +9,7 @@ stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('monitor-cur.c'))
 stub_ss.add(files('monitor-hmp.c'))
+stub_ss.add(files('monitor-puts.c'))
 stub_ss.add(files('qapi-event-emit.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
diff --git a/stubs/monitor-puts.c b/stubs/monitor-puts.c
new file mode 100644
index 000000000000..c4cf4f632845
--- /dev/null
+++ b/stubs/monitor-puts.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+
+int monitor_puts(Monitor *mon, const char *str)
+{
+    abort();
+}
diff --git a/util/qemu-print.c b/util/qemu-print.c
index ab09dd8600ec..323789f265f9 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -19,25 +19,19 @@
 /*
  * Print like vprintf().
  * Print to current monitor if we have one, else to stdout.
- * (if the monitor is QMP, fail without printing anything)
+ * QMP monitors are rejected (return -1) since they don't accept
+ * free-form text output.
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
     Monitor *cur_mon = monitor_cur();
 
-    /* for all monitors: QMP & HMP */
     if (cur_mon) {
-#ifdef CONFIG_HMP
-        /* don't use monitor_cur_hmp(), to avoid a second lookup */
-        MonitorHMP *hmp = (MonitorHMP *)
-            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
-        if (!hmp) {
+        if (object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_QMP)) {
             return -1;
         }
-        return monitor_hmp_vprintf(hmp, fmt, ap);
-#else
-        return -1;
-#endif
+        g_autofree char *buf = g_strdup_vprintf(fmt, ap);
+        return monitor_puts(cur_mon, buf);
     }
     return vprintf(fmt, ap);
 }

-- 
2.56.0.rc0.29.g47ce80527c56


