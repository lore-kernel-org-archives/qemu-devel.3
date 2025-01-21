Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E52C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBA-0000l5-EH; Tue, 21 Jan 2025 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFB8-0000hw-Li
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFB6-00038e-CC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so41432845e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469466; x=1738074266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiIs8YYj06822iMH2Rgg/pc1ZfogTC4R+p3YX6Af3lQ=;
 b=jTB3p5lDYf3+8kBtX5RyuD6LvUrcnogsIHONfQbMgRKJCV8vIcj2LxieF5U58M5dkQ
 fKLJ4CAztL5Tff2TetyutnsemG4C1vj4ovtpzoOJSbuV4rtpGWQsL6f9itG0ZVH12Veu
 ek5na5sfAyFudb+CyDRSK3imkSKN590idOVsiQOJ/79nNr1XtzmRZCR/DXgXphxc3o5M
 pkizCO9xoirdwf9eIvi1HY5bsLqhslx7BnKiFwUd7DOXdIn3X51WcjTtFiFQwMYnz1EX
 fK9bo/BeY3kRn955PM/EHYcUrM1eELUyBt5ICG7pDsNHI019zCme//J7n0mUlHq2Kr/W
 vJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469466; x=1738074266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiIs8YYj06822iMH2Rgg/pc1ZfogTC4R+p3YX6Af3lQ=;
 b=GkY82AMXbUh1hC5RI+kOVS+HuymKaHCfzDGegRPnm8wFr/ClONe/Nyj/i8OkZHmsGt
 J653mLj+x7xqPQ1X/Mkq6nL2L85BXUzj0kchtLBBG8mG+51x2tSstzslHsFQkCdYYnWW
 JaIw9T59wSygH9bubCJgaPuOggcrICBk0PZLTBMFU30W+Ye1t+gHPYusFjFnSQV5HoGt
 AMWb/54nwAy/the5ikZ7GWzpAtqHAVpsQfSrZEH+MV+V2WRziF2B0HCL7UwJmjE72K2I
 Sr4tbqXyp3b1mINU3GVheb5bfpzYVRBq6czRzrbebn1TO+m+4Q+0Gp7vkxnwKmXeZpZQ
 vOXA==
X-Gm-Message-State: AOJu0YzPI9tqLx9xWIxwHgINWkxxVpeNOOnnaigxvB51rESnf5mQ6PvO
 msIY2XGIIu4z/ACbjee6ahEt0hjXcPQ0OdRhYXv95morhbp5eLCmLnL6c/J71f9Bf01EFpmhF8J
 fy7Y=
X-Gm-Gg: ASbGncvqpaIq7zcLrgaTnTLzxyPi/7WKvFAOvb4Uam0QeLVFHmVl+nuep/1hTxP5LRi
 QwI9zJBtC41aw5fazEMJW5H4Lh0uPZb/LMR3u9loALGu2gGiV23h+TJDgmHKV1aBC2H+SM423pQ
 Dag6kIua+2FkQZstPzK+ZFKN+tfLX3YjNrR45dmdX97k0xFSD90s41bPZynk8OT5qpdiZbdbi43
 xLJu2WPYhjt5RejAZ+LlLvfI2jSS6w35mJtY1/atn0+OV1VjwINx7g87CZDe7Tvd0nya2oyHiYl
 AxDU3ly4xYrENv+Q0vLNMS5iu63Hp8R+TqSVkY+4PYU3
X-Google-Smtp-Source: AGHT+IEqU4c1vPc61VRhbpZWCkP23zax6N4SJjoafycJSvu6Z6n9Ti+CKt0NEksxbyrgsNYG7j/HIw==
X-Received: by 2002:a5d:64ee:0:b0:385:f1f2:13ee with SMTP id
 ffacd0b85a97d-38bf57b9426mr14843696f8f.46.1737469466639; 
 Tue, 21 Jan 2025 06:24:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327574asm13594085f8f.68.2025.01.21.06.24.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/28] target/arm: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:22 +0100
Message-ID: <20250121142341.17001-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 048b825a006..322c95038d5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -123,6 +123,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 /*
  * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
  * IRQ without Superpriority. Moreover, if the GIC is configured so that
@@ -141,6 +142,7 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -2671,6 +2673,7 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
+    .has_work = arm_cpu_has_work,
     .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
@@ -2721,7 +2724,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->has_work = arm_cpu_has_work;
     cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-- 
2.47.1


