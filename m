Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A006C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-00089U-NQ; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS8-00081N-1P
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAS4-0006kK-Pe
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lydss1k89V/8lbFWiww6LDgDn6tT0DEK3ZSxi0vt8K0=;
 b=aUrSBOD0wsOxcWQ3SWyj0SNPxWnk1ey+9QOxpIg1tltV3OCZYzP4fh2bdwgrTyEkLNjZLK
 zjnZkN/uYCNQXCxr7bTLR73K6XUj0Po4Oqoav1bGU0yromhSTCSs3oCIfrf/m7y7Qjybc3
 szUGBOH4taXlVa4vSJZPtISSWBzAKek=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-02WfBvZIPHGUsy2q7NVcig-1; Sun, 22 Feb 2026 09:28:50 -0500
X-MC-Unique: 02WfBvZIPHGUsy2q7NVcig-1
X-Mimecast-MFC-AGG-ID: 02WfBvZIPHGUsy2q7NVcig_1771770529
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4363333c102so2947785f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770529; x=1772375329; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lydss1k89V/8lbFWiww6LDgDn6tT0DEK3ZSxi0vt8K0=;
 b=HL8eK416bW2WrX1nmPkQbQ6yCr+X2NzDPppylfUPvpZIwYI4hdqtTX+Egyfe0lKw3I
 RlnKt4qDI/hw1ugWTQ+xKoxXuIMz99mx4IHjK+w3G4bj3iKYvaKM4eswcrVzZN7ebYoy
 qtMA4kuxM8pupnEyE3SHEUyEusg7sUL+TimU2uzoNyyK4sapkjkVfoiNDtpgKZmi8nkn
 nyYIIsxk54RZWow1FrSEm4twTuxrD15nm73Mz+t6ZF7601RWjACu0ojIf9okZNDrwX1W
 CuKftY0BVMQBzfKQ3A+CPmKwLYwcdJ+Aaun86//IG+VGW7Feqx+jo+5cSfEMxsKt866c
 ridQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770529; x=1772375329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lydss1k89V/8lbFWiww6LDgDn6tT0DEK3ZSxi0vt8K0=;
 b=ANpzGy8rZqBDLgPtHFkzRYY+gr2tNKFE8yXhpJ9vEgJJ0IMiGvLomHp+fnQJgpC9p4
 lx/8pzpb5uJNnPEq1gWO7EzqcVukv1bJLEfix3RX1WP8Al9flBDyeteov1JOn3YGlVm8
 Y6Db4wGQbA+cfK4B/eajpQBSkxIbFZ1PEifrA0+QnO2wILLCEVlu7UuW2FaFWplcwATH
 WD690uD9VHaxnqntstP6IYZKPeGa+LGE7PwFW3IEEzGBD4e3a+MHADKLF/lXMofyziKw
 u/wk/Qve/UiafEHSGSO6zsr1t7FgJ08Tqv3JoTQiFH3jH1mkDq7rIhnd2fQ+n8nSC6GX
 9kyA==
X-Gm-Message-State: AOJu0Yw5DPDXnyn4Op04cqqYkDxl/TLrvoWndBptiDhb/Uf/uStYAKnM
 /0ctWxOLcLXtplWE0agLr11h02vwmN/Y+Q5G6yHiGxZixlTUgivJfRW9TsYibsIGy8Tr7LnR42d
 8B4J7OWjMVBlIJ0YQfbINXUmz069IC3BeY0GxFMjNhv8AUygXk0xtfA8TkVJGf1sLo6eUH352K6
 c1KJe8uVSYSIx5Om+naV1q4HaUBIGTU64qjw==
X-Gm-Gg: AZuq6aJWgeZpB4Dxk9W0dXhOlJ4VxhhtdoTtuzHlCc+O6aIIKvYFHE+HmLoTafQJbiE
 PenQgyeqOsHkQo2byK8w0mOkLa4RqzQWVyrSNxiEV7DCNoS5O1tkqD5hr3i/6ouTKKL0BhwkhWB
 tdTGtv5Kk7RvcMxjUbyPZGNaDyltD8WBkRgkg0aYHuTXR7JRuUyi3htSjEPqPIOE4Htgb5Y2Fdu
 UihI4YRmg2Fp2Kt0Msw7CrLwzQOjFOiMuy843pI/mNRzEVZ0me1QmxR8RAPCh+KNXHqL8ql/1gu
 jSaSsqE5u6tapxKdCjy2LifyE5Ubd1BEBIG5xJ1zN5cFF7VoMUKXjxdET0tvAKNG+CB9E/ib5fl
 q8th/5+EOESED7zutw2VgIf3j6FR3h5Z+OmHSye8RYsAaZg==
