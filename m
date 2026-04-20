Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F26DF99C86
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhCH-0008IQ-Af; Mon, 20 Apr 2026 01:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhCC-0008FZ-4r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhC6-00082r-JJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:17 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso1578967a91.2
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662953; x=1777267753; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvnDam+RI7xNOArU3spJiI07Kx70RBnYFEvTvltBdIM=;
 b=jfoBZXp8oXEimEdtXmCutrViDXfJp4mq05XgwH6yGn6W41WHP/j1a5BR1gM51bVY/1
 ieyWm5e7PuVP3tc4hZ2/9Ewoc4VQ87YRr3AtZJNEB5BV+bcCWFzt6EYLdKw0SRSOa0xF
 M4cHZUGJqx3p3FsT6ZLhHO41kGmzVQDV4XGgPS6gBeqP2xHE67jV6ZpiEJwA9lxbBPJE
 4DE4HaV4tACxr1UqshGK5pZjo79l1J9RsfYhoRY7p8kCf9ZS9inzVWrClMHPoz2ZLDAb
 ceGv6YxFVmedjFilsxhqYrxyF8QiAHzmZ4dV3NzPeukxWJZXT/i7yWdYLG6NoDJNUC/k
 J4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662953; x=1777267753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UvnDam+RI7xNOArU3spJiI07Kx70RBnYFEvTvltBdIM=;
 b=eg64EahrgZ8tPuQkWniZoEiQhh3yj4wjOVYgz7JRcYi5Q+Ih/BxPJmr1AipuBJJMZJ
 Bh4YbciSJBbAtFVq3CvTB97zuYLHw7982gcbXtvQPtLkB+JmKxA37hM6p82YDvYFSUS2
 iWaoGJr/oWvVtCNVDdo+wO2AQSjdXgctuDoPRC/2Z83n9rZuqsAkmp6xJXaDvU1Hee55
 D5uO36fSUTu19G90LXWOpZhCgBCrRuSf6/7l8ktB8H+JVp8S1e4mXd7HrNLl417nufEQ
 CqCECCBMieeqmVSJnEQM6e5xGbHayZJWvQjEwaVNZxuemkFeXZDDsTopYFFpsShsOr1O
 0fLQ==
X-Gm-Message-State: AOJu0YyL2pGbJ224S52vICK7+J8DlbIbA2WoV4Q6pnPNoms4bbZ2XOGt
 1Ay6N7eyj/ElYPkKi9o9nUFKpJXoVEndwZ5ABSHxusS0npsHhg786fXIHmG9X9JzdA0=
X-Gm-Gg: AeBDievWDze3hdgSPHMbYPI+DnyOZNX0FPhVUH9xmllkNpb4AhtT4kMmTWZ+KFG+i9D
 pTZ0mfThU9sCzjDCbntbPH+wkMdTWBuN82brKY+uqJLrAQuW2/bZeP81QsQrIG100muJPBxFBdX
 70AfjGOH6c2VB8aOOtKiz14pjYPwW56UKmCoB8N1VGp0S5VQfVoeGd9eZg9u+G1b8WzHeIw0tVT
 5ATcqenLKNVIwVqT3Op6gcZbK1LZizrRW5JwG60vFwREeCd8TOpExy4KP0LcmqPZxFKtva6r51D
 Ac+KwEYlYvNxejuG0EvjyMBJhu9d7CdUMF58zPJHhhr1MxzstHA7Bw+lVaaR9RTDy1sZ+WnaOvN
 zgI+80MqgfuPqDxpRR+KRiU0MvM/F2bPgdQaY4lLuG7lBny6fV/g3hMQckw4GvGq0XCvmEATDUv
 Jhc1Ztbau7LV4T6aqD5MOLWPN+fQnIVJehdd07fQFWxZ7u64D0Mg4=
X-Received: by 2002:a17:903:1b6f:b0:2b2:4cd2:e16c with SMTP id
 d9443c01a7336-2b5f9f3c58amr118027145ad.20.1776662952815; 
 Sun, 19 Apr 2026 22:29:12 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm93099675ad.71.2026.04.19.22.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:29:12 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Mon, 20 Apr 2026 14:28:53 +0900
