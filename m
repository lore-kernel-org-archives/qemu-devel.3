Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917BCCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE7y-00074M-EC; Mon, 15 Jun 2026 16:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7x-0006yX-21
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE7u-0003Cm-WB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaRY/jUcRVQS+0kqMk+f2r96IhSS7NkiLw7F+Npkow8=;
 b=LV1rmmlc0XGcw6rGFmFDE/JontCITtyZbaUWiWJIVKMM7qT9+iNzAxHUMUFBm4vyavAdxI
 Hberkga7FdbzgkWg9H9N3641TvVdIt52Z9j/XqzFZE9S/Q3fLMiF/LHbIWgeCkOQ16t/qA
 bDGbUp02mL1aVdsM92Tmi49sv3R74Rw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-Gf6lYNugOTmjRCVxVu8eEg-1; Mon,
 15 Jun 2026 16:41:42 -0400
X-MC-Unique: Gf6lYNugOTmjRCVxVu8eEg-1
X-Mimecast-MFC-AGG-ID: Gf6lYNugOTmjRCVxVu8eEg_1781556101
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07AA3195608D; Mon, 15 Jun 2026 20:41:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1DFC1800361; Mon, 15 Jun 2026 20:41:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:11 +0400
Subject: [PATCH v2 45/53] hw: convert device-local PropertyInfo definitions
 to use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-45-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8639;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=13OjH4Jv1Cy4m5GEP+CXU8X9alHiaj7k8yL+23y+6y0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQSpiL/NYc+IuO6Mfjat8xDrzC9PRPW8DkK
 thPvcGV71mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5YjJEACWpYsyVCB+0faKDfPIYSDMhDlAihzdat8UB31bUsFvQ6O+fU2K6NpjhALaTSb5ObRZbJ2
 5qQ34edX6lZZT5P8Ay3D1XrTTrFIWlP+4bxx8SbgS1tVG9QiD2bZ7BZamAaj+oAzQt+eDaPn9kn
 InbFOQqVe9Iwgq3Ya34OPiyv9VzVLhYL8EwfwKXWU9tUrpa3pUvAW4MWCFA4Gt8lYRi3i8qh1Vg
 7DKchp0C1PyrDQ4GONRRX9/7hN8mGTowXnMW6s19H9ENG1PNYs3j2k9MQwsi2aehTawBoldh+0n
 lahlWYCrHy1oftkbVJES27dpNLPyQOAW40zodrQkRk2ztPxxP7Ea85mAhthg5FRBV4C7CN642E0
 jFePDM8voCaxSpy1U75DMP5VyHDFI4SbLHq2+U8+QDU5Kkv6giPpmp54UPrcaI8Ij/Od8iK7p6Y
 4BQoH5FgsN0UmpkCzKHUCNzOmN4qAEVfq5L/LWtosLaJPRj0aQMIEEKwTld8rMxV1flXvlznmdI
 Y6QvgMwwCoTPKIkPF6QYKihfmP7Hl0eMXWKfvSXeXvUP9HeP+ioNcCiK8COJa7WqaaFHiqXQQ/I
 Jv2VQjiUPhNutyJEI7bb15xvbWRvcP6ieu7uOV9v4BiA31A/7kwNP409VtHDAlXzbNYicdv0CwE
 6McWOejaB8uaytQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mechanical conversion of PropertyInfo definitions in device-specific
files, replacing .type string with .qapi_type pointer to the
corresponding QAPITypeInfo.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/block/xen-block.c       | 3 ++-
 hw/misc/xlnx-versal-trng.c | 3 ++-
 hw/nvme/nguid.c            | 3 ++-
 hw/nvram/xlnx-bbram.c      | 3 ++-
 hw/nvram/xlnx-efuse.c      | 3 ++-
 hw/pci/pci.c               | 3 ++-
 hw/s390x/ccw-device.c      | 3 ++-
 hw/s390x/css.c             | 5 +++--
 hw/s390x/s390-pci-bus.c    | 3 ++-
 hw/vfio/pci-quirks.c       | 3 ++-
 hw/display/apple-gfx.m     | 3 ++-
 11 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 474c12fe4ac..d9721c565c5 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -29,6 +29,7 @@
 #include "dataplane/xen-block.h"
 #include "hw/xen/interface/io/xs_wire.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define XVDA_MAJOR 202
 #define XVDQ_MAJOR (1 << 20)
