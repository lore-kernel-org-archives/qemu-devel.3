Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9455DC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taxsb-0001TI-Gp; Thu, 23 Jan 2025 09:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB8-0002QW-KL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB5-00054s-Qg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250123055452epoutp02b5d3ff0552ec005a06d487788637fcec~dPKDMalWR0338403384epoutp02q
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 05:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250123055452epoutp02b5d3ff0552ec005a06d487788637fcec~dPKDMalWR0338403384epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1737611692;
 bh=RUXaewyFwLIJcZ4QUgVMzV1AEtjgB0IadrAPd1N60FU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l01kKMMsqNOXxQB2rwFRABfzvwA89Nysj74FlgCjDfa6pRFgtz6/buVxkO2wLgctk
 FtDO4S2DPRmYi16NUZ2ftkn3UkmWuRqmz6HyJxygUMjVD/J7xelAqadsZoyGFjdt2e
 ShKkwxHNsT0TAlOCMgkydEnEAzGaAb12u1G3pzzg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20250123055452epcas5p3f49bf86d77c3339bce356ff5cba6dfc4~dPKC3JyME0460704607epcas5p3K;
 Thu, 23 Jan 2025 05:54:52 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YdqsQ0xwDz4x9Pp; Thu, 23 Jan
 2025 05:54:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.9A.29212.8A9D1976; Thu, 23 Jan 2025 14:54:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2~dOiMsc0tB2285122851epcas5p4M;
 Thu, 23 Jan 2025 05:09:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250123050913epsmtrp1d6e95b29596f7f348f52a5e4f788504f~dOiMrxThM0313303133epsmtrp1j;
 Thu, 23 Jan 2025 05:09:13 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-76-6791d9a87b11
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 41.7F.18729.9FEC1976; Thu, 23 Jan 2025 14:09:13 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250123050912epsmtip1403d70645c4cf5a6e74b72e880855673~dOiLjhr292475324753epsmtip1R;
 Thu, 23 Jan 2025 05:09:12 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: krish.reddy@samsung.com, vishak.g@samsung.com, a.manzanares@samsung.com,
 alok.rathore@samsung.com, s5.kumari@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Date: Thu, 23 Jan 2025 10:39:03 +0530
Message-Id: <20250123050903.92336-3-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123050903.92336-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTXXfFzYnpBrvPC1lMP6xo8eX0HjaL
 hRuXMVkc793BYrHm3GcWixMnt7NbnJ81h92B3ePJtc1MHn1bVjEGMEVl22SkJqakFimk5iXn
 p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp29kU
 5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfcmzaVpeBKcMWlTXwN
 jN1WXYycHBICJhKPLy5j7WLk4hAS2MMosWPBBWYI5xOjxId1W9ghnG+MErPnLmWFaVn8bx5U
 Yi+jxPS+E0wQTgOTxJvNU9lAqtgEDCQeNB9nB7FFBCQlfnedZgaxmQXWMEpsWyIPYgsLNDJK
 nLnJBWKzCKhKzPnczQRi8wpYS0w7vIYdYpu8xP6DZ8F6OQVsJI5tesMIUSMocXLmExaImfIS
 zVtng90tIXCJXeLG3jVQp7pIbNj4iBnCFpZ4dXwL1FApiZf9bVB2scS5i58YIewaidddK6Dq
 7SVaT/UD2RxACzQl1u/ShwjLSkw9tY4JYi+fRO/vJ0wQcV6JHfNAbA4gW0Vi6dtMmE1fnjVD
 TfeQmLN3HTTg+hklPn+cxDSBUWEWkndmIXlnFsLmBYzMqxilUguKc9NTk00LDHXzUsvhsZyc
 n7uJEZwWtQJ2MK7e8FfvECMTB+MhRgkOZiUR3v9PJqQL8aYkVlalFuXHF5XmpBYfYjQFBvhE
 ZinR5HxgYs4riTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp1cDUfdM+
 yqN86SKL+Qq7b0VsuOtlkWzy/eTP6+dbZL58EOS4MFFDNWjCr8ltcnsVjZNOX9GurDRNUZO1
 Kd8yZYnenVoOoUrv2+Hmx2/vqa5fabz+WkTEoyV7739p7QvfzXeE98SPSsnH6vPq6i+vyC08
 KTmxeldDznGODSvvXHQ6MWWSeSdHfmf1mRMvAtL2y281Tlf68Gzi98p7Kvk5/uqXJzXylIXK
 PTQ67Ky6Ysoq14MX9ZselM3sP2KtcV33jEH33Poz3oX+Lm9OlB2bsfGBFEuZcVu26ulc3yUX
 rC7c6T7Lfu3QGfE/QRzn5y61z/WzcHyqxBP9WPTkeo3VyrOW3LX8XFba8WqPcWS/bOQ1JZbi
 jERDLeai4kQAKyNNDRQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO7PcxPTDZ4tMrKYfljR4svpPWwW
 CzcuY7I43ruDxWLNuc8sFidObme3OD9rDrsDu8eTa5uZPPq2rGIMYIrisklJzcksSy3St0vg
 yrg3bSpLwZXgikub+BoYu626GDk5JARMJBb/m8fexcjFISSwm1Hi/us+NoiElMSxnT+hbGGJ
 lf+eQxX9Y5R4cOkgK0iCTcBA4kHzcXYQW0RAUuJ312lmEJtZYBOjROs+PRBbWKBeYtLyWSwg
 NouAqsScz91MIDavgLXEtMNr2CEWyEvsP3gWrJdTwEbi2KY3jCC2EFDNz0lzWCHqBSVOznzC
 AjFfXqJ562zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERy2
 Wpo7GLev+qB3iJGJg/EQowQHs5II7/8nE9KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ84q/6E0R
 EkhPLEnNTk0tSC2CyTJxcEo1MJ0Ojsm4+PXszZ7TxQ5VfZc3/DKM+vUme9mmO14Va/4VZd9J
 PBZ6pUr2xevLimV3awVjWKrnWM3dyMuYZGJ8S8pagf372p1e7a26Bp8Vb89WW36uyvfChNnn
 71yq/csq9el9cbYef84njR0z2pfxnVa/E/o5e+eaT5M/K14qTb5zQ37jOY7cB8JMUw4mXhbt
 mn7hS9mDzzueGAgHRbyX2Dn3Xd3fqpnMy7afiZO2kmbOPJmgrXWjTL3/5v5t4UIvo/UvqUyT
 vfX39TUrw0nHVZ8Ez9ycoGrunTF/0haF3y9zDgbvPVn7tLdtQYFLh6VI/+G/DXWyjK8kLjxk
 2xL7tic+cu6UWwfnTORO7PAN3ZyhxFKckWioxVxUnAgAOjWKAMoCAAA=
