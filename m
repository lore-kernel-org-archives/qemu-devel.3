Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF3C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgjy-0003WB-4L; Sun, 21 Jul 2024 20:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjw-0003Q7-IR
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgju-0005kc-Dp
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugOrV8EJw9eeb5qLhYeR3H1/gihB/jIlqcXCvXTnPcM=;
 b=DQ+HUvXwbBl91p1cwn7EirsqrYsLiOCDUG0jYA47z+nNQv02PJtUrvVhlEN5NJ3LTfEm8s
 H+4ARLGKepAemiZJA1dflsXVG/eKP5YlViuTYKMAo5Vpt1JAPVfwtuRRWhEZFi0xayi90U
 5rbxG8Y+IXwd4FHTkptybVdd3frLY3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-071YkblUPFCiBYeL_Z0kMA-1; Sun, 21 Jul 2024 20:17:16 -0400
X-MC-Unique: 071YkblUPFCiBYeL_Z0kMA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427d92bec90so19337785e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607434; x=1722212234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugOrV8EJw9eeb5qLhYeR3H1/gihB/jIlqcXCvXTnPcM=;
 b=F28mf2FRjei01RPJ/jCGVtJuJ1RRQCjWL9fTwIfffyKInR0jTU6O37tdnSCYfQZ/LL
 QiC33pIB7ohDmZIkekhUVCllhLlAWoND/oEdi8rO+5ni21r8Ab0x+079FwkkcfrnNAFn
 G6O+ff5XuixGPPS+Edm62fFafyNf5+ciAJXQL/hMYUQj1hGH/xFnmnV8KvUVdmWh/3Hc
 L1LcDp1XVm+XkiYwebiCivQDv7O8Nhquav2JshLsiNUs5aTdb4U1zZVbU8Mk0csQ0JLe
 WDtdK0hJyd1VESHw9BS8H41Gfhh2WGk/qYg7hnCnIHrepWKQbdsgQfOYl90RSv317Xl8
 N/Gg==
X-Gm-Message-State: AOJu0YyKzu3Q8Dw+QIgKH3wxdGNReM5Cno+iKgzN+ptjooJ6xmHUP03u
 ZJ+/ppRKysaCMT+NC788+nlwB0Yah4ioOk5IC4p/QrGIE/iSt9VbOgV6kPvE3gysvBXXl35ieQD
 2wXru2GrzLRQdCFz3pS+2TvCBCsZuxDxIBPCc3v174RcnpqEHfG0JJDlOs9JGco/MhjReW0D1zQ
 GT1/k5LPmMAHtXIiejvwXwO+66wHXaKg==
X-Received: by 2002:a05:600c:1f87:b0:426:67ad:38e3 with SMTP id
 5b1f17b1804b1-427daa2135bmr35797175e9.3.1721607434558; 
 Sun, 21 Jul 2024 17:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL39haoVzxK3A7NMK1RgArJGKb6H+U6UJO5NsILwpa0gDHb2CX2rIugNPw4PRCJngp20+K5A==
X-Received: by 2002:a05:600c:1f87:b0:426:67ad:38e3 with SMTP id
 5b1f17b1804b1-427daa2135bmr35796995e9.3.1721607433938; 
 Sun, 21 Jul 2024 17:17:13 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced6dsm6999983f8f.75.2024.07.21.17.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:13 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 11/63] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Message-ID: <d80378943a6b88b8d211e1468073d9dd44239e27.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature and
optionally modified using Set Feature.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Link: https://lore.kernel.org/r/20240223085902.1549-2-shiju.jose@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705123039.963781-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  10 ++
 hw/cxl/cxl-mailbox-utils.c  | 258 ++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cc98553583..48ed0d9240 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -464,6 +464,14 @@ typedef struct CXLDCRegion {
     unsigned long *blk_bitmap;
 } CXLDCRegion;
 
