Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F1CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoFy-0005YP-1M; Mon, 19 Oct 2026 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDW-0002Ib-J2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDQ-0005er-9C
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzdBuwc183+OztrN8g9Q45eHcJGqrUB1CpqSxvWa3nc=;
 b=Ih6bRuzVQ0Xqb0BKzqs9gGiTW4bpoK1xAUGZDH0J7lSjQ70f7Jfs/abkaErdEGkwbYl4kE
 azL42oEGgf1vNBirJyaIZULWrRln/idS4BGnH8jocWACScj8k1dHMRUMztOgpjq5l7rTaa
 9TlDryM2mOXfy1SQXWfnvCh0gqHv5uY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-w5wRSY7qOR6Jx8oLqrxwJg-1; Mon,
 19 Oct 2026 14:19:46 +0000
X-MC-Unique: w5wRSY7qOR6Jx8oLqrxwJg-1
X-Mimecast-MFC-AGG-ID: w5wRSY7qOR6Jx8oLqrxwJg_1792419583
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADD261800613; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35FB718005BA; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BE8D21E669C; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 55/65] qdev: convert system PropertyInfo definitions to use
 qapi_type
Date: Mon, 19 Oct 2026 16:19:19 +0200
Message-ID: <20261019141929.1594337-56-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace .type string and .enum_table pointer with .qapi_type in all
PropertyInfo definitions in qdev-properties-system.c

Update file-private enum accessor functions to use .qapi_type->lookup
instead of .enum_table.

Note, this should be a faithful conversion, but it would be worth to
consider better types than just "str" for references (block node names,
chardev/netdev IDs, MAC addrs, etc)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-prop-internal.h     |  2 +
 hw/core/qdev-properties-system.c | 93 ++++++++++++++------------------
 hw/core/qdev-properties.c        |  2 +-
 3 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index d7b77844fe..c190b7b88c 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -8,6 +8,8 @@
 #ifndef HW_CORE_QDEV_PROP_INTERNAL_H
 #define HW_CORE_QDEV_PROP_INTERNAL_H
 
+const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info);
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp);
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3381de1144..8819a9a0b7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -27,6 +27,7 @@
 #include "qemu/uuid.h"
 #include "qemu/error-report.h"
 #include "qdev-prop-internal.h"
+#include "qapi/qapi-type-infos.h"
 
 #include "qemu/audio.h"
 #include "chardev/char-fe.h"
@@ -238,7 +239,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -247,7 +248,7 @@ const PropertyInfo qdev_prop_drive = {
 };
 
 const PropertyInfo qdev_prop_drive_iothread = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -315,7 +316,7 @@ static void release_chr(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_chr = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a chardev to use as a backend",
     .get   = get_chr,
     .set   = set_chr,
@@ -389,7 +390,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_macaddr = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
     .get   = get_mac,
     .set   = set_mac,
@@ -477,7 +478,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_netdev = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a netdev to use as a backend",
     .get   = get_netdev,
     .set   = set_netdev,
@@ -514,7 +515,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
 }
 
 const PropertyInfo qdev_prop_audiodev = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of an audiodev to use as a backend",
     /* release done on shutdown */
     .get = get_audiodev,
@@ -584,7 +585,8 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
     int *ptr = object_field_prop_ptr(obj, prop);
     int value;
 
