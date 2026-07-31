Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77BFC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppyP-0004qI-Bt; Fri, 31 Jul 2026 12:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyN-0004nu-Oc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyL-0000Sp-S5
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-472326ca506so867869f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785514832; x=1786119632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P8y7FwywKZm7mMFJi3dJ5HYMr1USdH7jbbn4Vnp7ANs=;
 b=oMAF8NtEtKox2jVOH8wA3GkScgR+5bemYYkGAQBd1hqm682dURBW7iOnB/aeKnfA54
 KqOXDpFDNxgX7yV3T9SxMqoLdq2IK5r2B5hJ4nyezCuCJJFrZmSIqZW+/iv5V8x6xT0M
 evVLgfkfq6UqTmqRzPqsayawJyxT4l0O70Mivf5eeOKegob50rePgchlR7tWk2T8fLl2
 GcWj62ItxUI71iuSskIyhICZAC+FN8QJuEb9vW+UFX1Kc8LR0LbChgpj0TCTfLzg7wON
 JP5HtfxCjm05NCmnV6PS6uQxGmTnHwdIkV1PTaLTaxPASs1XKiwxbC/f4cJraepoAYwH
 gUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514832; x=1786119632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P8y7FwywKZm7mMFJi3dJ5HYMr1USdH7jbbn4Vnp7ANs=;
 b=IZbBWGgDA90qz/ePHKLrbwz6EWeCcD55/zg8G0lCsiE2zACQpG3jB8vKos4N+eMvaH
 iFcjUndUsCvbFRYDrPolIuFwKqL9v3T444emlQ7DQaaq7ps51fRJjueLrT2fPs+AsVNX
 nACny+dClufO1VrzG8ErxexwWrq9tR5TKFgqxvLc2eQJE5vv0GnZD4A5e44opMAoEnAM
 /MgqYd8kTBHp0VpFoBjyi8nvglCEygvKYdAGh5iFKJ1gUwS3vgvg2rM2twMuXZGcYoPz
 Qki4xqLWaWNun3iMSQjxbycz1Nh8GKV5MZjUofUE6eVx2a3r2mEAtX7X4Q7yyQhKPWoU
 CNHA==
X-Gm-Message-State: AOJu0YzKkP42c7n6ho9Q1qUczpCgUglCJhdI5XA36SKa1IVw5MhCAbla
 HX4wXUhxl4u/ZkzBRwdITp1qOkOVObR8dgBEQWKGh81+Ti1F93K2vChGZUU/Eq1DM3U1L05eKvH
 8DApn
X-Gm-Gg: AR+sD12fEP2TYX58g5eAKG8i294dhXfq5knn2lREwAaNOvEln5VqtMIz1ZvzbUgQB6a
 s/t2OWSltq7JeIOeu6fSbm/K4biEF7Fap0qjHr+WveKvjo2zAce4Yj0fTtQXuDF54E4HPgh3k8S
 6g1Yq6iPuRoFL0ZNcxa2Qy/EGz3vRtYvVJFoWODVCps129d5mgiePJ0NkcVQEmzJrRkBY5dQBaW
 Nqx9RvUDWT9DVaHeCxB8pFUdw82RL+Rlp+cPEXvgXFVQjIYaBErpJXLpPsfhaN2T/DVrMKARU+K
 30cFrsHOPfZIzpNjw7IiqQdBqGdaG3C7l79sxjBNjxrfjNGea2mLJkhFAEg0w3w9O4hNu7lZwBT
 owEMzbf7l7p6GuKh2aJTbsQzLemEynn1kqVdoH7CcFyCLuxipP0+DGuvPSBuFdy5mpyJYUimSLH
 24jjLk2xO/Kbc94pg8EKPHv9MvDWG7WFNjnBKAKyeqgwrZEc8KrWctjnKkNT/rsIScXcHigpfoz
 NNQ3GWpkrlUzIe3QdGPYqQFrfFbCenykaJaUWhijPPi6sCkFFxONwlZTpbRmP1pCJvVOg==
X-Received: by 2002:a05:6000:25fa:b0:47f:8f8f:e493 with SMTP id
 ffacd0b85a97d-47fd72ba69cmr583651f8f.3.1785514832237; 
 Fri, 31 Jul 2026 09:20:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm6328593f8f.34.2026.07.31.09.20.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:20:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] target/arm: Make YIELD, WFI and WFE be NOPs on pre-v6K
Date: Fri, 31 Jul 2026 17:20:23 +0100
Message-ID: <20260731162024.3097467-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731162024.3097467-1-peter.maydell@linaro.org>
References: <20260731162024.3097467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The YIELD, WFI and WFE instructions are in the NOP hint space, and
were only defined to actual non-NOP instructions starting in the v6K
architecture; they are also present for all M-profile architecture
versions.

We never did check the architecture version before making these
instructions have their special behaviour.  Mostly this has not been
a problem because a guest won't execute one of these insns unless it
is prepared for it to have its usual effect, and because we
implemented SEV and WFE as NOPs anyway.

Now we have implemented SEV and WFE to be more than just NOPs, it's
important that we have the same condition on the SEV as the WFE, so
that we either NOP both or else implement both.  A guest probably
won't try to use SEV/WFE on CPUs that don't implement them, but it is
valid for it to do that and rely on them both being NOPs (and so a
WFE-loop falls back to a pure busy-wait loop).

Add the "only if M profile or v6K or better" check to YIELD, WFE and
WFI.  This means that all the insns in the NOP-hint space for A32,
T32 and T16 have a correct feature check.

Fixes: 60e7ee5bb7cd ("target/arm: implements SEV/SEVL for all modes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260728111629.1705308-3-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 6e52ad082e..055f3c5b40 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3235,10 +3235,14 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
      * the next round-robin scheduled vCPU gets a crack.  When running in
      * MTTCG we don't generate jumps to the helper as it won't affect the
      * scheduling of other vCPUs.
+     * This is a NOP hint on older architectures.
      */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        gen_update_pc(s, curr_insn_len(s));
-        s->base.is_jmp = DISAS_YIELD;
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V6K)) {
+        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+            gen_update_pc(s, curr_insn_len(s));
+            s->base.is_jmp = DISAS_YIELD;
+        }
     }
     return true;
 }
@@ -3280,17 +3284,30 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
-    /* For WFE, halt the vCPU until an event. */
-    gen_update_pc(s, curr_insn_len(s));
-    s->base.is_jmp = DISAS_WFE;
+    /*
+     * For WFE, halt the vCPU until an event. This is a NOP
+     * hint on older architectures, with the same conditions
+     * as SEV.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V6K)) {
+        gen_update_pc(s, curr_insn_len(s));
+        s->base.is_jmp = DISAS_WFE;
+    }
     return true;
 }
 
 static bool trans_WFI(DisasContext *s, arg_WFI *a)
 {
-    /* For WFI, halt the vCPU until an IRQ. */
-    gen_update_pc(s, curr_insn_len(s));
-    s->base.is_jmp = DISAS_WFI;
+    /*
+     * For WFI, halt the vCPU until an IRQ. This is a NOP
+     * hint on older architectures.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V6K)) {
+        gen_update_pc(s, curr_insn_len(s));
+        s->base.is_jmp = DISAS_WFI;
+    }
     return true;
 }
 
-- 
2.43.0


