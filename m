Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFA4C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGO-0003ZS-Kc; Mon, 12 Jan 2026 05:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGM-0003US-VC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGK-0002HT-R9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:06 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLG7mY003154
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TsDVCGu7EMrgvK4IC
 gunXCK5qbSqmbDED8pjmluh8YA=; b=ML22tSn0b7C41l7DJ/8gQd/yDizwVVzZi
 rlaPVRPRnAxTeY+3ZPvEfTG5eD39cgg34dX8fnvC8DV6e+w+Hw2mCqc/6EV23XZ+
 CWa/uuIe1KNtbWVHrC9ay5sHZxyAgNeVZlJ+pAEXdqTwVnlX8nc2g65VL1KbLB8v
 YMCtwzbcQuMU/1cm1fsY+Ufn2PrZEEorbxg8wBcvq6EHaOq/5tr6VjCPvJG3GNa2
 BccUbpk01O8okSWV/hhVFj8QE14IClUO9cHrsBL+R2DQJaiH5n6ESPThtUTU/HYH
 udaZJKYUMiwVz9FueIHvUGEbvXKHVL0BhylDjq8ECPpD5ht0OuDRQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92pk3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAYmZt029743
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajd73r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAYw9751511570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:34:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCAB320043;
 Mon, 12 Jan 2026 10:34:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49FA520040;
 Mon, 12 Jan 2026 10:34:57 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:34:57 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 04/10] hw/ppc: Add pnv_i2c vmstate support
Date: Mon, 12 Jan 2026 16:04:27 +0530
Message-ID: <20260112103433.8451-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vfvt6m54VQAWAtuxEla8yohOK1i6dXQx
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=6964ce57 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Zxc3rZUEGKWGcrBLKaoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX/ZBV24eREeLw
 4QxqHIBbPF6BRmviwUv+8cRTMkRqBztKsOpA56DcFUY0JOP9qhNNOWeEhotAeDcPEbwocGEGEro
 0urqGmLWQ4bsmfxiB1g3EYoMoGrvkJki4GO9KMD0vIsk+RkHyRd7+SzNgJiQbWzbBH/NwYT3aHV
 lTNpcOUmT6mr9wQdvFnS8vpeRZ0K5/ggMkpDTmWUEazFTVmzSXizA9ocMxNIFESz8okBO9wu1hn
 8nqOHa5DDhqCKqACjHE2hFHRhIKUswANW1hohHGdw42oHocSP91Hr5Wz+To6NbqiOZHFTvFRCRp
 G2L7+736fkwL+7GwBnlipdCUmcPuYtXBSZbICWJ0kY0lA/V02+xWfROWX4rFrKTbWH0JzYZ9qTn
 GgzaGbiMWiLRBdueYWwelOyvPJ04eaFTM9ECA3IeVlofhwUhhcjIZ9Ug0I4sNAAC+NDcIpf7NKS
 956CsmUUO43HV5BoWGg==
X-Proofpoint-GUID: vfvt6m54VQAWAtuxEla8yohOK1i6dXQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

- Add vmstate support for i2c registers

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-4-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index c8e90c636f..60f7164a1c 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -19,6 +19,7 @@
 #include "hw/ppc/pnv_i2c.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include <libfdt.h>
 
@@ -549,6 +550,15 @@ static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
 };
 
+static const VMStateDescription pnv_i2c_vmstate = {
+    .name = TYPE_PNV_I2C,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvI2C, PNV_I2C_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -561,6 +571,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "PowerNV I2C";
     dc->realize = pnv_i2c_realize;
+    dc->vmsd = &pnv_i2c_vmstate;
     device_class_set_props(dc, pnv_i2c_properties);
 }
 
-- 
2.52.0


