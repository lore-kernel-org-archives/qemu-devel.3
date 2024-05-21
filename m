Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E2CC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NUF-0007gf-Fi; Tue, 21 May 2024 07:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NUD-0007fx-KJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NU8-0003wF-Vq
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:53 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240521111645epoutp043d51ef74258f2b4ef34d287f77f33947~RfNkwveak3165831658epoutp04N
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 11:16:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240521111645epoutp043d51ef74258f2b4ef34d287f77f33947~RfNkwveak3165831658epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716290205;
 bh=HFQu6GWXz7aOOCEF9QSREk2falkXs0AMJY2xiYpyXQ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mt7P19fmyPvDiD/07bBV73P0uDzrJO+q0JNqNnaihEuXB+dV+3LMXn8WzRX6vI4/P
 qbkhiOux6hhc366eIZRXLitmf/UeJlpV2Ts/GtRYlx/+4cnDBotAK3vfSq+ZYE6LIG
 0/pRaJ5SFCWzJgZOKY8EHRQE2kbDFGxQJCEToz1A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240521111644epcas2p456b9bcfaac169280d09899b70fb2079c~RfNkcTjIB1106811068epcas2p4B;
 Tue, 21 May 2024 11:16:44 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VkBhr1Fsmz4x9Pw; Tue, 21 May
 2024 11:16:44 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 B2.2C.09665.B928C466; Tue, 21 May 2024 20:16:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92~RfNjYEfz02788927889epcas2p4V;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240521111643epsmtrp23aa01e0ad3ecb421c891950f2a9c5654~RfNjXMo8y2930529305epsmtrp2R;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
X-AuditID: b6c32a47-93fff700000025c1-ca-664c829b920e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 20.B4.09238.B928C466; Tue, 21 May 2024 20:16:43 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epsmtip170062d38760434fe028016e2e64fdc78~RfNjLuOWB0093400934epsmtip1m;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
Date: Tue, 21 May 2024 20:05:44 +0900
Message-Id: <20240521110544.258772-3-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521110544.258772-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhe6cJp80g2WnmSxuHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR2XbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6w9fZSx4NQd
 xor5OxawNTAeWsrYxcjJISFgIjH15EEgm4tDSGAHo8SH7S3sEM4nRokFN7ZCZb4xSnxZdR2u
 5XjTQVaIxF5Gia9/l7KBJIQEfjNKnF5cBmKzCahLNEx9xQJiiwikS1x+txKogYODWSBb4uEN
 PRBTWMBKovevOkgFi4CqxP37b8GqeQWsJU597GKFWCUvsf/gWWaQck4BG4lT7+UgSgQlTs58
 AlbODFTSvHU2M8g1EgLX2CWe/WyG6nWRuNS4EcoWlnh1fAs7hC0l8fndXjYIu1zi55tJUG9V
 SBycdZsNZJeEgL3EtecpEAdrSqzfpQ8RVZY4cgtqK59Ex+G/7BBhXomONiGIGcoSHw8dYoaw
 JSWWX3oNtcdD4umE/9Cw7GeUePrjH8sERoVZSJ6ZheSZWQiLFzAyr2IUSy0ozk1PLTYqMIZH
 b3J+7iZGcErUct/BOOPtB71DjEwcjIcYJTiYlUR4N23xTBPiTUmsrEotyo8vKs1JLT7EaAoM
 6YnMUqLJ+cCknFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA1OF
 i/HqKFHZx2f6f4rm/2eY7Mtjxr6kzktxUuptSc8zq1dO0JDpmOjq77+88lu/2hHp5QZfTZYv
 em4hqxthO+mRa6Bywc0mgWhbwxDJTn8Ju8Oi+a/4D4S8lqm01ncJD+u9eFoi+a9x5JwJq4wN
 9j3QXtAqM0GNk5Vng8iKMrbAy5onuia/MY4s8Xzl8/H7n0T1JEkV1sLueInJZ1Unb10hN7/M
 rU9AuYHhnvS9hwm9HHq8z1l9a1ki5tcpn4oLzo+XifnJk/nQm8MjuvtUKxeL8fwNSmJJzHMO
 SCw42N23/8OxPwXrs3u2Vu32c3xndjVzL7vh/eLTNkfPt3MarVnRecTQ5//95J4ZPV+UWIoz
 Eg21mIuKEwHLMxpyEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO7sJp80g3+tmhY3D+xksnhwt5/R
 4v7Wa4wWSy6mWjw7fYDZYta7djaL4707WBzYPZ5c28zk8X7fVTaPvi2rGAOYo7hsUlJzMstS
 i/TtErgy1p4+ylhw6g5jxfwdC9gaGA8tZexi5OSQEDCRON50kLWLkYtDSGA3o8TcVW9YIBKS
 EvtO32SFsIUl7rccgSr6ySgx+c9hsCI2AXWJhqmvwGwRgUyJha862EFsZoF8ia6OBUxdjBwc
 wgJWEr1/1UHCLAKqEvfvvwUr5xWwljj1sQtqvrzE/oNnmUHKOQVsJE69lwMxhYBKrrZxQ1QL
 Spyc+YQFYri8RPPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/
 dxMjOIC1NHYw3pv/T+8QIxMH4yFGCQ5mJRHeTVs804R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 Gs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpg8mtYIeW4UD39ROHqbH3P99PmTD2a2zg/rzVDW3Ja
 JeOb07+1nGXffCmf5qX/KbDbqs3j5rqMLbF7pvy+sLjf/2hh593NRrzLOKfvS97StbHHi62S
 KyFH5FlmzcM3ZsFvLn1hOqDNtyf5m8fCvcp7d4ifi5a9aC2g22l+UKppubL/jeInfikVk6pf
 R704rywaPmt6veueiCda787U8TyyP/7Yvf6mj1zb3LaPBvwLTFcfTLrdHGL6XNFaUu7pnQly
 c1Z0yPYkOr20DOaZJqS3IGtbnWfZ0lCjDYWJda+kV9ya9HLK/BWvLt0t4LI8rPKlzGHG87/O
 d7JeZOxgf73aSDEqgVGe+eyqzXknlgRrKLEUZyQaajEXFScCADCfAiDPAgAA