Subject: [PATCH v6 5/5] tests/qtest: Add UFS Write Booster QTest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-write_booster-v6-5-8c49acba03d4@samsung.com>
References: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
In-Reply-To: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776662940; l=8918;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=rU67KxRcVLL6ZVBVhiBQ/INRn8llY3KXffQmzbO047E=;
 b=f8YXU4vN/4n731hESBmuMmgJJ0TK+3IzIUik2wf7twoNcpfLGNC4/GnsbAsHjkI/ybLL3v0/4
 O05I4HXQ0nUA3Ou/w5OwT4y75EuKcS/gkqwdFGv6r0Uj/XLGq8F3rSt
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ldc.jml@gmail.com; helo=mail-pj1-x1034.google.com
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

It adds 'wb-init' and 'wb-read-write' TCs into tests/qtest/ufs-test.c.
'wb-init' tests that the WB support is properly initialized with UFS
device and 'wb-read-write' tests that WB can be enabled and WRITE I/O
can be handled/buffered as a WB command.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 tests/qtest/ufs-test.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f999441552a105987aaaf8e2b976f4a05f953ed..253fea27a5e52619f433d15075500a566eddeccc 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1182,6 +1182,173 @@ static void ufstest_query_desc_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_wb_init(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    uint8_t *desc;
+    uint32_t value;
+
+    ufs_init(ufs, alloc);
+
+    /* Read Device Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_DEVICE);
+
+    /* Check Write Booster Supportability */
+    desc = rsp_upiu.qr.data;
+
+    value = *(uint16_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_WB_SUP);
+    value = be16_to_cpu(value);
+    g_assert_cmpuint(value, ==, WB_RESIZE | WB_FIFO | WB_PINNED);
+
+    value = *(uint32_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+    value = be32_to_cpu(value);
+    g_assert_cmpuint(value & UFS_DEV_WB_SUPPORT, ==, UFS_DEV_WB_SUPPORT);
+
+    /* Read Geometry Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_GEOMETRY, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
+
+    /* Check Write Booster Configuration */
+    desc = rsp_upiu.qr.data;
+
+    value = *(uint32_t *)(desc + UFS_GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS);
+    value = be32_to_cpu(value);
+    g_assert_cmpuint(value, ==, 1024);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ];
+    g_assert_cmpuint(value, ==, 3);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_RED_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_WB_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_wb_read_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096] = { 0 };
+    uint8_t write_buf[4096] = { 0 };
+    const uint8_t read_capacity_cdb[UFS_CDB_SIZE] = {
+        /* allocation length 4096 */
+        SERVICE_ACTION_IN_16,
+        SAI_READ_CAPACITY_16,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x10,
+        0x00,
+        0x00,
+        0x00
+    };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 1 */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    uint32_t block_size;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+    uint64_t end_time;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    /* Read capacity */
+    ocs = ufs_send_scsi_command(ufs, test_lun, read_capacity_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    block_size = ldl_be_p(&read_buf[8]);
+    g_assert_cmpuint(block_size, ==, 4096);
+
+    /* Check available buffer size */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0xA));
+
+    /* Enable WB */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_WB_EN, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    /* Write data */
+    for (int i = 0; i < 256; i++) {
+        memset(write_buf, 0xab, block_size);
+        ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf,
+                                    block_size, NULL, 0, &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                         UFS_COMMAND_RESULT_SUCCESS);
+    }
+
+    end_time = g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+
+        /* Check available buffer size */
+        ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                             UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                             UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0,
+                             &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+        g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    } while (rsp_upiu.qr.value == cpu_to_be32(0xA) && g_get_monotonic_time() < end_time);
+
+    /* Check available buffer size */
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x9));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -1234,6 +1401,13 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };
 
+    QOSGraphTestOptions wb_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8,"
+                                             "wb-max-size=1024,wb-min-size=256,"
+                                             "wb-max-lus=1,wb-cap-adj-fac=3,"
+                                             "wb-reduction=1" };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -1262,6 +1436,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
+    qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
 }
 
 libqos_init(ufs_register_nodes);

-- 
2.48.1


