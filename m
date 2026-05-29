Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31FCCD6E4F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsbX-0001TQ-SC; Fri, 29 May 2026 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbM-0001PQ-7V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbJ-0005R2-N7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso62077735e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780043392; x=1780648192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hbeufYVzoMG/wzzAjSBDrNtpV9A32DdB20M94ZA85Y=;
 b=Ml7FFs7eoro+n6MWGRJhk8UjfOAa/iDIOr7A0ZJ9aifFJNBSUBKfnpKKuC9tC1LdPH
 mRU9QWl1VJU+846pmx9R3NbOz+ttApC8AKFSkSxpCuV27bsc0b/HlVGnkv+g/jmPHcJr
 QdGzmzXODpIDd5Prw3B1h/KkGTh6Yvtuocqhc8zqmuaXiq8ZvddO/NjBh8vKloNEe4EP
 alH6FAsGeFLJ5d5olvc54l4NLyqmr2ORkQoUVLzqJk8X0DAvkDcRQQ02iDey4MLkV0ll
 BKKPIPA1G9gU4GC6E1StVWBOqxggHdJtRrB96gJ5IqY98tPTcP6KIRRvBONtSonWkDZz
 QG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043392; x=1780648192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hbeufYVzoMG/wzzAjSBDrNtpV9A32DdB20M94ZA85Y=;
 b=bUW913sFC+SdKrtdjPN8d6X28oAIHcw5kWupnmlwgEjq1tHIvTfNRfGvNmr0AWE29J
 Pz34edGp3ftyIzbedvFXovk1OPNc71HrTODLYvt6BIdobiIsP3AHAcYJyenB+aZh22V0
 szcqpFWHHLi7h4GBP2RYHuY/w9+qj38Uy1yrE4FeQuIvpghV7OrhKwiwtX16gHcHlC5V
 vOziNGR+5uiNLCLiFc9JmAI1iZX+UXKlmlvJGI9B7YmztyZd8i6sjVoTr1erhSlUUduO
 ObJugNEkkUbHMOJB8xzX+ZZX+inH7DYxLg2u6rM+ycfZsE4P/5zJH+8OQiufWfDO1gc3
 GEEA==
X-Gm-Message-State: AOJu0Yzice4yv9BhmzWkwgluImy/ZXMyClfR4b93Jf9H+Y1sAI2um0sr
 0lQRSWQI8OpljeirFz+AR9dBIbQq/SushCiog8qzsfj/w3igVTgNOl/KLl8zAh1PLuo=
X-Gm-Gg: Acq92OEhWbkYIs9DaHBjUUySTnQH0KyZRm/PpAa2FVObjvF5tap/h+Km7m6bLP+m2fw
 Bug0uPA64A8Qpp0uNKsxDdWdKaHs69gBb99kLpBl6vlR51hgBFDFC4qflq8CGanB+sPF0+Yu69n
 pfotVlk+9vIORq4RccDaSbADQCjhlD0IluQlqwLI06jP8j5avj1el0a6RWWVJDCF8jbFk43pufT
 dYtWKFng41tD5MBuW2Kx9eoz97Exdgh+NU99LpTJlEXcbnqVU2GsTHivlrimpOv4m9VDevxD3pO
 zFAcQOpbotszQsZNKlX7PFnEsE0DD/xn/372fx1JKqca437jPCG22eOcOVHD5sQ9zC1ZhgHlmkN
 +iWXY+vbOW/IKeh+djIx4TcnWm5VIIu/vZXqYGhufSaYrIKUsAwXfYoC+WvqtyQ4IoC6CCES+JU
 oF12qg8lSlrWExtn3M4d3oh7M1lxbOt/9yjA==
X-Received: by 2002:a05:600d:864a:20b0:490:6869:7d8b with SMTP id
 5b1f17b1804b1-4909c089d9dmr24637905e9.15.1780043392032; 
 Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c6319ddsm31623155e9.0.2026.05.29.01.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 01:29:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A48060335;
 Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 4/8] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Fri, 29 May 2026 09:29:43 +0100
Message-ID: <20260529082948.363931-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world. As the WFE/WFI
have similar behaviours shuffle the case statements around a little
and update the commentary to cover both.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - shuffle case statements, unify the comments.
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 15b40090c0f..c20269b1501 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10939,25 +10939,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-        case DISAS_WFE:
-            gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
-            break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
+        /*
+         * Both WFE/WFI can cause exceptions or exit the loop to
+         * halt so we have to make sure we have rectified the PC.
+         * However they can also return directly if they don't
+         * enter a wait state so we must add an exit block so we exit
+         * the loop and check for interrupts.
+         */
+        case DISAS_WFE:
+            gen_a64_update_pc(dc, 4);
+            gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
+            break;
         case DISAS_WFI:
-            /*
-             * This is a special case because we don't want to just halt
-             * the CPU if trying to debug across a WFI.
-             */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
-            /*
-             * The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-- 
2.47.3


