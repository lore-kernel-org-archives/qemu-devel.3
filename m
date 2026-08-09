Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F8DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7W-0000ev-7B; Sun, 09 Aug 2026 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7T-0000dA-Id
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7Q-0007Fo-Uk
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso1229001b3a.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314947; x=1786919747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oDtDairKA2j63G3Du0xI+jvMHSn2cZG/v/iJcs98XNQ=;
 b=JOzn0bM8QZNrne6fq7JCqViChlHepWp0tz4yWBThwMTSblYC02QNblh1wwvaxVnhXx
 mKqAH3ZpZp1q9p1rj+C86Cod67uQh25/5T1jHAW2Z4CKS7g3Oy40H6QkLaqxkZ349DFj
 FApHUuEFft4zLkoNaj3vM1z869N5loJyqVMq9ayhgw01jZ9Qcvzu2XzR+i5F+78T/KoF
 LtML1KKJP4HafYMwqfoZXb1HULLsGllK73D8Xi8oJ1fJTcpXXNYLcyUe1g6sauAFWSeP
 S8ZPYUpADlZi9au2ahih4W7qZ0fwiybupa4KuWGuqGSmcNWNfOs1GwyX3UevBKwtOYWh
 hp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314947; x=1786919747;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oDtDairKA2j63G3Du0xI+jvMHSn2cZG/v/iJcs98XNQ=;
 b=YZHcb8S6RyY0mot4yd9F20LCiPklDXR7T1TCiYi6d9mfTBuFtC3/L8pPOgKmumCihP
 b9SeYQZyFqLeMEsmTHjNwKUnuhGexZx86cIp3Q+ClyCdHgY/zo500Qmc01L/p+bYgX71
 MuwIA2G5U1v9iOU6JFOzcTNs4HQo4PKUYuW7aZqQ5Rz7w03Up0koF52I3ZAs6xMi82dP
 /E8hjrxfDwZiujgKf+0CVT08QAxUJxqDj6gH1GsIvxGERpqseNhjBEH0vrTnzeKh1isg
 0h7DaTk075uRsawEIsEzpyDCGH5bhewl8i5GX2qokLrYiKI6cizcfSUt5r1FjDeLH/65
 NKBg==
X-Gm-Message-State: AOJu0YzHdNiED+7yX4KwfZuMmUDT6kdPD77CLLWzK6MbK9XHWx7ryWjF
 R48c7chXHQM0ZKsURVOzRSxg4TNpor1VcotFFhWzZo3Dk9YVlEhsF5T1ZsJVsMtB0LnPt9joxZv
 r7w/j
X-Gm-Gg: AR+sD123v3HCa3qGbcuihM6hdGNe8K2AZr6DGA1h4FQcIScMGrvZjovVnoHztLcYzJ+
 ThLgjMF9PhPykBiLhYt2NgPpQ4/ukitW8VuYULekP8mbm+hNoTHYmSc6UgbKWPC6UV1+g3JYBnO
 a3dGvYWZGBrqM9y1X+svATiXLCEMNCPmv97M9ZDjCRW7xfoH+638G9AMrTvw2+1+4qX+KKOiY+O
 A3tOMZAkFwHHzljM3awOEMu8Bi3bGaGAmUPRxKXe8G+wHYdlDPamnTxogWky4KUeSmyWe7CS//v
 MjmV9PjsXY9HEXpfNueOaTAtPjjgWQXbfL1VWLhHHhw/dKAORLuww7YxmrS4AwWjlL1VScmGNou
 ngNM38kqHyYHDnHMH0Dp2P32R01LGQlRmR+DRpVJRFUS8Vr72ozjVnJ8VMJxzUL+hDpM6r0G5DT
 co1aAQl5KSg3RwwtQvTmCVs8946UbtLN+NQO+ZHU+hPK7t1fcf7fvI5AOHFSF3O9CA1tYorq34v
 wgU4Mgg7FMPLKd5/uXQ
X-Received: by 2002:a05:6a00:8c3:b0:848:30c3:45d6 with SMTP id
 d2e1a72fcca58-84f694948aamr15610424b3a.14.1786314946826; 
 Sun, 09 Aug 2026 15:35:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [RFC PATCH 00/56] disas/riscv: Reorganize the disassembler
Date: Sun,  9 Aug 2026 15:34:49 -0700
Message-ID: <20260809223545.730664-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

One of my pet peeves is the non-automatic addition of indexes to rv_op
which must match entries in rvi_opcode_data[].

Reorganize the disassembler to pass around pointers to individual opcodes
rather than pointer to table + index.  To do that, rewrite how pseudo ops
are processed, replacing indexes with pointers.  Merge the decompression
of compressed opcodes into the pseudo ops mechanism.

