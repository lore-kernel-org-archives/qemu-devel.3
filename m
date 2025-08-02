Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B53BC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIa-0000sY-Jy; Sat, 02 Aug 2025 19:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIV-0000mi-9G
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:52 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIS-00015p-JS
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:50 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30799a41109so1055517fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175947; x=1754780747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKIdW06ZTz1VXr6FwN7LN5KfnzHWclYz+QB+jPoNsFE=;
 b=y8pmd/gJ7tfSg7O0r2QtmfDBXl5scIBeIeC3Low5quaTFx4EyWq4n9thsg2V0kvAP1
 7WpnsDSabRaLidwm4YP+FdHhU5z/gJa+7/coyBA7dwRzT9LlCxvl3i0/WvOMQDioHp5A
 zA0fepH1/F9RT2r3/dkJbGo02grWYLkwaKAiSzX0aNuoaaeOcVpNdPyaJX3WRzSbE93J
 jVuFpwRzXbBcFsL9efvxdHX6uczbYl/Pp+PyKz755LSQ79p/Bgi409w3tbi9Pa423UdP
 2J0FmZhsM1zIOS2tYSaO+y5tgB0VJD0Sc4ENIe3WBehAuMtn+KvUGFVGowDc9kY/2UL8
 rXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175947; x=1754780747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKIdW06ZTz1VXr6FwN7LN5KfnzHWclYz+QB+jPoNsFE=;
 b=fGiJsbfeDHyYbp8CJcp/yi//kx4+QstajvtBdogD5trYvFg9qwlBvsnKFgduKHFDt/
 VrGa+ukdYcYSYsjYv8H2QYpLqa9xBGlO1N9UVzwCe/rNfrw5kkb+SFUiuiZckL9jwlPM
 SvyPeHBjVsXyIRkocu4gkybkVXpD9SPVD4mnEMUCIm+CaAGxYrXomfa7Pj67JQiH8+oh
 6xk/7YUiH/IZNmJ6c9ADkGYtOiLF8PK9McktKqFXpmCTeMU1NAMEY4Ni5c4ubLo17rbY
 kdxFC9EBH0+HdKS3SmzYYVCb82L8WDYIQ9qfZP+24wdhgAUPiETqgC+5+1YQayU1hEfB
 SUPA==
X-Gm-Message-State: AOJu0YwitlVqXh7D554MUcIEoXvOawNhsS+YazFnaOqNr+k4U6F/wBAG
 wEp2MXl17MXyZAxb5e7VDF3o0luNwS2X/heiURfX7EVQQdYOS8GstiWbug9fXII+6Vd6jdCRqaE
 EHK4yhIk=
X-Gm-Gg: ASbGncs+R7MkpPA6yc1NkDXZYBxxtGwxghYMqu107jJQ115/ornf0mG2joQVNEaVDAq
 KPpxg/tjZSpWr3A2wLRZqDHN7ASk9x+v4dHQkOMPU/XV6MTjg3C26IbwqnKHQO1onM0fwcGe4/v
 S8IHj9dl5ywR25gH9+C67PNFqYCb01YrLW3omY2gjbFQfErav2ADBiAC7V9t1oKsYmKzjWRwvMK
 NNZh9rw/E2IstwIXJXW54Z0kfOCB/v3EDelZqOITqzy26Kh/tIClAZ04XkEXfb9p0e4MNp8DWU9
 TIYPUNjpDKKZWEoz/fA4Bi51kHg/XjRccsKzu2L1KtWWNqiTqxdCKNyvUyiQtPHuGIyo6fmBdA4
 1jOpzZ/gH94Pzj7WlqRuqZkOYzQIAeLbfCdBvKvAUV+2FHGWlZiI6
X-Google-Smtp-Source: AGHT+IGSsyDXAT7H8fgAG8FD59RBM6FBNgKHe65YzwMCHXJXVJILR2lEQ9Hd9DLIw3UBKLFiScjQ0g==
X-Received: by 2002:a4a:edc5:0:b0:615:b2c9:7ffd with SMTP id
 006d021491bc7-6198ef153c2mr2417998eaf.0.1754175947233; 
 Sat, 02 Aug 2025 16:05:47 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/95] linux-user: Move get_elf_hwcap to
 loongarch64/elfload.c
