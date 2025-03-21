Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF81C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveoU-0001mO-4W; Fri, 21 Mar 2025 12:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemk-0000d9-VJ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemh-0004RX-L9
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso22772225e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572786; x=1743177586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXpyXRlk1mV6j3CJQ2ag1OnZd2L/6aCZGApR0YJeQRw=;
 b=nuxPiQnxR5bXQKgVIcf90Tm4L+ns8t3SLrRYxJSdXnLHZAQGiknZjTAjRW8O50x8Rt
 6CZUU6WLD2FScdQq2awdp1s9IcneAXjGf4T/M6BGEWAvHL0S08kwzoY6PSSxzxgF8KAn
 LpadO0wLXsERF5bcE/cNrL1xIBRnCEMhaqWFPMIVW/T+5XHvZw1nM2xJcUu2WnCfw0Eg
 9rG1hFWfDh2xjj/UC8VQNMr0f0KwUG+y48i3++h+zUL560gw1hJ7Jx2sksZpdTJmNfBU
 U7MYLWmC6j4wSZkEYxkZPUAOusxmtxijtZu6eLiGTjVYT1GokQm/mcP7yLNyQ3yAgUBA
 G0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572786; x=1743177586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXpyXRlk1mV6j3CJQ2ag1OnZd2L/6aCZGApR0YJeQRw=;
 b=HN9p6PeEzxyFKDEtuduNy6aZSoUrI4QHVblhuDyB2EjE64nb1xThUG/Pn/7iCt3cvw
 lYaZq2yF73D8Z0NQ2D7tw1ihCTkwDK/0kapFyOPxLWwbs/fU5iDAz8eQQRfs+LLjcAOw
 RA9+D8XiA6XompZw8ljxEP6bVRPUr/ahBnDgA4fv6+Xqw4682Jb27zNaDLmHiYN9U19t
 +lzy0WmxEm5gSPFadIiNPg/Lvfay/IZHxCpeo26z0IZuNAHDttfK9Wr+VG/t1Y0p0cyy
 jQg+elXbgJ5jWck5dC8ysqDqOwsVoYIqD/uHeVPgSfzBZGk6ncEHJnqEkBa4rYigF8yX
 eW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ySa7GeEmedjBnw5q9OkBDJX89hjKWKENGjYL/K122rCFeuFcWB4K4hamVNmdqRETJFBp+C67nYUx@nongnu.org
X-Gm-Message-State: AOJu0YzGPyAM5OJdtKX3of1NHQBTQ3cik3CY3GrCbS9rtqX0DaSrOx7C
 yl1mvCeHdP4yMc3+FhkNKVMzc8hWTF8H6MVeMcE1xP9AJC5bo3HDyuxjwid8YYs=
X-Gm-Gg: ASbGncuR33a8Zc8SM73Qs6237BhCwDBv9CuNZ6l5lE2VVgijh7AreKKlzEo9sqYVkb4
 dqfOEOwA5pGDlLhCGDS56/KQRu8nj/LWGSD57Y5bEgcPpdKNX0lw4cwZBTmW0NTqbh3ZPojQH8Z
 eIWw+KZ+W+cLTFnWkMaLeTVxAPcdKBupo6FbTsyXVjQu37ADWLnk9YeEy5xjDQPygOXlAf0IQQC
 kaQ9Ct/BCgqIrY/9HJimfV5+ppBB5repFH8gsENiLDI27k82/34GRGWuU0Ba1qyI2YCyQl8+sgZ
 hLyHTZafGodsVkKCczcVku7RR++40Wrx4OG5wPGcj6RHBA9rsn6NjBrIac5TEd++P8hRDD3ooTO
 RroBhnFhCfiIYKuFXlxJpw296D+5Mdw==
X-Google-Smtp-Source: AGHT+IEcX87Lc5sB8DrzF4GlO/fyqPCjptTHDiCNubBbR8TnoR+ddYeYVXD8++etivfi38XgblEyWw==
X-Received: by 2002:a05:600c:35ca:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-43d50873bedmr42318745e9.0.1742572785688; 
 Fri, 21 Mar 2025 08:59:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47196sm80755545e9.16.2025.03.21.08.59.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 08:59:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
