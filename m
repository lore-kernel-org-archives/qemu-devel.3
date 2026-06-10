Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22438CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKpW-0004Gd-Ap; Wed, 10 Jun 2026 11:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wXKpU-0004G0-RJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:26:56 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wXKpT-0006Ov-67
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:26:56 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66077e90382so6317027d50.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781105213; x=1781710013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KDNP88INBAI3S9CuXBwCUOV/zjTeUMEtUojHhGSOqpA=;
 b=LufkP4gjaoF/u0Uqa1tleahVoEQf5AEt5HLPkakQftEabN3h/p6KfueILG5RoHKF3e
 OJyIdWRIoOFk9eiP7w3I78sqAVMAHDrRjblirwz+qRC+Q7WCO015R2hsSmJswAWTfMgC
 qb2bAKNiF56IUkrAmVOoR8HSmKw9BU+zC9jrRUCLa5qIkV23PIQoo6acCNbauf8n5szz
 iDUid3u1fQoxthQqh6KsOLJLRSKTPlHkOyYt9IPbw4T0eLld5W8/ifmOYp7QLMWOfuja
 73tJH9U+tppBZsTq3G6Jh1LzMMNdLmbal/9Vr1ZmULdotnmOn5E0qW76Us6W3A2Ozl8f
 kIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781105213; x=1781710013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDNP88INBAI3S9CuXBwCUOV/zjTeUMEtUojHhGSOqpA=;
 b=Nwvx3oH5ms+RKBEUvLg0EouToCDEjvnf7/Ea8gRbtORrx4jh7eV3aZAJ+U7ZExLCNB
 +tolhU2mN8vgz8rZ2xBE1L5pO3ft6MHZtDAFMW4k4yQLfajU7u/8yJmuqBid6Vf74KDU
 StguvD+m96GGSJAWHeS9bdBUu2grnjARy02HtEKlp+L49YPZjYHUyCfZOzEsEkN9T++8
 sSLbCOZbCTOzg2NlnlGAxjJhPzdcLvx3pEI+/BHaQ9AMYeA7y0tq0AQTScDY+MkP8CXa
 bvHvtvham4+mUatRzrrGI5YgZTIPJFKYBbcVhTcvSf1n29kwiPVGm/xAq5Ump3I2IJ07
 mN7g==
X-Gm-Message-State: AOJu0Yzt62bGiKRkXo7pLDWmawzlWb0QtGnQlFkl9Qf20QyMZctShHOp
 Q80sAFkk4ccst0NSSceu0fECZ3lCD+Iku1+qWcU9+fu197UFsRN6fWha0gHJqQ==
X-Gm-Gg: Acq92OFzxVyE1qrs63+CsdY+z1PofSb7hRwDCq3K5EIN8VS3njsA3xh706IpQfAMAHf
 J8T1qXcU548bIIQZCFWjXiwC2iHyK2ZW4lX9h+z+d+1pJbkjgKiiaeuD2sJvJrq+XdVKowZb/IN
 8kHmdrglg8Nk5OdPi03mrHLGrA6mCjrbLM9tKkXgannQQogImoF2NTb4fC0Zvpj5k66O4ycnfXo
 AYNnb6G1iZbwI5VmS3sDHK84qkxWlmNWKvkFJrA3WR80GWd5iZ7AZK+7hsxqjnLBJigDS8y7iPI
 wknuLqBrqR9ybM7YQCMAdl8fNP2XNQcD92IK1ji/scpdLqRPGEs26SHrhiXCyvmNxhOkNSbeBGs
 SP/lLwweTs0WSChl5w+NQxenGV+g0WUccR8cXjbWJ70cMQi49nd6yeazwcDgV4zJNucWuUYkwOA
 X7Mch18sa/1Slj+3gZU/9rr6hoi04vs2xx1EfzJKM8lT2e
X-Received: by 2002:a05:690e:1386:b0:65e:18a4:3021 with SMTP id
 956f58d0204a3-6614f80a5b0mr8771414d50.52.1781105213360; 
 Wed, 10 Jun 2026 08:26:53 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64409e9sm12417648d50.15.2026.06.10.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:26:52 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/2] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
