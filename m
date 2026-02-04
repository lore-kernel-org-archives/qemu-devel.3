Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30D5EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9i-00061m-8h; Wed, 04 Feb 2026 14:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9c-0005zz-Ag
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9Y-0007iW-Vl
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdpxBV07eKB+3arYDNp/6Z4nxyWT8AOAC6C29860iBk=;
 b=bdsJlXd/qypJOAsFM13fbRAiMNnjICPUdGGRNguKV5cLNc5/SjFQ7KPHSBhc0i/lEIbbfB
 EzZoxvBfZKRZOf1Z1e3Y+mveMmUff9G77qdlM3BcVbVWS/hLJgANpNYHOf86XQSmxWJrRH
 VqcD6aWYTzpDKnO/HbBABSu7jFrPyFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-M1XgtISjOoeA4ClCISCJew-1; Wed, 04 Feb 2026 14:03:02 -0500
X-MC-Unique: M1XgtISjOoeA4ClCISCJew-1
X-Mimecast-MFC-AGG-ID: M1XgtISjOoeA4ClCISCJew_1770231781
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so1811685e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231781; x=1770836581; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kdpxBV07eKB+3arYDNp/6Z4nxyWT8AOAC6C29860iBk=;
 b=MTEVJJQ1FKz8+BI+NfpabdHup3fxULI1wgbWC71fmz2LbRyAvP1hbuM++FR/30Y54E
 k986paNW3Ld2/h0MzUCuJNBGxungPzf7NEzRWoOOySch3p0A+/+RC2JrpuxYGdfL+Jo/
 W30Yu1X1rZ6G0T2I49+QuXqk1rXlYm2x/OhEdzBWqRI74mMC84ycVIrJxGUeGcLAgis0
 xCXwhbGWtRgEdSpOqsyiQtNYYPe4364RAAAWurWN7kOnE1kF59GSN8v7r3ty4qPDUDHS
 ErqL87WU9yYUXLctgsR3S/Y5UcQqOno7ZIT4GG+U23HxzeHVF4noPEFBcBnIylLGji/1
 mfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231781; x=1770836581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdpxBV07eKB+3arYDNp/6Z4nxyWT8AOAC6C29860iBk=;
 b=hoqu5r5VekUEtvVmn5tIdIuqUJ94LIUxbB+aQqtka+bGZdFgO4BIyKh4+5mdSxeUaw
 hnhEZ90QCQogQSI8EvDVnhLTM/ZgwU7d6k+9cFXr0cOpy2DJcTQZuBPr7dwIE5LasZCM
 3KL0PU/QenOKSxKC9Y3bOA9yJUHBvXrbhHG1I0ve7ioIdqAO1ZjR2HrgpJQRDepN1Mef
 L0ousT2qsyxFs5GK8BghlZYtWAG7C82dAKDk4RRg2o35LuNQ8hPm0R75auHKWtX5cYYC
 y3fqOWXnlVfTnmcruBQuzV4VHyoostuwVDS9nPIbUG+t3/6JkgzVsJfb/oipcMpShUTx
 g6lw==
X-Gm-Message-State: AOJu0YxTaIkkrheJnVM9WZuSRtb3P8yjFfcIgGQ5tkK3z/C412rSjqZv
 QDzwLYS1IZ+n7/vjEZmRqeMImr6aFmCUGBm7+2hliueXLx4El97NlOB5nbPqcbQIj9shwk8pu7s
 6Y9NiytDURtekkUPVDjTfTTpzdN+taTJveBuaLYedSSbjuIUqPPy506dfGVxHiZwALJ/4CCWXBr
 zRm+iG5NX/bFZlhEp1zxiqmx5lhCYXxM7nqg==
X-Gm-Gg: AZuq6aIMOuzPGQG3RK9YcyXuvzvT3peYXwnvKF04d/ka65xf0IKtq63phuA2yPZPRV+
 vN3ccMzS/4vkeha9ZScPvbV4rCcKxIxNMI2vIivOrWQDMgevnZHbw+OkQxlyh2L4/fon0V5o4xT
 cZpPYNF85sYvNv+9kmn9Hl4tpE1Kdo6WXm2HGlZibHVvrUj6h+JrYPvdse/TzUSbP6fqFrRNXG8
 f8ihH3WTFrufZXKS33PnfKK+22suDuY2d++cslHS258pLM/NOwx1+x1maNoAOVJUpGkvdkL+s6R
 Q4B5rzkSj0k2gLd6Dmf+01DP6ZPl4BXRh89IIE8iqZffWG5O0rrTYBuEfqbTXO+6ZNCYC4pFYpe
 RmkyLU5xvUwPSn4QzuNX+UnKtVSVBGc0xHQ==