Date: Fri, 21 Mar 2025 16:59:24 +0100
Message-ID: <20250321155925.96626-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321155925.96626-1-philmd@linaro.org>
References: <20250321155925.96626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
have each target set the 'mttcg_supported' field in the TCGCPUOps
structure.

Since so far we only emulate one target architecture at a time,
tcg_init_machine() gets whether MTTCG is supported via the
&first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/multi-thread-tcg.rst          | 2 +-
 configs/targets/aarch64-softmmu.mak      | 1 -
 configs/targets/alpha-softmmu.mak        | 1 -
 configs/targets/arm-softmmu.mak          | 1 -
 configs/targets/hppa-softmmu.mak         | 1 -
 configs/targets/i386-softmmu.mak         | 1 -
 configs/targets/loongarch64-softmmu.mak  | 1 -
 configs/targets/microblaze-softmmu.mak   | 1 -
 configs/targets/microblazeel-softmmu.mak | 1 -
 configs/targets/mips-softmmu.mak         | 1 -
 configs/targets/mipsel-softmmu.mak       | 1 -
 configs/targets/or1k-softmmu.mak         | 1 -
 configs/targets/ppc64-softmmu.mak        | 1 -
 configs/targets/riscv32-softmmu.mak      | 1 -
 configs/targets/riscv64-softmmu.mak      | 1 -
 configs/targets/s390x-softmmu.mak        | 1 -
 configs/targets/sparc-softmmu.mak        | 1 -
 configs/targets/sparc64-softmmu.mak      | 1 -
 configs/targets/x86_64-softmmu.mak       | 1 -
 configs/targets/xtensa-softmmu.mak       | 1 -
 configs/targets/xtensaeb-softmmu.mak     | 1 -
 include/accel/tcg/cpu-ops.h              | 8 ++++++++
 include/exec/poison.h                    | 1 -
 accel/tcg/tcg-all.c                      | 7 ++-----
 target/alpha/cpu.c                       | 1 +
 target/arm/cpu.c                         | 1 +
 target/arm/tcg/cpu-v7m.c                 | 1 +
 target/avr/cpu.c                         | 1 +
 target/hexagon/cpu.c                     | 1 +
 target/hppa/cpu.c                        | 1 +
 target/i386/tcg/tcg-cpu.c                | 1 +
 target/loongarch/cpu.c                   | 1 +
 target/m68k/cpu.c                        | 1 +
 target/microblaze/cpu.c                  | 1 +
 target/mips/cpu.c                        | 1 +
 target/openrisc/cpu.c                    | 1 +
 target/ppc/cpu_init.c                    | 1 +
 target/riscv/tcg/tcg-cpu.c               | 1 +
 target/rx/cpu.c                          | 1 +
 target/s390x/cpu.c                       | 1 +
 target/sh4/cpu.c                         | 1 +
 target/sparc/cpu.c                       | 1 +
 target/tricore/cpu.c                     | 1 +
 target/xtensa/cpu.c                      | 1 +
 44 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 14a2a9dc7b5..da9a1530c9f 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -30,7 +30,7 @@ user-space thread. This is enabled by default for all FE/BE
 combinations where the host memory model is able to accommodate the
 guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO is zero)
 and the guest has had the required work done to support this safely
