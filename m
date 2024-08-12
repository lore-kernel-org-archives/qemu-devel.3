Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90609C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQtG-0001Cv-BV; Mon, 12 Aug 2024 04:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtE-00014J-4O; Mon, 12 Aug 2024 04:58:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtB-0007lE-OM; Mon, 12 Aug 2024 04:58:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C40VKs021722;
 Mon, 12 Aug 2024 08:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 Gp3pp2LGJjLPchwoCjr6VnHpfNCNzIRZm2qo5aLGOqQ=; b=Brkx6ahEkFRdu/7F
 o6puJVgYJlGKex/5seSThbhmxzY2OMwvmWMGrzt0pfv+XxoDwWxfR7N1M7eeyyhm
 nlm2rSWbxYX+IhbF/M/Uown8RvXDNRWVZvweHjy+M/jvjYM+g1Yssf4MMTRfkaww
 wo5HR7M5ULZDtQ9zXo3RiaHKpm7hOzLwQYy6AvYKPtGwlm802+1DTSOcTsTiyMot
 FzDIyyEJOz8BcrvDCiY91ezK4PLKyTuqVtCkzukLTeyt/09YlnTAHeQV3gS4pqgj
 x81R6o/ttH8t0BSnks9BLl63dUIeROKKetxYsTCC3ZJCY4mI9Lsm2Q/l6qIdN+AX
 +rKs9A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpmddf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C8wni5001897;
 Mon, 12 Aug 2024 08:58:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpmddc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47C6xqQM016228; Mon, 12 Aug 2024 08:58:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhpdmqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47C8wioi54395150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 08:58:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554942005A;
 Mon, 12 Aug 2024 08:58:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E81AE20040;
 Mon, 12 Aug 2024 08:58:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.70.115])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2024 08:58:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] target/ppc: Set ctx->opcode for decode_insn32()
Date: Mon, 12 Aug 2024 10:53:08 +0200
Message-ID: <20240812085841.1583-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812085841.1583-1-iii@linux.ibm.com>
References: <20240812085841.1583-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5Do39T0k_Al7iEM8hiI2kk6CI0EFHXlK
X-Proofpoint-GUID: iSO4FVt-Kk-E8LLF0uPjbaUWS_hrRBbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=950
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408120064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


