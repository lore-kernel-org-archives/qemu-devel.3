Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4EDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJye-0006hc-27; Tue, 18 Aug 2026 09:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJyb-0006YZ-RE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJyZ-0000av-R1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787060135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcMcfYcJnP5pSepZPUlbKT/IGaqv3YNUpR9si4mBH+Q=;
 b=UsgJ3vcDg/jEc6Kj6D4UGh+sCDOXeYpgxSAkwBmWKQ41ToaP8lJgQ9Xhd1vo46Jk+sCc0t
 hZ7kLwxdH2NlhQgVerTB6lQ1hXJXUnHGw7aQqTjYOHh1YsHtva/Z2S7y2ricPgCZDHlXan
 ZolPkL8MhmOaKx2IocDUemZgQvh/yYQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-0LsnsvebM_iuqnqKt0D47w-1; Tue,
 18 Aug 2026 09:35:21 -0400
X-MC-Unique: 0LsnsvebM_iuqnqKt0D47w-1
X-Mimecast-MFC-AGG-ID: 0LsnsvebM_iuqnqKt0D47w_1787060115
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A1FC18011C5; Tue, 18 Aug 2026 13:35:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3927180034F; Tue, 18 Aug 2026 13:35:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:29:29 +0400
Subject: [PATCH v3 63/74] hw: convert device-local PropertyInfo definitions
 to use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-63-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8761;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M1ZK58SCDRwPvhT0ecKJ8jMYH52yLNqHGDUugt8emrA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhF9z4CkZw2HKM6dzp+UwaFJyFhTU2u5rvrSYf
 BXDoaKYjlqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRfcwAKCRDa6OEJdZac
 5TOdD/0Q9eYTxC1cXJssQBTteyZwUW7EKCWsS/xXRovKEx+Kktno7QRX7UT2fLJQQIvHlkwM+LH
 lTxEFpG1pm45KOEQgHwxUP2e7clXlV5ri74lCFTIsYgXuM0wWqJ9FUXZNpM03icIJeVql1Bev9w
 VcgWpRv8aeBjn0jRvYSyA1qY+nRfUd8KT9SR/9elfGTCFA2LWnu1iFDi2pm42I6+PGmdUrDIn9L
 eBxdg5XNFKSYJ6iuNNFyc+wn4CAgXD6t4SF1c7YbZPUMEahGoXHtNN7Dyh55F1kmPAPJXlU60Ly
 QNs7ECUtW+o7mOC+7c07FYFgZGwAtXzgZRP1qrYFaBq3rkNvWTDHz4YIE6HN8n3WzLm0HjJJaLJ
 /xG/hOfgKpwiEYKhsyZnaWRAugrzFMy3HuAjXNzenokQYpPZbEbbEkcX7ThHth5w/+BBs/53IF1
 oMoicdK6lxhlpRpcARnNOH2vgZhUcgQj914/RpTsKKBceYwvG3/w5JRf3nBRlDrsXahjo9BenyA
 Q+theYaAaOmLZ9BBDU9bKh6U5pOZOaWGiQiDEIO+hc0dQXibHwJmO/NvuUDtDO2VwR8GWGaym9B
 2tiD5+1HFd7vv5FAdTQR3sdBm0q2neoHk9GwmWJARYpW9nEOxJUx180AQ9xYvW0vr+PRvMknpHD
 0URkHEcRSEyYjmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
index be6145a90a9f..7cfe6032b915 100644
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
index 3a67b6705319..152687da7820 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -24,6 +24,7 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 #include "exec/cpu-common.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -2519,7 +2520,7 @@ out:
 }
 
 const PropertyInfo css_devid_propinfo = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Identifier of an I/O device in the channel "
                    "subsystem, example: fe.1.23ab",
     .get = get_css_devid,
@@ -2527,7 +2528,7 @@ const PropertyInfo css_devid_propinfo = {
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


