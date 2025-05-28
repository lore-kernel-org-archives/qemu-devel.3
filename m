Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75382C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBz4-0003fI-1y; Wed, 28 May 2025 04:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwO-0008NE-Da
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0005JZ-SH
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so36111075e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420086; x=1749024886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pm3xkFnc20tBc5Z04QdFQevYRIKWsOD/PoRYyufonDM=;
 b=GXz4O7yW/Ef5XL0Nl2Tgp9rzyZdEkAYlr1fRWvAEhuu2jd4fXBkqDLG+nTFc10zFrP
 XHC2K993rDWovf44cZzoydZYSI9T3BTN2107aUI7p9rbg4mvLTis31mFLi4oSrzs5qWx
 PHm8HPpsJiLzUkDb4vcb5KRsKuXpIItcu62ge/10GVtLMsIu8fuDTPPQQ8KtyZP7p0QH
 3LYmKtRQITziqsK/nsE+toeaJA+cBNN3KrsOeSS4naBJvTIc2UK5GmJn+k1wqjdE+yuv
 30b5ygKi9VTsGD3CT7U4Cw10HcYwQ2ne8Z5yBu2oE9UJVWNTEVbS/GrbsF+AodmXL+BO
 mmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420086; x=1749024886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pm3xkFnc20tBc5Z04QdFQevYRIKWsOD/PoRYyufonDM=;
 b=w5+zpN4+Pv+FIKkEVCHnCtcyD72E7tnB/FqWeTHOOwhV6hlGSgpqnpI9ImBJDV6APZ
 FOZfJfau3jMtY6CUvySiL10r6pypdW7Mioz8vKNJ3xiVlUZCXwXpRc0uEl5/jKxYQ/b/
 o5mPJqg6NvZPJUjw4tc2/QW6jBkEnqbm6zW7g0ygN7VzStC1ZfwAWLfPvwaY1kTFZAj6
 MMRIZOTy9SlsE0SsX6C4zPRK+qcP/xTi+FvNB1zjvKJnpFEIAueh5Ahcjj7o9Ea+dNVF
 9b9gG7i9IC4AhOsykGwq6/gBNqEjU4M52E8xLBe8n1uykHtuXKoiXGSkOmGand7r+giN
 /0LA==
X-Gm-Message-State: AOJu0YzfoSpjW3wKGGtaYXy2n4owma2R5uynnjIHSDmBa+/j2C9oma1P
 skesrsQpUm7x5Ceq8wEpzjwQUkIOfpRQvMvCA1jSHL0JV4FU+v9veCpfFicp3YFLwGT+E6ZcExz
 8MFIziIxKHQ==
X-Gm-Gg: ASbGncsGoPHWDQNcEjyBkjq7stFRW6tJYQFNGdr8tiBmHvEHyk+2KnvAP8uUbw47Gcd
 2d3xUuU4/gI9wib8kuVOmUmRPtg8ksg6RZIGWFBIlR/ZrYyTDTyoGFf3GPSqHnqFsaV2z6nud6Z
 aUAFcZ9XeXG8FQN43HHTlFzMqU37Jr7jbmQh5xiLoLAs88HqFUl+eKcnHc+QPoJh1k3mngq3gfr
 HmV2fZuI3Goj5DhiHYMk8/4djfi1v+b8XBBZC2vakUjd6gxbLtF6dss2kVKJmiU3NEUrDzsPI7M
 7m4EdeOSxF4yTbGESvEeziBVzFCq7T+vFaTWjaDKEuJvvnW+nmmQXLyC
X-Google-Smtp-Source: AGHT+IEAAFqawdCoE9HEArCTZFnKusbG3Q/qevc2fcc2v1t3iSTNjp0HqIiDIrLkIpaXZ9RcdpY2lQ==
X-Received: by 2002:a7b:cc83:0:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-450cabd03b5mr5563345e9.3.1748420085710; 
 Wed, 28 May 2025 01:14:45 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/28] target/ppc: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:06 +0100
Message-ID: <20250528081410.157251-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check 32 vs 64-bit state.

Cc: qemu-ppc@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9642812a71..a0e77f2673 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7386,6 +7386,12 @@ static void ppc_cpu_exec_exit(CPUState *cs)
         cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
     }
 }
+
+static vaddr ppc_pointer_wrap(CPUState *cs, int mmu_idx,
+                              vaddr result, vaddr base)
+{
+    return (cpu_env(cs)->hflags >> HFLAGS_64) & 1 ? result : (uint32_t)result;
+}
 #endif /* CONFIG_TCG */
 
 #endif /* !CONFIG_USER_ONLY */
@@ -7490,6 +7496,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
   .tlb_fill = ppc_cpu_tlb_fill,
+  .pointer_wrap = ppc_pointer_wrap,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
-- 
2.43.0