-(TARGET_SUPPORTS_MTTCG).
+(TCGCPUOps::mttcg_supported).
 
 System emulation will fall back to the original round robin approach
 if:
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 82cb72cb83d..5dfeb35af90 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 # needed by boot.c
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 89f3517aca0..5275076e50d 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=alpha
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index afc64f5927b..6a5a8eda949 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=arm
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index 63ca74ed5e6..ea331107a08 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 5dd89217560..e9d89e8ab41 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 351341132f6..fc44c54233d 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index 99a33ed44a8..23457d0ae65 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=microblaze
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 52cdeae1a28..c82c509623d 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index b62a0882499..c9588066b8d 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 620ec681785..90e09bdc3e5 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=mips
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index adfddb1a8ac..0e47d9878b0 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=openrisc
-TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 7cee0e97f43..74572864b36 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 # all boards require libfdt
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index c828066ce6b..db55275b868 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 09f613d24a0..2bdd4a62cd2 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 5242ebe7c2e..76dd5de6584 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 78c2e25bd13..57801faf1fc 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index f7bab97a002..2504e31ae33 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 1ceefde1313..5619b2bc686 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index 65845df4ffa..2a9797338a6 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=xtensa
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index f1f789d6971..5204729af8b 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 5fd299cefb6..31e63b8a663 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -19,6 +19,14 @@
 #include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+    /**
+     * mttcg_supported: multi-threaded TCG is supported
+     *
+     * Target (TCG frontend) supports:
+     *   - atomic instructions
+     *   - memory ordering primitives (barriers)
+     */
+    bool mttcg_supported;
 
     /**
      * @guest_default_memory_order: default barrier that is required
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ed04b31083..6df627868c6 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -35,7 +35,6 @@
 
 #pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
-#pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison BSWAP_NEEDED
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 2b7f89eaa20..50b3fd75c32 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -41,6 +41,7 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #endif
+#include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
 #include "cpu-param.h"
 
@@ -91,11 +92,7 @@ static int tcg_init_machine(MachineState *ms)
 #else
     unsigned max_cpus = ms->smp.max_cpus;
 #endif
-#ifdef TARGET_SUPPORTS_MTTCG
-    bool mttcg_supported = true;
-#else
-    bool mttcg_supported = false;
-#endif
+    bool mttcg_supported = first_cpu->cc->tcg_ops->mttcg_supported; /* FIXME avoid first_cpu */
 
     tcg_allowed = true;
     mttcg_enabled = s->mttcg_enabled;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e5e14976f51..2bad59a48a4 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,6 +239,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* Alpha processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8b9f2acf82b..a332d9a5148 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2675,6 +2675,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index df6b7198944..7069a7a2ca8 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 24e52e28f44..9bc921c1cb2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,6 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
+    .mttcg_supported = false,
     .guest_default_memory_order = 0,
 };
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 34734b0edb0..7bcf297998f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -324,6 +324,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 997bd69db19..31f29a95ac0 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -257,6 +257,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* PA-RISC 1.x processors have a strong memory model.  */
     /*
      * ??? While we do not yet implement PA-RISC 2.0, those processors have
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 4a76c475971..62d36880ceb 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -129,6 +129,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 
+    .mttcg_supported = true,
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c39ff056157..460d05b1ee5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -869,6 +869,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e96b379e266..4c94f031b13 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -593,6 +593,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4b9ef6e52c4..5604c2a34a0 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -432,6 +432,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* MicroBlaze is always in-order. */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5ddc9bbb829..eee604e9254 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,6 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
+    .mttcg_supported = TARGET_LONG_BITS == 32,
     .guest_default_memory_order = 0,
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6a878aaadd8..1a6ca405a0c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -248,6 +248,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 28fbbb8d3c1..ed79cc1a6b7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
+  .mttcg_supported = TARGET_LONG_BITS == 64,
   .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5ccd7b9dc07..f26cfae6cdb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,6 +140,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 6a24e7e9136..4bcbc22d3ad 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -213,6 +213,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
 
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 };
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 12fd853c00a..7ca34002d37 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -361,6 +361,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
 
+    .mttcg_supported = true,
     /*
      * The z/Architecture has a strong memory model with some
      * store-after-load re-ordering.
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce9ed75107a..b796bac8afd 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -267,6 +267,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 39bd0c42855..2ae7173c0bc 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /*
      * From Oracle SPARC Architecture 2015:
      *
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e0a48065948..aea1f211516 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -179,6 +179,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 };
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index dd9061ba469..8cc987f8408 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -237,6 +237,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
+    .mttcg_supported = true,
     /* Xtensa processors have a weak memory model */
     .guest_default_memory_order = 0,
 
-- 
2.47.1