X-Received: by 2002:a05:600c:848a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4830e930426mr55743815e9.12.1770231780631; 
 Wed, 04 Feb 2026 11:03:00 -0800 (PST)
X-Received: by 2002:a05:600c:848a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4830e930426mr55743245e9.12.1770231780019; 
 Wed, 04 Feb 2026 11:03:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec5cc24sm39868465e9.3.2026.02.04.11.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:02:59 -0800 (PST)
Date: Wed, 4 Feb 2026 14:02:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 04/51] hw/cxl: Add emulation for memory sparing control feature
Message-ID: <ecb32ae609d0e3b7a914c730ebd81a9eade73008.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Shiju Jose <shiju.jose@huawei.com>

Memory sparing is defined as a repair function that replaces a portion of
memory with a portion of functional memory at that same DPA. The
subclasses for this operation vary in terms of the scope of the sparing
being performed. The Cacheline sparing subclass refers to a sparing
action that can replace a full cacheline. Row sparing is provided as an
alternative to PPR sparing functions and its scope is that of a single
DDR row. Bank sparing allows an entire bank to be replaced. Rank sparing
is defined as an operation in which an entire DDR rank is replaced.

Memory sparing maintenance operations may be supported by CXL devices
that implement CXL.mem protocol. A sparing maintenance operation requests
the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support memory sparing
features may implement sparing Maintenance operations.

The host may issue a query command by setting Query Resources flag in the
Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
sparing resources for a given address. In response to a query request,
the device shall report the resource availability by producing the Memory
Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
of the values specified in the request.

During the execution of a sparing maintenance operation, a CXL memory
device:
- May or may not retain data
- May or may not be able to process CXL.mem requests correctly.
These CXL memory device capabilities are specified by restriction flags
in the memory sparing feature readable attributes.

When a CXL device identifies error on a memory component, the device
may inform the host about the need for a memory sparing maintenance
operation by using DRAM event record, where the 'maintenance needed' flag
may set. The event record contains some of the DPA, Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
should be repaired. The userspace tool requests for maintenance operation
if the 'maintenance needed' flag set in the CXL DRAM error record.

CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
discovery and configuration.

CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
maintenance operation feature.

Add emulation for CXL memory device memory sparing control feature
and memory sparing maintenance operation command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250917143330.294698-4-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 317 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  44 +++++
 include/hw/cxl/cxl_device.h |  33 ++++
 include/hw/cxl/cxl_events.h |   5 +
 4 files changed, 395 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8c38b88ad4..a4bd49e113 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1135,6 +1135,10 @@ enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_ECS,
     CXL_FEATURE_SPPR,
     CXL_FEATURE_HPPR,
+    CXL_FEATURE_CACHELINE_SPARING,
+    CXL_FEATURE_ROW_SPARING,
+    CXL_FEATURE_BANK_SPARING,
+    CXL_FEATURE_RANK_SPARING,
     CXL_FEATURE_MAX
 };
 
@@ -1223,6 +1227,35 @@ typedef struct CXLMemECSSetFeature {
         CXLMemECSWriteAttrs feat_data[];
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
 
+/*
+ * CXL r3.2 section 8.2.10.7.2.3:
+ * Memory Sparing Features Discovery and Configuration
+ */
+static const QemuUUID cacheline_sparing_uuid = {
+    .data = UUID(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb,
+                 0xfd, 0xaf, 0x65, 0x03, 0xba, 0xc4)
+};
+
+static const QemuUUID row_sparing_uuid = {
+    .data = UUID(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98,
+                 0xc2, 0xd5, 0x7f, 0x27, 0x9b, 0xed)
+};
+
+static const QemuUUID bank_sparing_uuid = {
+    .data = UUID(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef,
+                 0xfa, 0xac, 0x5d, 0x18, 0xa8, 0x63)
+};
+
+static const QemuUUID rank_sparing_uuid = {
+    .data = UUID(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76,
+                 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7)
+};
+
+typedef struct CXLMemSparingSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemSparingWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemSparingSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1323,6 +1356,70 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                     CXL_FEAT_ENTRY_SFE_CEL_VALID,
             };
             break;
