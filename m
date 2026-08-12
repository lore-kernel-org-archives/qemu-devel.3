Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4AC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUO-0007Dw-Ss; Wed, 12 Aug 2026 18:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUI-00079i-52
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUG-0000vX-LK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc891373e0so1796855ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573911; x=1787178711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/E6Fwaz35a68K1w+UujJny6WBEZEooLAdbD+72JhRU=;
 b=cChw5LAMMnPiwvddQDfIXnqgg/SXgpqbXfTM7tnU95C2ZF/zp/K9UVJ7lT7/QjVvyP
 je7EVgxWpxjqBMvRRxrAuoZpWRUHiwGDciI1s5ld/gqqXjyY5OWfAkQF6krQtGKaYtW6
 le91N0Hz3cnv4a1S6MmxDXmrnitUzmKcNsZSLtAaKa4r8XtTTHw8vFCwbeaSCLZL4dK7
 kyHFbJE18XJxA17q23JFDzT4KIQGckP8MJymPHRaiimmQCXH/drovCX4XHigWsA+7OLK
 x6KV3BxJrzWfnI8VIO1H2QyziK2hY/q3SU1sraEAPKK+Qi1jz8x1OGnCa9x7I8uJUFQl
 4PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573911; x=1787178711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/E6Fwaz35a68K1w+UujJny6WBEZEooLAdbD+72JhRU=;
 b=CW30DLeBSqXxR72L0ZvwsA48fJ6m4meqjy42vvNttcGAss3Ro7mYAM6qUl6Y6E7k8x
 TTwyMFxfFE2VChngwKIRY6pxim46gA87wbMisvBRUz3JmD9eADtWM8iu/k3qZ5lwJHH4
 hadzklbnjc9HdDyvGS+uoIZ1mTQX1pQeLzuAYYrOtO9VS7U2BEN4YY8y83fXRQWLi3zb
 UvQIBBxVNk2h4UH1iUaOP4c6jp72XkMBqgPbGHCdN+DBr5vj7Gsqvr2VvgPTuGObJ+9r
 s4uMRwVOJHvJuAvYGHRX3wifHjz7mFTzac/h+Y/1EbNdTo2rhONFzSqaiu88AgNqfCCf
 IaIg==
X-Gm-Message-State: AOJu0YyEfn3p2cV3t7B1TwfZv6SiLmhZso98LrlK+Bqs6RCKiWqeh6SF
 Pt0lE7Iz6xhAYE3R073g4O8r6/xekNbSDCLSYhUYQohq96C/MipR8tlASJzUXnUCKoviUel2MP0
 qquw/
X-Gm-Gg: AR+sD113QhQ7S1J+78fxoJVy1KKSUvgEBs4g1k7cb/D9i1y+LyT07vzY1SFYJIGjNHC
 Egw+8aEFrj7qtzIwEAa+bmJnw8+8ajnwoRcbTnHiAFcAAz27Nt4UHeqqW6Crk79F4UJaxY+Yq78
 DgQaZfKEFtg2rpFGWeomZjD9Fxxg/hAEwQnPUF1HzkIq05adCm2f7VoE26HvzeuhwnOquOJFXfs
 A+6WVp7lLT7gxlCBEcy/iEjoA9bcj2azzVGjbo1VSGE6n5eZdKXHTwE6SqVJvHoVkQ+XaH1XLJD
 1mdyOqVfYIfkdXuJJMqh1yAQKuu+9OcaNmR2FTVhOyTF94pv9Irc7HjtNNU6ZyZsFEHnyvbTNQ6
 isK/kTjgKNPEsYAqvvKr9hPPDvxrToryF6tPiL/DnSSNt8uD0ndLn5X0prHWeMwXG8ItKiIhV7d
 DG+ZUWRo6DrrML/C67KcsB/kYCAHt8hzuXnpC1h0sJBF0sEcjJTjAkI5v1Ml8rvbL5/AL2Yjx/M
 ur+CbdHBpEzGy6CWl3kLA==
X-Received: by 2002:a05:6a20:e211:b0:3c3:8651:b302 with SMTP id
 adf61e73a8af0-3cc553a08d4mr1594036637.28.1786573911090; 
 Wed, 12 Aug 2026 15:31:51 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 06/52] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_lift_pseudo
Date: Wed, 12 Aug 2026 15:30:56 -0700
Message-ID: <20260812223142.349142-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 47fae7316c..0be2f07612 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5358,21 +5358,22 @@ static GString *format_inst(size_t tab, rv_decode *dec)
 
 /* lift instruction to pseudo-instruction */
 
-static void decode_inst_lift_pseudo(rv_decode *dec)
+static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
+                                                     const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    const rv_comp_data *comp_data = opcode_data[dec->op].pseudo;
-    if (!comp_data) {
-        return;
-    }
-    while (comp_data->constraints) {
-        if (check_constraints(dec, comp_data->constraints)) {
-            dec->op = comp_data->op;
-            dec->codec = opcode_data[dec->op].codec;
-            return;
+    const rv_comp_data *comp_data = op->pseudo;
+    if (comp_data) {
+        while (comp_data->constraints) {
+            if (check_constraints(dec, comp_data->constraints)) {
+                dec->op = comp_data->op;
+                op = &dec->opcode_data[dec->op];
+                dec->codec = op->codec;
+                break;
+            }
+            comp_data++;
         }
-        comp_data++;
     }
+    return op;
 }
 
 /* decompress instruction */
@@ -5464,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
-    decode_inst_lift_pseudo(&dec);
+    op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec);
 }
 
-- 
2.43.0


