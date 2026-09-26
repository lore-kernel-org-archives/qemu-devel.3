Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28436C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAcGE-0006YH-7K; Sat, 26 Sep 2026 19:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFu-0006WE-Dl
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:34 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFr-0004Ok-1e
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:33 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so856231a12.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790466989; x=1791071789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lG+J3suELYt96W3OkQY+H0iATWW74eO2wnH4cNj4aBM=;
 b=M8pZ5iEC10qeX2mb5zUwmOVC13KK3H81VOUhANxsJdcSzCxL6+EOYBbo9/6wIX+yXX
 v0+rCsPZhHbDPz8VJ7m+cmf7EKvPOWqGe+9mTUEGA/q6Z5NcvvhKsg4UdlV3AKM/F/VY
 SydneaTSSPCWjx5s+1dgBonM/lIpB37HJ3WJ+nWmieF5MEIn3L7LJuxCztJKZJZ7xEAt
 QhjqVzDpnBy1nDCUf9/1wpHb8yzuD0LFOm4sA/sindgFH8ik9t3yeJJjyKQmWYM5y2O0
 X5eu94nHpxVh+3jL/kzQTTmmZpZZadBUxgYyv8BrLVq20ExBrDW/hx626JvyKP1/bww2
 ROoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790466989; x=1791071789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lG+J3suELYt96W3OkQY+H0iATWW74eO2wnH4cNj4aBM=;
 b=cypDt4tliSYQXlpMkhrs3/8iewGhAkgMPVX9wmDtbLKoFP7dmY+q8A11bOGzBzn1hL
 NIoIn5ccMkg6GRz/jwRFSbXVuUj1wkHoNfdZGqdwitbWEWCcH4XDPsZ4hLb8PqAg3JcN
 FbhvuBRKYI4UJdRY7SgROFS6oIwWSgfbWIX1MmCJh84MKzwdVm6PFifyDq6Y/I6TDtIv
 YmPCTB8gq+09PtNWIQPBVPxc3uOcmNgrSLH7EJKmTZOpuUoVYDVAh0VGISeu6Wle+Ur+
 av0qipEo+KM4I6dYznLPy7qQqjtvMl1Ln8tkvxXPUhlSX0HxRX7jFfC2s5uTi/uJDttv
 e8ZQ==
X-Gm-Message-State: AFq9FYLlqV9DWRNRt4a6Xs+OkAWbRWMgNUM/W542wChT4+Gj3fRb6n6E
 dhdnZ86jWJbi2ytoe+vOkgOlgQp+RRe+9eQE5j/+pfyMr4tPVJe/EjlW5G7w37dYL0WoqQ2ZeR/
 ivzNE
X-Gm-Gg: AYBFou3G6tmBcjXtKSySYRhHpu/49vFBm8rIfeFTeoETe3Bs9chIhtGj7H1ZPJKMn7z
 Iwf1+rwucw9BmlYVffhddjTxhmJcM1dbAbTHQvnx3j10+LSxtc0vQWcy8mrk8W3zuvS3EP+l86o
 UdRA+D0/AowZHC++fzZcrGOvsc5A5rM3ODOSs6sHoE1qNr4xxDkCjrlUTuvYRY0L9LewZ/ZxWRQ
 Y/7Vd9UIOkwMiOjdMdW9BJjetgyYDIjrK5ysGQFc+ZZOMZ42/POWUkgeP48G8Sk5rlxz98O65Pl
 Z1h6bgCnIYbY3gjF31v8sAz6d0mo2TA0LPXhLx3TXfNcv6KKQocph+a9xXJpnqzSHYGTR/2FRzn
 IEBbNdefXxVS5wmklx+0cAp+2i0RMxC6e4ZzAiIOpcO77zgkZ8F1TqMK7z01HP8jimIgxDJYTPd
 2SGP/6/C4lxkTZTOV822UEmwnNvtmE9MQzBkO5hM0KY2EtisqcqUX43dd1lpq66RWipCIrEdV1a
 LKuHvhdHOvMfqN9hQ4nU9so7c5RkFc=
X-Received: by 2002:a17:90a:bc9:b0:3a0:a515:c47d with SMTP id
 98e67ed59e1d1-3a0a515c8f3mr4882131a91.34.1790466989090; 
 Sat, 26 Sep 2026 16:56:29 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm18136031a91.17.2026.09.26.16.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:56:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: paul@galbraiths.ca,
	pbonzini@redhat.com
Subject: [PATCH v4 3/3] tests/tcg/i386: Add regression test for wrapping
 16-bit near branches
Date: Sat, 26 Sep 2026 16:56:20 -0700
Message-ID: <20260926235620.851099-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926235620.851099-1-richard.henderson@linaro.org>
References: <20260926235620.851099-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

