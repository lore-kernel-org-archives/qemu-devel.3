Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F32DCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D7-0003cA-Cg; Wed, 15 Oct 2025 17:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cx-0003Zk-2N
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cr-0004zV-MF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27eec33b737so895615ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564328; x=1761169128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZnK3yCNaUwo8Kqz/STDxY+wFQGjUJ7jcrykCbsgxto=;
 b=mGddp9C3VSlkdtHx+dAx+ttT2VQMxfyHLT2XbaUzril3GNmsStFvdNYLoxGtSL3kLf
 YN0apiZHvI9hjNyzPWkTT3PjCNk1pnOgBviKVyEy5MGVDwyjFdX2v+7zr4gOVymC60iR
 YoBESrjxwVLlLpGbQ8b7KhtZqUTWbu4Q0JLYkrSDnz09M99rLZVR6HaY2SK8gPWY8SeP
 3gQlJfuOEnk/D+flDShGnSkrhEZbeSiyPJF394FmPhqKa55kS0YYBn17mV3WkDK/sX/A
 +rS2JW12uYxBgXrqs4fWdgUy8kKmK9eWiF6Jy4c5Vtf24gkW+9DHJVQp2+Q/HLEmkKII
 ENCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564328; x=1761169128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZnK3yCNaUwo8Kqz/STDxY+wFQGjUJ7jcrykCbsgxto=;
 b=R45zNfS6qp+03Hwlll5FvV0MK0KW8QA+WS76coflDIJDkATE2bhnU5SwUPzYm8MTBA
 gfeGqpneNgy9f3ayJ6J4wdb/wII+ZQxTwibOvjwcIVq0gCOJyrk70fXxPkWEA8853+TK
 FZKJ0tHKJ1+hWGHCiEQUgRHOTa2LAEwF87964shnl5dJFJj844H70pwRaSOnFVfpiQQ4
 CGAaKulJeRbzqf6NI7GELXxdKoH9YPXtQBKmgQ+fhLEwxqUBmQA3NK9jmVyzTWCQDfuU
 cH88gW0iM+1nk+tIJGdQWDo6qXViOTyBre+NhVMOZ0zYp1ym4B8YtJNSOn6eEWDJPbw1
 24Gg==
X-Gm-Message-State: AOJu0YxBhE7czeacSmbsGW1wndK3SFE/WrZz6EJiqLkcHX/cNHLEPeFS
 zEv7TlOF5BAV3Mw9598KoKuj27XOyMhBZYeRXBQGOrHA6YSznn4oBi4BQRQigZodQIov7p9rxBg
 EB50EyvE=
X-Gm-Gg: ASbGncvUBs0wPQjnE/VqMpyEN5QGvnA9IzfInG1d5P72+A2lgK/9HNQce9spstkqQUD
 UhFSqwX6Vug1n2LmD3fW3hyF58vz6l4seQumiGZD00MnuVO8VvjvuEe+SaSFC/CBFOwjjP+AtCS
 K5UnF7M+iAn7w2puq/WyPDxQc1LTjbWas4UaUnBgZeCOFrIXijg6m5OB4mKUzr0XdyxxMGdMAg0
 1bNxXm+xXN2r+kYk2+GnOSU4J637xduwstnM9hN7B+Cni9SBiVwGer3vAiH9/AgyGZkD6OUlotU
 r5czYUZL3MBv6qHIJosW1n9xj+gMwht0OU3YB3hJH8shbEum8RlLjLWpSla8pr/gqngckQMbyMf
 WhrWJQ7KfjD4KcYJJEa/8Jwd58U8anUsL9DSIu/6CQokU3SozLZqN7geijBOH6UOk3jlR+W9v4j
 k0VRQwR/a62g==
X-Google-Smtp-Source: AGHT+IEJt1pOKktZVap13DuSuLhCD/Guq+ewxkjAlI3UPriB6Hq2j9kPY44fKK54+DQg6ia1Hj9IlQ==
X-Received: by 2002:a17:902:ea10:b0:290:a70e:6261 with SMTP id
 d9443c01a7336-290a70e645dmr1897485ad.11.1760564327707; 
 Wed, 15 Oct 2025 14:38:47 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 4/9] tcg/mips: Remove support for O32 and N32 ABIs
