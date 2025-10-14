Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B87CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJt-0002Vi-Oh; Tue, 14 Oct 2025 16:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJX-0002IS-GI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIy-0005LW-4O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-28832ad6f64so64880365ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472448; x=1761077248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5btMPkNJDkRLOMsyDK95md6xOaMjB+VfIt/mT/S7SM=;
 b=VOgNbad4f/ALi6Y5YFy96wYYKo7MgBRd7hbhU7BVZ6voVcu/MF8ZojTUzzWN3Jwe/9
 D9su6d5oNEejJubClI7AzAmBsQDzLP+QcWvg/XUPDZ6BAEm5HTgyFs5upnxMp1n31yw3
 5khGftQIvuSDycWYLmz4s20pzhNS4/mTPQQ8gOkY2FpQN59xsR6MK5pL8izWj34WDQbq
 OA94mfnt0GXhKPDglxMhuEG1Gxi1qYazzQKqIckanh5CC828eGZNj9n8lCerfXfLhG3n
 B6IKPdnjwOWvVOQXXwZI3M0GEGaObwuIcmxSokdsoH2D19aH5yxR/Y4QaZna4Od8Idod
 IMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472448; x=1761077248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5btMPkNJDkRLOMsyDK95md6xOaMjB+VfIt/mT/S7SM=;
 b=wHwEEKn56hy7uFMNiCWeLkEzJYYbBu0RO4UV/ISAL+rHrSg8S76qZNIMYZbl8ljfYC
 yxWXrJtqC7hF9I0pShCCmnj0a7M3NJek9nTtzBA97BP0nUZ/auz4opcbf6j3KR+6nXlW
 VWCinBk300MHsl142doXM3h4A7BqnM8K720XFWCIwa0rWTuAgAkIQbJ8tyM6gpqPhfAi
 Q7L88iC/tdLcYt1M8PDH4I5W0uyeS4bCY3rLlZaHDycs8n81TjHkQRITHCqhp2gJwjf1
 Cn/chw/y8Eap53ezhiLRVNktLBr6UiEr8ozjL4X3AlKBM+KGHsire0TUmQamThhWGiL6
 tMQA==
X-Gm-Message-State: AOJu0Yw7JuXrW/5spdSV7K+ufPJUwwvy0GPS6502pj3/iCE8CcjGIBkP
 WxI9rqZDT2XJ/IqP3bSu4JqGJKhBTaFIN+VaYKij5lYw3f24K9CBKdEzdA/sIxiMH+s4cIQZiVk
 seZXebQ4=
X-Gm-Gg: ASbGncvrKAlRlOtYdjR/HpH4T3YXG2cL8IjfaTaItb42NCZqQvx5YdFWNlIRqiDhFAA
 /zfOGLcL3seATeZprwk7b0WCv6tDTEOjTUgDR8fEeLMrOyBdWPSj37XDFOUHKdmlzPhXzZ/fVUi
 3yS/IhnU/pAw87rK2XU3E73Xim/4pfuJpPOYdOw1uIMYNvC5Oq2vvmJqWDGNUFNYX9EIHPnWH0S
 CgxZyWj7SfhemFeefsx3u9bks0txOFJ/xDVVn7C0Ki/JGKbjNl4KbsC0D26iNAQ3iT+N8s8FqKe
 WNLuJqYjaX3Njb0nZnpxUW3uHYI8mjtKGqDu7NtEx1xebQ0M4kMRU1tki3UnYdNaAPUgkWI2ibD
 39Y1rna0LFs2geoZRhjh+J8n9+/lQqLKp4gHYOoOWcGuVxrSjd3s=
X-Google-Smtp-Source: AGHT+IEY/yq2MXLBnNiJVS+zsoolOlLuGEATos/veulfUZhThjphSNKNH627vQjUU+Kbztgd7sZSsA==
X-Received: by 2002:a17:903:19e8:b0:28e:ccd7:dd61 with SMTP id
 d9443c01a7336-29027305380mr313511235ad.57.1760472447532; 
 Tue, 14 Oct 2025 13:07:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 12/37] target/arm: Put 128-bit sysregs into a separate list
