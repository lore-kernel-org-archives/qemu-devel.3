Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E4D4335A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTorA-0007of-Uz; Thu, 11 Dec 2025 17:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor8-0007o3-SH; Thu, 11 Dec 2025 17:09:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor7-0000ra-3P; Thu, 11 Dec 2025 17:09:50 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBJ3Qhs027524;
 Thu, 11 Dec 2025 22:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rj+Bv/ZDTNuzXDenr
 KI5me9VuCCuFuGX+EqeVL+6lhI=; b=SY8ckZoI5Za+E3x/wqHmI80F1wOZSYZqh
 mi86Wz8GwR11yCwOvexBE4j/uCtl66rlP0A2egjBVXUz3O7NK9XjxxpS0j3fej6E
 k8NnGMg5G+7cFQTFi728BMoyp4WgV94U7c9LqWx3IzVP/Qv+IYRSqfDbRkrN8yf4
 rBJOd00m2VBxEh8r2lxw9RP5S+vkUvf6/Cm6fX2AUf3YZcVqpB639ss80igOyfDm
 aUJDAwf3zDfSFd9v1t0xzWrwalj6A6YFySPVt771b6Gg3Vp6F31CSspLQBoiQNNg
 8VB8NPH2L1f9Wu291FuJLFFpyaA7BUPRI1wy74LOw0rBSZxmpFAcA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM3g1D026523;
 Thu, 11 Dec 2025 22:09:44 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBKFZ9J030340;
 Thu, 11 Dec 2025 22:09:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtsh137-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9Q4E17761002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6E1558059;
 Thu, 11 Dec 2025 22:09:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2683958043;
 Thu, 11 Dec 2025 22:09:41 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:41 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 2/6] hw/ppc: Add pnv_spi vmstate support
Date: Thu, 11 Dec 2025 16:09:22 -0600
Message-ID: <20251211220926.2865972-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX+eRJhk+kMSz+
 kN1jW7G3FOcdHae7x/5s2zktJ2RUXqI5QBV9DDiOwKd3gW3TgCBH4MqQQWK3okJwjfY2AyFa8RQ
 mYb9oLRVGkez5HFG4sR0RGbBFkP806ZtR7AJo2Lgsd4x/bNWPY0M+Dlt/upo04ABJbQSeGbUyuH
 sAlZLEwGCbg7oe7VvKng6cbt/Z7HKNp95PkllB0odhLgocaVphfRsn8dKSXiRU4YmMgAoYYT+1h
 hTGVBnIHBuFKBocLK4flnNfPCjLxgc+2r+IudDqu5d35J08458255ZedK9l/kWWqclkwilMidaH
 W9uZ1IxufXi+xbsw8HGnJg8ONN15fNpd4HGEcGrCoCxgRNYuUiOj0OmPv3EzLjqgzzZ2rybAWEW
 3+AJHqglo4aesY5lVvA7AeiTSbn10w==
X-Proofpoint-GUID: VK33VY4W_oLJRhdgF7I94qjccgq4LK1L
X-Proofpoint-ORIG-GUID: 7rZFXKRDVDLbzeg6ZB3LGagLmVBxxtGK
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693b4129 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zPJzuvo3V7OF8ZkWVCkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Add support for needed PnvSpi structure variables

Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f40e8836b9..389a2cca6b 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -13,6 +13,7 @@
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ssi/pnv_spi_regs.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include <libfdt.h>
 #include "hw/irq.h"
 #include "trace.h"
@@ -1199,6 +1200,31 @@ static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
+static const VMStateDescription pnv_spi_vmstate = {
+    .name = TYPE_PNV_SPI,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(fail_count, PnvSpi),
+        VMSTATE_UINT8(transfer_len, PnvSpi),
+        VMSTATE_UINT8(responder_select, PnvSpi),
+        VMSTATE_BOOL(shift_n1_done, PnvSpi),
+        VMSTATE_UINT8(loop_counter_1, PnvSpi),
+        VMSTATE_UINT8(loop_counter_2, PnvSpi),
+        VMSTATE_UINT8(N1_bits, PnvSpi),
+        VMSTATE_UINT8(N2_bits, PnvSpi),
+        VMSTATE_UINT8(N1_bytes, PnvSpi),
+        VMSTATE_UINT8(N2_bytes, PnvSpi),
+        VMSTATE_UINT8(N1_tx, PnvSpi),
+        VMSTATE_UINT8(N2_tx, PnvSpi),
+        VMSTATE_UINT8(N1_rx, PnvSpi),
+        VMSTATE_UINT8(N2_rx, PnvSpi),
+        VMSTATE_UINT64_ARRAY(regs, PnvSpi, PNV_SPI_REGS),
+        VMSTATE_UINT8_ARRAY(seq_op, PnvSpi, PNV_SPI_REG_SIZE),
+        VMSTATE_UINT64(status, PnvSpi),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_spi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1209,6 +1235,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
     dc->desc = "PowerNV SPI";
     dc->realize = pnv_spi_realize;
     device_class_set_legacy_reset(dc, do_reset);
+    dc->vmsd = &pnv_spi_vmstate;
     device_class_set_props(dc, pnv_spi_properties);
 }
 
-- 
2.47.3


