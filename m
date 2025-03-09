Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E736DC28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKr3-0000JL-VS; Sun, 09 Mar 2025 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqt-0008RI-Jd
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqr-000508-T1
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2907020f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542852; x=1742147652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ROoqZyq+JYACAQOwfrSif1wT020r29BY9+8qi9Qxys=;
 b=XYQ8nfhOq1F/jzwMEgi6cIXo1LjKlD256tSyRhHZH72DGFG3/2gAV8RAnw/kj/QWek
 eC8qo9pICbM389I/fPPpxNZhclcvJokQ3dl4eNEF41jx90uErUaA+sSWK8F/Wa9t1uj/
 WjzmyKif4nkgH1X/1JGPA2b7FYguVXA6qTjdAbK+w/6AgLkgv88gHyKeqah1NNyFtK9K
 0WfffFsMYaVCV4C3kHCtoL/DfO8jQyzt1kZmGb7OcI+FjKyvDmbaxd5oWowUQl0hCuLL
 C0p9QdYNDYbPyy2neGZUfY/8x22vW0JeMUg7Ovg2yZOJs7RQ+aKPZkG3obTQCfRpfmiC
 ci9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542852; x=1742147652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ROoqZyq+JYACAQOwfrSif1wT020r29BY9+8qi9Qxys=;
 b=dqt8+QmSEbbbGRn+8U5LViJzN019Np7QzSey1uyXNLky+hGmpU2iBNXoyl+XsO+00M
 69OH3Ab5XwsLKnz87beLk44pIqWNfM9UFn34ROzx6E8pG6rzxaHH4cXWub/sd8kcPDMT
 HPjuiKzVCSCONAGA3aeElJLA5v02IUvdqIJzJMt6ggIkqIsXyQQxbQkEEuKSBwJGzg6C
 dy2YZ+KOkEw8EXf5qjSXMtGD0oWpzsGFlkUBt3cLxMQcWaKQppflC9lCLXj5l0aVx65U
 Aybc8kS3rOR44Zh87JU4AM/iZgc/n1LPf+TkX69jbinc8ELxPiJFLQ4y8onBRzJQ+YAG
 PCWA==
X-Gm-Message-State: AOJu0YwH3LppezVG3LHNwMkPoUd7PAhUDbO/xZFpIk4viLoRFSP8tinZ
 SLAkT/rBq7MUTDYq+ydEud6UmoghX+PCYs5Hk+3Kopwj9V4gfoQxfD68Ea+luzvyx5UwJ2tnRWY
 +P7s=
X-Gm-Gg: ASbGncvzqjyReqtUoqsmFpl3hcR8Z5D+PdIjc991skhnMpGQKz2so+HtVltJPJcTf5X
 HVAIJi68gBe7YOGPpvoo/mWeIDNRfrwB+xKgE32K3Npl1HJyQeHuu4rXqjWPpJoJvslx4cA+ojj
 Lrgb8VkM/UOVRgWYa+xYUfPiEHUyPJbMxihIN9nFNXKek/rnOvoVwGiE4KS7eP5vncfG/EYqhPA
 m5eq1twXDCCgYc2d6UGiRBYn6vozVvZZwgf8vV6Fmi9R8Zn8CPdsxP/panU4oiUS7BMOGh3Q6AG
 byDPzuNYQ8Q07WND+xcZMUuMZTzfk14rTb0DlZXzlMWvF5A/RVw0GaN6eUvu1k0ztiYbGT+wRcq
 Tq8g8jGAwhsdK2X4rK5U=
X-Google-Smtp-Source: AGHT+IGsq15d/WrgN/FzkgoL/Cmsg3TYiS//QTc2+OKBuUUiFb2QBSDnaAGrO1hmyAwIAUm/L4F4qQ==
X-Received: by 2002:a5d:6d8c:0:b0:391:2a9a:47a3 with SMTP id
 ffacd0b85a97d-39132b5b802mr6855978f8f.0.1741542851926; 
 Sun, 09 Mar 2025 10:54:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01ebddsm12728542f8f.60.2025.03.09.10.54.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] target/mips: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:55 +0100
Message-ID: <20250309175207.43828-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Move has_work() from CPUClass to SysemuCPUOps and
cpu_mips_hw_interrupts_enabled() to system.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-14-philmd@linaro.org>
---
 target/mips/internal.h | 4 ++--
 target/mips/cpu.c      | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8a..28eb28936ba 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -162,8 +162,6 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
 
 extern const VMStateDescription vmstate_mips_cpu;
 
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
 {
     return (env->CP0_Status & (1 << CP0St_IE)) &&
@@ -206,6 +204,8 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
     return r;
 }
 
+#endif /* !CONFIG_USER_ONLY */
+
 void msa_reset(CPUMIPSState *env);
 
 /* cp0_timer.c */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e76298699ab..b207106dd79 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -132,6 +132,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
     return cpu->env.active_tc.PC;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static bool mips_cpu_has_work(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
@@ -177,6 +178,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     return has_work;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
@@ -534,6 +536,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
+    .has_work = mips_cpu_has_work,
     .get_phys_page_debug = mips_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
@@ -577,7 +580,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
     cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
-- 
2.47.1


