Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EE8CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWat-0006Nc-6Q; Tue, 16 Sep 2025 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaZ-0005wQ-9b
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008K4-TE
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-25d44908648so53124715ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032571; x=1758637371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxN+3w5DJd2qHPBAZ7pYBpWaLTYZHTclwzQuuWTXi7U=;
 b=Ev2m4HovWtco1enM0fiWbgCLDz3bXGBsNdtb0UoGm6OVC3M1nH9AHM/4EMnseoAccP
 BSFV92h91or+Oq4PCDOzaYQmyCeLDM0LQWhVKrcGtRhbEVdr5lgpqJwmEiKXrMq71y1n
 FQDC60ELUoutWQhlgEHCcdjVJ7t42HAJPoSwcQ6pvmJhEg6oxD1wTlLEhpHiQkughztH
 xeXMH2oIYfljYsxWYryq2+z0SvSYAOXsQhlA/TOGDwXIcDXN5nIv+14D6H0b1Dg/T03c
 XiXI5WvYU1lLPy6DD/Lzb7Scwzj0j9j78fPii1KdyK9pR8J5MCAk7cJaPmiaxQDDkpzP
 wpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032571; x=1758637371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxN+3w5DJd2qHPBAZ7pYBpWaLTYZHTclwzQuuWTXi7U=;
 b=BIdsSCYAsWV1A/6EUpO0XaZGZXuPaF3DOvRsQ20bMC8h32cYhiwELfNiBvWd+WN3Id
 WF99CdLspcV+SIR5xe5XBBzU7Cz99Cm6S2vSvDO+fA4ORuPWYK9cEDdC+xllhjOc8OJ1
 MPN+h51FLGahtfrTXibWRa3GkuQcimBnVUM2dV6+qYBde50d9/dt1m9iHkBXuNe1Vn3k
 4nm8f/ZiqNfL/8j9yyp5rYTLjiSsgGoF2WioVeDcZydVUfLe4FhzFmzbEtaAmKj666b7
 7QQ0cUu4H2NP77JO++PxWBS0ypMTAn4MPBmg6A/jnUysJAKE/OQV5RIJz5IhYuZAPfUc
 +low==
X-Gm-Message-State: AOJu0YwGtrZHW9zSzj7QUV0XTDZq/eCsxdGTlWFvc8mgkL2ss4kFyI4q
 2LV055XFQguVd8B9pqkHqNDNEiU5V0X8Ew9n/E9GmMIInKDDi1utlMY98vQ+Us2pTMrvDUcBZCp
 76wvh
X-Gm-Gg: ASbGnctJFFnVPeBhKpeSK2vnlLRcfZe6jeSKbvmJpy6uwxlL3dfv2xbbtTXxMAt7jjM
 k68fCtp+E3QBSrMtj/S1M9P40zyTs+WfyUyMroKD6Bwd1s3+9YBKatKjUqof08x7QcHU1OUobUt
 k5vfzVBvaPMxxl08m4VCaHOPSOepXha0OBRyDWiU2rb/hLE7g2xouUquJ35hLOnLwb/3YGADY7I
 5ojiHy068pVgkWD/li6p4lhECkWLf/EMd34BTxA39aTKDVL5p1zpPaNTRk/2neSjJNC9mrh8nz/
 A8KfHAjM5+MchX3BeKDb2dttct2blgJi93WM+ug4JktDR+2t3OA86PKuVSzKrsP+2lpAqEPGLzT
 FQhr/oP1q1GeYiasdzyIcT3FhTK+n
X-Google-Smtp-Source: AGHT+IHTIxQbYkyJFL/LTs8nN/Oi7LwgxhbltcYOQ3JoBg6wzHZkyHWrgbryzeSVPyLd6OWXPGf0Dg==
X-Received: by 2002:a17:902:d58a:b0:264:c48:9cae with SMTP id
 d9443c01a7336-2640c489f42mr132015655ad.38.1758032570923; 
 Tue, 16 Sep 2025 07:22:50 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 14/36] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
Date: Tue, 16 Sep 2025 07:22:15 -0700
Message-ID: <20250916142238.664316-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Prepare for 128-bit fields by using a better query api.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h  | 10 ++++++----
 target/arm/gdbstub.c |  7 +++++--
 target/arm/helper.c  | 18 +++++++++++++-----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 812fb1340a..b6c8eff0dd 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -22,6 +22,7 @@
 #define TARGET_ARM_CPREGS_H
 
 #include "hw/registerfields.h"
+#include "exec/memop.h"
 #include "target/arm/kvm-consts.h"
 #include "cpu.h"
 
@@ -1053,12 +1054,13 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
 void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
- * Return true if this reginfo struct's field in the cpu state struct
- * is 64 bits wide.
+ * Return MO_32 if the field in CPUARMState is uint32_t or
+ * MO_64 if the field in CPUARMState is uint64_t.
  */
-static inline bool cpreg_field_is_64bit(const ARMCPRegInfo *ri)
+static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
 {
-    return (ri->state == ARM_CP_STATE_AA64) || (ri->type & ARM_CP_64BIT);
+    return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
+            ? MO_64 : MO_32);
 }
 
 static inline bool cp_access_ok(int current_el,
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..e2fc389170 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -247,10 +247,13 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
-        if (cpreg_field_is_64bit(ri)) {
+        switch (cpreg_field_type(ri)) {
+        case MO_64:
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
-        } else {
+        case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+        default:
+            g_assert_not_reached();
         }
     }
     return 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b310f52724..b7c483b0d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -63,20 +63,28 @@ int compare_u64(const void *a, const void *b)
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         return CPREG_FIELD64(env, ri);
-    } else {
+    case MO_32:
         return CPREG_FIELD32(env, ri);
+    default:
+        g_assert_not_reached();
     }
 }
 
 void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         CPREG_FIELD64(env, ri) = value;
-    } else {
+        break;
+    case MO_32:
         CPREG_FIELD32(env, ri) = value;
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2754,7 +2762,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
-    if (cpreg_field_is_64bit(ri) &&
+    if (cpreg_field_type(ri) == MO_64 &&
         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
         ARMCPU *cpu = env_archcpu(env);
         tlb_flush(CPU(cpu));
-- 
2.43.0


