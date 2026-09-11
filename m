Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF04C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54JF-000748-4H; Fri, 11 Sep 2026 12:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54J2-0006fy-5F
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Iz-0007BF-4K
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDadYbb+MvTukZ4DS18E0pLdpqsEG2v4jBcqkrYw0bM=;
 b=U8sgjLLgLHBPOvsOAyAozl7fe7ww2nxBlCfvGNwszauANppzG1vpDM9YepatedT8aoIIQL
 WVtIYLBRFkBZDvSSIkK0mQ66O4U1SnbsmpQGMBczCEXB4A5WktovSYFukVYsXlaoXqCEuo
 XIz71EwuF5rFhv2cgNp7eI8vfJjbQgM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-DbPVIgPSPbOP9ibl1dS4OQ-1; Fri,
 11 Sep 2026 12:40:44 -0400
X-MC-Unique: DbPVIgPSPbOP9ibl1dS4OQ-1
X-Mimecast-MFC-AGG-ID: DbPVIgPSPbOP9ibl1dS4OQ_1789144841
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06CD218005A0; Fri, 11 Sep 2026 16:40:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DECE195608F; Fri, 11 Sep 2026 16:40:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:26 +0400
Subject: [PATCH v5 52/62] hw: convert device-local PropertyInfo definitions
 to use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-52-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8761;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JMD8CHS/Ms/ZN3B00kadMDC30ZNsy393OriqSCvH/Y0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27/FrwpaBUFhbPDQM/o0pmo0Fc272pN3kVq
 if9mhmJslKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5RQQD/0VJ4R8+y480kJaLTZ3cqEvpfw1lNnm/uI8n1uA2ZLFzVvlOsEpqHPLE2mR/9Oo/sJhKUg
 s8P4TDAafsiUyYQpMlrEdjoieMqshEAXlKQkq+RO3/373up8zM8+D39GLdnPqEDFPme25Gr5y2x
 8c8PRoLO7vI+lrEiwpI2IyrHWT7Zb21mqnKpLQTBZrhY8Qmj+ZX/JtJpOAdDXxk1OugIQVSeBZq
 rWHF7eYcufQtH4rtS7mHG2RuJJDd0Kjl+B7E6WmhKeGtdcpHwNTZc+Wvh37MyvdAg2XfYFJLWPP
 B/N5ofB2dMndTh9s3f3FuHZtQ/i/8i523aDWkDPKsT910Xc5QThMses3GAalYPjif0xtlmfkmaI
 KUl3FdjHiMA0PchYgdr6e0rZLfZdWs2anxhut6VAH5MNruVPPxvDYTg/eqnB1G5pYbCQuYzvZS2
 3dFLRN2YMBiz/hM17+P2uE6VCE+2U76ksfyOOTzxgxcK3xoTnTcCh831KYU2qNptNG7goifUmzX
 wbKc3GDwzszxYqtef4uRogD37D6cxnipthwixlylbyB+Co8qw8663WPDj1r0bozbQoqxotruS1I
 yN2/5u/1jktef5brLkbmqVqfE2cxAmrGNOYZ6R32U3ZRIusQ/YOO1qNV9iu8FQ6kfXEIOOlV3kS
 fX2ixHNs8L+WsjA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
corresponding QAPITypeInfo. Except "display_mode" for apple-gfx, which
is a string of a specific format.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/block/xen-block.c       | 3 ++-
 hw/display/apple-gfx.m     | 3 ++-
 hw/misc/xlnx-versal-trng.c | 3 ++-
 hw/nvme/nguid.c            | 3 ++-
 hw/nvram/xlnx-bbram.c      | 3 ++-
 hw/nvram/xlnx-efuse.c      | 3 ++-
 hw/pci/pci.c               | 3 ++-
 hw/s390x/ccw-device.c      | 3 ++-
 hw/s390x/css.c             | 5 +++--
 hw/s390x/s390-pci-bus.c    | 3 ++-
 hw/vfio/pci-quirks.c       | 3 ++-
 11 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 474c12fe4ac8..d9721c565c5f 100644
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
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index be0061b9db25..77c420b30006 100644
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
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 0584ee089e3c..97bd3c3f8475 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -36,6 +36,7 @@
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #ifndef XLNX_VERSAL_TRNG_ERR_DEBUG
 #define XLNX_VERSAL_TRNG_ERR_DEBUG 0
@@ -662,7 +663,7 @@ static void trng_prop_fault_event_get(Object *obj, Visitor *v,
 }
 
 static const PropertyInfo trng_prop_fault_events = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
     .get = trng_prop_fault_event_get,
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 4cd6fad6ac9b..6eaf90fca88e 100644
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
index e336874bdef4..eb032ab8b9c8 100644
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
index 03c9fbc0d076..b1c9ee4980a0 100644
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
index af6e1d440c37..89a36221bc43 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 #include "hw/xen/xen.h"
 #include "hw/i386/kvm/xen_evtchn.h"
@@ -80,7 +81,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .get = prop_pci_busnr_get,
 };
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 25c427327957..fd21a4346522 100644
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
index 76dbca3bb961..60cba93e7eec 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 #include "exec/cpu-common.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -2518,7 +2519,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2526,7 +2527,7 @@ const PropertyInfo css_devid_propinfo = {
 };
 
 const PropertyInfo css_devid_ro_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe92..f77632810b76 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -33,6 +33,7 @@
 #include "system/runstate.h"
 
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 S390pciState *s390_get_phb(void)
 {
@@ -1541,7 +1542,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c5b4f9091d49..4a3fd374a211 100644
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

-- 
2.55.0.543.g5ebe2ebe4ea8