Date: Tue, 14 Oct 2025 13:06:53 -0700
Message-ID: <20251014200718.422022-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Duplicate the cpreg_{indexes,values,array_len} array as
cpreg128_{indexes,values,array_len}.  Similarly for
cpreg_vmstate_{indexes,values,array_len}.

Split the values between the two arrays during
write_cpustate_to_list, write_list_to_cpustate,
count_cpreg, and add_cpreg_to_list.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  19 +++++--
 target/arm/helper.c | 125 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e21612b898..a030539488 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -918,25 +918,36 @@ struct ArchCPU {
 
     /* Coprocessor information */
     GHashTable *cp_regs;
-    /* For marshalling (mostly coprocessor) register state between the
+    /*
+     * For marshalling (mostly coprocessor) register state between the
      * kernel and QEMU (for KVM) and between two QEMUs (for migration),
      * we use these arrays.
      */
-    /* List of register indexes managed via these arrays; (full KVM style
-     * 64 bit indexes, not CPRegInfo 32 bit indexes)
+    /*
+     * List of register indexes managed via these arrays (full KVM style
+     * 64 bit indexes, not CPRegInfo 32 bit indexes).  The registers are
+     * segregated by size, with 64-bit registers in cpreg_indexes and
+     * 128-bit registers in cpreg128_indexes.
      */
     uint64_t *cpreg_indexes;
+    uint64_t *cpreg128_indexes;
     /* Values of the registers (cpreg_indexes[i]'s value is cpreg_values[i]) */
     uint64_t *cpreg_values;
+    Int128 *cpreg128_values;
     /* Length of the indexes, values, reset_values arrays */
     int32_t cpreg_array_len;
-    /* These are used only for migration: incoming data arrives in
+    int32_t cpreg128_array_len;
+    /*
+     * These are used only for migration: incoming data arrives in
      * these fields and is sanity checked in post_load before copying
      * to the working data structures above.
      */
     uint64_t *cpreg_vmstate_indexes;
+    uint64_t *cpreg128_vmstate_indexes;
     uint64_t *cpreg_vmstate_values;
+    Int128 *cpreg128_vmstate_values;
     int32_t cpreg_vmstate_array_len;
+    int32_t cpreg128_vmstate_array_len;
 
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d9d8ae56e8..d3a425e259 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -217,10 +217,11 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
-    int i;
+    int i, n;
     bool ok = true;
 
-    for (i = 0; i < cpu->cpreg_array_len; i++) {
+    n = cpu->cpreg_array_len;
+    for (i = 0; i < n; i++) {
         uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
         const ARMCPRegInfo *ri;
         uint64_t newval;
@@ -230,6 +231,10 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
             ok = false;
             continue;
         }
+        if (ri->type & ARM_CP_128BIT) {
+            ok = false;
+            continue;
+        }
         if (ri->type & ARM_CP_NO_RAW) {
             continue;
         }
@@ -257,35 +262,77 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
         }
         cpu->cpreg_values[i] = newval;
     }
-    return ok;
-}
 
