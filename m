Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BEFEA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpe5-0008Qn-H7; Wed, 04 Feb 2026 22:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpdz-0008Ph-0W
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:01 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpdw-0007Sg-DD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:02:58 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so266828b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260574; x=1770865374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SEMOzJmNfdF12NQjohyhsx0+eYLub0ytTqf73and+w=;
 b=dlNSLNTCqwRURZQ7FYRLL6wfOhJ/pI1fhJxMpUT0uy60vQNTz6AtH6ds3OpadSi5fa
 euU4exTm5C7xsnxnXNHk9DN5zaFauekWyrQenPNSN0KdmfsOsXk1PwTUIyjvqW+SNbQI
 LQSbfUIWbO4ZoJ1Hp9THfdTbLr9zI08DvN+eSAB30ulJxi7DAILZ6swRD5vgA/LEi0Lh
 cuRAlDyIo+qSyIiRhFK+rOL4DK7/ZEplF9mlmNyzUeua5Ny+kSXZuUFv8ldfMmMQjWZ4
 XAsHYlRD67EcMZdrMCkDIfs9P8kzeneJ5+B23qZCYv7LavOpQkrOBmsChcYD65JOw76e
 EjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260574; x=1770865374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2SEMOzJmNfdF12NQjohyhsx0+eYLub0ytTqf73and+w=;
 b=Qha92D6bRCICh3w0X4IFgJJvBm6elTkhcQYnZUPm5ncW+MrRXyulJ0EBwj+jH1+HEG
 nxTGpGqRrn9cy7Y0AopohtInbA0lWLm43diGAv0VpnZzIn+xAKNhpKMh7tRIH3Boc6nG
 njODoHqkPHUNN90Po5VR7guupFvOGSlUcbFs8ZWq6Srs6T8TEZhneE69fZn8xpbrzLo1
 gCHBdOnQ+Ec/CpzUmuIyNsTQAnE8lJ7J+lVDxhKhNp3G83MEC5wlr6aUPxRsMxkZlPWe
 4tANi6cacx8q0rrhC9wIFXIMIr4azAv3o6agLQZqikTfLuB5GyCrWRpfEvWd7yYS5fjH
 3q7g==
X-Gm-Message-State: AOJu0Yw12vbKauwMNJGTPmzOI6DpKwV9tSOI5wswyTGvXM/0AYUEbaQZ
 4v5GDsJfJgWA5fw9DTR5nyqWogPwxJ59NzGiZqJoilRatRP36KTJwoPedY+cUW1bot/1gM+XhK2
 +nNvqqDt3HQ==
X-Gm-Gg: AZuq6aLncRCokZirMSgBuwze9+wZGOrRBOXfkpMD7nQMWfSo31WMA4fVjwoGFW4lRze
 hI0XkamvE+wm8vfbvf4Yqn/maIOebGQNts8E+RrG5jWP0r4MD9Zbyve27R/6C8UCCIV2SAALTHU
 v0FskzILPNAtuL4exhi0zfxxC7jAn0RAhJMrPADooNWHRFnkxkf5/EDjR5ozH2vTDlCO39NjF3V
 ozEFFPmp8lAvZBwbzqoK0j8ApyP16XoN96OOAVHiFDdKlmDbulr0eTr7Q+A7aTWkxj6kh979VIA
 zAs6mo8CCNs9Q9grTNjL9WbRuBafZT1v7JyL0MaHLdeYXUWFRwZO6o249nW3+LMh1WkIWimIX9n
 omBZVkN1ozzG00U6II+PmFil4bhkOhEp5PTtjjox9M73tJlHv9JDUDSFK3gt3edwM4vUQpdMN44
 UgwWbJCdOSEHCmMKhmIThT
X-Received: by 2002:a05:6a21:778c:b0:393:74ed:7de9 with SMTP id
 adf61e73a8af0-39374ed82eamr3512551637.3.1770260574338; 
 Wed, 04 Feb 2026 19:02:54 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:02:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 1/6] target/or1k: Rename from openrisc
Date: Thu,  5 Feb 2026 13:02:39 +1000
Message-ID: <20260205030244.266447-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

