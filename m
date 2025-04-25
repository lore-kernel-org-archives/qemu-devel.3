Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF63DC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ktj-0001iz-GL; Fri, 25 Apr 2025 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Kte-0001fQ-Vt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8KtZ-0002p9-Mw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso2347731b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594596; x=1746199396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+F3AGtcq0LBY9UzRHTX0Z+/0ocsWmI8LW9rY6+lCBw=;
 b=PXvBxxKfIyF8K24W4IVUvymO0X8dhTAPpKItVUU549tV+zdy6NJI5MnENllzGxgKNU
 Ll7X9idmYUg2GjdiBH4ZDg/gk1N+GWPqL+J+YD7pwCdH57mz4WhsNqpNKaWTPhMFQyjF
 uSjnhmCKeAVAiqiYKh6CEt14vBrtWMH9wKKaQI/Q2QLu0yVnC5VjzpNZJwdKsPqkvtAG
 jjMXR7K4tysv4BEkkgjOfJcr63aZmT9XWRHK5XoDIqDqhxO6FFTY5i5WwQ3Z6squtKUe
 nkKXtozimFOK7rLNL8XOWIS4500/Rsjl7G8eBICc98nlIMk8ZZd9yi54xLcoIf7SMnk5
 B7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594596; x=1746199396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+F3AGtcq0LBY9UzRHTX0Z+/0ocsWmI8LW9rY6+lCBw=;
 b=j/Fev1jDAzqp39fVa0EdvmvP9UMOgK2/O9K9yh3SzgyxTVeT//iSZarwTgZs/fKzmJ
 zQS7l95sN0TXkOPoWSl9IZQAIoaz7Z1CGkcdGSzqNnwinaO8/np6nps4zqiXT9Ec/uTb
 zJn2O7gObcSwhnJiGle8XVXTSuXvYRLMpLI4AyelguCT1MUVDC1ruME8usjtuFm2/2LZ
 Rxj4tyJvijZApglzK4ExCOYHQLAQ7xOyjK1XzRSdrkSJI6KFhYkraXV3zslr2eTSY8eq
 TkjqpnBRbjlzVSiIgwZRPM65RUnsK+QdUD2A35sbeVxzrjEZD/nXF/XznU26FFR6P0bZ
 dosQ==
X-Gm-Message-State: AOJu0Ywd1/CYaEhqPHN9eFSW8fQ3Ad9qRjAx5oMSk60TXMR/W+/9d6B/
 covsJBqlbReJw+OJLBW0zwiEH8JxXUh4lpLB69pLSFmK4lYiyme/UxaNh20UEmwQswQkk2XPHeM
 B
X-Gm-Gg: ASbGncv0lZCNawEbbt6zM3BOTYPctaBc37QocMF85/g/CqG1SeTE21Sd4cn8DPzR1/4
 04m6VhdO06k/29e/esHBrMPl5SeGqmhCEPDDXiJMVbGoiMNU8LokLqHxFxjqt1ygOg8Xx/GrCgv
 qHlDnP72QAIu4imh83/1QQCxla3MuUONeyQtbrPeZNniIWCD+gFHJ2JfQ3UWCNeE+Sb8AS6Duox
 dYqf3WG8kSWMiFAeXcDMhzIm++Mb4Vc48nXYD8fPr2djZmg0y6bWKq7wI8SFm6tQVOuEZ3/P1ZX
 2cCUHKn31IAmt6qruxVxCnCw9EDlrj1x8fGXO9Vs+NJj+XHJgu/F5Z4eeF+b41t+CCyijPXme0A
 =
X-Google-Smtp-Source: AGHT+IEzDeX2afsNRb2mmlhjGNU6//Q1hDLyc7GBG1Nt17zFsrhyf6eGBE3X7HY5rwtFxMMCXB0MiA==
X-Received: by 2002:a05:6a00:b84:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-73fd73c7ff1mr3260845b3a.11.1745594596099; 
 Fri, 25 Apr 2025 08:23:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 4/7] target/riscv: Pass ra to riscv_csrrw
Date: Fri, 25 Apr 2025 08:23:08 -0700
Message-ID: <20250425152311.804338-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h       | 8 ++++----
 hw/riscv/riscv_hart.c    | 2 +-
 target/riscv/csr.c       | 8 ++++----
 target/riscv/op_helper.c | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4d41a66d72..2c0524d0be 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -816,8 +816,8 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value,
-                           target_ulong new_value, target_ulong write_mask);
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra);
 RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
                                  target_ulong *ret_value,
                                  target_ulong new_value,
@@ -826,13 +826,13 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
 static inline void riscv_csr_write(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
 }
 
 static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val = 0;
-    riscv_csrrw(env, csrno, &val, 0, 0);
+    riscv_csrrw(env, csrno, &val, 0, 0, 0);
     return val;
 }
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index a55d156668..2ebbf41b18 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -72,7 +72,7 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
         ret = riscv_csrr(env, csrno, (target_ulong *)val);
     } else if (strcmp(cmd, "set_csr") == 0) {
         ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
-                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
     }
 
     g_assert(ret == RISCV_EXCP_NONE);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d62d1aaaee..097640e25d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5574,15 +5574,15 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value,
-                           target_ulong new_value, target_ulong write_mask)
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra)
 {
     RISCVException ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, 0);
+    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, ra);
 }
 
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
@@ -5704,7 +5704,7 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
     if (!write_mask) {
         ret = riscv_csrr(env, csrno, ret_value);
     } else {
-        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+        ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask, 0);
     }
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5b0db2c45a..aee16e2e3a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -71,7 +71,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
 void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
 {
     target_ulong mask = env->xl == MXL_RV32 ? UINT32_MAX : (target_ulong)-1;
-    RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask);
+    RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -82,7 +82,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
                           target_ulong src, target_ulong write_mask)
 {
     target_ulong val = 0;
-    RISCVException ret = riscv_csrrw(env, csr, &val, src, write_mask);
+    RISCVException ret = riscv_csrrw(env, csr, &val, src, write_mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
-- 
2.43.0


