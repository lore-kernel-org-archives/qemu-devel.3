Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1D6C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdq-0001lV-FM; Fri, 17 Jan 2025 08:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-00011Q-Fv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0002Fk-MS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:13 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso399602966b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121389; x=1737726189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0X1Y4uYNu2Kk1P4je8Zch9rD7a4QSWs3eQqhNJ9Els=;
 b=WSXGy6rKTuQg8jBOZr8u4xFDqX/sr8RI77MdPZAS1jJ+FH0i6SVeWRXAj04fn6CO9o
 QHCI7JXskUKqmjwQVNfbKIHCAr5KPOZfbtAClIRXaUOJKs7cAOe15lPGgeQ/yfJF0aGy
 sghKEXHk/i20y2T8kaqiOh7VGC2NRDxAsiui+sZNflLfRZykVny4QRPkydSAgE1FGjXI
 rpVKjN31MZe58hg7sUt6WnESMcG+CUVEfYnIDP38UuDauvFONZkuufN9FZIGZJM0ES4h
 LJQzrJ71beoHDze1aBB4jySEHO2DYnbF4FG/5+UsfwIwZjNhkwNNp87yWu/JzTCInFhD
 oBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121389; x=1737726189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0X1Y4uYNu2Kk1P4je8Zch9rD7a4QSWs3eQqhNJ9Els=;
 b=IfflOKRSqEncFolydzx54hPG176sik/SX2mCLNV2WEyzpisA7sSwIOynnUYnVnQxzM
 b1yLJucMLICZr06Tmxrfd45P3PJd39m2j4tK7tD+/ar3ScY5Ft5J1mQgxo8W2NcrB0Aa
 yAGu7euSLJ2AndPVwep41UiXgA9pDpbghbBkAVSVoHkeW3tCxjHQUZyG3msxlK05Dv2N
 SsK4lpdZdW3u0WKZ/j1lgUJwy3fJmRTda6oc7aUNzwcz6DeRO5WqGiLIOWQApcgyphgm
 DYFFmTG6k3A5vPhT/9akt+UFi32bNMSrXIkIEWp00fICo0ECp4RaLWfp9kRobMZrjiwC
 LTAA==
X-Gm-Message-State: AOJu0YyC+udU8hliViC0EM6oNv0JLxqIeEJlDUvChr+uq4YKEnCqSQjx
 x1HT0mV+Esrv9a8S5OsYSRhel70tvoYK94Y/aWm8wAFX+ojllZPxb/TV/GACfoI=
X-Gm-Gg: ASbGncsBFKlJk9Z6JqSCvTTyyCPzvsDkHmHrrcjGAI8YMMDJ7YZwDV9bdJMR+ZQRaAF
 xuRd8kQcpeCZ+2o0C7Oc733BrqrC4DtaOUmCeAw8m0H/+CzSzanRg7Z6Sd7n7gzsnsA536fsMp0
 i/11wQeZ5soCdcoFXGcC5hQaOS5BGsJQKfas+fLGIgYe0IRbnMRgcDK9ZBVcXPdeg0h5J/JsYJa
 Ku5Q5vcQy7SFolF9l/aXeMeOEsxAPo7IF7+ONnK2B7kN+3tECYgoJk=
X-Google-Smtp-Source: AGHT+IG8sy+wJlhBjrnXX1CZ6NQTsDMJtl2oBKNY49ZZJlbGCk0pFKvlNmvGvueZQYCYOiD4WUkToA==
X-Received: by 2002:a17:907:86a3:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-ab38b4c8520mr323435866b.54.1737121389093; 
 Fri, 17 Jan 2025 05:43:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c75283sm173209666b.8.2025.01.17.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F114660858;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/37] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
Date: Fri, 17 Jan 2025 13:42:41 +0000
Message-Id: <20250117134256.2079356-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

While it would be technically correct to allow an IRQ to happen (as
the offending instruction never really completed) it messes up
instrumentation. We already take care to only use memory
instrumentation on the block, we should also suppress IRQs.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-23-alex.bennee@linaro.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec9..d56ca13cdd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -633,9 +633,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * Exit the loop and potentially generate a new TB executing the
      * just the I/O insns. We also limit instrumentation to memory
      * operations only (which execute after completion) so we don't
-     * double instrument the instruction.
+     * double instrument the instruction. Also don't let an IRQ sneak
+     * in before we execute it.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
+    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = cpu->cc->get_pc(cpu);
-- 
2.39.5


