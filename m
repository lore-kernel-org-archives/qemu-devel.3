Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C0EFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuF-0001YG-NR; Wed, 29 Apr 2026 00:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwu4-00016n-Kg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwu3-0001CU-1R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a871daa98fso79539085ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438322; x=1778043122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIgLzoAd3/xxTcwu4RMkibZOlgzaUFKfwoSJXOcjJsk=;
 b=Jnmftx9sTADB6QU4EkxM2DEAUum3J3+yZulHXNSwi8tVa/DxKUm2/a0gfAvF3I4YWU
 6X4iQqcyEubPV85BWXNSUT1b3JAh3lQQ4CHVaqfqvLi8lgN3oTpyRmCRAEPQTdijSic1
 MoTz6il+hG+dplHvUvLQlPLRONXgYxbd/FRpYKdfndYO1ZDaJZDTQH2edNJnYlhu8pKp
 IuYiB/q0Hwadul87GR3lrCU64BLWGmIbIWgdGIkXu8+g1kkDTcD+abKbAUKoY6dgCZxH
 EutiJeRZUNqEtNcmjsj12Qj7HPIVVkQajIJe3fKhnKqa7lhyr/tLepUNXxTfoUdmGjit
 RNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438322; x=1778043122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iIgLzoAd3/xxTcwu4RMkibZOlgzaUFKfwoSJXOcjJsk=;
 b=IT6Hs6veUNlXauJcRoiF++hkAPvVJpVn0hdvda5UcAJApk+QvCmiO78NXuezbW44uf
 rG7AooAmyWa1HynuxSCHDsF7u7yBN1+qajUF/2xYd3554YGfINLxFZjAPPM/OZTptuzy
 ayuJrRnVkRm3ECjWSVxhHETQkRaVd9oPddOtXn9oUdOMO/Pnx3bP4Ue/o7eo+J8ArTnS
 r07byfAWFbKtQsXA47TCbChJwPi/NObdCg0xWFpR/l4EC16X2aZOI1YmNgdFk/g+BqFf
 1vE+LRju1nSEQdW1dbXuD5mf/OOcQrqD1I+0Xp5GpPdcMTU0H6dBqvG6kosZG7fud9Pd
 47OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2tgZaZjUIijkeFmRCoTs7gHMFBAcMWDWekrqWU9aFcArcMDMVIe7VEfMmzh+fkgGlJnbvdRuQTdAL@nongnu.org
X-Gm-Message-State: AOJu0YxlekQ9rxM4RsPZ9FbkMsu1ySd0G4wLop7yF2ZCVZZXHi4bdIEL
 ogHT4MO67ZMKU6K0FwjcGGpacSuX9b9LwLQ99TGF8cbN65t8PonnCdJC
X-Gm-Gg: AeBDieu7vWQjD4TTJviQG5Iph07ENI+Pd28Th53jJcbwteBSq+R0rBq2avf26zknbZA
 qvePrJjzF3aZz2VNc/Q4dTR9Lmvam6z2WQ++mfJOdXdMpHBDyQzyeGRPEuZYrPZOexX4Xp86hoq
 f6ZI1jeOd6+KR3Cz+NoYxlkkUcDmMq8AFbsK6+vg8mMmhjbDaX4GckaEeP05fjcabeJHKMpbqyd
 MPyqcg2H7X6yV6it9oPS6CGoqCPIVWimTBMFAhQkmXm2iES3ajtBYQn/wx7Ff08kBFNtMd+Nf66
 iB+SgRS8pjKzQk1IPhHxPmOg/fbVx+/6nTjmpMZN8+9n3gCgz2u2cyXloA7hfbYSqf1mUeB3sW+
 eVXZTPnbY3pyxN2osZ7GwAyiEV3L3hyk4GbSnAa7wjgN1WZFppSR13FdOt3Kt/9slG6zmEM/Xwu
 /xB5BMkf4/gQGHII3DUEPV8EzX+xcbkfObcyDN3yRbQbd3NlgHtFIM
X-Received: by 2002:a17:902:f550:b0:2b2:5491:e32b with SMTP id
 d9443c01a7336-2b97c462246mr61989645ad.23.1777438321757; 
 Tue, 28 Apr 2026 21:52:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/51] target/riscv: Add a helper to return the current
 effective priv mode
Date: Wed, 29 Apr 2026 14:47:47 +1000
Message-ID: <20260429044752.4176397-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This helper returns the current effective privilege mode.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 37 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu_helper.c | 15 +++++----------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53..672f0dab0f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -806,6 +806,43 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 }
 #endif
 
+/*
+ * Returns the current effective privilege mode.
+ *
+ * @env: CPURISCVState
+ * @priv: The returned effective privilege mode.
+ * @virt: The returned effective virtualization mode.
+ *
+ * Returns true if the effective privilege mode is modified.
+ */
+static inline QEMU_ALWAYS_INLINE
+bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
+{
+    int mode = env->priv;
+    bool virt_enabled = false;
+    bool mode_modified = false;
+
+#ifndef CONFIG_USER_ONLY
+    if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
+        mode = get_field(env->mstatus, MSTATUS_MPP);
+        virt_enabled = get_field(env->mstatus, MSTATUS_MPV) && (mode != PRV_M);
+        mode_modified = true;
+    } else {
+        virt_enabled = env->virt_enabled;
+    }
+#endif
+
+    if (priv) {
+        *priv = mode;
+    }
+
+    if (virt) {
+        *virt = virt_enabled;
+    }
+
+    return mode_modified;
+}
+
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
                                               target_long priv_ver,
                                               uint32_t misa_ext)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 659150c646..513bad21af 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -45,19 +45,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #else
     bool virt = env->virt_enabled;
     int mode = env->priv;
+    bool mode_modified = false;
 
     /* All priv -> mmu_idx mapping are here */
     if (!ifetch) {
-        uint64_t status = env->mstatus;
-
-        if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
-            mode = get_field(env->mstatus, MSTATUS_MPP);
-            virt = get_field(env->mstatus, MSTATUS_MPV) &&
-                   (mode != PRV_M);
-            if (virt) {
-                status = env->vsstatus;
-            }
-        }
+        mode_modified = riscv_cpu_eff_priv(env, &mode, &virt);
+        uint64_t status = (mode_modified && virt) ? env->vsstatus :
+                                                    env->mstatus;
+
         if (mode == PRV_S && get_field(status, MSTATUS_SUM)) {
             mode = MMUIdx_S_SUM;
         }
-- 
2.53.0


