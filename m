Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD21D5B85B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCE5-0002uP-5O; Mon, 15 Dec 2025 12:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDW-0002HV-7W; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDQ-0002iv-KP; Mon, 15 Dec 2025 12:18:34 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFCHumS002244;
 Mon, 15 Dec 2025 17:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jcAN7q4Px4l/w7XdI
 +IIyXW1K41nZmGak05mxyr+J5o=; b=CQdJ/sXH//BtwriHYk60d2KLXuNpD4Zxv
 /piQMG5uEMCZJoRojB4toNyVbVYLRm9WFTF757+5gkFZw9lAivCpMernMEMjXdYZ
 RdUjtPx5QpMfDN5PrujKRw1/80+WBpEDW64J6zotFBE1+Vb+3MZv6ltk9LvolHN7
 iVp11EgHkfX5vpE5saT6HLKBi9EyFu+KSG3WtJ+b34Do9saaIukWYCg4Z+XEz/I8
 Asz5x8oCTxJbsZA0FjO06ERyL6hoR2JDxlOGErtItuqo9OwhKwTEMssMebSZkoI7
 vKVQgJQOZ1nO6Lc3g0q+0a1pv/prmzanKb8AHHX0iu6ex45a5Pinw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjktn2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHITHD007079;
 Mon, 15 Dec 2025 17:18:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjktn2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFFOHhs002856;
 Mon, 15 Dec 2025 17:18:29 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfmyn87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHIRTc23069240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B167D58063;
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B4E95805A;
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 6/7] hw/ppc: pnv_chiptod.c add vmstate support
Date: Mon, 15 Dec 2025 11:18:12 -0600
Message-ID: <20251215171813.1670241-7-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CUQYU40ZZEafyUAy-7KE_aFj_E-Meydd
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=694042e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2tKvrj9r5tddppBGlX0A:9
X-Proofpoint-GUID: A-BL0gcu4_n1fPJbExOdiy0FECo1mRi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX2/2OZ4XN2DhU
 4QWn3pvq3QmLJIpw5dSFR6hPd2ArpfBdD9W8S2XIqJLkOwLaMeCtWTJR3QdKBt3O1BYdw5jC8y6
 Wv1/QHZHfxifPBxyPTSBgX3bu6/g2ipoC1/fcjRav906hvFNVw2oy7Qz0Z/NfCJTDcWhNrWgKIp
 SpWxHXP4Qr2Ea774awBLwRqKhydFqPe6ipfJqq4BmTjuvUpPa0x/ta7EjMHxh98TlyMboq5wmjX
 wSVjhE3WTQSIYOmtBfjipPPqjnIaTJ9jUBmCnqlmnmCXwH9uYF8092nh0DxqUzboJLIdODHa3kY
 duFIXjvAa/fDeaO2P+xZ/p1gAVBR1TUrf7gFD3k/QBsv84tHSKyG1/1XgXon+RpZ5ho+Nltem9F
 mjFRLy+OirkzdNPux9PxUM+ohp2s/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

- Added pre_save and post_load methods to handle slave_pc_target and tod_state

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_chiptod.c         | 38 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index f887a18cde..9dc5942ca0 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -37,6 +37,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_chiptod.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 #include <libfdt.h>
@@ -341,6 +342,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
                           " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
                           " invalid slave address\n", val);
         }
+        /* Write slave_pc_target to a uint64_t variable for vmstate support. */
+        chiptod->tx_ttype_ctrl = val;
         break;
     case TOD_ERROR_REG:
         chiptod->tod_error &= ~val;
@@ -613,6 +616,40 @@ static void pnv_chiptod_unrealize(DeviceState *dev)
     qemu_unregister_reset(pnv_chiptod_reset, chiptod);
 }
 
+static int vmstate_pnv_chiptod_pre_save(void *opaque)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    chiptod->tod_state_val = (uint8_t)chiptod->tod_state;
+    return 0;
+}
+
+static int vmstate_pnv_chiptod_post_load(void *opaque)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    if (chiptod->tx_ttype_ctrl != 0) {
+        pnv_chiptod_xscom_write(chiptod, TOD_TX_TTYPE_CTRL_REG << 3,
+                                chiptod->tx_ttype_ctrl, 8);
+    }
+    chiptod->tod_state = (enum tod_state)chiptod->tod_state_val;
+    return 0;
+}
+
+static const VMStateDescription pnv_chiptod_vmstate = {
+    .name = TYPE_PNV_CHIPTOD,
+    .version_id = 1,
+    .pre_save = vmstate_pnv_chiptod_pre_save,
+    .pre_load = vmstate_pnv_chiptod_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(primary, PnvChipTOD),
+        VMSTATE_BOOL(secondary, PnvChipTOD),
+        VMSTATE_UINT64(tod_error, PnvChipTOD),
+        VMSTATE_UINT64(pss_mss_ctrl_reg, PnvChipTOD),
+        VMSTATE_UINT64(tx_ttype_ctrl, PnvChipTOD),
+        VMSTATE_UINT8(tod_state_val, PnvChipTOD),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -621,6 +658,7 @@ static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
     dc->unrealize = pnv_chiptod_unrealize;
     dc->desc = "PowerNV ChipTOD Controller";
     dc->user_creatable = false;
+    dc->vmsd = &pnv_chiptod_vmstate;
 }
 
 static const TypeInfo pnv_chiptod_type_info = {
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index 466b06560a..3e5e3b02b2 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -41,6 +41,8 @@ struct PnvChipTOD {
     uint64_t tod_error;
     uint64_t pss_mss_ctrl_reg;
     PnvCore *slave_pc_target;
+    uint64_t tx_ttype_ctrl;
+    uint8_t tod_state_val;
 };
 
 struct PnvChipTODClass {
-- 
2.47.3