-    if (!visit_type_enum(v, name, &value, prop->info->enum_table, errp)) {
+    if (!visit_type_enum(v, name, &value,
+                         qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -604,9 +606,8 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
 QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 
 const PropertyInfo qdev_prop_losttickpolicy = {
-    .type  = "LostTickPolicy",
+    .qapi_type = &LostTickPolicy_type_info,
     .description = "Policy for handling lost ticks (discard/delay/slew)",
-    .enum_table  = &LostTickPolicy_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_losttickpolicy,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -631,7 +632,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
     .get   = qdev_propinfo_get_size32,
@@ -644,9 +645,8 @@ const PropertyInfo qdev_prop_blocksize = {
 QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
 
 const PropertyInfo qdev_prop_blockdev_on_error = {
-    .type = "BlockdevOnError",
+    .qapi_type = &BlockdevOnError_type_info,
     .description = "Error handling policy (report/ignore/enospc/stop/auto)",
-    .enum_table = &BlockdevOnError_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -657,10 +657,9 @@ const PropertyInfo qdev_prop_blockdev_on_error = {
 QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
 
 const PropertyInfo qdev_prop_bios_chs_trans = {
-    .type = "BiosAtaTranslation",
+    .qapi_type = &BiosAtaTranslation_type_info,
     .description = "Logical CHS translation algorithm "
                    " (auto/none/lba/large/rechs)",
-    .enum_table = &BiosAtaTranslation_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -669,9 +668,8 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
 /* --- FDC default drive types */
 
 const PropertyInfo qdev_prop_fdc_drive_type = {
-    .type = "FloppyDriveType",
+    .qapi_type = &FloppyDriveType_type_info,
     .description = "Floppy drive type (144/288/120/none/auto)",
-    .enum_table = &FloppyDriveType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -680,10 +678,9 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 /* --- MultiFDCompression --- */
 
 const PropertyInfo qdev_prop_multifd_compression = {
-    .type = "MultiFDCompression",
+    .qapi_type = &MultiFDCompression_type_info,
     .description = "multifd compression method"
                    " (none/zlib/zstd/qpl/uadk/qatzip)",
-    .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -694,9 +691,8 @@ const PropertyInfo qdev_prop_multifd_compression = {
 QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_mig_mode = {
-    .type = "MigMode",
+    .qapi_type = &MigMode_type_info,
     .description = "Migration mode (normal/cpr-reboot)",
-    .enum_table = &MigMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -707,18 +703,16 @@ const PropertyInfo qdev_prop_mig_mode = {
 QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_granule_mode = {
-    .type = "GranuleMode",
+    .qapi_type = &GranuleMode_type_info,
     .description = "Granule page size (4k/8k/16k/64k/host)",
-    .enum_table = &GranuleMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 const PropertyInfo qdev_prop_zero_page_detection = {
-    .type = "ZeroPageDetection",
+    .qapi_type = &ZeroPageDetection_type_info,
     .description = "Zero page detection (none/legacy/multifd)",
-    .enum_table = &ZeroPageDetection_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -729,9 +723,8 @@ const PropertyInfo qdev_prop_zero_page_detection = {
 QEMU_BUILD_BUG_ON(sizeof(SsidSizeMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_ssidsize_mode = {
-    .type = "SsidSizeMode",
+    .qapi_type = &SsidSizeMode_type_info,
     .description = "ssidsize mode: auto, 0-20",
-    .enum_table = &SsidSizeMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -742,9 +735,8 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
 QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_oas_mode = {
-    .type = "OasMode",
+    .qapi_type = &OasMode_type_info,
     .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
-    .enum_table = &OasMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -824,7 +816,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
     .get   = get_reserved_region,
     .set   = set_reserved_region,
@@ -904,8 +896,7 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    /* The formatted string accepted by the setter is a CLI convenience. */
-    .type  = "int32",
+    .qapi_type = &int32_type_info,
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
@@ -1011,7 +1002,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Address (bus:device.function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
@@ -1021,9 +1012,8 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
 /* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
 
 const PropertyInfo qdev_prop_off_auto_pcibar = {
-    .type = "OffAutoPCIBAR",
+    .qapi_type = &OffAutoPCIBAR_type_info,
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
-    .enum_table = &OffAutoPCIBAR_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1062,7 +1052,8 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &speed, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &speed,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -1072,8 +1063,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
-    if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &speed,
+        qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1103,9 +1094,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
-    .type = "PCIELinkSpeed",
+    .qapi_type = &PCIELinkSpeed_type_info,
     .description = "2_5/5/8/16/32/64",
-    .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1147,7 +1137,8 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &width, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &width,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
@@ -1157,8 +1148,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
-    if (!visit_type_enum(v, name, &width, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &width,
+                         qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1191,9 +1182,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_width = {
-    .type = "PCIELinkWidth",
+    .qapi_type = &PCIELinkWidth_type_info,
     .description = "1/2/4/8/12/16/32",
-    .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
     .set = set_prop_pcielinkwidth,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1241,7 +1231,7 @@ static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_uuid = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
         "\" for random value (default)",
     .get   = get_uuid,
@@ -1254,9 +1244,8 @@ const PropertyInfo qdev_prop_uuid = {
 QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
-    .type  = "S390CpuEntitlement",
+    .qapi_type = &S390CpuEntitlement_type_info,
     .description = "auto/low/medium/high (default medium)",
-    .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1299,7 +1288,7 @@ static void release_iothread_vq_mapping_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
-    .type = "IOThreadVirtQueueMappingList",
+    .qapi_type = &IOThreadVirtQueueMappingList_type_info,
     .description = "IOThread virtqueue mapping list [{\"iothread\":\"<id>\", "
                    "\"vqs\":[1,2,3,...]},...]",
     .get = get_iothread_vq_mapping_list,
@@ -1310,18 +1299,16 @@ const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
 /* --- Endian modes */
 
 const PropertyInfo qdev_prop_endian_mode = {
-    .type = "EndianMode",
+    .qapi_type = &EndianMode_type_info,
     .description = "Endian mode, big/little/unspecified",
-    .enum_table = &EndianMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
-    .type  = "VMAppleVirtioBlkVariant",
+    .qapi_type = &VMAppleVirtioBlkVariant_type_info,
     .description = "unspecified/root/aux",
-    .enum_table  = &VMAppleVirtioBlkVariant_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1364,7 +1351,7 @@ static void release_virtio_gpu_output_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_virtio_gpu_output_list = {
-    .type = "VirtIOGPUOutputList",
+    .qapi_type = &VirtIOGPUOutputList_type_info,
     .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
     .get = get_virtio_gpu_output_list,
     .set = set_virtio_gpu_output_list,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index abdb380cb9..a9abc646d5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -101,7 +101,7 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
-static const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
+const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
 {
     if (info->qapi_type) {
         assert(info->qapi_type->lookup);
-- 
2.55.0