X-CMS-MailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
 <CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=vinayak.kh@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jan 2025 09:08:19 -0500
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

    CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
    CXL devices supports media operations Sanitize and Write zero command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 217 ++++++++++++++++++++++++++++++++++--
 include/hw/cxl/cxl_device.h |  11 ++
 2 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2315d07fb1..89847ddd9d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1722,6 +1722,145 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+#define DPA_RANGE_GRANULARITY 64
+struct dpa_range_list_entry {
+    uint64_t starting_dpa;
+    uint64_t length;
+};
+
+static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
+                             size_t length)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
+    int rc = 0;
+
+    if ((dpa_addr % DPA_RANGE_GRANULARITY) ||
+         (length % DPA_RANGE_GRANULARITY)) {
+        return -EINVAL;
+    }
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(dc_mr);
+    }
+
+    if (!vmr && !pmr && !dc_mr) {
+        return -ENODEV;
+    }
+
+    if (dpa_addr >= vmr_size + pmr_size + dc_size ||
+        (dpa_addr + length) > vmr_size + pmr_size + dc_size) {
+        return -EINVAL;
+    }
+
+    if (dpa_addr > vmr_size + pmr_size) {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+    }
+
+
+    return rc;
+}
+
+static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
+                          uint8_t fill_value)
+{
+
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
+    AddressSpace *as = NULL;
+    MemTxAttrs mem_attrs = {0};
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+
+    if (dpa_addr < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_addr < vmr_size + pmr_size) {
+        as = &ct3d->hostpmem_as;
+    } else {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+        as = &ct3d->dc.host_dc_as;
+    }
+
+    return  address_space_set(as, dpa_addr,
+                              fill_value, length, mem_attrs);
+}
+
+/* Perform the actual device zeroing */
+static void __do_sanitize(CXLType3Dev *ct3d)
+{
+    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
+    int dpa_range_count = san_info->dpa_range_count;
+    int rc = 0;
+
+    for (int i = 0; i < dpa_range_count; i++) {
+        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
+                san_info->dpa_range_list[i].length, san_info->fill_value);
+        if (rc) {
+            goto exit;
+        }
+    }
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
+exit:
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+    return;
+}
+
+static int get_sanitize_duration(uint64_t total_mem)
+{
+    int secs = 0;
+
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    return secs;
+}
+
 enum {
     MEDIA_OP_GENERAL  = 0x0,
     MEDIA_OP_SANITIZE = 0x1,
@@ -1729,10 +1868,9 @@ enum {
 } MEDIA_OPERATION_CLASS;
 
 enum {
-    MEDIA_OP_SUB_DISCOVERY = 0x0,
-    MEDIA_OP_SUB_SANITIZE = 0x0,
-    MEDIA_OP_SUB_ZERO     = 0x1,
-    MEDIA_OP_SUB_CLASS_MAX
+    MEDIA_OP_GEN_DISCOVERY = 0x0,
+    MEDIA_OP_SAN_SANITIZE = 0x0,
+    MEDIA_OP_SAN_ZERO     = 0x1,
 } MEDIA_OPERATION_SUB_CLASS;
 
 struct media_op_supported_list_entry {
@@ -1777,9 +1915,14 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
     };
     } QEMU_PACKED *media_op_in_pl = (void *)payload_in;
 
