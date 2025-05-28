Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF53C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBz8-00043a-GU; Wed, 28 May 2025 04:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwS-0008Qa-0N
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwE-0005IM-Ke
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-442d146a1aaso48842305e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420083; x=1749024883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm/j60D6ziFgBnhIXDXZVa7Si2QjgX9S2ztuPc0u2vE=;
 b=FtHXS52YnzCstCfQxMgdM1fmBqAIhJSn2bOWSpKi8GE/Ur33ZOknpWxtlwj60HdvwV
 +poL2YoqgRs+0t3+M+aiOBnJqUwcxVMfMCnk1D98Fr+p5M0AxH7BxTOa3UnhYXniNMgj
 KqpfL4PLzpoQ06aNZTTwIWOxz4B1w/pb0n1x2DUJYdDk5Ax/yKQgG8oHyHbxDh+uYON0
 wTVYqrPsmiAlnRfl18K5xstsw61l9t4DRkuvQ/FwEZs4YAcCfOQ+O1mStzsOdZLVPYpz
 2SEzw/fAPn+iV9xpz3RPyR3RrojEdH3AzLlAzTzRctFIAjol4nQ9q+miKI6CWrvIvmBc
 cBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420083; x=1749024883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nm/j60D6ziFgBnhIXDXZVa7Si2QjgX9S2ztuPc0u2vE=;
 b=viTSVSbvukrZqniSqOiTA45gYzQq++uG7Ex9xP5wfnVHpunKAjhHllj8sLX1NmAzgf
 nPuzb3J9XZLqj1KnB1mZyLtcK4UoBQDAyyCS6793fkGi96xELFKFkVBATzsXrR41Oq3A
 DyI8yWtwepssIrkFjpl71E9pXDu41DBZh9j4gWQzfUuPgcJdOq2PUd8IlsjvfLlwhIrb
 EKtu8TdXcOHGnoG1Yec4mB0Atc4C6KOGSLoIkFCCdKjDWPMmKwIfH2mo3MbvHhe01RT3
 /fn04xAiMaLXJZQ6ccT1eOmqBkzzK5Kigtn1nWGooVDPn1UHOVxSMRzEkLU96/zq79eK
 AAgw==
X-Gm-Message-State: AOJu0YxP2sa7D+dl86hEGRGOwTO+osfSOhXHlLDiAOM7tVPdX3vseTBP
 VzmAMbpi+O9HRrWf2OiV1WYmcf1f77r5IVHElHi+ndEpEdCDiHq/g9+MjLSzUwi5CzNXvUqwnrg
 1/7PB0rUlyw==
X-Gm-Gg: ASbGncujP294fRxHYbuniTGEVosx5Wa9GlR8BwZI1j+YvfuGP1flGtrDp5/ic2quXzl
 s1YVP6Q2yiV5uuK6RARMywHRlBOwOyNvQGJiAHDlvU2QlnVC4C3stRdLsYE4BBOVAG5PB/ba6uF
 ICA4V5hRHYBLlEK0be7Lg/BKjzbX+Ga274uRkQeTgNmmx6ty2TJjDAlepIYjY/G4yUP7S8OLcrN
 qU8OTf1027+uFNGl0w1oDCQPrPlMyYNSvRYAtqSazkow4KbT96dG+a3633mL2dFIRnsAih4bKJT
 ci5zE89mVv1GeSfk+CiYRK88GGvLzwKqkDMdDVClKOLWJ1rofzexGKPQ
X-Google-Smtp-Source: AGHT+IFAkl/abVcmKTlqkgaAISu+po8UQWREYerEiNHXUPTr/9VwF7mkqpuWMh7st05gkUR9oQfijQ==
X-Received: by 2002:a05:600c:820a:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-44c959b79fdmr146138375e9.27.1748420082678; 
 Wed, 28 May 2025 01:14:42 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/28] target/loongarch: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:04 +0100
Message-ID: <20250528081410.157251-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Check va32 state.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f7535d1be7..abad84c054 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -334,6 +334,12 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
+                                    vaddr result, vaddr base)
+{
+    return is_va32(cpu_env(cs)) ? (uint32_t)result : result;
+}
 #endif
 
 static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
@@ -889,6 +895,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
+    .pointer_wrap = loongarch_pointer_wrap,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


