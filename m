Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB62CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRy-0001n6-7v; Wed, 27 Aug 2025 19:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRw-0001lj-4G
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRt-0004AT-Uh
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso494567b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336860; x=1756941660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7W5Ve4shqEohSxRVdKPBvK3hz0rWOcEpZ6oE5AgP894=;
 b=wf/wpP6/dMMBWjtAA33ndQNRCMOZ4zF7xkekeCvSDPLMRgRIRdRnh/aDy5o6Dd1fox
 wA+4GD0XfBZzgmFodV9gZ5sfVEk6amaDSbKMDl7nqT+3Jo6eyDVNONqrZJNCGBvq4WCr
 qu967v7Q/mD8cvnW08LvTERYYup3rfpISuuY0seDF19usoaF8bolzu2qQdZW0vRFAfkU
 D9w5R84vyfeO+8UEr2u7fIR2g8Ts7SOSGWKUJISQLsMeSvVrKJeXtCoMiRNcIS5soFQf
 TGuThz3ISNgTKC7xQbAKxKLN/PhYu7wNxey7ck6W1vl7itez/PFodl8yzkXJpXI0JwIN
 fMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336860; x=1756941660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7W5Ve4shqEohSxRVdKPBvK3hz0rWOcEpZ6oE5AgP894=;
 b=BheQd++1PhDElIAVRyMRULF1wg5Y2/ItpHzCkxYEEwgjbnPgxprDa/72WF+7YhAXxr
 O6K02JGzK14JqVvCTppl+TBtsMEBBhnmQ/hByax943Ktn4evKyZ1YfIhv8Bwa3wwUYsp
 rnwqs0FRkbpSHxlR1cHOBizX3syxN8XlLPSaCCX/kwUU6f9k2X+HfmtttgXPoQPhyzzk
 f+wpDoizG95MZBn3BKldKJlLBESBmL2yR/DpBUq4QecECAGfsXARz6wUyFubxkmFMuf/
 mmU23PP4YO4tCo5zp+onBEpP5EiOUqA5MpPndzd4lMJsrZhvuHC9kjQcWjSknThhJQiC
 0EGQ==
X-Gm-Message-State: AOJu0Yyj6pai83qvBAEBkRjII2pL+LBoelRu4azURYIrsKKBx8jsEtTt
 35D6FE8NDdpWszsB3eonOuWaqE+Xzt8SH89x+xdDu0K1u/m6JNYu7Z/PHJD+AlWEuX0Y6fJIiyC
 o1OReaPw=
X-Gm-Gg: ASbGnct4WmN3Zzx3ngjM8I74HdGY3SE9l+yGl2cZjJq2St9nMKLQ5m9H0I57yjGd+p9
 z/ZggBlnYiCErwN1tc7CgBsL2rrulQZYk+K0A5Nu/CrPoGJBassIQdFDaRuRCGRiYwOy7mDx598
 vMIcLGSut50+Z0bI6+nvqq5n+C8QxUd98rXGMeGDF6Vj4OI9K8V4VY59+Avq5GCynEQLx6e+dik
 EViPZwURKIdqL+4RwQFepUxoPnSM71NZ1TxiwKxCSDnPw87EWUybRaasPBWnsZ015evUhUDJklS
 k9VRC5xDZYeJPIYBjS+jvXayT2MmUAW96F/LqXF62v8vwBZReiNKt6C7Lu4h1LMkswUPcFNP8nI
 xvWhyATBWGgAQn58cB/+km1IwGw==
X-Google-Smtp-Source: AGHT+IElLyZlA2R09DGWEmYhKeSf1yPV4YFkwPq+86V+LrB5bpxkOFD1y5KBKZ/cotUn+2Dtf6UQIg==
X-Received: by 2002:a05:6a20:9185:b0:23f:f431:9f77 with SMTP id
 adf61e73a8af0-24340b360b2mr30539128637.22.1756336860194; 
 Wed, 27 Aug 2025 16:21:00 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/46] linux-user: Move get_elf_hwcap to mips/elfload.c