+        case CXL_FEATURE_CACHELINE_SPARING:
+            /* Fill supported feature entry for Cacheline Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = cacheline_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_ROW_SPARING:
+            /* Fill supported feature entry for Row Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = row_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_BANK_SPARING:
+            /* Fill supported feature entry for Bank Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = bank_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_RANK_SPARING:
+            /* Fill supported feature entry for Rank Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = rank_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -1411,6 +1508,47 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid,
+                                  &cacheline_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->cacheline_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &row_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->row_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &bank_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->bank_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &rank_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->rank_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1560,6 +1698,78 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             ct3d->hard_ppr_attrs.hppr_op_mode =
                     ct3d->hard_ppr_wr_attrs.hppr_op_mode;
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->cacheline_sparing_attrs.op_mode =
+                                    ct3d->cacheline_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->row_sparing_attrs.op_mode =
+                              ct3d->row_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->bank_sparing_attrs.op_mode =
+                              ct3d->bank_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->rank_sparing_attrs.op_mode =
+                             ct3d->rank_sparing_wr_attrs.op_mode;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1576,6 +1786,15 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
             memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
+            memset(&ct3d->cacheline_sparing_wr_attrs, 0,
+                   set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
+            memset(&ct3d->row_sparing_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
+            memset(&ct3d->bank_sparing_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
+            memset(&ct3d->rank_sparing_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
@@ -1586,9 +1805,27 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
+#define CXL_MEM_SPARING_FLAGS_QUERY_RESOURCES BIT(0)
+#define CXL_MEM_SPARING_FLAGS_HARD_SPARING BIT(1)
+#define CXL_MEM_SPARING_FLAGS_SUB_CHANNEL_VALID BIT(2)
+#define CXL_MEM_SPARING_FLAGS_NIB_MASK_VALID BIT(3)
+
+typedef struct CXLMemSparingMaintInPayload {
+    uint8_t flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint8_t sub_channel;
+} QEMU_PACKED CXLMemSparingMaintInPayload;
+
+static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
                             uint8_t maint_op_class, uint8_t maint_op_sub_class,
-                            CXLMaintenance *ent)
+                            CXLMaintenance *ent,
+                            CXLMemSparingMaintInPayload *sparing_pi)
 {
     CXLEventSparing event_rec = {};
 
@@ -1616,6 +1853,31 @@ static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
             strncpy((char *)event_rec.component_id, (char *)ent->component_id,
                     sizeof(event_rec.component_id));
         }
+    } else if (sparing_pi) {
+        event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
+        event_rec.result = 0;
+        event_rec.validity_flags = CXL_MSER_VALID_CHANNEL |
+                                   CXL_MSER_VALID_RANK |
+                                   CXL_MSER_VALID_NIB_MASK |
+                                   CXL_MSER_VALID_BANK_GROUP |
+                                   CXL_MSER_VALID_BANK |
+                                   CXL_MSER_VALID_ROW |
+                                   CXL_MSER_VALID_COLUMN;
+        event_rec.res_avail = 1;
+        event_rec.channel = sparing_pi->channel;
+        event_rec.rank = sparing_pi->rank;
+        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_NIB_MASK_VALID) {
+            memcpy(event_rec.nibble_mask, sparing_pi->nibble_mask,
+                   sizeof(sparing_pi->nibble_mask));
+        }
+        event_rec.bank_group = sparing_pi->bank_group;
+        event_rec.bank = sparing_pi->bank;
+        event_rec.column = sparing_pi->column;
+        memcpy(event_rec.row, sparing_pi->row, sizeof(sparing_pi->row));
+        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_SUB_CHANNEL_VALID) {
+            event_rec.sub_channel = sparing_pi->sub_channel;
+            event_rec.validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
+        }
     } else {
         return;
     }
@@ -1627,6 +1889,26 @@ static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
     }
 }
 
+static CXLRetCode cxl_perform_mem_sparing(CXLType3Dev *ct3d, uint8_t sub_class,
+                                          void *maint_pi)
+{
+    switch (sub_class) {
+    case CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING:
+        qemu_log("Cacheline Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING:
+        qemu_log("Row Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING:
+        qemu_log("Bank Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING:
+        qemu_log("Rank Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+}
 
 static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
 {
@@ -1637,10 +1919,10 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
             /* Produce a Memory Sparing Event Record */
             if (ct3d->soft_ppr_attrs.sppr_op_mode &
                 CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN) {
-                cxl_mbox_create_mem_sparing_event_records(ct3d,
+                cxl_create_mem_sparing_event_records(ct3d,
                                 CXL_MEMDEV_MAINT_CLASS_SPARING,
                                 CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
-                                ent);
+                                ent, NULL);
             }
             break;
         }
