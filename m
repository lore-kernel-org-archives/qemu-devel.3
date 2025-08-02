Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0B3C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIK-0000eV-3b; Sat, 02 Aug 2025 19:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIF-0000aT-A8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:35 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLID-00013m-J5
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:35 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-610cbca60cdso1073410eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175932; x=1754780732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUDlTwexrg7VVi2wKLIGzuJdZ9/FoZnjKxQDeCVb91U=;
 b=soDhZkMZ1xoEqaaOME/xFI80rhflO9t1ua3zJJJxwR8y/LJ872B93+k2+qeyGR8szy
 gz2ZruLoXw4arsknIfPKc8XfHHwg6v1Mue9dKXuAQuYLBf0Wu5Agfm4SsM5iXozVuW/+
 8iz6ANSWR6UBvbL4ysLa6n6745pzRj8BMsobw0BKzVUQuRYooPtISziMbmOoCxhMtnZF
 LHrH1O3Bjk4dGZeaDYSzL3PuJ01fHP0neEU/STV5KiUceVQa0op1e9Wkds9gxdAUMyIC
 Y47oi3UAd1M+DBCdoOa9u80ijUd7vvZ+BJypnBvUu4GvUBjK5FbDWJM4UjLarOP8mMRk
 6azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175932; x=1754780732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUDlTwexrg7VVi2wKLIGzuJdZ9/FoZnjKxQDeCVb91U=;
 b=kSUsjG6Y1Dr5mpEqSPBJFLh+aBxz60g1Oe1kZx8S0mhOKFbi9U7CXPDGu9K4MdOkij
 QiAdQfe5YAyXcBSf0B6+BnnmCmGIaRED3I9P/P0zsr2Emxy7m2bK3s1HOCzfJfaXGJfh
 y5ATZbNU4/RvGGXChz2WcpmuOTRM1kr0YzD3Fkk5MLW8VSftVoqA9FJbec6bo27HAyuL
 ijk5yb5YDwUNl5/kVcUgmpn77udRwPYftgOGxvbT2d2PbgpJXoWGgT+ZDrwn36BY3wll
 jQ5FMnDmt/Q/G6dOMKeKUIZ9AgBSbbB9wFzmz/wY/8+xOIva6Mlh1KChd5neru84opsj
 144g==
X-Gm-Message-State: AOJu0YwMw9slFjIFok1vhDa8NPbTNeeftzTDg18SW9k6OMR9+X0eRfa4
 n2Qb2m/fB06vb3w9zsJfkQEU64+sTjy3ZUGE1BVNZARKPwTg1ytYs4ZPoOdRyjhEGGYT7VI4jMc
 mWlYq7/c=
X-Gm-Gg: ASbGncsLRKeZyig64XHApHQ4LSjWN7vDg88RHMZOV0hqNRehNUvYCbfK0+z7xSQwvjI
 S6Jcdv6fTcadk6uWddY98KahIIIw/yrfbAFCLGuvosjjrxe+bJGbEGsXKCPk2C7EjWwYcQLnYfV
 LzN8ZmSIMQ60bbsGomNiyMTVAbW3jzz4ToLMVl1pTIl597LE61wkPyk1I2bxs4rcbCkzyeWNXZs
 qXPPDxbvfRs1+V3I9GJBDrLx9lIiYqRLsGqJr785fonak2SxCaiRyhvJbS+wVy2lO971R7pxNtu
 pWnarafV/bnj/gwUFfGhQtkjinERtGYygNxiFf2DbZJViBHLBmy75zFoL6AjTfoI/zJyBOPI1bp
 wI3j0u3nOPz9isHaN0gsHdN6El3qagvvNzT5cNbwwhxBQUs+5TWli
X-Google-Smtp-Source: AGHT+IGV5MeYPkiAcnF3BOFyCwj4CH75fGmVxP/E8z9AxxNplbEfTMI5v4MKIpJgymfC9GBTvl6scg==
X-Received: by 2002:a05:6820:138e:b0:619:6fea:3343 with SMTP id
 006d021491bc7-6198f2af271mr2371565eaf.7.1754175932283; 
 Sat, 02 Aug 2025 16:05:32 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/95] linux-user: Move get_elf_hwcap to {i386,
 x86_64}/elfload.c
Date: Sun,  3 Aug 2025 09:03:30 +1000
Message-ID: <20250802230459.412251-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
Duplicate the one line function between i386 and x86_64,
as most other additions to elfload.c won't be common.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   | 2 ++
 linux-user/loader.h            | 3 +++
 linux-user/x86_64/target_elf.h | 2 ++
 linux-user/elfload.c           | 9 +--------
 linux-user/i386/elfload.c      | 5 +++++
 linux-user/x86_64/elfload.c    | 5 +++++
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index e6f0d8fa4e..802395af3a 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 75ee9975a0..457bb36daa 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,6 +101,9 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+abi_ulong get_elf_hwcap(CPUState *cs);
+#endif
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
 uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 5849f96350..03483bad57 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4ca8c39dc2..0c62c249e9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -148,14 +148,7 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    X86CPU *cpu = X86_CPU(thread_cpu);
-
-    return cpu->env.features[FEAT_1_EDX];
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index f92adb7308..f99336e73c 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -9,3 +9,8 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "max";
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    return cpu_env(cs)->features[FEAT_1_EDX];
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index f92adb7308..f99336e73c 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -9,3 +9,8 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "max";
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    return cpu_env(cs)->features[FEAT_1_EDX];
+}
-- 
2.43.0