@@ -663,7 +664,7 @@ invalid:
  * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
  */
 static const PropertyInfo xen_block_prop_vdev = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Virtual Disk specifier (d*p*/xvd*/hd*/sd*)",
     .get = xen_block_get_vdev,
     .set = xen_block_set_vdev,
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index aa1d65de7b7..4c358104c50 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -36,6 +36,7 @@
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #ifndef XLNX_VERSAL_TRNG_ERR_DEBUG
 #define XLNX_VERSAL_TRNG_ERR_DEBUG 0
@@ -651,7 +652,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
 }
 
 static const PropertyInfo trng_prop_fault_events = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
     .realized_set_allowed = true,
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 4cd6fad6ac9..6eaf90fca88 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -18,6 +18,7 @@
 #include "qapi/visitor.h"
 #include "qemu/ctype.h"
 #include "nvme.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define NGUID_SEPARATOR '-'
 
@@ -179,7 +180,7 @@ static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_nguid = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description =
         "NGUID or \"" NGUID_VALUE_AUTO "\" for random value",
     .get   = get_nguid,
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index edfb592a5ec..8198790b98f 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -34,6 +34,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/nvram/xlnx-efuse.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #ifndef XLNX_BBRAM_ERR_DEBUG
 #define XLNX_BBRAM_ERR_DEBUG 0
@@ -486,7 +487,7 @@ static void bbram_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo bbram_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as BBRAM backend",
     .realized_set_allowed = true,
     .get = bbram_prop_get_drive,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 1a9650ba128..50a7f2baba1 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -34,6 +34,7 @@
 #include "system/blockdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #define TBIT0_OFFSET     28
 #define TBIT1_OFFSET     29
@@ -251,7 +252,7 @@ static void efuse_prop_release_drive(Object *obj, const char *name,
 }
 
 static const PropertyInfo efuse_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as eFUSE backend",
     .realized_set_allowed = true,
     .get = efuse_prop_get_drive,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3bb7ab0cb86..812ebe0452b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -52,6 +52,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
@@ -79,7 +80,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .get = prop_pci_busnr_get,
 };
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 25c42732795..fd21a434652 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -17,6 +17,7 @@
 #include "qapi/visitor.h"
 #include "qemu/ctype.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 static void ccw_device_refill_ids(CcwDevice *dev)
 {
@@ -74,7 +75,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 }
 
 const PropertyInfo ccw_loadparm = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Up to 8 chars in set of [A-Za-z0-9. ] to select"
             " a guest kernel",
     .get = ccw_device_get_loadparm,
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ecd28fed5c3..541a53db2c1 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -23,6 +23,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 #include "exec/cpu-common.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -2494,7 +2495,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2502,7 +2503,7 @@ const PropertyInfo css_devid_propinfo = {
 };
 
 const PropertyInfo css_devid_ro_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eb2b6185db0..e9f087ae4c8 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -32,6 +32,7 @@
 #include "system/runstate.h"
 
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 S390pciState *s390_get_phb(void)
 {
@@ -1540,7 +1541,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751fd..288bcab9f21 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -26,6 +26,7 @@
 #include "pci.h"
 #include "pci-quirks.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 /*
  * List of device ids/vendor ids for which to disable
@@ -1436,7 +1437,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_nv_gpudirect_clique = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "NVIDIA GPUDirect Clique ID (0 - 15)",
     .get = get_nv_gpudirect_clique_id,
     .set = set_nv_gpudirect_clique_id,
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index be0061b9db2..77c420b3000 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -15,6 +15,7 @@
 #include "qemu/lockable.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "qemu/aio-wait.h"
@@ -871,7 +872,7 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_apple_gfx_display_mode = {
-    .type  = "display_mode",
+    .qapi_type = &str_type_info,
     .description =
         "Display mode in pixels and Hertz, as <width>x<height>@<refresh-rate> "
         "Example: 3840x2160@60",

-- 
2.54.0