X-CMS-MailID: 20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92
References: <20240521110544.258772-1-minwoo.im@samsung.com>
 <CGME20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92@epcas2p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
utilized the legacy I/O codes as much as possible to support MCQ.

MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
register statically with no spare space among four registers (48B):

	UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg

The maxinum number of queue is 32 as per spec, and the default
MAC(Multiple Active Commands) are 32 in the device.

Example:
	-device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 474 ++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++-
 include/block/ufs.h |  23 ++-
 4 files changed, 592 insertions(+), 20 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 665e1a942b..dda7f8a2e5 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -11,13 +11,18 @@ ufs_exec_nop_cmd(uint32_t slot) "UTRLDBR slot %"PRIu32""
 ufs_exec_scsi_cmd(uint32_t slot, uint8_t lun, uint8_t opcode) "slot %"PRIu32", lun 0x%"PRIx8", opcode 0x%"PRIx8""
 ufs_exec_query_cmd(uint32_t slot, uint8_t opcode) "slot %"PRIu32", opcode 0x%"PRIx8""
 ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32_t ucmdarg3) "uiccmd 0x%"PRIx32", ucmdarg1 0x%"PRIx32", ucmdarg2 0x%"PRIx32", ucmdarg3 0x%"PRIx32""
+ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
+ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
+ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 
 # error condition
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu. UTRLDBR slot %"PRIu32", request upiu addr %"PRIu64""
 ufs_err_dma_read_prdt(uint32_t slot, uint64_t addr) "failed to read prdt. UTRLDBR slot %"PRIu32", prdt addr %"PRIu64""
+ufs_err_dma_read_sq(uint8_t qid, uint64_t addr) "failed to read sqe. SQ qid %"PRIu8", sqe addr %"PRIu64""
 ufs_err_dma_write_utrd(uint32_t slot, uint64_t addr) "failed to write utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_write_rsp_upiu(uint32_t slot, uint64_t addr) "failed to write rsp upiu. UTRLDBR slot %"PRIu32", response upiu addr %"PRIu64""
+ufs_err_dma_write_cq(uint32_t cqid, uint64_t addr) "failed to write cq entry. cqid %"PRIu8", hwaddr %"PRIu64""
 ufs_err_utrl_slot_error(uint32_t slot) "UTRLDBR slot %"PRIu32" is in error"
 ufs_err_utrl_slot_busy(uint32_t slot) "UTRLDBR slot %"PRIu32" is busy"
 ufs_err_unsupport_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is not yet supported"
