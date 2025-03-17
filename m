Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6602BC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS4-0007Wq-Tq; Mon, 17 Mar 2025 15:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZf-0003f5-Af
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZV-0001Gv-Do
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22401f4d35aso86774395ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229848; x=1742834648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeD8bm35WueORl8KNXonDwF4c8bIUJRaJ8sV3CTjwqM=;
 b=S/Usznr1xGuBWaLju3AfaMyZjIgpxihnH9Q74DYdJ9HfE0P5zCEhjC04KWbywdz6QB
 3IJC9rYU4KBwX0LmFOizbGkPIpjcdIP55jf5nDobl92hk7KwGLV7O6eEBdydXG478y/D
 PSoMCpyYKPM9UqrSJSpBQtYRs3u0msf+3E4nfWQzaMO4rMyjVDB4JRYmB5rKrjBr6EM9
 5BQe3qH0rSgr447aFukk/33QKq2THYtRBqEemXBtKgqU/BBvHwUzZnvClE8ZZ2dZu2eJ
 sDCr5oh/7hTMXFmuph/pnJGXTvVmiKkGVPCWmC/lg7aPtZwfN6VQQVwFDwc0lRJjqUs0
 mo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229848; x=1742834648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeD8bm35WueORl8KNXonDwF4c8bIUJRaJ8sV3CTjwqM=;
 b=ecqEcq9g7Fkc1iPNvREVEWVTurfbkAgqNp+B+xBFxAlphZlsTzI3Ghia6Lup/sinEO
 dbvYWR9Ffwo6KwE92r31P2Kij5Td1gwzaf+MChbJIKqbLScKPlCAs/gE/yuT2dft4wZL
 x+SR93UhZxqqesaP65xob+GZSyNV/7Aetdtqyw9k3iZPXmAr0FSkcm4w8XcCR8BI8hRZ
 F00uq+DPXPmfRDQXUFeEGobkgKnG+hWZAwfXDy8RMgoyacmOGj+a2i3g3NYBdRT3iPnp
 lf5JcmqiahPw3hs7jBzYggfNaGXC/w9RBkXLlxoNfNzM7Er/gQKzyjRewqNLpQwuxWPZ
 VVfA==
X-Gm-Message-State: AOJu0YzKk/tfgBEVlMUlZogOwVzAS+TvBJ22jM70YxPl0EvrkdfLP4hu
 OK6Kt1/2JQx3m08zvgYptnNQu8yuu8qqEGHnMnZnnPbhUCQ1gPxfDKM2gw==
X-Gm-Gg: ASbGnctZIRnSi907wDSdMRGkpKxSWC1zskT+7+4++tG1zGcEdPXGSWzXda6Yu3BoSx3
 dCvw15IzfMFukGK5QDZaQvAFRpjpmzu8l9fDSPIZkmVyfhYsjQ9nzr84C1iHjDIakQXR+60IRm6
 cQJx311fc4ZrLu9No0bYPlaAnM2MDQu7bdF2N0iMczz5AErqGhOPhfeu7pZHqjnyJUdQTQHino6
 qc1aHAjtaH20ZOOmYqCu1rnW6rfY59/5rZIkIbz8v/UrhAz8iMM2kQJ8x/e6V0UXhpLJU1gK4UJ
 M0wBEf0Y2g5Cl9GDJYzSg0BRtD4qFXB7lOeNPQz5qsfktziD6SWCEESboIudjxYt2g==
X-Google-Smtp-Source: AGHT+IG0XeoWDYSAWB21haDmsMHHN7vfotQour+vtP/CxU8L4xDi/z4qMOAZA355+nOAzMAQY9rxlA==
X-Received: by 2002:a17:903:188:b0:224:1d1c:8837 with SMTP id
 d9443c01a7336-2262c554bc8mr2540105ad.19.1742229848165; 
 Mon, 17 Mar 2025 09:44:08 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:44:07 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Date: Mon, 17 Mar 2025 16:31:35 +0000
Message-ID: <20250317164204.2299371-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:34 -0400
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 173 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +-
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 181 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 77cf0fdb15..5bcbd434b7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -127,6 +127,8 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
+        #define INITIATE_DC_ADD           0x4
+
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3669,6 +3671,170 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
+                                                        uint16_t host_id,
+                                                        uint32_t ext_count,
+                                                        CXLDCExtentRaw extents[],
+                                                        CXLDCEventType type)
+{
+    CXLDCExtentRaw ext;
+    CXLDCRegion *reg = NULL;
+    int i, j;
+
+    if (dcd->dc.num_regions == 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "No dynamic capacity support from the device.\n");
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* TODO: host id check will be added later, currently host id must be 0. */
+    if (host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    for (i = 0; i < ext_count; i++) {
+        ext = extents[i];
+
+        if (ext.len == 0) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
+        if (!reg) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        /* Check requested extents do not overlap with each other. */
+        for (j = i + 1; j < ext_count; j++) {
+            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
+                               extents[j].len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            /* Check requested extents do not overlap with existing extents. */
+            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
+                                               ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h)
+ */
+static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t selection_policy;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
+    CXLEventDynamicCapacity event_rec = {};
+    CXLDCExtentGroup *group = NULL;
+    CXLDCExtentRaw ext;
+    int rc, i;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents causes exceeding device's extent tracking ability. */
+        if (in->ext_count + ct3d->dc.total_extent_count >
+            CXL_NUM_EXTENTS_SUPPORTED) {
+            return CXL_MBOX_RESOURCES_EXHAUSTED;
+        }
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_ADD_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+
+        /* Prepare extents for Event Record */
+        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
+        for (i = 0; i < in->ext_count; i++) {
+            ext = in->extents[i];
+            event_rec_exts[i].start_dpa = ext.start_dpa;
+            event_rec_exts[i].len = ext.len;
+            memset(event_rec_exts[i].tag, 0, 0x10);
+            event_rec_exts[i].shared_seq = 0;
+
+            /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                     ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+
+            /* Create extent group to add to pending list. */
+            group = cxl_insert_extent_to_extent_group(group,
+                                                      event_rec_exts[i].start_dpa,
+                                                      event_rec_exts[i].len,
+                                                      event_rec_exts[i].tag,
+                                                      event_rec_exts[i].shared_seq);
+        }
+
+        /* Add requested extents to pending list. */
+        if (group) {
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+        }
+
+        /* Create event record and insert to event log */
+        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+        event_rec.type = DC_EVENT_ADD_CAPACITY;
+        /* FIXME: for now, validity flag is cleared */
+        event_rec.validity_flags = 0;
+        /* FIXME: Currently only support 1 host */
+        event_rec.host_id = 0;
+        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
+        event_rec.updated_region_id = 0;
+        for (i = 0; i < in->ext_count; i++) {
+            memcpy(&event_rec.dynamic_capacity_extent,
+                   &event_rec_exts[i],
+                   sizeof(CXLDCExtentRaw));
+
+            event_rec.flags = 0;
+            if (i < in->ext_count - 1) {
+                /* Set "More" flag */
+                event_rec.flags |= BIT(0);
+            }
+
+            if (cxl_event_insert(&ct3d->cxl_dstate,
+                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
+                                 (CXLEventRecordRaw *)&event_rec)) {
+                cxl_event_irq_assert(ct3d);
+            }
+        }
+
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0},
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b742b2bb8d..ccc619fe10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
  * the list.
  * Return value: return true if has overlaps; otherwise, return false
  */
-static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
-                                           uint64_t dpa, uint64_t len)
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
     Range range1, range2;
@@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 217003a29d..1d5831a0b6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
-- 
2.47.2


