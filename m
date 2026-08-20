Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05CBC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Ll-0006qP-Hl; Thu, 20 Aug 2026 10:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Lg-0006hV-66; Thu, 20 Aug 2026 10:02:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3Lc-0005Ym-4X; Thu, 20 Aug 2026 10:02:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9DwXB471300; Thu, 20 Aug 2026 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=UEmyv8GOnS16D3aoO/SIMfEzv269
 juJdIzWzUhL0D2Y=; b=lT44FuxoppoFFm5zT2KUcExSEqTmrGjfzP/quet2ATQT
 57Fgg5Nk6mJMexmRpXwf9HIaM0A8giLkdKuFvRmtp4p2i8qF9QONxj2y5Az+dLSY
 aA3gfCB68vSrJeaRWqtBRzvLKFYOyx7L6rtRenGBq9ZVDkELTv8z0wgX/7FRxfn+
 XO1a+wQd0HLTN1OAoAU5UrPcSHplcC9HLj6ld1lIMXBwsFhHMlH5E6/PKS7ugD0M
 E1hLbp7DAGTCujk0NsctohQkUd2NYyrJgtIc3zmCFkAXfUfrOHmvKbdm+C1HzSnZ
 j0nCMJUnz75dNbuiJqeh6DSne77ptqVgD7VmGoWP9g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jtg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:02:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuUOu014706;
 Thu, 20 Aug 2026 14:02:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypmv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:02:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE2BV149676654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:02:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 727D020043;
 Thu, 20 Aug 2026 14:02:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23A8620040;
 Thu, 20 Aug 2026 14:02:04 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:02:03 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 00/29] target/ppc: Moving instructions to decodetree
 specification
Date: Thu, 20 Aug 2026 19:30:29 +0530
Message-ID: <20260820140114.327023-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a8708ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=PKsiBD0K0ecj8VnNqhUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Yb7xyY33ITBEGY4Hf4eP4ajyaYkaBSo_
X-Proofpoint-GUID: WOuEZssn8ThWw5Z-v8b-Pbx8utDulHGj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX4f6RkcVlVUFw
 ZhyHRjAKhS6P3AkhPD3lKJo+rahCmpE93MRsBPvRiFSX7J0pe/iPgwLw/+gQ9NqBZ9sdK8QJZkd
 ikCs7QNW5/+xtbOya+tuTBik8q9+AYI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXxW3Lf/cOQ5ST
 31pxSC9auFwzaPxkOygzjCmRsnJe4eVmBCd39aVvt1wp/arT3ykhGqE+tKF9BTypVdZLckHtXN4
 i9+pLubWGwo7olZNcQZbWsMlUi0rxj+wNPe13rPgl9y3wJcxr/y/dH8h6Jmrnt4r69O8PwVqN2K
 DCkRv1UJpS5BHzTeWLvgp72OSs8Qt4YbQZ/ikzevwvSAVtPnVFz0b0uluRnUtJ5qhF+uHS+xDFV
 LL3R7NP9P7sYMJ+1ZqY31MBNxYDaMKutppqbGhoJShD7Xs7hBd4FO3huMqGb9V6pjtR7iO+/Ip8
 9/4mb+/RdXKdFCEucN3Y++FhsNXAX0B/3UR7v/RmP5OOuUkPvHMZYXHYpo/4XXunPu6hS/VLXk5
 4rm6AW+rXoLWQmjPujjp1FeJzecrLzfj7jZ/rDX0F8bplpiZHw/fuTfbDjvpItJ6t7oJGMmOVOc
 fpKaWnbUk9gVbEEsMBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

We recently had a QEMU decodetree hackathon at our org focusing on moving
instructions to decodetree specification. I have consolidated the patches
generated out of this effort in this series. Though I have done a round
of review on all of them, might share some more review comments later.

The checkpatch.pl script emits false error for a couple of patches which
are of the following nature :

TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))

static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
                                                    ^
I see this happening in the last pointer argument in function
definitions after macros (like TRANS(..) in this case).

Gitlab CI : https://gitlab.com/rathc/qemu/-/pipelines/2776338293
This series was originally posted as an RFC. Link to the same :
https://lore.kernel.org/qemu-devel/20260520160728.2283628-1-rathc@linux.ibm.com/

Changes from RFC :
- Incorporated all the review comments received in the RFC as of 19th
August 2026.
- Retained all the 'Reviewed-by's and 'Tested-by's received.
- Patch 22 is a new patch introduced.

Aboorva Devarajan (3):
  target/ppc: Move vector merge instructions to decodetree
  target/ppc: Move vector pack instructions to decodetree
  target/ppc: Move GPR atomic load/store instructions to decodetree

Amit Machhiwal (2):
  target/ppc: Move fixed-point Shift insns to decodetree
  target/ppc: Move fixed-point byte-reversal store insns to decodetree

Chinmay Rath (1):
  target/ppc: make do_ea_calc_ra available for 32 bit builds

Mukesh Kumar Chaurasiya (IBM) (2):
  target/ppc: convert slw, srw instruction via decode spec
  target/ppc: convert sraw[i] instruction via decode spec

Nikhil Kumar Singh (3):
  target/ppc: Migrate extswsli to decodetree
  target/ppc: Migrate atomic loads to decodetree
  target/ppc: Convert cache instructions to decodetree

Ojaswin Mujoo (7):
  target/ppc: Move isync instruction to decodetree.
  target/ppc: Convert b{a, l, la} to decode tree
  target/ppc: move various conditional branch insns to decodetree
  target/ppc: Fix TRANS* macro variadic arguments handling
  target/ppc: Move wait instruction to decodetree
  target/ppc: Move sleep & friends to decodetree
  target/ppc: Refactor sleep and its variants to use a common helper

Shivang Upadhyay (4):
  target/ppc: Move Condition Register access instructions to decodetree.
  target/ppc: Move Condition Register logical instructions to
    decodetree.
  target/ppc: Move Fixed-Point Load/Store String instructions to
    decodetree.
  target/ppc: Move VMX integer arithmetic and BCD instructions to
    decodetree.

Shivani Nittor (1):
  target/ppc: Convert mcrf to decode tree

Tanushree Shah (2):
  target/ppc: Move rlwimi, rlwinm instructions to decodetree
  target/ppc: Move lmw, stmw instructions to decodetree

Utkarsh Verma (1):
  target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree

Vishal Chourasia (3):
  target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
  target/ppc: Move byte-reverse instructions to decodetree
  target/ppc: Move system call and rfi instructions to decodetree

 target/ppc/helper.h                           |  100 +-
 target/ppc/insn32.decode                      |  254 ++
 target/ppc/int_helper.c                       |   76 +-
 target/ppc/internal.h                         |    7 -
 target/ppc/mem_helper.c                       |   18 +-
 target/ppc/tcg-excp_helper.c                  |   10 +-
 target/ppc/translate.c                        | 2289 +++--------------
 target/ppc/translate/branch-impl.c.inc        |  181 ++
 target/ppc/translate/fixedpoint-impl.c.inc    |  936 +++++++
 target/ppc/translate/misc-impl.c.inc          |  170 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
 target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
 target/ppc/translate/vmx-impl.c.inc           |  373 ++-
 target/ppc/translate/vmx-ops.c.inc            |   41 -
 14 files changed, 2362 insertions(+), 2240 deletions(-)

-- 
2.55.0


