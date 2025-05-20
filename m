Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4390EC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHT6G-0001ho-HM; Tue, 20 May 2025 15:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHT6E-0001he-8x
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:58:06 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHT67-0007Kr-Ob
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:58:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73972a54919so5683618b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747771076; x=1748375876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mxu7EAKjxOL/jRlNPWnc2FmXYmyv4DcFiIfRobuMjWM=;
 b=C+584C8BNngbUp6Q6cwOWkZkDvuilcFJAoKk5qoOAXgbiJ6E7SbQl9cr5GRzQSidiV
 z1HCw2T0t+sctLJuSUfnkOj/dxYFBbBVzqHqmk5kdVV8M5xTA9c6+SvMio1Ai2+JI+Bw
 IPEDnJ6WTb9GGVAP/El1xrU7BhCpXioB2eAESmIWKl0qkWd7BT1kwOvwFUHca3HUvO6/
 7P7oqb2ZzKBWMaCewEgZBOZT2HpTOL9VhXUCYgOc+AOIqUxQAn31YsbfkM8pwZ3gKDCV
 thvEw8oNJKgj1Qd7DxJK4ckX7iwZXTkLZsDjpkPNQVBDZ9Ib3baQDzqJKObwuCgUdMm2
 2A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747771076; x=1748375876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxu7EAKjxOL/jRlNPWnc2FmXYmyv4DcFiIfRobuMjWM=;
 b=OytEiIxGnZ14y+j7FpCyZG2gr/QenMkMCgQuLE72ioYZD3r8RK0K3w+8YE/P5BSM1q
 cPyqGSeeL7RfVdvbDx7jjfC+6q21N1tHS22FEU/TgWDN2cnF8NqNyV2/ue1ADdn654ov
 u0498ttJbObW2ahZ8Z5CAepLX+VzV4U0EiQVdsPtwmgb8dkdgQiRYB8b1Wx6fJxsOWBf
 6MTgH9PG+agkvjRzUKb72LY3bjzOy0xcunXQOHuNQIFhdAj15bzpdN2pxqjg70a1OLxP
 7mPRJy+F1k7khTjErTm6Z1evRptsNtl6NbJNvvyZicoPdkHqRr1eWpjizrvYwF8M+PNu
 NpDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8kDTM9qOd1o4yY6iygB11IIO7/IAUW8+FYGE4IDa7nC1HdpNlgVUzcYBlscCnzJnr+GjXQgWVJDeW@nongnu.org
X-Gm-Message-State: AOJu0Yzu8uJXrLdpLlTdN8VXLQ0axgbBxXUyLoEnX7y4DOyVNWp8C7Id
 vGzj+hWB9jbOAjeouTX58mN6dvZy2VtBkC73b9akFH6ZP9MdQsLFSL0l
X-Gm-Gg: ASbGncvKVTVtRlFz4KKM03ClHFeTSMI3XLrQNjpz4IF/3MRYItxs40uX3f6Y3CmyeXy
 rZCYdBVeMZTnkrOiX3viNKAYRO5S+bScQhc7SpJt2aiTKItwDpm6a0kVN3DHjtkW5+ehaHbSRYD
 Qnd1GB9J36V0/clAj/GjuVGiGChESyw8BMh8JHiv6GcW1v5/48CQAf9TzWMPnlpAe5d+B81tbJM
 Qgzr7WDmSXy/joQaQGSRGqJuKEuS1HFOkSVH5C93ZLEcFBt8JSZG1uw0MXDkNoN7w8oDGmeNK59
 Q+R9rBFbBZY3+APpcf2tABOFNFcV1XTVpIV9I9kO92O3Mx1gFx13w+KWKqgylCEpKkYw
X-Google-Smtp-Source: AGHT+IHVgoS/GUrv4eXd7c/tYQixcYyqNwUlmHsqZpaOzi2Jukxs0vecZkBbaB+DbCsJDFN5uiXTyw==
X-Received: by 2002:a05:6a21:9183:b0:1fe:5e67:21af with SMTP id
 adf61e73a8af0-216219d18e0mr29653558637.30.1747771076060; 
 Tue, 20 May 2025 12:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb0843d1sm8458531a12.49.2025.05.20.12.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 12:57:55 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan.cxl@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] hw/cxl: fix DC extent capacity tracking
Date: Tue, 20 May 2025 12:56:43 -0700
Message-ID: <20250520195741.789841-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
extents in different states including added, pending, etc.

Before the change, for the in-device extent number tracking purpose, we only
have "total_extent_count" defined, which only tracks the number of
extents accepted. However, we need to track number of extents in other
states also, for now it is extents pending-to-add.

To fix that, we introduce a new counter for dynamic capacity
"nr_extents_accepted" which explicitly tracks number of the extents
accepted by the hosts, and fix "total_extent_count" to include
both accepted and pending extents counting.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  3 ++-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 299f232f26..0b615ea37a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     uint16_t out_pl_len, size;
     CXLDCExtent *ent;
 
-    if (start_extent_id > ct3d->dc.total_extent_count) {
+    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
 
     stl_le_p(&out->count, record_count);
-    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
     stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
 
     if (record_count > 0) {
@@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
     QTAILQ_INSERT_TAIL(list, group, node);
 }
 
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+    uint32_t extents_deleted = 0;
 
     QTAILQ_REMOVE(list, group, node);
     QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
         cxl_remove_extent_from_extent_list(&group->list, ent);
+        extents_deleted++;
     }
     g_free(group);
+
+    return extents_deleted;
 }
 
 /*
@@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
-    uint32_t i;
+    uint32_t i, num;
     uint64_t dpa, len;
     CXLRetCode ret;
 
@@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     }
 
     if (in->num_entries_updated == 0) {
-        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        ct3d->dc.total_extent_count -= num;
         return CXL_MBOX_SUCCESS;
     }
 
@@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
-    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    ct3d->dc.total_extent_count -= num;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -3160,7 +3167,7 @@ free_and_exit:
         }
         *updated_list_size = 0;
     } else {
-        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
+        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
     }
 
     return ret;
@@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
-    ct3d->dc.total_extent_count = updated_list_size;
+    ct3d->dc.total_extent_count += (updated_list_size -
+                                    ct3d->dc.nr_extents_accepted);
+
+    ct3d->dc.nr_extents_accepted = updated_list_size;
 
     return CXL_MBOX_SUCCESS;
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 94e7274912..f283178d88 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
     if (group) {
         cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
+        dcd->dc.total_extent_count += num_extents;
     }
 
     /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ed6cd50c67..a151e19da8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ struct CXLType3Dev {
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
+        uint32_t nr_extents_accepted;
         uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
@@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint16_t shared_seq);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
 void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                  uint64_t len);
 void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
-- 
2.47.2