+typedef struct CXLSetFeatureInfo {
+    QemuUUID uuid;
+    uint8_t data_transfer_flag;
+    bool data_saved_across_reset;
+    uint16_t data_offset;
+    size_t data_size;
+} CXLSetFeatureInfo;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -501,6 +509,8 @@ struct CXLType3Dev {
     CXLPoisonList scan_media_results;
     bool scan_media_hasrun;
 
+    CXLSetFeatureInfo set_feat_info;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dbaa83a110..7b7d8e5eae 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -69,6 +69,10 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -767,6 +771,248 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.6: Features */
+/*
+ * Get Supported Features output payload
+ * CXL r3.1 section 8.2.9.6.1 Table 8-96
+ */
+typedef struct CXLSupportedFeatureHeader {
+    uint16_t entries;
+    uint16_t nsuppfeats_dev;
+    uint32_t reserved;
+} QEMU_PACKED CXLSupportedFeatureHeader;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL r3.1 section 8.2.9.6.1 Table 8-97
+ */
+typedef struct CXLSupportedFeatureEntry {
+    QemuUUID uuid;
+    uint16_t feat_index;
+    uint16_t get_feat_size;
+    uint16_t set_feat_size;
+    uint32_t attr_flags;
+    uint8_t get_feat_version;
+    uint8_t set_feat_version;
+    uint16_t set_feat_effects;
+    uint8_t rsvd[18];
+} QEMU_PACKED CXLSupportedFeatureEntry;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
+ */
+/* Supported Feature Entry : attribute flags */
+#define CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE BIT(0)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_DEEPEST_RESET_PERSISTENCE_MASK GENMASK(3, 1)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE BIT(4)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION BIT(5)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SELECTION BIT(6)
+
+/* Supported Feature Entry : set feature effects */
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_COLD_RESET BIT(0)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE BIT(1)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_DATA_CHANGE BIT(2)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_POLICY_CHANGE BIT(3)
+#define CXL_FEAT_ENTRY_SFE_IMMEDIATE_LOG_CHANGE BIT(4)
+#define CXL_FEAT_ENTRY_SFE_SECURITY_STATE_CHANGE BIT(5)
+#define CXL_FEAT_ENTRY_SFE_BACKGROUND_OPERATION BIT(6)
+#define CXL_FEAT_ENTRY_SFE_SUPPORT_SECONDARY_MAILBOX BIT(7)
+#define CXL_FEAT_ENTRY_SFE_SUPPORT_ABORT_BACKGROUND_OPERATION BIT(8)
+#define CXL_FEAT_ENTRY_SFE_CEL_VALID BIT(9)
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CONV_RESET BIT(10)
+#define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CXL_RESET BIT(11)
+
+enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_MAX
+};
+
+/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL r3.1 section 8.2.9.6.2 Table 8-99
+ */
+/* Get Feature : Payload in selection */
+enum CXL_GET_FEATURE_SELECTION {
+    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
+    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
+    CXL_GET_FEATURE_SEL_SAVED_VALUE,
+    CXL_GET_FEATURE_SEL_MAX
+};
+
+/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL r3.1 section 8.2.9.6.3 Table 8-101
+ */
+typedef struct CXLSetFeatureInHeader {
+        QemuUUID uuid;
+        uint32_t flags;
+        uint16_t offset;
+        uint8_t version;
+        uint8_t rsvd[9];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
+
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
+enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
+    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
+};
+#define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
+
+/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
+static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint32_t count;
+        uint16_t start_index;
+        uint16_t reserved;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
+
+    struct {
+        CXLSupportedFeatureHeader hdr;
+        CXLSupportedFeatureEntry feat_entries[];
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
+    uint16_t index, req_entries;
+    uint16_t entry;
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
+        /*
+         * Temporary: suppress compiler error due to unsigned
+         * comparioson to zero.
+         */
+        true /*get_feats_in->start_index >= CXL_FEATURE_MAX*/) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    req_entries = (get_feats_in->count -
+                   sizeof(CXLSupportedFeatureHeader)) /
+                   sizeof(CXLSupportedFeatureEntry);
+    req_entries = MIN(req_entries,
+                      (CXL_FEATURE_MAX - get_feats_in->start_index));
+
+    for (entry = 0, index = get_feats_in->start_index;
+         entry < req_entries; index++) {
+        switch (index) {
+        default:
+            __builtin_unreachable();
+        }
+    }
+    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
+    get_feats_out->hdr.entries = req_entries;
+    *len_out = sizeof(CXLSupportedFeatureHeader) +
+                      req_entries * sizeof(CXLSupportedFeatureEntry);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
+static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    struct {
+        QemuUUID uuid;
+        uint16_t offset;
+        uint16_t count;
+        uint8_t selection;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
+    uint16_t bytes_to_copy = 0;
+    CXLType3Dev *ct3d;
+    CXLSetFeatureInfo *set_feat_info;
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    ct3d = CXL_TYPE3(cci->d);
+    get_feature = (void *)payload_in;
+
+    set_feat_info = &ct3d->set_feat_info;
+    if (qemu_uuid_is_equal(&get_feature->uuid, &set_feat_info->uuid)) {
+        return CXL_MBOX_FEATURE_TRANSFER_IN_PROGRESS;
+    }
+
+    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feature->offset + get_feature->count > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len_out = bytes_to_copy;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
+static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
+    CXLSetFeatureInfo *set_feat_info;
+    uint8_t data_transfer_flag;
+    CXLType3Dev *ct3d;
+
+
+    if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    ct3d = CXL_TYPE3(cci->d);
+    set_feat_info = &ct3d->set_feat_info;
+
+    if (!qemu_uuid_is_null(&set_feat_info->uuid) &&
+        !qemu_uuid_is_equal(&hdr->uuid, &set_feat_info->uuid)) {
+        return CXL_MBOX_FEATURE_TRANSFER_IN_PROGRESS;
+    }
+    if (hdr->flags & CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET) {
+        set_feat_info->data_saved_across_reset = true;
+    } else {
+        set_feat_info->data_saved_across_reset = false;
+    }
+
+    data_transfer_flag =
+              hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK;
+    if (data_transfer_flag == CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER) {
+        set_feat_info->uuid = hdr->uuid;
+        set_feat_info->data_size = 0;
+    }
+    set_feat_info->data_transfer_flag = data_transfer_flag;
+    set_feat_info->data_offset = hdr->offset;
+
+    if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+        data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER ||
+        data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
+        memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
+        set_feat_info->data_transfer_flag = 0;
+        set_feat_info->data_saved_across_reset = false;
+        set_feat_info->data_offset = 0;
+        set_feat_info->data_size = 0;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -2114,6 +2360,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
+                                  cmd_features_get_supported, 0x8, 0 },
+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
+                                cmd_features_get_feature, 0x15, 0 },
+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
+                                cmd_features_set_feature,
+                                ~0,
+                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
-- 
MST


