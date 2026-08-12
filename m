Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CFC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUH-00079b-II; Wed, 12 Aug 2026 18:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUG-00078N-3Q
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUE-0000tm-51
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso64258b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573909; x=1787178709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HsAVma9Q09T4VPTfqzHPIQ5GcTD1DQ9g0qyO1ki6d2k=;
 b=Jvd+HAYMp/j466YbVIImiOiqlckapF7h+qVFFhrF5S5m/uiwqg07HLHvSsYoUvoeKF
 QojgRTb+LK/QksKG+ydVACDALvOV4R9EEUQ2YOo6KXDvMOef8d0/7OJoOwNzB37uJhHH
 ak+vbP4CmsJYGIl496VC0tFHwmegDonVjONZOvif6yvTRsLRMdIGBee1m6FXod1r0Tq8
 8wsbuaLynrFrmxtxjpF6/Grg/XkthYQ3vSPgvhjB45xyT2wmD14rpsSQ4IWLa8NBbTQa
 Faim2sh/bOPox0CUJnxwrqWZokpnoUU6FYcKFKSdm0s5RNxG+iHJNH8kfhfRxPoEpJxE
 PQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573909; x=1787178709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HsAVma9Q09T4VPTfqzHPIQ5GcTD1DQ9g0qyO1ki6d2k=;
 b=YYHx0qm1lge03BHvyeL+ofstMEIgbeqXIJECONzaIzak2CPqUA357qX8S4mOJFUAm8
 Cd/HJKweTy5wg8ROhclb5T3a0zM6Ro2DltPQuVhvgkz/DQeSGpcjxwhKD+Ju8l29P74R
 0FBnDORAVh+fKptICDqMvyuxRG6OX6UTPMDHTwX6gg8KG7vdvloE01aoYNiBQ+kI/pWv
 eF81rUgEY39GhTRt6jgJYDoQElhpP6YK0DEx5uqBXyrkbMG3RHGEdbc6ct2Lx2S5+q74
 nJLc66xz5rLDWGzoYbUcg2rhmRobZ0ddKGxqq6ZmerCEq659ZuTjW2/bxGnp+Kag+hxj
 GbMg==
X-Gm-Message-State: AOJu0Yy1BaH4ZOpD7205WIn1MwncEYyxYZ1zPcY9dTrYQ7ctgbdcK/BM
 Df5GqSQpQ0owVlV6+d1WQkx9F3zvisoDf8iVs2B/9W4LzkEY4MRHmLQsgsXeeOaVaiI4Uv3AwSU
 S2Rt2
X-Gm-Gg: AR+sD13oOxEF0McdBvCfeidRifkX8+gQWdhHc7KyB+UbuX7lAmAIIKitZx3H3WfMaKh
 3vWA2z4nIyAeZsu+6bM4iyKCyu6xAdmWZRLedsYc18S3QuLsi+lu8VFWYEyTNv4rkqBUiSOD1r2
 THG12milyvENnYWdT7/jE49d2qSsSwPzlnb34Ls/Q1xMS2xkcxfxRacIS//a4xXzuDBe6kKIgwG
 1FEV8vKXshb4n8R4COVBk37j41554zNQKB7lJ79DhzC60KIsp4UID92POX5IpwgKMhAWmBtYdlv
 +3bUs6hJ4GkaAwCdaJs7GGPSone+AYTDc86sHPZ0e+ijFdCU5r4SaMAUipzeAy8UPlwg36Cyr5Q
 Eo2CnLMDb5dl8twPqj2RcDcXnZbr/Zvqb1nHvyez8fqscIFKJqqLVAFAVpyCsYofoP1xBTdRthL
 TjqKy/lhWFRFpdx4CliekbCA1hVMt30uXs1aD4Cy3aGvceBWFYzmWo6p6SgR7YQi81bpfQKJdO8
 HmWKbrUAvQo0lMuGgaRMqdXa5oNv4M=
X-Received: by 2002:a05:6a20:3ca1:b0:3cb:9bb0:27a2 with SMTP id
 adf61e73a8af0-3cc5547c7a9mr2068983637.34.1786573907675; 
 Wed, 12 Aug 2026 15:31:47 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 04/52] disas/riscv: Pass rv_opcode_data pointer to
 decode_inst_operands
Date: Wed, 12 Aug 2026 15:30:54 -0700
Message-ID: <20260812223142.349142-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


