Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63ACC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgv4-0008C3-RK; Fri, 21 Mar 2025 14:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvgv1-0008Bg-34
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguy-0001Ki-2L
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so14203145e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580986; x=1743185786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPZBH8y1q2dMsxNWLz+3tBAuN1XftmDrZUlAjxNrm7c=;
 b=DuEcg0L5mNgyAZ9p0VwNWsaQ/28htGAgVhEQWmetuXmw6ySwcCLo3tmNCMF7oZ8Gv4
 mePnG0fi1dgqjGrAc3FWiOo7U7wR0s3Nl65zNyK+QFrCqfS+qfa8u9M+VZLf9NA431dp
 hRIlk1EGl61bnYtsj2aTcq7ugDfwdHnwliIQj34qfzOlDuybTm7FhB+suoL5zOYfxSeF
 x4KoHzRuJmjtT7lnYV1W+cgRjCosFFmEkAOv7Gw9YTjb7u2LcgsDpNB3k4EwsxZXu7z4
 KiGBLmXdFzVPGb/Ky8zK9lARvvaziB2Tn1qztuW4DSyDCNEENW8uS2DIQGjitx56H1lq
 JHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580986; x=1743185786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPZBH8y1q2dMsxNWLz+3tBAuN1XftmDrZUlAjxNrm7c=;
 b=vtTi1rDm/a5T0SNXjowwXRWUkufFhy30KqmSLrvDEfHu3X6sfWNzkdUtExNfsMJorT
 2m8kGqLKHeoxM+Mrl5RU5SuzIyJC6bnUIeFqEeYdAp2WSxZCc//EnDrjlLJmVYkXWyVs
 Le6VP502wcpRXmStrgcPd6I7sd8dcCd4cmx+oC4I4F5tWeLi9gowx8AQN021dg93jO9A
 4ZLoSemIO2R70EvX3LPnE0nwV/whjhzCvJYGBVLSg6hH9/yKrOZRyKwKg8BBcADMhF7J
 PilzmWT94XHBQ1GIXUOZJxE9hLFrSnN5snF/He5l3n8+AM8izUecnYKizuE9p41bZhF/
 DV2g==
X-Gm-Message-State: AOJu0Yy51+VmGXFKXiBdRiU6zLsWCnaKWtCAqECndeQfXHDzW0LceNmJ
 RTZVC/1zZFImFO1sr0kr6aSiZ4kdnZ7GG3NdmoLPUNVYBbXmsvm7BUk78QdPZ1Qk9wd9QmXDYBx
 J
X-Gm-Gg: ASbGncvMdjcCDIHCaBqeBbFInJoDJqcrEri7UT9uF7CC7FSu9fpzkVLw2SRMtjCz+Lu
 UEJtO8Ow4X6PFP70WXCl04SfXSZ9HFAZRA0pswsJ7NCBRK2sJsbjQ1bVw92WkR+aKdbBnXyDE8S
 q1KX1FLsr0TkVtLit8FcqwnbN6V+3mQ59HTinWM7CSHPxBe10ZBF1HlUWXnJUPm3dGLJJVqlTZC
 B1N2k3/rjwarCv+tRaFk9xkv0sqsgIpHiGNLa4mZuMuf/YRROG/1f7CSPBA1XJZlGbasWGHY9FU
 VxW0JfKNH2k98mbP+84IMEhZurbJ7cQUcOch8K9jjMBy3BFHUeIczMp/0NUp7j9wPQzUpZjoqqt
 md4GiXyEMqJqhvcpXQ7c=
X-Google-Smtp-Source: AGHT+IHPtpRq8sUAAYBW86ZKFcMs/4tr1Fr77SXJWbQ/TbYL1Q7/xZyPORQBxRn5yyihciHAXszpwA==
X-Received: by 2002:a05:600c:4503:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43d509f41famr51042345e9.15.1742580986075; 
 Fri, 21 Mar 2025 11:16:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a6326sm2926093f8f.29.2025.03.21.11.16.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 7/7] tcg: Remove the TCG_GUEST_DEFAULT_MO
 definition globally
Date: Fri, 21 Mar 2025 19:15:49 +0100
Message-ID: <20250321181549.3331-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

