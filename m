Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF57CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmo-0000tO-F9; Sat, 30 Aug 2025 11:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fm-00064W-Db
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:18 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fk-0004qA-FF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:18 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-327ceef65afso2290735a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506854; x=1757111654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prtlyWLbDAwBX5YWvmSgUP1Zf7BeweKUjDWIIAQ/vSE=;
 b=AGnsnw9s8scL4GYxeVV0yostv/y++xJmEFpjY56fy9sXC+KuVvDMdD3SaUg0P1ABDk
 Y42feKhX8KIIFMuwrafQMYkAN/fVdTnln0MlEohZI1BhtEIw51dNyUzqctA+xTymQjVT
 DwDg+JPC8n38Jo9L8VOGs+S0dstp9KEw74q1TOAeTBS6+RxDz6MfOJswlh6/215WE5R4
 p2AiuKPoL2AFG9eIaRfZPBZzTmGzv2ng+gf4NltxrQfubTehpTWDTTA0XkwXVDL1Xhj0
 zRpwTQgeJ6IN5NOKDkVH+gr1Dak3hpxdwGDG5Y2oYhO6nWF6nr6sUcweuKy6D7j0TWkJ
 wpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506854; x=1757111654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prtlyWLbDAwBX5YWvmSgUP1Zf7BeweKUjDWIIAQ/vSE=;
 b=LljAKIVGHEoLMeFfbV6u8sZE5JG3fBm0vx9kmlRFlLYb3S5kAn+85X8kIjzVGZCYUN
 mdyvz+tCxy1oqp0JEr0XOkamk9W3bM3873UpEX+K+9b8yIBz3sjlrnu3qQcsYdkgbey5
 vAnB2Ns6sU73UvmmsYfcpO0vzVsEmjAjKzKPEddagwYBUtxfeVWyJf5hgHAAe5HoDdil
 WIl8zT0TVKx5Tch+iUmD+e4ZHGqYc8tjuuQUuOI1ZSgI8LUAs/0V30AYYnYUaYfhxivm
 8p0FcuESzbHnPzYEs951YdW2mH1jyP93Gpz42PXYswXIuY113DML4f+/vgNm+1Q6I5kr
 AkvA==
X-Gm-Message-State: AOJu0YzwaF/IOVVTAKD7sDZUMT22zNU2Sc3jZzLdBpRAAbBVnGHb2MiV
 U+LfRa2i9O9HvYRfUVkiIL70MYVS1M3RR5jlbo0BzJS8rWE7hrSNOBDUWABYhI4ZejJINTZh3Mo
 ESsGbX/4=
X-Gm-Gg: ASbGncvmAMnZbKr3UGEtPYBggXWhtVgDYMwKxYAQ8UaPFLpZVC0d3ySBkxmK5lRVmQM
 sxG4Cchu//0Cb/iPUT2l1ZDOgYmLrcyZ7THN7BZU/0IZ+myphDSIkbWzeUFvmqSiYSA7sB+dogP
 LiJ33Ye0RRgtkieIE2FEABsehHSphWjbxN0tBAGW6lOdXuPr6CSek7HNbFuPycZOYxVK9SpgDM/
 Ey3ks90wn/YOR2TJLU29m1RgohAbRkQcIFgRySDReIzUEe5aVxN3gXcjtb6g03fyt9Qv0RMBov7
 xCl394fOxlfePW8VZCxEvW0fz4QTCi5fNwlVg5EwZtG2YWbKVrS+mAzadSSsuzcQp5s05E+cjCp
 ez/1fWasJzVY7DGdLuLSwdCUD9QkBD25Ig+eZVfZ1ivA6k3lSclqg2eb38q2ui1DL9H1YvWc=
X-Google-Smtp-Source: AGHT+IHtrN4I9hR/1JrnADJArYKWgBwyPdgs777zfCk2cbecIVtkomkZWXI3dS7BhqYw+FT2zsLeQQ==
X-Received: by 2002:a17:90b:3b8f:b0:325:cce7:f65b with SMTP id
 98e67ed59e1d1-328156cfb93mr364988a91.29.1756506854578; 
 Fri, 29 Aug 2025 15:34:14 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 91/91] linux-user: Remove target_pt_regs from target_syscall.h
Date: Sat, 30 Aug 2025 08:24:27 +1000
Message-ID: <20250829222427.289668-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

All target_pt_regs which have not been broken out to
target_ptrace.h by this point are unused.  Remove them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_syscall.h   | 40 -----------------------------
 linux-user/hexagon/target_syscall.h |  5 ----
 linux-user/hppa/target_syscall.h    | 18 -------------
 linux-user/m68k/target_syscall.h    | 16 ------------
 linux-user/riscv/target_syscall.h   | 35 -------------------------
 5 files changed, 114 deletions(-)

diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
index fda3a49f29..53706b749f 100644
--- a/linux-user/alpha/target_syscall.h
+++ b/linux-user/alpha/target_syscall.h
@@ -1,46 +1,6 @@
 #ifndef ALPHA_TARGET_SYSCALL_H
 #define ALPHA_TARGET_SYSCALL_H
 
-/* default linux values for the selectors */
-#define __USER_DS	(1)
-
-struct target_pt_regs {
-	abi_ulong r0;
-	abi_ulong r1;
-	abi_ulong r2;
-	abi_ulong r3;
-	abi_ulong r4;
-	abi_ulong r5;
-	abi_ulong r6;
-	abi_ulong r7;
-	abi_ulong r8;
-	abi_ulong r19;
-	abi_ulong r20;
-	abi_ulong r21;
-	abi_ulong r22;
-	abi_ulong r23;
-	abi_ulong r24;
-	abi_ulong r25;
-	abi_ulong r26;
-	abi_ulong r27;
-	abi_ulong r28;
-	abi_ulong hae;
-/* JRP - These are the values provided to a0-a2 by PALcode */
-	abi_ulong trap_a0;
-	abi_ulong trap_a1;
-	abi_ulong trap_a2;
-/* These are saved by PAL-code: */
-	abi_ulong ps;
-	abi_ulong pc;
-	abi_ulong gp;
-	abi_ulong r16;
-	abi_ulong r17;
-	abi_ulong r18;
-/* Those is needed by qemu to temporary store the user stack pointer */
-        abi_ulong usp;
-        abi_ulong unique;
-};
-
 #define UNAME_MACHINE "alpha"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/hexagon/target_syscall.h b/linux-user/hexagon/target_syscall.h
index 7f91a4abc7..d9c94737a5 100644
--- a/linux-user/hexagon/target_syscall.h
+++ b/linux-user/hexagon/target_syscall.h
@@ -18,11 +18,6 @@
 #ifndef HEXAGON_TARGET_SYSCALL_H
 #define HEXAGON_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    abi_long sepc;
-    abi_long sp;
-};
-
 #define UNAME_MACHINE "hexagon"
 #define UNAME_MINIMUM_RELEASE "4.15.0"
 
diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index 9a8f8ca628..4b21e85371 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -1,24 +1,6 @@
 #ifndef HPPA_TARGET_SYSCALL_H
 #define HPPA_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    target_ulong gr[32];
-    uint64_t     fr[32];
-    target_ulong sr[8];
-    target_ulong iasq[2];
-    target_ulong iaoq[2];
-    target_ulong cr27;
-    target_ulong __pad0;
-    target_ulong orig_r28;
-    target_ulong ksp;
-    target_ulong kpc;
-    target_ulong sar;
-    target_ulong iir;
-    target_ulong isr;
-    target_ulong ior;
-    target_ulong ipsw;
-};
-
 #define UNAME_MACHINE "parisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 #define TARGET_CLONE_BACKWARDS
diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
index 8d4ddbd76c..3ca0231c70 100644
--- a/linux-user/m68k/target_syscall.h
+++ b/linux-user/m68k/target_syscall.h
@@ -1,22 +1,6 @@
 #ifndef M68K_TARGET_SYSCALL_H
 #define M68K_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-    abi_long d1, d2, d3, d4, d5, d6, d7;
-    abi_long a0, a1, a2, a3, a4, a5, a6;
-    abi_ulong d0;
-    abi_ulong usp;
-    abi_ulong orig_d0;
-    int16_t stkadj;
-    uint16_t sr;
-    abi_ulong pc;
-    uint16_t fntvex;
-    uint16_t __fill;
-};
-
 #define UNAME_MACHINE "m68k"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
index 7601f10c28..69a7b753eb 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -8,41 +8,6 @@
 #ifndef LINUX_USER_RISCV_TARGET_SYSCALL_H
 #define LINUX_USER_RISCV_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    abi_long sepc;
-    abi_long ra;
-    abi_long sp;
-    abi_long gp;
-    abi_long tp;
-    abi_long t0;
-    abi_long t1;
-    abi_long t2;
-    abi_long s0;
-    abi_long s1;
-    abi_long a0;
-    abi_long a1;
-    abi_long a2;
-    abi_long a3;
-    abi_long a4;
-    abi_long a5;
-    abi_long a6;
-    abi_long a7;
-    abi_long s2;
-    abi_long s3;
-    abi_long s4;
-    abi_long s5;
-    abi_long s6;
-    abi_long s7;
-    abi_long s8;
-    abi_long s9;
-    abi_long s10;
-    abi_long s11;
-    abi_long t3;
-    abi_long t4;
-    abi_long t5;
-    abi_long t6;
-};
-
 #ifdef TARGET_RISCV32
 #define UNAME_MACHINE "riscv32"
 #define UNAME_MINIMUM_RELEASE "5.4.0"
-- 
2.43.0