X-Received: by 2002:a05:6000:604:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4396f181362mr11071331f8f.46.1771770528775; 
 Sun, 22 Feb 2026 06:28:48 -0800 (PST)
X-Received: by 2002:a05:6000:604:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4396f181362mr11071281f8f.46.1771770528076; 
 Sun, 22 Feb 2026 06:28:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm11949077f8f.29.2026.02.22.06.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:47 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 13/33] hw/cxl: Add support for Maintenance command and Post
 Package Repair (PPR)
Message-ID: <5e5a86bab8308a9d5db09cbfdf12cc3751dce0f7.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Davidlohr Bueso <dave@stgolabs.net>

This adds initial support for the Maintenance command, specifically
the soft and hard PPR operations on a dpa. The implementation allows
to be executed at runtime, therefore semantically, data is retained
and CXL.mem requests are correctly processed.

Keep track of the requests upon a general media or DRAM event.

Post Package Repair (PPR) maintenance operations may be supported by CXL
devices that implement CXL.mem protocol. A PPR maintenance operation
requests the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support PPR features
may implement PPR Maintenance operations. DRAM components may support two
types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
(sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
but the repair is lost with a power cycle.

CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
maintenance operation and section 8.2.10.7.1.3 describes the device's
hPPR (hard PPR) maintenance operation feature.

CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
configuration.

CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
configuration.

CXL spec 3.2 section 8.2.10.2.1.4 Table 8-60 describes the Memory Sparing
Event Record.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250917143330.294698-3-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 240 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 125 +++++++++++++++++++
 include/hw/cxl/cxl_device.h | 112 +++++++++++++++++
 include/hw/cxl/cxl_events.h |  42 +++++++
 4 files changed, 517 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8b471c7d93..59f7a392ef 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -86,6 +86,8 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
         #define SET_FEATURE   0x2
+    MAINTENANCE = 0x06,
+        #define PERFORM 0x0
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -1111,8 +1113,8 @@ typedef struct CXLSupportedFeatureEntry {
 #define CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE BIT(0)
 #define CXL_FEAT_ENTRY_ATTR_FLAG_DEEPEST_RESET_PERSISTENCE_MASK GENMASK(3, 1)
 #define CXL_FEAT_ENTRY_ATTR_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE BIT(4)
-#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION BIT(5)
-#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SELECTION BIT(6)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL BIT(5)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SEL BIT(6)
 
 /* Supported Feature Entry : set feature effects */
 #define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_COLD_RESET BIT(0)
@@ -1131,6 +1133,8 @@ typedef struct CXLSupportedFeatureEntry {
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_ECS,
+    CXL_FEATURE_SPPR,
+    CXL_FEATURE_HPPR,
     CXL_FEATURE_MAX
 };
 
@@ -1172,6 +1176,28 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
 };
 #define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
 
+/* CXL r3.2 section 8.2.10.7.2.1: sPPR Feature Discovery and Configuration */
+static const QemuUUID soft_ppr_uuid = {
+    .data = UUID(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e,
+                 0x69, 0x2c, 0x91, 0x75, 0x68, 0xbb)
+};
+
+typedef struct CXLMemSoftPPRSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemSoftPPRWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemSoftPPRSetFeature;
+
+/* CXL r3.2 section 8.2.10.7.2.2: hPPR Feature Discovery and Configuration */
+static const QemuUUID hard_ppr_uuid = {
+    .data = UUID(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1,
+                 0xec, 0x74, 0x59, 0xfb, 0x0e, 0x24)
+};
+
+typedef struct CXLMemHardPPRSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemHardPPRWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemHardPPRSetFeature;
+
 /* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
 static const QemuUUID patrol_scrub_uuid = {
     .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
@@ -1235,6 +1261,38 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     for (entry = 0, index = get_feats_in->start_index;
          entry < req_entries; index++) {
         switch (index) {
+        case CXL_FEATURE_SPPR:
+            /* Fill supported feature entry for soft-PPR */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = soft_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSoftPPRReadAttrs),
+                .set_feat_size = sizeof(CXLMemSoftPPRWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPPR_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPPR_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_HPPR:
+            /* Fill supported feature entry for hard-PPR */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = hard_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemHardPPRReadAttrs),
+                .set_feat_size = sizeof(CXLMemHardPPRWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_HPPR_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_HPPR_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         case  CXL_FEATURE_PATROL_SCRUB:
             /* Fill supported feature entry for device patrol scrub control */
             get_feats_out->feat_entries[entry++] =
@@ -1333,6 +1391,26 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSoftPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSoftPPRReadAttrs) -
+                        get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->soft_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemHardPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemHardPPRReadAttrs) -
+                        get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1444,6 +1522,44 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                         ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
             }
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+        CXLMemSoftPPRSetFeature *sppr_set_feature = (void *)payload_in;
+        CXLMemSoftPPRWriteAttrs *sppr_write_attrs =
+                            &sppr_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
+               sppr_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->soft_ppr_attrs.op_mode = ct3d->soft_ppr_wr_attrs.op_mode;
+            ct3d->soft_ppr_attrs.sppr_op_mode =
+                    ct3d->soft_ppr_wr_attrs.sppr_op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+        CXLMemHardPPRSetFeature *hppr_set_feature = (void *)payload_in;
+        CXLMemHardPPRWriteAttrs *hppr_write_attrs =
+                            &hppr_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_HPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
+               hppr_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->hard_ppr_attrs.op_mode = ct3d->hard_ppr_wr_attrs.op_mode;
+            ct3d->hard_ppr_attrs.hppr_op_mode =
+                    ct3d->hard_ppr_wr_attrs.hppr_op_mode;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1456,6 +1572,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
             memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
