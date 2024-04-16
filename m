Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CEEC04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 23:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwrrE-00033f-Fs; Tue, 16 Apr 2024 19:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrr9-00033C-PJ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:51 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrr8-0007Pa-4A
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:51 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-36b2ec387a9so4192305ab.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713308689; x=1713913489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssIuZaHoHfxGkU2ooOzNE6RgtnB9PZD34dZd+Oj8vXc=;
 b=MhS6s2kNtB6CX0aNK3Otb+65ckHgbxk1tuPkkln0YrDRBGpJeqJw8lXOrBaiKlcWck
 XD5wALA1FmqlduUhYRXXAovxnWRbBnHlEm/g/mfmQTsSuFcjhQzsCpURVVxtqP1ImjzG
 YSAuyL3ky6Pp/UrLJP9WvvmVpMIazQYYnrzpDsie1dGN8PtBK6WNOOPzdNszMnVwIAMf
 4i4FQi+vuvWm0cg0BBgRXuDUY+tEuhd7L8OrJs6IjVZOMXO1tFH42362G5nR6JRRWcf8
 1L5mV6259zoUrkV0CFb+NKRT3s+fpB2Rf5QZwTqVTiFHF6PnRX73trZj16s7gFJU3biO
 7X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713308689; x=1713913489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssIuZaHoHfxGkU2ooOzNE6RgtnB9PZD34dZd+Oj8vXc=;
 b=XoQRfYrdxM18ZRhqMUnd+LB0JXGtTkLI9nXsX+PAHZOqG5YIUpxbFvr6lu421Q55cq
 BkrkW4h8G6EKGdaCEjtUOxnbtpioqbh0QRLQ1aZwFzt9jUaeJdarhYrvnNzUFvm6w5Zm
 XRq7vGuBo9qXy5b7C6EcRHptkhKXoFnRrnWBCL+PfNh1douEnXhoaJg2KnOhMX4hseJM
 GPYFh7U/oVsDROS06uUFt6ooNTeJDv/3JC+uhHotr0e7iZhMki3UdhkvMYhQxPAZl3xJ
 0HI7sZ1ngwqrdrHXdb5d+htTs7h4Z++sICZeAhWJ49dGy0ZTJn5zU4qmzWURHW6eGIz8
 +6bw==
X-Gm-Message-State: AOJu0YzikvU9MBx3jICpP2CxvpZTKGc1KEZYmqMAMJfu7aNq8pZ5ZNDu
 5P0aIIu3UTnESagygUzK/zgUlCIxKwEQ4DZKFSHjE7U2/7BCGprzvOCdwt6OO3qDBsDwEYyq0QC
 z
X-Google-Smtp-Source: AGHT+IGji79nc52Bll8C4nZtz+BYJYUxlIEdLPtdSIAIgzGDMC8wuSbd+GWtGTKM1t/lMHDDIDhAcQ==
X-Received: by 2002:a05:6e02:1c06:b0:36a:686:b3bf with SMTP id
 l6-20020a056e021c0600b0036a0686b3bfmr18553927ilh.17.1713308688837; 
 Tue, 16 Apr 2024 16:04:48 -0700 (PDT)
Received: from grind.. ([177.45.186.202]) by smtp.gmail.com with ESMTPSA id
 g10-20020a63374a000000b005e4666261besm9399555pgn.50.2024.04.16.16.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:04:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v3 1/2] target/riscv/debug: set tval=pc in breakpoint
 exceptions
Date: Tue, 16 Apr 2024 20:04:36 -0300
Message-ID: <20240416230437.1869024-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x12a.google.com
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

We're not setting (s/m)tval when triggering breakpoints of type 2
(mcontrol) and 6 (mcontrol6). According to the debug spec section
5.7.12, "Match Control Type 6":

"The Privileged Spec says that breakpoint exceptions that occur on
instruction fetches, loads, or stores update the tval CSR with either
zero or the faulting virtual address. The faulting virtual address for
an mcontrol6 trigger with action = 0 is the address being accessed and
which caused that trigger to fire."

A similar text is also found in the Debug spec section 5.7.11 w.r.t.
mcontrol.

Note that what we're doing ATM is not violating the spec, but it's
simple enough to set mtval/stval and it makes life easier for any
software that relies on this info.

Given that we always use action = 0, save the faulting address for the
mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
used as as scratch area for traps with address information. 'tval' is
then set during riscv_cpu_do_interrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 1 +
 target/riscv/debug.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..f9c6d7053b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             tval = env->bins;
             break;
         case RISCV_EXCP_BREAKPOINT:
+            tval = env->badaddr;
             if (cs->watchpoint_hit) {
                 tval = cs->watchpoint_hit->hitaddr;
                 cs->watchpoint_hit = NULL;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..b110370ea6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
                     /* check U/S/M bit against current privilege level */
                     if ((ctrl >> 3) & BIT(env->priv)) {
+                        env->badaddr = pc;
                         return true;
                     }
                 }
@@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                     if (env->virt_enabled) {
                         /* check VU/VS bit against current privilege level */
                         if ((ctrl >> 23) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     } else {
                         /* check U/S/M bit against current privilege level */
                         if ((ctrl >> 3) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     }
-- 
2.44.0