+
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint8_t media_op_cl = media_op_in_pl->media_operation_class;
     uint8_t media_op_subclass = media_op_in_pl->media_operation_subclass;
     uint32_t dpa_range_count = media_op_in_pl->dpa_range_count;
+    uint8_t fill_value = 0;
+    uint64_t total_mem = 0;
+    int secs = 0;
 
     if (len_in < sizeof(*media_op_in_pl)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -1788,7 +1931,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
     switch (media_op_cl) {
     case MEDIA_OP_GENERAL:
         switch (media_op_subclass) {
-        case MEDIA_OP_SUB_DISCOVERY:
+        case MEDIA_OP_GEN_DISCOVERY:
             int count = 0;
             struct media_op_discovery_out_pl *media_out_pl =
                 (void *)payload_out;
@@ -1806,7 +1949,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
                 return CXL_MBOX_INVALID_INPUT;
             }
 
-            media_out_pl->dpa_range_granularity = CXL_CAPACITY_MULTIPLIER;
+            media_out_pl->dpa_range_granularity = DPA_RANGE_GRANULARITY;
             media_out_pl->total_supported_operations = MAX_SUPPORTED_OPS;
             if (num_ops > 0) {
                 for (int i = start_index; i < MAX_SUPPORTED_OPS; i++) {
@@ -1824,22 +1967,73 @@ disc_out:
             media_out_pl->num_of_supported_operations = count;
             *len_out = sizeof(struct media_op_discovery_out_pl) +
             (sizeof(struct media_op_supported_list_entry) * count);
-            break;
+            goto exit;
         default:
             return CXL_MBOX_UNSUPPORTED;
         }
         break;
     case MEDIA_OP_SANITIZE:
+    {
         switch (media_op_subclass) {
-
+        case MEDIA_OP_SAN_SANITIZE:
+            if (len_in < (sizeof(*media_op_in_pl) +
+                   (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
+                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+            }
+            fill_value = 0xF;
+            goto sanitize_range;
+        case MEDIA_OP_SAN_ZERO:
+            if (len_in < (sizeof(*media_op_in_pl) +
+                (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
+                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+            }
+            fill_value = 0;
+            goto sanitize_range;
         default:
             return CXL_MBOX_UNSUPPORTED;
         }
         break;
+    }
     default:
         return CXL_MBOX_UNSUPPORTED;
     }
 
+sanitize_range:
+    if (dpa_range_count > 0) {
+        for (int i = 0; i < dpa_range_count; i++) {
+            if (validate_dpa_addr(ct3d,
+                media_op_in_pl->dpa_range_list[i].starting_dpa,
+                media_op_in_pl->dpa_range_list[i].length)) {
+                return CXL_MBOX_INVALID_INPUT;
+            }
+            total_mem += media_op_in_pl->dpa_range_list[i].length;
+        }
+        ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
+                                  (dpa_range_count *
+                                  sizeof(struct dpa_range_list_entry)));
+
+        if (ct3d->media_op_sanitize) {
+            ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
+            ct3d->media_op_sanitize->fill_value = fill_value;
+            memcpy(ct3d->media_op_sanitize->dpa_range_list,
+                   media_op_in_pl->dpa_range_list,
+                   (dpa_range_count *
+                   sizeof(struct dpa_range_list_entry)));
+            secs = get_sanitize_duration(total_mem >> 20);
+            goto start_bg;
+        }
+    } else if (dpa_range_count == 0) {
+        goto exit;
+    }
+
+start_bg:
+    /* EBUSY other bg cmds as of now */
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+    /* sanitize when done */
+    cxl_dev_disable_media(&ct3d->cxl_dstate);
+    return CXL_MBOX_BG_STARTED;
+exit:
     return CXL_MBOX_SUCCESS;
 }
 
@@ -3154,6 +3348,13 @@ static void bg_timercb(void *opaque)
             cxl_dev_enable_media(&ct3d->cxl_dstate);
         }
         break;
+        case 0x4402: /* Media Operations sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+            __do_sanitize(ct3d);
+            cxl_dev_enable_media(&ct3d->cxl_dstate);
+        }
+        break;
         case 0x4304: /* scan media */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..6d82eb266a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -581,6 +581,15 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+struct CXLSanitizeInfo {
+    uint32_t dpa_range_count;
+    uint8_t fill_value;
+    struct {
+            uint64_t starting_dpa;
+            uint64_t length;
+    } dpa_range_list[0];
+};
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -651,6 +660,8 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
+
+    struct CXLSanitizeInfo  *media_op_sanitize;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.34.1


