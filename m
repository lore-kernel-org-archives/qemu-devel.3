Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6353CD5BB8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCY-0007e2-Vs; Sat, 23 May 2026 12:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCX-0007ce-Q9
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCV-0001UG-Rt
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NFtDYC2359358
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fx/0nUFoQArgjX5Wg
 9BJ8UizOveP8WnrqthgIS57yuM=; b=WLDQl3fu7ppRouMHl3Jl4X6yeor3UcKbl
 +ZLHMM6VcN3b3zU3asiuoqBKAhAPXv4KKLYzA3T5yRkhmn4jzUHgnWO9oU/ZF89p
 RrjdNyqc1UVpcVpF3OD9pElbmdxxiXTP0BAqk7gGG7E6lUqiPAsK+zllQA4kALmn
 up8LroOCptpBAXeUeX4wz5zfs4LEProgofQOcx6IJx172YAzuSqavcF/yUd6sa+j
 Wfg5orFV2yKc9Q3eLDQLbOTOBmDER5JOf3uwtk6DL1gaZAP2OjFIEMJx+oGgkPb/
 OKuE16X/Urmk5A3GI4jVbkgLZ9ayFU/ViuzCFehGGAyTJpGFsGB7g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21gud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NGO6ou016111
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46nhrs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGRgXr48955740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 16:27:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1570D2004B;
 Sat, 23 May 2026 16:27:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCF982004E;
 Sat, 23 May 2026 16:27:40 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 16:27:40 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PULL 4/5] ppc/pnv: Make PowerNV11 as the default powernv machine
Date: Sat, 23 May 2026 21:57:23 +0530
Message-ID: <20260523162724.95229-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2XR6O-6j_nFa5ato-trpT5qf-a9mwn3Q
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11d582 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YpvtxgsHfqG9jXpqftsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfX7xQL4QdY72x6
 HLngzSAfrykz1UZkpl4h+aZaCoC1j02doPWW1JMmxxObJ8e4xvcGWiY0ho5jlooub7n8kILG8s2
 Nr0Z+dqvXgIOStE0QExBJBlcaULdxxJuChVdeoemWSsf0UEgcscM1AJ9xRwpMWTEJKBHmh3adbe
 DY6aZmUGH8fypvksjz/8qIsBoHAIg81ttuSOgeMOS8vk+4/O/VxE4HXJnCCDfPPdx/TtkG3aXJo
 lOQdAYNHZBJSIy37481WMz2RX5JhhbMcRFOJHk+TfbQghkzbwCfcHHudHSc4Ggj9htBVeggUVTN
 UwRKnPJMJn74ouM/WL0MIO1T7pH8abkQiCxAa4YjorUJMI+WNGkOZ8gaEeHR4fQ5/KBNg/bz+7p
 LIjMzAs/j1StwCkpmylHIPX0mpXUkkuxSW4RfgugO8fHjW9vbcDOPJTWQf4E8A8W014XGjQm/N3
 Y3HXqgIUiZIqD//ej+g==
X-Proofpoint-ORIG-GUID: 2XR6O-6j_nFa5ato-trpT5qf-a9mwn3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

With Power11 being the newest supported Power processor in QEMU, and
sufficiently tested, set powernv machine as an alias to powernv11
machine

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260521200844.1449023-2-adityag@linux.ibm.com
[harshpb: corrected Amit's email for Tested-by tag]
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6a45852174..8df697da94 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3470,8 +3470,6 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
-    mc->alias = "powernv";
-
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
@@ -3548,6 +3546,8 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
 
+    mc->alias = "powernv";
+
     object_class_property_add_bool(oc, "big-core",
                                    pnv_machine_get_big_core,
                                    pnv_machine_set_big_core);
-- 
2.52.0


