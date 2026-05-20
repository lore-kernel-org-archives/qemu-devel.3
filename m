Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458DBCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorR-0008Ow-Hn; Wed, 20 May 2026 17:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPor5-0007rS-HL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPor4-000525-1I
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEpLNtezLZ5gi9gc6tBA5aF7JHFme/l1NsetAdVdzOU=;
 b=A8U+aT3VFeRiOiyb5fL4+X4XnBPDsgJCbWpt6aERvctom+aI0XVpHz2n1mo1mdh2v3aTBs
 FXmjQvufuOIvrM/DLqWgIBKBDqXxXvkCvvlakNdlkjShJ9f2sbY6x5jPEj/pd2i4g0TxMJ
 LLQAgVd5wZsSrAUwopcd3cqP0kKR9AM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-f7jyiDZCMQ-Fd4_C0TlmBA-1; Wed,
 20 May 2026 17:53:27 -0400
X-MC-Unique: f7jyiDZCMQ-Fd4_C0TlmBA-1
X-Mimecast-MFC-AGG-ID: f7jyiDZCMQ-Fd4_C0TlmBA_1779314007
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E264E19560B4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A81E30001A2; Wed, 20 May 2026 21:53:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:35 +0400
Subject: [PATCH 34/40] util: guard monitor_vprintf callers with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-34-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HwWHsZFMKZdWXTYjOmgerggdHu8TDi5XpVZ7v+nyDlk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEYRx+qsbU28Pdc7J8yrvkAvvS06c5QAvFG
 LNVeWI/VMOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5Ve9EACUp+iPKWWmZmSVvxM0G00/aqmjBrek3BkDZeEevQSVZxWu5149MJiwoIqrpB8FwK236R8
 VgTvmpmCI4SKzqATEWX6Iv4kQOv8GmyfdolaS0AO2zUb7Jko7aZ7H5r+ItIbdJPNNHWt7wK6tb2
 ATqr4gP1UDa59HkshGCcg1dahOiODd3dtSt/1T+oHj7T/onN7KscZ4yeX2WwdNSiimzSfUI9jqC
 c3bDeoO9qn5u0Cy9WuLHugOeTF1X/tmMkaBKY+a2Llv4yJPCpi/yrhqCMZ8QIl6Cjddw0tegrtE
 DPXeOzRYtR4CE49ZoIdZ3kyWFOo2AP/Dev2dWESoZ6Pj+ahJMBZ1/mKkMySM41I/non1NBHq27s
 Ww3mEhHhTFzdYRfGXceGOBF/QRN7Qs47PcHGApF4Judt9IheYGMmL6Qdvw6F90Uw04Wm0Cea6ZV
 KnrS148uGfIKV4zF5E5aPmecFUsa8yUuKBf8rNZtOgRA4nX6SXSlEsFuSpCEVtytRzRDdHfeA4z
 EPSul6eWlsI6m2mJyf9K6vN+/gTiB/0I2BsAVuH/3wFEAGMxSkak3XPtG0zgY2sU4GneSo1InQ0
 SYgPy5M5uh8iCWkYQ6mgnbPo3Rag9gXqSAKy9F56Eu6ZuMgIlfGPj/8yZCkW4fK0hML/WdtpRiS
 mjxnZsofCab/G+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Guard calls to monitor_vprintf in error-report and qemu-print so
they compile without HMP. When CONFIG_HMP is not set,
error_vprintf_mon falls back directly to stderr and qemu_vfprintf
returns -1 for NULL streams.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/test-util-sockets.c | 4 +++-
 tools/qemu-vnc/stubs.c         | 2 ++
 util/error-report.c            | 8 +++++---
 util/qemu-print.c              | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index b9f2453e299..23ebe1e26b5 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -73,8 +73,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
  */
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
-int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
 bool monitor_cur_is_qmp(void) { abort(); };
+#ifdef CONFIG_HMP
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
+#endif
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
index a865ce85f04..f476dd6d956 100644
--- a/tools/qemu-vnc/stubs.c
+++ b/tools/qemu-vnc/stubs.c
@@ -46,10 +46,12 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return NULL;
 }
 
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     return -1;
 }
+#endif
 
 /*
  * Link-time stubs for VMState symbols referenced by VNC code.
diff --git a/util/error-report.c b/util/error-report.c
index f832ad9b6b6..e2e46281455 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -40,11 +40,13 @@ error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
      * IOW this will only print if in HMP, otherwise we
      * fallback to stderr for QMP / no-monitor scenarios.
      */
+#ifdef CONFIG_HMP
     int ret = monitor_vprintf(cur_mon, fmt, ap);
-    if (ret == -1) {
-        ret = vfprintf(stderr, fmt, ap);
+    if (ret != -1) {
+        return ret;
     }
-    return ret;
+#endif
+    return vfprintf(stderr, fmt, ap);
 }
 
 /*
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 7b9591035e5..ee80000722b 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -20,10 +20,12 @@
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     Monitor *cur_mon = monitor_cur();
     if (cur_mon) {
         return monitor_vprintf(cur_mon, fmt, ap);
     }
+#endif
     return vprintf(fmt, ap);
 }
 
@@ -52,7 +54,11 @@ int qemu_printf(const char *fmt, ...)
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
     if (!stream) {
+#ifdef CONFIG_HMP
         return monitor_vprintf(monitor_cur(), fmt, ap);
+#else
+        return -1;
+#endif
     }
     return vfprintf(stream, fmt, ap);
 }

-- 
2.54.0


