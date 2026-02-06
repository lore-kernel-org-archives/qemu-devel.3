Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E3FEE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh2-0001Tn-HD; Fri, 06 Feb 2026 16:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfg-0007tc-RB
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfc-0002lV-C0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so23528915e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414438; x=1771019238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwJyWTQpcklAqD/YURniTtHpvdLcCNaSi5IXHKEhIrs=;
 b=qmIT2qsRqoiKmYuSFYCCGPEClE7G5RS6V3uTo2yfZTmvupnm4jdoyky3FeTDCF0Ip3
 V21J5LepRjgV54Ixq7vHFFr9Bi9WJIDELQbygc6zdQBi2TbgB4ZvKumQUJg+H+7u78nm
 EpfNonTI/gjP76kB9mY2MZh460UwVyARWfBFA8oth4Kisj78gJ+2pWh0b4OlmK06m8PA
 ErYbjOL54We7uylgvRShob3cc4Sc5X/xJAuFXYPWGIprjden1uqNMuICHk+X9RsTuxUL
 /hmIzZ71y+y5iWbwpbp7xwVlG7N2bs1BmkMFNljXHQs/Ad0dBB2xD6iyyWW06CsC9L0T
 QE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414438; x=1771019238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gwJyWTQpcklAqD/YURniTtHpvdLcCNaSi5IXHKEhIrs=;
 b=jsBuRH7MYtu7EIdNA/XQY5xfzdTaPIg2bR43HOfWLmWNYsPS0W06JKECYEMflcNYJB
 EKx7Ur9LPe8vNImM3qWqyMeCkg5vvYsIKDEKCY50PTt/6cVVI9+S5jQNQs3ZRWBFLxtL
 KwjouRSFcuTxjFzrtUeyO4MBop6KCUPv21X8khsbIKbZnV0EpmZc5Q1ILlizEvEJa2lU
 drAt9MIjH6MIHzliEojoydxgB20/YPJs2YwIhijPaEX3s3fBYyiYnPK/qcv5kxArPzQW
 583itcEuz8mg7L9oX4ADS/cN9mrg0P5sZg5d/XH7xqnjFqsR1ZL9Kjk0CnnPgKhAww8+
 cbOA==
X-Gm-Message-State: AOJu0Yzsz2g5eeRsISUe7U03Nz2vlgES+OjmTl7r+cuHTz8kx6ooQsi3
 qUS5gn8NXp02DZG/wbYaqa7dxIfqWmmxe4aoUYzqbkXUxMbC0w1xESuKCIwqtgyhco1J6aaScuI
 8avfqQXk=
X-Gm-Gg: AZuq6aLN1RVN6hzTO/CeKg8P8f2ozzudRALenPfUF8wXuAZxSGrd0Z1VImBwgPyrDri
 nolec75fwV0+bxHsIK3MMAD4DApWwVUNcFH+IWGZoMsYQhoztQ0ZnaBlC6FQA3+nygW9ho6ZmOz
 VL4N2Ud2LNUtf246Ya8q2+5a91dAM0hBg14sWV+ybAuCl1vM7ml0vpots4FkxVgKOMcR73SpC9Y
 sjru/fKGjDCAmhdxKxYdhJdScHtbVOaDNMsmYfvJCUOi3l3py3e+8HUgKLejpfmYp25B47k0atN
 +AAtdEgw4nx+d88TknX/2vMOLIliW9uU0H7LbihcJZiFxYU4U38RqxQ42F+poCLskoOPU2MQGLO
 ei2U8S3VipP0xoDH5UrSaEWTrNWgw3y00tBgs2AE76VE1xz7M8TvTF7D9/bg/T7khVl6lqEAh0B
 CeLhn4+9KF/4Hurv1RlbJtJSdZRsO7lEJj9zI9FrqvKj1iAgHtObgsQbDknjctoi9T1sDGAuY=
X-Received: by 2002:a05:600c:848d:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-48320181b22mr56936585e9.0.1770414438106; 
 Fri, 06 Feb 2026 13:47:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203d606fsm29606095e9.2.2026.02.06.13.47.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 22/30] target/or1k: Rename from openrisc
Date: Fri,  6 Feb 2026 22:44:40 +0100
Message-ID: <20260206214448.22008-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This is the minimal change beginning with TARGET_ARCH in
configs/targets/or1k-* from openrisc to or1k, then adjust
TARGET_OR1K, QEMU_ARCH_OR1K, directory names,
and meson.build to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260205030244.266447-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                       | 2 +-
 configs/targets/or1k-linux-user.mak               | 2 +-
 configs/targets/or1k-softmmu.mak                  | 2 +-
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
 target/{openrisc => or1k}/insns.decode            | 0
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
 rename target/{openrisc => or1k}/insns.decode (100%)
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
 rename target/{openrisc => or1k}/meson.build (79%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65ac60b86b1..08bcd8892ac 100644
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
index 97d7cb10465..0ee3a05884d 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_ARCH=openrisc
+TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index c53408a2bf5..204283d604f 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_ARCH=openrisc
+TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a779adbb7a6..21eed4c54fa 100644
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
index 51e24c3091e..f2f909d5406 100644
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
index be7a8765238..534a29bc12c 100644
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
index 6ae6e1fa139..20d862fd8b1 100644
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
diff --git a/target/openrisc/insns.decode b/target/or1k/insns.decode
similarity index 100%
rename from target/openrisc/insns.decode
rename to target/or1k/insns.decode
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
index be18902bb2f..1ac6d9a8575 100644
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
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 0702f622a55..b5c2e5655bc 100644
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
index 82f1f0ef1cc..49c274b8483 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -4,4 +4,4 @@ openrisc_ss.add(files('boot.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
 openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
-hw_arch += {'openrisc': openrisc_ss}
+hw_arch += {'or1k': openrisc_ss}
diff --git a/linux-user/meson.build b/linux-user/meson.build
index efca8433698..332847a6218 100644
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
index 273e7a0c38a..00000000000
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
index 00000000000..bb7c2ee6bac
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
index d0c7b59d9c7..3c73e3bae01 100644
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
index b29598e7c5e..d891ef9ee09 100644
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
index cd66c2e3b6c..b2693067b1f 100644
--- a/target/openrisc/Kconfig
+++ b/target/or1k/Kconfig
@@ -1,3 +1,3 @@
-config OPENRISC
+config OR1K
     bool
     select DEVICE_TREE # needed by boot.c
diff --git a/target/openrisc/meson.build b/target/or1k/meson.build
similarity index 79%
rename from target/openrisc/meson.build
rename to target/or1k/meson.build
index d51ea1ab753..cad8c1b1ae0 100644
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
2.52.0