By directly using TCGCPUOps::guest_default_memory_order,
we don't need the TCG_GUEST_DEFAULT_MO definition anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/multi-thread-tcg.rst |  4 ++--
 target/alpha/cpu-param.h        |  3 ---
 target/arm/cpu-param.h          |  3 ---
 target/avr/cpu-param.h          |  2 --
 target/hexagon/cpu-param.h      |  3 ---
 target/hppa/cpu-param.h         |  8 --------
 target/i386/cpu-param.h         |  3 ---
 target/loongarch/cpu-param.h    |  2 --
 target/m68k/cpu-param.h         |  3 ---
 target/microblaze/cpu-param.h   |  3 ---
 target/mips/cpu-param.h         |  2 --
 target/openrisc/cpu-param.h     |  2 --
 target/ppc/cpu-param.h          |  2 --
 target/riscv/cpu-param.h        |  2 --
 target/rx/cpu-param.h           |  3 ---
 target/s390x/cpu-param.h        |  6 ------
 target/sh4/cpu-param.h          |  3 ---
 target/sparc/cpu-param.h        | 23 -----------------------
 target/tricore/cpu-param.h      |  3 ---
 target/xtensa/cpu-param.h       |  3 ---
 target/alpha/cpu.c              |  3 ++-
 target/arm/cpu.c                |  3 ++-
 target/arm/tcg/cpu-v7m.c        |  3 ++-
 target/avr/cpu.c                |  2 +-
 target/hexagon/cpu.c            |  3 ++-
 target/hppa/cpu.c               |  8 +++++++-
 target/i386/tcg/tcg-cpu.c       |  5 ++++-
 target/loongarch/cpu.c          |  2 +-
 target/m68k/cpu.c               |  3 ++-
 target/microblaze/cpu.c         |  3 ++-
 target/mips/cpu.c               |  2 +-
 target/openrisc/cpu.c           |  2 +-
 target/ppc/cpu_init.c           |  2 +-
 target/riscv/tcg/tcg-cpu.c      |  2 +-
 target/rx/cpu.c                 |  3 ++-
 target/s390x/cpu.c              |  6 +++++-
 target/sh4/cpu.c                |  3 ++-
 target/sparc/cpu.c              | 23 ++++++++++++++++++++++-
 target/tricore/cpu.c            |  3 ++-
 target/xtensa/cpu.c             |  3 ++-
 40 files changed, 66 insertions(+), 101 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index b0f473961dd..14a2a9dc7b5 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -28,8 +28,8 @@ vCPU Scheduling
 We introduce a new running mode where each vCPU will run on its own
 user-space thread. This is enabled by default for all FE/BE
 combinations where the host memory model is able to accommodate the
-guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the
-guest has had the required work done to support this safely
+guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO is zero)
+and the guest has had the required work done to support this safely
 (TARGET_SUPPORTS_MTTCG).
 
 System emulation will fall back to the original round robin approach
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index ff06e41497a..c74556d2667 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -25,7 +25,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 896b35bd6d5..55de4d54544 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -38,7 +38,4 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif /* !CONFIG_USER_ONLY */
 
