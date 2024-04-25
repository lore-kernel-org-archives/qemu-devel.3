Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E5C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWN-0001xn-3y; Thu, 25 Apr 2024 06:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWL-0001x3-Mm
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWI-0006xm-To
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34be34b3296so784167f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041601; x=1714646401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6I7eopQEiXePMFfuuglLJED0IgYNow8XyLPv9LxTAY=;
 b=R98+e1E23BMmnj6FZ+bXoWlaPh+mxHpL1Qb+4PSBxsPfJ1fAgXgEMDflEm1IFSlvYb
 A8MQeC1imZkBG1uvpqVtTZW3fN2dM6j6HADlqdRjsBuM7RudH42TxpEzB8JrYzG7IDXh
 L+5Q0Lj24nx3aT3MqgtLrUkodz92XiYIO+dKgAYufc9ohtVC95AJF4f+Hve+bJ6d9A1L
 vZVMwON7uutgjQjZi6qfTCRedVN8fB8HQBGDb3qWX2NZxLd2WwJPTpdVvhoTjgJOLYnO
 MtuOUDJHU8myzaJV1vA4nnuNcKJem4FYGg4v1mbiBHWeKC3R+GhSO0NR/4JcplLOV5D+
 B3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041601; x=1714646401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6I7eopQEiXePMFfuuglLJED0IgYNow8XyLPv9LxTAY=;
 b=cjFMXzjuipjcyTxVvTA+9nEVLj6S0t3bLWGnGVBIZWdeze/p9it5kF9Cog8mYDgdu7
 OT1ysQ9kEeVowO9p00GHTiVqIL6zv0meu0lD08ljifXVgydAFExoW7GrJ8QnPFesHTg5
 qhs8sDgNYxSmS649AxrzA3vRkipWurXM4Iftafzels20mydU7gyo1+d73Gh/LMcI1nZ0
 SqSXEo66yLBqYNhvpPf+xuijm8jCTDzuOzlsgSgSKJL5BhPFR0icgKLQX48rLrRTrm41
 rxk26WsFiEJuLVtpZI7ouHEahuPwLrr8/WwCs3IrNd+VWuqUQUI6D4sKUoWjGcvROz2i
 yKNw==
X-Gm-Message-State: AOJu0Yy935zI+bzsFCg3QUT5GOq+UZ9T9r4AoG6KE2b7OWcmswn3rr6w
 7MkEfh5WBLp/xlHqUI0BDS4jsSHqoOXX7iZGSFKGeR535LS53cCq/BTYVhA4zD5FpaqXONTxhXG
 5
X-Google-Smtp-Source: AGHT+IFy3IqbE1xDbneFglPX26pi/zREeqlNb9QykjMaNu5wtYIjTq8Rnf51Ta2idsWnHgh6JSFhcg==
X-Received: by 2002:a05:6000:1042:b0:343:a183:4218 with SMTP id
 c2-20020a056000104200b00343a1834218mr4625611wrx.52.1714041601143; 
 Thu, 25 Apr 2024 03:40:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/37] target/arm: Add PSTATE.ALLINT
Date: Thu, 25 Apr 2024 11:39:23 +0100
Message-Id: <20240425103958.3237225-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

When PSTATE.ALLINT is set, an IRQ or FIQ interrupt that is targeted to
ELx, with or without superpriority is masked. As Richard suggested, place
ALLINT bit in PSTATE in env->pstate.

In the pseudocode, AArch64.ExceptionReturn() calls SetPSTATEFromPSR(), which
treats PSTATE.ALLINT as one of the bits which are reinstated from SPSR to
PSTATE regardless of whether this is an illegal exception return or not. So
handle PSTATE.ALLINT the same way as PSTATE.DAIF in the illegal_return exit
path of the exception_return helper. With the change, exception entry and
return are automatically handled.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-3-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            | 1 +
 target/arm/tcg/helper-a64.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bc0c84873ff..de740d223fa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1430,6 +1430,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_D (1U << 9)
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_SSBS (1U << 12)
+#define PSTATE_ALLINT (1U << 13)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ebaa7f00df3..29f3ef274ae 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -892,8 +892,8 @@ illegal_return:
      */
     env->pstate |= PSTATE_IL;
     env->pc = new_pc;
-    spsr &= PSTATE_NZCV | PSTATE_DAIF;
-    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF);
+    spsr &= PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT;
+    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT);
     pstate_write(env, spsr);
     if (!arm_singlestep_active(env)) {
         env->pstate &= ~PSTATE_SS;
-- 
2.34.1