@@ -31,3 +36,15 @@ ufs_err_query_invalid_opcode(uint8_t opcode) "query request has invalid opcode.
 ufs_err_query_invalid_idn(uint8_t opcode, uint8_t idn) "query request has invalid idn. opcode: 0x%"PRIx8", idn 0x%"PRIx8""
 ufs_err_query_invalid_index(uint8_t opcode, uint8_t index) "query request has invalid index. opcode: 0x%"PRIx8", index 0x%"PRIx8""
 ufs_err_invalid_trans_code(uint32_t slot, uint8_t trans_code) "request upiu has invalid transaction code. slot: %"PRIu32", trans_code: 0x%"PRIx8""
+ufs_err_mcq_db_wr_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_db_wr_invalid_db(uint8_t qid, uint32_t db) "invalid mcq doorbell sqid %"PRIu8", db %"PRIu32""
+ufs_err_mcq_create_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_create_sq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
+ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
+ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
+ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
+ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
+ufs_err_mcq_delete_cq_sq_not_deleted(uint8_t sqid, uint8_t cqid) "mcq sq %"PRIu8" still has cq %"PRIu8""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index bac78a32bb..d8b301f12d 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: https://www.jedec.org/, 3.1
+ * Reference Specs: https://www.jedec.org/, 4.0
  *
  * Usage
  * -----
@@ -28,10 +28,45 @@
 #include "trace.h"
 #include "ufs.h"
 
-/* The QEMU-UFS device follows spec version 3.1 */
-#define UFS_SPEC_VER 0x0310
+/* The QEMU-UFS device follows spec version 4.0 */
+#define UFS_SPEC_VER 0x0400
 #define UFS_MAX_NUTRS 32
 #define UFS_MAX_NUTMRS 8
