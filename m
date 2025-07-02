Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173F2C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwZ-0006fw-H1; Wed, 02 Jul 2025 06:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwT-0006eO-GR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:53 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwJ-0001Iw-My
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:52 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae3cd8fdd77so16555866b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453021; x=1752057821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRCp3ySVNCc5vKTsGg2A8ACZ7tFKQgIdG5HQy6KJhQ4=;
 b=rHa0HiIv7FjYuHQCV2TW3sXvjozR8GoNo5NR1srXsqB4yL++MiXIIw5MjJ63mKqiPl
 6uFUmIhhlV5qme/MoNOkNMTzX+gTClHx8GXV24kPquxOn92FOC0/u+Du5eH+N+p1NXKo
 o8Hn5uioKp3UQgvkO8UHm6N3h15SjKPtrfhuEvQcSyWo8Zi+rUX0NPDeXkIj/mp2da+i
 d2yP7bscDvCz8IKDDzlXDs9A7WTOa7W7l7O2xoC91XFyLEcZGCzRDkt/IXvKwCNKHvcO
 c8+JSdzo8dTt7wtusnvLWhgdV0vtfKJU+dFJXbHXB4XYfTgbHOMmTOsdwutIM9zAoDzH
 oHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453021; x=1752057821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRCp3ySVNCc5vKTsGg2A8ACZ7tFKQgIdG5HQy6KJhQ4=;
 b=tslN/PLf13rrPZzKK4OfGonMLZ/UV70LzkQUUZlymhf7nUXegL91bnCQhsnjbTTmYJ
 fcouFalx//9iRUt0tYxuUxaiTuCuvsRBMp3iPrjAmPBe68DOLq69N0Yulf8IFq09Ll4x
 WtmuYnwsSS40zNr+NKgFqdqt14gkqKICSMu/ociH1cPqVsLkTDWUpK3rbxMTlbTmCKoH
 ICcZ3SCi3Dp0O7ABU0ai9lnw5YVrcWpdXnbjchAQtBZGmBoFRgcA4VWHG+FCw4/lnXzS
 I2bgmHCByzzhnNE711i965SWPg8wCWBDkEqGeJKuTRcm9npk2qazghSLHUb7EBD8saLC
 NWag==
X-Gm-Message-State: AOJu0Yxnp+zGe9Aj9PSj4Hcu4GeNFNmEKprx54iA56lqIieusNu4Jirb
 4+ZkpycKhcCn1qE9Y3o57kD66uEB4ZZbhWCtYvalMLUhbgAucV2+3ryK/DhT9nJG9wg=
X-Gm-Gg: ASbGncu1lAjARqMh1luHcaG1oIMESWO6yK+dy3vVGlCj/L1wWDPvJFoBoFVZp25sg2R
 tNm7ipod3VuTzz58OHudzNC/8r38cFrFvgBDg12sTH6yTkwtTyXqqfSB966MBir996rBc3rJwrS
 5GDpD8Tl6ob3EBZFDsh95BGhjPp+qAPbyWJoTmXMO1Uy+/0JGqYiyy7SMixfY0kffHCPIK8bmyz
 dglphjO/1K7CNxwM2ENYy6XFhwiy5bSLAvactqsF7IBqwteAVXnThr2jNYOPlDtO9W/b+RFO5YC
 kLB4t7Bo1Y2rqxdlCmoOzSLLfgNiN2uPPXToR873D3Ctvs6EPcZxWu/tVbyHpQw=
X-Google-Smtp-Source: AGHT+IHdgLSlbvcgbAwAFGmSlhOmB1J/6bXqPJe3eb2nEDYCtD3AyNrAwV3YwOtXV/cdiskkjN64nA==
X-Received: by 2002:a17:906:4fc7:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-ae3c2ca3ebamr212404666b.47.1751453021552; 
 Wed, 02 Jul 2025 03:43:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353ca2edcsm1039338966b.180.2025.07.02.03.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CD9F5F8D7;
 Wed, 02 Jul 2025 11:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/15] semihosting/uaccess: Remove uses of target_ulong type
Date: Wed,  2 Jul 2025 11:43:24 +0100
Message-ID: <20250702104336.3775206-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


