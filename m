Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D252CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoE6-0002cI-0r; Mon, 19 Oct 2026 10:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDU-0002G5-8u
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDO-0005dh-Ml
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GO1+ifYyt2NYFxz8UkkVzZvAh7OT9Bx98fSk0/WM0PQ=;
 b=TkupwQpd/GLD3oAXBpdfEgsvrm4hqYdDvXudUkjElf77ZW5NPHj2juqaM5xEV8VpydHIPe
 PP6KPms8H2CKMIcix7oRAy666LLeNWP1xft/7wn9DHuIE+T5Q4WPYHqPD0BWgyI1IlLiKA
 82bZRRy9CiqaVBe3zJhX50bAMe8rHH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-6gUzyLX3POSHGNUoPp8adg-1; Mon,
 19 Oct 2026 14:19:46 +0000
X-MC-Unique: 6gUzyLX3POSHGNUoPp8adg-1
X-Mimecast-MFC-AGG-ID: 6gUzyLX3POSHGNUoPp8adg_1792419583
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2B6218005BB; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B30930001A2; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80F1821E66A5; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 56/65] hw: convert device-local PropertyInfo definitions to
 use qapi_type
Date: Mon, 19 Oct 2026 16:19:20 +0200
Message-ID: <20261019141929.1594337-57-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Mechanical conversion of PropertyInfo definitions in device-specific
files, replacing .type string with .qapi_type pointer to the
corresponding QAPITypeInfo. Except "display_mode" for apple-gfx, which
is a string of a specific format.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index 474c12fe4a..d9721c565c 100644
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
index 0584ee089e..97bd3c3f84 100644
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
index 4cd6fad6ac..6eaf90fca8 100644
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
index e336874bde..eb032ab8b9 100644
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
index 03c9fbc0d0..b1c9ee4980 100644
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
index 6edc702776..1b22c8d112 100644
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
index 25c4273279..fd21a43465 100644
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
index 65341c68c3..50d14ab855 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 #include "exec/cpu-common.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -2530,7 +2531,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2538,7 +2539,7 @@ const PropertyInfo css_devid_propinfo = {
 };
 
 const PropertyInfo css_devid_ro_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Read-only identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..96603bfdb8 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -35,6 +35,7 @@
 #include "system/runstate.h"
 
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 S390pciState *s390_get_phb(void)
 {
@@ -1843,7 +1844,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c5b4f9091d..4a3fd374a2 100644
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
index be0061b9db..77c420b300 100644
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
2.55.0


