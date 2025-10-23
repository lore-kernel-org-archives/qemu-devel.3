Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0831CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjg-0004rE-7Q; Thu, 23 Oct 2025 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwje-0004oG-CV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjc-0005aO-AX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso10625535e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231370; x=1761836170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QCuV9Ie04TI1xV3BkHsw3lfUDwis9uD7D2gaUqo7FkM=;
 b=gqAR5aXUUR4gQGr/v0/QYnQPszakdWNsSpjfPHi6aPnOsuIuPgX7+1NMH5G26gktzy
 sosYCEBGGq3hegV0KoJM2m7d1IRcJ9MGfL+rJ75ced5BtrlpFpn5yMClRmvxTaxT/QCh
 H5LikZVYrDJ8scEz+/nwkvIP1EFC282hVOhJ+SXjZFuwW5n3roNLO+gOUzNA+Vhg+j0K
 Talv5yvxIWi3QPvlfQxsEwCYFrywWSTsKy1DDvimqLuVHLg0kHKb8emD9n2jAx0WUhBQ
 TZ7/mr0enoUUYXzpcHcu/ehqFTFgttHpf+4QX8WdMJqdVpm7sG2CtOPDyCKNlilmHpn1
 spCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231370; x=1761836170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCuV9Ie04TI1xV3BkHsw3lfUDwis9uD7D2gaUqo7FkM=;
 b=DFvELANoTFCzlxbqvtBlTgfWUiD1I1aDupTYNGFuW17+774kFMQepjMXfTA4ivczJ/
 Be0fYOrIL2hn0uOp6sgYJNaw1MDymSg5lmgErwGc3IAPjfDKpK5mYadQlSDoX44Feo53
 +GRLYxUKf52rA5j9v6YgZGSV3HYTS6aC2dfzDl1Lv9jhDqANPvWpaQYu7gT32AMypTuq
 g9G6/ATE/wMaG6GB7Xf10Llqa5WAyeKgt6PSqjDZUs+lAnfM7Y5W5jqvbfhDRmYaLG7P
 LUP7r3IoGWDoIihE+Gcr9jplCRmVZNIp/o3sKK1L41e4sh/05YaUXZw1pHntAcr1Gwl+
 0cOg==
X-Gm-Message-State: AOJu0YyYDAbi5g1QE2+fZtH89SN4QPlMk8V/+v8/BvlFwfe41fWgYdhO
 M6sGzT/tG1AXCkHu4cpi+KmZ11+jwLooJlNUyXGoXpvSg9CnPquCBh27mnxbgqOtM59eVMn/D29
 R/unR
X-Gm-Gg: ASbGncsy7D7cB4Rs9Nh0RS7k/Gw6TQjB/zpjQsABvXEUvZ3VWL1GXiA+iDCMb4uoEPA
 6o5ZqQPg051Htiop/a0vSoCxoHCRkWc4b/HxLKZBDtcESQygYIppVSFieyJWkDYLTkXhC0Ap3Y8
 F82D3uNwoRLEKaGkA+YSPHCUXAnhAoqP3gQhKzsdaDxT+tLReRlPoaCTdKaGuNNjs5tScT9HpSh
 8AsaGSapD9ZBaMYj5NJyJvtr7AGxBVms9QRpykJOucKr61O3ARW0aq7rKxR3kGFjyihZrheQIJ6
 Fq7OjEtKx0ZGm0NchZiIkt7+dmr17VCrr1mbn2aFHGlqwy1PXWzvz1hlYc5IxMoBOcfN3+y/BPb
 Vx3pab+aLee0K4sUUzo27/FwUgQ06rXMLtgrshblaTcu3qU3vzMdnWa9naDMSwMDioxB9iPnMyr
 i+k/fdiP+bR0Q9t0Ux
X-Google-Smtp-Source: AGHT+IHPTvWBBUMxfx+4r/+i5X/knCT5ux45OGwBs3tk8YSpaYx0Jf1oCDA8s6ZlSz0ACC7trSyTrQ==
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4711791f94dmr235291825e9.34.1761231370466; 
 Thu, 23 Oct 2025 07:56:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] target/arm: Implement SME2 support in gdbstub