+#define UFS_MCQ_QCFGPTR 2
+
+static void ufs_exec_req(UfsRequest *req);
+static void ufs_clear_req(UfsRequest *req);
+
+static inline uint64_t ufs_mcq_reg_addr(UfsHc *u, int qid)
+{
+    /* Submission Queue MCQ Registers offset (400h) */
+    return (UFS_MCQ_QCFGPTR * 0x200) + qid * 0x40;
+}
+
+static inline uint64_t ufs_mcq_op_reg_addr(UfsHc *u, int qid)
+{
+    /* MCQ Operation & Runtime Registers offset (1000h) */
+    return UFS_MCQ_OPR_START + qid * 48;
+}
+
+static inline uint64_t ufs_reg_size(UfsHc *u)
+{
+    /* Total UFS HCI Register size in bytes */
+    return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
+}
+
+static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
+{
+    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
+}
+
+static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
+{
+    uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
+    return (addr >= mcq_op_reg_addr &&
+            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
+}
 
 static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
 {
@@ -181,9 +216,14 @@ static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
 {
     MemTxResult ret;
 
-    ret = ufs_dma_read_utrd(req);
-    if (ret) {
-        return ret;
+    /*
+     * In case of MCQ, UTRD has already been read from a SQ, so skip it.
+     */
+    if (!ufs_mcq_req(req)) {
+        ret = ufs_dma_read_utrd(req);
+        if (ret) {
+            return ret;
+        }
     }
 
     ret = ufs_dma_read_req_upiu(req);
@@ -335,6 +375,221 @@ static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
     ufs_irq_check(u);
 }
 
+static void ufs_mcq_init_req(UfsHc *u, UfsRequest *req, UfsSq *sq)
+{
+    memset(req, 0, sizeof(*req));
+
+    req->hc = u;
+    req->state = UFS_REQUEST_IDLE;
+    req->slot = UFS_INVALID_SLOT;
+    req->sq = sq;
+}
+
+static void ufs_mcq_process_sq(void *opaque)
+{
+    UfsSq *sq = opaque;
+    UfsHc *u = sq->u;
+    UfsSqEntry sqe;
+    UfsRequest *req;
+    hwaddr addr;
+    uint16_t head = ufs_mcq_sq_head(u, sq->sqid);
+    int err;
+
+    while (!(ufs_mcq_sq_empty(u, sq->sqid) || QTAILQ_EMPTY(&sq->req_list))) {
+        addr = sq->addr + head;
+        err = ufs_addr_read(sq->u, addr, (void *)&sqe, sizeof(sqe));
+        if (err) {
+            trace_ufs_err_dma_read_sq(sq->sqid, addr);
+            return;
+        }
+
+        head = (head + sizeof(sqe)) % (sq->size * sizeof(sqe));
+        ufs_mcq_update_sq_head(u, sq->sqid, head);
+
+        req = QTAILQ_FIRST(&sq->req_list);
+        QTAILQ_REMOVE(&sq->req_list, req, entry);
+
+        ufs_mcq_init_req(sq->u, req, sq);
+        memcpy(&req->utrd, &sqe, sizeof(req->utrd));
+
+        req->state = UFS_REQUEST_RUNNING;
+        ufs_exec_req(req);
+    }
+}
+
+static void ufs_mcq_process_cq(void *opaque)
+{
+    UfsCq *cq = opaque;
+    UfsHc *u = cq->u;
+    UfsRequest *req, *next;
+    MemTxResult ret;
+    uint32_t tail = ufs_mcq_cq_tail(u, cq->cqid);
+
+    QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
+        ufs_dma_write_rsp_upiu(req);
+
+        req->cqe.utp_addr =
+            ((uint64_t)req->utrd.command_desc_base_addr_hi << 32ULL) |
+            req->utrd.command_desc_base_addr_lo;
+        req->cqe.utp_addr |= req->sq->sqid;
+        req->cqe.resp_len = req->utrd.response_upiu_length;
+        req->cqe.resp_off = req->utrd.response_upiu_offset;
+        req->cqe.prdt_len = req->utrd.prd_table_length;
+        req->cqe.prdt_off = req->utrd.prd_table_offset;
+        req->cqe.status = req->utrd.header.dword_2 & 0xf;
+        req->cqe.error = 0;
+
+        ret = ufs_addr_write(u, cq->addr + tail, &req->cqe,
+                             sizeof(req->cqe));
+        if (ret) {
+            trace_ufs_err_dma_write_cq(cq->cqid, cq->addr + tail);
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
+
+        tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
+        ufs_mcq_update_cq_tail(u, cq->cqid, tail);
+
+        ufs_clear_req(req);
+        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
+    }
+
+    if (!ufs_mcq_cq_empty(u, cq->cqid)) {
+        u->mcq_op_reg[cq->cqid].cq_int.is =
+            FIELD_DP32(u->mcq_op_reg[cq->cqid].cq_int.is, CQIS, TEPS, 1);
+
+        u->reg.is = FIELD_DP32(u->reg.is, IS, CQES, 1);
+        ufs_irq_check(u);
+    }
+}
+
+static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
+{
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+    UfsSq *sq;
+    uint8_t cqid = FIELD_EX32(attr, SQATTR, CQID);
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_sq_invalid_sqid(qid);
+        return false;
+    }
+
+    if (u->sq[qid]) {
+        trace_ufs_err_mcq_create_sq_already_exists(qid);
+        return false;
+    }
+
+    if (!u->cq[cqid]) {
+        trace_ufs_err_mcq_create_sq_invalid_cqid(qid);
+        return false;
+    }
+
+    sq = g_malloc0(sizeof(*sq));
+    sq->u = u;
+    sq->sqid = qid;
+    sq->cq = u->cq[cqid];
+    sq->addr = ((uint64_t)reg->squba << 32) | reg->sqlba;
+    sq->size =
+        ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
+
+    sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
+                                 &DEVICE(u)->mem_reentrancy_guard);
+    sq->req = g_new0(UfsRequest, sq->size);
+    QTAILQ_INIT(&sq->req_list);
+    for (int i = 0; i < sq->size; i++) {
+        ufs_mcq_init_req(u, &sq->req[i], sq);
+        QTAILQ_INSERT_TAIL(&sq->req_list, &sq->req[i], entry);
+    }
+
+    u->sq[qid] = sq;
+
+    trace_ufs_mcq_create_sq(sq->sqid, sq->cq->cqid, sq->addr, sq->size);
+    return true;
+}
+
+static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
+{
+    UfsSq *sq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_delete_sq_invalid_sqid(qid);
+        return false;
+    }
+
+    if (!u->sq[qid]) {
+        trace_ufs_err_mcq_delete_sq_not_exists(qid);
+        return false;
+    }
+
+    sq = u->sq[qid];
+
+    qemu_bh_delete(sq->bh);
+    g_free(sq->req);
+    g_free(sq);
+    u->sq[qid] = NULL;
+    return true;
+}
+
+static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
+{
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+    UfsCq *cq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_cq_invalid_cqid(qid);
+        return false;
+    }
+
+    if (u->cq[qid]) {
+        trace_ufs_err_mcq_create_cq_already_exists(qid);
+        return false;
+    }
+
+    cq = g_malloc0(sizeof(*cq));
+    cq->u = u;
+    cq->cqid = qid;
+    cq->addr = ((uint64_t)reg->cquba << 32) | reg->cqlba;
+    cq->size =
+        ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
+
+    cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
+                                 &DEVICE(u)->mem_reentrancy_guard);
+    QTAILQ_INIT(&cq->req_list);
+
+    u->cq[qid] = cq;
+
+    trace_ufs_mcq_create_cq(cq->cqid, cq->addr, cq->size);
+    return true;
+}
+
+static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
+{
+    UfsCq *cq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_delete_cq_invalid_cqid(qid);
+        return false;
+    }
+
+    if (!u->cq[qid]) {
+        trace_ufs_err_mcq_delete_cq_not_exists(qid);
+        return false;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        if (u->sq[i] && u->sq[i]->cq->cqid == qid) {
+            trace_ufs_err_mcq_delete_cq_sq_not_deleted(i, qid);
+            return false;
+        }
+    }
+
+    cq = u->cq[qid];
+
+    qemu_bh_delete(cq->bh);
+    g_free(cq);
+    u->cq[qid] = NULL;
+    return true;
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
 {
     switch (offset) {
@@ -390,6 +645,12 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     case A_UCMDARG3:
         u->reg.ucmdarg3 = data;
         break;
+    case A_CONFIG:
+        u->reg.config = data;
+        break;
+    case A_MCQCONFIG:
+        u->reg.mcqconfig = data;
+        break;
     case A_UTRLCLR:
     case A_UTMRLDBR:
     case A_UTMRLCLR:
@@ -402,18 +663,138 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     }
 }
 
