Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F55C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 10:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfxkB-0002kf-QR; Sat, 04 Jul 2026 06:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxkA-0002kS-8M; Sat, 04 Jul 2026 06:37:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxk8-0003Hv-P0; Sat, 04 Jul 2026 06:37:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6647G3bs1065842; Sat, 4 Jul 2026 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KoIeVJ3ETvOlh+yzj
 sUUUmKatfq2crTb3gHjH9JpjUg=; b=olMTwptYEg+aHaL75FQugDNvmjWno0Ase
 Yp+lQy18BXk6kiq+ht0DaiyXJEiU7RLoCd3cENQVGnkAx2ixIdlhDY6BXp43TZlk
 o2GJa5C9bWEr+ihraBDoDrtX2rc22iDJsIN7bDPOrPf6Fi5r1qCfOkwNTWAsU9gL
 y7VMu4CuIYvv02VvCJEPlA8uuffLtI8etTFHji+ZSD5valt3+iYEc4DSMPOK7OjL
 MZw4uWKCv4UHGzqpXTLue81K52LIsnUB02c6Z1GCJI3kBDVTgfOdg1hL2uHBhuWN
 MW+DIAXp5A8v7LfXW24M/v+0WPUWD4fJNTJou3OjBkDwalSEo3pTw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suq9150-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:37:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664AYaZ5011065;
 Sat, 4 Jul 2026 10:37:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wme9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:37:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664AavKf29032890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 10:36:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80CB820040;
 Sat,  4 Jul 2026 10:36:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C146A20043;
 Sat,  4 Jul 2026 10:36:54 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.212.207])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 10:36:54 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, sbhat@linux.ibm.com, gautam@linux.ibm.com,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 2/2] MAINTAINERS: add self as reviewer for PPC KVM CPUs
Date: Sat,  4 Jul 2026 16:06:16 +0530
Message-ID: <20260704103617.632929-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704103617.632929-2-vishalc@linux.ibm.com>
References: <20260704103617.632929-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfXxKy2NS7VJj95
 7TatVLif9FilA54gudnkb7ebfisFKS5js/NgblBgBKQ+WiVx9kV6IuNmPomyoxwlQnwqmKCKVYy
 bjTiFS9sXMgkXv7vLIrUXpmGb03KPAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfX1i4oXQR/jlk0
 PMyW+3rCOQd3H8Cm0BoQ9Uc8+sNUdJggmcCKXOAw857996EtKDsPcAvLKIQBvadViHf5TKwekLJ
 NthAX4IRIz7s75eIGvy0Qf1pMxiYnYq0TUtCUfzfxtnJIZoHaT99PE2fKxme9HZ18ABBEO2KLa7
 aeqS83lSrkzV8TrgOcBI5oibwN0NLoOvJn2O+LM7xNjLf3i1gp65ppg7dkx0rfT13jmiEGETK3C
 PxV1nHsHO/vz2IPB0v5lWjMW0ZMYsqC/w6sgEG1PJxHq3pTL5WV9iStN8M/SNvEuQLH7Ur58DxP
 1PvxGCuvcWUtMyVAP9F6p1kKFvSYVUj+ePVYDXsSAuC3SC3zGyPrc10uIdbu+3kYNw8iOEVUJXf
 zH/nlGNQhoWF9THlDpbuhuvyc1i/bpO9wWDoj5YWm1Z3Zuc1Ft1OqMBvcUORPWe6Xj8oNwB+2Wd
 TQTbXvsBqArsnGTTsxw==
X-Proofpoint-GUID: AlIXd5-EqdvD2dwgQCtpYuu6Y9AqOd8T
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a48e24f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=KiPbuy1ShhI8k8eQ5nMA:9
X-Proofpoint-ORIG-GUID: 4Q-1btzrP_5w_gbgdCfdAe87Fl3udhUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

As part of my daily work responsibilities, I actively investigate CPU
hotplug functionality on Linux and have been reviewing related patches
for some time. I'm stepping up as a reviewer for PPC KVM CPU areas to
help share the review workload and contribute to maintaining code
quality in these subsystems.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb19e868b4..43f87269be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -488,6 +488,7 @@ F: tests/functional/aarch64/test_kvm.py
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
+R: Vishal Chourasia <vishalc@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
 F: hw/ppc/spapr_cpu_core.c
-- 
2.54.0


