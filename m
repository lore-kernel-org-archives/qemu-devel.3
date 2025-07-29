Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FC8C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguTC-0004ct-N3; Tue, 29 Jul 2025 20:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-00023y-UM
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFV-00045u-9f
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso4194333b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833648; x=1754438448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CADeaL3DI6HVsbELxc9JEssLR4ovDMED3rp4rPvNRf8=;
 b=BnejvlEfIbr/o0cdCsD/VlNhzwVMTFo4wSWahNRPvF/7OojHQvq3AZW6MyVv8I7ali
 OcBadhBDSycKNdVvtuWcdwBReN4MWa/fUGjf5ByvQmsnjPThmg78iu374IYGq5Eg63cf
 ANnFaXLqtQFLoowA5P4Ik4V0R5sNmT0+fPFHvd3ROR9GA/comf6N7pI6xmgJaGnfhbAe
 Rtha7e8BgR5F8kdFrfIWuwUR107b34SthO5SM9d7P3ume/mWcV6Vyv8lCpH8uz9izXdX
 1KKG7eqCTXyqQF9U9wGpsAMbSLs0gtZj8VSLO1GxJlYncXGWDjY3PUSGgPwLI3fgzjqZ
 oulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833648; x=1754438448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CADeaL3DI6HVsbELxc9JEssLR4ovDMED3rp4rPvNRf8=;
 b=vyiuoL0Ua2zLfw3NxGSWRPd1LVVByJrO+HnqFSJqpkUbgsrvOxzb90GmEOWREcHux7
 IuiLydqjyWHOIyW0up+VXtfyn3Hl5N/rLUHKu3+QEM7zMXNG3QNBv4njeCc6HQkP7GAk
 n3RaQzugXyDxx9EsrRonmPjPdgFo86VXx5p5L0yZBEwrK/8RiBzWARYszCkrhIAMg0iz
 21RWS0BtQarvS0R1mXLbMgTXqq6fQ/0v5sDcb+BkzyfCz+r5VG5czPcppPT+3q7pB8cM
 3gvLkJj/ty8Z9t7NSwKi2XFeVfDLl/8g8xDRjZQHqu4M1+tkJbgKIKfvMDY/SjOHaF8b
 joYA==
X-Gm-Message-State: AOJu0YztaVieGuO9T96DrveYEwBcAr/EKTjmQahlUgq7n0hyB+ZCKac+
 0SZWBeeV3ueTBWY2hSVUMtNhuuUMlV/nXn+rpLCLJQWGLEgIzZEX8HNtNtCuEix8NlIhTYY5+ai
 0FYV2
X-Gm-Gg: ASbGnctujF+KOV/zB9fgjizt4OGYWXsktD+n2W3xHK8zrsisc0DSn1AS5zh6P27gVJR
 jzeHHYutw+YdROnBaehbQJeVUg/N5QRXN1BXvUzQU1S+pqldabjlDaa4OXVQSC2E57lDgUyEhAi
 +KPDgHMMyyWGX2GzoXY0MKDvyxRpnR/CziI3nMGiFD1/20tJihsURAfmcmt4LirL4hoLosDsncS
 2Mn7wsZpt5/Dol9aQAJ7hDGzfqcPk6dA+SHVraHQOMfAEqXFgZwYGydFTunfvrKbITlLsLf1jTN
 3yzbyu6Hr7tY5pYtM5vnm+60b4BnZWj/QiAyFxSBFEW1TQnRpKqqW9/u9BFc5LBPQvXXnyLHzWx
 CsOwNYHwcsQ6whgIJtLbiZkBOPjOuz0wGWwORp2SlOPhue7o3736TfaGao+mlY0kgWRHlVfoE4M
 YqG9KNhb2WmQ==
X-Google-Smtp-Source: AGHT+IE1R7b+hsnzGWpUNyZoF/OdcWJJAA1SBA9x6J0MssMYEtC8R/QMt7W0dCd9FfH2/nFWX1eD2w==
X-Received: by 2002:a05:6a00:2e17:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-76ab2e55d58mr1828105b3a.16.1753833647565; 
 Tue, 29 Jul 2025 17:00:47 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/89] linux-user/ppc: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:00 -1000
Message-ID: <20250730000003.599084-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      | 17 +----------------
 linux-user/ppc/cpu_loop.c | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 07f02378ad..00a3f6d33d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -491,22 +491,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
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


