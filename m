Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F196AC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZO-0008AD-7p; Fri, 07 Feb 2025 16:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ5-0007ZG-EA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:07 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ3-00023l-BI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:07 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f50895565so17731295ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962424; x=1739567224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzZogz5f66qmacMYOhcZXgO+/2EwLVWTtxU+MCKdark=;
 b=UTbb8d1Tb8/vZve7FlwFJ35OpJxgMWpEKJC5jcCvBPLlkZ2crlVMr9hlzyxej+YnBP
 eXYj/8uG1bggkHV5lJ/75DJU44Yh0NoY07GGpL7VEgvL91aKCqBLkEGj9g69Ff+oZ8ov
 QF/6GQ0bcHxXWemRHEvFAUpz9+vHanWGVLFJ0AacM4/ccMM4uCyM3CJZsAZy130qQtxc
 hqPuNQK8pQ3iN8k77LQWb4n8+8Sl7z4rpRJW0vGXQHJgc8BmAQqDkYwyyuMRjzgHyaFt
 zSKxaAM7m2cYu569lCtejXb5GmyuFH1NR9JbfXwxCAIJYH15l5qoQtoOEkWN/pA+JyDl
 DB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962424; x=1739567224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzZogz5f66qmacMYOhcZXgO+/2EwLVWTtxU+MCKdark=;
 b=RNHge42YSD5X2RVVD5oCkRStx0CMIcemtU1qn8x9ysFcESiohjC0aZORsd+slKXs4X
 J6zMWLvmpjQ+jmy5LJjvAx/4lF+km61Ly+1k6NAZMEo7CXNAXkaQpW1Qy6o+3ffbJJls
 XM0okcsph45IBAz01mdIpeVKoyH9/y9r+eQU+7H54gWIlKTC/IGJC7W2grCZgDnC5zrN
 tY8S4Ze5+aIy2O92llXPPGECbMkGuax9ooX+0C1BGVYRFkEhTTAl5bQPV8473nkenDpH
 yYXJvip7f3eWIF/QRI5pkozcTPm2gbtRjt+aoBBqeMyoCuObFR39zVfIpv3f4EnpMFgJ
 /VUw==
X-Gm-Message-State: AOJu0YzBlRcRniyv55rQQ0Ds+kjkn+bI/gMkgd40SNM4cJaP9uSJIxxa
 EHuLm3JJ9sTENXTS/25SfPVa7FuYf8a9XqEvnpW8NAWZpJ9YZZGOlG2VwtO1uNkjR/tr0Ln1+OD
 9
X-Gm-Gg: ASbGncsWf9zsX4vzdvqpEJblfxGvP8u3DiunhfsrwR8ns5noL3yYTDRZvGXHLt3C7x/
 BUzV1brYmesnQBdCAONWixki4YR7LdXIyYocHWjb3mINDgsD0Vip5x7dmou9EHjYVZVDka2EVR4
 Yz5MIQtW6pwaPqIko9U31zpc3nti4CACBv7oyPVjWhTGhN1/ETK7S1r/4xeqMxfKIY+p2085Hm7
 2NOHJJklyY3fNxKtzociaSpHLqJsT0XFQZ+fmhIUmSwA6Shrkz3tQ+4dmhUQ38TnFrdXhYvyMDt
 xWpSRWPVwVr5qOOdxg+sMpIkuzJC76K2vCi1FewrixyBRmk=
X-Google-Smtp-Source: AGHT+IGA6vyJTwtlrnrG65p38CBXMFBcw3/MLguJEcFscCj9PeZblCKx7XOhhL41skHV/bLZggwscA==
X-Received: by 2002:a05:6a21:338a:b0:1e1:cbbf:be0 with SMTP id
 adf61e73a8af0-1ee03a8f4edmr7941298637.22.1738962423974; 
 Fri, 07 Feb 2025 13:07:03 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 7/9] target/*: Remove TARGET_LONG_BITS from cpu-param.h
Date: Fri,  7 Feb 2025 13:06:53 -0800
Message-ID: <20250207210655.16717-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This is now handled by the configs/targets/*.mak fragment.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h      | 2 --
 target/arm/cpu-param.h        | 2 --
 target/avr/cpu-param.h        | 1 -
 target/hexagon/cpu-param.h    | 1 -
 target/hppa/cpu-param.h       | 2 --
 target/i386/cpu-param.h       | 2 --
 target/loongarch/cpu-param.h  | 1 -
 target/m68k/cpu-param.h       | 1 -
 target/microblaze/cpu-param.h | 2 --
 target/mips/cpu-param.h       | 5 -----
 target/openrisc/cpu-param.h   | 1 -
 target/ppc/cpu-param.h        | 2 --
 target/riscv/cpu-param.h      | 2 --
 target/rx/cpu-param.h         | 1 -
 target/s390x/cpu-param.h      | 1 -
 target/sh4/cpu-param.h        | 1 -
 target/sparc/cpu-param.h      | 2 --
 target/tricore/cpu-param.h    | 1 -
 target/xtensa/cpu-param.h     | 1 -
 19 files changed, 31 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index c21ddf1afd..ff06e41497 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -8,8 +8,6 @@
 #ifndef ALPHA_CPU_PARAM_H
 #define ALPHA_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 64
-
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
 
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index bed29613c8..896b35bd6d 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -9,11 +9,9 @@
 #define ARM_CPU_PARAM_H
 
 #ifdef TARGET_AARCH64
-# define TARGET_LONG_BITS             64
 # define TARGET_PHYS_ADDR_SPACE_BITS  52
 # define TARGET_VIRT_ADDR_SPACE_BITS  52
 #else
-# define TARGET_LONG_BITS             32
 # define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 93c2f470d0..81f3f49ee1 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -21,7 +21,6 @@
 #ifndef AVR_CPU_PARAM_H
 #define AVR_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 /*
  * TARGET_PAGE_BITS cannot be more than 8 bits because
  * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 71b4a9b83e..45ee7b4640 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -19,7 +19,6 @@
 #define HEXAGON_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 16     /* 64K pages */
