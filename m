Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF59CC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kV-00032B-KK; Thu, 20 Aug 2026 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3k8-0002W2-IG; Thu, 20 Aug 2026 10:27:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3k3-0002CX-DA; Thu, 20 Aug 2026 10:27:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K99NPk3543925; Thu, 20 Aug 2026 14:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ONfPp7sgxXk5TVEGKmGxXcFalP++Ski53AW4QOJ+3
 MQ=; b=HVSaJRUgA4KLF/gmICbEDpT8jCmh0i9+FsRPeEcfWTDxRUqi6JpSLkdh8
 w5vKAxEaLVCg5y6E54Fb5E5nz/k90G5b1jUup8LDKXUYxiWlveZAbq03vVphziAU
 6MC4ylR3wLoXNRgp8Mequk1+YO4Ktpt2qN72V0Edf74097gyQBgpvzgyeA13aGrv
 mTzbHhkdxj47GyHC6kHNe/wguDbESai1/NDxfYWK2n3xPArbNTLhyCywDtqlhbwL
 x/FX3O2BQKxm4RQ1RFhTySPhtqiIr9qbA3CVBC0xiafrPyrTKKak6x026QSjIToA
 aok/BpBTbgfq869jNX9YCK2EPs+7A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2as0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:27:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEQYEO020983;
 Thu, 20 Aug 2026 14:27:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpth3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:27:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KERWP046530858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:27:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 136D52004B;
 Thu, 20 Aug 2026 14:27:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F14720049;
 Thu, 20 Aug 2026 14:27:29 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:27:28 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 0/7] target/ppc: PPC ISA 2.07 flag cleanup and updates
Date: Thu, 20 Aug 2026 19:56:57 +0530
Message-ID: <20260820142717.337686-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a870ed9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8
 a=gQ7FEG4IobcTiEelWAQA:9
X-Proofpoint-GUID: Kkhd-WkbT8CLuI_VafVsPR085hMhidRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXwi+nJjvS/DJ1
 ITB/8eaNqWzwew3hyDfdxP8jAXeMf1zP0jENvIbR1750EDqVW3hyxMMl3nCyBxkUAEYQJAqHqIW
 SXOyrt9rKTxJ7VLvxVTZYMoOIYTxCil27/Tp5Stc3bG9H+h6kb/8eFBSUqHSQlu3WBO9laYBzrB
 h1IWAe+AWUqeGfyQ8IZ3+Vd2YghoT2622Z/oHsK+EiKvFQ1et97mh/NznVunOQ7tSzRz1NVOwZg
 bhOoG7i4ZFYfoJAxgvgLwznVY4iBgu+NwOVCQVdtGy9BvD7224iZDRNHS9sjwjS5WZ/S0UFRR/c
 7MT9l5teZuwNlEj+RqP+PL/UxPj7LG/AE6PDMxvpdGEDAHGJtw8SRAg5tVQdmdI9TKGE7sSgVdM
 7yqcwkXJDs90amh+72n41ZdVeYcb8BNBndTQB88x5oqeyD6AnaO+asvXpQF/FzAwQLzHn3FBpzp
 Ebmo7hErCAM+B0QG/xQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXwMx3MkA00G2W
 2Tj0/9P7MVA4erzcDqLJ1jhHlkRyhpDEBJ6yBneaVnDh3us44kUVMVBIjRjLnObdmRscTSqP2U/
 fTNZokijgUrP7zsZQwQdObzVDzoWk1A=
X-Proofpoint-ORIG-GUID: ll4nJ0zzrXd7LsjIQSuXMV3KYhOghX_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

While working with some PPC instructions from a ISA 2.07 POV, I observed
the following :

1. Unlike ISA versions 2.05, 3.0 and 3.1 which have one specific flag
for usage in the insns_flags2 field in the CPUPPCState struct, ISA 2.07
and 2.06 have multiple flags. Upon further investigation, I see that
during CPU intialization (POWER 8+), all those variations of the ISA 2.07
flags are only ever used all together. There is no instance in the code
where a CPU is initialzed in a more granular level, using only a subset
of the ISA 2.07 flag variations.
This patch series hence consolidates the different 2.07 flags, and frees
up bits in the insns_flags2 field for future use. I intend to do the
same analysis for the ISA 2.06 flags as well.

2. The "Summary of changes in Power ISA 2.07B" section in the ISA
version 2.07B mentions : "The icbt instruction has been moved from
the Embedded category to the Base category."
This change has not been incorporated in the QEMU code resulting in
illegal instruction exception upon encountering ICBT instruction in
Power VMs where it should be recognized. Hence adding the necessary
flag to the instruction. Also correcting the invalid mask for the
decoding as per the ISA.

This series is based on top of the patches from another series that I
had posted :
[A] : https://lore.kernel.org/qemu-devel/20260820140114.327023-1-rathc@linux.ibm.com/

Link to Gitlab CI with patches :
https://gitlab.com/rathc/qemu/-/pipelines/2776338293

Changes in v2 :
-Retained all 'Reviewed-by's and 'Tested-by's received.

-In patch 2: Change instruction flag in BCTAR instruction.
The above series [A] now incorpates the following review comment
received on its respective RFC series :
https://lore.kernel.org/qemu-devel/46867b5b-bb66-4378-8722-d918fd720037@linux.ibm.com/
Due to this. Doing the necessary change in patch 2.


Chinmay Rath (7):
  target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
  target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
  target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
  target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
  target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
  target/ppc: Reorder PPC2 flags
  target/ppc: Add ICBT support for ISA version 2.07

 hw/ppc/spapr_caps.c                           |   2 +-
 linux-user/ppc/elfload.c                      |   6 +-
 target/ppc/cpu.h                              |  38 +++----
 target/ppc/cpu_init.c                         |   6 +-
 target/ppc/cpu_init.h                         |   7 +-
 target/ppc/tcg-excp_helper.c                  |   8 +-
 target/ppc/translate.c                        |  10 +-
 target/ppc/translate/bhrb-impl.c.inc          |   4 +-
 target/ppc/translate/branch-impl.c.inc        |   4 +-
 target/ppc/translate/fixedpoint-impl.c.inc    |   4 +-
 target/ppc/translate/fp-impl.c.inc            |   4 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |   8 +-
 target/ppc/translate/vmx-impl.c.inc           | 102 +++++++++---------
 target/ppc/translate/vmx-ops.c.inc            |  18 ++--
 target/ppc/translate/vsx-impl.c.inc           |  56 +++++-----
 target/ppc/translate/vsx-ops.c.inc            |  24 ++---
 16 files changed, 143 insertions(+), 158 deletions(-)

-- 
2.55.0


