Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E01C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPi-0007Ee-Nz; Tue, 22 Apr 2025 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-00010F-6G
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLk-0006fD-Qk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22928d629faso54246575ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350327; x=1745955127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPrUJL2Wwt5H6m+qbEougiZhbCqsapatk+AvGECCLZ0=;
 b=xFOWXr/pAX60p4nMfpHEy/oKhjM3UbrdWyxzzpg/Qnqav87TU0iZgjp6XJyGqG6LOV
 aeqRy5mGl9l9xCBYG1fuKuZCIPkAILzgWzrxJdR3Y0ocA3vV9PCc5kwPO2CrI8dLz4Zy
 02SCaBk7QYZbNX62Xzu+PXf50aJorN1s2YyW18pZN8aOuZPQhsOYDhe74dRXGzxztNxE
 X5SFWBsd9HxSchnBobUZ4I9iHvri6uzu3XPEGtXoNv8oDmFh/G8jsIJ/sLeDX/4xiiT2
 9MPwTcEIX3+gp5B8JOKTU3r0IMBrEJZDY6/XOvSFZiPzhFydr5wrj92ZkMSq5TdlLIGh
 NSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350327; x=1745955127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPrUJL2Wwt5H6m+qbEougiZhbCqsapatk+AvGECCLZ0=;
 b=C/yfYBDlqGiWtZVPIXvbIXU72yyiTg2Stjg3wuRiwKeXrMiA27QTHLn3d2cbRaiSW+
 5bQqAPtcfpIGkkn2AGyZX+XzXYXhdv+ANq0mDcN1slA/E1+Sn7sO3IsEgApOSYZA69DK
 prN4T9wYOXpzXpx6bDUX/YNULfVBcAczeT0Jyxtbn9kHxdRnzMYuWAd/ztn8MPSTRHDU
 aZskakewvzB+puSLsCMEgADGALH0TUCdncprjxxywvZTPUMYE+4H76Fxt+HwGshb6Mk5
 sW0onlp5Z3n5B5hRqoRA+15vxHLqGMS+pXTjf/zoPa+qx/66Edl1iZRqLTqKYiYv25or
 Ngzg==
X-Gm-Message-State: AOJu0Yx6kYsloV4QTerPN0wlmEAGOFpC7+ADry24UCQjQMBygDuDyoIH
 er6JdaEzk5hMrDPkQbyDkCNdNcn2qVA0LSEGb8WponJuUf/yW5EvtaGEltld3/yPLfJOjbo8rPo
 l
X-Gm-Gg: ASbGnctHgRuQzx96yxpfMo4OxTgY31e2M2qhXsKxJ8WbbEZldT1onuwnLACzoSGvt7+
 ZuIALMfDA/9052UgivVzm36+FDUr3TTFdOOMkBaIPzRi4+RH1POTFimFQpGTAV6UJIcW6AI9bl8
 RLKwn+FMT0TKd2F6/0YbdwwSL+NkPmjy6V2DQvzi8Uk+hhT7x3C2GlddZNMg0sKmQwaut568UCE
 MKQgMwZTnV83hn8LNDklQqBYiBy6RNtmqgPpwVZNRHaSJL+OPf9xEb0tPypnhTbgRYUnSZakvL1
 GTZ/8LJOxKCYosv7pWeT1bmibmHd4ad8CyExIdwOqtpQ5NjfrmfETHUF5ju6blTrDkdaELrZoe4
 =
X-Google-Smtp-Source: AGHT+IFt/p5BWHLdwSq+AVfN0dwEW5BAWTMNnu6NWbABk9RIACRT1M2ON8stnOmPrzs9KbYqsOhdaw==
X-Received: by 2002:a17:903:287:b0:223:33cb:335f with SMTP id
 d9443c01a7336-22c5337a07fmr210733565ad.3.1745350327132; 
 Tue, 22 Apr 2025 12:32:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 071/147] target/rx: Fix copy/paste typo (riscv -> rx)
Date: Tue, 22 Apr 2025 12:27:00 -0700
Message-ID: <20250422192819.302784-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().

Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401072052.25892-1-philmd@linaro.org>
---
 target/rx/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0ba0d55ab5..a240b3b3ce 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -66,7 +66,7 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
     return 0;
 }
@@ -227,7 +227,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
+    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.43.0