-#define TARGET_LONG_BITS 32
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index ef3200f0f3..7ed6b5741e 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -8,8 +8,6 @@
 #ifndef HPPA_CPU_PARAM_H
 #define HPPA_CPU_PARAM_H
 
-#define TARGET_LONG_BITS              64
-
 #if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
 # define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 8c75abe141..b0e884c5d7 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -9,7 +9,6 @@
 #define I386_CPU_PARAM_H
 
 #ifdef TARGET_X86_64
-# define TARGET_LONG_BITS             64
 # define TARGET_PHYS_ADDR_SPACE_BITS  52
 /*
  * ??? This is really 48 bits, sign-extended, but the only thing
@@ -18,7 +17,6 @@
  */
 # define TARGET_VIRT_ADDR_SPACE_BITS  47
 #else
-# define TARGET_LONG_BITS             32
 # define TARGET_PHYS_ADDR_SPACE_BITS  36
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index db5ad1c69f..52437946e5 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef LOONGARCH_CPU_PARAM_H
 #define LOONGARCH_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 64
 #define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 5bbe623ba7..7afbf6d302 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef M68K_CPU_PARAM_H
 #define M68K_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 /*
  * Coldfire Linux uses 8k pages
  * and m68k linux uses 4k pages
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 00efb509e3..c866ec6c14 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -17,11 +17,9 @@
  * of address space.
  */
 #ifdef CONFIG_USER_ONLY
-#define TARGET_LONG_BITS 32
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #else
-#define TARGET_LONG_BITS 64
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index f3a37e2dbe..11b3ac0ac6 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -7,11 +7,6 @@
 #ifndef MIPS_CPU_PARAM_H
 #define MIPS_CPU_PARAM_H
 
-#ifdef TARGET_MIPS64
-# define TARGET_LONG_BITS 64
-#else
-# define TARGET_LONG_BITS 32
-#endif
 #ifdef TARGET_ABI_MIPSN64
 #define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 6169ed9f55..37627f2c39 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef OPENRISC_CPU_PARAM_H
 #define OPENRISC_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 13
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 9c481b9f6c..6c4525fdf3 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -9,7 +9,6 @@
 #define PPC_CPU_PARAM_H
 
 #ifdef TARGET_PPC64
-# define TARGET_LONG_BITS 64
 /*
  * Note that the official physical address space bits is 62-M where M
  * is implementation dependent.  I've not looked up M for the set of
@@ -27,7 +26,6 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 64
 # endif
 #else
-# define TARGET_LONG_BITS 32
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 25686192c0..fba30e966a 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -9,11 +9,9 @@
 #define RISCV_CPU_PARAM_H
 
 #if defined(TARGET_RISCV64)
-# define TARGET_LONG_BITS 64
 # define TARGET_PHYS_ADDR_SPACE_BITS 56 /* 44-bit PPN */
 # define TARGET_VIRT_ADDR_SPACE_BITS 48 /* sv48 */
 #elif defined(TARGET_RISCV32)
-# define TARGET_LONG_BITS 32
 # define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 521d669bdf..ef1970a09e 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -19,7 +19,6 @@
 #ifndef RX_CPU_PARAM_H
 #define RX_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 12
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index a05ffcf78d..5c331ec424 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef S390_CPU_PARAM_H
 #define S390_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 12
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index a30ba992b3..2b6e11dd0a 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef SH4_CPU_PARAM_H
 #define SH4_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 12  /* 4k */
 #define TARGET_PHYS_ADDR_SPACE_BITS  32
 #ifdef CONFIG_USER_ONLY
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 14105dc18b..6952ee2b82 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -8,7 +8,6 @@
 #define SPARC_CPU_PARAM_H
 
 #ifdef TARGET_SPARC64
-# define TARGET_LONG_BITS 64
 # define TARGET_PAGE_BITS 13 /* 8k */
 # define TARGET_PHYS_ADDR_SPACE_BITS  41
 # ifdef TARGET_ABI32
@@ -17,7 +16,6 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 44
 # endif
 #else
-# define TARGET_LONG_BITS 32
 # define TARGET_PAGE_BITS 12 /* 4k */
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index e29d551dd6..790242ef3d 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef TRICORE_CPU_PARAM_H
 #define TRICORE_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 14
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 0000725f2f..5e4848ad05 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef XTENSA_CPU_PARAM_H
 #define XTENSA_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 32
 #define TARGET_PAGE_BITS 12
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


