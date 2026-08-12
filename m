Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B0FC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUD-00075v-AH; Wed, 12 Aug 2026 18:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUB-00075d-CP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHU9-0000ri-MR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so1711758b3a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573904; x=1787178704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9MxVGgjNk8bFnakXO7rXME+a7iUEkn7G5lX72q22MxQ=;
 b=RzfaLyey/JUd+CHTivHqvs0BpA3qifRxq5Cs7C099leoaWRjv2s7yFcshCX2thrdOn
 Z5BsyV9YaO4roMpJty7o57pjzeSDd4OzxW+QQGRJTYfpwS8MTIJ2L0KPOPJ8LOuvAyQ+
 Fxc5F+Hwd5yJnk9kU2P/ST7/yuphKCQAAn02Mw4E1VLptVCk5iOcbtEuijNLGQq8+6fb
 Go6ZS88w7c+ntYGGR6P8Nr5sYVaICY3/n13wQXOFgxLZU/+7xYnkvukMoxoFjXQqwKpR
 HyNIIceqauXlxYH/lH4cR060qoL9PXAOJrFB49YAEFEWldi9AtvO95dM0W+/iBSY4VrI
 tNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573904; x=1787178704;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MxVGgjNk8bFnakXO7rXME+a7iUEkn7G5lX72q22MxQ=;
 b=j0lgQhy9yCZxrLfsmp3ZhXPznNrb+A1kIJVmVeuT2tx9nWx7wKgxtWf2RoEaxhirFE
 PREESx6qomkMZMH+5SpQ5HvaUEjeDW7w/maLfthQIzxeQoesJJp/dwObB4pWasn1CL/N
 nLIFCyRtUTdgrqXF70wBtjsscNmy6SviIi+tqvTXZhU5VPA78h/VS+k2aL4TGWVhxDMw
 +aJTWPm7eFHO8tizro4c1jSgGvOni8dWKon+oCgEOSkiaKGgIDeIthYKanDM5hTkFPcD
 Diz4lLowM2MBALoRBk+HaoIM4dZ+VkWTMqswDHqOnwubg6Wb2ZBnZWe6Hnk/aUyFYKBf
 6uQQ==
X-Gm-Message-State: AOJu0Yxc7tTra93s+sxAtRPr21PUL7JUNBJ8iZ+xgqASfJmGDyBFDH7p
 kQhOjyypfRcaz7NfcvYQxPxN4psU+2SC5h1uqGfz8iUn/DzWznm1bPuHBijYNP84MEqYDmN3SeA
 BSKaj
X-Gm-Gg: AR+sD10hjxh5AOLKyiJaIbhLBX20cQr41slr6492wtV/0JkrsqrV47Bg8VvxJmq6gHw
 oiSk56He2cQOfg1S4r8EP+diKozz7P9vg/5v866hVBgPPgGd1QBQu8ZXFcI+taOJODFV27QdQse
 PmRCqhjUiKxR0SUszoIGvuDXvDgS5c0chYmkF/N+t59pBiPSEcMcYrop+eBGSPEFKZqzk+TRSwe
 pedHGTsJN3xYgzSzcFgq6AqEiZi+ObDoXASPf3uBQR/Jvu6ptZH5rd7tEdZ3htEar4bPGHx09ZW
 r1HI8l/D41HKJSfZdBnK/HffSRGfXWkrV+QgiB85QYzidQG2JMhy/BLk/VYsHggWSeAgsrVG21E
 bDtcAP5La0oYOpjVTUkPjmiCmk4uU8q7pJgE7fUJOEa99ZyF2yNKLjTOQJ+2j7NqImn9iGE1e1D
 SWMBCOzp7rq9zXrpRGVDQrJbTvwc7KKV5/kAxHlX1YUTvapn7LO9vSR5yB0EVBx9UPBtR7TECqZ
 90gVAxWiNb8xKJIyPxf9Q==
X-Received: by 2002:a05:6a00:3907:b0:84c:1c9e:f894 with SMTP id
 d2e1a72fcca58-84fc74568e0mr1184751b3a.4.1786573903660; 
 Wed, 12 Aug 2026 15:31:43 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	Alistair.Francis@wdc.com
Subject: [PATCH v2 00/52] disas/riscv: Reorganize the disassembler
Date: Wed, 12 Aug 2026 15:30:50 -0700
Message-ID: <20260812223142.349142-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

One of my pet peeves is the non-automatic addition of indexes to rv_op
which must match entries in rvi_opcode_data[].

Reorganize the disassembler to pass around pointers to individual opcodes
rather than pointer to table + index.  To do that, rewrite how pseudo ops
are processed, replacing indexes with pointers.  Merge the decompression
of compressed opcodes into the pseudo ops mechanism.

Fix quite a few bugs found in the process, mostly related to isa level.

Changes for v2:
  - Rebase on riscv-to-apply.next, which now contains Tiancheng's fixes.
  - Adjust the DECOMP macro to make clang happy.
  - new patch: "disas/riscv: Skip post-processing of illegal insns"

The only unreviewed patch is the new one.


r~


Richard Henderson (52):
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
  disas/riscv: Drop always true branch pseudos
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
  disas/riscv: Skip post-processing of illegal insns
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

 disas/riscv-xlrbr.h           |    4 +-
 disas/riscv-xthead.h          |   24 +-
 disas/riscv-xventana.h        |    4 +-
 disas/riscv.h                 |   46 +-
 disas/riscv-xlrbr.c           |   57 +-
 disas/riscv-xthead.c          |  503 +--
 disas/riscv-xventana.c        |   23 +-
 disas/riscv.c                 | 6390 +++++++++++----------------------
 disas/riscv-op.c.inc          |  913 +++++
 disas/riscv-xlrbr-op.c.inc    |    8 +
 disas/riscv-xthead-op.c.inc   |  125 +
 disas/riscv-xventana-op.c.inc |    2 +
 12 files changed, 3411 insertions(+), 4688 deletions(-)
 create mode 100644 disas/riscv-op.c.inc
 create mode 100644 disas/riscv-xlrbr-op.c.inc
 create mode 100644 disas/riscv-xthead-op.c.inc
 create mode 100644 disas/riscv-xventana-op.c.inc

-- 
2.43.0


