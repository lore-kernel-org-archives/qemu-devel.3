Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C941094474
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x5t-0006Pu-3X; Sat, 21 Mar 2026 10:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5n-0006OL-Ht
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:19 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5k-0003mk-I6
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82c20b9f989so550065b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102455; x=1774707255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3Z5wTR6rdcOkAJ261tGDFFGrSwYBche8sRudhARne8=;
 b=hRBChbIhVC6z6krywTG1drbdFeo3ryQ0IPDf20w4ED+ewPNJGM0hqHP2MPvvrbTTIe
 hJ1fEqNoksb9llR+GE20KigYjwa1YWHgIyMIG+HgsABUBMPymlspFMebugF1e1E+ZIFZ
 Aom9Wlnef8zdeu0a3Y6n1a+giBzNNyk4wDZZpk7QxookkGI4pAjectAdQH0SMz5CvcuG
 BTxsDTegxUseniwegtk4xx4tAqcfG84fHsiYUzV1Euzutu6m6xlnayFYwa8X7c3Mfo26
 iqwgJJUai70mTTSXi5HOBuqqNKtbDUad4clOFM3Xviuw6DFdr4DEEcCWTE1FvxL9L6aU
 FJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102455; x=1774707255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3Z5wTR6rdcOkAJ261tGDFFGrSwYBche8sRudhARne8=;
 b=jO/uVpKGVwZ7Uksl8KZ46z32muFtJlJ6J2eUNdHPkdkWyspdqiIrzsPcfIFhmjsZzG
 fKVmJ55Vzjx7OP/2qBjTdbCkMnqMQ/vRSDUWnH1T0M5SUPCpGpx5UhUZJQTqUMJYvkYu
 A3j8wgWrAtATuOip8FkfWXYo7ZCymSExVRuMyad1hQhngBSYcE0xPKdq0AQlx0FwC5Or
 7+s+6IDYed8yc7U1joTBJKSX1/RZcuJWlbgQjacRQYMgrp69GkkXpIW5gBEDW3NQZ1NB
 nNoKqKmKMqf+CAdicBRMXITOUCgHk3Q1G+Vezt4xm1a/+aH693YA5Rd2FiWqO19yAXmz
 JDPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR+bfPplf6P290x/MSXvUG0Su6Wae80gFLMcJa1Rsi3uz10LV5fK9B3uMa39rST4NFdYVTgmdvvKYA@nongnu.org
X-Gm-Message-State: AOJu0YynTe/KmZVnIoCeWgCXDyJH2DEQ6v7wcV82usEJxH4NJnKfkAc1
 r84WLNFeBKTveiTRfPAcHIFMBHvB6HZAw2x0+m4RPqInLyJFsbpYycmn7uLyuw==
X-Gm-Gg: ATEYQzzLQsD2Psp8ci+oBDCTG2kIdDeP3ikjNqlwsejkYwd6797hY3GOFPJFRTCFFIA
 SQyV0n38rynJJPfwL3ER5+UbcfkuzVlGWBeBIG7y90PqxPveKqumjDnteJmJ8ySLz8T1XIYjU17
 9QpHlkMUe/fDBoiWBC9W54iDA7H4mIiZKb62VQkyYBAUoW0enyhAFHKqN/RUhlXn+LGxVDlFaZ5
 6hEVWJjjs2UYNfRXLnhzbyLm3KriAq4q3cmI/us5bYEUhKzVOqvRQlibkhh6uzEC69yyyDEnmLe
 wFu3YuH3TLWjJl3s6+/kbvNPkC4OpklM4XAS6t0ChZMhhbuI0XVz7h9M4eGrGiOE6W188OS6pMk
 WidPeTaz3MW93SxMw3inttiZ3Q3u5sxIbXKnH6KlCNdXR6a718wGwsftR5f3tfyTpX+m+bsiolU
 +LsFMHrch98k6hpk7iTlNlv0VkNsRynm1hOBnsxLL3vj9Sh222yapqT1peflBVV1E4tir3
X-Received: by 2002:a05:6a00:1707:b0:80a:fc3c:f839 with SMTP id
 d2e1a72fcca58-82a8c3961f6mr5449835b3a.49.1774102455172; 
 Sat, 21 Mar 2026 07:14:15 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 2/5] linux-user/riscv: Allow restore_sigcontext to return
 error
Date: Sun, 22 Mar 2026 00:13:40 +1000
Message-ID: <20260321141345.599105-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Linux can return error from restore_sigcontext in some conditions, which
forces a SIGSEGV. Plumb through this error handling which will be used
by the next change.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 22b1b8149f..ece276f85f 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -145,7 +145,7 @@ badframe:
     force_sig(TARGET_SIGSEGV);
 }
 
-static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
+static bool restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 {
     int i;
 
@@ -161,9 +161,11 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
     uint32_t fcsr;
     __get_user(fcsr, &sc->fcsr);
     riscv_csr_write(env, CSR_FCSR, fcsr);
+
+    return true;
 }
 
-static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
+static bool restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
 {
     sigset_t blocked;
     target_sigset_t target_set;
@@ -177,7 +179,7 @@ static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
     target_to_host_sigset_internal(&blocked, &target_set);
     set_sigmask(&blocked);
 
-    restore_sigcontext(env, &uc->uc_mcontext);
+    return restore_sigcontext(env, &uc->uc_mcontext);
 }
 
 long do_rt_sigreturn(CPURISCVState *env)
@@ -191,7 +193,10 @@ long do_rt_sigreturn(CPURISCVState *env)
         goto badframe;
     }
 
-    restore_ucontext(env, &frame->uc);
+    if (!restore_ucontext(env, &frame->uc)) {
+        goto badframe;
+    }
+
     target_restore_altstack(&frame->uc.uc_stack, env);
 
     unlock_user_struct(frame, frame_addr, 0);
-- 
2.51.0


