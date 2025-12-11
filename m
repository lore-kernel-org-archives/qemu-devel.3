Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE6D4335A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTorH-0007uM-Qm; Thu, 11 Dec 2025 17:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorG-0007th-Q3; Thu, 11 Dec 2025 17:09:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorF-0000tr-1m; Thu, 11 Dec 2025 17:09:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBDfhW3020228;
 Thu, 11 Dec 2025 22:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FrlZwHxUraAXwhYyS
 hW28XoHuYF/alVtgcPQHSAO0Ig=; b=JnUWApExJaZpfpsFxw4HtKljxIMZ6m/RW
 7hN4ZRwd7uAy/Y8AkIoA6FXCivh7FAwMyNAIQ43+EYyZJ+dIGuC8+ENsuRXVbXW6
 VVNSwRMCrayPmN8efi8dGSWBareHoVNA2Oeaji8or5KIFXjq6wBX8VYARGOhAeFR
 yfIT+SqoSBBDOOXT6+rsRaY/qdcVAeElHTeLR0BzNj73LfiXHS9BUM4lUgzz01aq
 SBeCO+ZrHb7RW094KQgczyfbUnMO0QP9MBK3k0OIA9si/+Z9DdLIFaQ09rJFp8mR
 ctNAM4B1ZTRjvQyVcHUO72oFBKgrZn29O0HOp0JuzwHwHZ0DMYtLA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53sk7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM7Epa030830;
 Thu, 11 Dec 2025 22:09:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53sk7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBIroUc026789;
 Thu, 11 Dec 2025 22:09:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1gjwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9pKx28770996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5EB258053;
 Thu, 11 Dec 2025 22:09:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D879E58043;
 Thu, 11 Dec 2025 22:09:50 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:50 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 6/6] hw/ppc: pnv_chiptod.c add vmstate support
Date: Thu, 11 Dec 2025 16:09:26 -0600
Message-ID: <20251211220926.2865972-7-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX0xeAKIYgeBWR
 SZiFwZdFkht8xf1JZw294TxenEqYXmJ8xShxO8/r6BDfG7wwX4e9yLtF0u8Hyd2TptAGHVmYiOA
 aUmxhjwM3/0mlhksxfuGw2V3Wjg62+1HuR3Ct8IbzvcWQfwiO500V1evFFMdP1mv0RGIobpBU7/
 S93n3p0fmCR+z+yj1Tn/Kt2qmlMvvKTv6RrPJY7zkdSQaTIh4/UVxGpWHQfNfzLvC738d5loROT
 FxKk5VAmrg9MxoFd6F/JXLSRVIAGNp7aZLJeDKMjWVsK4KvA9lN8gVgNCb0DC2QxpI6eK7nP6mi
 e5fFoC6F5H6+FkR33ykBM0TwwiZraHKq7OLcf7FmFFnz1NmW+86pQLZFeNMLn+k+dJ3SmrL0spL
 8yY/keKxMQp8vMdcgtubvpQ2Ke6fkg==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693b4132 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=txxOMR3xnhxhWtf-mN8A:9
X-Proofpoint-ORIG-GUID: K8iq5w8-SeQDjeDsQ7CqBzCeN7L_B6Vw
X-Proofpoint-GUID: udcoutYoUC-35LgziSNGLDTytZ-Wi3rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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

Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
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