@@ -1466,6 +1586,116 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
+                            uint8_t maint_op_class, uint8_t maint_op_sub_class,
+                            CXLMaintenance *ent)
+{
+    CXLEventSparing event_rec = {};
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &sparing_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            1, maint_op_class, 1, maint_op_sub_class,
+                            0, 0, 0, 0);
+    if (ent) {
+        event_rec.flags = 0;
+        event_rec.result = 0;
+        stw_le_p(&event_rec.res_avail, 2);
+        stw_le_p(&event_rec.validity_flags, ent->validity_flags);
+        event_rec.channel = ent->channel;
+        event_rec.rank = ent->rank;
+        st24_le_p(event_rec.nibble_mask, ent->nibble_mask);
+        event_rec.bank_group = ent->bank_group;
+        event_rec.bank = ent->bank;
+        st24_le_p(event_rec.row, ent->row);
+        stw_le_p(&event_rec.column, ent->column);
+        event_rec.sub_channel = ent->sub_channel;
+        if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
+            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
+                    sizeof(event_rec.component_id));
+        }
+    } else {
+        return;
+    }
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_INFO,
+                         (CXLEventRecordRaw *)&event_rec)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
+
+static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
+{
+    CXLMaintenance *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, &ct3d->maint_list, node, next) {
+        if (dpa == ent->dpa) {
+            /* Produce a Memory Sparing Event Record */
+            if (ct3d->soft_ppr_attrs.sppr_op_mode &
+                CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN) {
+                cxl_mbox_create_mem_sparing_event_records(ct3d,
+                                CXL_MEMDEV_MAINT_CLASS_SPARING,
+                                CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
+                                ent);
+            }
+            break;
+        }
+    }
+}
+
+/* CXL r3.2 section 8.2.10.7.1 - Perform Maintenance (Opcode 0600h) */
+#define MAINTENANCE_PPR_QUERY_RESOURCES BIT(0)
+
+static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    struct {
+        uint8_t class;
+        uint8_t subclass;
+        union {
+            struct {
+                uint8_t flags;
+                uint64_t dpa;
+                uint8_t nibble_mask[3];
+            } QEMU_PACKED ppr;
+        };
+    } QEMU_PACKED *maint_in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+    if (maintenance_running(cci)) {
+        return CXL_MBOX_BUSY;
+    }
+
+    switch (maint_in->class) {
+    case CXL_MEMDEV_MAINT_CLASS_NO_OP:
+        return CXL_MBOX_SUCCESS; /* nop */
+    case CXL_MEMDEV_MAINT_CLASS_PPR:
+        if (maint_in->ppr.flags & MAINTENANCE_PPR_QUERY_RESOURCES) {
+            return CXL_MBOX_SUCCESS;
+        }
+
+        switch (maint_in->subclass) {
+        case CXL_MEMDEV_MAINT_SUBCLASS_SPPR:
+        case CXL_MEMDEV_MAINT_SUBCLASS_HPPR:
+            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
+            return CXL_MBOX_SUCCESS;
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -3767,6 +3997,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                  CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
                                  CXL_MBOX_IMMEDIATE_LOG_CHANGE |
                                  CXL_MBOX_SECURITY_STATE_CHANGE)},
