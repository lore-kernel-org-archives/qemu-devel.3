Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BEECD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjSr-00081y-4R; Wed, 20 May 2026 12:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjSf-0007ws-V5; Wed, 20 May 2026 12:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjSc-0002UJ-SJ; Wed, 20 May 2026 12:07:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KBdqO73067542; Wed, 20 May 2026 16:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=NRQ+r85vQoSyrGnuXYY1y9d+kmrRxS81jhFtmL/Lr
 OI=; b=S5Vu3uBdLvTAj3T2QmzlYXCBGZDKdYxbjyY9HiikMd8bMqHhPTZe8lilY
 UlRiVcemcw7bRF3T2dnxwVQ0z+rsdbFP5DJgpKP4rXDKA5X1ni/uKEn8dNlo6HE8
 KFTtRWqvPcxUVARhBXLH7RLnLNZBtc5LSeCzrCxU/J8uwv2LSBC5BoqyjftKgZkF
 pnLqG8lJyYkYcqxVhvPbFB0Ead5jZ5wjXoVRiU7a6wjClhrdVihDdv3P6Zz3828l
 gbzfu7XttfhJRh8Juv7KvPOwdWwFJwLmdRnhOW2BAjJPTXP05iL6jidhCQfZptVo
 yEme2jg2tcna8AYRXIMCjO+uHOs8g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw9xkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:07:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd687026092;
 Wed, 20 May 2026 16:07:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7tja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:07:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG7iT651511604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:07:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D80BA2004B;
 Wed, 20 May 2026 16:07:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E32120043;
 Wed, 20 May 2026 16:07:39 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:07:39 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
Date: Wed, 20 May 2026 21:37:00 +0530
Message-ID: <20260520160728.2283628-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX+Xg7yLRNt878
 ae/CSiUJ7wUHVGoyq+xoAAWTqw1aNYTT8b8HDNQRktxmcticJGksSr1uFnm/rjR7ZNHOxecxhss
 Vj7L4PHmjdg56IyfzhjLrjYtgx9YA8ATxe/gqZxipKhbe7EMOvDrYzPV9cR2pdWguFJRx72v38B
 QMjLqRYaDUANa3xFGWX9g66ul+zYDg1NnY6xNDrsOwq7gjoPik8OqMzhKspvc/VBXLSI3G4aSyr
 xE6N89TVLm4WggVX7XitKZAuzOXmDWV0CmZFX3rvv4k7dn2ZRFLbP8epgyiho//jKM44h8bSLHb
 wnhvwkzaT3XvoSzs7Kae4DBgTRGUHcIgYhdiHCHvO/au86BdjqkrItPyR61lbdgz4BCc0GWzW3n
 hDJKMoYvB5/+OUwKPPK29nnG/O/0sv18suwGhC5ptTDd8sJqE89aj/e3Qp8YxCp/Mj9/nW+KXK1
 Abi9zMZp483sFhRB5tw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ddc55 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8 a=PKsiBD0K0ecj8VnNqhUA:9
X-Proofpoint-ORIG-GUID: 6hybbpk4rMxKp2upPSP7OmprHyCOsftB
X-Proofpoint-GUID: z43y2TKKF43uUu-ModWL7nQpNBQKWgvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Richard, Peter, Stefan,
Could you please advise if it would be okay to have the above false
positive in the patches ?

Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
Please note that check-python-tox and migration-compat-aarch64 from CI
fails in the upstream master branch as seen in the following:
https://gitlab.com/rathc/qemu/-/pipelines/2537246569

Thanks,
Chinmay

Aboorva Devarajan (3):
  target/ppc: Move vector merge instructions to decodetree
  target/ppc: Move vector pack instructions to decodetree
  target/ppc: Move GPR atomic load/store instructions to decodetree

Amit Machhiwal (2):
  target/ppc: Move fixed-point Shift insns to decodetree
  target/ppc: Move fixed-point byte-reversal store insns to decodetree

Mukesh Kumar Chaurasiya (IBM) (2):
  target/ppc: convert slw,srw instruction via decode spec
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
  target/ppc : Convert mcrf to decode tree

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
 target/ppc/insn32.decode                      |  244 ++
 target/ppc/int_helper.c                       |   76 +-
 target/ppc/internal.h                         |    7 -
 target/ppc/mem_helper.c                       |   18 +-
 target/ppc/tcg-excp_helper.c                  |   10 +-
 target/ppc/translate.c                        | 2592 ++++-------------
 target/ppc/translate/branch-impl.c.inc        |  181 ++
 target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
 target/ppc/translate/misc-impl.c.inc          |  175 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
 target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
 target/ppc/translate/vmx-impl.c.inc           |  360 +--
 target/ppc/translate/vmx-ops.c.inc            |   41 -
 14 files changed, 2529 insertions(+), 2358 deletions(-)

-- 
2.53.0


