Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC864C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJ6-0001dq-5S; Sat, 02 Aug 2025 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIt-0001B4-4X
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:20 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIr-00018Q-HH
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:14 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6199e7dea32so180531eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175972; x=1754780772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yEeq0RZk/l844ggMKjsps45XK8zy1/6p2Ssn5uBtVg=;
 b=AoYRrYPRZNspzlYDI0tbFfbuIC9Ws1Lcrv3zaeEpL4hZfngFdqIqjnB9WDf/hCxZGe
 5CLLWG1ZAb1kTx4jiddsfkzed3aO8Qzf5DpVxAzJV7JJ+/M7k1vhR7VEeyVrsryety92
 P7RljgOr21AbacTaVp/V33LmWfmU5ClS6mcc7fy814qE+EUE6UCtriDWgBPyIdXKNQXc
 g3UJWKfg9RvUTiW/47AQmEi3D705pIkny03LMHKWDhKe5UdI2vzro1FRNDqlQJEQteIg
 A2+I3zcEzDn7BMOm+cn9pz0zTnmYcfAvNNbcQk1I6s6jBnrKpz7d0f+xl/d03qkzYaBm
 Amag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175972; x=1754780772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yEeq0RZk/l844ggMKjsps45XK8zy1/6p2Ssn5uBtVg=;
 b=SOqyCBiN8BPdDie49vED5+DSBIIaVsM8OsoCWUfKKmpx2WCWRrByIbDc06UxfGNJ1r
 nKuUMxeut6lfJ5EpBhBLtXS/V4my+oQ8RQRhGYRxYGCj6zGdb0u+HaojOIdwanqZkV6N
 tB5xHzzX69PdYwyym5se+jXMu1FuiJLvkqPFXhu+9tkIrBIyvuUvQMuBtIsIux441Jzt
 tkrGM0DDnG+Au2qnM/o7XavUv+uZmSX3Hg61uXTinqU2w4rhiSoFwEuLnS9kp821insP
 b6DPSG2fyKhKeLmf2YlvwGGuJGK0JJkjBHwb5E9fcQiw0J/kxrCUfHEki3kzFW9ulNJ4
 4EQA==
X-Gm-Message-State: AOJu0Yz4dOsTWFnF3WJmYZGJBMAZnzO8UmJrTsEXdWckUcGIYC0Tammn
 sAxgigvxGcGL8Dv0cS07ZLIis7pYu22fsS1JKL9/7FgGRSNLXZZX9iMj+eSV3aN3JGz0vTAhr26
 yeU4T72U=
X-Gm-Gg: ASbGnctc48AVc1JM1QAEvavtWuadu36dUooMUp8YmA1ZnSCV7Re26oi8nDk/s/KGNtT
 mHgXv02fOGs1UfqnzW725CsuBUW54pfxkSRinyhW4/z0AA9K3oqfVKKmRYLjQB49/kAqyp+FNqM
 h6tuu2PHH3FfAq23aDNcIvlpTw2lVDLRxjq93RO25spDEZMPCyNvodWfrP3DpTc4uJhjW90qlxk
 z92Pd1nlmdqqcR7Q0bJzzrm+jpA38oJdyWODV5qBzYKE+b177bZrSucWEBigeQNaz4fm01LWgCO
 zWXJ+T/aKRRMoEc4ZwPAJtOTId+kYRfiHGKmQqnUhGWgoT32rK/wRZByixP2DjbUdtmu8+hLgRh
 92jdpaNAjGIOy4kjxfgHlQhd1CMWTzca/DNiQwzigCiwNf7u/am6V
X-Google-Smtp-Source: AGHT+IF3yLGtmHyFMHDgtNzv86s+58ilmyXpPpHZsnGtG0KwDBu/SyJ3BS2qtJJkyO3Aqb5o3SWONA==
X-Received: by 2002:a05:6820:992:b0:619:950f:2413 with SMTP id
 006d021491bc7-619950f26a5mr1587641eaf.2.1754175971869; 
 Sat, 02 Aug 2025 16:06:11 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 17/95] linux-user: Move get_elf_platform to {i386,
 x86_64}/elfload.c
Date: Sun,  3 Aug 2025 09:03:41 +1000
Message-ID: <20250802230459.412251-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Move get_elf_platform to i386/elfload.c; pass in CPUState.
Create a simple get_elf_platform for x86_64.
Introduce HAVE_ELF_PLATFORM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   |  1 +
 linux-user/loader.h            |  3 +++
 linux-user/x86_64/target_elf.h |  1 +
 linux-user/elfload.c           | 18 ++----------------
 linux-user/i386/elfload.c      | 13 +++++++++++++
 linux-user/x86_64/elfload.c    |  5 +++++
 6 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 802395af3a..44dde1ac4a 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -9,5 +9,6 @@
 #define I386_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 729723cc06..44bb4cbfd3 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,5 +105,8 @@ abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
+#if defined(TARGET_I386)
+const char *get_elf_platform(CPUState *cs);
+#endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 03483bad57..498c3f7e4e 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -9,5 +9,6 @@
 #define X86_64_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7a41917b49..e6e509c0a6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -149,12 +149,12 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
+
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_PLATFORM   "x86_64"
-
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->rax = 0;
@@ -237,22 +237,8 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_386
 
-#define ELF_PLATFORM get_elf_platform()
 #define EXSTACK_DEFAULT true
 
-static const char *get_elf_platform(void)
-{
-    static char elf_platform[] = "i386";
-    int family = object_property_get_int(OBJECT(thread_cpu), "family", NULL);
-    if (family > 6) {
-        family = 6;
-    }
-    if (family >= 3) {
-        elf_platform[1] = '0' + family;
-    }
-    return elf_platform;
-}
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index f99336e73c..1b759098ca 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -14,3 +14,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    static char elf_platform[] = "i386";
+    int family = object_property_get_int(OBJECT(cs), "family", NULL);
+    if (family > 6) {
+        family = 6;
+    }
+    if (family >= 3) {
+        elf_platform[1] = '0' + family;
+    }
+    return elf_platform;
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index f99336e73c..88541ea45e 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -14,3 +14,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "x86_64";
+}
-- 
2.43.0