This is the minimal change beginning with TARGET_ARCH in
configs/targets/or1k-* from openrisc to or1k, then adjust
TARGET_OR1K, QEMU_ARCH_OR1K, directory names,
and meson.build to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h                             | 2 +-
 include/system/arch_init.h                        | 2 +-
 include/user/abitypes.h                           | 2 +-
 linux-user/{openrisc => or1k}/sockbits.h          | 0
 linux-user/{openrisc => or1k}/target_cpu.h        | 0
 linux-user/{openrisc => or1k}/target_elf.h        | 0
 linux-user/{openrisc => or1k}/target_errno_defs.h | 0
 linux-user/{openrisc => or1k}/target_fcntl.h      | 0
 linux-user/{openrisc => or1k}/target_mman.h       | 0
 linux-user/{openrisc => or1k}/target_prctl.h      | 0
 linux-user/{openrisc => or1k}/target_proc.h       | 0
 linux-user/{openrisc => or1k}/target_ptrace.h     | 0
 linux-user/{openrisc => or1k}/target_resource.h   | 0
 linux-user/{openrisc => or1k}/target_signal.h     | 0
 linux-user/{openrisc => or1k}/target_structs.h    | 0
 linux-user/{openrisc => or1k}/target_syscall.h    | 0
 linux-user/{openrisc => or1k}/termbits.h          | 0
 linux-user/syscall_defs.h                         | 4 ++--
 target/{openrisc => or1k}/cpu-param.h             | 0
 target/{openrisc => or1k}/cpu-qom.h               | 0
 target/{openrisc => or1k}/cpu.h                   | 0
 target/{openrisc => or1k}/exception.h             | 0
 target/{openrisc => or1k}/helper.h                | 0
 linux-user/{openrisc => or1k}/cpu_loop.c          | 0
 linux-user/{openrisc => or1k}/elfload.c           | 0
 linux-user/{openrisc => or1k}/signal.c            | 0
 system/qdev-monitor.c                             | 2 +-
 target/{openrisc => or1k}/cpu.c                   | 0
 target/{openrisc => or1k}/disas.c                 | 0
 target/{openrisc => or1k}/exception.c             | 0
 target/{openrisc => or1k}/exception_helper.c      | 0
 target/{openrisc => or1k}/fpu_helper.c            | 0
 target/{openrisc => or1k}/gdbstub.c               | 0
 target/{openrisc => or1k}/interrupt.c             | 0
 target/{openrisc => or1k}/interrupt_helper.c      | 0
 target/{openrisc => or1k}/machine.c               | 0
 target/{openrisc => or1k}/mmu.c                   | 0
 target/{openrisc => or1k}/sys_helper.c            | 0
 target/{openrisc => or1k}/translate.c             | 0
 MAINTAINERS                                       | 2 +-
 configs/targets/or1k-linux-user.mak               | 2 +-
 configs/targets/or1k-softmmu.mak                  | 2 +-
 hw/openrisc/Kconfig                               | 4 ++--
 hw/openrisc/meson.build                           | 2 +-
 linux-user/meson.build                            | 2 +-
 linux-user/openrisc/meson.build                   | 5 -----
 linux-user/or1k/meson.build                       | 5 +++++
 linux-user/{openrisc => or1k}/syscall.tbl         | 0
 linux-user/{openrisc => or1k}/syscallhdr.sh       | 0
 target/Kconfig                                    | 2 +-
 target/meson.build                                | 2 +-
 target/{openrisc => or1k}/Kconfig                 | 2 +-
 target/{openrisc => or1k}/insns.decode            | 0
 target/{openrisc => or1k}/meson.build             | 4 ++--
 54 files changed, 23 insertions(+), 23 deletions(-)
 rename linux-user/{openrisc => or1k}/sockbits.h (100%)
 rename linux-user/{openrisc => or1k}/target_cpu.h (100%)
 rename linux-user/{openrisc => or1k}/target_elf.h (100%)
 rename linux-user/{openrisc => or1k}/target_errno_defs.h (100%)
 rename linux-user/{openrisc => or1k}/target_fcntl.h (100%)
 rename linux-user/{openrisc => or1k}/target_mman.h (100%)
 rename linux-user/{openrisc => or1k}/target_prctl.h (100%)
 rename linux-user/{openrisc => or1k}/target_proc.h (100%)
 rename linux-user/{openrisc => or1k}/target_ptrace.h (100%)
 rename linux-user/{openrisc => or1k}/target_resource.h (100%)
 rename linux-user/{openrisc => or1k}/target_signal.h (100%)
 rename linux-user/{openrisc => or1k}/target_structs.h (100%)
 rename linux-user/{openrisc => or1k}/target_syscall.h (100%)
 rename linux-user/{openrisc => or1k}/termbits.h (100%)
 rename target/{openrisc => or1k}/cpu-param.h (100%)
 rename target/{openrisc => or1k}/cpu-qom.h (100%)
 rename target/{openrisc => or1k}/cpu.h (100%)
 rename target/{openrisc => or1k}/exception.h (100%)
 rename target/{openrisc => or1k}/helper.h (100%)
 rename linux-user/{openrisc => or1k}/cpu_loop.c (100%)
 rename linux-user/{openrisc => or1k}/elfload.c (100%)
 rename linux-user/{openrisc => or1k}/signal.c (100%)
 rename target/{openrisc => or1k}/cpu.c (100%)
 rename target/{openrisc => or1k}/disas.c (100%)
 rename target/{openrisc => or1k}/exception.c (100%)
 rename target/{openrisc => or1k}/exception_helper.c (100%)
 rename target/{openrisc => or1k}/fpu_helper.c (100%)
 rename target/{openrisc => or1k}/gdbstub.c (100%)
 rename target/{openrisc => or1k}/interrupt.c (100%)
 rename target/{openrisc => or1k}/interrupt_helper.c (100%)
 rename target/{openrisc => or1k}/machine.c (100%)
 rename target/{openrisc => or1k}/mmu.c (100%)
 rename target/{openrisc => or1k}/sys_helper.c (100%)
 rename target/{openrisc => or1k}/translate.c (100%)
 delete mode 100644 linux-user/openrisc/meson.build
 create mode 100644 linux-user/or1k/meson.build
 rename linux-user/{openrisc => or1k}/syscall.tbl (100%)
 rename linux-user/{openrisc => or1k}/syscallhdr.sh (100%)
 rename target/{openrisc => or1k}/Kconfig (76%)
 rename target/{openrisc => or1k}/insns.decode (100%)
 rename target/{openrisc => or1k}/meson.build (79%)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index a779adbb7a..21eed4c54f 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -21,7 +21,7 @@
 #pragma GCC poison TARGET_ABI_MIPSO32
 #pragma GCC poison TARGET_MIPS64
 #pragma GCC poison TARGET_ABI_MIPSN64