Date: Thu, 23 Oct 2025 15:55:51 +0100
Message-ID: <20251023145554.2062752-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

For SME2, we need to expose the new ZT0 register in the gdbstub XML.
gdb documents that the requirements are:

> The ‘org.gnu.gdb.aarch64.sme2’ feature is optional.  If present,
> then the ‘org.gnu.gdb.aarch64.sme’ feature must also be present.
> The ‘org.gnu.gdb.aarch64.sme2’ feature should contain the
> following:
>
>    - ZT0 is a register of 512 bits (64 bytes).  It is defined as a
>      vector of bytes.

Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251017153027.969016-2-peter.maydell@linaro.org
---
 configs/targets/aarch64-bsd-user.mak      |  2 +-
 configs/targets/aarch64-linux-user.mak    |  2 +-
 configs/targets/aarch64-softmmu.mak       |  2 +-
 configs/targets/aarch64_be-linux-user.mak |  2 +-
 target/arm/internals.h                    |  2 +
 target/arm/gdbstub.c                      |  6 +++
 target/arm/gdbstub64.c                    | 52 +++++++++++++++++++++++
 gdb-xml/aarch64-sme2.xml                  | 14 ++++++
 8 files changed, 78 insertions(+), 4 deletions(-)
 create mode 100644 gdb-xml/aarch64-sme2.xml

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
index f99c73377a9..7f42e060477 100644
--- a/configs/targets/aarch64-bsd-user.mak
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index b779ac3b4a0..bf328b3b80c 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 5dfeb35af90..d14bcfc4900 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index ef9be02290f..284430add7b 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a65386aaed3..bf44066f71b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1720,6 +1720,8 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_sme2_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_sme2_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8d2229f5192..1ca3e647a84 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -554,6 +554,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                 arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
                                      aarch64_gdb_set_sme_reg, sme_feature, 0);
+            if (isar_feature_aa64_sme2(&cpu->isar)) {
+                gdb_register_coprocessor(cs, aarch64_gdb_get_sme2_reg,
+                                         aarch64_gdb_set_sme2_reg,
+                                         gdb_find_static_feature("aarch64-sme2.xml"),
+                                         0);
+            }
         }
         /*
          * Note that we report pauth information via the feature name
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 65d6bbe65fb..5ad00fe771d 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -335,6 +335,58 @@ int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme2_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int len = 0;
+
+    switch (reg) {
+    case 0: /* ZT0 */
+        for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i += 2) {
+            len += gdb_get_reg128(buf, env->za_state.zt0[i + 1],
+                                  env->za_state.zt0[i]);
+        }
+        return len;
+    default:
+        /* gdbstub asked for something out of range */
+        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
+        break;
+    }
+
+    return 0;
+}
+
+int aarch64_gdb_set_sme2_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int len = 0;
+
+    switch (reg) {
+    case 0: /* ZT0 */
+        for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i += 2) {
+            if (target_big_endian()) {
+                env->za_state.zt0[i + 1] = ldq_p(buf);
+                buf += 8;
+                env->za_state.zt0[i] = ldq_p(buf);
+            } else {
+                env->za_state.zt0[i] = ldq_p(buf);
+                buf += 8;
+                env->za_state.zt0[i + 1] = ldq_p(buf);
+            }
+            buf += 8;
+            len += 16;
+        }
+        return len;
+    default:
+        /* gdbstub asked for something out of range */
+        break;
+    }
+
+    return 0;
+}
+
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/gdb-xml/aarch64-sme2.xml b/gdb-xml/aarch64-sme2.xml
new file mode 100644
index 00000000000..43911dae160
--- /dev/null
+++ b/gdb-xml/aarch64-sme2.xml
@@ -0,0 +1,14 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2025 Linaro Ltd.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+
+     This is the SME2 ZT0 register. Upstream GDB dynamically generates
+     the XML for this feature, but because the vector is always 64 bytes
+     in size we prefer to use static XML for it.
+     -->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.aarch64.sme2">
+  <vector id="sme2_bv" type="uint8" count="64"/>
+  <reg name="zt0" bitsize="512" type="sme2_bv"/>
+</feature>
-- 
2.43.0


