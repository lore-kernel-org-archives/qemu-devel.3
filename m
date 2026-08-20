Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D0AC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjs-00020n-NC; Wed, 19 Aug 2026 23:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjq-0001rS-Mq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjp-000463-43
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1758193a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197604; x=1787802404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXSMuIYcdvTbWFw3R3IymTx+qxtp/rW/iojAskcb29A=;
 b=eJdSQMS83c8mkJp/YL3m2yF1MGKbcXmF2TMhMxfd97MCmG1vEwvNFIeexioARoGpqD
 /8bcZJRwehKVqVFIMqz+6Jc/pyGKCpezIk9MUHFNkKCpVzy7b/FTwY+opNDCysHCIUR0
 JQLWfxrjgt0O3O9EsID9QcIZz6lZKQHegf7P3mTiQLkFBCq2lmvtcJythdh57uDO3782
 TD8LM/oCtn6xbfJhB5Eu04xMbzH/qvZBFbCPk7SoH6QDKcwyNl48ER9kWhkJtsYMZDCQ
 MS6tT72Bn899jVZp10Mce1fwAyef2qljg9BhZLucpdtYVbXeXFQ5j3n3eLiJWDuv0ch8
 cCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197604; x=1787802404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXSMuIYcdvTbWFw3R3IymTx+qxtp/rW/iojAskcb29A=;
 b=lLoiJgSHqSdqJiwysBPef1pieK+/nQisQJS/M2291XK8WBQ7xNxyPdPG8+WLyHXrmG
 kuVRlvuwsU+fIkxxPbHmybYjPPJaS794JcYyihybf6Cbut3t0wgkARt+vJi2fMLeeePl
 Z4htJwVoeid5WFvbkDGJydUjQufD5HGopRNIVy8J5QggAtLF1wW0Y26b4Vq0seiS9shn
 GY2AiH6KMWRNX1D6FKOyFXIOe1Fs8wB75N7UGBXfNWcDhWcKJGvKBnB8lF8MykLquTFU
 NzeeK+6zoo59+/AkFXcOZ3AQuyF9e1AWOJmtpOX2/uCC1PURKWaBAXT6o5SlUzQxOdCl
 8dkQ==
X-Gm-Message-State: AFuF++mkChjUPzRkMo6C+k+4PJYSMNOZ3yTL2i9VZkSC+zocdN7vmJZI
 CmuxTgJfSJ6/NGZwJH3sCXgLodYrR5/GEUr5tC3LyHM4VPSDdTnDvX5QY6kYOQ==
X-Gm-Gg: AR+sD11SfsXaP46iF5P8IexGFaJ8v9YQDQVrjacgwkwPuJ8NN+WYJpxCLfPOjYE2GaC
 ZSwPzf0nA3FI8Z9b7pPZf8wmsuLovnbY7KWKXnBQFq19TWIMumMQj0RmzM51jAFmGc+MF7znqWG
 6uyIyc+ET1yEMcf8G9Xu4Hh8Pl7LADHEnlZhsPkhsc99IGmDhlJPj/Y+YnK38NPBwT76OqeZBFW
 qK7qqSAbj80Q09ueY+lDVbtsXKKHVp+sNA11ir73OQN+hAp447enjuNVoEtjq8V7qGTFpbPN7TX
 E7ptXimNzJyNsONWUqtRh7unkl0/mNixrxA/gJl2/t8yltjRCLDeO6kuu1Q3SxsoEjBRjaEV+sW
 GSusqzFsl+hmcxPdZWDT92l3hjiBptom2QrEbyY5lrH/8w0FcNP1BFuH6JBF2H53kDpgQOyj3VN
 w+f2Xsn3HiHDlXF6pUPkB6Kws5ajPKCBxYVvPLKi2y+rcIxqkRbRlUKhOBr9J4aYDY+VtGeAPxs
 PKkDg==
X-Received: by 2002:a17:90b:544f:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-39580f0943emr19445423a91.5.1787197603809; 
 Wed, 19 Aug 2026 20:46:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/93] disas/riscv: Pass rv_opcode_data pointer to
 decode_inst_operands
Date: Thu, 20 Aug 2026 13:43:37 +1000
Message-ID: <20260820034430.1186695-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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


