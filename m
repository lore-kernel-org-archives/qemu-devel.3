Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D854BC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5N-0006QY-9m; Thu, 26 Jun 2025 18:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5I-0006ON-3R
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv57-0000u9-VZ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-236377f00a1so18307475ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976910; x=1751581710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0+GG0gjJCw7pfb+JxSIZ+IHUVC7BruErkqzXq+9RoU=;
 b=cywpy7/KNU2ZsL69cIxb0a58p7Byy715ZS9GXrRmlMMIo3qUy7qtnKuWxKHOsE6fPO
 nNGCgt++uT1ch4XlfljjKma87tMlNyak5xSq+1bgHHZBl9XDeU+CvYgnzsYcYsRAtlUX
 bJsHb7QcxgCpenjRP22rXkprgBGtzlPmzlGW7nF5HKoQwBfu9aJptVeKnGQAIacr6RSf
 f4qUBIAzs0gDiamg3W5nysVnkmqu8RkoLu0k2zgkIzAT9ozuTQdN0xMk+aci6NWxUfe6
 obwF9/2USY1L0ooSNUTBXKpnULc7KByfebdSmImLs/E1zSJNMjIt4CLdLJ22C5Z+JXfc
 z0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976910; x=1751581710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0+GG0gjJCw7pfb+JxSIZ+IHUVC7BruErkqzXq+9RoU=;
 b=hQ7qG9N3EQYeJK5eZJyZlfYnl/rgaFZuXKHKHnmbWid7i7y7cnDt7fakqHpi06STcd
 XibuUBqsKtfxZ6R9luZKFYLRa3iuoVcDg5JU6fi6daQs/1N1vVOeO8/vDTVHcbfARjw5
 w35wvlcdLGyszJOk8jovvXaFtMEgziiYZAfve8CS36nuCy4Y9UYtA+CYTeMx3O772Rfg
 gXXUsxXGnTYcMmaEkhJeJAncPqCtGYeBMQ3z4ImQeqweaV3ob5HFF0C7l1Y4EJESo9hd
 Naeo3UZRcoGbfDjXKU8xlMZMjlV043ndy2uFVF01TByfZP9Aj1ou85KsX8/jNCMgKQx1
 6aYA==
X-Gm-Message-State: AOJu0YzQpCiYYMg8mjQVbgkgSy7bhSteqF7htlEdY0cRh2PfgqR21B+2
 FTeRLLmTyrEC8NpRQSdu3lzwnM3Zqxp5iYcQpFFJAsJQwFZCITeKc9Lug8pb6g==
X-Gm-Gg: ASbGncsxRbMiwCnq02k4eQVYGWkoK7PBKX715+yrLY8O6W2oZyYvcQy9T4LUsxhvZJt
 nBBJ0jutsCrfn27gJ+eF2pxdBbWDTYqhGbzZOcs8vnaAjJxwxUEOYLXAiSMbs1Cx1fwywTYg0w8
 yISHV/syBNMReiDHvlRy7sZxXTYxYFgkUxC/chwEXby5o0lg3gjAoKkdUY3oJBMcbVXt3k351oI
 9QFvGg/0dabhzHdoYK6Wfg0webGDR3kKrrECBlNKmVb/BkdGCt+b9EUG4CXTd2soMeopKQL8jMC
 CAdmukTUF7vpwR6VC25jMblxq1B+5y/lzJM0GNFqBtPEmWmJIq2LCzTsARpHlEjThLdKg+oj0vu
 6hHw0OKXVzlfQh2C+WA==
X-Google-Smtp-Source: AGHT+IGb7C9jfd9dLU4Z2QTBlI1DepmvSTcctPfgZhCBugJCbUg3ZaVrc15bUxaL4S6DLsL6lJyw+Q==
X-Received: by 2002:a17:902:e5c9:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-23ac4633b92mr13533185ad.32.1750976909974; 
 Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC
 Add
Date: Thu, 26 Jun 2025 22:23:32 +0000
Message-ID: <20250626222743.1766404-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 106 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +--
 include/hw/cxl/cxl_device.h |   4 ++
 3 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 382c41c025..787eeaa7b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3539,6 +3540,104 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() function which accepts
+ * CXLUpdateDCExtentListInPl as a parameter.
+ */
+static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
+                                CXLUpdateDCExtentListInPl *extent_list,
+                                int count)
+{
+    int i;
+
+    extent_list->num_entries_updated = count;
+
+    for (i = 0; i < count; i++) {
+        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
+        extent_list->updated_entries[i].len = raw_extents[i].len;
+    }
+}
+
+/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
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
+    int i, rc;
+
+    switch (in->selection_policy) {
+        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
+            /* Adding extents exceeds device's extent tracking ability. */
+            if (in->ext_count + ct3d->dc.total_extent_count >
+                CXL_NUM_EXTENTS_SUPPORTED) {
+                return CXL_MBOX_RESOURCES_EXHAUSTED;
+            }
+
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw ext = in->extents[i];
+                /* Check requested extents do not overlap with pending extents. */
+                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                         ext.start_dpa, ext.len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+                /* Check requested extents do not overlap with existing extents. */
+                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                                   ext.start_dpa, ext.len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+            }
+
+            if (rc) {
+                return rc;
+            }
+
+            CXLDCExtentGroup *group = NULL;
+            for (i = 0; i < in->ext_count; i++) {
+                group = cxl_insert_extent_to_extent_group(group,
+                                                          in->extents[i].start_dpa,
+                                                          in->extents[i].len,
+                                                          in->extents[i].tag,
+                                                          in->extents[i].shared_seq);
+            }
+
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+            ct3d->dc.total_extent_count += in->ext_count;
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_ADD_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                          "CXL extent selection policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3666,6 +3765,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0 },
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9c2b9d197b..7676d785c2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
@@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 91ec1ba299..7be68d98c6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -736,4 +736,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
                                              uint32_t ext_count);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
-- 
2.47.2


