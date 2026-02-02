Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A6E7FDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzzH-0007MQ-Ee; Mon, 02 Feb 2026 14:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzz6-00075k-Sz; Mon, 02 Feb 2026 14:53:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzz4-0004LB-GR; Mon, 02 Feb 2026 14:53:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D44511850D6;
 Mon, 02 Feb 2026 22:46:08 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8520F35B2B8;
 Mon, 02 Feb 2026 22:46:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilia Levi <ilia.levi@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 68/69] tests/qtest/ufs-test: Add test for mcq
 completion queue wraparound
Date: Mon,  2 Feb 2026 22:46:31 +0300
Message-ID: <20260202194638.939438-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilia Levi <ilia.levi@intel.com>

Added a test that sends 32 NOP Out commands asynchronously. Since the CQ
has 31 entries by default, this tests the scenario where CQ processing
needs to wait for space to become available.

Additionally, added two minor fixes to existing tests:
* advance CQ head after reading from CQ
* initialize command descriptor slots bitmap in ufs_init()

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 94e72135d4d657d672561b1ae02a5854421616a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 4867ccf08a..ff9835735c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -166,6 +166,7 @@ __ufs_send_transfer_request_mcq(QUfs *ufs, uint8_t lun,
     cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
     cqentry_addr = ufs->cqlba[TEST_QID] + cqhp;
     qtest_memread(ufs->dev.bus->qts, cqentry_addr, &cqentry, sizeof(cqentry));
+    cqhp = (cqhp + sizeof(UfsCqEntry)) % (QUEUE_SIZE * sizeof(UfsCqEntry));
     ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
 
     return cqentry.status;
@@ -208,6 +209,81 @@ static enum UtpOcsCodes ufs_send_nop_out(QUfs *ufs, UtpUpiuRsp *rsp_out)
     return ret;
 }
 
+static bool ufs_mcq_sq_has_space(QUfs *ufs)
+{
+    uint32_t sqhp = ufs_rreg(ufs, ufs->sqdao[TEST_QID]);
+    uint32_t sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    uint32_t next_sqtp =
+        (sqtp + sizeof(UfsSqEntry)) % (QUEUE_SIZE * sizeof(UfsSqEntry));
+    return next_sqtp != sqhp;
+}
+
+static void
+__ufs_send_transfer_request_mcq_async(QUfs *ufs, uint8_t lun,
+                                      const UtpTransferReqDesc *utrd)
+{
+    uint32_t sqtp;
+    uint64_t utrd_addr;
+
+    /* Wait for SQ space */
+    while (!ufs_mcq_sq_has_space(ufs)) {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+    }
+
+    sqtp = ufs_rreg(ufs, ufs->sqdao[TEST_QID] + 0x4);
+    utrd_addr = ufs->sqlba[TEST_QID] + sqtp;
+    qtest_memwrite(ufs->dev.bus->qts, utrd_addr, utrd, sizeof(*utrd));
+    sqtp = (sqtp + sizeof(UfsSqEntry)) % (QUEUE_SIZE * sizeof(UfsSqEntry));
+    ufs_wreg(ufs, ufs->sqdao[TEST_QID] + 0x4, sqtp);
+}
+
+static int ufs_mcq_send_nop_out_async(QUfs *ufs)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+
+    /* Build up request upiu */
+    UtpUpiuReq req_upiu = { 0 };
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_NOP_OUT;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+
+    /* Build up utp transfer request descriptor */
+    UtpTransferReqDesc utrd =
+        ufs_build_req_utrd(req_upiu_addr, UFS_UTP_NO_DATA_TRANSFER, 0);
+
+    /* Send Transfer Request */
+    __ufs_send_transfer_request_mcq_async(ufs, 0, &utrd);
+
+    return cmd_desc_slot;
+}
+
+static int ufs_mcq_poll_cq(QUfs *ufs, UfsCqEntry *cqe, uint16_t n_cqe)
+{
+    uint32_t cqhp, cqtp;
+    uint64_t cqe_addr;
+    int ix = 0;
+
+    cqhp = ufs_rreg(ufs, ufs->cqdao[TEST_QID]);
+    cqtp = ufs_rreg(ufs, ufs->cqdao[TEST_QID] + 0x4);
+
+    while (cqhp != cqtp && ix < n_cqe) {
+        /* read completion entry */
+        cqe_addr = ufs->cqlba[TEST_QID] + cqhp;
+        qtest_memread(ufs->dev.bus->qts, cqe_addr, &cqe[ix], sizeof(cqe[ix]));
+
+        /* advance completion queue head pointer */
+        cqhp = (cqhp + sizeof(UfsCqEntry)) % (QUEUE_SIZE * sizeof(UfsCqEntry));
+        ix++;
+    }
+
+    ufs_wreg(ufs, ufs->cqdao[TEST_QID], cqhp);
+
+    return ix;
+}
+
 static enum UtpOcsCodes ufs_send_query(QUfs *ufs, uint8_t query_function,
                                        uint8_t query_opcode, uint8_t idn,
                                        uint8_t index, uint8_t selector,
@@ -416,6 +492,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     ufs_wreg(ufs, A_UTRIACR, 0);
 
     /* Enable transfer request */
+    bitmap_zero(ufs->cmd_desc_bitmap, UFS_MAX_CMD_DESC);
     ufs->cmd_desc_addr =
         guest_alloc(alloc, UFS_MAX_CMD_DESC * UTP_COMMAND_DESCRIPTOR_SIZE);
     ufs->data_buffer_addr =
@@ -679,6 +756,53 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_mcq_cq_wraparound(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    UfsCqEntry cqe[QUEUE_SIZE];
+    const int num_requests = QUEUE_SIZE;
+    int i, completed = 0;
+
+    ufs_init(ufs, alloc);
+
+    /* Ensure MCQ is supported */
+    g_assert_true(ufs->support_mcq);
+
+    for (i = 0; i < num_requests; ++i) {
+        ufs_mcq_send_nop_out_async(ufs);
+    }
+
+    while (completed != num_requests) {
+        int n_cqe = ufs_mcq_poll_cq(ufs, cqe, ARRAY_SIZE(cqe));
+        if (!n_cqe) {
+            break;
+        }
+
+        for (i = 0; i < n_cqe; ++i) {
+            uint64_t ucdba;
+            uint64_t rsp_upiu_addr;
+            UtpUpiuRsp rsp_upiu;
+            uint8_t tag;
+
+            g_assert_cmpuint(cqe[i].status, ==, UFS_OCS_SUCCESS);
+
+            ucdba = le64_to_cpu(cqe[i].utp_addr) & MAKE_64BIT_MASK(7, 57);
+            rsp_upiu_addr = ucdba + UTP_RESPONSE_UPIU_OFFSET;
+            qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, &rsp_upiu,
+                          sizeof(rsp_upiu));
+
+            tag = rsp_upiu.header.task_tag;
+            release_cmd_desc_slot(ufs, tag);
+        }
+
+        completed += n_cqe;
+    }
+
+    g_assert_cmpint(completed, ==, num_requests);
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_query_flag_request(void *obj, void *data,
                                        QGuestAllocator *alloc)
 {
@@ -1129,6 +1253,8 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
+                 &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
                  &io_test_opts);
     qos_add_test("query-attribute", "ufs", ufstest_query_attr_request,
-- 
2.47.3


