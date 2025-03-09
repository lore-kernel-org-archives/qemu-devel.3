Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD9C28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqk-0007p3-Rj; Sun, 09 Mar 2025 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqV-0007Eb-SM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqU-0004xY-7Z
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5230825e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542828; x=1742147628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=md16qNAXLQuQgmlTx8E9wB4d8K0hXUoBNEnxRY6/V4w=;
 b=FYT6JGNCr3iwJJViGZXIyVi0ESfoQZVGFPExP+SsuMBANFgwyUznxbBbJVXYkb3rWT
 FBhhu6s11dW92UJ5HuuhITmTzILEwW2HAy0g/lsN9t46bStTCZimXC3+OC7Ys3/G0oXf
 5LYL2aZPzOHUkwwHb4zDj2Q9sFgoyH7uMfKR8Bqh20gIsLzMHyNEmLuM0A9w9m9yHKod
 7374bsXLfXeEFdyF+MvbbOGBPrkoOq5cRm3D7VUlZsye4TMnF8jtHm+Lh93MmgP4MCDg
 NiRyFUPmz8hBW+l4byGhQuGiZMriGMlW6V5KfpoAEHcDI7FxBDPu6M7UPVtvvxuFR9ws
 affA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542828; x=1742147628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=md16qNAXLQuQgmlTx8E9wB4d8K0hXUoBNEnxRY6/V4w=;
 b=t61D8YL1DuArDY5o7q3jZIFchkY/i8Kx2T/WiJHbrfaeiPyaxETwIndx4TbwfWELhN
 T8j3bswyYodLXdXT20cnrNG3A/rOhsmLsIlcN/jzbdlmyBRJ9sjUlDKejWdgzTHx4VTI
 /C0S1u0OUSuH1VuM+0H56Cb4a8jiO46g2hCqcvtQwddsxwsQKLGJ8mTOPaI4+fEaulRJ
 MgvalmAcg/k44nnbRjLgrx4sACFtdNPzFrHB/4P6O6aNdW14CPcq6IK1vAZuKFhx3iS+
 aeEZCF8UJWNqOZL9MEnshuxACVc3wdvJVEVL6FmfdEQv2vdpEtAMqCMYIIm51phAbHxd
 rI4Q==
X-Gm-Message-State: AOJu0YzgWJ/bMc7dHBE651goUbQo0p6Ax+4By/CEGL+EXz+E7Y8tHchY
 TLg6qIzUHb8+cIP15SP0cKITazEgel13h/aG+uisfDtf+YsD21ZsDa9WodihE56LBuKYHp6iX/8
 +Lj8=
X-Gm-Gg: ASbGncttdITR6/kuifivu8KApEOBeicgvX65ZdudsW7My8qi0kp9eNp5Hkx7mdRV/U8
 c1tBZDyh3QuBc8R1V2TnRlVRpwx8XjqChDgUxQcHklLtguA20cXsY83sMC6HePSTQu24J0/xQA2
 +FfMUyMgISBa4lrIIK6Poe2wvYUNqEl/nOdBWV1bcoZRPCrZD5rpBdzwpO2HRluMWmap6X7KVfV
 FUV+gUAGWiHzuFKiHV+5Ma2HSiIdEBZNHr2b3CQ/9STVthTf2tXremo3xPFMdwEAHu87EDkqKA5
 2EfAHc4iUrANeY4AU4OHnPE2SvqEQjE3LjAFnbp39JeW9Ac72PaktHJb3nYzzpC6G70kYjp6P5O
 tk48GSNvPqMzG6TXjeFI=
X-Google-Smtp-Source: AGHT+IHgybnX3CVsedotVCSsceZ1WxKQM9Bh8wwAE9vWJlOPA6061/tH6dWEn/hNp6ac4Cclw1xWqw==
X-Received: by 2002:a05:600c:3c8c:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-43cd169b363mr67510585e9.11.1741542828379; 
 Sun, 09 Mar 2025 10:53:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba8b6sm12688775f8f.11.2025.03.09.10.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/38] target/hppa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:50 +0100
Message-ID: <20250309175207.43828-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-9-philmd@linaro.org>
---
 target/hppa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index d15f8c9c217..2a85495d02f 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -131,10 +131,12 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     env->psw_n = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -242,6 +244,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
+    .has_work = hppa_cpu_has_work,
     .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
 };
 #endif
@@ -278,7 +281,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
-- 
2.47.1