Date: Sun,  3 Aug 2025 09:03:34 +1000
Message-ID: <20250802230459.412251-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
 linux-user/loader.h                 |  3 +-
 linux-user/loongarch64/target_elf.h |  2 ++
 linux-user/elfload.c                | 49 +----------------------------
 linux-user/loongarch64/elfload.c    | 47 +++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 818c5e6d7d..92b6d41145 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,7 +102,8 @@ extern unsigned long guest_stack_size;
 const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC) || defined(TARGET_PPC)
+    || defined(TARGET_SPARC) || defined(TARGET_PPC) \
+    || defined(TARGET_LOONGARCH64)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 39a08d35d9..037740d36f 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -6,4 +6,6 @@
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 843b1f7b6c..574b37a22c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -725,54 +725,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap()
-
-/* See arch/loongarch/include/uapi/asm/hwcap.h */
-enum {
-    HWCAP_LOONGARCH_CPUCFG   = (1 << 0),
-    HWCAP_LOONGARCH_LAM      = (1 << 1),
-    HWCAP_LOONGARCH_UAL      = (1 << 2),
-    HWCAP_LOONGARCH_FPU      = (1 << 3),
-    HWCAP_LOONGARCH_LSX      = (1 << 4),
-    HWCAP_LOONGARCH_LASX     = (1 << 5),
-    HWCAP_LOONGARCH_CRC32    = (1 << 6),
-    HWCAP_LOONGARCH_COMPLEX  = (1 << 7),
-    HWCAP_LOONGARCH_CRYPTO   = (1 << 8),
-    HWCAP_LOONGARCH_LVZ      = (1 << 9),
-    HWCAP_LOONGARCH_LBT_X86  = (1 << 10),
-    HWCAP_LOONGARCH_LBT_ARM  = (1 << 11),
-    HWCAP_LOONGARCH_LBT_MIPS = (1 << 12),
-};
-
-static uint32_t get_elf_hwcap(void)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
-
-    hwcaps |= HWCAP_LOONGARCH_CRC32;
-
-    if (FIELD_EX32(cpu->env.cpucfg[1], CPUCFG1, UAL)) {
-        hwcaps |= HWCAP_LOONGARCH_UAL;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, FP)) {
-        hwcaps |= HWCAP_LOONGARCH_FPU;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LAM)) {
-        hwcaps |= HWCAP_LOONGARCH_LAM;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
-        hwcaps |= HWCAP_LOONGARCH_LSX;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
-        hwcaps |= HWCAP_LOONGARCH_LASX;
-    }
-
-    return hwcaps;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #define ELF_PLATFORM "loongarch"
 
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 874dc4c230..ee4a85b8d6 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -9,3 +9,50 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "la464";
 }
+
+/* See arch/loongarch/include/uapi/asm/hwcap.h */
+enum {
+    HWCAP_LOONGARCH_CPUCFG   = (1 << 0),
+    HWCAP_LOONGARCH_LAM      = (1 << 1),
+    HWCAP_LOONGARCH_UAL      = (1 << 2),
+    HWCAP_LOONGARCH_FPU      = (1 << 3),
+    HWCAP_LOONGARCH_LSX      = (1 << 4),
+    HWCAP_LOONGARCH_LASX     = (1 << 5),
+    HWCAP_LOONGARCH_CRC32    = (1 << 6),
+    HWCAP_LOONGARCH_COMPLEX  = (1 << 7),
+    HWCAP_LOONGARCH_CRYPTO   = (1 << 8),
+    HWCAP_LOONGARCH_LVZ      = (1 << 9),
+    HWCAP_LOONGARCH_LBT_X86  = (1 << 10),
+    HWCAP_LOONGARCH_LBT_ARM  = (1 << 11),
+    HWCAP_LOONGARCH_LBT_MIPS = (1 << 12),
+};
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    abi_ulong hwcaps = 0;
+
+    hwcaps |= HWCAP_LOONGARCH_CRC32;
+
+    if (FIELD_EX32(cpu->env.cpucfg[1], CPUCFG1, UAL)) {
+        hwcaps |= HWCAP_LOONGARCH_UAL;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, FP)) {
+        hwcaps |= HWCAP_LOONGARCH_FPU;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LAM)) {
+        hwcaps |= HWCAP_LOONGARCH_LAM;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
+        hwcaps |= HWCAP_LOONGARCH_LSX;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
+        hwcaps |= HWCAP_LOONGARCH_LASX;
+    }
+
+    return hwcaps;
+}
-- 
2.43.0