+static void ufs_write_mcq_reg(UfsHc *u, hwaddr offset, uint32_t data,
+                              unsigned size)
+{
+    int qid = offset / sizeof(UfsMcqReg);
+    UfsMcqReg *reg = &u->mcq_reg[qid];
+
+    switch (offset % sizeof(UfsMcqReg)) {
+    case A_SQATTR:
+        if (!FIELD_EX32(reg->sqattr, SQATTR, SQEN) &&
+            FIELD_EX32(data, SQATTR, SQEN)) {
+            if (!ufs_mcq_create_sq(u, qid, data)) {
+                break;
+            }
+        } else if (FIELD_EX32(reg->sqattr, SQATTR, SQEN) &&
+                   !FIELD_EX32(data, SQATTR, SQEN)) {
+            if (!ufs_mcq_delete_sq(u, qid)) {
+                break;
+            }
+        }
+        reg->sqattr = data;
+        break;
+    case A_SQLBA:
+        reg->sqlba = data;
+        break;
+    case A_SQUBA:
+        reg->squba = data;
+        break;
+    case A_SQCFG:
+        reg->sqcfg = data;
+        break;
+    case A_CQATTR:
+        if (!FIELD_EX32(reg->cqattr, CQATTR, CQEN) &&
+            FIELD_EX32(data, CQATTR, CQEN)) {
+            if (!ufs_mcq_create_cq(u, qid, data)) {
+                break;
+            }
+        } else if (FIELD_EX32(reg->cqattr, CQATTR, CQEN) &&
+                   !FIELD_EX32(data, CQATTR, CQEN)) {
+            if (!ufs_mcq_delete_cq(u, qid)) {
+                break;
+            }
+        }
+        reg->cqattr = data;
+        break;
+    case A_CQLBA:
+        reg->cqlba = data;
+        break;
+    case A_CQUBA:
+        reg->cquba = data;
+        break;
+    case A_CQCFG:
+        reg->cqcfg = data;
+        break;
+    case A_SQDAO:
+    case A_SQISAO:
+    case A_CQDAO:
+    case A_CQISAO:
+        trace_ufs_err_unsupport_register_offset(offset);
+        break;
+    default:
+        trace_ufs_err_invalid_register_offset(offset);
+        break;
+    }
+}
+
+static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
+{
+    UfsSq *sq;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_db_wr_invalid_sqid(qid);
+        return;
+    }
+
+    sq = u->sq[qid];
+    if (sq->size * sizeof(UfsSqEntry) <= db) {
+        trace_ufs_err_mcq_db_wr_invalid_db(qid, db);
+        return;
+    }
+
+    ufs_mcq_update_sq_tail(u, sq->sqid, db);
+    qemu_bh_schedule(sq->bh);
+}
+
+static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
+                                 unsigned size)
+{
+    int qid = offset / sizeof(UfsMcqOpReg);
+    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+
+    switch (offset % sizeof(UfsMcqOpReg)) {
+    case offsetof(UfsMcqOpReg, sq.tp):
+        if (opr->sq.tp != data) {
+            ufs_mcq_process_db(u, qid, data);
+        }
+        opr->sq.tp = data;
+        break;
+    case offsetof(UfsMcqOpReg, cq.hp):
+        opr->cq.hp = data;
+        ufs_mcq_update_cq_head(u, qid, data);
+        break;
+    case offsetof(UfsMcqOpReg, cq_int.is):
+        opr->cq_int.is &= ~data;
+        break;
+    default:
+        trace_ufs_err_invalid_register_offset(offset);
+        break;
+    }
+}
+
 static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     UfsHc *u = (UfsHc *)opaque;