-#pragma GCC poison TARGET_OPENRISC
+#pragma GCC poison TARGET_OR1K
 #pragma GCC poison TARGET_PPC
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 51e24c3091..f2f909d540 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -15,7 +15,7 @@ enum {
     QEMU_ARCH_SH4 = (1 << 10),
     QEMU_ARCH_SPARC = (1 << 11),
     QEMU_ARCH_XTENSA = (1 << 12),
-    QEMU_ARCH_OPENRISC = (1 << 13),
+    QEMU_ARCH_OR1K = (1 << 13),
     QEMU_ARCH_TRICORE = (1 << 16),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
diff --git a/include/user/abitypes.h b/include/user/abitypes.h
index be7a876523..534a29bc12 100644
--- a/include/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -22,7 +22,7 @@
 
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
-    || defined(TARGET_OPENRISC) \
+    || defined(TARGET_OR1K) \
     || defined(TARGET_MICROBLAZE)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
diff --git a/linux-user/openrisc/sockbits.h b/linux-user/or1k/sockbits.h
similarity index 100%
rename from linux-user/openrisc/sockbits.h
rename to linux-user/or1k/sockbits.h
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/or1k/target_cpu.h
similarity index 100%
rename from linux-user/openrisc/target_cpu.h
rename to linux-user/or1k/target_cpu.h
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/or1k/target_elf.h
similarity index 100%
rename from linux-user/openrisc/target_elf.h
rename to linux-user/or1k/target_elf.h
diff --git a/linux-user/openrisc/target_errno_defs.h b/linux-user/or1k/target_errno_defs.h
similarity index 100%
rename from linux-user/openrisc/target_errno_defs.h
rename to linux-user/or1k/target_errno_defs.h
diff --git a/linux-user/openrisc/target_fcntl.h b/linux-user/or1k/target_fcntl.h
similarity index 100%
rename from linux-user/openrisc/target_fcntl.h
rename to linux-user/or1k/target_fcntl.h
diff --git a/linux-user/openrisc/target_mman.h b/linux-user/or1k/target_mman.h
similarity index 100%
rename from linux-user/openrisc/target_mman.h
rename to linux-user/or1k/target_mman.h
diff --git a/linux-user/openrisc/target_prctl.h b/linux-user/or1k/target_prctl.h
similarity index 100%
rename from linux-user/openrisc/target_prctl.h
rename to linux-user/or1k/target_prctl.h
diff --git a/linux-user/openrisc/target_proc.h b/linux-user/or1k/target_proc.h
similarity index 100%
rename from linux-user/openrisc/target_proc.h
rename to linux-user/or1k/target_proc.h
diff --git a/linux-user/openrisc/target_ptrace.h b/linux-user/or1k/target_ptrace.h
similarity index 100%
rename from linux-user/openrisc/target_ptrace.h
rename to linux-user/or1k/target_ptrace.h
diff --git a/linux-user/openrisc/target_resource.h b/linux-user/or1k/target_resource.h
similarity index 100%
rename from linux-user/openrisc/target_resource.h
rename to linux-user/or1k/target_resource.h
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/or1k/target_signal.h
similarity index 100%
rename from linux-user/openrisc/target_signal.h
rename to linux-user/or1k/target_signal.h
diff --git a/linux-user/openrisc/target_structs.h b/linux-user/or1k/target_structs.h
similarity index 100%
rename from linux-user/openrisc/target_structs.h
rename to linux-user/or1k/target_structs.h
diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/or1k/target_syscall.h
similarity index 100%
rename from linux-user/openrisc/target_syscall.h
rename to linux-user/or1k/target_syscall.h
diff --git a/linux-user/openrisc/termbits.h b/linux-user/or1k/termbits.h
similarity index 100%
rename from linux-user/openrisc/termbits.h
rename to linux-user/or1k/termbits.h
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 6ae6e1fa13..20d862fd8b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -72,7 +72,7 @@
 
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4)  \
     || defined(TARGET_M68K)                                             \
