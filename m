Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D6DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgk1-0003ie-2H; Sun, 21 Jul 2024 20:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjz-0003bi-Ah
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgjx-0005ky-9I
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6a6rs+lqNePMYg6fXsfNOdsN7cy/NFFK4flSLPM9E4=;
 b=KI89CDbYnmq8TV8VDwft3+PVYryTSll4mPD/N1geAqRKFq/quSMDRdEdF6jYMqgnVyCM8l
 gJIY9dUojJXz21d2jkM2xpC59j5GykGCJVplhrRT+3cjLxKvRztGz/10+Wvl+8M5fi3PJU
 j0rQbQ508tBbl2nS6d1XHLjC21E22pM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-WRKLpZpAMtSOfUyM7xTqCw-1; Sun, 21 Jul 2024 20:17:18 -0400
X-MC-Unique: WRKLpZpAMtSOfUyM7xTqCw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so398177f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607437; x=1722212237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6a6rs+lqNePMYg6fXsfNOdsN7cy/NFFK4flSLPM9E4=;
 b=eBeLEXpR7IPSle6i3PT6EjqWFqMSV8eq+/bP8t8hOZSEhsmLqX448zuAKfhaRK5nvo
 5UZivtwbQtUtCpKLTQFnmpJIGND8L8+Lqf1CJVYB66Rd+JCFGBOQJAGD9ZjjlJzincnW
 FTnHYjubRXElUOaLVRds4uvz67uOcNRtLkazf4qh2OzcDaZbSmVBloKoHCYxtgy15MFy
 h9sDhPHtDyNHRQjYPo/bDW3VDRr+1lPNPvRQQMGbq3VKuOmpB9cZD2pi7IFARA2KgTeU
 dLR0R1BDVXuIOmbjgDU9RbHMFnXmxzDqVVjazfkzP+IsYIruPwA17CAkVjGWLUvVPFE5
 V38g==
X-Gm-Message-State: AOJu0YwP4nDXm1jd6SJkppWKo+pHWiKx9E3ALJK3PVvYamu1WnVo4WTV
 +d3ksL1+ZIZBpyAp8ga0lJcMF68o20Vi7sw9S8S3/rkAb3XvKaKkVvIsb1U43wT8QgAVUzncZuo
 xIUdExqjFCM4P8sxx9eIC6gmBPKU7pGhJxuYS8MRg8FNYFmfpQL4kTpTYJWXCbKqXn58GMejWO/
 Ez2Xt5Y0ebz0xkQjSGGX/Po9pXh/pIYA==
X-Received: by 2002:a5d:4a0c:0:b0:368:3b89:df1d with SMTP id
 ffacd0b85a97d-36873f18e6cmr5923451f8f.22.1721607436719; 
 Sun, 21 Jul 2024 17:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVxRluhAq5w9MJ1JKYm94mQQlhyPAOoginULAlcRF/enWH0o2SP1ntbXkKlQwPvrP89UO5Bg==
X-Received: by 2002:a5d:4a0c:0:b0:368:3b89:df1d with SMTP id
 ffacd0b85a97d-36873f18e6cmr5923436f8f.22.1721607436088; 
 Sun, 21 Jul 2024 17:17:16 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm107390905e9.10.2024.07.21.17.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:15 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 12/63] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <d88f667414106c7216485774293d0831c2482d20.1721607331.git.mst@redhat.com>
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

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle. The patrol scrub control allows the request to
configure patrol scrub input configurations.

The patrol scrub control allows the requester to specify the number of
hours for which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Link: https://lore.kernel.org/r/20240223085902.1549-3-shiju.jose@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705123039.963781-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 24 +++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 79 ++++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3.c          |  9 +++++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 48ed0d9240..2c1df25453 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -427,6 +427,26 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+/* CXL memory device patrol scrub control attributes */
+typedef struct CXLMemPatrolScrubReadAttrs {
+        uint8_t scrub_cycle_cap;
+        uint16_t scrub_cycle;
+        uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubReadAttrs;
+
+typedef struct CXLMemPatrolScrubWriteAttrs {
+    uint8_t scrub_cycle_hr;
+    uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubWriteAttrs;
+
+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -511,6 +531,10 @@ struct CXLType3Dev {
 
     CXLSetFeatureInfo set_feat_info;
 
+    /* Patrol scrub control attributes */
+    CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
+    CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7b7d8e5eae..485beb9dba 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -824,6 +824,7 @@ typedef struct CXLSupportedFeatureEntry {
 #define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CXL_RESET BIT(11)
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_MAX
 };
 
@@ -865,6 +866,17 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
 };
 #define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
 
+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
+static const QemuUUID patrol_scrub_uuid = {
+    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
+};
+
+typedef struct CXLMemPatrolScrubSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemPatrolScrubWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -890,11 +902,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
         return CXL_MBOX_UNSUPPORTED;
     }
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        /*
-         * Temporary: suppress compiler error due to unsigned
-         * comparioson to zero.
-         */
-        true /*get_feats_in->start_index >= CXL_FEATURE_MAX*/) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -907,6 +915,21 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     for (entry = 0, index = get_feats_in->start_index;
          entry < req_entries; index++) {
         switch (index) {
+        case  CXL_FEATURE_PATROL_SCRUB:
+            /* Fill supported feature entry for device patrol scrub control */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = patrol_scrub_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemPatrolScrubReadAttrs),
+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -956,6 +979,20 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemPatrolScrubReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemPatrolScrubReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -970,7 +1007,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            CXLCCI *cci)
 {
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
+    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
+    CXLMemPatrolScrubSetFeature *ps_set_feature;
     CXLSetFeatureInfo *set_feat_info;
+    uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
 
@@ -999,11 +1039,40 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     }
     set_feat_info->data_transfer_flag = data_transfer_flag;
     set_feat_info->data_offset = hdr->offset;
+    bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
+
+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ps_set_feature = (void *)payload_in;
+        ps_write_attrs = &ps_set_feature->feat_data;
+        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
+               ps_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->patrol_scrub_attrs.scrub_cycle &= ~0xFF;
+            ct3d->patrol_scrub_attrs.scrub_cycle |=
+                          ct3d->patrol_scrub_wr_attrs.scrub_cycle_hr & 0xFF;
+            ct3d->patrol_scrub_attrs.scrub_flags &= ~0x1;
+            ct3d->patrol_scrub_attrs.scrub_flags |=
+                          ct3d->patrol_scrub_wr_attrs.scrub_flags & 0x1;
+        }
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
 
     if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
+        if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+            memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+        }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
         set_feat_info->data_offset = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c7910687ae..7c583d80f5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -908,6 +908,15 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
     cxl_event_init(&ct3d->cxl_dstate, 2);
 
+    /* Set default value for patrol scrub attributes */
+    ct3d->patrol_scrub_attrs.scrub_cycle_cap =
+                           CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
+                           CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
+    ct3d->patrol_scrub_attrs.scrub_cycle =
+                           CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
+                           (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
+    ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
+
     return;
 
 err_release_cdat:
-- 
MST


