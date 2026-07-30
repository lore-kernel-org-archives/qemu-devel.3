Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C11C5516F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5P-0004Nx-TX; Thu, 30 Jul 2026 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5O-0004MU-OT; Thu, 30 Jul 2026 16:10:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5N-0001hq-A4; Thu, 30 Jul 2026 16:10:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJnFdg3878694; Thu, 30 Jul 2026 20:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q7oIuPCYo4p+RjfJB
 3jCPNS97if4AWQut/dKB+3wAW8=; b=kdxnhdB4+rY//wFWSmzCSEUIkGnmrOiZO
 uHnucRR4HJenMVTsEYQ990U/pM8fFVzvlokQl3JZQS2pJZEIZqxnoKX/dKtYEraJ
 XHZzdojBmiXNj/g/tDg5Fm9yJ73ptDnb7u/3GPNWda/wgPrvzjfPVnQ7Exf0Z2fj
 pIRMn0L31NY+2SXIMOxPM515wn3I0pJYfHtKV/hvwjaP0QUvPxRIytuYNrRdum9v
 3Wi0vwmnSa4WGP1l8QPwEfN9sZjBglhWEVGXCNXAj9cQ1m/cNSfgzNYrgA5r1bLa
 CTPx8Ki2+e50PhFq6bhRfoJpD8nMibgkAVHF4Qx6z7oD1TaN7FU1A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p0rwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJfQJo022888;
 Thu, 30 Jul 2026 20:09:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqn4g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9mgH9437720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D73F258055;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 824265805E;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] i2c/aspeed: Fix DMA receive first-byte handling for
 block reads
Date: Thu, 30 Jul 2026 15:09:39 -0500
Message-ID: <20260730200945.1113936-5-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730200945.1113936-1-mikail.sadic@ibm.com>
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX9Ib5WQIGA3va
 wx2IrXhUTpER0EnXQQqSHiw0nKuDCws+PM3sl70qwzzV3YfGfePXMLpPFCEvaq4zb8QKQWNTqtQ
 Uzxp6a1MbDh2Y+9DS6qdAkrZ1EM9wIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX/UpgnRoE6ioX
 aJT7RqLwLhAs4V3E8yVw70E1YhxCR6O+NA6kmES4RnSwLU2km40KXGTeomIxYTgkyaGs9aDed6v
 pJMtN90KzJnx9l0rlpoiGcuxGzWPfWx9OiKbE7yJJW90XWGzAK9XJHo/Ohke4NMyVrxLn3g9Bbb
 gi5BqPCc+Og2heYIXA9frcyWm46Dunr56ugAVHZRdL1AQaHkgMOCwrqJllsDURnX7Spz/qUqBu7
 WMj4g4SGu7orNh+c6Cr5QcEXQaaFzwbbJJE1KP/No59Re+b6FILK6D5du60mpdEViFsQrggymiG
 xNMqTQVcz+ix4tExjKfJBhPBtI3uGuSN2cLHg5XmRsQejScR1Vy/rKtTIeatchJZmubTpPCE49T
 s5v9GyGbS6Oy6DkiU3Br6YwxF4/c1JcRnzec2odf5ppXovXPVyzBLeCHdaR0GhfPAMUtnmfq0bQ
 cabOHqD3Kzkjmi0GtIA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6baf90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=82TwdL3_f4vI9uiogJoA:9
X-Proofpoint-GUID: 15bHUHUO4BdO7DqZXfKyAbJetaJ-IBfd
X-Proofpoint-ORIG-GUID: t7HXCBzbbRNUkpfalDDdzmwR-X-ZZ8fI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mikail.sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

An SMBus block read (I2C_M_RECV_LEN) reads the block length from the
first received byte. The Linux/U-Boot aspeed I2C driver obtains that
first byte from the I2CC_STS_AND_BUFF register (modelled here as
reg_byte_buf), even when the transfer uses DMA. The DMA receive path,
however, only wrote received data to DRAM and never updated
reg_byte_buf, so block reads read a stale/zero length.

Mirror the first DMA-received byte into reg_byte_buf so that
I2C_M_RECV_LEN transfers using DMA report the correct block length.
This is required for the ucd9000 driver, which uses
i2c_smbus_read_block_data().

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 hw/i2c/aspeed_i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 27afcaecee..facb54d27e 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -365,6 +365,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
     uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
     uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
+    bool first_dma_byte;
     int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
                                                 RX_SIZE) + 1;
 
@@ -391,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         }
 
         aspeed_i2c_set_rx_dma_dram_offset(bus);
+        first_dma_byte = true;
         while (bus->regs[reg_dma_len]) {
             MemTxResult result;
 
@@ -407,6 +409,11 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
                 return;
             }
 
+            /* Mirror first byte to reg_byte_buf for I2C_M_RECV_LEN. */
+            if (first_dma_byte) {
+                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);
+                first_dma_byte = false;
+            }
             bus->dma_dram_offset++;
             bus->regs[reg_dma_len]--;
             /* In new mode, keep track of how many bytes we RXed */
-- 
2.53.0


