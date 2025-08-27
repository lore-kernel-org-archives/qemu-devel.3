Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522EECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTA-00051K-KX; Wed, 27 Aug 2025 19:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSw-0004Tn-5Z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:08 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSo-0004KG-Re
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:05 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b49b56a3f27so277621a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336917; x=1756941717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7yJ2dOzXEPF3L/bLWXq6zElOhyfMDM32daynhfDIlI=;
 b=BmjQiGsRxEoX4Y+BISRlYtjS/4gcOH4fQ++N4qn3BraPpyk7iYycKKQMg4HuBFCEmr
 r1UkSdFk4IJJCyxHdhSuIP8sB05jzsngcyZKGRHMSb01KcGTs5r6Fw/oUxUs4BwMiSmZ
 n+CjX3XG016Zng1QqzLF5GKMc/1H636+d9fF+gjSoIxqKPc2uB7CqUjCWaazM+xL7sql
 SacEV8H5+BQVlGqmKEGGJmvkdgc44TQd5RYTUS89lp8iBqxBSklfuRM7lPZtLM8g1rrW
 Ibyrig+u8ssqetmxGRJ01xjakeapsz59ktrwUZgTS/r9AxyWjDkvgR8aDOGpJO9Solvu
 Qymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336917; x=1756941717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7yJ2dOzXEPF3L/bLWXq6zElOhyfMDM32daynhfDIlI=;
 b=K2ZxZaq5DS1A53rfoGWSjml9kuqSe+QEjJE2J+FtUEQxDyfrwWkY4BFi7GYLUUNgqg
 C7zPLyxCTYT76adV6PAGjczWgLS9l5kqRLEcu/zlItZZVnFe17ULdzecw75lLy5GpYGm
 Muw5zRKQn8+GlGtw3IYamanQG9zoWTfKgdVePDQHLEjZXNlwnV0qRz1j9v/fMqm6/Ri7
 Kq3EeSIah0uxldPVo0V9R+zFTrwRf8wY3+W8JFw1xeIOE943tKJKenJo7Hd5NtBEkUaq
 PXGT8qfnmXm3Bo2CsfeAT+TOzUfPI28lz6PGKRST0yIQ03DaOxj+MoM1j6VL+ho9ZtcM
 tCEw==
X-Gm-Message-State: AOJu0YzZDZveAfTDs5C3wNIii2Yz2GmMtIsiCHh1RPMUi89LYZzzXD2A
 K0PipZe6qXWKbGNR77qxlILYP+sKtFoNG9vMQLezdD0ITsN547RfTZbr5+zpZypep4WWWY0qoES
 Rob3m2X8=
X-Gm-Gg: ASbGncuagHF5atPyooFPIUFZ1mm3y1JZKLOAL9W4gtMUcpV+0cD5U+ykmtlcDtLVnRa
 x+AhK/e8LrmaFEdm17jLcq/CDR8c+mW/6lAlTiWr4+VCVYj16nhtF6gNQd7rcCLdGlUuu/eOoOS
 6FcrY7vCNoks1jiRJDyrvtX3hMaijv/uQZATmHjG30O/jGQdD6m0ct84lfijkSSMxqjQMGl12rt
 vIWYaa1UhXtQNUy7YevPkY+ZNgUy9HVMXriHsrn8oY2ZV7Tc5izuOAoStgS2CuO999mZuP2ZN+R
 RsdM7edfJ3e4c7/38f85oYEaSWQOiJSe52wB/V1qDzhFfleLl1E/mOzxL7psmRGBR9RXyru0WsN
 F48brWScq02prIK5X4UhlzfKUkA==
X-Google-Smtp-Source: AGHT+IGQIUXrni3PXf27OCFs5ESuZXrJZpi5wDPLgZcC6+xdbxl7fY9ROs6mbn9ndwhiuctWut46lw==
X-Received: by 2002:a17:90b:4a81:b0:31f:2fed:7867 with SMTP id
 98e67ed59e1d1-32518998362mr25686402a91.34.1756336916847; 
 Wed, 27 Aug 2025 16:21:56 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/46] linux-user/ppc: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:08 +1000
Message-ID: <20250827232023.50398-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      | 17 +----------------
 linux-user/ppc/cpu_loop.c | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 887a3a1cb2..a30431c7a2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -485,22 +485,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-static inline void init_thread(struct target_pt_regs *_regs, struct image_info *infop)
-{
-    _regs->gpr[1] = infop->start_stack;
-#if defined(TARGET_PPC64)
-    if (get_ppc64_abi(infop) < 2) {
-        uint64_t val;
-        get_user_u64(val, infop->entry + 8);
-        _regs->gpr[2] = val + infop->load_bias;
-        get_user_u64(val, infop->entry);
-        infop->entry = val + infop->load_bias;
-    } else {
-        _regs->gpr[12] = infop->entry;  /* r12 set to global entry address */
-    }
-#endif
-    _regs->nip = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 2a0efaffcd..22885ffd90 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -378,21 +378,31 @@ void cpu_loop(CPUPPCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
+    abi_ptr entry = info->entry;
+
+    env->gpr[1] = info->start_stack;
+
+#ifdef TARGET_PPC64
+    if (get_ppc64_abi(info) < 2) {
+        uint64_t val;
+        get_user_u64(val, entry + 8);
+        env->gpr[2] = val + info->load_bias;
+        get_user_u64(val, entry);
+        entry = val + info->load_bias;
+    } else {
+        env->gpr[12] = entry;  /* r12 set to global entry address */
+    }
 
-#if defined(TARGET_PPC64)
     int flag = (env->insns_flags2 & PPC2_BOOKE206) ? MSR_CM : MSR_SF;
 #if defined(TARGET_ABI32)
     ppc_store_msr(env, env->msr & ~((target_ulong)1 << flag));
 #else
     ppc_store_msr(env, env->msr | (target_ulong)1 << flag);
 #endif
-#endif
+#endif /* TARGET_PPC64 */
 
-    env->nip = regs->nip;
-    for(i = 0; i < 32; i++) {
-        env->gpr[i] = regs->gpr[i];
-    }
+    env->nip = entry;
 }
-- 
2.43.0


