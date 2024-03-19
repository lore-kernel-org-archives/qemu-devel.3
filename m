Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66625CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbf8-0003fL-K5; Tue, 19 Mar 2024 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbeo-0001wb-2r
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbel-0005ts-J6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:45:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4146703fd2dso4786575e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863136; x=1711467936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KePNgRmbU+28xR9UGCx3m+xL9JDUZJvD83MlZjBrjtE=;
 b=PrWe3goKr8GYfnaMoJ7LIs6DCUpeuT0k81FxkSXqMLUR8MzdMj+v1wkN+pWMm7kKkM
 wsckU+w+ehnecroXFmw7KzgzHNzEKh+QNPjYcc/8aONBFp+Tbx8J2IHVys814YfwReQv
 Qw3sBYbWMrvAWOoPnxdISp3SUCZvFWlRVJ3nIRlBC1/4SiZ4JGKAjRtnPcNiJ+esDwLj
 HiIqxbGJW/YLx6sA4sCN5jrFfMYKgpeFK5bHZfHh00f/U2/GfuGiLVFYlLGfkaBojIED
 lQxsdlko3tjajMo6db3Jzb8DxfaNa+T1p5kofw6NEzhYWUqYGKjgPKnhbg7a1B3rFbeo
 y+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863136; x=1711467936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KePNgRmbU+28xR9UGCx3m+xL9JDUZJvD83MlZjBrjtE=;
 b=PPLwV81XXGu9JyUq/f13/caxIiCSVpUl+a4S8NNwWAgXO6427eumxRg158G9vq7JLt
 9TSNzydtU3seBu5y1MeIogjEhwiu9qwYfKJrA12ZVdGeUYzzdGl3T+EN/LIbgi57zRn1
 wsGfLm/GMCFDVLjVMlTG5bSnrBFSJAQfFupfibMqvcFT7zmzPLsQg2Hi6GOGtZn02RCQ
 DnRkI4XZ6aNcmFe8lZzNL68V0AkWaR1M+vkBrzvtfXweJ/Qgr8D7Rr9Pg5k2099QUDWf
 lR4a5Uc9B4OOmLAjXcESMcWos3XwGl/ELzwa9kb81QBYW5IkN+AFVDgIKhyfFX35rFkd
 nwxA==
X-Gm-Message-State: AOJu0YzgjhAvVCQ48EEYEpJECmua/E21W/y+J+JQyhlsNbBrbqJ8jEDo
 iMYzdb38t82eLCWDyLW/WDWazzdByAOC16Efzl2klYORFD3jgN5+oRoum4pqrFl5V92m/dpnfdb
 3
X-Google-Smtp-Source: AGHT+IEE4yAInbM7a5W3co3gyripCxkhU6CS1CSdcy5xzdaio7+Ja0646bI9EzwANQCxpaRYANfjeA==
X-Received: by 2002:a1c:4b17:0:b0:414:3c57:fae5 with SMTP id
 y23-20020a1c4b17000000b004143c57fae5mr2383201wma.38.1710863135815; 
 Tue, 19 Mar 2024 08:45:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c501400b00414112a6159sm6723678wmr.44.2024.03.19.08.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:45:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-9.1 27/27] accel/tcg: Remove check on
 TARGET_HAS_CPU_GET_TB_CPU_STATE
Date: Tue, 19 Mar 2024 16:42:56 +0100
Message-ID: <20240319154258.71206-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

All targets have been converted to TCGCPUOps::get_cpu_state(),
there is no more use of TARGET_HAS_CPU_GET_TB_CPU_STATE in the
tree. Remove the check on TARGET_HAS_CPU_GET_TB_CPU_STATE, but
add an assertion in tcg_exec_realizefn() so new target won't
miss to implement this handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c      | 1 +
 accel/tcg/translate-all.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 987e6164f7..6167bd3159 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1072,6 +1072,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
         assert(tcg_ops->restore_state_to_opc);
+        assert(tcg_ops->get_cpu_state);
         tcg_ops->initialize();
         tcg_target_initialized = true;
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7b538d2b9c..3c9fafba69 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -221,7 +221,6 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
 }
 
-#ifndef TARGET_HAS_CPU_GET_TB_CPU_STATE
 void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags)
 {
@@ -229,7 +228,6 @@ void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
 
     cpu->cc->tcg_ops->get_cpu_state(env, pc, cs_base, flags);
 }
-#endif
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
 {
-- 
2.41.0


