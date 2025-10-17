Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB686CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mPr-0005JK-7T; Fri, 17 Oct 2025 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPh-0005Dj-RH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPb-000159-31
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1775596f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715030; x=1761319830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtSS8KnvSb4J83ASd5oqMayj/FmTzdqH/eYszZmtz3A=;
 b=fcW1Z9eCR24xIojSOJfObrx/9xAuTAoLAvn7vUlcAhlkxF2Zi+X6MjdxSRKBlW78pZ
 7dBgj3PBENPMANLO4BqR+Vs94GV3Y63bI8S0DrpJu7Xj7n360ucjiR/qH1QgYvgLsdGC
 SxkpzZd3EqNHAjBCc3OIyrnMgJx8rnUr3ZSlwk1lmPpJLXvz8hC+OZoQ9TyA4h/UlJia
 slPVNhGTA3z/zpaPJaSo8YL0D51SitCSrcbUxR4Yy5kPGnR+w2HoRYF7R96pHQe3VHUW
 wZqYWf/82HTbcNBlghSPT72HeLvIPxnRU1vxwsJuMVVMk1EklpcXHtQbzNK7ekL/ZKTd
 z/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715030; x=1761319830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtSS8KnvSb4J83ASd5oqMayj/FmTzdqH/eYszZmtz3A=;
 b=DHYPW5LxX78Nwqujhm8G3Ndnw1rTyiIDjlBfl69a8k/u1eFSDlR8ZvbvJANHZO34qO
 PEykF0FjrWywrt0poQ/25jNzqF+Un8a4Qxd8HOhDW/U2sR6Z99MWj8J4X9x0PlI2Np2c
 mVnTQbBofwziFqtm2ySrlCARV/EAO/lJOWnxxX5aXMirsinJqGg0cDSvzNWoYZHi1ZMj
 93fuzyf4YKtSKmqYHgm4pj39LCPMJQfzqCYw/A04AU0eGX2qj5Wh1360byx6fJfyvRIL
 6wDrAjZ0HqaoDwQQF3m0Gf4ymjjyhDpBmEJlngnEKMxprtaDEHee1WdjZMJR43B9Q9Wq
 lt8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmFZUx40MsrhTFl/RZEmOHs1Dnr/nvEwlVpCmsJqBIGEZAP7lIW04v6zTmI6qo5FnSBnm2SBfE1X0J@nongnu.org
X-Gm-Message-State: AOJu0YymA4Mls1Ca6zoQ+PqnpPCsMuh5Lm99paDlFTD2hXV5t143JTMY
 jn3LN1wiepXrMu64GLNxgD2ZyNsHMaTU0ZLrjfpCazIvUXtqimLXmUZJTR8IMewtdV8=
X-Gm-Gg: ASbGncvxcZ7wLlVNTCXMo3VLdsUAyPbkvBMir7Y9P44fy2OojppLCW/NjC9hHwed5pv
 5c58vd/O24WvLBkdS2PqAVO2BT/TekpYyU+dzJTYpGgUlqPohCGg4YrP5NZQcms27HyI2UcgaFf
 qjHyo+XbQsx52OG5msINUgdGUzY+x8dXsOyT6ncdZpoy4o6TqrhRNUrHM3RJPbJf6CKswscgPH4
 ZnoStP3Ih8Qah7C2b6zrduJ7L+aAP0LcP/scVwJAFfBMPSnG0TLmEo0IRAPHsbbfofa5+rB3SDp
 J31KVqxlsLzJKW7sTDQzYrkM+EDr9RM6NgNIhcDRxItxAzR4w0GfHn12qWCRCMbx+UNVk7ynqz2
 8k4JALoUVDcMVLSy43KO9HWKyOYNmx1mkocy4Vf9/2aIKSBpUWmOPAZLy82PXwhWEzmASV7MlmJ
 GA7sxMLw==
X-Google-Smtp-Source: AGHT+IFgsKCvYqY7LCVTEPsuKew7kaQMjAYDwZrazSQgOY26RsfDKQEqVsoXRbmozAVtgC2GT+9uRQ==
X-Received: by 2002:a5d:5888:0:b0:426:f38a:a51 with SMTP id
 ffacd0b85a97d-42704d8d684mr3466148f8f.22.1760715030138; 
 Fri, 17 Oct 2025 08:30:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm85038635e9.18.2025.10.17.08.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:30:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v2 1/3] target/arm: Implement SME2 support in gdbstub
Date: Fri, 17 Oct 2025 16:30:25 +0100
Message-ID: <20251017153027.969016-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017153027.969016-1-peter.maydell@linaro.org>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
index f539bbe58e1..b8b07e6477c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1719,6 +1719,8 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
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


