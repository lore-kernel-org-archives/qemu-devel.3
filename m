Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F17DE9E2FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9Mg-0007LF-2d; Wed, 11 Feb 2026 07:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9MW-0007HX-Pt
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9MT-0000Bn-BJ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770813028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGBq4qMkI/q12TmIhq+tbmp2Snz+Rz/20mUay39k8ag=;
 b=M6Pb349mD6ho4ZtmGCyG8MrygDp31jyJTGNzFeiHsGjkkL8RhUL9G9Py7Jb7HI8oQ2AkMV
 mLtefFJPdoJ1OGIJ91Ez/RO6HGTW/Ylrf9yJ1cfEcFFcVQhnRF/L/V9WI5hCiig5CqG7gP
 14kFpbNo4mkSBjqvGPnWBIFRFcG4w6U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-KX-bclq4MP2GmkzEZbJ6MA-1; Wed,
 11 Feb 2026 07:30:25 -0500
X-MC-Unique: KX-bclq4MP2GmkzEZbJ6MA-1
X-Mimecast-MFC-AGG-ID: KX-bclq4MP2GmkzEZbJ6MA_1770813024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3A5D180025C; Wed, 11 Feb 2026 12:30:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D1A3180066F; Wed, 11 Feb 2026 12:30:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Eric Blake <eblake@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 02/14] ui/spice: Require spice-server >= 0.15.0
Date: Wed, 11 Feb 2026 16:29:49 +0400
Message-ID: <20260211123007.3569932-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
References: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

For major distributions we have now:

    Debian 13: 0.15.2
    Ubuntu 22.04: 0.15.0
    RHEL-9/CentOS Stream 9: SPICE is removed
    Fedora 42: 0.15.1
    OpenSUSE Leap 15.4: 0.15.0

Time to update the dependancy in QEMU and drop almost all
SPICE_SERVER_VERSION checks.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260115144606.233252-2-vsementsov@yandex-team.ru>
---
 meson.build             |  2 +-
 include/ui/qemu-spice.h |  4 ----
 chardev/spice.c         |  6 ------
 hw/display/qxl.c        | 11 ++---------
 ui/spice-display.c      |  8 ++------
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e90184..9c12e0db601 100644
--- a/meson.build
+++ b/meson.build
@@ -1320,7 +1320,7 @@ if get_option('spice') \
              .require(pixman.found(),
                       error_message: 'cannot enable SPICE if pixman is not available') \
              .allowed()
-  spice = dependency('spice-server', version: '>=0.14.0',
+  spice = dependency('spice-server', version: '>=0.15.0',
                      required: get_option('spice'),
                      method: 'pkg-config')
 endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index b7d493742c4..8e5e6b2a744 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -34,11 +34,7 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
 
-#if SPICE_SERVER_VERSION >= 0x000f00 /* release 0.15.0 */
 #define SPICE_HAS_ATTACHED_WORKER 1
-#else
-#define SPICE_HAS_ATTACHED_WORKER 0
-#endif
 
 #else  /* CONFIG_SPICE */
 
diff --git a/chardev/spice.c b/chardev/spice.c
index db53b49da26..39b79d60fb4 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -278,12 +278,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     }
 
     *be_opened = false;
-#if SPICE_SERVER_VERSION < 0x000e02
-    /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
-    if (strcmp(type, "smartcard") == 0) {
-        *be_opened = true;
-    }
-#endif
     chr_open(chr, type);
 }
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f29b736722c..fbba02113f7 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -261,11 +261,6 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
                     QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
                     0));
     } else {
-#if SPICE_SERVER_VERSION < 0x000e02 /* release 0.14.2 */
-        if (qxl->max_outputs) {
-            spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
-        }
-#endif
         qxl->guest_monitors_config = qxl->ram->monitors_config;
         spice_qxl_monitors_config_async(&qxl->ssd.qxl,
                 qxl->ram->monitors_config,
@@ -2109,6 +2104,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     uint8_t* config = qxl->pci.config;
     uint32_t pci_device_rev;
     uint32_t io_size;
+    Error *err = NULL;
+    char device_address[256] = "";
 
     qemu_spice_display_init_common(&qxl->ssd);
     qxl->mode = QXL_MODE_UNDEFINED;
@@ -2208,9 +2205,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
         return;
     }
 
-#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
-    Error *err = NULL;
-    char device_address[256] = "";
     if (qemu_console_fill_device_address(qxl->vga.con,
                                          device_address, sizeof(device_address),
                                          &err)) {
@@ -2221,7 +2215,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     } else {
         error_report_err(err);
     }
-#endif
 
     qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index db71e866f89..f2304bb0ce2 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -689,13 +689,11 @@ static int interface_client_monitors_config(QXLInstance *sin,
     if (mc->num_of_monitors > head) {
         info.width  = mc->monitors[head].width;
         info.height = mc->monitors[head].height;
-#if SPICE_SERVER_VERSION >= 0x000e04 /* release 0.14.4 */
         if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SIZE) {
             VDAgentMonitorMM *mm = (void *)&mc->monitors[mc->num_of_monitors];
             info.width_mm = mm[head].width;
             info.height_mm = mm[head].height;
         }
-#endif
     }
 
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
@@ -1393,6 +1391,8 @@ static const DisplayGLCtxOps gl_ctx_ops = {
 static void qemu_spice_display_init_one(QemuConsole *con)
 {
     SimpleSpiceDisplay *ssd = g_new0(SimpleSpiceDisplay, 1);
+    Error *err = NULL;
+    char device_address[256] = "";
 
     qemu_spice_display_init_common(ssd);
 
@@ -1414,9 +1414,6 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     ssd->qxl.base.sif = &dpy_interface.base;
     qemu_spice_add_display_interface(&ssd->qxl, con);
 
-#if SPICE_SERVER_VERSION >= 0x000e02 /* release 0.14.2 */
-    Error *err = NULL;
-    char device_address[256] = "";
     if (qemu_console_fill_device_address(con, device_address, 256, &err)) {
         spice_qxl_set_device_info(&ssd->qxl,
                                   device_address,
@@ -1425,7 +1422,6 @@ static void qemu_spice_display_init_one(QemuConsole *con)
     } else {
         error_report_err(err);
     }
-#endif
 
     qemu_spice_create_host_memslot(ssd);
 
-- 
2.52.0