From: Paul Galbraith <paul@galbraiths.ca>

Jump from IP 0xFFF0 to IP 0x0020 with a CS base that is not page
aligned, and check that EIP wraps.

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
Message-ID: <20260926032336.933-3-paul@galbraiths.ca>
[rth: Simplfy slightly with ljmpl to pass/fail.
      Put 16-bit code in its own section with labels for
      ease of disassembly via "objdump -d -M i8086 -j .text16"]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/i386/system/meson.build          |   3 +-
 tests/tcg/i386/system/test-branch-wrap16.S | 101 +++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.S

diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index 91c6e887191..a6278da3955 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -35,7 +35,8 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
 endforeach
 
 tests += {
-  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] + qemu_def_args }
+  'test-branch-wrap16.S': { 'cflags': cflags, 'qemu_args': qemu_def_args },
+  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] + qemu_def_args },
 }
 
 if 'qemu-system-i386' in emulators
diff --git a/tests/tcg/i386/system/test-branch-wrap16.S b/tests/tcg/i386/system/test-branch-wrap16.S
new file mode 100644
index 00000000000..9a64b4c6d04
--- /dev/null
+++ b/tests/tcg/i386/system/test-branch-wrap16.S
@@ -0,0 +1,101 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * A 16-bit near branch must truncate EIP to 16 bits.
+ *
+ * The test jumps from IP 0xFFF0 to IP 0x0020 in 16-bit code. The jump
+ * crosses 0xFFFF. For correct 16-bit behaviour the CPU should wrap the
+ * target to 0x0020, rather than branching to 0x10020.
+ *
+ * TCG used to skip the wrap when the untruncated target (CS base +
+ * 0x10020) was on the same guest page as the jump. That only happens
+ * when the CS base is not page aligned, so the code segment starts at
+ * a page boundary plus 0x10.
+ */
+
+#define SEL_CODE32   0x08
+#define SEL_CODE16   0x18
+
+        .data
+
+/* 0x08 and 0x10 must match boot.S, which loaded the data selectors */
+        .balign 8
+gdt16:
+        .quad 0
+        .word 0xFFFF, 0
+        .byte 0, 0x9b, 0xCF, 0
+        .word 0xFFFF, 0
+        .byte 0, 0x93, 0xCF, 0
+gdt16_code16:
+        /* 16-bit code, 64 KiB limit; main fills in the base */
+        .word 0xFFFF, 0
+        .byte 0, 0x9b, 0x00, 0
+gdt16_end:
+
+gdtr16:
+        .word gdt16_end - gdt16 - 1
+        .long gdt16
+
+fail_msg:
+        .asciz "FAIL: branch left EIP untruncated\n"
+pass_msg:
+        .asciz "PASS\n"
+
+        .section .text16, "ax"
+        .code16
+
+        /*
+         * Page aligned plus 0x10. A larger alignment breaks the
+         * multiboot load in boot.S.
+         */
+        .balign 0x1000
+        .skip 0x10
+wrap16_cs_base:
+
+        .skip 0x10
+wrap16_target:
+        /* jmp lands here when EIP wraps to 0x0020 */
+        ljmpl $SEL_CODE32, $test_passed
+
+        .org wrap16_cs_base + 0xfff0
+wrap16_entry:
+        /*
+         * The problematic branch, which should wrap EIP:
+         * 16-bit relative 'jmp target', hand-assembled because clang rejects a
+         * rel16 displacement outside [-0x8000, 0x7FFF]. But, in 16-bit code, any
+         * 16-bit displacement is valid. GAS correctly accepts any 16-bit offset.
+         */
+        .byte 0xe9                              /* jmp rel16 opcode */
+        .word wrap16_target - (. + 2)           /* cw: 16-bit offset */
+
+        .org wrap16_cs_base + 0x10020
+wrap16_fail:
+        /* jmp lands here when EIP does not wrap (0x10020) */
+        ljmpl $SEL_CODE32, $test_failed
+
+        .text
+        .code32
+        .globl main
+main:
+        movl $wrap16_cs_base, %eax
+        movw %ax, gdt16_code16 + 2
+        shrl $16, %eax
+        movb %al, gdt16_code16 + 4
+        movb %ah, gdt16_code16 + 7
+        lgdt gdtr16
+
+        ljmpw $SEL_CODE16, $0xFFF0
+
+test_passed:
+        pushl $pass_msg
+        call ml_printf
+        addl $4, %esp
+        xorl %eax, %eax
+        ret
+
+test_failed:
+        pushl $fail_msg
+        call ml_printf
+        addl $8, %esp
+        movl $1, %eax
+        ret
-- 
2.53.0