-    uint8_t *ptr = (uint8_t *)&u->reg;
+    uint8_t *ptr;
     uint64_t value;
-
-    if (addr > sizeof(u->reg) - size) {
+    uint64_t offset;
+
+    if (addr < sizeof(u->reg)) {
+        offset = addr;
+        ptr = (uint8_t *)&u->reg;
+    } else if (ufs_is_mcq_reg(u, addr)) {
+        offset = addr - ufs_mcq_reg_addr(u, 0);
+        ptr = (uint8_t *)&u->mcq_reg;
+    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        offset = addr - ufs_mcq_op_reg_addr(u, 0);
+        ptr = (uint8_t *)&u->mcq_op_reg;
+    } else {
         trace_ufs_err_invalid_register_offset(addr);
         return 0;
     }
 
-    value = *(uint32_t *)(ptr + addr);
+    value = *(uint32_t *)(ptr + offset);
     trace_ufs_mmio_read(addr, value, size);
     return value;
 }
@@ -423,13 +804,18 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
 {
     UfsHc *u = (UfsHc *)opaque;
 
-    if (addr > sizeof(u->reg) - size) {
+    trace_ufs_mmio_write(addr, data, size);
+
+    if (addr < sizeof(u->reg)) {
+        ufs_write_reg(u, addr, data, size);
+    } else if (ufs_is_mcq_reg(u, addr)) {
+        ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
+    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0),
+                               data, size);
+    } else {
         trace_ufs_err_invalid_register_offset(addr);
-        return;
     }
-
-    trace_ufs_mmio_write(addr, data, size);
-    ufs_write_reg(u, addr, data, size);
 }
 
 static const MemoryRegionOps ufs_mmio_ops = {
@@ -1086,9 +1472,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
     }
 
-    trace_ufs_complete_req(req->slot);
     req->state = UFS_REQUEST_COMPLETE;
-    qemu_bh_schedule(u->complete_bh);
+
+    if (ufs_mcq_req(req)) {
+        trace_ufs_mcq_complete_req(req->sq->sqid);
+        QTAILQ_INSERT_TAIL(&req->sq->cq->req_list, req, entry);
+        qemu_bh_schedule(req->sq->cq->bh);
+    } else {
+        trace_ufs_complete_req(req->slot);
+        qemu_bh_schedule(u->complete_bh);
+    }
 }
 
 static void ufs_clear_req(UfsRequest *req)
@@ -1158,6 +1551,11 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
         return false;
     }
 
+    if (u->params.mcq_maxq >= UFS_MAX_MCQ_QNUM) {
+        error_setg(errp, "mcq-maxq must be less than %d", UFS_MAX_MCQ_QNUM);
+        return false;
+    }
+
     return true;
 }
 
@@ -1189,15 +1587,24 @@ static void ufs_init_state(UfsHc *u)
                                          &DEVICE(u)->mem_reentrancy_guard);
     u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
                                          &DEVICE(u)->mem_reentrancy_guard);
