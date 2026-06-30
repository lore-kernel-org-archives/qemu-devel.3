Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E70C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVoI-0002aJ-BF; Tue, 30 Jun 2026 06:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoH-0002Zy-Cl; Tue, 30 Jun 2026 06:35:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoF-0001zK-RR; Tue, 30 Jun 2026 06:35:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9nG3C1535003; Tue, 30 Jun 2026 10:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7qK60Cak/o69NgfwuKeggui4RaYQpsU4ujSk+MrFu
 VQ=; b=NOMmLLhHjzkQ2ojYmNuKuavJkv5h95wxtJuN3gwmOM7HjEROHFgxSBBxc
 H0rmCG3CiQhoyyaRD7YEVtZ8bc4mrMtss+e936zoR7J691frlY9BhJWj26Rp8Vk4
 wlj20rp+kwZG8sa7cZenHrT6LZBa0EPtJgqN8TIb2Q3qreCibR77D99rxbgqDX9a
 pwtGVBcqwMh3Y/ImeC+7P+siYNXBkECNwNLHATZxz0YJ8g2Q8sXp1jY1jxoLIPTP
 hVJRXTBm5/u0CUu27CuZHc8FSy39bym6NenZub7BFYXVQ7vNXoCqjYxRRPqPHxQ4
 qtGnNTkFypga7YBbRuPUDLY2woTjA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjnw3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UA4cEG005983;
 Tue, 30 Jun 2026 10:35:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy9ebb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UAZDO839911818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:35:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3139820043;
 Tue, 30 Jun 2026 10:35:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04E5620040;
 Tue, 30 Jun 2026 10:35:11 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 10:35:10 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v3 0/2] ppc/pnv: fixing external dtb
Date: Tue, 30 Jun 2026 16:05:06 +0530
Message-ID: <20260630103508.254000-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX7ar3sF6gpega
 LCTL9TSBD6o6dYvnWghnTVbtExaAwvZt2Rkb4/rv8cb2m7segZS2NpQJCH2RjJkd0//gGtgSWg9
 b0yipv+IYWATdhnEuIXoUqTzueXGNAJUm5i71qR/Z8T4+REyxCT0YOoeMGWarNjB8+elwJhV9/D
 aF0K27Che27xlldbWWG/I9Q14W6+AYaWYLvJTI7H3O9glzOBVL5fDWpF+Uym1eJX0l35dtxSTuI
 tEZz3TUUPsqzaQEayWwQ9cpWbNXMGDWr7kbYbAVYsCe4+wC0bWQpLgozthnHjsV2kweyYWXDE2t
 UZ2HTkAMzWXnU4cYG4At8EMkaDvm00FPWOZkeyHEWWCPaPEG6O9DtkvP45IlbEb1aWIHUs9HruA
 2V8Haj662jvQUS6yt0Gw8NyDTdAOsBDi38lIVqcoEAujn8/h3hZw/Bv87YKlAIvZcW3lg7bPXwy
 4Sgd2MwN9wHYSRq5wew==
X-Proofpoint-GUID: fKMDpBquFVqJYfQEhn5HNQVHhxwC71CV
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a439be6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HK4ePdA0MMetCi7OCQ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX5Lquv2ECJLNN
 fX4WeYDg4J2a6nqIeuCnCUqCjwKmFOWPj2sOVEcyAR2kZd+QPPow/o3W2YwwUJygMOBzX8+Gip2
 DrF8NLCIdHRuHp6Hjt8qOTbCIsDo+eQ=
X-Proofpoint-ORIG-GUID: ljwVn1iyn0UXvfM4fWFhumzDs_qHxekA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Currently powerpc pnv machines doesnt respect `-dtb`
argument passed from outside. During cpu start content of
machine->fdt is overwritten by `pnv_dt_create`.

This was previously found and fixed, during the discussion
for dumpdtb issue [1]. But reintroduced in MPIPL support
[2]. Saddly it skipped in the review phase [3].

Adding a functional test for checking the external dtb case
in powernv11.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
[2] https://lore.kernel.org/qemu-devel/20260310124619.3909045-8-adityag@linux.ibm.com/
[3] https://lore.kernel.org/qemu-devel/abAmBV7g_bGNw0Ax@shivang.upadyay/

Changelog
* V2: https://lore.kernel.org/all/20260626112239.177191-1-shivangu@linux.ibm.com/
  - renamed dtb file appropriate name.
  - addressed identation and spelling mistake by aditya.
  - keeping reviewed by from aditya.

* V1: https://lore.kernel.org/all/20260623063156.1110370-1-shivangu@linux.ibm.com/
  - change dtb from power10 to power11
  - refactored pnv_reset code to not `load_device_tree` on each iteration.
  - added commit message body.

Shivang Upadhyay (2):
  ppc/pnv: avoid regenerating DTB if external DTB is present
  ppc/pnv: add test to verify external DTB is honored

 hw/ppc/pnv.c                           | 10 +++++++---
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.54.0


