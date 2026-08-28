Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CDC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052L-0002tM-M7; Fri, 28 Aug 2026 18:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052J-0002rI-At
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002Ke-3z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso21850365ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956010; x=1788560810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAnGfAmlIa4zGWUxbLQOr6sCdCNjHw8VOXPeiP81wTw=;
 b=oWcDzdWaYbiJG7CxTiWQjVMVmbp8iRMnhlHLP5aYW+oz8tIw5SLZZzL9Ly/bNxfgDA
 o4uJOh2gzLICn1KRNTIZHKziCvNApdXa/o+ZjbcKGwuMBrBm6GN9+NSAyn6FdSLd8jd0
 2WNZH1q64iZQT/rwOQV586twa12Y3AVOU0IkXPEi7ei/nEBc+/dsX4RCeMFeFacO6iIE
 Mk4gtBg0eMwxP1RNl95Lf8ebCsI3q05Wvu/YDJCKAhS0Q/dOvIqi4e2SpLXsYytdf0KO
 MVCDMG8gqY/nIewOCq4RsMU7g6lalJ6i1MXzWbhsiUuiHxf465y/jxLcIJnx7K4i6T7D
 emJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956010; x=1788560810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iAnGfAmlIa4zGWUxbLQOr6sCdCNjHw8VOXPeiP81wTw=;
 b=RSSBthUcvPe05gAInedM6/f21ubV5QdUpFTkVZIZZw/nPTLzBCuyUxKRPVtUAiMuJr
 r3BrliO3ESHLql2p9iwvkfMEiQY147l+QcmA8jHBwkw0Ybnh7Wk9e0F93ViRZ5r5oAYt
 fwIIQR91fHsT0QavWeHTJZ6RLX20OowgImSsZtZNmtayftwBBo5wrjUWxaN+CUFnkbQ3
 E91ZmAR/Z3JT0G9CjSqFa+uBh3wY1mPyaszYZfVy71VZT04t5aGv1sxMjgkqFMfIUx5n
 ufC2+rjTqzZZaF/6U5mhS+bPYELLcS1r4J5ZXBmrxeUO7ScAo0yq/xde+K/nnb7K5Aw5
 zhWg==
X-Gm-Message-State: AFuF++k1+Q+1ngO2+FGdOF6Dyu/w2mPFWS8zeazAXf84bEeBi0oIORr3
 qqsT3T3JJUG3uCR47vrMYaQr3ucV9RwmTtBpCZ76K0gaqoIOEhinbnk+QAcrw+iKlr68zzz0RxA
 Uv7e9uJ0=
X-Gm-Gg: AYBFou1D9wqiy0yzXkXqBJ6hB7tlNK9l20Fl6469ivPh/EQyVQ0E2d/fUP5sfrua4b0
 OJw87RtRvMllberWdGUTo4uMrYRyg+bELtqI4VvPR6FoCseWri8oivjRWs+smzGVC2cBiRKkvOD
 20OpTSguSErPum3HAzugNjedoFj+evq7+elE9rvZINrFUCkiOcPrAh9dhfBgTYM+3MYUrv+IMkr
 hIcgHyEtWMxlf9bmMoJQRLGeNajH2NvH0rrb6N/D+IbECYEw70f0OYU6f5yJdK0nsa9bTnI3B7j
 EmFEGjQ5hPc0qZxZML0atGJgFsDgxmXg63NxFetKQJb1JkwqrjTrySWlUh5eQDl572MuDc1ezOs
 sgq9UxFuw4B9JmlXHFpCINXeCaMMz2LSPyFkxzayjycTta5gQ/L4a6My/YHWaxtpmdoo8FAXRpn
 wnv86234rbK1UH83azStCTIWKtyq2BRHl+SLjRnxR8CIpnQx4olQ0pkBkl1LD76d7thNkihK0pt
 bsQYNMn2OSEXpcQX8uifiRN/zhWfe0=
X-Received: by 2002:a17:903:3d06:b0:2d8:d4cc:5baf with SMTP id
 d9443c01a7336-2d8d4cc5dcemr50529365ad.15.1787956010298; 
 Fri, 28 Aug 2026 15:26:50 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/13] target/arm: Honor PSTATE.UINJ during translation
Date: Fri, 28 Aug 2026 15:26:38 -0700
Message-ID: <20260828222639.1432046-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  8 ++++++++
 target/arm/tcg/translate.c     | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 026a2a72d05..05741c94dd7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11168,6 +11168,14 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
         return;
     }
+    if (s->pstate_uinj) {
+        /*
+         * PSTATE.UINJ injected undefined instruction.
+         * Priority immediately after PSTATE.IL.
+         */
+        unallocated_encoding(s);
+        return;
+    }
 
     if (dc_isar_feature(aa64_bti, s)) {
         if (s->base.num_insns == 1) {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 40929a6ef78..77391c5486c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6125,6 +6125,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
         return;
     }
+    if (s->pstate_uinj) {
+        /*
+         * PSTATE.UINJ injected undefined instruction.
+         * Priority immediately after PSTATE.IL.
+         */
+        unallocated_encoding(s);
+        return;
+    }
 
     if (cond == 0xf) {
         /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
@@ -6700,6 +6708,14 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         gen_exception_insn(dc, 0, EXCP_UDEF, syn_illegalstate());
         return;
     }
+    if (dc->pstate_uinj) {
+        /*
+         * PSTATE.UINJ injected undefined instruction.
+         * Priority immediately after PSTATE.IL.
+         */
+        unallocated_encoding(dc);
+        return;
+    }
 
     if (dc->eci) {
         /*
-- 
2.53.0


