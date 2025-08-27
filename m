Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF865CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSJ-0002CY-Lt; Wed, 27 Aug 2025 19:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSA-00024Y-4J
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS7-0004Co-S5
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so343549b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336873; x=1756941673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lA8rQOeAatjbT4Ro5o0lSzOtjaI0GEX6SAlAltEIUzI=;
 b=e7Vs/sPIa3bgAp9W4B/6ER7LGJmuL7aENiQabGKmWU9dQVeAWYefovbqpno8l2yU9d
 WKc83l7We7YbeQV9TY7jEtelZuKEojKCr7fyAiVgPhBIeEp/Pc2i/i8pUAFvgeLQZH3k
 vLSxp/UqXJdN56yacuMv8LFUBVOwotp8mZFeziy6M4cfZ8O0veypX/syanqAT7Ukyq4F
 FwafaHVwgGve1u+ijVOJGrXoCxr+Z8j9Qv3MR0jWqDm/6On1g1rErBVHLtaGCvoGBXh4
 2LjvXdGc6gg4pZKfKGks8ma+O0cfv0Ehw3XRPNnUteXizJpeW1merk411Y7XRDlcYMM6
 QjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336873; x=1756941673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lA8rQOeAatjbT4Ro5o0lSzOtjaI0GEX6SAlAltEIUzI=;
 b=aiHecoJOZaS8a5qcCM1EptML3ThOcdpiVGnDFGfUqkb66pzP7G2jPxArjV5Sq6T+3L
 gshdOv4LPJbVL5QKfvV6jkYS1TqvFIuE881ucYVl/OIoB5fBLbA6xbjqmcS7lskLKChS
 IpSqyKMCRBI9bT0HAWjz7EtXVjhrZLC9kJSw0PHady4RB9CEKKfWWkuEs3oBZjYZrwO4
 iVG+nkq4fvCCSh7FsNPpPv/pbqQGMvC+dVSeHHMlWgpWhAk9RewX/WKJOOuXhdiaz/G/
 Rq/JNpMuIb7owtzzPXNx2ax4aKQLoeMQOPS0E6Bm5lM/a6XQLb37chdLQ07lMQqxTHbX
 4I6w==
X-Gm-Message-State: AOJu0YwJSAdMicsBZD1+nr5CGVUBX7cFLsj2uBn3qLsoTPUj2mJW8u9v
 Ql9wETRLGmTkCvObFKaoOWgNei3WclvmjIia01WUhiM0x+YgZhlAuQOceVJMuRXtIurRT87fHmW
 Aij3c1as=
X-Gm-Gg: ASbGncvT9U9gYTIkOUdyOBNQ+EYog1RrhgL0XopGLayH+nos6v2gB5bxRPXtU6XSOct
 wW0ILvIyBf/PHsLAtat4x7HQwSOBrbH2jfB1067LgtKMnsgZSW8aZejYYMNs+ECiD4JUYSupozS
 CDvMfKNRHOvMHpKK7F4rcakaTYyAi8m9mm6lPmbx903QDSLdEmMUSFO5OIIMmLkzaqFaBAuveqr
 BaHpv4CJlxhURi+KuI7cAFbEGCVOyhOKVnZFLu8kW2J7RiJeflAj51pTVS3Ox02ROcY72ugZyAO
 wXBO4z819DTUTmtTXl8MV0NlATPQWMCf9IUkzBMib3F9Kpc0WQAgTaguwV2UhHkCtUOVfgqUsar
 GItys6Zl0ZXptfZ3n8LJ4PjzdE4X8UJKHFUBW
X-Google-Smtp-Source: AGHT+IG+328bMyUCQvSVL+CzAtJ55zyYLMMbQGTwn7sEske2Nknuhh2QF1WDU/quWF0o2ZUSTfxiCg==
X-Received: by 2002:a05:6a00:23c4:b0:770:4ff5:1d2a with SMTP id
 d2e1a72fcca58-771fc293145mr9540581b3a.2.1756336872991; 
 Wed, 27 Aug 2025 16:21:12 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/46] linux-user: Remove ELF_HWCAP2
Date: Thu, 28 Aug 2025 09:19:53 +1000
Message-ID: <20250827232023.50398-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

All definitions of ELF_HWCAP2 are now identical.  Provide a
not-reached stub as a fallback definition of get_elf_hwcap2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 88d439f348..7a41917b49 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -448,8 +448,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
-
 #define ELF_PLATFORM get_elf_platform()
 
 static const char *get_elf_platform(void)
@@ -537,8 +535,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-#define ELF_HWCAP2  get_elf_hwcap2(thread_cpu)
-
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
@@ -593,8 +589,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_ARCH        EM_PPC
 
-#define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
-
 /*
  * The requirements here are:
  * - keep the final alignment of sp (sp & 0xf)
@@ -1279,6 +1273,10 @@ static inline void init_thread(struct target_pt_regs *regs,
 #ifndef HAVE_ELF_HWCAP
 abi_ulong get_elf_hwcap(CPUState *cs) { return 0; }
 #endif
+#ifndef HAVE_ELF_HWCAP2
+abi_ulong get_elf_hwcap2(CPUState *cs) { g_assert_not_reached(); }
+#define HAVE_ELF_HWCAP2 0
+#endif
 
 #include "elf.h"
 
@@ -1801,9 +1799,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #ifdef DLINFO_ARCH_ITEMS
     size += DLINFO_ARCH_ITEMS * 2;
 #endif
-#ifdef ELF_HWCAP2
-    size += 2;
-#endif
+    if (HAVE_ELF_HWCAP2) {
+        size += 2;
+    }
     info->auxv_len = size * n;
 
     size += envc + argc + 2;
@@ -1863,10 +1861,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
     NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
-#ifdef ELF_HWCAP2
-    NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-#endif
-
+    if (HAVE_ELF_HWCAP2) {
+        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
+    }
     if (u_base_platform) {
         NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);
     }
-- 
2.43.0


