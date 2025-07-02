Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04327C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2b-00009O-FQ; Wed, 02 Jul 2025 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2U-0008VG-QV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2P-0002p3-V0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so45122375e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453400; x=1752058200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRCp3ySVNCc5vKTsGg2A8ACZ7tFKQgIdG5HQy6KJhQ4=;
 b=YebtxBMcUBN9Hz2MWOVDB4hAOW2DdFkXmj0wYnu48Hj9pLrWCNuiilFNuO0ScpeYkl
 Xil2j/5LONCrN+4xPknMa8AuPv4WT8IrrsvRaKO64kxN/1YCW1MF7TUs+5urLyF0GLea
 J+xG7X7nxGXnxq5XM67sXWYqqc1dGM3fLrVZPEHfpctKDQhp2iEdjD9pZszKE4i3+LRe
 5Qzt5CBvEia5vfs66MFD0nK1Hd3N6mpr0qRh0Eouh31OwCd9vK20rI24g29tsQQccQ1t
 NiP7WcZkyoLiWiDSWpirZj28H1IUhleOBx61l+c8yOI32oxYHK3ki6ipS8p4LtkK2QKn
 9cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453400; x=1752058200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRCp3ySVNCc5vKTsGg2A8ACZ7tFKQgIdG5HQy6KJhQ4=;
 b=goXJPQdlv3f4DYES+Q4gn0BCiAWrfiyp+IEmYLGGYjqMMLOuGymTDoS0Z3dscq6Mvi
 CVCQl2KdGVDrbDa4UzvNdZZGWxgW+Knc+dw5IU1FI3sxkoLHsN/lhPoewBTXcmVU6Fxi
 GBCV/AMB0o5uX7S2yNT1507IM1Naee/VmIXV1me0v9c2P9H1mvJRN9pNqCiOB6vPXmMg
 MI/JILLSwgft9qxbMlK8mpAl2DUJ0aXz6NnCi/cEBBvKRSKd2T+GyyvpZ+wNI98oaB+S
 GT1wTuhSInyd7egC3o+OSazM2McrtE0zYFcBPEqlMWUz34WaafvwHZiT6Bgtt3V9JYPy
 1Big==
X-Gm-Message-State: AOJu0YxeEitiGgi+C0x1heof55VdY7tcM5eNs4znT5HWJVa4R5zmA31U
 a0aPgP9HF1RWlxmMuwB/+Na9xy3xEufK9z7KVx/PGEJd0TgppThLghekRR41SpqRSkY=
X-Gm-Gg: ASbGncvq53ZUNZ8MJ5tD/qI1NJYnBC9JRDiZd6eDf9OabESkgJ2bu6nYQ7nMKgZbXx8
 bSPntBQ+TM4rb0GFwj+merPf3hMJ3vaZcxhhhX3bdcIFbbU8t2oRh35sgI945frz+7dC+r7U47u
 Lmq4n3cEJAfAxJpClrruFsu9HHCAXM5rKFml/A3UGJ7SBmJVGwv83ZjDzJkx76H7kg+viPdMC8b
 9rN+B9mwqaV/rm4SRbPjiGSiLaYtgWNjDZy//AFnzXeBgaD8T35dYinwPQVjTNCUhMHqvZaWzHL
 yKO2mVKWynITVavKFl5ci/tNQUrbntMmgOEpl/rpOxBGucPG2pSELF71HJkrENg=
X-Google-Smtp-Source: AGHT+IFyV3qq2lI5cmScOe11u7GU6tNj5UEGI87FuPg4XOip5rEQzoOALvCTExHwbYhpyvcCOFFuRQ==
X-Received: by 2002:a05:6000:188c:b0:3a5:2653:7322 with SMTP id
 ffacd0b85a97d-3b1fdc2249amr1687289f8f.3.1751453400014; 
 Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e6f74sm15718218f8f.3.2025.07.02.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:49:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 123595F8D7;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/15] semihosting/uaccess: Remove uses of target_ulong type
Date: Wed,  2 Jul 2025 11:49:43 +0100
Message-ID: <20250702104955.3778269-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace target_ulong by vaddr or size_t types to match
cpu_memory_rw_debug() prototype in "exec/cpu-common.h":

 >  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 >                          void *ptr, size_t len,
 >                          bool is_write);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250526095213.14113-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-4-alex.bennee@linaro.org>

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 6bc90b12d6..2093a49827 100644
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
index 4554844e15..ff944d8c2f 100644
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
2.47.2