+
+    if (u->params.mcq) {
+        memset(u->sq, 0, sizeof(u->sq));
+        memset(u->cq, 0, sizeof(u->cq));
+    }
 }
 
 static void ufs_init_hc(UfsHc *u)
 {
     uint32_t cap = 0;
+    uint32_t mcqconfig = 0;
+    uint32_t mcqcap = 0;
 
-    u->reg_size = pow2ceil(sizeof(UfsReg));
+    u->reg_size = pow2ceil(ufs_reg_size(u));
 
     memset(&u->reg, 0, sizeof(u->reg));
+    memset(&u->mcq_reg, 0, sizeof(u->mcq_reg));
+    memset(&u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
     cap = FIELD_DP32(cap, CAP, NUTRS, (u->params.nutrs - 1));
     cap = FIELD_DP32(cap, CAP, RTT, 2);
     cap = FIELD_DP32(cap, CAP, NUTMRS, (u->params.nutmrs - 1));
@@ -1206,7 +1613,29 @@ static void ufs_init_hc(UfsHc *u)
     cap = FIELD_DP32(cap, CAP, OODDS, 0);
     cap = FIELD_DP32(cap, CAP, UICDMETMS, 0);
     cap = FIELD_DP32(cap, CAP, CS, 0);
+    cap = FIELD_DP32(cap, CAP, LSDBS, 1);
+    cap = FIELD_DP32(cap, CAP, MCQS, u->params.mcq);
     u->reg.cap = cap;
+
+    if (u->params.mcq) {
+        mcqconfig = FIELD_DP32(mcqconfig, MCQCONFIG, MAC, 0x1f);
+        u->reg.mcqconfig = mcqconfig;
+
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, MAXQ, u->params.mcq_maxq - 1);
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, RRP, 1);
+        mcqcap = FIELD_DP32(mcqcap, MCQCAP, QCFGPTR, UFS_MCQ_QCFGPTR);
+        u->reg.mcqcap = mcqcap;
+
+        for (int i = 0; i < ARRAY_SIZE(u->mcq_reg); i++) {
+            uint64_t addr = ufs_mcq_op_reg_addr(u, i);
+            u->mcq_reg[i].sqdao = addr;
+            u->mcq_reg[i].sqisao = addr + sizeof(UfsMcqSqReg);
+            addr += sizeof(UfsMcqSqReg);
+            u->mcq_reg[i].cqdao = addr + sizeof(UfsMcqSqIntReg);
+            addr += sizeof(UfsMcqSqIntReg);
+            u->mcq_reg[i].cqisao = addr + sizeof(UfsMcqCqReg);
+        }
+    }
     u->reg.ver = UFS_SPEC_VER;
 
     memset(&u->device_desc, 0, sizeof(DeviceDescriptor));
@@ -1288,12 +1717,21 @@ static void ufs_exit(PCIDevice *pci_dev)
         ufs_clear_req(&u->req_list[i]);
     }
     g_free(u->req_list);
+
+    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
+        ufs_mcq_delete_sq(u, i);
+    }
+    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
+        ufs_mcq_delete_cq(u, i);
+    }
 }
 
 static Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
+    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
+    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 8fda94f4ef..6c9382cbc4 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -16,6 +16,7 @@
 #include "block/ufs.h"
 
 #define UFS_MAX_LUS 32
+#define UFS_MAX_MCQ_QNUM 32
 #define UFS_BLOCK_SIZE_SHIFT 12
 #define UFS_BLOCK_SIZE (1 << UFS_BLOCK_SIZE_SHIFT)
 
@@ -45,10 +46,11 @@ typedef enum UfsReqResult {
     UFS_REQUEST_NO_COMPLETE = 2,
 } UfsReqResult;
 
+#define UFS_INVALID_SLOT (-1)
 typedef struct UfsRequest {
     struct UfsHc *hc;
     UfsRequestState state;
-    int slot;
+    int slot; /* -1 when it's a MCQ request */
 
     UtpTransferReqDesc utrd;
     UtpUpiuReq req_upiu;
@@ -57,8 +59,18 @@ typedef struct UfsRequest {
     /* for scsi command */
     QEMUSGList *sg;
     uint32_t data_len;
+
+    /* for MCQ */
+    struct UfsSq *sq;
+    struct UfsCqEntry cqe;
+    QTAILQ_ENTRY(UfsRequest) entry;
 } UfsRequest;
 
+static inline bool ufs_mcq_req(UfsRequest *req)
+{
+    return req->sq != NULL;
+}
+
 struct UfsLu;
 typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 
@@ -76,13 +88,43 @@ typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
     uint8_t nutmrs; /* Number of UTP Task Management Request Slots */
+    bool mcq; /* Multiple Command Queue support */
+    uint8_t mcq_qcfgptr; /* MCQ Queue Configuration Pointer in MCQCAP */
+    uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
 } UfsParams;
 