+    [MAINTENANCE][PERFORM] = { "MAINTENANCE_PERFORM",
+                               cmd_media_perform_maintenance, ~0,
+                               CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                               CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                               CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                               CXL_MBOX_BACKGROUND_OPERATION },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index acb75f8f01..697b3fa0de 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -964,6 +964,32 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
+    /* Set default values for soft-PPR attributes */
+    ct3d->soft_ppr_attrs = (CXLMemSoftPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_PPR,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_SPPR,
+        .sppr_flags = CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG |
+                      CXL_MEMDEV_SPPR_MEM_SPARING_EV_REC_CAP_FLAG,
+        .restriction_flags = 0,
+        .sppr_op_mode = CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN
+    };
+
+    /* Set default value for hard-PPR attributes */
+    ct3d->hard_ppr_attrs = (CXLMemHardPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_PPR,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_HPPR,
+        .hppr_flags = CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG |
+                      CXL_MEMDEV_HPPR_MEM_SPARING_EV_REC_CAP_FLAG,
+        .restriction_flags = 0,
+        .hppr_op_mode = CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN
+    };
+
     return;
 
 err_release_cdat:
@@ -1667,6 +1693,75 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return -EINVAL;
     }
 }
+
+static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
+                                   bool has_channel, uint8_t channel,
+                                   bool has_rank, uint8_t rank,
+                                   bool has_nibble_mask, uint32_t nibble_mask,
+                                   bool has_bank_group, uint8_t bank_group,
+                                   bool has_bank, uint8_t bank,
+                                   bool has_row, uint32_t row,
+                                   bool has_column, uint16_t column,
+                                   const char *component_id,
+                                   bool has_comp_id_pldm, bool is_comp_id_pldm,
+                                   bool has_sub_channel, uint8_t sub_channel)
+{
+    CXLMaintenance *ent, *m;
+
+    QLIST_FOREACH(ent, &ct3d->maint_list, node) {
+        if (dpa == ent->dpa) {
+            return;
+        }
+    }
+    m = g_new0(CXLMaintenance, 1);
+    memset(m, 0, sizeof(*m));
+    m->dpa = dpa;
+    m->validity_flags = 0;
+
+    if (has_channel) {
+        m->channel = channel;
+        m->validity_flags |= CXL_MSER_VALID_CHANNEL;
+    }
+    if (has_rank) {
+        m->rank = rank;
+        m->validity_flags |= CXL_MSER_VALID_RANK;
+    }
+    if (has_nibble_mask) {
+        m->nibble_mask = nibble_mask;
+        m->validity_flags |= CXL_MSER_VALID_NIB_MASK;
+    }
+    if (has_bank_group) {
+        m->bank_group = bank_group;
+        m->validity_flags |= CXL_MSER_VALID_BANK_GROUP;
+    }
+    if (has_bank) {
+        m->bank = bank;
+        m->validity_flags |= CXL_MSER_VALID_BANK;
+    }
+    if (has_row) {
+        m->row = row;
+        m->validity_flags |= CXL_MSER_VALID_ROW;
+    }
+    if (has_column) {
+        m->column = column;
+        m->validity_flags |= CXL_MSER_VALID_COLUMN;
+    }
+    if (has_sub_channel) {
+        m->sub_channel = sub_channel;
+        m->validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
+    }
+    if (component_id) {
+        strncpy((char *)m->component_id, component_id,
+                sizeof(m->component_id) - 1);
+        m->validity_flags |= CXL_MSER_VALID_COMP_ID;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;
+        }
+    }
+
+    QLIST_INSERT_HEAD(&ct3d->maint_list, m, node);
+}
+
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
@@ -1715,6 +1810,11 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO &&
+        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
+        error_setg(errp, "Informational event cannot require maintenance");
+        return;
+    }
     enc_log = rc;
 
     memset(&gem, 0, sizeof(gem));
