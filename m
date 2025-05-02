Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyVo-0000wY-1A; Fri, 02 May 2025 18:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVl-0000vu-3c
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVi-0003p4-W8
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:36 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso397781466b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746223532; x=1746828332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFPD/i+CML80Cyv12UvhgTPOMzRlpW0E4upDexx/MGY=;
 b=zAoLxmcLyk/G3Lu6F5E6BC8G4nAgoAUF9HwzqqnOHfwAeDXjxOiPhOhHki6Mo1gNfD
 mgZLFm3W1HrkVuW/FfDZyMDaM6+l99SalbrXe8Qecxb3bZp0JCNWrzR4klt8Sh/yTXBz
 tR82GVUiuXcPwl0wxs19LdyfdEJn2/Cuwa55WOPM+wJfXbNwm9MfizZNct5M+eWYO5VH
 6Z/cMU26C3+qmdGPZ1kS++uXUOBiaIenZjZTj2vPWBDBs7wcKbZfxnmO95buyRBVEP8i
 oCslczGuq8TkKU4UVsNLXwFwg+/HHz3HSwSej7tmrbPN2VtZSpvWm6PaWh82qkerMLid
 Jj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746223532; x=1746828332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFPD/i+CML80Cyv12UvhgTPOMzRlpW0E4upDexx/MGY=;
 b=NyPGYFa0vgCcLwb/rki8C8IbpT+bsC9b8hMmPnFAcz6vqGdOnJsb2NKbvEavTkSmLq
 BR6qSzCOJ9rbvA0biMMycmdN+WqztfbdaXk2tS5N+8MgM0njW8aouc4aBmCQMRkrB5Bs
 n1T4KDAxVGJjWWlANFst5i2GKCSlBTXADRCxPN/BEegR0CW6EqPCZI3+XT3rfyn4WYDy
 MHy70dswSnR3h3fJQJr4NElx4dJCIBj9xUlcjQF/+O6P0/YhwhKWAZe21N8iqdDhwbtG
 GGZMpoffVA81qFqy2A5ueVCd92UmPgGZJtRUvGBXWU43TvIxgiAFmLIV1F4+1Xh0e7yJ
 Tk/Q==
X-Gm-Message-State: AOJu0YyNL1NVp0sTaBmJ6ABHLe5+8QslzBleXdTyURjyTBdVJBiBoG4d
 tsH+ap6Cx6pPBrjFGlM0TCWbKcXjXcB9PGrICqIR2n2iWQ+RhQUbQi1J91EzTMnToL93zHOf4/8
 C
X-Gm-Gg: ASbGncvVQTej3MTWApGKtNUSZAxHu41NXaxP+r/LAgWrdAmOlAK42aiYBb3hz1kslNX
 jsPIL3xvxBhvC/hmXmQINfFDt6IPrOAeAM3wDgrunNIdvqe1zZXGatnMHSr6Ntdy+O9XuhPGKi1
 zuX1Aao7FeeB52xKtSDhx5B89yYvCUWXm/XtEfSdDNqk5exxxPj2GDk7BYl+s6ophRRzQ/0DD51
 swK/4rwW7HOtmTu3ql5eoT/KYg6We9Arrc442jynoISUqfby0Ww/0up7a/9AGTsHXHYSzK84Shs
 vtmMMl749pCJyqIxfzcru+QhZU+lqk7F7On29Gp9dXx0KhUT7Vnl9HnqDPT9PXGgWdH881YNewF
 X8ES8PjI9wzJoWqw=
X-Google-Smtp-Source: AGHT+IEA/zf0XPJZtCcLWQkzyPjKqnDGlTuJOmoeswmLRI0qNQPbzYQ9UWDmAv3k3FW0WuHheTpLOA==
X-Received: by 2002:a17:907:daa:b0:acf:b8:f5d2 with SMTP id
 a640c23a62f3a-ad1906adf0dmr86523166b.36.1746223532566; 
 Fri, 02 May 2025 15:05:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a24a4sm104659366b.41.2025.05.02.15.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 15:05:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] semihosting/uaccess: Remove uses of target_ulong type
Date: Sat,  3 May 2025 00:05:23 +0200
Message-ID: <20250502220524.81548-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502220524.81548-1-philmd@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Replace target_ulong by vaddr or size_t types to match
cpu_memory_rw_debug() prototype in "exec/cpu-common.h":

  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                          void *ptr, size_t len,
                          bool is_write);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 6bc90b12d6f..2093a498277 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -15,9 +15,9 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/tswap.h"
 #include "exec/page-protection.h"
+#include "exec/vaddr.h"
 
 /**
  * get_user_u64:
@@ -89,8 +89,8 @@
  *
  * The returned pointer should be freed using uaccess_unlock_user().
  */
-void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
-                        target_ulong len, bool copy);
+void *uaccess_lock_user(CPUArchState *env, vaddr addr,
+                        size_t len, bool copy);
 /**
  * lock_user:
  *
@@ -103,7 +103,7 @@ void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
  *
  * The returned string should be freed using uaccess_unlock_user().
  */
-char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
+char *uaccess_lock_user_string(CPUArchState *env, vaddr addr);
 /**
  * uaccess_lock_user_string:
  *
@@ -112,10 +112,10 @@ char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
 #define lock_user_string(p) uaccess_lock_user_string(env, p)
 
 void uaccess_unlock_user(CPUArchState *env, void *p,
-                         target_ulong addr, target_ulong len);
+                         vaddr addr, size_t len);
 #define unlock_user(s, args, len) uaccess_unlock_user(env, s, args, len)
 
-ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr);
+ssize_t uaccess_strlen_user(CPUArchState *env, vaddr addr);
 #define target_strlen(p) uaccess_strlen_user(env, p)
 
 #endif /* SEMIHOSTING_SOFTMMU_UACCESS_H */
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 4554844e15b..ff944d8c2f7 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -14,8 +14,8 @@
 #include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
 
-void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
-                        target_ulong len, bool copy)
+void *uaccess_lock_user(CPUArchState *env, vaddr addr,
+                        size_t len, bool copy)
 {
     void *p = malloc(len);
     if (p && copy) {
@@ -27,7 +27,7 @@ void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
     return p;
 }
 
-ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
+ssize_t uaccess_strlen_user(CPUArchState *env, vaddr addr)
 {
     int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     size_t len = 0;
@@ -75,7 +75,7 @@ ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
     }
 }
 
-char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr)
+char *uaccess_lock_user_string(CPUArchState *env, vaddr addr)
 {
     ssize_t len = uaccess_strlen_user(env, addr);
     if (len < 0) {
@@ -85,7 +85,7 @@ char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr)
 }
 
 void uaccess_unlock_user(CPUArchState *env, void *p,
-                         target_ulong addr, target_ulong len)
+                         vaddr addr, size_t len)
 {
     if (len) {
         cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
-- 
2.47.1