Date: Wed, 15 Oct 2025 14:38:38 -0700
Message-ID: <20251015213843.14277-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-5-philmd@linaro.org>
---
 tcg/mips/tcg-target-reg-bits.h           |  8 ++----
 common-user/host/mips/safe-syscall.inc.S | 35 ------------------------
 tcg/mips/tcg-target.c.inc                | 14 ++--------
 3 files changed, 6 insertions(+), 51 deletions(-)

diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
index 56fe0a725e..ee346a3f25 100644
--- a/tcg/mips/tcg-target-reg-bits.h
+++ b/tcg/mips/tcg-target-reg-bits.h
@@ -7,12 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_REG_BITS 32
-#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
-# define TCG_TARGET_REG_BITS 64
-#else
+#if !defined(_MIPS_SIM) || _MIPS_SIM != _ABI64
 # error "Unknown ABI"
 #endif
 
+#define TCG_TARGET_REG_BITS 64
+
 #endif
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips/safe-syscall.inc.S
index 6a44614970..3b196cc634 100644
--- a/common-user/host/mips/safe-syscall.inc.S
+++ b/common-user/host/mips/safe-syscall.inc.S
@@ -30,15 +30,9 @@
          * arguments being syscall arguments (also 'long').
          */
 
-#if _MIPS_SIM == _ABIO32
-/* 8 * 4 = 32 for outgoing parameters; 1 * 4 for s0 save; 1 * 4 for align. */
-#define FRAME    40
-#define OFS_S0   32
-#else
 /* 1 * 8 for s0 save; 1 * 8 for align. */
 #define FRAME    16
 #define OFS_S0   0
-#endif
 
 
 NESTED(safe_syscall_base, FRAME, ra)
@@ -47,34 +41,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         .cfi_adjust_cfa_offset FRAME
         REG_S   s0, OFS_S0(sp)
         .cfi_rel_offset s0, OFS_S0
-#if _MIPS_SIM == _ABIO32
-        /*
-         * The syscall calling convention is nearly the same as C:
-         * we enter with a0 == &signal_pending
-         *               a1 == syscall number
-         *               a2, a3, stack == syscall arguments
-         *               and return the result in a0
-         * and the syscall instruction needs
-         *               v0 == syscall number
-         *               a0 ... a3, stack == syscall arguments
-         *               and returns the result in v0
-         * Shuffle everything around appropriately.
-         */
-        move    s0, a0          /* signal_pending pointer */
-        move    v0, a1          /* syscall number */
-        move    a0, a2          /* syscall arguments */
-        move    a1, a3
-        lw      a2, FRAME+16(sp)
-        lw      a3, FRAME+20(sp)
-        lw      t4, FRAME+24(sp)
-        lw      t5, FRAME+28(sp)
-        lw      t6, FRAME+32(sp)
-        lw      t7, FRAME+40(sp)
-        sw      t4, 16(sp)
-        sw      t5, 20(sp)
-        sw      t6, 24(sp)
-        sw      t7, 28(sp)
-#else
         /*
          * The syscall calling convention is nearly the same as C:
          * we enter with a0 == &signal_pending
@@ -95,7 +61,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         move    a3, a5
         move    a4, a6
         move    a5, a7
-#endif
 
         /*
          * This next sequence of code works in conjunction with the
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 400eafbab4..2ca5aaf3a6 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -26,16 +26,10 @@
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_CALL_STACK_OFFSET 16
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
-#else
-# define TCG_TARGET_CALL_STACK_OFFSET 0
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
-#endif
+#define TCG_TARGET_CALL_STACK_OFFSET  0
 #define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128      TCG_CALL_RET_NORMAL
 #define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
 
 #if TCG_TARGET_REG_BITS == 32
@@ -135,12 +129,10 @@ static const TCGReg tcg_target_call_iarg_regs[] = {
     TCG_REG_A1,
     TCG_REG_A2,
     TCG_REG_A3,
-#if _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
     TCG_REG_T0,
     TCG_REG_T1,
     TCG_REG_T2,
     TCG_REG_T3,
-#endif
 };
 
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
-- 
2.43.0