-    || defined(TARGET_S390X) || defined(TARGET_OPENRISC)                \
+    || defined(TARGET_S390X) || defined(TARGET_OR1K)                    \
     || defined(TARGET_RISCV)                                            \
     || defined(TARGET_XTENSA) || defined(TARGET_LOONGARCH64)
 
@@ -1976,7 +1976,7 @@ struct target_stat64  {
     abi_ulong __unused5;
 };
 
-#elif defined(TARGET_OPENRISC) \
+#elif defined(TARGET_OR1K) \
     || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || defined(TARGET_LOONGARCH)
 
 /* These are the asm-generic versions of the stat and stat64 structures */
diff --git a/target/openrisc/cpu-param.h b/target/or1k/cpu-param.h
similarity index 100%
rename from target/openrisc/cpu-param.h
rename to target/or1k/cpu-param.h
diff --git a/target/openrisc/cpu-qom.h b/target/or1k/cpu-qom.h
similarity index 100%
rename from target/openrisc/cpu-qom.h
rename to target/or1k/cpu-qom.h
diff --git a/target/openrisc/cpu.h b/target/or1k/cpu.h
similarity index 100%
rename from target/openrisc/cpu.h
rename to target/or1k/cpu.h
diff --git a/target/openrisc/exception.h b/target/or1k/exception.h
similarity index 100%
rename from target/openrisc/exception.h
rename to target/or1k/exception.h
diff --git a/target/openrisc/helper.h b/target/or1k/helper.h
similarity index 100%
rename from target/openrisc/helper.h
rename to target/or1k/helper.h
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/or1k/cpu_loop.c
similarity index 100%
rename from linux-user/openrisc/cpu_loop.c
rename to linux-user/or1k/cpu_loop.c
diff --git a/linux-user/openrisc/elfload.c b/linux-user/or1k/elfload.c
similarity index 100%
rename from linux-user/openrisc/elfload.c
rename to linux-user/or1k/elfload.c
diff --git a/linux-user/openrisc/signal.c b/linux-user/or1k/signal.c
similarity index 100%
rename from linux-user/openrisc/signal.c
rename to linux-user/or1k/signal.c
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index be18902bb2..1ac6d9a857 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -62,7 +62,7 @@ typedef struct QDevAlias
                               QEMU_ARCH_I386 | \
                               QEMU_ARCH_LOONGARCH | \
                               QEMU_ARCH_MIPS | \
