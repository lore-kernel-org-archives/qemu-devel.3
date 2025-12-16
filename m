Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A8ED609A1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWkl-0006oU-KH; Tue, 16 Dec 2025 10:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWki-0006mk-8j; Tue, 16 Dec 2025 10:14:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkg-0006tS-2U; Tue, 16 Dec 2025 10:14:15 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG7eELm021469;
 Tue, 16 Dec 2025 15:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rj+Bv/ZDTNuzXDenr
 KI5me9VuCCuFuGX+EqeVL+6lhI=; b=B6y9j3LmK74bMHSaqkbl6vU8t8Lc+yO9w
 A+4hzgnYUTjDOhGDrwHGc77bj8sopuc1cqCLQK2lb7MUud6sBnJrxJiMS8ba+cKx
 uvipFVGBtmCcz4Bx14Z0jxj+WjNNfO/uHd7jgrAHCieVUYGoi5e/ec/xol7yuZ77
 FVbxD4YaUBwUUq8f3uWZKPU99AMiIqS9sCdjSPgxrE1hHwLTGWMAuGoHrdJzjW64
 R0t5oRpY3p9SpUq87CUXE38RmIei/v3RZdZ4vS1m5ppkM+CnbpRquOGyRgYZB77Q
 Y+Ux19qBT0IMrmf+VBTtpY20KL340trqFRvoXlEeOr5UFzr68tzqg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpyepw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGF43sH013822;
 Tue, 16 Dec 2025 15:14:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjpyeps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGEbQsL014318;
 Tue, 16 Dec 2025 15:14:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjvg2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFE8Bu29623018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:14:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C977958053;
 Tue, 16 Dec 2025 15:14:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0334758061;
 Tue, 16 Dec 2025 15:14:08 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:14:07 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v3 2/7] hw/ppc: Add pnv_spi vmstate support
Date: Tue, 16 Dec 2025 09:13:54 -0600
Message-ID: <20251216151359.418708-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfXwGpXq4/nT5m4
 ozdtOhkPB4NJft13sldzvRlIcJIsE7gyTjWAm94eDsqLIUV/LqtkU1f9MOhb69Gr94L1llfCAM4
 inyCNuTFRzx2FEARtimPMIYKeOinKdRu6z3IsI4TSiRtjL1t6pqjJdDBT0mBl8jTZWvkchDLAHn
 OFvea/saq5SKLzPXHYbrc3QeD9YznSaNs0XX8713KsjGLMBsABnBBNN9GmfdZxEZ/c+xyBtNe/N
 7f+PEhMtp86wE/1Ans9pcYtfKWqZEDG2yLvE7qLNmY98mzTSuKKXRtOWiHstGpcExXr4oCjAqfE
 HtXjiqABTVSysy7pFbbYERR7TZAj6F/U2eq0b6eEcHpJb8EIj3UT+q17WP+tmaK72PKsAN20sYs
 2yvUHx5FxlTj5Pr91qHq6KCxCmTRXQ==
X-Proofpoint-GUID: GXqHPSi9i7MtF8VfoXypmjwhdyaqcLa8
X-Proofpoint-ORIG-GUID: 7yuowEONEKmdiWrBCbsrTmLq0BsMNfzH
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69417743 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=zPJzuvo3V7OF8ZkWVCkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


