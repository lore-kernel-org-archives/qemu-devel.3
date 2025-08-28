Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEEBCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEF-0006hM-TM; Thu, 28 Aug 2025 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb7-0007NF-9h
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb5-0000sS-Do
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:20 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4c645aaa58so496370a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383558; x=1756988358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbwavcB5p3xBMwbs2Qh5dv9jVH0cvn6kYBKvsg40cc4=;
 b=V8kYWOIl8/vFlHyocG/w20rgmFqbhe7F7NDFXHUDo82s3KlGRflYbuZJKoqQUWwn98
 G2dCrqBjAzc5aWitXJIdyXlBENwDEDHNDkK4TPiHi+O+kbtQed2rG87ncVRkQJ8gn8zX
 tNexqd081Wr1yrBBKJxk1+aXl5fAOaLV+13p1FRgSYMnXQaKeDOfVoq1DQgXV4LSOGJx
 sLRLCMcGm2rQgF1SbKQZTbfg9WDJxMwkZmpMmCfMKIRzU82tA6/C9U2QBvadqS80K1qf
 t/RnZUAhZQzC9lmROpCAMjHRbgJnAEuatL6OB/ZKp1MvIUWIJx4yYybhf+Q0LoJZ0U67
 TpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383558; x=1756988358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbwavcB5p3xBMwbs2Qh5dv9jVH0cvn6kYBKvsg40cc4=;
 b=coPrzQ2UcqcXxsx4BtE6Ucy6FGSEVowWwD0C8Mi2m5JUe35NtnPSHOskjO2b0b1XId
 0emoROm6ZZ181FDt596SWE56y/lELjDT6ZUh8PjeChvDfw4j12qK/+2tZyHGOnDbK1TC
 2TlGtVusRr8YxiCxqjXp2XV+xJrKns85yeIgSf3Pzrkr59vqSaehcD7vaGfNHW7AyyfV
 uKLyC4CKdlf/DwlbrGDRGKQ/Be34R8rdfm24vAgUCjgf7q9QB+s4BKijiGrWxWWtQ5Sg
 Oe6YgVkqQ5jqN39ZjUhyp8e24Bw3Ud2mPUr4nDIxPCfrqRPB+5m7xVWhlvJ0hQ9KMswt
 Xr0w==
X-Gm-Message-State: AOJu0YxCsEt8f3/lZkd5aJrZm7orYL3Wq/ETusVnnW9OhGuEcu99K2EY
 6FVrPPDg3o94CHjEwF+T7we3RxkGcVCecW56iDQb5xi2Ma9ehtqVWXrn5n+OPXZeAbys42kkSCv
 yxAzrBTg=
X-Gm-Gg: ASbGncsPUb2yedtRyopdv2sEryOGwovLXLWdXimeW6iNjs/uCCgL8VYN5TJcEWQRPTB
 mREwwbNIBFsuUrBGr7zAocctEg7A/vDsQ3drSbqA5oAHDA3tOqhOrbBmiWzx8zB5GuvJmEXesAw
 y9GAuejLBigq/BHQNKwbvOO5RIwLT9WAnP1NHPoGM4flJGPVW/FAuLecpPJ1cqw17dl9HSdTyMy
 HArXHj1ELcFMi7e2wodzZuOH0giZxt1CzMOSeKGkgGUdnP3I+67DgT2caJ3+jW+GY5X91B9MVVs
 HqVmwkLa7DbQDwhjV0HLvuYjLvOROSTDprWxNaexIbAyKTW+ymYc/4JZZX9L5wFJyJskaizVMnn
 qdQB5K0fhh6M+Amlo9q54V8A9UQ==
X-Google-Smtp-Source: AGHT+IF/MVTTJwTl3rKMFBo1BbrJTpQ4JVc5AwZt0RgF5Q+bwcThVqFBXRFQjSD0siPQuhhp3S2klA==
X-Received: by 2002:a17:903:3d05:b0:246:b467:eea9 with SMTP id
 d9443c01a7336-246b467f171mr199583585ad.21.1756383557876; 
 Thu, 28 Aug 2025 05:19:17 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 87/87] linux-user: Remove target_pt_regs from
 target_syscall.h
Date: Thu, 28 Aug 2025 22:08:36 +1000
Message-ID: <20250828120836.195358-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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


