Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D5C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Yz-0003LW-7S; Mon, 03 Mar 2025 09:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YX-0003AG-LB; Mon, 03 Mar 2025 09:14:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YU-0006Uw-1H; Mon, 03 Mar 2025 09:14:05 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523A2SnX004858;
 Mon, 3 Mar 2025 14:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QnrxR+pBQM2eXc4Uq
 sCpdZPLbczVq2jMp7TVblJKPUw=; b=XVPciHpgd0KCtwH45sweQr8hWVayz4J+I
 5r43XQertFNfFh7CTaXAHS/VGZUmZigYy+pvs91aM5n73tGRka6+OaGcDdd6Gm7N
 9yVhiOVyLx0MasjusOumyK6OB1TfGoPM4FDd8vnMyy0o/2oqscQFQ1IO4FqGRfcF
 ZL8Ye/HQ3TU4qSFU0a8yYBeUzYhVdntRvXOeYBgrE4vFRdj6Al8Wkxham37FE2wq
 Cuw/b7REaUA84bo1Gw2p4/raRueUJZVyS5+HzAMhlH93fVU5aQvnUbLNPs+Y8QeT
 hY8tFCQx7sU34PIt7Qj6l/Zek5t4ocmv8gcnqWzouHUFBlQaAh0tg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455aaps8ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523EDWLS028566;
 Mon, 3 Mar 2025 14:13:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455aaps8jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523BJ4IB008940;
 Mon, 3 Mar 2025 14:13:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxy7rym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 523EDnJp52167150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Mar 2025 14:13:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 326832004B;
 Mon,  3 Mar 2025 14:13:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6A2B20043;
 Mon,  3 Mar 2025 14:13:46 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Mar 2025 14:13:46 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v6 4/4] hw/ssi/pnv_spi: Put a limit to RDR match failures
Date: Mon,  3 Mar 2025 08:13:28 -0600
Message-Id: <20250303141328.23991-5-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
References: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7JXeOV3cOBektWH9taxKSr16dlNNfWPD
X-Proofpoint-GUID: aBIP2l_-7HU4-7CUnTUa3QYdhWD2FSH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030107
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There is a possibility that SPI controller can get into loop due to indefinite
RDR match failures. Hence put a limit to failures and stop the sequencer.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ssi/pnv_spi.h |  1 +
 hw/ssi/pnv_spi.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 6adb72dbb2..c591a0663d 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -40,6 +40,7 @@ typedef struct PnvSpi {
     MemoryRegion    xscom_spic_regs;
     Fifo8 tx_fifo;
     Fifo8 rx_fifo;
+    uint8_t fail_count; /* RDR Match failure counter */
     /* SPI object number */
     uint32_t        spic_num;
     uint32_t        chip_id;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 83221607c9..126070393e 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -20,6 +20,7 @@
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
 #define PNV_SPI_FIFO_SIZE 16
+#define RDR_MATCH_FAILURE_LIMIT 16
 
 /*
  * Macro from include/hw/ppc/fdt.h
@@ -872,18 +873,27 @@ static void operation_sequencer(PnvSpi *s)
                 rdr_matched = does_rdr_match(s);
                 if (rdr_matched) {
                     trace_pnv_spi_RDR_match("success");
+                    s->fail_count = 0;
                     /* A match occurred, increment the sequencer index. */
                     seq_index++;
                     s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
                                     SEQ_STATE_INDEX_INCREMENT);
                 } else {
                     trace_pnv_spi_RDR_match("failed");
+                    s->fail_count++;
                     /*
                      * Branch the sequencer to the index coded into the op
                      * code.
                      */
                     seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 }
+                if (s->fail_count >= RDR_MATCH_FAILURE_LIMIT) {
+                    qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: RDR match failure"
+                                  " limit crossed %d times hence requesting "
+                                  "sequencer to stop.\n",
+                                  RDR_MATCH_FAILURE_LIMIT);
+                    stop = true;
+                }
                 /*
                  * Regardless of where the branch ended up we want the
                  * sequencer to continue shifting so we have to clear
-- 
2.39.5


