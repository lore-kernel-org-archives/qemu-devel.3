Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F64C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDR-0002eU-45; Mon, 12 Jan 2026 05:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDP-0002Vb-Le
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDN-0001oP-1h
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:32:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so45245765e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213919; x=1768818719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AX8TReywRramP00AS3aCoMrxM5/FCzCrdGkFzNm/dQI=;
 b=U+KAHOkGVuUAaCyHZT1RDGwqkYWJv5BaLsk11iJoSmyFiS73rYZTUZdYJ3dN8vyuNA
 alUzkCVDVZA16QhhPbLXLn4RSRoszt8YP2jvoMmuA+KAxSOZ4CshaiyEWfDZJhtI0nVI
 HerzwacjmW/Y2x4C3Wu2j7S1W3Cb0BYi4AlFXKSdthMIOvHo31Qx4GFq8W8pIPkk5KTL
 sGiKFVThQ4jkW7RnZ2uAo8Ze7dpnEjdz+0Hh8OjxhKrPh6KC/cTkcXPOXnXUwGBXjAYB
 KrExqLG9ppThXUUFRjs9eQESk1G4d7XjHZ/SK2PCDcg8faqdIH9XndLf1uTUz4ttU0a6
 y9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213919; x=1768818719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AX8TReywRramP00AS3aCoMrxM5/FCzCrdGkFzNm/dQI=;
 b=uzKof764e318u6L+kh/BycKDKD8Ng1QZMqplHKxrwmTKM8CY3gbyKOb0TxyR+gJr9e
 cTqkaMQbP7Hk3ZQdIETCEGfaF5ZcsXHQVKBoZg3SgP2Naa6Tts3htdCgBcfVKr7cUxtN
 Q8d94boj9CeLV39j6efqglyeM6qfaRwvzN6R0d/abVqicgeweQAYX+S4bLS0gc0LCTgh
 0Sx6hlSQXR9pf4RbLtc6JFCIZMLvo4q4m39oLqWYWFJm8mtm5t0prcXtibJpG4o1lpP3
 Dp0prSj90gvBOgEjKqC6malQ11ZpxLpFCm7axEQ3Yna7TKjGhmqCalcBs8KZote8PP8B
 g71A==
X-Gm-Message-State: AOJu0YzmKpSnaN7S9KM0kc4gBetQl/7AX0THtl+tWvYELv9TI7fGdeCs
 m+oXSAEMhSRZ/KYGR2/tqMvD0yN7PXC4aKmehHRHqO2Dh+S8CQVYTF3GnYNZ46S3BhQAtw15rbQ
 o0xhUCfo=
X-Gm-Gg: AY/fxX7lMUAF60N/MhQkc1zJFh4HSfC9f/igZHz5oODlFwN6cHxjE+Y07zhyUONOVT0
 dTK0gGCrVDVj2Bq67KR52zfopLbSDZ8KKZU2x2z+1aQtEPcVmObyi6LlQvpgYxyw347Jr7jTRP9
 PvpvM3bD/k8e0ld0zsc8TvvomFNYJfgHVPd1+65+TY92xarIveQ+C0d6eQjZol/nstgilsBJbIs
 cLGIyVfnPJ3LgCSJNMuqoXGYgXUwmNqwqvovduy7FwyFCQMkwB2ra/6tyd/zq85ZOnJJXTRDfK/
 sTUFHr5pevY9zvtGFZuAxUJOPROur7w4vmF/bPq3pN6V34LkF8RyKRWS773LE8UnyWjIJ6iW/ub
 tdGyoSZgHtHR27C/7SqNAkPCLySCXEr8uarOycVtPMuG2IeZ8bbHplCLOyGujBy9pSlRT8kkQxQ
 yjuiYOHVmN04qCTuSckAjYxVHbH823C3G5gfccNCfoU+xdXkt6KO8A5NmADpQW
X-Google-Smtp-Source: AGHT+IGB6Tl1ert2opqbGb3etVZFe2N9kHf1efTNdwwXBVqb7F1j0mAu1FrFM18r/Olgb+y1yiSm/g==
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d84b3b719mr219757495e9.31.1768213919309; 
 Mon, 12 Jan 2026 02:31:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm360270915e9.14.2026.01.12.02.31.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 12/19] accel/hvf: Skip WFI if CPU has work to do
Date: Mon, 12 Jan 2026 11:30:26 +0100
Message-ID: <20260112103034.65310-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Avoid sleeping vCPU thread for any pending work, not just IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/hvf/hvf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index af28b8e8825..d74703a3d55 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1737,8 +1737,11 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
-    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
-        /* Interrupt pending, no need to wait */
+    if (cpu_has_work(cpu)) {
+        /*
+         * Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
         return;
     }
 
-- 
2.52.0


