Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E559D5B85D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCEP-0003E4-NU; Mon, 15 Dec 2025 12:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDW-0002HW-7C; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDQ-0002io-HA; Mon, 15 Dec 2025 12:18:33 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFBG8ZJ020030;
 Mon, 15 Dec 2025 17:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vakf4KS5jvKAayUTj
 S8UDZ/c6IzELYhdEzAawdQnx2c=; b=bRt/YLFnqIQsQusmGKlfJVBvvebDGS8PB
 PEk3GYmAzVC968zMZzHkg5Wo1ZAWHBzwkEgo2v+rH7vknOO/qXrlZ29iobSNKbjN
 2T7WwykpnYTyDAIsl8Kd0Had/bYntNIbEt9AUuL17bclN128vKYUYtjthpcXlNLM
 tqHf0DMi8Rb95FlZWsedBUCVlTjXmnJcJu3vQ6YXa/1DGaa8R6zEvXGsPNOV9C1Y
 Bb83693lKTokff1MzytktDOx7vphzTtgR5wnFdqTDovyKxxAvSElX7eZPyUdAjke
 UApDPwkUi3am6bK9Fo7Lg6ST1M4uybEj0xgv96r9uhRnkh4pbvaIQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv34n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHBq05003481;
 Mon, 15 Dec 2025 17:18:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv34n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFGNoQa014406;
 Mon, 15 Dec 2025 17:18:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjqc7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHIQpv15663734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8165058063;
 Mon, 15 Dec 2025 17:18:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B27958056;
 Mon, 15 Dec 2025 17:18:26 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:25 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 5/7] hw/ppc: pnv_core.c add vmstate support
Date: Mon, 15 Dec 2025 11:18:11 -0600
Message-ID: <20251215171813.1670241-6-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX9EXW57XNLABw
 atxFhck8FDj+JcD5b3rkVzfKb+DZ7VC2nrbcOj+MOR9JkeJYrOUF4eo3BGLDNMC1HW7AYcFa0kw
 uB/D5CNkxe/ozN4zobDTpL1HiOVuA9tBwnUnkauwkVvFbniokmHy5dSGSKtv9ivSGt/0skECesU
 GaMGboX9Q3GKPghmj9hZww/fG9YRaOPNL8D6nrhy0rviv4dmy7R6Fpou0YcPnQw8lpWhBSZzJTE
 PpOPNPIVnwzC2YwP+gNtlv5HRFbud97F9qoFp2j5lp1x+ecWFwce5YyCE4HcgM4f1mVwyXLGIXG
 qrB5S9Na9/IVmXXjot+Zyr5DssBsKqn+o+vMcij62mkV+Iojt9Qx8ztDwI83mwTIG2XynTljfzI
 1eslxAOZSgahiGql844njHNeON5dlA==
X-Proofpoint-ORIG-GUID: 5TKiE3RR4RUIg1AQtaeFljWuFOmJ2NLE
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=694042e4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=QXuC7XpKZ5phjoL22fcA:9
X-Proofpoint-GUID: Olyfne18taEpvVhX8H4yObEwF2NP_dA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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

- Add vmstate support PnvCore and PnvQuad capturing scratch
registers and special wakeup registers

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index fb2dfc7ba2..03b64f0013 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/qdev-properties.h"
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