-                              QEMU_ARCH_OPENRISC | \
+                              QEMU_ARCH_OR1K | \
                               QEMU_ARCH_PPC | \
                               QEMU_ARCH_RISCV | \
                               QEMU_ARCH_SH4 | \
diff --git a/target/openrisc/cpu.c b/target/or1k/cpu.c
similarity index 100%
rename from target/openrisc/cpu.c
rename to target/or1k/cpu.c
diff --git a/target/openrisc/disas.c b/target/or1k/disas.c
similarity index 100%
rename from target/openrisc/disas.c
rename to target/or1k/disas.c
diff --git a/target/openrisc/exception.c b/target/or1k/exception.c
similarity index 100%
rename from target/openrisc/exception.c
rename to target/or1k/exception.c
diff --git a/target/openrisc/exception_helper.c b/target/or1k/exception_helper.c
similarity index 100%
rename from target/openrisc/exception_helper.c
rename to target/or1k/exception_helper.c
diff --git a/target/openrisc/fpu_helper.c b/target/or1k/fpu_helper.c
similarity index 100%
rename from target/openrisc/fpu_helper.c
rename to target/or1k/fpu_helper.c
diff --git a/target/openrisc/gdbstub.c b/target/or1k/gdbstub.c
similarity index 100%
rename from target/openrisc/gdbstub.c
rename to target/or1k/gdbstub.c
diff --git a/target/openrisc/interrupt.c b/target/or1k/interrupt.c
similarity index 100%
rename from target/openrisc/interrupt.c
rename to target/or1k/interrupt.c
diff --git a/target/openrisc/interrupt_helper.c b/target/or1k/interrupt_helper.c
similarity index 100%
rename from target/openrisc/interrupt_helper.c
rename to target/or1k/interrupt_helper.c
diff --git a/target/openrisc/machine.c b/target/or1k/machine.c
similarity index 100%
rename from target/openrisc/machine.c
rename to target/or1k/machine.c
diff --git a/target/openrisc/mmu.c b/target/or1k/mmu.c
similarity index 100%
rename from target/openrisc/mmu.c
rename to target/or1k/mmu.c
diff --git a/target/openrisc/sys_helper.c b/target/or1k/sys_helper.c
similarity index 100%
rename from target/openrisc/sys_helper.c
rename to target/or1k/sys_helper.c
diff --git a/target/openrisc/translate.c b/target/or1k/translate.c
similarity index 100%
rename from target/openrisc/translate.c
rename to target/or1k/translate.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b7ed4fccb..a0422936ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -303,7 +303,7 @@ OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: docs/system/openrisc/cpu-features.rst
-F: target/openrisc/
+F: target/or1k/
 F: hw/openrisc/
 F: include/hw/openrisc/
 F: tests/functional/or1k/meson.build
diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 97d7cb1046..0ee3a05884 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_ARCH=openrisc
+TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index c53408a2bf..204283d604 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_ARCH=openrisc
+TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 0702f622a5..b5c2e5655b 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -1,7 +1,7 @@
 config OR1K_SIM
     bool
     default y