@@ -1773,6 +1873,15 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
+        cxl_maintenance_insert(ct3d, dpa, has_channel, channel,
+                               has_rank, rank,
+                               0, 0, 0, 0, 0, 0, 0, 0,
+                               0, 0, component_id,
+                               has_comp_id_pldm, is_comp_id_pldm,
+                               0, 0);
+    }
 }
 
 #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
@@ -1842,6 +1951,11 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO &&
+        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
+        error_setg(errp, "Informational event cannot require maintenance");
+        return;
+    }
     enc_log = rc;
 
     memset(&dram, 0, sizeof(dram));
@@ -1935,6 +2049,17 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
+        cxl_maintenance_insert(ct3d, dpa, has_channel, channel,
+                               has_rank, rank,
+                               has_nibble_mask, nibble_mask,
+                               has_bank_group, bank_group,
+                               has_bank, bank, has_row, row,
+                               has_column, column, component_id,
+                               has_comp_id_pldm, is_comp_id_pldm,
+                               has_sub_channel, sub_channel);
+    }
 }
 
 #define CXL_MMER_VALID_COMPONENT                        BIT(0)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e461a824b6..2d4f26acfd 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -430,6 +430,12 @@ static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
     uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
     return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
+
+static inline bool maintenance_running(CXLCCI *cci)
+{
+    return cci->bg.runtime && cci->bg.opcode == 0x0600;
+}
+
 static inline bool scan_media_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