Date: Thu, 28 Aug 2025 09:19:48 +1000
Message-ID: <20250827232023.50398-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
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

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  2 +-
 linux-user/mips/target_elf.h   |  2 ++
 linux-user/mips64/target_elf.h |  2 ++
 linux-user/elfload.c           | 52 +---------------------------------
 linux-user/mips/elfload.c      | 50 ++++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 92b6d41145..04457737dd 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,7 +103,7 @@ const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index febf710c7a..877f8347d7 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 02e6d14840..c0347e5cb6 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 574b37a22c..dc3f502277 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -834,57 +834,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-/* See arch/mips/include/uapi/asm/hwcap.h.  */
-enum {
-    HWCAP_MIPS_R6           = (1 << 0),
-    HWCAP_MIPS_MSA          = (1 << 1),
-    HWCAP_MIPS_CRC32        = (1 << 2),
-    HWCAP_MIPS_MIPS16       = (1 << 3),
-    HWCAP_MIPS_MDMX         = (1 << 4),
-    HWCAP_MIPS_MIPS3D       = (1 << 5),
-    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
-    HWCAP_MIPS_DSP          = (1 << 7),
-    HWCAP_MIPS_DSP2         = (1 << 8),
-    HWCAP_MIPS_DSP3         = (1 << 9),
-    HWCAP_MIPS_MIPS16E2     = (1 << 10),
-    HWCAP_LOONGSON_MMI      = (1 << 11),
-    HWCAP_LOONGSON_EXT      = (1 << 12),
-    HWCAP_LOONGSON_EXT2     = (1 << 13),
-    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-#define GET_FEATURE_INSN(_flag, _hwcap) \
-    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
-    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
-    do { \
-        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
-            hwcaps |= _hwcap; \
-        } \
-    } while (0)
-
-static uint32_t get_elf_hwcap(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
-
-    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
-                        2, HWCAP_MIPS_R6);
-    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
-    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
-    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
-
-    return hwcaps;
-}
-
-#undef GET_FEATURE_REG_EQU
-#undef GET_FEATURE_REG_SET
-#undef GET_FEATURE_INSN
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #endif /* TARGET_MIPS */
 
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 04e3b76740..739f71c21b 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -42,3 +42,53 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "24Kf";
 #endif
 }
+
+/* See arch/mips/include/uapi/asm/hwcap.h.  */
+enum {
+    HWCAP_MIPS_R6           = (1 << 0),
+    HWCAP_MIPS_MSA          = (1 << 1),
+    HWCAP_MIPS_CRC32        = (1 << 2),
+    HWCAP_MIPS_MIPS16       = (1 << 3),
+    HWCAP_MIPS_MDMX         = (1 << 4),
+    HWCAP_MIPS_MIPS3D       = (1 << 5),
+    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
+    HWCAP_MIPS_DSP          = (1 << 7),
+    HWCAP_MIPS_DSP2         = (1 << 8),
+    HWCAP_MIPS_DSP3         = (1 << 9),
+    HWCAP_MIPS_MIPS16E2     = (1 << 10),
+    HWCAP_LOONGSON_MMI      = (1 << 11),
+    HWCAP_LOONGSON_EXT      = (1 << 12),
+    HWCAP_LOONGSON_EXT2     = (1 << 13),
+    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
+};
+
+#define GET_FEATURE_INSN(_flag, _hwcap) \
+    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
+    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
+    do { \
+        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
+            hwcaps |= _hwcap; \
+        } \
+    } while (0)
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    abi_ulong hwcaps = 0;
+
+    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
+                        2, HWCAP_MIPS_R6);
+    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
+    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
+    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
+
+    return hwcaps;
+}
+
+#undef GET_FEATURE_REG_EQU
+#undef GET_FEATURE_REG_SET
+#undef GET_FEATURE_INSN
-- 
2.43.0


