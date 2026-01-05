Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE69CC79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn3K-0005ZS-7u; Mon, 05 Jan 2026 11:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn29-00052G-6d; Mon, 05 Jan 2026 11:02:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn22-0001Hx-Hn; Mon, 05 Jan 2026 11:02:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605DmNT0012556;
 Mon, 5 Jan 2026 16:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=P6UXoVjvsDkuwgnHd
 VavBdkRzuZbxGIl5ksQA7lT53Y=; b=MBHiLLTmn+NaAt0C0YT0q/ngzEEF3pXZP
 jMzHvSOg4BR1C9gaS/NHYdaxIDlIBs8d0X96ej14DNekgwIVHa39Qzn+hlJKFM47
 336S/znwUByl5dTBUTskj90fqojTWekB2HPOFA9Ez5eLVHmYtvc3M97SaQEePI7B
 Y8ffz010sfXP5CEaBw2pczQZuoEQTRfRsD9UTgKi9+Ax+ciGTCgbBFQ7r+JQXsTt
 /flH+4Z5UeNFUeqdgo9TC4Las2hWyrIJkOSV/+gobmGWldI5H+PrkDq7L8UARm0z
 ZdR12I/49vVMmtPw2oTCn5kHmJmqw+2RbHAIOn9+/soMH0LdfQUZg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu601rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605G1rlm032411;
 Mon, 5 Jan 2026 16:01:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu601rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605EErbN014523;
 Mon, 5 Jan 2026 16:01:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeempnnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605G1p9W58786206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 16:01:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34A825805C;
 Mon,  5 Jan 2026 16:01:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F9F58054;
 Mon,  5 Jan 2026 16:01:50 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 16:01:50 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v4 2/7] hw/ppc: Add pnv_spi vmstate support
Date: Mon,  5 Jan 2026 10:01:33 -0600
Message-ID: <20260105160138.3242709-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105160138.3242709-1-calebs@linux.ibm.com>
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695be072 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zPJzuvo3V7OF8ZkWVCkA:9
X-Proofpoint-ORIG-GUID: ciPb-7xuckwYJy2GYg_YvaeqbCN0_x1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOCBTYWx0ZWRfXwrfON48b95QT
 aC3D5jUkCQ5l4OChUoobe5sbOMsMwMDGqWOKfa9vnAgshwJyuBukEbnBKpSqjA0Z9EmtuE1uawz
 SURVpNkVXGqOf9gGG1fYMS2zFzX4z9OUuQv5j7Exx6OP74R7Uc2ao3jZd8VHl+dtV+QjMtGv7jT
 1Exxfv6+IbVFvHO6MXlZb2OF/lyc76EHBW+u7GbaZU7dPPOOsRhK5DPAZqVP1LlRoP54k8s7vbX
 BvMMK8Y4dJRHT27OdQLnJBOvfxsHJgCKvPJY8lyoDb/hUBwmL8cseOwbueHoo1nhB97krW+jmjL
 eqGVSKB22dQsjEmm+Pol6wpoql5fkxbdcoFPV3uybRGwv5JZIO6qmYaxKMMVarPSUlu51NPmyA5
 GND0JVvSv4sMlJpQkIMausexZWUU+J4ky0omQobtuwvvcVmodzESCHYrJbJjwnPn9jP0KQNm+iV
 9qTtfYdXDtGmlRLJjZA==
X-Proofpoint-GUID: vQZTk2MXKBjN7-cVNUFT4hSJvRQlWBJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 1cf3a4416d..76304d26fc 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -13,6 +13,7 @@
 #include "hw/ssi/pnv_spi.h"
 #include "hw/ssi/pnv_spi_regs.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include <libfdt.h>
 #include "hw/core/irq.h"
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


