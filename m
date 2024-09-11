Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4800EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJh-0000NB-Nk; Wed, 11 Sep 2024 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHO-0007jF-3S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHI-0007Wi-NS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c7d14191so524836f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057013; x=1726661813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOoLq1zQk/j+9ceACLoOgrYgbVOONfVhPAuu+Xp6jGY=;
 b=o48u0vLAsJkL3TT2VROyUZCnGNbl2TBywv6GbFAVeFQY72og2OGQDAYkxRDzPWSIXU
 8c79lsIBRO+LgG8C3l3Iqkh3etzJ95pfcWMqQ5nwqfG3GpyRp5LByzR+Tx48tI1Jb39L
 2RsrY5hyZiyL8yEWidTD5TYhP9yiwe5tdniSbXE+Lg9zYtRxx/jij0HuzNgQAAfGZ35K
 nhT9MCAIGv0VH65qR0VG2nrjeOCMO8TxzevZMEI7DLqqPCnhUq+Ka0eLk7IFThao3mrp
 cQLBMRDn0vWyP32LfExNuuoFHlNIkIu2wH2aMJ71uTJ/Haalq5Qz3yUvcl1IrvQ6kA2s
 1/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057013; x=1726661813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOoLq1zQk/j+9ceACLoOgrYgbVOONfVhPAuu+Xp6jGY=;
 b=nUaBra26p509R/DeONozEoAIcJr8tPKRXJtxayybNcnU5fwEJJciWnHvz7MNKzTDyT
 F4lrws7KmgMaYipxoBF3q5NVea9MHcClZ5e55+AKwiSDEL8Lpcf97BbmxHKDxIdS2EM5
 2tq9OXlolPKxzaQy28DLVwlIhqCIr2FMDtCxorHXuGrCEVLoMVKclypZ1SOSoaJG4dsX
 oZi/GOqVJNjcvSYeoRcUin6H/LruWaagD/hErqPuHngFu2LEA5mPV3heo8xB7cuMoXqF
 in7yG8sm970WdvZ8eMAjuAOjHFGquxIDa/LDh1DkBLRIsLwfy/II5fQ0kXgUg0mBNim9
 rnkg==
X-Gm-Message-State: AOJu0YxXqFww6KfzYlE8UO7QsmHqmJPf3I85fD1mLjNtyFFe2+7Z8k5Z
 IGAwSt6Xts/2b/+7ds3oQJSvZBz/1eWP2S7yMGqzEntLAay0ul+59z0341sCCRuPZX4BohCeCuk
 1
X-Google-Smtp-Source: AGHT+IGqfdu74IjOVB5tHXbUpKP+6YvXuN0u7CWSs6reMaEih2ynxXnmB5s813/5OvBpWXW8ntnynA==
X-Received: by 2002:adf:ed12:0:b0:374:be11:22d7 with SMTP id
 ffacd0b85a97d-378a8a1c2c2mr4010623f8f.13.1726057012895; 
 Wed, 11 Sep 2024 05:16:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956650f2sm11372417f8f.26.2024.09.11.05.16.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/56] target/riscv: Remove the deprecated 'any' CPU type
Date: Wed, 11 Sep 2024 14:13:46 +0200
Message-ID: <20240911121422.52585-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The 'any' CPU is deprecated since commit f57d5f8004b
("target/riscv: deprecate the 'any' CPU type"). Users
are better off using the default CPUs or the 'max' CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20240724130717.95629-1-philmd@linaro.org>
---
 docs/about/deprecated.rst       | 13 -------------
 docs/about/removed-features.rst |  8 ++++++++
 target/riscv/cpu-qom.h          |  1 -
 target/riscv/cpu.c              | 28 ----------------------------
 4 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dc4b6849a9..ed31d4b0b2 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -333,19 +333,6 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplementation unfortunately.
 
-RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The 'any' CPU type was introduced back in 2018 and has been around since the
-initial RISC-V QEMU port. Its usage has always been unclear: users don't know
-what to expect from a CPU called 'any', and in fact the CPU does not do anything
-special that isn't already done by the default CPUs rv32/rv64.
-
-After the introduction of the 'max' CPU type, RISC-V now has a good coverage
-of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
-CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
-CPU type starting in 8.2.
-
 RISC-V CPU properties which start with capital 'Z' (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index b850a24233..06f8cc1b73 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -850,6 +850,14 @@ The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
 ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
 via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
 
+RISC-V 'any' CPU type ``-cpu any`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The 'any' CPU type was introduced back in 2018 and was around since the
+initial RISC-V QEMU port. Its usage was always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that isn't already done by the default CPUs rv32/rv64.
+
 ``compat`` property of server class POWER CPUs (removed in 6.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 3670cfe6d9..4464c0fd7a 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -29,7 +29,6 @@
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
 
-#define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..4bda754b01 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -438,27 +438,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-static void riscv_any_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-
-    env->priv_ver = PRIV_VERSION_LATEST;
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-
 static void riscv_max_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -1161,11 +1140,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) != NULL) {
-        warn_report("The 'any' CPU is deprecated and will be "
-                    "removed in the future.");
-    }
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -2952,7 +2926,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
     },
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
@@ -2962,7 +2935,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
-- 
2.45.2


