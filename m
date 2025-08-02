Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F313AC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJE-000288-78; Sat, 02 Aug 2025 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIp-00016m-2x
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:17 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIn-00017y-JJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:10 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-61997c8e2a1so386500eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175968; x=1754780768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8iia86ZEBxJNkpQxMDVIvnq2O/V2R4bUkFKz1Yuo0A=;
 b=yNm72QU+50vA2rHHuim2ayfIhnoXJWsnGerX027dhWiUNae7TFQQdjsgR1aw7mQyLo
 W9VxTHvGPZXOMLJaT00A39rSBFeLfYJcrZZMXQoW87BV2hbOoN0VmEexln7YIPShuEhb
 Fo3ZAev3aofRg9pco5Deiow/FzpQ/zwpcDYWFWYhhvng8YdRmFCA8IQ7NNzD9sQ2XPYF
 lX6lsixng3DebE+oatMPS+iEjtdcqMAKB6c7n61VVLLQnVXxE/TXodicoGRxPiQgx6fT
 KO3jixMswnPsfycHHMKLbKiCzicjdX1H2PwGpm6Yj15LeffBHqObzCCaDt/MoG5OroJg
 edCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175968; x=1754780768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8iia86ZEBxJNkpQxMDVIvnq2O/V2R4bUkFKz1Yuo0A=;
 b=DEIKrmpheSPScQ3QVeGHwHE97EzyGGxix3m3chPjSiLBKjsCbyLg8a9zDNHJ61jtJ7
 9t20Lw8AhKIYiKERdUAhR8pov02Gp953CDrwInmXe/Vc0na7D9q2sOPbc8Ot+lbx/R8W
 aPYVg0WZPJ8AIrmXDZpuqSyWeV/3ZkUHpFt9tgCYtyGOq1RBVGDTmFFylslh1NV1Vx9Y
 omOnPNLZhw60HRtHufHcNubFJ0YTsQBacliFyE4K6p2EoTIu5C5kIn7juNFzbT39Wb0Q
 9ma66WWwtlzRagcTQ8SM2ez4NtIFEo0O8jvwxJJLGK2YD2vCpOwQt2R68NM7P995ew2T
 o0ow==
X-Gm-Message-State: AOJu0YwBtGubOpJMkY1vWHi0JtbpqOyTmSA+ZhskjboaA/HO4emF4Jp2
 /6aPBkFfz9Ffp1OOnbxUwStgDA+uM1/r9n8taGzr0NNIqq8jJ4LhY/Kbo5Qlb78gQwFC25L9GoK
 EUPW/398=
X-Gm-Gg: ASbGncvGmqL9Hx+Inog7EEIQdDa5GmoJWGxxhQPn6fc8ipopEIu8dxFEpSLMH8DJprQ
 SQ6gGe2xHiq4SnjBLe7rHW8nmPaGicR+Z8z78154a94ssRjQJbdagZfR7+gZUdJAsy9/4wJIIcM
 oPWuBdPPjm7DF0OqI4rTZmtueUrpeUPPjbw4itpI9kS8hkt4bcPEBeVhsZSmlql8/0ngmfrqErF
 SDa1A9DwVqKhLIP1EcJf8E4pGBWotQEzC5udaSJiBlHZ87YNKQEBeU8jAFlZbwqsBseAOOnuJC+
 UJM8c7z/aCWTNW0XjmvLCpx3z+DClPTFSUSvSZkEQ/XlRSnzv1sQEIqztLwEwGgtoGFPk2jUJ+Q
 kYWabyIyK790GZ+9+w9hfmoXGy8343a6KxVH63Eomp+luP2RBYOU78hN4L6uLzBA=
X-Google-Smtp-Source: AGHT+IG3aug2APxg504sz5P3gXmy2pBCQtiyZwFyc7+IILb7j6qekgcjOoelqzRmTT31havmMtlUzg==
X-Received: by 2002:a05:6820:88f:b0:619:2ee:6378 with SMTP id
 006d021491bc7-6198eb3bd08mr2345537eaf.3.1754175968409; 
 Sat, 02 Aug 2025 16:06:08 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/95] linux-user: Remove ELF_HWCAP2
Date: Sun,  3 Aug 2025 09:03:40 +1000
Message-ID: <20250802230459.412251-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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


