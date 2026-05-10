Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84C3CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4aL-00069P-Mk; Sun, 10 May 2026 09:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Zk-0005uy-BE
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Zg-0006Ge-Bj
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcrGBjuVCyta7ZW2/ggJXvCFgnKnKfGh6WTHVhdMlqA=;
 b=Ke4B0sLA77J4ddy3mgewweKOnuQpnSmnEV0SQg5PbQmJsRSduSU9tILv8gzclR2i3n1ZQx
 LDtNTBLLFy92SXWv7sDDg0KFrFcYs0/wVfWxJnmFz8eKZsNx6DVeXfYb4sGTwAAIWujIcv
 Thou/WaxoyZy7gKcWzQ5SgXRC6JgCtk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286--uwV3Ji6N9mOSl_ha5LHJg-1; Sun,
 10 May 2026 09:52:02 -0400
X-MC-Unique: -uwV3Ji6N9mOSl_ha5LHJg-1
X-Mimecast-MFC-AGG-ID: -uwV3Ji6N9mOSl_ha5LHJg_1778421121
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 669B9195608C
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:52:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D80818004A3; Sun, 10 May 2026 13:51:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:41 +0400
Subject: [PATCH 44/54] qdev: convert system PropertyInfo definitions to use
 qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-44-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=16328;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IeX0KlHWmS/C0FJArtdK37K3QFR+XSLDoZnx8zCppns=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwALxMytdoihhBlU/5+AugT+aHviaj9xsiW
 bKZbVQ8JqeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5cZhD/49YXcokCEPHzv09z1YStYTcWE/MQv0Xn3kE60gpk1tNXVQZ4nZrqxRMPKoqKPKBmVuZS5
 Lr68XWBPiORqFmTJmHiNaazwacUBCjQ7YKrc2joSzXH3WWMXoHmUBwizzQvqdLuuwBpyFIXLZPo
 d4rpSxjKQiE/+FAQsHJ807H8cqRDZJT+O9Wfif11VhIVffbScyNCi16oVSDkbWsfxdw9VHHEC9P
 U0UsnC4BBYl/Lm+Le6WK9O/dkKL+Qz0MqMp8uP5hcWIfbdVjDrRkV3fi80sMwjaL5IVToM1PerE
 kUcixu1xk7qpcWVfEuRTz8/oXqDK8CeYzl0O9T906NtW3/wEEGUCWU2qGV1nUDkr92VGy1H3uqU
 8bKA6Dte0hvPt9+DLqe3HHvbpTqid2TItbgxx7i4GJWz/WrdE9DphCZnJ/oIuWx5TywMKCLReoj
 iS9MXRJ/CmCrRYr0ATXv62+QKL2rZZqkkVAt2U34KLZ0timQWIwiEcOVU14oQVRdDYkQIWhDbkm
 Wh0V3P8GMs019HJqzQJhuBmqVIwDU/JaiT8teSPbJvgu7caYa/IgRrAGAJLzyxigqYtj//4XTjo
 tatkA7YLcXKZyiqWw8RwaiS5twwPAQhcwxGSiny2XhpFqUd1EYFVr9tAAPTl2LY+plic3nbktv0
 AwEIHkhLdOrQFZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace .type string and .enum_table pointer with .qapi_type in all
PropertyInfo definitions in qdev-properties-system.c

Update file-private enum accessor functions to use .qapi_type->lookup
instead of .enum_table.

Note, this should be a faithful conversion, but it would be worth to
consider better types than just "str" for references (block node names,
chardev/netdev IDs, MAC addrs, etc)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-prop-internal.h     |  2 +
 hw/core/qdev-properties-system.c | 92 +++++++++++++++++-----------------------
 hw/core/qdev-properties.c        |  2 +-
 3 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index d7b77844fe0..c190b7b88cf 100644
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
index 5bfdfe1ab9d..12be7b80a59 100644
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
@@ -904,7 +896,7 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
@@ -1010,7 +1002,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Address (bus:device.function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
@@ -1020,9 +1012,8 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
 /* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
 
 const PropertyInfo qdev_prop_off_auto_pcibar = {
-    .type = "OffAutoPCIBAR",
+    .qapi_type = &OffAutoPCIBAR_type_info,
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
-    .enum_table = &OffAutoPCIBAR_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1061,7 +1052,8 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &speed, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &speed,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -1071,8 +1063,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
-    if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &speed,
+        qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1102,9 +1094,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
-    .type = "PCIELinkSpeed",
+    .qapi_type = &PCIELinkSpeed_type_info,
     .description = "2_5/5/8/16/32/64",
-    .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1146,7 +1137,8 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &width, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &width,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
@@ -1156,8 +1148,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
-    if (!visit_type_enum(v, name, &width, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &width,
+                         qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1190,9 +1182,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_width = {
-    .type = "PCIELinkWidth",
+    .qapi_type = &PCIELinkWidth_type_info,
     .description = "1/2/4/8/12/16/32",
-    .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
     .set = set_prop_pcielinkwidth,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1240,7 +1231,7 @@ static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_uuid = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
         "\" for random value (default)",
     .get   = get_uuid,
@@ -1253,9 +1244,8 @@ const PropertyInfo qdev_prop_uuid = {
 QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
-    .type  = "S390CpuEntitlement",
+    .qapi_type = &S390CpuEntitlement_type_info,
     .description = "auto/low/medium/high (default medium)",
-    .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1298,7 +1288,7 @@ static void release_iothread_vq_mapping_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
-    .type = "IOThreadVirtQueueMappingList",
+    .qapi_type = &IOThreadVirtQueueMappingList_type_info,
     .description = "IOThread virtqueue mapping list [{\"iothread\":\"<id>\", "
                    "\"vqs\":[1,2,3,...]},...]",
     .get = get_iothread_vq_mapping_list,
@@ -1309,18 +1299,16 @@ const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
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
@@ -1363,7 +1351,7 @@ static void release_virtio_gpu_output_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_virtio_gpu_output_list = {
-    .type = "VirtIOGPUOutputList",
+    .qapi_type = &VirtIOGPUOutputList_type_info,
     .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
     .get = get_virtio_gpu_output_list,
     .set = set_virtio_gpu_output_list,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7e562518184..5edcca42056 100644
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
2.54.0


