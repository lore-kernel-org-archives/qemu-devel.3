Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D2ACD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 08:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNRAK-0004fj-DK; Thu, 14 May 2026 04:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA6-0004c8-Vp
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNRA4-0001dq-Vr
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bd2c147abaso12208465ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778746275; x=1779351075; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MQ+5ywA3ydfBVc0Y2SIXe1ysRDC1KubdnKS/us59kO4=;
 b=BbfzvFama7deOjubR1gO5O6Vp7f1FzQlqfPnQijXGrH2F6s12JzEFbhGpgXEzSYjvZ
 gWB0TYnt6bB+/+xwgiZlnx+jb/nKtzNk0oFrIpi9mtb6SsxdZxRApEDz+KOCIBKmw15Y
 rGto4zlKo8+x+zz3upoqWg/NTiLjqOPib0eXCcct+n1caAHEa8vnkB/jfkSjei9okkA0
 L1ayaFFyPjPtG2yMkqoHxNUT413M/k9OByk+jWj/Nd4QfKCSKhT4JmjKp9IzgtN6UgmT
 ufVEJEKp/fQjhauSvhK+gPTde+IayPSuefyKzPGOvMxfATvvrTHY4KUkdxLkbprdSqv1
 qLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778746275; x=1779351075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MQ+5ywA3ydfBVc0Y2SIXe1ysRDC1KubdnKS/us59kO4=;
 b=KY1YmvnluNPWUagBwdq884X8sxgOmZtkXXjUyTfvXWLsN8TFeY4o7A+gEfD7/d+eAY
 SCDA1wKg1mhTOc5sIghV7O6RCk41OS07/yC4IL8yqBqA8tZna6XwSyTykNP1FTH/Sq1q
 cEbjxU7TjE5of8gTjqaY8dlFqk5FSp9IIbJtG3cGT7HJDSe/dmxLXhC/lYzdj2KpXCrB
 dRXgSODdvW3FNXa9crXvNESZlpiFWFMwwny8kLsu7+BtXgsexBkoWrXAnsmOc0Vg8zW3
 qizpMbgVkSqvNiX0goVUQrDVVEsOwgtIjRR4cz+eJEqBsOZyRO4+8PC1fK2jjkq7qctz
 x1cA==
X-Gm-Message-State: AOJu0Yw4qnuBc7RA+i1kYpT/j+nenNM/cFTFPObaZDopT5BfHSJ7+mqG
 pqzk9n8m1ZIUtMfvN8RTMmOgqy2qZ9+9vafnX6OeIjTCL6fm0McwIYPX
X-Gm-Gg: Acq92OEmuYdfgbCl3NWM0JRGS0FBniVH+TxSJ6UGty/6nj20SzQ62mg52sGz3/UfO4r
 IK6mTBO79twGf0rWBQp269Z+v3fWzWlWJ+gwdPjXtUxk/8ISUek0RjBxfE8dmZRoJQNMlnFmVau
 1qxIe972+gV+BfobW6j6sdGwn5iCKPz70CNThYvhTM2Bs5ymufCYmWRAbDADRWq7TYNoeIR7+PI
 1jLGqiZvM9j41kZpSQ0qorLPJaBEOM8HTwr8aOGvArm8xXYMGIXJ5ABnyRmncdEl8ywiGV9kSyo
 cQAR1GLQ6kBSEPCl570ZcqVZjB5T3ReQswMeW3vdY43BjxFNL54c9DJyjERrBoo75a+U0j/BsNr
 qEOctZkmSVni/nmhegpWidy3EsUUwQixsodsRS4l6vFUFkxf8qnn8Ugwr9Y4gdbpB3V6L8FNIvD
 E92DAoAao4OSjgolCEzw5MwhrGfOHSQg==
X-Received: by 2002:a17:902:ceca:b0:2bd:2de3:5181 with SMTP id
 d9443c01a7336-2bd2de353e8mr65173175ad.9.1778746275334; 
 Thu, 14 May 2026 01:11:15 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c2631basm14480165ad.34.2026.05.14.01.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:11:14 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Thu, 14 May 2026 17:10:48 +0900
Subject: [PATCH v7 5/5] tests/qtest: Add UFS Write Booster QTest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-write_booster-v7-5-c3ae3452980f@samsung.com>
References: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
In-Reply-To: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778746262; l=8707;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=VF/oNvi7a6+2ChQ1c7V146kArgtcUgd94DaSD1duQAw=;
 b=z2zEWSas4vxuk76WJwPAtvnFNIz/QNB/ucyBVQElOlNbEWd/CV+/4krOiVC/O5BxzFhmiAFCV
 w4PXHqzAnKiASQIySfcedgmVaAfj2S8W5bZyBJwoMCCVdWkP6sNYwLy
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x635.google.com
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
 tests/qtest/ufs-test.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f999441552a105987aaaf8e2b976f4a05f953ed..c33cb58c14e94f7b44a454bce34ad35ecace5634 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1182,6 +1182,170 @@ static void ufstest_query_desc_request(void *obj, void *data,
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
+    value = lduw_be_p(desc + UFS_DEVICE_DESC_PARAM_EXT_WB_SUP);
+    g_assert_cmpuint(value, ==, WB_RESIZE | WB_FIFO | WB_PINNED);
+
+    value = ldl_be_p(desc + UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
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
+    value = ldl_be_p(desc + UFS_GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS);
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
@@ -1234,6 +1398,12 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };
 
+    QOSGraphTestOptions wb_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8,"
+                                             "wb-max-size=1024,"
+                                             "wb-min-size=256" };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -1262,6 +1432,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
+    qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
 }
 
 libqos_init(ufs_register_nodes);

-- 
2.48.1


