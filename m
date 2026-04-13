Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69E7F34C4B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGEG-00036I-If; Mon, 13 Apr 2026 08:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wCFu5-0007Kb-1z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:56:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wCFu2-00058L-KX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 07:56:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so69274295e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776081387; x=1776686187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A1TiISkTO3j+HxWAc+L4J+fKzG1mPw3rd5YD4ODQi1o=;
 b=nGzloVa8t2GdNz6Kx3pSZL48ptAAGk0DmZkzMYfIYbp00+Ea0qm68idRn+7muNb1a0
 klTtbVUq50xLWy0lgnQOSJOh2P2imMUWC2CVLVXqDSPmEr6Q29LXTm7Pb9a49BGuaUO5
 og2+UBX/7oRtGA/hDiw95QDYxOC+pG3X4T5S7Ts2fBYAmyaVLwaPdt6OVxPD5teaVLbt
 sKuz3H2Iv3k8xvshl1vMlKZN4KSliBrdu18CVG+Q4+BB+MEm/PnDov+6CQEUfMHDn4jk
 hB0lx2jo8djeKieAeMp4ay8Wdk9CGQmVdIPvevqH/pMCaS6t2XQZ6PL2xAzlIgLrnBaM
 9M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776081387; x=1776686187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1TiISkTO3j+HxWAc+L4J+fKzG1mPw3rd5YD4ODQi1o=;
 b=tMovIgsR2xr567lei86iovEuAfgB0v8K3uPKXf34ULo4twUZpViRxGSt2kOPNftuNb
 Nji8ZCtsWcpLJohrzrkZUZYPD6/kdqjiiVw1kWqz+w4VIAL6Lz8DN9ZqNwdfhd8QvPWg
 cXwuleeWD1kBFJb+2Yn2TSSSiSzC4KPl62PNZ10BdsiQz75u+agsZGkboE/22u/ndPUG
 4jRBKRv5vZkCvGrf5V3ML5uLxIvQeGM0kblpThwsheYQFLCmTzHaikh5Uwx9zpmpJ5Hy
 5oybQTJqxjVpjOpLj+rnu0Z+fbRXR8PTsKHpYtkOIxQxTuwuGY7XugHD6WP3r/VjEGBL
 i4Aw==
X-Gm-Message-State: AOJu0YzGsyA93llEdBn7frROW3f0Ch8FyMsleMZEWa4QZBIt2pkih8UB
 4KWSpLnh5p3XG/bC9BkjY3/ZmS7wE4Olu0jnXXNUQf4Qj5jPqMgNxDYzjT1rj7bPYTw=
X-Gm-Gg: AeBDievLIkg/yfsa9Xgsmo/v4UXQsyrzVhOexltZlUTDgz5lJHF11399IoXlFg8R5UD
 M+BaorFNj/hrym3xOeOcIaIcW5nOEFnOeu2TqbljjT1ri3/L/CLtcECLqVasNL2tpwXDS9KvSoM
 TGMJgGMfYXLlVdgjyz6sVZT15lvlDuJg0wzTCvNCgdjKy+BGU8J1tUI9LSL5rgt4qnJWdaPMiiG
 H5LrGBWknte1DqxF3qqqV/FP+04krte0yRDiIxobmmKYAHP27qLJHOmF0UKWFAa+flwosz4A2tZ
 phhqLtT/AmpbYkxpARI1+SuUJo/HpO1N0O+4dOZcjm7ccdcHCWjGEWOUQ4alkH+MwrV2v1r354z
 JgRBviCKvDPzkuLg34IBTnv6ATFO4m5MTbhhGqUJjtTAS5t30gc3zkfJbkfBD/c51ktkj9KSoQo
 k1oC+iK0XTIHv+o1ZaMJpyoGxqdWR3K8yEZdxTqMTw9cd1RKNQlIha7bTvEj3q6aZt3v1rG4Afw
 CbBXyEa
X-Received: by 2002:a05:600c:c0da:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-488d685c12dmr152577755e9.19.1776081386441; 
 Mon, 13 Apr 2026 04:56:26 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-229-187.tugraz.at.
 [129.27.229.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d97c65sm95788215e9.6.2026.04.13.04.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:56:26 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: fix missing PF_INSTR in SIGSEGV context
Date: Mon, 13 Apr 2026 13:56:22 +0200
Message-ID: <20260413115622.160212-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:17:20 -0400
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

When running linux-user emulation, the SIGSEGV handler does not
correctly set the 4th bit (PF_INSTR) in the error_code variable of
the context argument (context->uc_mcontext.gregs[REG_ERR]).

Because this bit is never set, guest applications cannot distinguish
if a fault was due to missing executable permissions. This patch
ensures that when a page fault occurs during an instruction fetch,
the PF_INSTR flag is properly populated in the signal context.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3384
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 VERSION                            | 2 +-
 target/i386/tcg/user/excp_helper.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/VERSION b/VERSION
index de760e732f..340ebebb29 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-10.2.92
+10.2.93
diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index 98fab4cbc3..6c5df5e0e8 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -36,9 +36,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * signal and set exception_index to EXCP_INTERRUPT.
      */
     env->cr[2] = addr;
-    env->error_code = ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
-                    | (maperr ? 0 : PG_ERROR_P_MASK)
-                    | PG_ERROR_U_MASK;
+    env->error_code = (maperr ? 0 : PG_ERROR_P_MASK)
+                    | ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
+                    | PG_ERROR_U_MASK
+                    | ((access_type == MMU_INST_FETCH) ? PG_ERROR_I_D_MASK : 0);
     cs->exception_index = EXCP0E_PAGE;
 
     /* Disable do_interrupt_user. */
-- 
2.53.0