+/*
+ * MCQ Properties
+ */
+typedef struct UfsSq {
+    struct UfsHc *u;
+    uint8_t sqid;
+    struct UfsCq *cq;
+    uint64_t addr;
+    uint16_t size; /* A number of entries (qdepth) */
+
+    QEMUBH *bh; /* Bottom half to process requests in async */
+    UfsRequest *req;
+    QTAILQ_HEAD(, UfsRequest) req_list; /* Free request list */
+} UfsSq;
+
+typedef struct UfsCq {
+    struct UfsHc *u;
+    uint8_t cqid;
+    uint64_t addr;
+    uint16_t size; /* A number of entries (qdepth) */
+
+    QEMUBH *bh;
+    QTAILQ_HEAD(, UfsRequest) req_list;
+} UfsCq;
+
 typedef struct UfsHc {
     PCIDevice parent_obj;
     UfsBus bus;
     MemoryRegion iomem;
     UfsReg reg;
+    UfsMcqReg mcq_reg[UFS_MAX_MCQ_QNUM];
+    UfsMcqOpReg mcq_op_reg[UFS_MAX_MCQ_QNUM];
     UfsParams params;
     uint32_t reg_size;
     UfsRequest *req_list;
@@ -100,8 +142,62 @@ typedef struct UfsHc {
     qemu_irq irq;
     QEMUBH *doorbell_bh;
     QEMUBH *complete_bh;
+
+    /* MCQ properties */
+    UfsSq *sq[UFS_MAX_MCQ_QNUM];
+    UfsCq *cq[UFS_MAX_MCQ_QNUM];
 } UfsHc;
 
+static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].sq.tp;
+}
+
+static inline void ufs_mcq_update_sq_tail(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].sq.tp = db;
+}
+
+static inline uint32_t ufs_mcq_sq_head(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].sq.hp;
+}
+
+static inline void ufs_mcq_update_sq_head(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].sq.hp = db;
+}
+
+static inline bool ufs_mcq_sq_empty(UfsHc *u, uint32_t qid)
+{
+    return ufs_mcq_sq_tail(u, qid) == ufs_mcq_sq_head(u, qid);
+}
+
+static inline uint32_t ufs_mcq_cq_tail(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].cq.tp;
+}
+
+static inline void ufs_mcq_update_cq_tail(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].cq.tp = db;
+}
+
+static inline uint32_t ufs_mcq_cq_head(UfsHc *u, uint32_t qid)
+{
+    return u->mcq_op_reg[qid].cq.hp;
+}
+
+static inline void ufs_mcq_update_cq_head(UfsHc *u, uint32_t qid, uint32_t db)
+{
+    u->mcq_op_reg[qid].cq.hp = db;
+}
+
+static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
+{
+    return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 3513b6e772..92da7a89b9 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -152,7 +152,8 @@ REG32(MCQCONFIG, offsetof(UfsReg, mcqconfig))
     FIELD(MCQCONFIG, MAC, 8, 8)
 
 #define UFS_INTR_MASK                                    \
-    ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
+    ((1 << R_IS_CQES_SHIFT) |                            \
+     (1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
      (1 << R_IS_HCFES_SHIFT) | (1 << R_IS_UTPES_SHIFT) | \
      (1 << R_IS_DFES_SHIFT) | (1 << R_IS_UCCS_SHIFT) |   \
      (1 << R_IS_UTMRCS_SHIFT) | (1 << R_IS_ULSS_SHIFT) | \
@@ -242,6 +243,21 @@ typedef struct QEMU_PACKED UfsMcqCqIntReg {
 REG32(CQIS, offsetof(UfsMcqCqIntReg, is))
     FIELD(CQIS, TEPS, 0, 1)
 
+/*
+ * Provide MCQ Operation & Runtime Registers as a contiguous addressed
+ * registers for the simplicity.
+ * DAO(Doorbell Address Offset) and  ISAO(Interrupt Status Register Address
+ * Offset) registers should be properly configured with the following
+ * structure.
+ */
+#define UFS_MCQ_OPR_START   0x1000
+typedef struct QEMU_PACKED UfsMcqOpReg {
+    UfsMcqSqReg sq;
+    UfsMcqSqIntReg sq_int;
+    UfsMcqCqReg cq;
+    UfsMcqCqIntReg cq_int;
+} UfsMcqOpReg;
+
 typedef struct QEMU_PACKED DeviceDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1169,6 +1185,11 @@ static inline void _ufs_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x38C);
     QEMU_BUILD_BUG_ON(sizeof(UfsMcqReg) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqSqReg) != 20);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqReg) != 8);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqSqIntReg) != 8);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqIntReg) != 12);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqOpReg) != 48);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
-- 
2.34.1


