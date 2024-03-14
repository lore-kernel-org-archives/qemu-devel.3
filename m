Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D126C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvi-0007PE-1A; Thu, 14 Mar 2024 11:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvV-0007KP-BP
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvS-0003lv-Oh
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GtVai0wfhlJK9oqZsNhUAn7YwBsNEZysKpT0qchJskI=;
 b=Qo1i2pt97nyarupeO1bQIVvz5HsmKSVJUJBvQ0dsfTw6kBjicW1+7+SlJPzK38V/FAzoyk
 2/BMyzTC3kpC0CDh6ikzCBI2S9PPAKYmv9yu/LTaW3tOWGuI8e71QPRbjw9H0aN/1t3WKP
 jn3d/2a3WPP1/T6065wSTrpw3M1FdGc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-Vifs8u5cM3u8pfK4greGnQ-1; Thu,
 14 Mar 2024 11:23:20 -0400
X-MC-Unique: Vifs8u5cM3u8pfK4greGnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D3683C025AC
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 15:23:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A725D10F53;
 Thu, 14 Mar 2024 15:23:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 10/21] smbios: rename/expose structures/bitmaps used by
 both legacy and modern code
Date: Thu, 14 Mar 2024 16:22:51 +0100
Message-Id: <20240314152302.2324164-11-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As a preparation to move legacy handling into a separate file,
add prefix 'smbios_' to type0/type1/have_binfile_bitmap/have_fields_bitmap
and expose them in smbios.h so that they can be reused in
legacy and modern code.

Doing it as a separate patch to avoid rename cluttering follow-up
patch which will move legacy code into a separate file.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 include/hw/firmware/smbios.h |  16 +++++
 hw/smbios/smbios.c           | 113 ++++++++++++++++-------------------
 2 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 0f0dca8f83..05707c6341 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -2,6 +2,7 @@
 #define QEMU_SMBIOS_H
 
 #include "qapi/qapi-types-machine.h"
+#include "qemu/bitmap.h"
 
 /*
  * SMBIOS Support
@@ -16,8 +17,23 @@
  *
  */
 
+typedef struct {
+    const char *vendor, *version, *date;
+    bool have_major_minor, uefi;
+    uint8_t major, minor;
+} smbios_type0_t;
+extern smbios_type0_t smbios_type0;
+
+typedef struct {
+    const char *manufacturer, *product, *version, *serial, *sku, *family;
+    /* uuid is in qemu_uuid */
+} smbios_type1_t;
+extern smbios_type1_t smbios_type1;
 
 #define SMBIOS_MAX_TYPE 127
+extern DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
+extern DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
+
 #define offsetofend(TYPE, MEMBER) \
        (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
 
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d530667a9d..e93b8f9cb1 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -78,19 +78,11 @@ static int smbios_type4_count = 0;
 static bool smbios_have_defaults;
 static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
-static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
-static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
+DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
+DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
 
-static struct {
-    const char *vendor, *version, *date;
-    bool have_major_minor, uefi;
-    uint8_t major, minor;
-} type0;
-
-static struct {
-    const char *manufacturer, *product, *version, *serial, *sku, *family;
-    /* uuid is in qemu_uuid */
-} type1;
+smbios_type0_t smbios_type0;
+smbios_type1_t smbios_type1;
 
 static struct {
     const char *manufacturer, *product, *version, *serial, *asset, *location;
@@ -599,36 +591,36 @@ static void smbios_maybe_add_str(int type, int offset, const char *data)
 static void smbios_build_type_0_fields(void)
 {
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0, vendor_str),
-                         type0.vendor);
+                         smbios_type0.vendor);
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0, bios_version_str),
-                         type0.version);
+                         smbios_type0.version);
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
                                      bios_release_date_str),
