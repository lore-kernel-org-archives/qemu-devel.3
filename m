Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDF3C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesqf-0008OV-Ed; Thu, 24 Jul 2025 06:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqZ-0008He-9K; Thu, 24 Jul 2025 06:06:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqX-0006d8-Dl; Thu, 24 Jul 2025 06:06:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O4DioC004434;
 Thu, 24 Jul 2025 10:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ByNLjDExmTIg266JQ
 NHp18a51BfWNVrhBa2dUbWI/Jw=; b=WyrQj8dqOV2TC/Vda/JkcIVs1j/5xOaGH
 0/ST++8Zq4uNVLWW3Xfm1H3rrVfCES53uuT43DBDUi60GgpK2Kso6AiAJqte3G08
 RgxoPr4ECxK0VL5tY0Utpma2k5R8QkmXfPaALsS2mgeHYjrQIVmzPx8r4HxL0pjZ
 SuSSA5ar6cc7jZSs0wdLILsDI5fsmO3V912m2IJKT/L5sUlhvPlAYY/etGR1FO+9
 rIOW4C7l/Ivvwwd203MQBLnvJO6frBsRHVkChBGgCT+gSZWjFIO6H5gPaDTu8ZhT
 LBcEwixOku0KIKODNtBzv/OQF/WTFJZPitCQh7al807PVAJk1r/7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff51xre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA6ddO014878;
 Thu, 24 Jul 2025 10:06:39 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff51xrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O8Z38e024744;
 Thu, 24 Jul 2025 10:06:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2krcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OA6YUp55968184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:06:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A8B620079;
 Thu, 24 Jul 2025 10:06:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59B3020076;
 Thu, 24 Jul 2025 10:06:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:06:32 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 2/5] MAINTAINERS: Adding myself as reviewer for PPC KVM
 cpus.
Date: Thu, 24 Jul 2025 15:36:16 +0530
Message-ID: <20250724100623.3071131-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724100623.3071131-1-harshpb@linux.ibm.com>
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XPROkvkmtfZ90cASK-5BjEKIc5Gjyi43
X-Proofpoint-ORIG-GUID: rsV-PDkkBkr0Hh-lXn4i9QWT_97vF7iy
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=688205af cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Wx8enTvzk5m5oACMLf8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MSBTYWx0ZWRfX+e/DcBup4A6T
 dQHNOhz++8WAneHNMFMtMGftviYuk2+hBJn+F9Fbn+H8Q+JtF7zI5EK14NlEhKm+MiyijJC2tEs
 lVHqWJ5+AF2xABHu9/Il05F8uH92gTPWl0cB3tGfm4Kgrcv7oirn4x7P0pu3XdpxqDiI21xfJDb
 WxzJdbKdrL24HKIqRDdHilDAKSVE791UN/3HxiWgMqQEWZDmXhSiWCoaglMTmhNntYOFMk9KOP4
 x2Q/l3Wi6dw+92PRUqFbJTS6R6vhcSQ3nqjXzNGppF9NCcXtRDlDZrnt0+dchH5TwrwXzeXgzQq
 aNBIp1p6NeZDisjLPhHAEuTLSlFY7cnbWzacjqkF4Dj/Lc0Eyi/YzlKnsbSuuu7eaiMnr7cN5TD
 epOwV7zMvuiic7gI1cyQiVoyTYj+GIYwE7xm4itdcIRbAsfFeYKhqHMXRhZD3ccNz43DboWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=525 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Have been contributing in ppc/spapr from tcg/kvm perspective, stepping
up to help with patch reviews and get notified of incoming changes.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index afc94e6e67..6e95ef00c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -453,6 +453,7 @@ F: target/mips/system/
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
-- 
2.43.5


