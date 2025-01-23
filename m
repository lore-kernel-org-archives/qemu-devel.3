Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F84C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Cv-0006Co-E4; Thu, 23 Jan 2025 16:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Cc-0005TO-OG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:38 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Cb-0002vX-5L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:30 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1055329f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669447; x=1738274247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tD14boF6dvwaWjMp/PPnzVj7/mx2oVtmk8yCDrx4k5w=;
 b=gOcW8hXxo14Z8UGAeDg456xJDs+77hBiN2N6Z5P7bFVR8CBVqNQYzmSNKDFtaANeYQ
 vmasrmIxM5Bunk++tWPhJU4jHjq8VOfw6mBWuhumknWn+B9fWhqPXyyj4NgN4MG3Rb2G
 43QGinRo51B2FTxwufFzIKYuZO+jP1AvcbpbDrr3+awXj95Qmnh01kRYUpmlT370A+jn
 6h/JjCMXpGW8VQ3VNrrXZunY8py9rX/RYmNk9ZUJXdZ5v920T+0lHiRpGUnkvBWdsE2n
 T5s8XcOWFIDArpFeTzhFOBjbWHtfXFlLbSsR4W8FBK3t/qyy3jlKjryvZ7SvL/yeRfBc
 +Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669447; x=1738274247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tD14boF6dvwaWjMp/PPnzVj7/mx2oVtmk8yCDrx4k5w=;
 b=Z+wy1Q6/WNSROyiRUvF8F+MEDO4HYMOlLhkbVFDEHG86K1q+w2P+H0paEhRJJYekyf
 FSdNPmHALMgHMoIg8mmaor2gLrYW11/3lauTm4d1RbY43hgacYsrrs/72yjg6jRmH0cN
 7JtwmAO5VO2ig0dnxSduMGIeZyvSGQVnQLJTTdN7eQbQxAMuNougj2WzJmEbTh4Q6e9m
 cAXTD3UeWGUJKGQkxHHTBQ3qK2KAvlrqbfuHD13r5eFmQ9BkOAPu/LIVXzi49xId5bPm
 UsDmsLp2cTr1cIvCu3DYMLdkr6kxzIdV9MgnIe+McXqcVVtkwfY0yTx/lRhltQ3HrZIA
 v31A==
X-Gm-Message-State: AOJu0YxGcDVRBSJzX5AG4GsLBGngmFfrXEB5UYRptgbkQ76pYejcJ8wy
 QCIz2mW9jO9xLv6ErL7Kh5120zrD7t+lO1G2ScfSdkUrDiBvRbLAPJ9GH1l3Iet3hzFswUqtcJd
 2Vr4=
X-Gm-Gg: ASbGncuNU+wWzl21znDMfnGV5QGORTAE3mkFI/07dqZFB/9Bp6aCStdzsu1tb5U3rqs
 epibzuHV9USNIP2lQyHmF9M+RJwzU6ZPp2gNxdMf7bqYW7jjnkLIoyBh+eDqCsAdQirIqen2nDR
 mU/QIDvM2SbWg5TKtplnhMc0nv1iFv+Xqu96iiCLX2G0zCST48pfGNERVThbmtNbl0h2cBDucSu
 8rIbHftE+zOXaOmzWyZWOkzlV9RBYMyteF7dQYfZdlkSG7MXjg5tAznBNxkqpJSFw8qLYYHA87Z
 /sxfGaIsAqCpZ8rocP2kM/dJE1QTHjAOtvG5K3L0zd2mSl0QJ+RZhlk=
X-Google-Smtp-Source: AGHT+IEpclplO8xXrWMZOuLiWhOLETM1wTWoOMWmrt0VZkx+BgHqSUEj6wYu+9Jmu//EElruFB4U4Q==
X-Received: by 2002:a05:6000:144d:b0:385:e01b:7df5 with SMTP id
 ffacd0b85a97d-38bf565c2d0mr29569150f8f.14.1737669446797; 
 Thu, 23 Jan 2025 13:57:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6e2sm802184f8f.23.2025.01.23.13.57.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/15] target/ppc: Restrict ATTN helper to TCG
Date: Thu, 23 Jan 2025 22:56:09 +0100
Message-ID: <20250123215609.30432-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Move helper_attn() to tcg-excp_helper.c and make
raise_exception_err() static.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h             |  2 --
 target/ppc/excp_helper.c     | 20 --------------------
 target/ppc/tcg-excp_helper.c | 13 ++++++++++++-
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ca5bbd263cb..35b56368eac 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2752,8 +2752,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 }
 #endif
 
-G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
-                                    uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
                                        uint32_t error_code, uintptr_t raddr);
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2d4d47ee384..eedfa2d1de1 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -31,11 +31,6 @@
 
 #include "trace.h"
 
-#ifdef CONFIG_TCG
-#include "exec/helper-proto.h"
-#include "exec/cpu_ldst.h"
-#endif
-
 /*****************************************************************************/
 /* Exception processing */
 #ifndef CONFIG_USER_ONLY
@@ -400,21 +395,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
-#ifdef CONFIG_TCG
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-void helper_attn(CPUPPCState *env)
-{
-    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
-    if ((*env->check_attn)(env)) {
-        powerpc_checkstop(env, "host executed attn");
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
-                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
-    }
-}
-#endif
-#endif /* CONFIG_TCG */
-
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 072a7fd0947..b6765835683 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -56,7 +56,7 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 
 #ifndef CONFIG_USER_ONLY
 
-void raise_exception_err(CPUPPCState *env, uint32_t exception,
+static G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                            uint32_t error_code)
 {
     raise_exception_err_ra(env, exception, error_code, 0);
@@ -544,6 +544,17 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
     ppc_maybe_interrupt(env);
 }
 
+void helper_attn(CPUPPCState *env)
+{
+    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
+    if ((*env->check_attn)(env)) {
+        powerpc_checkstop(env, "host executed attn");
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+
 #endif /* TARGET_PPC64 */
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
-- 
2.47.1


