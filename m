Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3F3EE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR0-0006sI-16; Thu, 12 Sep 2024 01:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQT-0004C1-0c
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQR-00036V-3F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-719232ade93so509795b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119085; x=1726723885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8kqQOO07s/lXe7azl0i3Zls58n2NpD50p6A7IulL6U=;
 b=mcSteSlBtObYMgffV1oXWh2Gbr1JQ18AAmmSIrbKjciqk/NOtUuLrhJwVVqcX0G/q3
 ZGDndwxkoH9gjpZodkzBYBb25Ahy3/WmJCf7ckt3WEeO3opyMFeyzNewTDMtLPbFX7j6
 qexc42TDQmZc5m+Q14q/htaFhkGNSNIGYzICgbsx+7LqW5GPk+Y6JSs++mNAGqjY6lak
 LNmDlhQeHH+Ti6GWMbKK7+39q44G3r2M52KVrpiv7TPudHv8hOBYGalavJtKHmwW3p79
 8AaMQc5LWzVGISuHWVXHjSywUSAG9eZAsPwQNRek36qA8c38stYfEqpiJb3mHCjtwND8
 kJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119085; x=1726723885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8kqQOO07s/lXe7azl0i3Zls58n2NpD50p6A7IulL6U=;
 b=iRr6PqEImgf10tzSSecpfcAsgySQggG6DQF8qNabqmSqxa4Q8OL2Da17p+Zfm9iYgQ
 dQo4K2141wvF8Ses02OHAr/WuFFrp970/BPNhAq3eUVwp+GzLOwhSd6U3WVMBvJi4a1S
 jyoC22RxHhw4POi0g2wWdRAuIS7ZuLpPVC9028LArPwSlCGpAM+3QF2hugPKzpM68vor
 i214KZ8mLOp2ZZ6qtryZxZbmN+KVEtxBCeZbEXy2zrU42vMrxl79zv0/KwRuBgqSqBXM
 LqDy0XbyYJvOQLQUen/zzbSNO5DjGwiGv6cKZGNn4Waj+WMqsPEOtULmubK+MqWXU89t
 wj+w==
X-Gm-Message-State: AOJu0YzVX7X4zj5GTUZllNi5Gle9XBQ0AKFni+O8L+UUTSzfkS6yGWnJ
 rUYyL/jUSgtvi6Wx5BcBiFXwRQRePpBK1hSYkdcsywTOexIDCcXG4Ws+Pg==
X-Google-Smtp-Source: AGHT+IGoECLeYMy/QdisTJx8qkw+47og9bgJWO/hw0VDS4uk/+zBn9afJ70lrMcTRJYqXX1cNPra7Q==
X-Received: by 2002:a05:6a00:3e23:b0:717:8f0d:ec37 with SMTP id
 d2e1a72fcca58-71926206e36mr2172746b3a.25.1726119085088; 
 Wed, 11 Sep 2024 22:31:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/47] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Thu, 12 Sep 2024 15:29:32 +1000
Message-ID: <20240912052953.2552501-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Mark Corbin <mark@dibsco.co.uk>

Implemented the RISC-V CPU execution loop, including handling various
exceptions and system calls. The loop continuously executes CPU
instructions,processes exceptions, and handles system calls by invoking
FreeBSD syscall handlers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-3-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index e17c910ae9..ea2a8d1ace 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -36,4 +36,98 @@ static inline void target_cpu_init(CPURISCVState *env,
     env->pc = regs->sepc;
 }
 
+static inline void target_cpu_loop(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+    int trapnr;
+    abi_long ret;
+    unsigned int syscall_num;
+    int32_t signo, code;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        signo = 0;
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        case RISCV_EXCP_U_ECALL:
+            syscall_num = env->gpr[xT0];
+            env->pc += TARGET_INSN_SIZE;
+            /* Compare to cpu_fetch_syscall_args() in riscv/riscv/trap.c */
+            if (TARGET_FREEBSD_NR___syscall == syscall_num ||
+                TARGET_FREEBSD_NR_syscall == syscall_num) {
+                ret = do_freebsd_syscall(env,
+                                         env->gpr[xA0],
+                                         env->gpr[xA1],
+                                         env->gpr[xA2],
+                                         env->gpr[xA3],
+                                         env->gpr[xA4],
+                                         env->gpr[xA5],
+                                         env->gpr[xA6],
+                                         env->gpr[xA7],
+                                         0);
+            } else {
+                ret = do_freebsd_syscall(env,
+                                         syscall_num,
+                                         env->gpr[xA0],
+                                         env->gpr[xA1],
+                                         env->gpr[xA2],
+                                         env->gpr[xA3],
+                                         env->gpr[xA4],
+                                         env->gpr[xA5],
+                                         env->gpr[xA6],
+                                         env->gpr[xA7]
+                    );
+            }
+
+            /*
+             * Compare to cpu_set_syscall_retval() in
+             * riscv/riscv/vm_machdep.c
+             */
+            if (ret >= 0) {
+                env->gpr[xA0] = ret;
+                env->gpr[xT0] = 0;
+            } else if (ret == -TARGET_ERESTART) {
+                env->pc -= TARGET_INSN_SIZE;
+            } else if (ret != -TARGET_EJUSTRETURN) {
+                env->gpr[xA0] = -ret;
+                env->gpr[xT0] = 1;
+            }
+            break;
+        case RISCV_EXCP_ILLEGAL_INST:
+            signo = TARGET_SIGILL;
+            code = TARGET_ILL_ILLOPC;
+            break;
+        case RISCV_EXCP_BREAKPOINT:
+            signo = TARGET_SIGTRAP;
+            code = TARGET_TRAP_BRKPT;
+            break;
+        case EXCP_DEBUG:
+            signo = TARGET_SIGTRAP;
+            code = TARGET_TRAP_BRKPT;
+            break;
+        default:
+            fprintf(stderr, "qemu: unhandled CPU exception "
+                "0x%x - aborting\n", trapnr);
+            cpu_dump_state(cs, stderr, 0);
+            abort();
+        }
+
+        if (signo) {
+            force_sig_fault(signo, code, env->pc);
+        }
+
+        process_pending_signals(env);
+    }
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.46.0


