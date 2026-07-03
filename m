Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D8EC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZlr-0004QE-HI; Fri, 03 Jul 2026 05:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfZlp-0004Pa-UF; Fri, 03 Jul 2026 05:01:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfZlo-0004XD-HS; Fri, 03 Jul 2026 05:01:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636ISf91761147; Fri, 3 Jul 2026 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xiiSZZC3xrwNxKmcB
 bGt8MQheo7KODvs7aC/xlgItzI=; b=axp1B4QzqtGoqeOYnpHK8OOkrjCnTuuEz
 lx40ykj3JWshRRVD5263gMwDnRDoHoBzgX8tuv2AjvO+IP+/1IHeY6zY8cF2mNBD
 8MAVo7sD049QHrOWL2CIeE11TKXBmpWJH6eDuTTSVKsMjRRkqY9gn54zG0BjENI3
 VGE7Xuq33uAKSgAtpOlhOdUDiE8Qj8Eg6HoY6JfPhLC4s28yZ7ZbSihnzMjGtxO8
 QCR5/0Eaw2pZ57F7KGFwGmTBb4rA3Ls96M06LhRFYGyB6O4eBObvv3Vqslce+1/Z
 18r5a7fj9Xt9n7+YxvZa/NlWsluU/sRCfuhVUr6xb1B9joj03OLgw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5w5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 09:01:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638ncci009229;
 Fri, 3 Jul 2026 09:01:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyqsmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 09:01:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663913i242664394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 09:01:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D20720043;
 Fri,  3 Jul 2026 09:01:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2789920040;
 Fri,  3 Jul 2026 09:00:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.212.167])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 09:00:56 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 RESEND 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Fri,  3 Jul 2026 14:29:55 +0530
Message-ID: <20260703085955.2318600-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703085955.2318600-1-adityag@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX35Sp9MeBYcnx
 EdMPufUZ1fS2yzuRW6GmigVqp2xNANVCeVA8WdYfhNCg2IynfXyBT5p980+3VsH3JiCh9I8YfAp
 Xklo1A/lXrDjb5di8bw7SIJRrsFYPqGrYtyMVunbXf2GyCmlORNq5vAi/XdGjrDyI3I6IQoO1LM
 uaM1RJywdcld27uAdnO2TMoOUzws2NUsT8IIj7V4aM5820aPIKf4PXIaODsgl5c0qVz6Yav+A7L
 dQUcFcmYHuJOaf4jR7vqupgjxUyR3ygWCBaPxQIYW4fVxMJgYIN1ZTRv6ehcBeaElpzN5XncraY
 bbnHj/UWUVbI6nhJF3vwsdNFLfrnderLLg9YWtFhP8Mu5ZeNOh3dvH5QgjUYDxNipXqlE7n4SQS
 S6Zh1fIZewXibrJA4GUIhxapxebkrt20oVYKjo7Wc0PvL92Lx/+wjEunf+pUG0BDuZmPdGiZy55
 +Or/TTapmuD72CZWm0A==
X-Proofpoint-GUID: VHJ6FKEB83rwZ0Ec5WBWYTGRlaekagNU
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a477a54 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX7lcQlUBzbiM3
 wx5Ekv/Ql1aTdW+E+w9rc4EzTHAFT0zjihxr8RQyl8lh8bxW4O5BEjeJKQoNKqeELMkkIrmE7xo
 to9LLUoQacvQbU5RsWnzZ9A+kK9Pcos=
X-Proofpoint-ORIG-GUID: UgboorAGuOacQs7AUsk4D_ruekwqJneU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded61..537b5cd895a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,7 +1663,7 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.55.0