-/* ARM processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1f..11e827109c0 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -31,6 +31,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 2d57ea6caf9..45ee7b46409 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,7 +23,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 7ed6b5741e7..e0b2c7c9157 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -19,12 +19,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-/* PA-RISC 1.x processors have a strong memory model.  */
-/*
- * ??? While we do not yet implement PA-RISC 2.0, those processors have
- * a weak memory model, but with TLB bits that force ordering on a per-page
- * basis.  It's probably easier to fall back to a strong memory model.
- */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index b0e884c5d70..909bc027923 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,7 +22,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e56..071567712b3 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 1a909eaa13e..7afbf6d302d 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,7 +17,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index c866ec6c149..6a0714bb3d7 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,7 +27,4 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 11b3ac0ac63..35fb6ea7243 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -25,6 +25,4 @@
 #define TARGET_PAGE_BITS_MIN 12
 #endif
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 37627f2c394..3011bf5fcca 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 6c4525fdf3c..2cee113ddd3 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -38,6 +38,4 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index fba30e966a8..a80310ef2c5 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -26,6 +26,4 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 2ce199164d7..ef1970a09e9 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,7 +24,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 5c331ec424c..a5f798eeae7 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -12,10 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
-/*
- * The z/Architecture has a strong memory model with some
- * store-after-load re-ordering.
- */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 1bc90d4695e..2b6e11dd0ac 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,7 +16,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 6952ee2b826..6e8e2a51469 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -21,27 +21,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/*
- * From Oracle SPARC Architecture 2015:
- *
- *   Compatibility notes: The PSO memory model described in SPARC V8 and
- *   SPARC V9 compatibility architecture specifications was never implemented
- *   in a SPARC V9 implementation and is not included in the Oracle SPARC
- *   Architecture specification.
- *
- *   The RMO memory model described in the SPARC V9 specification was
- *   implemented in some non-Sun SPARC V9 implementations, but is not
- *   directly supported in Oracle SPARC Architecture 2015 implementations.
- *
- * Therefore always use TSO in QEMU.
- *
- * D.5 Specification of Partial Store Order (PSO)
- *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
- *
- * D.6 Specification of Total Store Order (TSO)
- *   ... PSO with the additional requirement that all [stores] are followed
- *   by an implied MEMBAR #StoreStore.
- */
-#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
-
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 923459370cc..790242ef3d2 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,7 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad059..06d85218b84 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,7 +16,4 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 00905d48621..e5e14976f51 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,7 +239,8 @@ static const TCGCPUOps alpha_tcg_ops = {
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Alpha processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9e858ae8c77..8b9f2acf82b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2675,7 +2675,8 @@ static const TCGCPUOps arm_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 6f714324ffd..df6b7198944 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,7 +238,8 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 330e50f74e7..24e52e28f44 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,7 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 };
 
 static void avr_cpu_class_init(ObjectClass *oc, void *data)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 669f7440f52..34734b0edb0 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -324,7 +324,8 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 15cbcd2d957..997bd69db19 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -257,7 +257,13 @@ static const TCGCPUOps hppa_tcg_ops = {
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* PA-RISC 1.x processors have a strong memory model.  */
+    /*
+     * ??? While we do not yet implement PA-RISC 2.0, those processors have
+     * a weak memory model, but with TLB bits that force ordering on a per-page
+     * basis.  It's probably easier to fall back to a strong memory model.
+     */
+    .guest_default_memory_order = TCG_MO_ALL,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index de2fe8e04f4..4a76c475971 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -129,7 +129,10 @@ static const TCGCPUOps x86_tcg_ops = {
     .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The x86 has a strong memory model with some store-after-load re-ordering
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 };
 
 static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5b9dd5048d4..c39ff056157 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -869,7 +869,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index dc742ddc2cb..e96b379e266 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -593,7 +593,8 @@ static const TCGCPUOps m68k_tcg_ops = {
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 32f9e32502c..4b9ef6e52c4 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -432,7 +432,8 @@ static const TCGCPUOps mb_tcg_ops = {
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MicroBlaze is always in-order. */
+    .guest_default_memory_order = TCG_MO_ALL,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 207b7d3c8db..5ddc9bbb829 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,7 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index c6a1d603afb..6a878aaadd8 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -248,7 +248,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 28f6f6bc2ba..28fbbb8d3c1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7490,7 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
-  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+  .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0e5fa10784d..fb903992faa 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -139,7 +139,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index ae78c661079..6a24e7e9136 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -213,7 +213,8 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, void *data)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 975b8353026..12fd853c00a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -361,7 +361,11 @@ static const TCGCPUOps s390_tcg_ops = {
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The z/Architecture has a strong memory model with some
+     * store-after-load re-ordering.
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 };
 #endif /* CONFIG_TCG */
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 6d319dd01c7..ce9ed75107a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -267,7 +267,8 @@ static const TCGCPUOps superh_tcg_ops = {
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 961c7f92a84..39bd0c42855 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,7 +1005,28 @@ static const TCGCPUOps sparc_tcg_ops = {
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * From Oracle SPARC Architecture 2015:
+     *
+     *   Compatibility notes: The PSO memory model described in SPARC V8 and
+     *   SPARC V9 compatibility architecture specifications was never
+     *   implemented in a SPARC V9 implementation and is not included in the
+     *   Oracle SPARC Architecture specification.
+     *
+     *   The RMO memory model described in the SPARC V9 specification was
+     *   implemented in some non-Sun SPARC V9 implementations, but is not
+     *   directly supported in Oracle SPARC Architecture 2015 implementations.
+     *
+     * Therefore always use TSO in QEMU.
+     *
+     * D.5 Specification of Partial Store Order (PSO)
+     *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+     *
+     * D.6 Specification of Total Store Order (TSO)
+     *   ... PSO with the additional requirement that all [stores] are followed
+     *   by an implied MEMBAR #StoreStore.
+     */
+    .guest_default_memory_order = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 960e7093f1c..e0a48065948 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -179,7 +179,8 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 0a4068ad7bf..dd9061ba469 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -237,7 +237,8 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Xtensa processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
-- 
2.47.1


