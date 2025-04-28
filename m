Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B896C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoJ-00058v-Fd; Mon, 28 Apr 2025 16:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoF-00057j-Uc
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoD-0000bp-7V
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7052598b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871031; x=1746475831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+okpcsP7PofS8VGlGl/0oZrZuuqV6z9iH9yWhQVjc+I=;
 b=e4kQ8zHgbQCKlOgkpzSXikMFaAgY5ANYFCuAw9FzfyLygERxRs/ZXy9geXIGhdqy/r
 iSlESQt1szM3+sKVy+3CnvGR1T6M0XIW7kS9EZO3+VtlguSt3qY96DtSR7TabPLyYOa2
 BxWKcd94NEMQ3yW+EwepEunkIhvd0/SXUyMyNtoAg+hhI9W9riaLsy0FQ8PfwRoRAl4G
 6zeHyMbR6bvca65Z4gp32SuxtjXEYcjzmNV1cTGof0igkg9mcPJgqzmy+ODnU1tAerVV
 GbKnR4R5gCGCg+mGtvRhq1nK0n/X0iKDq3ptddjdMoZZt8eYkuuts35/0g5eD2A+TpFv
 eQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871031; x=1746475831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+okpcsP7PofS8VGlGl/0oZrZuuqV6z9iH9yWhQVjc+I=;
 b=WwopLKrMNuRqEf7gU4whE5KiSvi+8HBS9ThBhlHqQusH7voLkSG5S8P+RQFLeWQvil
 xyhttgFZDJ4iVBbnpTP4xvJP+W3kXnJiT7UHRzFbR8UtT1vXobjN178NxnFvAST00NAG
 MzXMbGFRmn9WkyRS4rgEpjUhowp5Cc9XGWjKtHne1oQHQbs2Qy7gVF/pIioMzpUPsHqi
 jBWq2c5hYOPU6IKVbWc8DJyQtnGojW+YlMfrjl3/cgLcgcXmBZKiS5AGqUFCz791QCdT
 ToGhNAUJNTjLhZwYhelpMEfNnW0G8OofAaNgb2aLkeqPwq/U1D7DHAv0SULFF9qHzdEd
 RuFA==
X-Gm-Message-State: AOJu0YzjszhuFF5FOTWCNn8/AhxQ1K/HMtv8HefaJ2T8Ha6btRhaF/Hk
 TZAzZov+pMROYsTu9JB3T7cov6o/O8N6rraEmHIwc9ixqBiXPv11UtYNTVDBTPUvO5Z6puIN+6N
 w
X-Gm-Gg: ASbGncu8jkvkEH+kZZWXPUpHCxvFympCK9b40l1HbgffBC8iZHrMykQblEOJ8ceknXt
 c5RdXCmFK541FNHu68FVKd+tCSXA2WnLwbc8Wj5UMgwBIFOoyvqZ+32Rr54jCOoythJ3JdN2hGG
 RAQ8ZJrnaLiVa4AapirK8rKWm7QPKKPukh8Ol3ajviFBkqqobHXMHQB+QiYTQkhJax9+iImAPxq
 ZEV9MY/EvAoGO7BOjOsWP+oP+7S5B1oJ2efhsSkkNRG6Uh7ccanp4Fn0PyG+YG6MzlI9HDMiEO1
 rE+NsX7WyRETBr7imcST1JpLa6y0g97ECkZsMFXjzAUBaOtF83EMxFrnj5Al4iLU3GvwJhFDqPV
 kKXjsbm1WwA==
X-Google-Smtp-Source: AGHT+IHtSy1ue2ckAU4b2UfUXMPvmhZtqmdIRhHY4UIVZkMGQe9ANWmxeGTrloH0RH8h3XCdck2K6w==
X-Received: by 2002:a05:6a20:e608:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-2093e528f9bmr1407691637.40.1745871031343; 
 Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 02/10] accel/tcg: Unconditionally use CPU_DUMP_CCOP in
 log_cpu_exec
Date: Mon, 28 Apr 2025 13:10:20 -0700
Message-ID: <20250428201028.1699157-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

This flag is only tested by target/i386, so including this
makes no functional change.  This is similar to other places
like cpu-target.c which use CPU_DUMP_CCOP unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
We could just as easily remove CPU_DUMP_CCOP entirely, and let
target/i386 dump CCOP along with general regs like other targets.
---
 accel/tcg/cpu-exec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8ff4a34509..ff979a2c57 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -285,14 +285,11 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
         if (qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
             FILE *logfile = qemu_log_trylock();
             if (logfile) {
-                int flags = 0;
+                int flags = CPU_DUMP_CCOP;
 
                 if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
                     flags |= CPU_DUMP_FPU;
                 }
-#if defined(TARGET_I386)
-                flags |= CPU_DUMP_CCOP;
-#endif
                 if (qemu_loglevel_mask(CPU_LOG_TB_VPU)) {
                     flags |= CPU_DUMP_VPU;
                 }
-- 
2.43.0