-                         type0.date);
-    if (type0.have_major_minor) {
+                         smbios_type0.date);
+    if (smbios_type0.have_major_minor) {
         smbios_add_field(0, offsetof(struct smbios_type_0,
                                      system_bios_major_release),
-                         &type0.major, 1);
+                         &smbios_type0.major, 1);
         smbios_add_field(0, offsetof(struct smbios_type_0,
                                      system_bios_minor_release),
-                         &type0.minor, 1);
+                         &smbios_type0.minor, 1);
     }
 }
 
 static void smbios_build_type_1_fields(void)
 {
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, manufacturer_str),
-                         type1.manufacturer);
+                         smbios_type1.manufacturer);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, product_name_str),
-                         type1.product);
+                         smbios_type1.product);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, version_str),
-                         type1.version);
+                         smbios_type1.version);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, serial_number_str),
-                         type1.serial);
+                         smbios_type1.serial);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, sku_number_str),
-                         type1.sku);
+                         smbios_type1.sku);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, family_str),
-                         type1.family);
+                         smbios_type1.family);
     if (qemu_uuid_set) {
         /* We don't encode the UUID in the "wire format" here because this
          * function is for legacy mode and needs to keep the guest ABI, and
@@ -646,14 +638,14 @@ uint8_t *smbios_get_table_legacy(size_t *length)
     size_t usr_offset;
 
     /* also complain if fields were given for types > 1 */
-    if (find_next_bit(have_fields_bitmap,
+    if (find_next_bit(smbios_have_fields_bitmap,
                       SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
         error_report("can't process fields for smbios "
                      "types > 1 on machine versions < 2.1!");
         exit(1);
     }
 
-    if (test_bit(4, have_binfile_bitmap)) {
+    if (test_bit(4, smbios_have_binfile_bitmap)) {
         error_report("can't process table for smbios "
                      "type 4 on machine versions < 2.1!");
         exit(1);
@@ -694,10 +686,10 @@ uint8_t *smbios_get_table_legacy(size_t *length)
 
 bool smbios_skip_table(uint8_t type, bool required_table)
 {
-    if (test_bit(type, have_binfile_bitmap)) {
+    if (test_bit(type, smbios_have_binfile_bitmap)) {
         return true; /* user provided their own binary blob(s) */
     }
-    if (test_bit(type, have_fields_bitmap)) {
+    if (test_bit(type, smbios_have_fields_bitmap)) {
         return false; /* user provided fields via command line */
     }
     if (smbios_have_defaults && required_table) {
@@ -725,25 +717,25 @@ static void smbios_build_type_0_table(void)
 {
     SMBIOS_BUILD_TABLE_PRE(0, T0_BASE, false); /* optional, leave up to BIOS */
 
-    SMBIOS_TABLE_SET_STR(0, vendor_str, type0.vendor);
-    SMBIOS_TABLE_SET_STR(0, bios_version_str, type0.version);
+    SMBIOS_TABLE_SET_STR(0, vendor_str, smbios_type0.vendor);
+    SMBIOS_TABLE_SET_STR(0, bios_version_str, smbios_type0.version);
 
     t->bios_starting_address_segment = cpu_to_le16(0xE800); /* from SeaBIOS */
 
-    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, type0.date);
+    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, smbios_type0.date);
 
     t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
 
     t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
     t->bios_characteristics_extension_bytes[0] = 0;
     t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
-    if (type0.uefi) {
+    if (smbios_type0.uefi) {
         t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
     }
 
-    if (type0.have_major_minor) {
-        t->system_bios_major_release = type0.major;
-        t->system_bios_minor_release = type0.minor;
+    if (smbios_type0.have_major_minor) {
+        t->system_bios_major_release = smbios_type0.major;
+        t->system_bios_minor_release = smbios_type0.minor;
     } else {
         t->system_bios_major_release = 0;
         t->system_bios_minor_release = 0;
@@ -773,18 +765,18 @@ static void smbios_build_type_1_table(void)
 {
     SMBIOS_BUILD_TABLE_PRE(1, T1_BASE, true); /* required */
 
-    SMBIOS_TABLE_SET_STR(1, manufacturer_str, type1.manufacturer);
-    SMBIOS_TABLE_SET_STR(1, product_name_str, type1.product);
-    SMBIOS_TABLE_SET_STR(1, version_str, type1.version);
-    SMBIOS_TABLE_SET_STR(1, serial_number_str, type1.serial);
+    SMBIOS_TABLE_SET_STR(1, manufacturer_str, smbios_type1.manufacturer);
+    SMBIOS_TABLE_SET_STR(1, product_name_str, smbios_type1.product);
+    SMBIOS_TABLE_SET_STR(1, version_str, smbios_type1.version);
+    SMBIOS_TABLE_SET_STR(1, serial_number_str, smbios_type1.serial);
     if (qemu_uuid_set) {
         smbios_encode_uuid(&t->uuid, &qemu_uuid);
     } else {
         memset(&t->uuid, 0, 16);
     }
     t->wake_up_type = 0x06; /* power switch */
-    SMBIOS_TABLE_SET_STR(1, sku_number_str, type1.sku);
-    SMBIOS_TABLE_SET_STR(1, family_str, type1.family);
+    SMBIOS_TABLE_SET_STR(1, sku_number_str, smbios_type1.sku);
+    SMBIOS_TABLE_SET_STR(1, family_str, smbios_type1.family);
 
     SMBIOS_BUILD_TABLE_POST;
 }
@@ -1178,9 +1170,9 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
     smbios_uuid_encoded = uuid_encoded;
     smbios_ep_type = ep_type;
 
-    SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
-    SMBIOS_SET_DEFAULT(type1.product, product);
-    SMBIOS_SET_DEFAULT(type1.version, version);
+    SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
+    SMBIOS_SET_DEFAULT(smbios_type1.product, product);
+    SMBIOS_SET_DEFAULT(smbios_type1.version, version);
     SMBIOS_SET_DEFAULT(type2.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(type2.product, product);
     SMBIOS_SET_DEFAULT(type2.version, version);
@@ -1453,13 +1445,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         }
 
         if (header->type <= SMBIOS_MAX_TYPE) {
-            if (test_bit(header->type, have_fields_bitmap)) {
+            if (test_bit(header->type, smbios_have_fields_bitmap)) {
                 error_setg(errp,
                            "can't load type %d struct, fields already specified!",
                            header->type);
                 return;
             }
-            set_bit(header->type, have_binfile_bitmap);
+            set_bit(header->type, smbios_have_binfile_bitmap);
         }
 
         if (header->type == 4) {
@@ -1490,41 +1482,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             return;
         }
 
-        if (test_bit(type, have_binfile_bitmap)) {
+        if (test_bit(type, smbios_have_binfile_bitmap)) {
             error_setg(errp, "can't add fields, binary file already loaded!");
             return;
         }
-        set_bit(type, have_fields_bitmap);
+        set_bit(type, smbios_have_fields_bitmap);
 
         switch (type) {
         case 0:
             if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, errp)) {
                 return;
             }
-            save_opt(&type0.vendor, opts, "vendor");
-            save_opt(&type0.version, opts, "version");
-            save_opt(&type0.date, opts, "date");
-            type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+            save_opt(&smbios_type0.vendor, opts, "vendor");
+            save_opt(&smbios_type0.version, opts, "version");
+            save_opt(&smbios_type0.date, opts, "date");
+            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
 
             val = qemu_opt_get(opts, "release");
             if (val) {
-                if (sscanf(val, "%hhu.%hhu", &type0.major, &type0.minor) != 2) {
+                if (sscanf(val, "%hhu.%hhu", &smbios_type0.major,
+                           &smbios_type0.minor) != 2) {
                     error_setg(errp, "Invalid release");
                     return;
                 }
-                type0.have_major_minor = true;
+                smbios_type0.have_major_minor = true;
             }
             return;
         case 1:
             if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, errp)) {
                 return;
             }
-            save_opt(&type1.manufacturer, opts, "manufacturer");
-            save_opt(&type1.product, opts, "product");
-            save_opt(&type1.version, opts, "version");
-            save_opt(&type1.serial, opts, "serial");
-            save_opt(&type1.sku, opts, "sku");
-            save_opt(&type1.family, opts, "family");
+            save_opt(&smbios_type1.manufacturer, opts, "manufacturer");
+            save_opt(&smbios_type1.product, opts, "product");
+            save_opt(&smbios_type1.version, opts, "version");
+            save_opt(&smbios_type1.serial, opts, "serial");
+            save_opt(&smbios_type1.sku, opts, "sku");
+            save_opt(&smbios_type1.family, opts, "family");
 
             val = qemu_opt_get(opts, "uuid");
             if (val) {
-- 
2.39.3


