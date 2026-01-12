Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7F0C9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGh-00041b-5i; Mon, 12 Jan 2026 05:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGV-0003oD-HF
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGT-0002Mv-DM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:15 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLlVhK022229
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GG3l8hJ5lOnCOENrC
 nlEV53BjU/WwUJKlQUVDAPMSUc=; b=JWZMd6ALoxEkODN4q7EEBZhKJ0M8zyD4L
 HCcjj5fFFjBHpQciSf88xNMsGgIDjjLulrxAzrtSkprQXc+T9vfJQOXlPB9xeYj3
 w7I1ZEhqx8mSzf8b6dPeEXUzFQy3bsL/jnkI4myv04ZC1rk72YxidhW0N2QexEUC
 AiLx8N2f+Hvfv08+l7gJTy7M2QX2b7sw7k+58gmyvSW0+VRTYVjI/VC8p/MkswOp
 4jWp4VeqgP3nVLPR7u03ZaB22RCNPE1AgssmrArsRgdnG8b+S74So9ESI/qYpD+d
 M8vVzebFtQwvau0Sk3vVNg6noe1ogLhCATCpdXPJmMzZesNoJrxTA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsp9w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C94b0H002510
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13sdj54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAZ4sw60228092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:35:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7EE920043;
 Mon, 12 Jan 2026 10:35:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0188E20040;
 Mon, 12 Jan 2026 10:35:03 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:35:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 07/10] hw/ppc: pnv_chiptod.c add vmstate support
Date: Mon, 12 Jan 2026 16:04:30 +0530
Message-ID: <20260112103433.8451-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX+8SJDhBWIMnC
 qci352xikuEPjj/1MgH8Fn7unlTqqfcIoSz/h4sqDssyLD3uawXkLtu3dWOnN7mHCw1KLu30RAZ
 /ahKMtLvbnAGj2AcRIPnw2EDEYtHvxFWZKVf9fKLWx7O+QZToE7pk2BWIh9DZh2z3HDtZCFybQu
 Qy/+IKtnMiOIkjIasDNLR3W6ijQ659ojSJd8snqkLSAmJ/qyA8ly65qGRq0EqG/7ulKIX/kJqBY
 ZrVCvpTckmTZHfDR1tVxYBLZ3TK7fru41/LrtED55Tj8waBGtKo/KW8F9T8NRE7qjH8LbE5xh9F
 KIN3lXGyap8H/fuYhiOZDFh1u7eOLnOMrYhlU22d/Ogt8Qt1nWz0Ur7cU7tWGpzkeJhAfDuJzqX
 RpGfnMtoliPDyIo7YwMfeD2Ow7NItSbMf+NGzYhA/jio6VdE4DNHnYgw+pL7w/sbb+Krcr5KTpL
 HNmPpenRYsdtM0Og8MQ==
X-Proofpoint-GUID: 1hi3B1K2ugIpQPW703ySZpo4qJf4mj9J
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964ce5f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aOXUxLJ6JlOQ0ORGhkoA:9
X-Proofpoint-ORIG-GUID: 1hi3B1K2ugIpQPW703ySZpo4qJf4mj9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Caleb Schlossin <calebs@linux.ibm.com>

- Added pre_save and post_load methods to handle slave_pc_target and tod_state

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-7-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_chiptod.h |  2 ++
 hw/ppc/pnv_chiptod.c         | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 09a5a52ac7..bcf9b615a4 100644
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
-- 
2.52.0