-    depends on OPENRISC
+    depends on OR1K
     select DEVICE_TREE
     select SERIAL_MM
     select OPENCORES_ETH
@@ -11,7 +11,7 @@ config OR1K_SIM
 config OR1K_VIRT
     bool
     default y
-    depends on OPENRISC
+    depends on OR1K
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
index 82f1f0ef1c..49c274b848 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -4,4 +4,4 @@ openrisc_ss.add(files('boot.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
-hw_arch += {'openrisc': openrisc_ss}
+hw_arch += {'or1k': openrisc_ss}
diff --git a/linux-user/meson.build b/linux-user/meson.build
index efca843369..332847a621 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -50,7 +50,7 @@ subdir('m68k')
 subdir('microblaze')
 subdir('mips64')
 subdir('mips')
-subdir('openrisc')
+subdir('or1k')
 subdir('ppc')
 subdir('riscv')
 subdir('s390x')
diff --git a/linux-user/openrisc/meson.build b/linux-user/openrisc/meson.build
deleted file mode 100644
index 273e7a0c38..0000000000
--- a/linux-user/openrisc/meson.build
+++ /dev/null
@@ -1,5 +0,0 @@
-syscall_nr_generators += {
-  'openrisc': generator(sh,
-                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
-                      output: '@BASENAME@_nr.h')
-}
diff --git a/linux-user/or1k/meson.build b/linux-user/or1k/meson.build
new file mode 100644
index 0000000000..bb7c2ee6ba
--- /dev/null
+++ b/linux-user/or1k/meson.build
@@ -0,0 +1,5 @@
+syscall_nr_generators += {
+  'or1k': generator(sh,
+                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                    output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/openrisc/syscall.tbl b/linux-user/or1k/syscall.tbl
similarity index 100%
rename from linux-user/openrisc/syscall.tbl
rename to linux-user/or1k/syscall.tbl
diff --git a/linux-user/openrisc/syscallhdr.sh b/linux-user/or1k/syscallhdr.sh
similarity index 100%
rename from linux-user/openrisc/syscallhdr.sh
rename to linux-user/or1k/syscallhdr.sh
diff --git a/target/Kconfig b/target/Kconfig
index d0c7b59d9c..3c73e3bae0 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -7,7 +7,7 @@ source loongarch/Kconfig
 source m68k/Kconfig
 source microblaze/Kconfig
 source mips/Kconfig
-source openrisc/Kconfig
+source or1k/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
 source rx/Kconfig
diff --git a/target/meson.build b/target/meson.build
index b29598e7c5..d891ef9ee0 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -8,7 +8,7 @@ subdir('loongarch')
 subdir('m68k')
 subdir('microblaze')
 subdir('mips')
-subdir('openrisc')
+subdir('or1k')
 subdir('ppc')
 subdir('riscv')
 subdir('rx')
diff --git a/target/openrisc/Kconfig b/target/or1k/Kconfig
similarity index 76%
rename from target/openrisc/Kconfig
rename to target/or1k/Kconfig
index cd66c2e3b6..b2693067b1 100644
--- a/target/openrisc/Kconfig
+++ b/target/or1k/Kconfig
@@ -1,3 +1,3 @@
-config OPENRISC
+config OR1K
     bool
     select DEVICE_TREE # needed by boot.c
diff --git a/target/openrisc/insns.decode b/target/or1k/insns.decode
similarity index 100%
rename from target/openrisc/insns.decode
rename to target/or1k/insns.decode
diff --git a/target/openrisc/meson.build b/target/or1k/meson.build
similarity index 79%
rename from target/openrisc/meson.build
rename to target/or1k/meson.build
index d51ea1ab75..cad8c1b1ae 100644
--- a/target/openrisc/meson.build
+++ b/target/or1k/meson.build
@@ -21,5 +21,5 @@ openrisc_system_ss.add(files(
   'mmu.c',
 ))
 
-target_arch += {'openrisc': openrisc_ss}
-target_common_system_arch += {'openrisc': openrisc_system_ss}
+target_arch += {'or1k': openrisc_ss}
+target_common_system_arch += {'or1k': openrisc_system_ss}
-- 
2.43.0


