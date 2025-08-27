Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF14CA0FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRj-0001YC-Jk; Wed, 27 Aug 2025 19:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRh-0001X9-V5
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:49 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRf-00048V-Gj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32326e8005bso375488a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336846; x=1756941646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUDlTwexrg7VVi2wKLIGzuJdZ9/FoZnjKxQDeCVb91U=;
 b=a7A7P7L6BeI4bV/YF4vji8upriVH6G0ekrVqqLzAhkuMm5ThR2jimqIsrQliHMsVip
 ihhpfHyCBaVHNvaYbg34CKXs8Effu0LCGlnzcEVXIvqbuE9Z7EQUgK4Nxy3Eq/bYuLZh
 IjH7kBAfZJejERRcYt2PO4fijTprKcAqcrSpr1tfbyl2x+pSlYq9v0QXGJt/PHDHlFv5
 f0Hm5AfHl0kOEyO4fcEr2MrVBSyiW3PyiqcHNzKbq5kxd4LYhQuDs9H5dowaW8FXQFw/
 HsR9d7V2QcekDIw1X3IBMDPe/oD0DKyqp7c5Q5WKmACeNSYh2L4ktVyyuTTjUDqvZ5bT
 lRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336846; x=1756941646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUDlTwexrg7VVi2wKLIGzuJdZ9/FoZnjKxQDeCVb91U=;
 b=sxqFIngeZePi2gubWF7uVpcDY+UENxTRYvH5nSkuVyANkT+I3orhvqyXyCfHlqOiQH
 WMFaT6C/A+1tsyHhsQWaaQST9uascDh+zVJJ1sdIhKEY7oxvdbMNAx48bDh5s4KgoL4m
 oVvX+EkkQAf7/pWUERvN+vPNJnHQ3ycuxLqsvx2OS61eTGQ7sdlDAIQqN7ZvyzAPvV9I
 x7bplaOck4HhyYXrld2a6BnCeMqsi2WFd33ZvKW1MinecjkELidaBql9qPRa9U4/NT6L
 gJzeu9Z/LOZTwNKJISAWcmQfdCCs5wUVNr6EXLIeT1iSvUPSspq7zA766eX0lgkvUili
 Q08A==
X-Gm-Message-State: AOJu0Yzh2QeOmVRPhe2nYAtdgEekkYH+ATEPbXnD1+BkKmljtX9vRGSg
 d3sSGroHKxZhY9m1QmZ6RzCDlK2oax1o9U12Slh9Z9xUh7cRS6iAsMMY6QKJUBiUSCBMXh7JOeS
 Vi51d/cM=
X-Gm-Gg: ASbGncvl47ZKaTCzU7hm7eVrzhogN291VravdijvSxiPxqkbRViomECJMvTKXSLPhBl
 8PpWE345gS7ScQAUnha4GtSs2/1A+/G0E6NQXsmw7ZDjdxY3+rDKQYsC0Tvb0+GzJtGRKrSJqjv
 jCY0LazFOlcYcvB3K7L6/FtCEm1l6eLeHUFB6uhPfAlMo+kFVDvPdOx7ry7j3rJFTZeE/YOt0Da
 QOW9Qvw0l4SdAC3gpOlq1rUyrdJCFrwv3PvqNQ9G/yYCS1MYJqIy8ceZS+i2lKnSOeodduX8z8G
 r+BtLTK966/ekDnteR2ABHxpjVIeO5Q8E53GMZdFXwAz5WW/E4sgWdwhQUR8V1LFLItlrUnVQYR
 pi1DCtS+99twxZEsyRUXZkCKFCM2GQtkCvYbH
X-Google-Smtp-Source: AGHT+IGciEOxO2qOWv1lguyakIFvuam4HOcwZGxNRpAkEBzJNVF07dJi96AkD7pGy5AN0xgOP24Tew==
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id
 98e67ed59e1d1-325c492175cmr13947119a91.28.1756336845890; 
 Wed, 27 Aug 2025 16:20:45 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/46] linux-user: Move get_elf_hwcap to {i386,
 x86_64}/elfload.c
Date: Thu, 28 Aug 2025 09:19:43 +1000
Message-ID: <20250827232023.50398-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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


