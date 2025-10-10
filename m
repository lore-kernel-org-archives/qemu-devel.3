Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FF0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqP-0007Jx-U1; Fri, 10 Oct 2025 09:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqB-00072J-VZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0003xw-1a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso16284945e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101580; x=1760706380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RlBUUTIQO83oi35+gFqrHr8rvh5bv342xdcH4feI04=;
 b=cC6eUWEGhuBuuicqHMTm1qCYuwGxx9Gs3mMsbPkpJqAZA8shS5DxNV0xIdYyLd7Ch0
 Hox+TAY3Y9Vp75dwPi6kKZdS8FGtTjRBgLcr9afDtEkniOeYwgqMG1Eg8UZ+2pBxNcbE
 Vokf6Xh8UT599xFg/BpH9dLlQNhz3oHhM5DW6NR6BR9kp8Z02QKhSc0eL5ekfVem/cOB
 rTZ5hQR2GSr9sYYqc6Zh/lQJHjAlLiWcNuuftKiyATj4NS5VYI3wmJZ2YWfqwOik0qlh
 l6b811arXZ1BipLt8d1J8fbo2l2zkR6TJwb2Kab//EkCe1yjauVCh+xgqQ2nDwffXZgp
 kGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101580; x=1760706380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RlBUUTIQO83oi35+gFqrHr8rvh5bv342xdcH4feI04=;
 b=lQwe8sLiiNLu9pnAhe6R88xUNKHwRmqxakLISMGoO4LLSIG95X5Y2/iCxsEc4kC7N9
 LQyP2HU8iDR72tU5VvbxMV8Fm1Q1ZX7TQCdx6msgpG+NSs37+Fs39TMB3Ao9+0OlkH4w
 JacvqWfntoAhnwexEN6kUk6fwPVIzelSWtfUT/pshHErfQeikZw6cpGU7FhzV8JpVkLW
 KC8Iawev+tyqIGx3FmGbZy+gKYEo4sWN+DafL71PMAk86B1X+MLiVrTO5o0vn0UEhOy9
 ohnrEC+7YRwWo/tU6kIajFtOhHj9q7hpqbRf11/AmJEgrHGbW1ZS2EdlhKPxpxoDF1xh
 3rwA==
X-Gm-Message-State: AOJu0YxiqQORGuJqm/j5a0iHxVPfLvHyvz1p+/4k8pjh437ljFqtJ86j
 rUcK6ooXJf2VdH+oMWFLD8+sNiaZhodF6KzZc50bgJdKHxdldVK8Pztr4mvQUqVT9Gj1gEIPfLv
 Fc7TQ
X-Gm-Gg: ASbGncttWUB9CHnFCNh47alniOMifRCY7iiLCbF7Tl6J+jiJ7k3QJDI4qyhFxkn6uEJ
 9voXbiLWZRL+QK3Pd5fwrqhL86QpKRHiG80H0EFCUvTVQH+ubHP5kUFUbV3mjSrYzqAV4WMb92H
 pK8Gn/dnd+BmOdKpZ9E+6WTf7vNRsXrOb3fiMoEaM31oLjIMOmHCPut7cAv72vKt0Qk4dAcqt+Y
 a9EPQ/S9zyc5OaLzWIuWXKssA2aNwI7sC60/fj9NvVlFYqw3Sb9+7/i73TZ1NslXeg+N5bId1Bv
 HLJRnfbuIw8FA3BmskMP4sWgSYjycvGxNNgyE28ITryoGNeHN3Gn6wdNtm73HhRIMOwTsNJZDhI
 3zmNkqOCDWQ0sKuBtYlizRrltrKwFW0e0HnO9yJ8qf2jNP989XobFFxSNn4EreA==
X-Google-Smtp-Source: AGHT+IEnYd2//mv61PFZ4MvSHv3spbxcb2TMkzFxgk0lO9gXZuXM5fCFsiBJHKCwWDcAkNE3HlbrFw==
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46fa9af0621mr80234755e9.19.1760101579957; 
 Fri, 10 Oct 2025 06:06:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/76] target/arm: Emit HSTR trap exception out of line
Date: Fri, 10 Oct 2025 14:04:55 +0100
Message-ID: <20251010130527.3921602-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Use delay_exception_el to move the exception out of line.
Use TCG_COND_TSTNE instead of separate AND+NE.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-45-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 78d26aac043..57bc8ea4c54 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1774,21 +1774,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
         if (maskbit != 4 && maskbit != 14) {
             /* T4 and T14 are RES0 so never cause traps */
-            TCGv_i32 t;
-            DisasLabel over = gen_disas_label(s);
+            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
+            TCGv_i32 t =
+                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
 
-            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
-            tcg_gen_andi_i32(t, t, 1u << maskbit);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
-
-            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
-            /*
-             * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
-             * but since we're conditionally branching over it, we want
-             * to assume continue-to-next-instruction.
-             */
-            s->base.is_jmp = DISAS_NEXT;
-            set_disas_label(s, over);
+            tcg_gen_brcondi_i32(TCG_COND_TSTNE, t, 1u << maskbit, fail);
         }
     }
 
-- 
2.43.0


