Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQu2-0005Jc-VE; Tue, 04 Jun 2024 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQu1-0005J7-Rk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQu0-00022D-7O
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42137366995so34379345e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494982; x=1718099782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ay+Vb25Ah58Dvvnz7p7zDrtYiMbYdEQ6V3ef1gToK4=;
 b=NAOqbAZ9rXscGu3Fo7xbmPVgkeZ9s/+ZuBzZJ5F7mW3ba9mMw8NOxkLNZlQmHV2F47
 meV0OOq0IvtlNV8o+61z4+HhD5amDZsdVCwv4z0/8hDt864ahNwNlW+27VyG44lNPZWk
 7Av4VmzUxZMgS9YPzI2gV8db+reyrO1Fv12y+CScxO2sonfOSiC41V8XwgViWZ9dvGOP
 luWNFRBcyh+ma52HYL3BiWjpuPpXkCZH/Kgna3WvgM0QtA95JIixfWEeLZzpL6AbQoP9
 BTyNr1Ouwhsw+dEG7CCuXwMY8U7sroRkn3rD5qKCgPm4hxWs/hlk3RTCo9NFOQBkc6H1
 NynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494982; x=1718099782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ay+Vb25Ah58Dvvnz7p7zDrtYiMbYdEQ6V3ef1gToK4=;
 b=NMz15+YlDtZFxrkZLcyzVWVw3BLObXncExJqqAwPGb5LtiBp57/WzQtMqWZABoxEas
 Uk0CB4uxAxl246z7RMTEVStZh9yVl94PFjDOKHw4fPzg3xKGF3gkIWoTz7+iAw1ZGSag
 2jaYBi65Vt1x+bAJlpzM95DEco5UlF+DFUt+QGRfoC/n3KIMNpULCBeukzngFoeAODs/
 oEGhVcqYuw87lN2TIqx2Zd0aD7Thy6LrWMC/JUZq6xcL7B4ikiAl1bmz669Ngp3ocH+J
 CEaAaEHDwC/L8YHe5trUoxe8r+8nHRpOoLsb+1mEbi+nuMuclH7fRQFfBjgQmnwKAcCU
 4ADw==
X-Gm-Message-State: AOJu0Yxeo8EvlyoBEh1VPim7096yhSNpIqEuVnUuwCPbv8AtNkmioabO
 lBDbuv15512wb8qtAOj77f2ATrUhMYwkRUJeRDa374XNR3qhhibvZvWRm2U4tfnl6kEPE3EWpXr
 E
X-Google-Smtp-Source: AGHT+IEB8RT1GC6X383o/hp+NDc23LnbLGFkWuJ/5Rrx9E8cXvl7ht1QjD66JW21WJEss1u3LKXVGw==
X-Received: by 2002:a05:600c:5248:b0:421:4ecb:bd68 with SMTP id
 5b1f17b1804b1-4214ecbbf7amr14446145e9.31.1717494982345; 
 Tue, 04 Jun 2024 02:56:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062edbcsm11070738f8f.84.2024.06.04.02.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/32] target/riscv: Restrict 'rv128' machine to TCG accelerator
Date: Tue,  4 Jun 2024 11:55:38 +0200
Message-ID: <20240604095609.12285-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We only build for 32/64-bit hosts, so TCG is required for
128-bit targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230626232007.8933-5-philmd@linaro.org>
---
 target/riscv/cpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..0dad66ec96 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -591,6 +591,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -612,6 +613,7 @@ static void rv128_base_cpu_init(Object *obj)
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
+#endif /* CONFIG_TCG */
 
 static void rv64i_bare_cpu_init(Object *obj)
 {
@@ -624,7 +626,9 @@ static void rv64e_bare_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     riscv_cpu_set_misa_ext(env, RVE);
 }
-#else
+
+#else /* !TARGET_RISCV64 */
+
 static void rv32_base_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -2550,12 +2554,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+#ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
+#endif /* CONFIG_TCG */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
-#endif
+#endif /* TARGET_RISCV64 */
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
-- 
2.41.0