-bool write_list_to_cpustate(ARMCPU *cpu)
-{
-    int i;
-    bool ok = true;
+    n = cpu->cpreg128_array_len;
+    if (n == 0) {
+        return ok;
+    }
+    assert(!kvm_sync);
 
-    for (i = 0; i < cpu->cpreg_array_len; i++) {
-        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
-        uint64_t v = cpu->cpreg_values[i];
-        const ARMCPRegInfo *ri;
+    for (i = 0; i < n; i++) {
+        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg128_indexes[i]);
+        const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
 
-        ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
         if (!ri) {
             ok = false;
             continue;
         }
+        if (!(ri->type & ARM_CP_128BIT)) {
+            ok = false;
+            continue;
+        }
         if (ri->type & ARM_CP_NO_RAW) {
             continue;
         }
-        /*
-         * Write value and confirm it reads back as written
-         * (to catch read-only registers and partially read-only
-         * registers where the incoming migration value doesn't match)
-         */
-        write_raw_cp_reg(&cpu->env, ri, v);
-        if (read_raw_cp_reg(&cpu->env, ri) != v) {
+
+        cpu->cpreg128_values[i] = read_raw_cp_reg128(&cpu->env, ri);
+    }
+    return ok;
+}
+
+bool write_list_to_cpustate(ARMCPU *cpu)
+{
+    int i, n;
+    bool ok = true;
+
+    n = cpu->cpreg_array_len;
+    for (i = 0; i < n; i++) {
+        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+
+        if (!ri) {
             ok = false;
+        } else if (ri->type & ARM_CP_128BIT) {
+            ok = false;
+        } else if (!(ri->type & ARM_CP_NO_RAW)) {
+            /*
+             * Write value and confirm it reads back as written
+             * (to catch read-only registers and partially read-only
+             * registers where the incoming migration value doesn't match)
+             */
+            uint64_t v = cpu->cpreg_values[i];
+            write_raw_cp_reg(&cpu->env, ri, v);
+            if (read_raw_cp_reg(&cpu->env, ri) != v) {
+                ok = false;
+            }
+        }
+    }
+
+    n = cpu->cpreg128_array_len;
+    for (i = 0; i < n; i++) {
+        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg128_indexes[i]);
+        const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+
+        if (!ri) {
+            ok = false;
+        } else if (!(ri->type & ARM_CP_128BIT)) {
+            ok = false;
+        } else if (!(ri->type & ARM_CP_NO_RAW)) {
+            Int128 v = cpu->cpreg128_values[i];
+            write_raw_cp_reg128(&cpu->env, ri, v);
+            if (int128_ne(read_raw_cp_reg128(&cpu->env, ri), v)) {
+                ok = false;
+            }
         }
     }
     return ok;
@@ -298,9 +345,14 @@ static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
     const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
-        cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
+        uint64_t idx = cpreg_to_kvm_id(regidx);
+
         /* The value array need not be initialized at this point */
-        cpu->cpreg_array_len++;
+        if (ri->type & ARM_CP_128BIT) {
+            cpu->cpreg128_indexes[cpu->cpreg128_array_len++] = idx;
+        } else {
+            cpu->cpreg_indexes[cpu->cpreg_array_len++] = idx;
+        }
     }
 }
 
@@ -310,7 +362,11 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
     const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
-        cpu->cpreg_array_len++;
+        if (ri->type & ARM_CP_128BIT) {
+            cpu->cpreg128_array_len++;
+        } else {
+            cpu->cpreg_array_len++;
+        }
     }
 }
 
@@ -320,9 +376,10 @@ void init_cpreg_list(ARMCPU *cpu)
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
      * Note that we require cpreg_tuples[] to be sorted by key ID.
      */
-    int arraylen;
+    int arraylen, array128len;
 
     cpu->cpreg_array_len = 0;
+    cpu->cpreg128_array_len = 0;
     g_hash_table_foreach(cpu->cp_regs, count_cpreg, cpu);
 
     arraylen = cpu->cpreg_array_len;
@@ -340,13 +397,33 @@ void init_cpreg_list(ARMCPU *cpu)
     cpu->cpreg_vmstate_array_len = arraylen;
     cpu->cpreg_array_len = 0;
 
+    array128len = cpu->cpreg128_array_len;
+    if (array128len) {
+        cpu->cpreg128_indexes = g_new(uint64_t, array128len);
+        cpu->cpreg128_values = g_new(Int128, array128len);
+        cpu->cpreg128_vmstate_indexes = g_new(uint64_t, array128len);
+        cpu->cpreg128_vmstate_values = g_new(Int128, array128len);
+    } else {
+        cpu->cpreg128_indexes = NULL;
+        cpu->cpreg128_values = NULL;
+        cpu->cpreg128_vmstate_indexes = NULL;
+        cpu->cpreg128_vmstate_values = NULL;
+    }
+    cpu->cpreg128_vmstate_array_len = array128len;
+    cpu->cpreg128_array_len = 0;
+
     g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
 
     assert(cpu->cpreg_array_len == arraylen);
+    assert(cpu->cpreg128_array_len == array128len);
 
     if (arraylen) {
         qsort(cpu->cpreg_indexes, arraylen, sizeof(uint64_t), compare_u64);
     }
+    if (array128len) {
+        qsort(cpu->cpreg128_indexes, array128len,
+              sizeof(uint64_t), compare_u64);
+    }
 }
 
 bool arm_pan_enabled(CPUARMState *env)
-- 
2.43.0


