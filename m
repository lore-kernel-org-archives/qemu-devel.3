Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF072CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmO-0006xa-Mr; Sat, 30 Aug 2025 11:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7by-0004u4-H3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bw-0003xE-88
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77238a3101fso446973b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506618; x=1757111418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5SCOArTMDFn9DLEGEULkPg//35bBeOm8KVxr1J+Y1U=;
 b=PrRiRjqObu6k1y6ucg6yLj0yH+QpFiHR+zNRS1Rf6hwVWjF3MY1bn+0pQUFVekjogN
 j+++2cE0Lc4+MMzk3Ws6fDOaz6gEdKEJ30EqRnp1hZLrgYTuBQPWL2gllc94cR4Tv0at
 onRSRcXD3p/eFdMbFVr/MdvSuhLg561HdUmpDSIicoPJ9bJgNyQ0JApBS61B5ybSLs/0
 HvDhNIq31qy9ajGVYe+5fef9hKGkqow9ZOumAhFAp5GiLMXZf/PvQqhQQ1g7YopfzG8s
 ownBjzrgKhYjaAcXd0rxpmQlQktZsbMPVYB7/K77rN1Kl+6pgvYPhqmS7vsRMe3CbOcR
 fAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506618; x=1757111418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5SCOArTMDFn9DLEGEULkPg//35bBeOm8KVxr1J+Y1U=;
 b=v3kfpJ5w+4v5pvdcpwKjwHZNIQiPcDVacHWgOlm8+XXRSFOtkm9WPaiXxuzz3YnARz
 yn16cZJwSvODfEtgJXlTtlXh6Sp2U9hqyg9pCxqNLsN3G/gojInqeILzXK4+HerDpiOb
 41eKRLo40Dta6Omn0D0cKHJ67dt6klJO0HV1qgT2k4nQTpq4bl2KZTBhik24ec9brGR6
 njcIaDZnCEG4OZw3cb3zPk10p3SZJcZFdgOR/ov26NPkN5b0PdXUoqZ3V8PFiw9hpQD8
 MIhYTBZb/HKcLlC56nQdvjMk9okLbUoMQjVzZkXZgspIipBbMOgO363R9aYlbSS4kX0w
 I63Q==
X-Gm-Message-State: AOJu0YxMauMH16hqmpJs9Zo9+isJPxrSYOouKLvCfERD29VW1T4USA4O
 feDNXvqzTIePw1Y5THhwazFhRr3v6IHivRg0+IjNALjdoZe/IggNknFyfYjxJPS2JMIaTfK9lSA
 aOL/DGn8=
X-Gm-Gg: ASbGncvjrmOw7+FBIoKm+NotUIG42raQ63+ts9m7a0LHgj/dDO+Wu2E6WLQKyyNIsXQ
 daABWbPlevDctDSGubA+TX456eZ38EqioZOYnfp3KnP6q0Hoc8IxP8yX+TA7F02Aywe9Hmh++Aq
 +qrA8JJIxst24I/SvtbSgN3in91WoA1cIXOnPdxbWTG7MfejAGRzLBdRd8ygqhfgzDWR3uFVb8l
 qKE2AChO+ng4FoUQWCPUEjN0xWigh1PUZuRNhnLmQqkn3zJDUaCZQNWpi9UtlHQRmZIyTDxfIoN
 Uwsd4wHHHUb2FTh6sD4rNtQzEb0f308YVaptjTbHy5XD9alKa3Ksh7HnFkkoLGs5I6bwGFU7OpO
 c44F+YT1VCrYqMy9rqMPG27sseUxTcFYJZ87bcJBSTBYivt/YDY+ZxtRuwDjFrdJ/27xY+s0mjA
 ==
X-Google-Smtp-Source: AGHT+IHnLcVs8VfGcJ6d49H84Xa3TxphBlKu9sh6/uO8dLQmJ1TKiteY44vBX1BMtnSp5AYRiQmpxw==
X-Received: by 2002:a05:6a00:889:b0:771:e434:6c80 with SMTP id
 d2e1a72fcca58-7723e257d88mr301810b3a.11.1756506618264; 
 Fri, 29 Aug 2025 15:30:18 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 68/91] linux-user: Move elf parameters to {i386,
 x86_64}/target_elf.h
Date: Sat, 30 Aug 2025 08:24:04 +1000
Message-ID: <20250829222427.289668-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   | 22 +++++++++++++++++++
 linux-user/x86_64/target_elf.h |  4 ++++
 linux-user/elfload.c           | 39 ----------------------------------
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index f89ac0b611..dc58c0017a 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -10,6 +10,11 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_386
+#define EXSTACK_DEFAULT         true
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
@@ -22,4 +27,21 @@ typedef struct target_elf_gregset_t {
     struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x)       ((x) == EM_386 || (x) == EM_486)
+
+/*
+ * i386 is the only target which supplies AT_SYSINFO for the vdso.
+ * All others only supply AT_SYSINFO_EHDR.
+ */
+#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        if (vdso_info) {                                \
+            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
+        }                                               \
+    } while (0)
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index f05b1d4dba..f3c09bb8da 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_X86_64
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8ff9f83bb8..73ca6c681e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,45 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_I386
-
-#ifdef TARGET_X86_64
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_X86_64
-
-#else
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_386
-
-#define EXSTACK_DEFAULT true
-
-/*
- * i386 is the only target which supplies AT_SYSINFO for the vdso.
- * All others only supply AT_SYSINFO_EHDR.
- */
-#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        if (vdso_info) {                                \
-            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
-        }                                               \
-    } while (0)
-
-#endif /* TARGET_X86_64 */
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_I386 */
-
 #ifdef TARGET_ARM
 
 #ifndef TARGET_AARCH64
-- 
2.43.0


