Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85B9106B504
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vcp-0001so-Lx; Wed, 25 Mar 2026 17:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vck-0001pO-Ev
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vci-00021p-9o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b41b545d9so239820f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473522; x=1775078322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELyG3CPRX3HGPrR46En7QqMJTEd390KuOAkz1dhhPqI=;
 b=NscsU5NC3OBZxW/SfQ4LW2L2k/P53CUe+2beyP/bSdjDieYvZJE5iAeWcthM2nBqyN
 1hm4VfYYBDrQV6bAlgvGZJGkHO+lYAxTwsVTz9+bU7vCY1QebVHiy1IGAu9w3G17/XLy
 DbB27Qz61X4SM0/7sq86Kp3fnuEqR2yI4kHoD9OX8Lhdry717PZn14oQGcGxXl6iuEfF
 SwloXSk2udz+6ZfbrHgmvZa/Y8TvmIaNX0hPqRaudo9MaaL/gui+H+8TgmHo4STW3I0E
 dDZiOCSkra+CYO2gjmDNdKvaCbyI/A8QbeDsVIyPPsR9H242xCN9j/0fhICfwh553CjR
 psQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473522; x=1775078322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELyG3CPRX3HGPrR46En7QqMJTEd390KuOAkz1dhhPqI=;
 b=ijOIfr6cfRzLfMTOBEgC7fu11pDZCDThreGgLWvIMcRdrwcUKmOEofBHpaT2kRXXKQ
 lxZTf8tyhxeruYCioRP5dbF24G3+X59TnMm65wCUHk8UDISkP7e2K4V7UVs5o7H9NU1N
 4IpQvhuGuHOVYzotV4TI+vRuCuG/p17EgGCdzeGQm82ktyVnt20qtpXRaRd2RflE3sK4
 pdQvz9NwluoNuxOj2BpK0mN3eyEp2KCSAmh3OGBkoaylMHknkjYzbzxlEbLjS05Zi5zx
 r+VBNQkxRyP+nmTeyv0UB4vWAKUDBUU6VYuv8qoRAHNQxExQPQlN/BwUni9ejKQnTUYb
 h83A==
X-Gm-Message-State: AOJu0Yx1uIMjIh6B7uHPLrthZkvyLzoV9UnivfmJdnANGRGxx+owljpI
 kraSW/4zGVHWfnhiTszCYHVNYCxxUSRuSu+qm840As4PyxhI1ToPidqWpsVy0E+x9PJ+m8VeSjT
 50fs/Oyo=
X-Gm-Gg: ATEYQzx5utbiEmH1HJTpKBsRuXDmG6uTvx1jJYsK1rrh8qHz6FVtDI7nAslFnA+PSxp
 SI9Pe+nEDyw2GF4Jb1TJifUDxk2BbMvJDZGmrbzAX6ru6O2T7IM7kB7+FbxyTVwnfJOXd3AL9bu
 ZkVDtKgBsplHaFO3PO9FcJA2NCD3ljTsklYomMYGjMImGsM7CgqWtT3ngo8xhLEfHeZeMxxBZIw
 4dH00jy1AH/UsSfWEmEUvORtyP4X6aeptSlQ/VLCKP5zawuHKQFng117dE4hSQaWbt6EPPhCTjI
 l3plse33rbKSxNVdahO/k6I/bkA6UVZHzAdnFBKt19MuOO4shEtq4va3cHQV7EShUe676A3uNii
 XlYEZeEQoQXr9vrhFyS2c6obX/686XntAukV5Wx6ZttQ9mE6vnMXYUeqBVuRbgadEYGK+IO9z8B
 TjvacYXYSJlBUbo25gBHMgyn+vDQR1mzFtu8YHX6KwpVEU2YmwvAlPpaLVLfWZK4a1UCnirCV9
X-Received: by 2002:a05:6000:2308:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43b88994d97mr7991806f8f.11.1774473522203; 
 Wed, 25 Mar 2026 14:18:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e352sm2748535f8f.3.2026.03.25.14.18.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH-for-11.1 10/10] migration: Restrict legacy VMSTATE_UINTTL()
 macros to few targets
Date: Wed, 25 Mar 2026 22:17:28 +0100
Message-ID: <20260325211728.89204-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Only 5 base targets use VMSTATE_UINTTL (MIPS, PPC, X86, SPARC and
RISCV). In order to build a single binary (preliminary step toward
heterogeneous emulation) we need to remove it, but it will take some
time. Add a temporary TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
definition to keep targets not using these macros clean while we keep
cleaning the last few targets one by one, preventing legacy uses to
creep back in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/i386-softmmu.mak     |  1 +
 configs/targets/mips-softmmu.mak     |  1 +
 configs/targets/mips64-softmmu.mak   |  1 +
 configs/targets/mips64el-softmmu.mak |  1 +
 configs/targets/mipsel-softmmu.mak   |  1 +
 configs/targets/ppc-softmmu.mak      |  1 +
 configs/targets/ppc64-softmmu.mak    |  1 +
 configs/targets/riscv32-softmmu.mak  |  1 +
 configs/targets/riscv64-softmmu.mak  |  1 +
 configs/targets/sparc-softmmu.mak    |  1 +
 configs/targets/sparc64-softmmu.mak  |  1 +
 configs/targets/x86_64-softmmu.mak   |  1 +
 include/migration/cpu.h              | 24 +++++++++++-------------
 target/ppc/machine.c                 |  1 +
 scripts/make-config-poison.sh        |  1 +
 15 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f..048ae17fdc5 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index 95397af9442..81990d21880 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index f9cc41b9ed4..2f7873af06d 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 4e7dedc5f30..62e74f77ba5 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index b0fba8a9d0a..57e556b93b8 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..1e28d40b440 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 10d7a2681e7..8c7171f9d5e 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 26080599be7..a9cd8ae89ee 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 5059c550480..3f97cd6dfa5 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 126ce12abb0..0630fa54b43 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES=sparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 4e621fb8e39..500db845ea9 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f5..18b3575e4e2 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API=y
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 05a1ddde343..4c8c9c34cc8 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -3,25 +3,23 @@
 #ifndef MIGRATION_CPU_H
 #define MIGRATION_CPU_H
 
+#ifdef TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
+
 #include "exec/cpu-defs.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
 #if TARGET_LONG_BITS == 64
-#define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
-    VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
-    VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL(_f, _s) \
+    VMSTATE_UINT64_V(_f, _s, 0)
+#define VMSTATE_UINTTL_ARRAY(_f, _s, _n) \
+    VMSTATE_UINT64_ARRAY_V(_f, _s, _n, 0)
 #else
-#define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
-    VMSTATE_UINT32_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
-    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL(_f, _s) \
+    VMSTATE_UINT32_V(_f, _s, 0)
+#define VMSTATE_UINTTL_ARRAY(_f, _s, _n) \
+    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
 #endif
 
-#define VMSTATE_UINTTL(_f, _s)                                        \
-    VMSTATE_UINTTL_V(_f, _s, 0)
-#define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
-    VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
+#endif /* TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API */
 
 #endif
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 49cfdc6d674..f6169a128dc 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -5,6 +5,7 @@
 #include "helper_regs.h"
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 #include "qapi/error.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index b4d61e8bc9e..a1c5fa77d9d 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -12,6 +12,7 @@ exec sed -n \
   -e '/CONFIG_SOFTMMU/d' \
   -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
   -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
+  -e '/TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.53.0


