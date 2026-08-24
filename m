Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D583EC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNae-0004QR-Bq; Mon, 24 Aug 2026 01:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZa-0002dQ-H8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZZ-0002PI-25
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:18 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so2461761a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550616; x=1788155416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXSMuIYcdvTbWFw3R3IymTx+qxtp/rW/iojAskcb29A=;
 b=bHBnkm0ckBwP2830IEfV0xzpCZwNAoPszAV6SpX7epow9omRVrMiTBVmrVRhqjJa/b
 Dq72DHj2/d3tVfY2Sw/7qEm6sZP1kHEnhHPMWa2NdCB3ZgylMB+MpVm2Op2N0oAGMT1d
 Hiz2TfrDeg7k6QT7N5iRaYWLIwQcJZrsrdurfLwgzNpzCf0ELQuLk3sGOhk8bcy+dMtB
 CdNoZ1bW7iw3bnSywfgj6bhVVJbUc47NRsp4Aoqe8WYAktVlqiJw6FRablK+t+cN1gYJ
 gOvmvZtgXsFLdFJDYz/gKsbJIRQfmHYrnY9h/8yzfnu5y4jFBKMApWvtlyb5TsjB85iB
 ZGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550616; x=1788155416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXSMuIYcdvTbWFw3R3IymTx+qxtp/rW/iojAskcb29A=;
 b=qSKk8goPKsqTU7K+LHFGe8CJN05N3rh4jTMDxTtLuYdxAF/0sT1Ae86MDyFC3quRue
 J0Hp9wn87bM1+E4y7XEv8+0wAYuAaaL9CYyVMP27T1CQIzr7izPlDDZ4viqG/aL99nGq
 5dT27S+RRwtpylf9diTZUdzgo40LWicZvasoljBKQguoFAEmnjHLszU/0El793FOxUed
 nYSQ9zVOIUDn2VVv0DbtOgAuQgnt+NgMSeuZj2TrJ6i5Us+NoX3rzOak0j369vDukEnZ
 EB7q9s8QjnswiresggD8fn9kl6ngT5PbgtjbpWdHKskgI9NM3si71MJzRSIdwkVvSATa
 kZ1Q==
X-Gm-Message-State: AFuF++mw89CDofV27saLqZbG/lB72UwsB32DfLGIamZyJQHz7uHKvz/y
 8778Hd5ujj2QP12Kflr4VOx8bsXPg1nvoqJV06qZGscTxHxokgFe0vA80aUb1w==
X-Gm-Gg: AR+sD1256+y3k5XStca1gW4IJrKqChj2nMy7ZuEvMYeV6kA4FVAkb4MJaChEj+fCByl
 sthCp3Al/3jt3GNZep7zZCxMGdyaKi2U+bCd2w+kTymRZmnkJEl5ed0YWjByZNF2Vv4NJLHIsRx
 iLsRbznVSfEJb393dtZzxSL+a7t9QZCCQ7NVLCYAuVzC3kt35bM0HupwWXZEpg7kXv5XXYe/BGE
 wJd17yszqgnQItsXUFm5Qlis16D7TszmQ4g+SJ1/SxZ2Hf7gsu1vIVp9IfXvPcwittP932SzsWz
 EIFctjI8pDIMNc6SJQoZUnr6Km3LD8l6GGOWYw+mWx2yBqjpwCOjBdfyvpY+/Cw5U7HtXhtlO18
 FShoVowJywzykK8B/r3ANW8+g6rbVg9j8TMp6AJ8JFS6s6sbXN9mP9J6A6ZWiFWmyEoXbhuAgtJ
 PUAA37dFrYlvZ04PF4uJRWMzIfOfwsK/25PWl4OwGUFa+MMMMttpmcRkZKIyjuz+JVJjIBpMT26
 Prs9iv0pY7G9LWo
X-Received: by 2002:a17:90b:1a90:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-395c33a0168mr33300025a91.5.1787550615783; 
 Sun, 23 Aug 2026 22:50:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 37/96] disas/riscv: Pass rv_opcode_data pointer to
 decode_inst_operands
Date: Mon, 24 Aug 2026 15:47:07 +1000
Message-ID: <20260824054806.2790041-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-5-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 986dc6b752..af43940732 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4595,11 +4595,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 
 /* decode operands */
 
-static void decode_inst_operands(rv_decode *dec, rv_isa isa)
+static void decode_inst_operands(rv_decode *dec, rv_isa isa,
+                                 const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     rv_inst inst = dec->inst;
-    dec->codec = opcode_data[dec->op].codec;
+
+    dec->codec = op->codec;
     switch (dec->codec) {
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
@@ -5468,6 +5469,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
     };
 
+    const rv_opcode_data *op;
+
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
         bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
         const rv_opcode_data *opcode_data = decoders[i].opcode_data;
@@ -5486,7 +5489,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         dec.opcode_data = rvi_opcode_data;
     }
 
-    decode_inst_operands(&dec, isa);
+    op = &dec.opcode_data[dec.op];
+    decode_inst_operands(&dec, isa, op);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
     return format_inst(24, &dec);
-- 
2.54.0


