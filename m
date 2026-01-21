Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83903D4697D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viga1-0007V1-PK; Wed, 21 Jan 2026 17:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZw-0007Nt-PM; Wed, 21 Jan 2026 17:21:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZv-0003hW-2v; Wed, 21 Jan 2026 17:21:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LD05OU006258;
 Wed, 21 Jan 2026 22:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SZ6rjewYExYpU3EnA
 JJL8Qg2URw2/DN00ZZ6Galxmis=; b=ELwp1ioCQdHW5x0BNcL0L0/SRR0YTCV1o
 aHM8SYPoalKSDIfRs0zXHTcPfG5YBubRH8KmyLPF2rb+7P5I0HiGCm/ThhuwR26u
 F7F+YRYV+toezvwN8oYyBj5JSywF5Ivy32cOYOBD4tIhAdxZLrGQGeVymDbKGk/w
 Lej6QrqGCQCA1FpJtnNdBT5SNz2VOaZCte2w4601roKT7MqOJOIGDdBd9UiLP/wv
 Bg1N+cvGOxa2Txm6AuRbZIY3CPdP+MUmt4Sh6z2zHKD0GXBxLvCyVmOTMmUaPYaL
 hZTaR6X4Ljr87hiEj6p1Jklt7wFFjuV5PFhyxbbalo3t0/TXZjrlg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6tkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LMDnN4024634;
 Wed, 21 Jan 2026 22:21:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarw57d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LMLNi834734558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 22:21:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1727920043;
 Wed, 21 Jan 2026 22:21:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9247020040;
 Wed, 21 Jan 2026 22:21:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.153.49])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 22:21:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] target/s390x: Dump Floating-Point-Control Register
Date: Wed, 21 Jan 2026 23:12:31 +0100
Message-ID: <20260121222116.713325-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121222116.713325-1-iii@linux.ibm.com>
References: <20260121222116.713325-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5GQWqxmMCY3CbdpOuGvKd4e6rz2uQbYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE4NyBTYWx0ZWRfXy5oKLJKLeiaW
 HQgdxj09NKLDBUBSYXfiTAhersqMwEQPs11VFhTGpsEWd5bdAIfS3Q5rEPO1SIHEVzpLN+n3R1k
 HgqRrmdTwxRpzJGZKTHwYM/hAlXX83Ss1E8qXGu22Y8DlNd5yOwANJyGtIBZIyI99MEA10ufraw
 ot7eO2+P7gjTHXEvhf4ISxWvK1PxpQhFCpzIUGpCNASaedjiFJ3Oxtw9y+zFkNC5SrbAq3wFjbs
 S0N/RsSf/pxZL/P2rOAOvlni+bpcLBrjcSBxa6Pt2dWdaPJ39W1ogmdfAP1hxnWfCba0SYrPc2g
 g2YZeBnU5PZ3chu4E5RrI2PHhTW0GeABWJihIpGGkl2WKKW43E5B8YQ3+o4b7wNNA8fYmATKDNI
 IMNFUEyGWLL9X1EXRo+IYvCtUBPYiR5k3EEIB7VB3w+QzzpJUYPjWXxPTdWw3UNFgtcbHJdTc3p
 ylYcjWZtZVk6jHXcNdQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69715165 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=cezZA3FWbPs5aIUPbxMA:9
X-Proofpoint-ORIG-GUID: 5GQWqxmMCY3CbdpOuGvKd4e6rz2uQbYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Knowing the value of this register is very useful for debugging
floating-point code.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/cpu-dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index 869d3a4ad54..5b852928031 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -63,6 +63,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                              (i % 4) == 3 ? '\n' : ' ');
             }
         }
+        qemu_fprintf(f, "FPC=%08" PRIx32 "\n", env->fpc);
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.52.0


