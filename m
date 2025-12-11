Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81DBD4335A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTorH-0007uB-BM; Thu, 11 Dec 2025 17:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorF-0007tO-NB; Thu, 11 Dec 2025 17:09:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorD-0000tW-FD; Thu, 11 Dec 2025 17:09:57 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBJgn6T017182;
 Thu, 11 Dec 2025 22:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ygMSstDWdmKL7JSMN
 5viGFPtFnOaimhntt1h2aL45e8=; b=byuea66E1X3h0Yn+rsAWlv+Re85Cycsrk
 t8ZCuAi9WeQuMy4vqmfmGLDk5hrkgznbajslLTVPS9h3WZasrQrGDOn+OPRM3Olk
 ouLntDrWqRDcLN2adLnb4XAuCgl7q52N3YrJHsG4LJP1zUFhKbZUSthIgc8FaQPA
 y2/una7ftaYwUJSpDJtYug6YncYjfWHoTCcpDScpaVaOd32o2Qttx25jYEHRKOIE
 4w0ZCVldcTssXeiwb0m6OuMbmy49Yl3M57WnphYlSGuBxHpk2nUb4NiRs2147Ni6
 Bw/6q1KH5SWXHvt910SdMGxPTEXCilIDIjd3sEuKnNSMzkn2hOH1w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM75KM031980;
 Thu, 11 Dec 2025 22:09:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBLhQ5w008391;
 Thu, 11 Dec 2025 22:09:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn8vdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9mCi30867880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A846158043;
 Thu, 11 Dec 2025 22:09:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D34505805D;
 Thu, 11 Dec 2025 22:09:47 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:47 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 5/6] hw/ppc: pnv_core.c add vmstate support
Date: Thu, 11 Dec 2025 16:09:25 -0600
Message-ID: <20251211220926.2865972-6-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfXz/r/7uNFeZa6
 5uh6QdV1IkoIPTtjIPArYdNtV2lbDM8Ld86AAkSb4hopzTZbm9E2TsZbJQ26FikBvqMOCOCKg4o
 /xQEDZVdUG1E/ETjUikAKOGHXrZhhG6f8z7gcvfwTqvxvYS0S8P7PpD5wPsHa2e2Zk6jAMvoBrL
 +xsgZa4Mm47s1WNIATqLt+NX2AaWeH5DI/HQwsQgR0tR9K5qBUqw6tdodsUABQIAaODowQcsQKV
 kdvgayUQSUW+EaTzejrsvb23FDipsjW1IfYzvAOhVBd3Z5UgznCo6oZRKm2uCORAsfC9TyePqTS
 7XJc6d5vv48d8Vf0RTTYsrB73NialKkR5ZNL7KJjYvFztAlWZB7xF4vez5UEs1+xbwHItzLwNOM
 X/OnrMAgcNYJ+KXharozfqv5CK2wQg==
X-Proofpoint-GUID: pwJFbsTRD0N0cT-iy6_53ZLZ7ZuUnzvR
X-Proofpoint-ORIG-GUID: OSay_35Yuj3l0aDvAOhl7WNWu6Be-I-x
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693b4130 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=KKI1ENItW6cRV8dWla4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
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

- Removed VMSTATE for big_core, lpar_per_core, hwid, hrmor, and pir.
- Removed quad_id vmstate

Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
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