@@ -1664,6 +1946,7 @@ static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
                 uint64_t dpa;
                 uint8_t nibble_mask[3];
             } QEMU_PACKED ppr;
+            CXLMemSparingMaintInPayload mem_sparing_pi;
         };
     } QEMU_PACKED *maint_in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -1689,6 +1972,32 @@ static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
             return CXL_MBOX_INVALID_INPUT;
         }
         break;
+    case CXL_MEMDEV_MAINT_CLASS_SPARING:
+        if (maint_in->mem_sparing_pi.flags &
+            CXL_MEM_SPARING_FLAGS_QUERY_RESOURCES) {
+            /*
+             * CXL r3.2 sect 8.2.10.7.1.4 - Memory Sparing Maintenance Operation
+             * Produce Memory Sparing Event record to report resources
+             * availability.
+             */
+            cxl_create_mem_sparing_event_records(ct3d, maint_in->class,
+                                                 maint_in->subclass, NULL,
+                                                 &maint_in->mem_sparing_pi);
+
+            return CXL_MBOX_SUCCESS;
+        }
+
+        switch (maint_in->subclass) {
+        case CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING:
+            return cxl_perform_mem_sparing(ct3d, maint_in->subclass,
+                                           &maint_in->mem_sparing_pi);
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
     default:
         return CXL_MBOX_INVALID_INPUT;
     }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b02dc31f11..7e309af935 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -990,6 +990,50 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         .hppr_op_mode = CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN
     };
 
+    /* Set default value for Cacheline Memory Sparing attributes */
+    ct3d->cacheline_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Row Memory Sparing attributes */
+    ct3d->row_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Bank Memory Sparing attributes */
+    ct3d->bank_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Rank Memory Sparing attributes */
+    ct3d->rank_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
     return;
 
 err_release_cdat:
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 72e8c68187..55797a9ec3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,30 @@ typedef struct CXLMemECSWriteAttrs {
     CXLMemECSFRUWriteAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
 } QEMU_PACKED CXLMemECSWriteAttrs;
 
+/*
+ * CXL r3.2 section 8.2.10.7.2.3, Table 8-134 and 8-135:
+ * Memory Sparing Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemSparingReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[10];
+    uint16_t restriction_flags;
+} QEMU_PACKED CXLMemSparingReadAttrs;
+
+typedef struct CXLMemSparingWriteAttrs {
+    uint16_t op_mode;
+} QEMU_PACKED CXLMemSparingWriteAttrs;
+
+#define CXL_MEMDEV_SPARING_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_SPARING_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_SPARING_SAFE_IN_USE_FLAG     BIT(0)
+#define CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG    BIT(1)
+#define CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG    BIT(2)
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -735,6 +759,15 @@ struct CXLType3Dev {
     /* ECS control attributes */
     CXLMemECSReadAttrs ecs_attrs;
     CXLMemECSWriteAttrs ecs_wr_attrs;
+    /* Memory Sparing control attributes */
+    CXLMemSparingReadAttrs cacheline_sparing_attrs;
+    CXLMemSparingWriteAttrs cacheline_sparing_wr_attrs;
+    CXLMemSparingReadAttrs row_sparing_attrs;
+    CXLMemSparingWriteAttrs row_sparing_wr_attrs;
+    CXLMemSparingReadAttrs bank_sparing_attrs;
+    CXLMemSparingWriteAttrs bank_sparing_wr_attrs;
+    CXLMemSparingReadAttrs rank_sparing_attrs;
+    CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 7cba494b72..8a660c7a62 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -203,6 +203,11 @@ typedef enum CXLDCEventType {
  * CXL r3.2 section Table 8-60: Memory Sparing Event Record
  * All fields little endian.
  */
+
+#define CXL_MSER_FLAGS_QUERY_RESOURCES BIT(0)
+#define CXL_MSER_FLAGS_HARD_SPARING BIT(1)
+#define CXL_MSER_FLAGS_DEV_INITIATED BIT(2)
+
 #define CXL_MSER_VALID_CHANNEL BIT(0)
 #define CXL_MSER_VALID_RANK BIT(1)
 #define CXL_MSER_VALID_NIB_MASK BIT(2)
-- 
MST


