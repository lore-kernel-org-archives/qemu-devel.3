Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B7EE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 16:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTkOJ-0005ei-Ok; Fri, 03 Jan 2025 11:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tTkOI-0005eK-3s; Fri, 03 Jan 2025 11:19:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tTkOG-0001aI-MW; Fri, 03 Jan 2025 11:19:13 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503E4Gje026493;
 Fri, 3 Jan 2025 16:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iixKk5Q0dYDDrARCZ
 DFFwcYNAdJEzOCoUjmmBfG6iF8=; b=e7dJKOxXrgL/aXuKXKZRgH12cyKVvVp9+
 S6oB0vdGV4fijnrQOswZfcQIk785MMnSUpwpiExu6WAbnYQOQ+zey4fkbIUWk6O8
 C9Hl2PHEZRVfqn+5NlVCPNBEG4jc1a24CsvOE6r4vutqH40mcvGJjCgfR8i+SPyV
 K0/cPwSNbuEaVZ3Q3CM5XhiZr5twj1VWNNEsRsSoXRxccARMfNp2DAR5nBYRvsdG
 hUoUf9dB0hOZpyEGYA2E7B+I1YDwOY8wMVuWe1jk4Nj1Rj8ah27FyJGoPyEjZoj9
 D62PY/VPsdWFOuh1Dn6EtCqux1uvQB9GismWtN4W/raS7+PnDgVRw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4mab1qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:19:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 503G5wVD002309;
 Fri, 3 Jan 2025 16:19:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4mab1qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:19:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503CKMBb004365;
 Fri, 3 Jan 2025 16:19:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43twvk6qkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:19:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 503GIwtP32112940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2025 16:18:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDD4320049;
 Fri,  3 Jan 2025 16:18:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C000220040;
 Fri,  3 Jan 2025 16:18:55 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2025 16:18:55 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v5 4/4] hw/ssi/pnv_spi: Put a limit to RDR match failures
Date: Fri,  3 Jan 2025 10:18:24 -0600
Message-Id: <20250103161824.22469-5-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWoRzg3feIU3L7dmhPJLkzO_tjjw7saS
X-Proofpoint-ORIG-GUID: Q2VhpmavniXestWuDPCNPVDYrOnpKBGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=983
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030141
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
---
 hw/ssi/pnv_spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 41beb559c6..d605fa8b46 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -20,6 +20,7 @@
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
 #define PNV_SPI_FIFO_SIZE 16
+#define RDR_MATCH_FAILURE_LIMIT 16
 
 /*
  * Macro from include/hw/ppc/fdt.h
@@ -838,21 +839,31 @@ static void operation_sequencer(PnvSpi *s)
              */
             if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
                 bool rdr_matched = false;
+                static int fail_count;
                 rdr_matched = does_rdr_match(s);
                 if (rdr_matched) {
                     trace_pnv_spi_RDR_match("success");
+                    fail_count = 0;
                     /* A match occurred, increment the sequencer index. */
                     seq_index++;
                     s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
                                     SEQ_STATE_INDEX_INCREMENT);
                 } else {
                     trace_pnv_spi_RDR_match("failed");
+                    fail_count++;
                     /*
                      * Branch the sequencer to the index coded into the op
                      * code.
                      */
                     seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 }
+                if (fail_count >= RDR_MATCH_FAILURE_LIMIT) {
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