Date: Wed, 10 Jun 2026 11:25:36 -0400
Message-ID: <20260610152648.677463-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Factor FCR→fp_status and FSR→fp_status synchronisation out of the
wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
mode and exception flags without duplicating the flag-mapping tables.

cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
that FCR bits valid only on fpu2k configs are preserved while MBZ bits
7-11 are always cleared.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/xtensa/cpu.h        |   4 ++
 target/xtensa/fpu_helper.c | 111 ++++++++++++++++++++-----------------
 2 files changed, 64 insertions(+), 51 deletions(-)

diff --git ./target/xtensa/cpu.h ./target/xtensa/cpu.h
index 75cfeee6e3..442e98bd1b 100644
--- ./target/xtensa/cpu.h
+++ ./target/xtensa/cpu.h
@@ -642,6 +642,10 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
 
+uint32_t cpu_get_fsr(CPUXtensaState *env);
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v);
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v);
+
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
 
diff --git ./target/xtensa/fpu_helper.c ./target/xtensa/fpu_helper.c
index 5358060c50..2e51cabe3f 100644
--- ./target/xtensa/fpu_helper.c
+++ ./target/xtensa/fpu_helper.c
@@ -64,56 +64,7 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
                              &env->fp_status);
 }
 
-void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
-{
-    static const int rounding_mode[] = {
-        float_round_nearest_even,
-        float_round_to_zero,
-        float_round_up,
-        float_round_down,
-    };
-
-    env->uregs[FCR] = v & 0xfffff07f;
-    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
-}
-
-void HELPER(wur_fpu_fcr)(CPUXtensaState *env, uint32_t v)
-{
-    static const int rounding_mode[] = {
-        float_round_nearest_even,
-        float_round_to_zero,
-        float_round_up,
-        float_round_down,
-    };
-
-    if (v & 0xfffff000) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "MBZ field of FCR is written non-zero: %08x\n", v);
-    }
-    env->uregs[FCR] = v & 0x0000007f;
-    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
-}
-
-void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
-{
-    uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
-    int fef = 0;
-    unsigned i;
-
-    if (v & 0xfffff000) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "MBZ field of FSR is written non-zero: %08x\n", v);
-    }
-    env->uregs[FSR] = v & 0x00000f80;
-    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
-        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
-            fef |= xtensa_fp_flag_map[i].softfloat_fp_flag;
-        }
-    }
-    set_float_exception_flags(fef, &env->fp_status);
-}
-
-uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
+uint32_t cpu_get_fsr(CPUXtensaState *env)
 {
     uint32_t flags = 0;
     int fef = get_float_exception_flags(&env->fp_status);
@@ -124,10 +75,68 @@ uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
             flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
         }
     }
-    env->uregs[FSR] = flags << XTENSA_FSR_FLAGS_SHIFT;
     return flags << XTENSA_FSR_FLAGS_SHIFT;
 }
 
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v)
+{
+    static const FloatRoundMode rounding_mode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+
+    env->uregs[FCR] = v & 0xfffff07f;
+    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+}
+
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v)
+{
+    uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
+    int fef = 0;
+    unsigned i;
+
+    env->uregs[FSR] = v & 0x00000f80;
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
+            fef |= xtensa_fp_flag_map[i].softfloat_fp_flag;
+        }
+    }
+    set_float_exception_flags(fef, &env->fp_status);
+}
+
+void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
+{
+    cpu_set_fcr(env, v);
+}
+
+void HELPER(wur_fpu_fcr)(CPUXtensaState *env, uint32_t v)
+{
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FCR is written non-zero: %08x\n", v);
+    }
+    cpu_set_fcr(env, v & 0x0000007f);
+}
+
+void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
+{
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FSR is written non-zero: %08x\n", v);
+    }
+    cpu_set_fsr(env, v);
+}
+
+uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
+{
+    uint32_t fsr = cpu_get_fsr(env);
+
+    env->uregs[FSR] = fsr;
+    return fsr;
+}
+
 float64 HELPER(abs_d)(float64 v)
 {
     return float64_abs(v);
-- 
2.53.0


