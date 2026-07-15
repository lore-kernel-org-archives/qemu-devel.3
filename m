Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7155FC4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzAc-0006b8-B3; Wed, 15 Jul 2026 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAa-0006ac-0H; Wed, 15 Jul 2026 08:57:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAW-0001Bg-IX; Wed, 15 Jul 2026 08:56:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FBfbh82370508; Wed, 15 Jul 2026 12:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=MARTnNLI0VRwE4bn/bgqOK3BSSAJ/ZfxAh1LhOJFO
 /E=; b=aymblFqBvid+YrdbDl17eKVkY9adU00zgJKiTp2yZRwY/ttynQiC9Az3m
 fw1M1madnsCNYVO7LUzHGx3FKAuZ/u8VCDHkEsXRd6hRZn8jQSezkapsckjVk1Vb
 Evw3vV/gDw0D3LowB3odzTd9JtreY7XXI4CrtP+Nylvq5w6xc4Oam/u2GLv9pUX3
 kVPEzw+8eB+jPw2Zv30lHfKfcE98dQNOyx8FGawS66xShDIw2k7nZWU/Bl5z06gZ
 BU4j9NzEGKYJRPdyA2qD0CB2O2T9Lb6hN4Q5nbhxCAcnUn4T4ia5h1oFyx5UoCRG
 BJohIwYCVxBYI1PZP2sONr0P1GxoQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33c5c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:56:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FCnhma024507;
 Wed, 15 Jul 2026 12:56:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw86uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:56:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FCukh748431468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 12:56:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5931B2004F;
 Wed, 15 Jul 2026 12:56:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 447DD2004D;
 Wed, 15 Jul 2026 12:56:43 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.30.15]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 12:56:43 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com, shivangu@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 0/7] target/ppc: PPC ISA 2.07 flag cleanup and updates
Date: Wed, 15 Jul 2026 18:26:27 +0530
Message-ID: <20260715125634.2107320-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX+UVIybyVVgts
 bknNulqY9cRSrt4QL9YLMobiTYX+G3Epk+lasWgqCRC6R4iPovzKK2kJWZWE4mHaYAtGKQv1Dbx
 9nbl240QMszzbFN5wXpZF1FLmMwjWEI=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a578394 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8
 a=vRu-xUEiTxWaVw53JsQA:9
X-Proofpoint-GUID: Zky1nnCalrn0C2NubjqBtlulFMB0aqnk
X-Proofpoint-ORIG-GUID: JhkHKLv5I6BKB9ilfM-A9GZSAzGqCiRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfXylnHh7mvUvMe
 A3CV7HrZvcNBXkVcM3Y2VdG2mBFqoyA7Auu5/ALklaZEnrBRsix26YqGwiGPum+alvwiT/6wscl
 07jCuNgfHNJtSlWZBgazwyrNLuYsBWbneKwd+JQdrNIHJD8cwz2oS7zJc8fbCJnlkEA8xgomT/F
 f+mUXMR4WbmY0y5lmePCTa9KgHB754ExlJI+pN0N438PauYpxegMz+/fAWxwwpyMs431ejwyrwK
 laxZnYEhJ8SyMRuBGsvVT4lAEx1ab6OqbUOF9rZZ/MDqTB7ZVQgrlWnEidCAq3DuC4iye6BAVxC
 5e3q8i5rhYYDCJ4K6c31xGHEuj4Gojl12l3IuwyFSDq4Dvy4Au4plUhkIjFx+XoQ60cKxn0+FFL
 gLjCK6BxvlKvqG2itgw8U5ANFbwfy7DMbyVVv85cTnwwsDmwfSffZ/qRLGgQ1UxRKBZU9UfO85S
 E4O9h/y7ggb327b6QYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
https://lore.kernel.org/qemu-devel/20260520160728.2283628-1-rathc@linux.ibm.com/
Link to Gitlab CI with patches :
https://gitlab.com/rathc/qemu/-/pipelines/2678607049

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
 target/ppc/translate/branch-impl.c.inc        |   2 +-
 target/ppc/translate/fixedpoint-impl.c.inc    |   4 +-
 target/ppc/translate/fp-impl.c.inc            |   4 +-
 .../ppc/translate/processor-ctrl-impl.c.inc   |   8 +-
 target/ppc/translate/vmx-impl.c.inc           | 102 +++++++++---------
 target/ppc/translate/vmx-ops.c.inc            |  18 ++--
 target/ppc/translate/vsx-impl.c.inc           |  56 +++++-----
 target/ppc/translate/vsx-ops.c.inc            |  24 ++---
 16 files changed, 142 insertions(+), 157 deletions(-)

-- 
2.53.0


