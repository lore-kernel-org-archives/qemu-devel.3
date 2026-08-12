Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97631C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t3-0004Pj-Eo; Wed, 12 Aug 2026 08:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sy-0004B4-TP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sx-0008VK-8B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so395544f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537001; x=1787141801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LsoLDHnYghJUoEKHkwC8XnaFsRjiPcziLwYSVW0Jgvk=;
 b=Ly5ZJEAHsQOUMfsnGzZf6uYJrVMEszT6prdwQnylF3SIr2pBSTE3Ju6Gw/7ehUZQwV
 6rK2eIBUjHuoVxAnPhjWYqxk01qZHPP4mfR8TSEGxmBjFs6kVJLlVial2lG1E6t1onP8
 mE5gTgx4Oja497O67y5Dyv0jqiQZ2K+zYbwRmn1EJcFRFj3ezi1F4T2BUHcg1rDJd/0k
 iuFp13dGwzCxMC4Jd/R5XLDu/vcuXfCQPbp0QA8fSsSRKD5iu7Y1DedIFpGGNQxoGoK9
 psDpU3R1H35HV7QMcRKhXkBUDly6a02c/50tqD70Xtex7Bx12fc2DR5bj/yP5Y65VC8v
 tPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537001; x=1787141801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LsoLDHnYghJUoEKHkwC8XnaFsRjiPcziLwYSVW0Jgvk=;
 b=KooBTo0VlI6ShjJ3A/9BRxUKDNTAFisyUph8vdNy9CqMhDthk1TY0Nnfgwqpnp/MQu
 y/39d0MSCo2rPLlWpEPGF0497Pg33LZvpyskNzehPYxz8dm0eUhZYSLq7GWHalWGDT4N
 ODa5Q/ZUd+B7DyXM5eLlEW0UgnFrxojediDuz7ksVFzbsJDdFqL+fwZGXNrbhbiFDOAq
 Yqv1+xc16PZcaGmWfvajtazXP3WoINcnIYQnwL6iYCIZzODYQfkI5abR7q8mIUAGAdaZ
 VyCWCXqLIYmIX891z6yxnYxWOHV6EI5iAh6UUcyyQyfip8/qDOOwsr+OOvhRAZgwRChL
 /b7g==
X-Gm-Message-State: AOJu0YxyXYuAayDjR0wrRHtYyZmsU1MvCyXoLP4ooTCTrtHMQpc2/2vm
 /iaw3wIMkZg0+dIJ4yBHk4TfONsRbKB9usIW4uPVqAHh5Rw+zqdkg9V9iGq2cYULpnA+8VjTMhC
 69gq9
X-Gm-Gg: AR+sD13J+qGtO1NCScG30M1NT7V7tKCgX2qlWlGg8NH5QZnZaCh/OFY/hNl4nV870Dk
 dgI4T2/ApPzbL5kksQE/UFBxe5xfOhk0ZeMrd6/JZipE/uxTBiI7GFrXh025iKIPnOdzT2xT742
 1gCmzKeIrFxQEGeTP59U4cUPjQpVQ5lmN1LUowG7LGIzkiAsGberlWTHzW4ddtoUFUlHnNQmxhG
 ZrZLQZI+srqL139aztVurFeOMEyTWkQJmksdNYSamEXGHK+Iawpn2wWTpn6eNfD6BlOQi25wXPP
 sklZzS8r08U4U0brF2hzBJ8TuWIqx+KlW+h4Je8CozADkpzgooNofAxgVrDPx7+qrDSvnG28dJ3
 s6KVqqoH8UPRovrrP35aAQw8zDJy9qMgG7wfPhH+xA8t3zfYeAiF3BVosiwDuSw9AyqUkQM2aeE
 uTC6cElZMbsgBBDXvmrYgMYKFXxj7+PDdB6zrZzEp131xgXIpZlH7Iqpgc3CJUyvu7y+6NlyFrU
 XZNoOTPg/5PF6EhXuFOXpNuCIDIEvDXTxw5YwLk77GFW6qseTR9YM7XZTkA4XOYSuoeJw==
X-Received: by 2002:a05:600c:628d:b0:498:261:dd93 with SMTP id
 5b1f17b1804b1-4997c18d823mr65316715e9.18.1786537001579; 
 Wed, 12 Aug 2026 05:16:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] target/arm: Enable FEAT_SME_TMOP for -cpu max
Date: Wed, 12 Aug 2026 13:16:06 +0100
Message-ID: <20260812121622.649730-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9930974a50..cc42db9e0b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -188,6 +188,7 @@ the following architecture extensions:
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
+- FEAT_SME_TMOP (Structured sparsity outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 64e25a04e3..48be49580a 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -177,6 +177,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
+    GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8a3ebf6321..24f34947ec 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1384,8 +1384,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
-    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* FEAT_SME_TMOP */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
-- 
2.43.0