Fix quite a few bugs found in the process, mostly related to isa level.

I grabbed Tiancheng's bug fixes to start, to avoid reworking those.


r~


Richard Henderson (51):
  disas/riscv: Move operand extractors earlier in file
  disas/riscv: Reduce rv_insn to uint32_t
  disas/riscv: Tidy dec initialization in disasm_inst
  disas/riscv: Pass rv_opcode_data pointer to decode_inst_operands
  disas/riscv: Pass rv_opcode_data pointer to/from
    decode_inst_decompress
  disas/riscv: Pass rv_opcode_data pointer to/from
    decode_inst_lift_pseudo
  disas/riscv: Pass rv_opcode_data pointer to format_inst
  disas/riscv: Tidy disasm_inst main loop
  disas/riscv: Set dec->opcode_data in decode function
  disas/riscv: Drop explicit zero of rv_opcode_data fields
  disas/riscv: Drop useless const in structures
  disas/riscv: Drop codec from rv_decode
  disas/riscv: Handle c.addi4spn imm != 0 during decode
  disas/riscv: Simplify c.addi
  disas/riscv: Handle c.lui imm != 0 during decode
  disas/riscv: Handle c.{srli,srai} imm during decode
  disas/riscv: Handle c.slli imm != 0 during decode
  disas/riscv: Do not recognize c.{addw,subw} with rv32
  disas/riscv: Remove rvcd_imm_nz
  disas/riscv: Unify decomp_rv{32,64,128}
  disas/riscv: Drop always true branch psudeos
  disas/riscv: Handle aliases of csrrw during decode
  disas/riscv: Handle aliases of csrrs during decode
  disas/riscv: Handle aliases of csrrwi during decode
  disas/riscv: Break pseudo loop for jal and jalr
  disas/riscv: Allow decode_inst_lift_pseudo to loop
  disas/riscv: Handle decompression via decode_inst_lift_pseudo
  disas/riscv: Drop format from DECOMP insns
  disas/riscv: Tidy rv_comp_data terminators
  disas/riscv: Chain "ret" pseudo off "jr" pseudo
  disas/riscv: Chain "nop" pseudo off "mv" pseudo
  disas/riscv: Use rv_codec_illegal for pseudos
  disas/riscv: Simplify some insn decompressions
  disas/riscv: Store op pointer in rv_comp_data
  disas/riscv: Return rv_opcode_data pointer from decoders
  disas/riscv: Reject all of OP-32 and OP-IMM-32 for RV32
  disas/riscv: Fix rv32 encoding of zext.h
  disas/riscv: Fix isa decoding of rev8
  disas/riscv: Fix typo in th.lbib format
  disas/riscv: Split ventana_opcode_data
  disas/riscv: Split xlrbr_opcode_data
  disas/riscv: Split xthead_opcode_data
  disas/riscv: Move rv_op_illegal to riscv.c
  disas/riscv: Split out riscv-op.c.inc
  disas/riscv: Merge all mop.r.n to one pattern
  disas/riscv: Merge all mop.rr.n to one pattern
  disas/riscv: Merge all c.mop.n to one pattern
  disas/riscv: Tidy decode of c.mop.n
  disas/riscv: Tidy decode of mop.r.n and mop.rr.n
  disas/riscv: Split rvi_opcode_data
  disas/riscv: Sort riscv-op.c.inc

TANG Tiancheng (5):
  disas/riscv: Fix th.srri decoding
  disas/riscv: Fix 6-bit immediate extraction
  disas/riscv: Use signed type for vector immediates
  disas/riscv: Decode unsigned vector immediates as unsigned
  disas/riscv: Use extract helpers for operand fields

 disas/riscv-xlrbr.h           |    4 +-
 disas/riscv-xthead.h          |   24 +-
 disas/riscv-xventana.h        |    4 +-
 disas/riscv.h                 |   47 +-
 disas/riscv-xlrbr.c           |   57 +-
 disas/riscv-xthead.c          |  507 +---
 disas/riscv-xventana.c        |   23 +-
 disas/riscv.c                 | 5255 ++++++++++-----------------------
 disas/riscv-op.c.inc          |  913 ++++++
 disas/riscv-xlrbr-op.c.inc    |    8 +
 disas/riscv-xthead-op.c.inc   |  125 +
 disas/riscv-xventana-op.c.inc |    2 +
 12 files changed, 2852 insertions(+), 4117 deletions(-)
 create mode 100644 disas/riscv-op.c.inc
 create mode 100644 disas/riscv-xlrbr-op.c.inc
 create mode 100644 disas/riscv-xthead-op.c.inc
 create mode 100644 disas/riscv-xventana-op.c.inc

-- 
2.43.0


