Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B9FD609A8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWkq-0006rO-G3; Tue, 16 Dec 2025 10:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWko-0006qL-Fg; Tue, 16 Dec 2025 10:14:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkm-00070H-T4; Tue, 16 Dec 2025 10:14:22 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGDCLau022048;
 Tue, 16 Dec 2025 15:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jcAN7q4Px4l/w7XdI
 +IIyXW1K41nZmGak05mxyr+J5o=; b=mji73KhfeoeELysJIjWQJm9LTXUnyLiRU
 xPkXNzfgxUhcRrkbXT7DYdpHAx22u+21/AnCDwI1PwMO3YtdKGhWM31fkgToHzsb
 Wumj1VLTHE/Xc2n+TNWDv229cAdzWaiFli+YD5V6KJHnr0lZIT4EptVJUIKpJSUH
 A+zTnb7ABAwNTGm8EmEnJADYtOqBC3gFg3bImFOk8LvlKPdTj9J6Vmayfimk6ABI
 7vSTAWmLH09iW/xY/bH98t9N7YBIbtRcr43k3Dge4MomVQglWVOQlTcc4uvH3mIR
 W4DSFDv7eT6D1LLnoa31myzSGm2PFg9WfZih1JHEuPrhXpZDClZGA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1f2fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGF8kLO008542;
 Tue, 16 Dec 2025 15:14:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1f2ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGDvu2C002755;
 Tue, 16 Dec 2025 15:14:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfn4rur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFEFvU29426338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:14:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C28F258059;
 Tue, 16 Dec 2025 15:14:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F04E858053;
 Tue, 16 Dec 2025 15:14:14 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:14:14 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v3 6/7] hw/ppc: pnv_chiptod.c add vmstate support
Date: Tue, 16 Dec 2025 09:13:58 -0600
Message-ID: <20251216151359.418708-7-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bnpxc4dKcoyN5D4c4v10WcvetApakY8S
X-Proofpoint-ORIG-GUID: Ao0LF4S04T-Pid1S_uH-87X6I4GMIzzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX1P5zR6lPSfeN
 dl3HdLiDawOhpGBoM+Rgsat40pfq21qabrGdxk3G7Kgb/3In/u7+51Xr5Ka31aRCSm/HWPb5oLt
 CWPDiAx+p6jangbk8CtRZMGk4s1+hmwPx8lFQA1wqZcJ4Il3kTPN8Ec1WS+YO5tyK7Lecbk7cX2
 XdRqFcJiBHmyXEQkJhnkSFP6ElocSHej+WumFddcWcFenNPfvqhHTQbUPWwo+74ST0AX+saHN/7
 HTIFthl9yeE6q2LWh8N5nGn9OX7X/NH2dIZyvG80E5Bx5rFKaDJZSM+h7lkRqkdcobEhZwX/wSy
 98RagEbX1FGoec+ljYAbb8JFHQY2TI/eAUcowkCyLAl2exIpAbdBAuWDwqe54B+R5jFFvqbYUnm
 3r4964G5G5AsKBLXC3fLsIAxWa8mdQ==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6941774a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2tKvrj9r5tddppBGlX0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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


