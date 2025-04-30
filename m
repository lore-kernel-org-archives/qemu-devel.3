Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A3C3ABAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1p3-0001ds-GG; Wed, 30 Apr 2025 03:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1uA1oz-0001cj-Nb
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:33 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1uA1ow-0004EJ-8n
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:32 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 7DEC41C1133; Wed, 30 Apr 2025 09:25:25 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v5 7/7] h264: stop gstreamer pipeline before destroying,
 cleanup on exit
Date: Wed, 30 Apr 2025 09:25:24 +0200
Message-Id: <20250430072524.3650582-8-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250430072524.3650582-1-dietmar@proxmox.com>
References: <20250430072524.3650582-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Some encoders can hang indefinitely (i.e. nvh264enc) if
the pipeline is not stopped before it is destroyed
(Observed on Debian bookworm).

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 include/system/system.h |  1 +
 include/ui/console.h    |  1 +
 system/runstate.c       |  2 ++
 system/vl.c             |  7 +++++++
 ui/vnc-enc-h264.c       | 18 ++++++++++++++++++
 ui/vnc.c                | 15 +++++++++++++++
 6 files changed, 44 insertions(+)

diff --git a/include/system/system.h b/include/system/system.h
index a7effe7dfd..9226e60050 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -109,6 +109,7 @@ bool defaults_enabled(void);
 void qemu_init(int argc, char **argv);
 int qemu_main_loop(void);
 void qemu_cleanup(int);
+void qemu_cleanup_displays(void);
 
 extern QemuOptsList qemu_legacy_drive_opts;
 extern QemuOptsList qemu_common_drive_opts;
diff --git a/include/ui/console.h b/include/ui/console.h
index 46b3128185..ff46e9fe98 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -458,6 +458,7 @@ int vnc_display_password(const char *id, const char *password);
 int vnc_display_pw_expire(const char *id, time_t expires);
 void vnc_parse(const char *str);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
+void vnc_cleanup(void);
 bool vnc_display_reload_certs(const char *id,  Error **errp);
 bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
 
diff --git a/system/runstate.c b/system/runstate.c
index 272801d307..0cb3ba5ec1 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -924,6 +924,8 @@ void qemu_cleanup(int status)
     job_cancel_sync_all();
     bdrv_close_all();
 
+    qemu_cleanup_displays();
+
     /* vhost-user must be cleaned up before chardevs.  */
     tpm_cleanup();
     net_cleanup();
diff --git a/system/vl.c b/system/vl.c
index c17945c493..a781ebd77b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2679,6 +2679,13 @@ static void qemu_maybe_daemonize(const char *pid_file)
     }
 }
 
+void qemu_cleanup_displays(void)
+{
+#ifdef CONFIG_VNC
+   vnc_cleanup();
+#endif
+}
+
 static void qemu_init_displays(void)
 {
     DisplayState *ds;
diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 98055c095f..6618f156b4 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -95,6 +95,24 @@ static GstElement *create_encoder(const char *encoder_name)
 
 static void destroy_encoder_context(VncState *vs)
 {
+    GstStateChangeReturn state_change_ret;
+
+    VNC_DEBUG("Destroy h264 context.\n");
+
+    /*
+     * Some encoders can hang indefinitely (i.e. nvh264enc) if
+     * the pipeline is not stopped before it is destroyed
+     * (Observed on Debian bookworm).
+     */
+    if (vs->h264->pipeline != NULL) {
+        state_change_ret = gst_element_set_state(
+            vs->h264->pipeline, GST_STATE_NULL);
+
+        if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
+            VNC_DEBUG("Unable to stop the GST pipeline\n");
+        }
+    }
+
     gst_clear_object(&vs->h264->source);
     gst_clear_object(&vs->h264->convert);
     gst_clear_object(&vs->h264->gst_encoder);
diff --git a/ui/vnc.c b/ui/vnc.c
index c707b9da37..578d9eea32 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4368,6 +4368,21 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+void vnc_cleanup(void)
+{
+    VncDisplay *vd;
+    VncState *vs;
+
+    QTAILQ_FOREACH(vd, &vnc_displays, next) {
+        QTAILQ_FOREACH(vs, &vd->clients, next) {
+#ifdef CONFIG_GSTREAMER
+            /* correctly close all h264 encoder pipelines */
+            vnc_h264_clear(vs);
+#endif
+        }
+    }
+}
+
 static void vnc_register_config(void)
 {
     qemu_add_opts(&qemu_vnc_opts);
-- 
2.39.5


