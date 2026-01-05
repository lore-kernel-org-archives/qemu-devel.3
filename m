Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F89C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn2x-0005DB-0M; Mon, 05 Jan 2026 11:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn29-00052H-6l; Mon, 05 Jan 2026 11:02:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn22-0001IW-I4; Mon, 05 Jan 2026 11:02:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605CgZIK001294;
 Mon, 5 Jan 2026 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hR9Op/uk0vupq98tW
 hVjphviuJajcEYo5k/Jema+QAY=; b=C259mRjn9kX0AMOl4HFIozJIPQB0D3e7g
 ypAi+wN7oKbOGSikYKop46liSS4/Wagr8mMe0PUMP5xcFxFIHaGIygXeZopVdE9E
 T+EdiuDciLJ/efu1LgU+c0ZqxTglgNZ0VjavFEfVj/B0hQu5gB7bvFNa3lLVAOyM
 IHbgRNgoFpG0NdOQpUOBDxfYnM2yqT4TFeOq7TSxWR5VFdMXM90x7tNirRgQ35u+
 ScgdS9uQqIOism/FhUceK5xeIsLvcFuEq32S0EIkgUxHPE+rb3SiZIu7ZzY8aYzX
 MlHSo+kaptxWnkkGiQGKDKDXIqGtysDUnlAfhruLuDOSFh6jftqHA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfdba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605G1wuP021213;
 Mon, 5 Jan 2026 16:01:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtfdb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605ExDOU012572;
 Mon, 5 Jan 2026 16:01:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj6ev7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605G1uc455837100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 16:01:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4DFE5805C;
 Mon,  5 Jan 2026 16:01:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F06B45805A;
 Mon,  5 Jan 2026 16:01:55 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 16:01:55 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v4 5/7] hw/ppc: pnv_core.c add vmstate support
Date: Mon,  5 Jan 2026 10:01:36 -0600
Message-ID: <20260105160138.3242709-6-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105160138.3242709-1-calebs@linux.ibm.com>
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695be077 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ijNBCCglf-f1jh5ZZN4A:9
X-Proofpoint-GUID: oAJbwRLgc7i6kIQuhZ_eBeC0RGh1KU1S
X-Proofpoint-ORIG-GUID: snn2PLAr_xh0UksLzNcMti_Aju1gtCZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOCBTYWx0ZWRfXxjjO8fupe1l2
 AwXZm6xZsNd2+gkHei3W5iuycwfTpIy7TiB70xci51ur/iaevK4hf5kihTA/rapAxKuZMdIpjcD
 86N41pzu5/0Y9KfrcwrOvDXUfqCui3VwoSFE6IoNlztuxuldodUB+5+LwVqkv3PYafmFWeV9Adr
 zKP4NXsxq7IUwU+4Pt0ovhF7wXB+7SVmamPYYXEXI7AQC4uGShGaGT8HpPGLqZx0F9lch0WmoJV
 Jj3VmkSqviyEmNqNlon562SVUYQOjpsgq6GRvBjX50+i2PE7sYBti1vKgN+BMr2q7QRjuVid39u
 fG3E0LTgw/Du0v66486JVpi3zgQqekOIv7rW/CTprZrbgmgF4804YpxJXIlvhtH+6XzQIrOYBsQ
 rGBBk2elJeiZw8VegDwnF6fqt25C5vuLHC9kweCs8fcztwso2vxh0vTPEfgOsfP9ZHIL3h6Z3QA
 awOVx86NBG+9T25w1kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050138
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

- Add vmstate support PnvCore and PnvQuad capturing scratch
registers and special wakeup registers

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 59a9eee597..8939515c2c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/core/qdev-properties.h"
 #include "helper_regs.h"
+#include "migration/vmstate.h"
 
 static const char *pnv_core_cpu_typename(PnvCore *pc)
 {
@@ -478,6 +479,15 @@ static void pnv_core_power11_class_init(ObjectClass *oc, const void *data)
     pnv_core_power10_class_init(oc, data);
 }
 
+static const VMStateDescription pnv_core_vmstate = {
+    .name = TYPE_PNV_CORE,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(scratch, PnvCore, 8),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_core_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -486,6 +496,7 @@ static void pnv_core_class_init(ObjectClass *oc, const void *data)
     dc->unrealize = pnv_core_unrealize;
     device_class_set_props(dc, pnv_core_properties);
     dc->user_creatable = false;
+    dc->vmsd = &pnv_core_vmstate;
 }
 
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
@@ -737,12 +748,23 @@ static void pnv_quad_power11_class_init(ObjectClass *oc, const void *data)
     pnv_quad_power10_class_init(oc, data);
 }
 
+static const VMStateDescription pnv_quad_vmstate = {
+    .name = TYPE_PNV_QUAD,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(special_wakeup_done, PnvQuad),
+        VMSTATE_BOOL_ARRAY(special_wakeup, PnvQuad, 4),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_quad_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     device_class_set_props(dc, pnv_quad_properties);
     dc->user_creatable = false;
+    dc->vmsd = &pnv_quad_vmstate;
 }
 
 static const TypeInfo pnv_quad_infos[] = {
-- 
2.47.3


