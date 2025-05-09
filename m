Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLa8-0007KZ-VB; Fri, 09 May 2025 07:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLZx-00076A-0l
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:45 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLZv-0000iz-0c
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:44 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30ac5cc0df4so2667373a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788860; x=1747393660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3QDNycj2cfcdLF6s/SvwTLO4ogOTisZBN0TIphy6t0=;
 b=IvFWKu8naz4v7ubeXMbeuGvwjh3Xc5x3EkiaBnUh2pFWgvJwBbgi1ilSopEbbh5MCl
 qN9T19bWV88+I6fcP05F2jcLo2kFbmYFWB1azp+9ty+WkvGGnclHkD4K+VaTC+Y1JRVq
 jUawTmd93HzA4e8kez7n51w9CFTsmnpx/NWxp0OjAKus70tQDwtqKi6cX7iXrxluIOn0
 repFOPIpSHGR36aB/fN6hw8DugUQWSmWblmYA1z2E6pYfBciVB9plQOu2wKx1ygglnkd
 TOkYKsSAKZmKjdFIMua8yk1VKAj4DMsqD7i3YSs2mffyak+dnuOtukIHFryD7ZC/66jj
 jolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788860; x=1747393660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3QDNycj2cfcdLF6s/SvwTLO4ogOTisZBN0TIphy6t0=;
 b=s3lWGFFUQcFv/E23v5fyBFYkPhl4X3B/eFHBrLlbs3K+G3GCMoHJLZfq4zRAmC6prC
 onNfwBYRjD/vDXb440a6WQJQ6qkvu1w/JEX9DMSenUsgoYzjd/bqJtfhckZlgEJuafRv
 Xs6mEmvBcZrOdV1z8mQIdH9KDbdsIUC4b+QW1tWj37O8BbBXVVHBH/xOaIp3RJRGPGO5
 wC7gyLgHou0UnfPakWz1A1A+1Ztv543HwXAUQnHFv9IMhibcR5Tesk+7bG6L4EaCGTpe
 9Exk1almO+m5AXb1/dgw3SVKzqrD+HLKN4oTn0wc+7O22dMTd2dF5laigl2pkKEcBFga
 PqEw==
X-Gm-Message-State: AOJu0Yzxg3WfpxPLZGaVLXvTQwIiGqHhptcq0i0eVVBE/1LtXsBEh3LF
 ugaiFY+haiidOGHgefAHQCFkvRMYT+UL7YEjmYFuwDGXtR3PIfmmy1GC//XBDDhiGze8Asr9Dvm
 zbFQ=
X-Gm-Gg: ASbGncutV2EzVrdX5esQRqR6jBWAyOJ+QlrNGwMWn4UZB9gD2hjr9nOlzxcjfGSTxa5
 KXzufmBsxWuB04Xj7TUksSP5KA3jnWRyA9s1Le5Ye3Lqt8+gF65yT4R0G1fV+JaneyQ6LZ/RHsN
 hi11tguExLuZLAqZq9SogUVOKcGqZeXdwWIt9rEO3lEDUj6+yvFj1EfrEtxCYAh8Be5EjFdnnnu
 C+urf4oIMkgpoupCRswCP0M5MwbMzx4uAgoHQMlDjDhTXYcAFDb+drQo/Y8QCdajsV7lBo2rzL1
 j7KOOtZqX9NkqgzqDZkWpIvrjld3KatJgSrQOboPdqmL/aIh9ou1IYDdnaM9TI1rPcxuV0iPx4r
 tXcznliHz1l+DpNk=
X-Google-Smtp-Source: AGHT+IHGv2wiwA/+WsvSv5j64C5TuTYfj4RbZv5gj7GDWVw8flDbAa8iVJZ/BRKWMAaYh7tkcQ3x2Q==
X-Received: by 2002:a17:90b:164f:b0:30a:4d18:c71b with SMTP id
 98e67ed59e1d1-30c3d3eb986mr4836926a91.20.1746788860455; 
 Fri, 09 May 2025 04:07:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4fe2248sm4170871a91.35.2025.05.09.04.07.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 May 2025 04:07:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] semihosting/uaccess: Remove uses of target_ulong type
Date: Fri,  9 May 2025 13:07:19 +0200
Message-ID: <20250509110721.90447-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250509110721.90447-1-philmd@linaro.org>
References: <20250509110721.90447-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1030.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


