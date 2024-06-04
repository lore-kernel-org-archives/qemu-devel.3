Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B54C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQu8-0005MG-OS; Tue, 04 Jun 2024 05:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQu7-0005Kh-4w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQu5-00022m-HN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42148c0cb1aso7985225e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494988; x=1718099788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrlTj9cDcahH+eORLITQpITIeYXXxYxxz/PmNCcuvu0=;
 b=wYmf98EERJwEuRcOhDZNCyTq8jvFQMPkD5oQoJI0POrmp8anBRy6I9RzEneDZs3bmk
 kFpOWnZp9gEKxMN7Aw3kr2dFaJdE5HU+QS7MVwrIBeWQZUhbbNoAHIdqpv3rv2RQ6rRV
 52bip7zC0WGHXGpOJQ5KAYJ8qavFnQr9P+aPwSD9s5xPxP96F+SbsEI98J6cRprx0itZ
 eFbvVMD6AGARdf4Vd2ahsJAtxuzvVtguThAUBx2IILgEuzVP+3BDIlw6Eci0+FJyrX2u
 2t/6MOfbBEwNO9ugx6+FexFvi4CELiw8Kp457B3aRFPGbLMpUXF3qAaMkwDm43/PKhI6
 QPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494988; x=1718099788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrlTj9cDcahH+eORLITQpITIeYXXxYxxz/PmNCcuvu0=;
 b=b2nB1M4S7U/VKMcpPQu3e8mokd1Qi4HrmRl3yMPqajaq/KAzaHZLKS4vo7fKDSP3ay
 aeil9jzDFGgU6DigS3E/pRtlyWDCt4ZULxWBys05Mrz4rgdxMdujZUW6RPqBqr4GuaPH
 C6+YUxI3NTY+rA9m+jTRiQDQqPfudF6ptGQVH5oMZMRwi5UGz/wCiIj7WXJlQSSZ22vC
 /QEe3UbuNXAMjiw3evH5PPpj8EonNBjDJmSl3DDkh/gubPc61emn3ztzGgc4deB1U5F8
 3x2ur7eBsJGYvaKt5bGXXFsZGDYh6AM045EYuXQQQB8vQmyv+PQ7Kbk46FATsZZsBuGi
 jnBg==
X-Gm-Message-State: AOJu0YyVcMtg+NtdoKpdTQhwdOXg4a8eyR1hLe64+UhNFKYB9xo/s25w
 kOhdGpsGrHWKF8ldrCZTh51xJLzY73BgzJ4azW6xoyDGg4yURsVym497nqFwqSA2D4/fOQNoBGX
 E
X-Google-Smtp-Source: AGHT+IHWs7uPb0NyGUgObjklZI4NgfIFdJpJaHQTqQZCerlzgx2FSVXyMqfc5U3eHBi6nNpdTqRVaA==
X-Received: by 2002:a05:600c:1550:b0:421:2ac2:d7c8 with SMTP id
 5b1f17b1804b1-4212e0622afmr103510855e9.18.1717494987865; 
 Tue, 04 Jun 2024 02:56:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064b030sm11067292f8f.105.2024.06.04.02.56.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/32] target/riscv: Restrict riscv_cpu_do_interrupt() to sysemu
Date: Tue,  4 Jun 2024 11:55:39 +0200
Message-ID: <20240604095609.12285-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

riscv_cpu_do_interrupt() is not reachable on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230626232007.8933-7-philmd@linaro.org>
---
 target/riscv/cpu.h        | 5 +++--
 target/riscv/cpu_helper.c | 7 ++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d0c02c35b..648e640f22 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -484,7 +484,6 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
-void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
@@ -514,6 +513,7 @@ int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_do_interrupt(CPUState *cpu);
 void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
@@ -539,7 +539,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
-#endif
+#endif /* !CONFIG_USER_ONLY */
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8ad546a45a..0868357f1c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1635,7 +1635,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
 
     return xinsn;
 }
-#endif /* !CONFIG_USER_ONLY */
 
 /*
  * Handle Traps
@@ -1645,8 +1644,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
-#if !defined(CONFIG_USER_ONLY)
-
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
@@ -1842,6 +1839,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
-#endif
-    cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
+
+#endif /* !CONFIG_USER_ONLY */
-- 
2.41.0


