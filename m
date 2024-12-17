Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5BEE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYZs-0001PB-El; Tue, 17 Dec 2024 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZM-0000vi-0T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNYZJ-0004w4-Ld
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734445740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk+5YCsyi76ZWWkuqCL0C8b0IiSrAQYKN9gEOhNTkLU=;
 b=B6nloJjkuW9+ffaVTKD9IHdiKWDi4WDJQ9qjnDtpgZvHxryrqzT3uAseO20kYsmyFvGhGU
 minCzVrME5w2Elvxeb0aqPSe0x5VSFYvTcsDq2CjT4WqiIUD7BzZ76QAI1fYVLeGiEbpTl
 TFGLzFAWyQN/RS2IJZ9k3S9tC1LwAtc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-OGtRjC-qObC_cTACaBSm4A-1; Tue,
 17 Dec 2024 09:28:58 -0500
X-MC-Unique: OGtRjC-qObC_cTACaBSm4A-1
X-Mimecast-MFC-AGG-ID: OGtRjC-qObC_cTACaBSm4A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D329219560A3; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B9081956053; Tue, 17 Dec 2024 14:28:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1383421E660A; Tue, 17 Dec 2024 15:28:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH 4/6] qdev: Change values of PropertyInfo member @type to be
 QAPI types
Date: Tue, 17 Dec 2024 15:28:52 +0100
Message-ID: <20241217142855.3805068-5-armbru@redhat.com>
In-Reply-To: <20241217142855.3805068-1-armbru@redhat.com>
References: <20241217142855.3805068-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PropertyInfo member @type is externally visible via QMP
device-list-properties and qom-list-properies.

Its meaning is not documented at its definition.

It gets passed to as @type argument to object_property_add() and
object_class_property_add().  This argument's documentation isn't of
much help, either:

 * @type: the type name of the property.  This namespace is pretty loosely
 *   defined.  Sub namespaces are constructed by using a prefix and then
 *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
 *   'link' namespace would be 'link<virtio-net-pci>'.

The two QMP commands document it as

 # @type: the type of the property.  This will typically come in one of
 #     four forms:
 #
 #     1) A primitive type such as 'u8', 'u16', 'bool', 'str', or
 #        'double'.  These types are mapped to the appropriate JSON
 #        type.
 #
 #     2) A child type in the form 'child<subtype>' where subtype is a
 #        qdev device type name.  Child properties create the
 #        composition tree.
 #
 #     3) A link type in the form 'link<subtype>' where subtype is a
 #        qdev device type name.  Link properties form the device model
 #        graph.

"Typically come in one of four forms" followed by three items inspires
the level of trust that is appropriate here.

Clean up a bunch of funnies:

* qdev_prop_fdc_drive_type.type is "FdcDriveType".  Its .enum_table
  refers to QAPI type "FloppyDriveType".  So use that.

* qdev_prop_reserved_region is "reserved_region".  Its only user is an
  array property called "reserved-regions".  Its .set() visits str.
  So change @type to "str".

* trng_prop_fault_event_set.type is "uint32:bits".  Its .set() visits
  uint32, so change @type to "uint32".  If we believe mentioning it's
  actually bits is useful, the proper place would be .description.

* ccw_loadparm.type is "ccw_loadparm".  It's users are properties
  called "loadparm".  Its .set() visits str.  So change @type to
  "str".

* qdev_prop_nv_gpudirect_clique.type is "uint4".  Its set() visits
  uint8, so change @type to "uint8".  If we believe mentioning the
  range is useful, the proper place would be .description.

* s390_pci_fid_propinfo.type is "zpci_fid".  Its .set() visits uint32.
  So change type to that, and move the "zpci_fid" to .description.
  This is admittedly a lousy description, but it's still an
  improvement; for instance, output of -device zpci,help changes from

      fid=<zpci_fid>

  to

      fid=<uint32>           - zpci_fid

