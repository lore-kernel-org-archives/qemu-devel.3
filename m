Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800B0CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEvi-00058F-Pu; Wed, 10 Jun 2026 05:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEvg-00057P-3k; Wed, 10 Jun 2026 05:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEve-0000qH-M6; Wed, 10 Jun 2026 05:08:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659IpTL83192673; Wed, 10 Jun 2026 09:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GrOYJIn8ptcNMNucZ
 iaJehBnDBtxdZaXEYhSoZ84oEU=; b=mg3iNdiLBWfw6l7/OmGfWFfY07Vc0DP4f
 TexqS9OB5o7t6PJM+UiYKvoTesvmutsGTsZ78/R1eLj07UVIT0ZLQdteM2kJTdwK
 WIZHPAY4IwB5bOLd0RJ90IGM6wos5z90osNpc7K+osD5rvUvdCCN6w+rpwyAeM+z
 Mac/DExa/Zfq9Ja3RiZYbedBzBDqpAjzTTbTc51cp8qEVKhfBcEcr/AOSa09Jgxo
 ICcQzmESoSp6smYh8TajjduK2FLTMvhdiTIiH0cSek+65J+Wf1uMxSb9a3RpgaKz
 qRin2DTOI6gVZr1Gbi/fHUxnLnsK0Jk3exM5gDjmG0EmYslQmYAig==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95gbgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8ndaU023972;
 Wed, 10 Jun 2026 09:08:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jydq9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A98aAa31588732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:08:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE53F2004D;
 Wed, 10 Jun 2026 09:08:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2093220043;
 Wed, 10 Jun 2026 09:08:32 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:08:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
Date: Wed, 10 Jun 2026 14:37:59 +0530
Message-ID: <20260610090800.3672832-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090800.3672832-1-adityag@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a292999 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=W2f51_xLFnIr7Ag5nCsA:9
X-Proofpoint-ORIG-GUID: iGIzkLQZbilvXsQ3Ua8S8m-jJAknfsJe
X-Proofpoint-GUID: 7-RvDAn_s7rwNB6ZAtNoOaOx0wOG-mtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfXwl0+njFQhEm/
 GKg6xqKMUcUCiGhUteiUQbiJEsqdcUft8s+8QYJIjxfiTEAhShJTQZV1+h7E/YcuEsMx1JXUQbY
 DGDB9U0J5vcGNQR7+VR51L3XEMyskKoMEdXE4HlwTrG52gB2rqnmwCBi44a08vTg/I+ujLnPvLW
 xMjrd27pPAyvh7V0FblluqLPm1cBYai6LIwcwqhCeztFs2WECpulnxkSXDfpGm4JdTdfEIsPkc+
 sQz9RnxjlZPHJB8DWn9NrkFjsLUBLWdwD55AIeO7c6ET15hOWSvG2Z56UB1HwXSk6T0//NHhLIZ
 /uihaSthNXXgJMy4Won9wkmlv8exma6VF6jpcNn1eU3bTRBrRlu1VJ+AYblbmvpO+CBKNvQIT/u
 8oflxFrABVmCd/jKZxhf9h85DNVGrtL7WY0E5bOSWYXlpp5GCq7K+FqDaSHxjaJ+/xSa/CDdpId
 0dg+F1QAmCy4/4tc2Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/pseries.rst | 2 +-
 hw/ppc/spapr_cpu_core.c     | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index bbc51aa7fcdb..1477028bc5ea 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -16,7 +16,7 @@ Supported devices
 
  * Multi processor support for many Power processors generations:
    - POWER7, POWER7+
-   - POWER8, POWER8NVL
+   - POWER8
    - POWER9
    - Power10
    - Power11
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 41e37103c043..9a9351991c95 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -408,8 +408,6 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
-- 
2.54.0