@@ -443,6 +449,23 @@ typedef struct CXLError {
 
 typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
 
+typedef struct CXLMaintenance {
+    uint64_t dpa;
+    uint16_t validity_flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint32_t nibble_mask;
+    uint8_t bank_group;
+    uint8_t bank;
+    uint32_t row;
+    uint16_t column;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    QLIST_ENTRY(CXLMaintenance) node;
+} CXLMaintenance;
+
+typedef QLIST_HEAD(, CXLMaintenance) CXLMaintenanceList;
+
 typedef struct CXLPoison {
     uint64_t start, length;
     uint8_t type;
@@ -455,6 +478,87 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+/* CXL memory maintenance operation */
+/*
+ * CXL r3.2 section 8.2.10.7.2, Table 8-125: Mainteance Operation:
+ * Classes, Subclasses, and Feature UUIDs
+ */
+#define CXL_MEMDEV_MAINT_CLASS_NO_OP 0x0
+#define CXL_MEMDEV_MAINT_CLASS_PPR 0x1
+#define CXL_MEMDEV_MAINT_CLASS_SPARING 0x2
+#define CXL_MEMDEV_MAINT_CLASS_DEV_BUILT_IN_TEST 0x3
+
+#define CXL_MEMDEV_MAINT_SUBCLASS_SPPR 0x0
+#define CXL_MEMDEV_MAINT_SUBCLASS_HPPR 0x1
+
+#define CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING 0x0
+#define CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING 0x1
+#define CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING 0x2
+#define CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING 0x3
+
+/* CXL memory Post Package Repair control attributes */
+/*
+ * CXL r3.2 section 8.2.10.7.2.1, Table 8-128 and 8-129:
+ * sPPR Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemSoftPPRReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[9];
+    uint8_t sppr_flags;
+    uint16_t restriction_flags;
+    uint8_t sppr_op_mode;
+} QEMU_PACKED CXLMemSoftPPRReadAttrs;
+
+typedef struct CXLMemSoftPPRWriteAttrs {
+    uint16_t op_mode;
+    uint8_t sppr_op_mode;
+} QEMU_PACKED CXLMemSoftPPRWriteAttrs;
+
+#define CXL_MEMDEV_SPPR_GET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_SPPR_SET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG               BIT(0)
+#define CXL_MEMDEV_SPPR_NIBBLE_SUPPORT_FLAG            BIT(1)
+#define CXL_MEMDEV_SPPR_MEM_SPARING_EV_REC_CAP_FLAG BIT(2)
+#define CXL_MEMDEV_SPPR_DEV_INITIATED_AT_BOOT_CAP_FLAG BIT(3)
+
+#define CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN BIT(0)
+#define CXL_MEMDEV_SPPR_OP_MODE_DEV_INITIATED_AT_BOOT BIT(1)
+
+/*
+ * CXL r3.2 section 8.2.10.7.2.2, Table 8-131 and 8-132:
+ * hPPR Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemHardPPRReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[9];
+    uint8_t hppr_flags;
+    uint16_t restriction_flags;
+    uint8_t hppr_op_mode;
+} QEMU_PACKED CXLMemHardPPRReadAttrs;
+
+typedef struct CXLMemHardPPRWriteAttrs {
+    uint16_t op_mode;
+    uint8_t hppr_op_mode;
+} QEMU_PACKED CXLMemHardPPRWriteAttrs;
+
+#define CXL_MEMDEV_HPPR_GET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_HPPR_SET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG               BIT(0)
+#define CXL_MEMDEV_HPPR_NIBBLE_SUPPORT_FLAG            BIT(1)
+#define CXL_MEMDEV_HPPR_MEM_SPARING_EV_REC_CAP_FLAG    BIT(2)
+#define CXL_MEMDEV_HPPR_DEV_INITIATED_AT_BOOT_CAP_FLAG BIT(3)
+
+#define CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN BIT(0)
+#define CXL_MEMDEV_HPPR_OP_MODE_DEV_INITIATED_AT_BOOT BIT(1)
+
 /* CXL memory device patrol scrub control attributes */
 typedef struct CXLMemPatrolScrubReadAttrs {
         uint8_t scrub_cycle_cap;
@@ -605,6 +709,9 @@ struct CXLType3Dev {
     /* Error injection */
     CXLErrorList error_list;
 
+    /* Keep track of maintenance requests */
+    CXLMaintenanceList maint_list;
+
     /* Poison Injection - cache */
     CXLPoisonList poison_list;
     unsigned int poison_list_cnt;
@@ -617,6 +724,11 @@ struct CXLType3Dev {
 
     CXLSetFeatureInfo set_feat_info;
 
+    /* PPR control attributes */
+    CXLMemSoftPPRReadAttrs soft_ppr_attrs;
+    CXLMemSoftPPRWriteAttrs soft_ppr_wr_attrs;
+    CXLMemHardPPRReadAttrs hard_ppr_attrs;
+    CXLMemHardPPRWriteAttrs hard_ppr_wr_attrs;
     /* Patrol scrub control attributes */
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4a7836ad72..3052bc9f18 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -219,4 +219,46 @@ typedef enum CXLDCEventType {
     DC_EVENT_CAPACITY_RELEASED = 0x5,
 } CXLDCEventType;
 
+/*
+ * CXL r3.2 section Table 8-60: Memory Sparing Event Record
+ * All fields little endian.
+ */
+#define CXL_MSER_VALID_CHANNEL BIT(0)
+#define CXL_MSER_VALID_RANK BIT(1)
+#define CXL_MSER_VALID_NIB_MASK BIT(2)
+#define CXL_MSER_VALID_BANK_GROUP BIT(3)
+#define CXL_MSER_VALID_BANK BIT(4)
+#define CXL_MSER_VALID_ROW BIT(5)
+#define CXL_MSER_VALID_COLUMN BIT(6)
+#define CXL_MSER_VALID_COMP_ID BIT(7)
+#define CXL_MSER_VALID_COMP_ID_FORMAT BIT(8)
+#define CXL_MSER_VALID_SUB_CHANNEL BIT(9)
+
+typedef struct CXLEventSparing {
+    CXLEventRecordHdr hdr;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t flags;
+    uint8_t result;
+    uint16_t validity_flags;
+    uint8_t reserved1[6];
+    uint16_t res_avail;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    uint8_t reserved2[0x25];
+} QEMU_PACKED CXLEventSparing;
+
+/* CXL r3.2 Table 8-60: Memory Sparing Event Record */
+static const QemuUUID sparing_uuid = {
+    .data = UUID(0xe71f3a40, 0x2d29, 0x4092, 0x8a, 0x39,
+                 0x4d, 0x1c, 0x96, 0x6c, 0x7c, 0x65),
+};
+
 #endif /* CXL_EVENTS_H */
-- 
MST