* Similarly for a raft of PropertyInfo in target/riscv/cpu.c.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c |  4 +--
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/s390x/ccw-device.c            |  2 +-
 hw/s390x/s390-pci-bus.c          |  3 ++-
 hw/vfio/pci-quirks.c             |  2 +-
 target/riscv/cpu.c               | 44 ++++++++++++++++++++++----------
 6 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b66e6f5c96..bd6ea9673d 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -667,7 +667,7 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
 /* --- FDC default drive types */
 
 const PropertyInfo qdev_prop_fdc_drive_type = {
-    .type = "FdcDriveType",
+    .type = "FloppyDriveType",
     .description = "FDC drive type, "
                    "144/288/120/none/auto",
     .enum_table = &FloppyDriveType_lookup,
@@ -801,7 +801,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
-    .type  = "reserved_region",
+    .type  = "str",
     .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
     .get   = get_reserved_region,
     .set   = set_reserved_region,
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index f989afd325..f3c09fedbd 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -652,7 +652,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
 }
 
 static const PropertyInfo trng_prop_fault_events = {
-    .type = "uint32:bits",
+    .type = "uint32",
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
     .realized_set_allowed = true,
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 5e789e6637..ecf735e9fe 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -74,7 +74,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
 }
 
 const PropertyInfo ccw_loadparm = {
-    .type  = "ccw_loadparm",
+    .type  = "str",
     .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
             " to the guest loader/kernel",
     .get = ccw_device_get_loadparm,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0bf01140b3..28534436bb 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1473,7 +1473,8 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo s390_pci_fid_propinfo = {
-    .type = "zpci_fid",
+    .type = "uint32",
+    .description = "zpci_fid",
     .get = s390_pci_get_fid,
     .set = s390_pci_set_fid,
 };
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 675184648a..0d2e59828b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1525,7 +1525,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_nv_gpudirect_clique = {
-    .type = "uint4",
+    .type = "uint8",
     .description = "NVIDIA GPUDirect Clique ID (0 - 15)",
     .get = get_nv_gpudirect_clique_id,
     .set = set_nv_gpudirect_clique_id,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b325fe9ca8..5a1f5b3f3d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1680,7 +1680,8 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "pmu-num",
+    .type = "int8",
+    .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
 };
@@ -1721,7 +1722,8 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "pmu-mask",
+    .type = "int8",
+    .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
 };
@@ -1752,7 +1754,8 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mmu = {
-    .type = "mmu",
+    .type = "bool",
+    .description = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
 };
@@ -1783,7 +1786,8 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp = {
-    .type = "pmp",
+    .type = "bool",
+    .description = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
 };
@@ -1857,7 +1861,9 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .type = "priv_spec",
+    .type = "str",
+    .description = "priv_spec",
+    /* FIXME enum? */
     .get = prop_priv_spec_get,
     .set = prop_priv_spec_set,
 };
@@ -1888,7 +1894,9 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vext_spec = {
-    .type = "vext_spec",
+    .type = "str",
+    .description = "vext_spec",
+    /* FIXME enum? */
     .get = prop_vext_spec_get,
     .set = prop_vext_spec_set,
 };
@@ -1928,7 +1936,8 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vlen = {
-    .type = "vlen",
+    .type = "uint16",
+    .description = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
 };
@@ -1968,7 +1977,8 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_elen = {
-    .type = "elen",
+    .type = "uint16",
+    .description = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
 };
@@ -2003,7 +2013,8 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbom_blksize = {
-    .type = "cbom_blocksize",
+    .type = "uint16",
+    .description = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
 };
@@ -2038,7 +2049,8 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbop_blksize = {
-    .type = "cbop_blocksize",
+    .type = "uint16",
+    .description = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
 };
@@ -2073,7 +2085,8 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cboz_blksize = {
-    .type = "cboz_blocksize",
+    .type = "uint16",
+    .description = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
 };
@@ -2108,7 +2121,8 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mvendorid = {
-    .type = "mvendorid",
+    .type = "uint32",
+    .description = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
 };
@@ -2143,7 +2157,8 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mimpid = {
-    .type = "mimpid",
+    .type = "uint64",
+    .description = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
 };
@@ -2199,7 +2214,8 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_marchid = {
-    .type = "marchid",
+    .type = "uint64",
+    .description = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,
 };
-- 
2.47.0


