Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B48DC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCc-0001Vu-BH; Mon, 10 Aug 2026 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCa-0001UR-GI; Mon, 10 Aug 2026 14:58:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCY-0003Rz-Um; Mon, 10 Aug 2026 14:58:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVbnO2191597; Mon, 10 Aug 2026 18:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q7oIuPCYo4p+RjfJB
 3jCPNS97if4AWQut/dKB+3wAW8=; b=qyJNvX7InRqp+3cVn5VERfzBHdmG+UBEu
 dEXSqidTKspXndP8CAqAeI/r5hi9nKob9oper0K63iUcc8fu/RGPRgh9zluPrOFW
 jaga77fzRPs24ah0typNbL2h6vTF96wHN6CmcJm4UEFL2Z9EozPqCz65BzwCV6+C
 BWtLpq83neuhsAqiPlsUl4tVfN2rtImhBiHH1dYl+JQs+KImGf9EHvfIrn2qaRyq
 QJAE7H4fNQJjdv7/hjVCEbyPpp8HQ03K5eLD6TACAyiMKYZCfp9i55kbyT40/8W7
 cbFaQCNZsSpvIUGPRs4h+cvz66DXvJjvc3fiObmC+5siAjVzZX3cQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw15js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIuMkv016188;
 Mon, 10 Aug 2026 18:57:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxwu01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvs1021627534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 309E758065;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 983305805C;
 Mon, 10 Aug 2026 18:57:53 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:53 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] i2c/aspeed: Fix DMA receive first-byte handling for
 block reads
Date: Mon, 10 Aug 2026 13:57:42 -0500
Message-ID: <20260810185748.1253-5-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7a1f35 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=82TwdL3_f4vI9uiogJoA:9
X-Proofpoint-GUID: sNgpppKu-6A8fJVbs6ez-kFmg5jMzS0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX1rAhdP1/G+tB
 Tlo7NyQpoTbpf67k/hvRwYo1TPPYziYcrdoj/8gS9LBO07xS8+0B4Euufo5fdtviX1ehJEE1KpQ
 wEMJXCLoaKAPJIt75M20Mhcjub4iO2QFT3AdF6ntfwKG0zWnrULUexYqoVep2E+cqXoBVK8z1qX
 HOdHpVYIJDeAdhQMO3S7vkln2xy8uugGyt/RAqMeZfM7SS5kwCu2ZPKV+nKk9NiQ+mAqtlNmLb+
 1vFvXxaucxdiKCYyYX7jCYeVVRm2JQSuOFvM7I+CicJTSzO9h23Iwi/FSjmB3TAZOWKUnaR/tv4
 ibgPepuaaiZnEhNUynUrsBvkrQPDGk6t0FvWnj3cvSEugml6aRybTStH5Bhw+wz/4Esam6vRt2p
 UnwtPPRCDPWGUL5AKU59sgqXUJfIWqK8kqixEFpTWCXxfasA6zCKWNIqgRwKNo2XvMAN5J8OlTb
 zUTt8jUf5JmIYWMkL+A==
X-Proofpoint-ORIG-GUID: F_99vDrTzkMQVPIu1BP6UJWqfFJfnlHZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXzdo9o+3tiR9e
 HUostSzMFyxMl9xRoNWpheoMGwXRjlXiquHu4Y1RgWQ9AAxXIoYnBnW+Dn/PnXAwXXh3AZnmruQ
 ar5+z8WZR86xxnxTTJWCvNCGzdlg9xM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100158
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


