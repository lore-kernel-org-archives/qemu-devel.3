Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE2606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=tm1708BU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Iv-0002al-3q; Mon, 16 Nov 2026 15:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ip-0002Ou-8W; Mon, 16 Nov 2026 15:27:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3In-0001Ot-4D; Mon, 16 Nov 2026 15:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=VhCh+ZItEwMKkXMlJ5Z6sLJKjcdNqXp6EbtDIetXkYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tm1708BUnVZ8n3F3rBqb/PIfT2zBa5XRg1CRHmt5s9tdOzuupk5fhNU627siJBmRu
 tYwrJBV3wMm6iCvvVJnj9X5iWmZz/dHheKoj3yG8aFL1nEYC8GmYu4bQjDiDbuv6Kd
 l1m6KreIn1JZcrsqfuoP+MMHQ2gU19B10Glo5AaDMLHdAF1bGRcHcFxEVAZgKhYIsL
 bS719u9ut4l/MhQ1fPK8kRJLaqbElmsNixO8lqYqXOGJP50/JtbmVv+fkpi1hNx8z1
 dqhvxlBPJMMfXKXlJnhdSAzBCy2Lk/o3gq3OvFAomW7F5hf0KSZnuvNdfPhy1zh5QL
 rQ2Ky1ANaWoqg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1A7721E71A9;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 16F8C45FBD5;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A37DEB8E6E; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daejun Park <daejun7.park@samsung.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 20/63] hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd
 as SYNCHRONIZE CACHE(10)
Date: Mon, 16 Nov 2026 23:24:59 +0300
Message-ID: <20261116202554.535325-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

scsi-hd implements SYNCHRONIZE CACHE(10) only and fails the 16-byte
variant with INVALID COMMAND OPERATION CODE. Linux sends SYNCHRONIZE
CACHE(16) to zoned disks (sd_zbc sets use_16_for_sync), so once a
logical unit can be zoned, every flush from such a guest fails. With
the zoned logical units and without this change, a Linux 7.3-rc7
guest logged

  sd 2:0:0:1: [sdb] tag#9 Add. Sense: Invalid command operation code
  critical target error, dev sdb, sector 0 op 0x1:(WRITE) flags 0x800

and fsync() on the disk failed with EREMOTEIO.

scsi-hd flushes the whole medium for SYNCHRONIZE CACHE(10) and does not
look at its LBA range. Hand the 16-byte command to scsi-hd as the
10-byte one and keep the IMMED bit. This keeps the UFS change inside
hw/ufs; if scsi-disk learns SYNCHRONIZE CACHE(16), the translation can
go.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit ad2f77a00b4ab8ef98863048a842a459c031dce8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 2da5bb50fb0..9b574b0ea37 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -368,6 +368,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint8_t sync_cache_10[UFS_CDB_SIZE] = { SYNCHRONIZE_CACHE };
     SCSIRequest *scsi_req;
     uint32_t len;
 
@@ -381,8 +383,19 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }
 
-    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun,
-                            req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
+    /*
+     * scsi-hd implements SYNCHRONIZE CACHE(10) only, while Linux sends the
+     * 16-byte variant to zoned disks. scsi-hd flushes the whole medium for
+     * SYNCHRONIZE CACHE(10) whatever its LBA range, so pass the 16-byte
+     * command on as the 10-byte one, keeping IMMED.
+     */
+    if (cdb[0] == SYNCHRONIZE_CACHE_16) {
+        sync_cache_10[1] = cdb[1] & 0x02;
+        cdb = sync_cache_10;
+    }
+
+    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun, cdb, UFS_CDB_SIZE,
+                            req);
 
     /*
      * A command that moves data needs a PRDT. Without one there is no SG
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index ea7b9aa62a7..3c9e9e4032c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -814,6 +814,51 @@ static void ufstest_no_prdt(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_sync_cache(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t buf[4096];
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t sync_cache_10_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE,
+    };
+    const uint8_t sync_cache_16_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE_16,
+    };
+    const uint8_t sync_cache_16_immed_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE_16, 0x02 /* IMMED */
+    };
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_10_cdb, NULL, 0,
+                                NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_16_cdb, NULL, 0,
+                                NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_16_immed_cdb, NULL,
+                                0, NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1766,6 +1811,7 @@ static void ufs_register_nodes(void)
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
     qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
+    qos_add_test("sync-cache", "ufs", ufstest_sync_cache, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
-- 
2.47.3


