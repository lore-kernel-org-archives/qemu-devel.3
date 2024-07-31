Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F966C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6Ha-0007Ap-EU; Wed, 31 Jul 2024 06:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZ6HX-00077Y-S9; Wed, 31 Jul 2024 06:10:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZ6HV-0002hd-B9; Wed, 31 Jul 2024 06:10:07 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V5ImJj028676;
 Wed, 31 Jul 2024 10:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=svJzSp8Crzh8vmxDnOECq7w1I/
 9ZCak5NMCdPaEIvi0=; b=o4HoCtRPq3DgG/Mk8T02iS2qEsm8mb887IXno5JpC9
 5kupmFpZLTa63A8a4dQWUcL5FvnqbkkGeIz5C7+VpsGXyhbUX6BOpAFmxXz+FlCg
 a5W6H/+/0IGQgz8lnzmuWNzleGevbGbdK8BW34NJmPPOBrSp5aCdul5ieay8zFnP
 +l7rQG1yh303LoLsWZNoGPqQgpR9P150uWaJZ+PXqSDQUQw6zBuONW++L/FIXiZI
 5glrh2KIiHO0181b0tnO0EiqrzwS8QzN/9G2soTy4JhloZdN82CiUzEtgNbPofwZ
 t1xoUMdEi7Wqg3fk/aYKilFXpf/1pRNspoMJHKmO9zkQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbgpu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 10:10:01 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VAA1Ax005862;
 Wed, 31 Jul 2024 10:10:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbgpu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 10:10:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46V87sm3029128; Wed, 31 Jul 2024 10:09:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0u0ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 10:09:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VA9tZJ55312814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 10:09:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE55220156;
 Wed, 31 Jul 2024 10:09:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56F9A20151;
 Wed, 31 Jul 2024 10:09:55 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.30.41])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 10:09:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH] target/ppc: Set ctx->opcode for decode_insn32()
Date: Wed, 31 Jul 2024 12:07:48 +0200
Message-ID: <20240731100953.14950-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YdTwHovDHlk7-547ayWPpWWMU9pU-psR
X-Proofpoint-GUID: WdyLqamPtTdSkGryCuE_Wb_n6cGbgqsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_07,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=838 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

divdu (without a dot) sometimes updates cr0, even though it shouldn't.
The reason is that gen_op_arith_divd() checks Rc(ctx->opcode), which is
not initialized. This field is initialized only for instructions that
go through decode_legacy(), and not decodetree.

There already was a similar issue fixed in commit 86e6202a57b1
("target/ppc: Make divw[u] handler method decodetree compatible.").

It's not immediately clear what else may access the uninitialized
ctx->opcode, so instead of playing whack-a-mole and changing the check
to compute_rc0, simply initialize ctx->opcode.

Cc: qemu-stable@nongnu.org
Fixes: 99082815f17f ("target/ppc: Add infrastructure for prefixed insns")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/ppc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 71513ba9646..02c810e8848 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6426,8 +6426,6 @@ static bool decode_legacy(PowerPCCPU *cpu, DisasContext *ctx, uint32_t insn)
     opc_handler_t **table, *handler;
     uint32_t inval;
 
-    ctx->opcode = insn;
-
     LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
               insn, opc1(insn), opc2(insn), opc3(insn), opc4(insn),
               ctx->le_mode ? "little" : "big");
@@ -6561,6 +6559,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
+        ctx->opcode = insn;
         ok = (decode_insn32(ctx, insn) ||
               decode_legacy(cpu, ctx, insn));
     } else if ((pc & 63) == 0) {
-- 
2.45.2


