Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E4CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYrF-0006sz-RB; Wed, 22 Oct 2025 09:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYrC-0006d3-6H; Wed, 22 Oct 2025 09:26:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYr9-0006Go-5k; Wed, 22 Oct 2025 09:26:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCIm4d002574;
 Wed, 22 Oct 2025 13:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=An+0Jc
 o86VmFjVn79M8PLV9SwpfIrdPlgEqPbZRqkfQ=; b=D9/Fwx47xYxOqxCCgg1s+4
 Bo6nEMu5uPBm4Pdt/9IER59fFMwnFY5bHrPu9bfqQQKyDCoB/K6BFubbxcQECYaV
 Da8Pb8kaK/Yl4NrRTjRfWXmW93MHIlgxsal5WFgpXAy640GqLTce3t4JpXuUzTcZ
 YIZbh3IEXwZPfiBJtiNsLqz3uQrHFMEV16HurJNAcSGTfNx9VoUxfcao4MPAEMWf
 X98AbxIZSBZt8kVMaTqR4fGNTdEjVCoId0WAEVqonaBnMkNj/SFRQuJS32BsI2dI
 3J0nn7ncPBX+cEaXhK/aPILXx1XWulpzQnx6UG7YbzYPlwv6d4exvDeErz2RazBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s4x9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MDHZwF015959;
 Wed, 22 Oct 2025 13:26:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s4x9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MC5Ehr011066;
 Wed, 22 Oct 2025 13:26:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx188fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:26:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MDQCSI30671166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 13:26:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 133F620043;
 Wed, 22 Oct 2025 13:26:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 580382004B;
 Wed, 22 Oct 2025 13:26:08 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.31])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 13:26:08 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Patch v6 5/6] hw/ppc/spapr: Rename resize_hpt_err to errp
Date: Wed, 22 Oct 2025 18:55:09 +0530
Message-ID: <20251022132507.1597232-12-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132507.1597232-2-vishalc@linux.ibm.com>
References: <20251022132507.1597232-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8827_Cf-vQo5XWg3rhdrAAFxdKVMXFPP
X-Proofpoint-GUID: LRNQ-ZxUZLSU2c0YbwWuSH-0fmENdbgY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4R+hfyfcpM9w
 gJKx+/QIOe1AfTg2GW02833tHVekXYi3HUUDLytiFIYbluzG5SaVzNrnnsW3AhXLzcvlQzC2WFe
 7ZtwaZRlJjt/o+h8/flko6QrLhZxok4mx+aqejxtMgUSL/6rRV4OZ8GErM0bhhaaQCwd0gpFuEN
 TNsK68pmZ5NIgGrPbHqgxyMq5dtYhfMeHX2khDAcQLOWzRGb6oYKITJ/nQOkVkfzehRT/QvWAa4
 lJNDjBf6bjIUWEPbwuMhlhuOUPsQckIhBQ/zsZFFv8s/GHs6R85WPbcWAxSKMGSQWzlFOwowLpw
 wRFLsvUlz0CH6wSZuoEJpEQmdXKdOs8ngdzNn3td6meLThakwA3sHDbkZZ9m343EP0Jv9QoW/gP
 K6By/pPFFLM6ux78F+2FWXd5A+er5Q==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8db79 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=96G5eRrKWJyLIaa8IewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Rename resize_hpt_err to standard errp naming convention.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/ppc/spapr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d69117d3b4..e51540a5ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2817,7 +2817,7 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     long load_limit, fw_size;
-    Error *resize_hpt_err = NULL;
+    Error *errp = NULL;
     NICInfo *nd;
 
     if (!filename) {
@@ -2845,7 +2845,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Determine capabilities to run with */
     spapr_caps_init(spapr);
 
-    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
+    kvmppc_check_papr_resize_hpt(&errp);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
          * If the user explicitly requested a mode we should either
@@ -2853,10 +2853,10 @@ static void spapr_machine_init(MachineState *machine)
          * it's not set explicitly, we reset our mode to something
          * that works
          */
-        if (resize_hpt_err) {
+        if (errp) {
             spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
-            error_free(resize_hpt_err);
-            resize_hpt_err = NULL;
+            error_free(errp);
+            errp = NULL;
         } else {
             spapr->resize_hpt = smc->resize_hpt_default;
         }
@@ -2864,14 +2864,14 @@ static void spapr_machine_init(MachineState *machine)
 
     assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
 
-    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && errp) {
         /*
          * User requested HPT resize, but this host can't supply it.  Bail out
          */
-        error_report_err(resize_hpt_err);
+        error_report_err(errp);
         exit(1);
     }
-    error_free(resize_hpt_err);
+    error_free(errp);
 
     spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
 
-- 
2.51.0


