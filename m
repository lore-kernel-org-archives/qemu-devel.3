Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21C7CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWm-000773-IF; Thu, 25 Jun 2026 17:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWk-00071n-Fj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWi-00041V-Qi
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEpLNtezLZ5gi9gc6tBA5aF7JHFme/l1NsetAdVdzOU=;
 b=OkcmTMTosLaNholxmeiBjGfvRimp/0funMbbD7YbENNom0P5O80Ob+/tBEb8exBUztNxp7
 bPoz5dzpLfw//hoQryxJWJBLxebJTNengl2lkbC6knej7/EXqUqH+ADSPj9Qe7sA3GIl26
 FLA60ZDyaa4b8HL9FVLGxXxXsHJvUyE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-j7KBVDziOHyqtkD-dyaJIw-1; Thu,
 25 Jun 2026 17:22:21 -0400
X-MC-Unique: j7KBVDziOHyqtkD-dyaJIw-1
X-Mimecast-MFC-AGG-ID: j7KBVDziOHyqtkD-dyaJIw_1782422540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13451185FC5C; Thu, 25 Jun 2026 21:22:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2D6C30001BE; Thu, 25 Jun 2026 21:22:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:32 +0400
Subject: [PATCH v2 31/39] util: guard monitor_vprintf callers with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-31-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HwWHsZFMKZdWXTYjOmgerggdHu8TDi5XpVZ7v+nyDlk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZteeCm0gKmQ12qklaBF9GyVLpZSjexlVIxFt
 5XZ9V3TjB2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5dUcD/42ygnbSspFamHFW6w0RVngWqKxe1uHVu+McRl+5omXH1RHMnGpHNyb7djnrkrJtu3OzJL
 LQoELuS6W7j9OGx5wce/EMh9llOlq6AOby3JU5P0PtCSYEmVkmceW1Rh/V6uTMR/8uVnryTPye6
 AuCu+61A0zZZOchGA0Q14p6g8MryIzwt6UgGW8oJoaljRZwZPL5hiovOJlOhx88YfUrjuheco2m
 aohzwhHPIPyutF65cS7uPfOfMLCUIOhNomYOnVev4JZDKZs0Lna9BeYblb0PBMboHXEgtQCIpSy
 wmWEcWasH9M2xnJU54LX5gv9++4LUmg7+bDfNl6Qi+rw8tQK7XfS0oz32LHPcjxYMf/GrZTG3Fh
 kG7XbPGTB/2FPFHXHuPEbMxFC9TlPjWgiWX3I9aF5ef9CWAEcwmVLI15HSzeBmvPRYlHMQzLCQU
 1Tb5ibq23BCvdk6wmeO2U/iIllb8caWKmIFixo3VV0QBXL1XgCIzjWYRvONTBX8ungBiTpwDrVT
 LTd8z7Jf+gybgp+nrGnf8EVdkG7lpyxZo//NCdsbxBgBjHX3ZjXS9WEk0qEWqKRf38rYP7vu6ck
 og8c0Yz4zussZW3d7AJoXs0c7kaidZvYIOedtKb2txw+uxVJio0sKiWxQWd2BC5jib9ygE/eLry
 dHxpfk8f/69eV5w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


