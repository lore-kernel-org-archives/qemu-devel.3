Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA388F327CB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Y0-00006R-03; Tue, 21 Apr 2026 05:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xu-000055-Rp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF7Xt-0007rT-6j
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:37:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso2571395b3a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776764247; x=1777369047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEioh2IayfhJrxVNIwfPDLydV5qmzTqIwQsaJf8KtQk=;
 b=asuohknoNkKAiPelRxAJVnTuUSZuaVZDZeiNSP9bDEqFK0dac5Zlpg2kit5I5iYGXX
 TYPkeRZoDF+SmrrOV0brWnCnUhicU4bxizslRaapqbQp8g/06y3JPSI2+FoLEEB3u82M
 gnRnbWtXDwFbQcbyp562MCoMUrN3K00Yvbcwpo+ZX8RUipd1ufd1ZYJb0PYV4cf0whyw
 UAH8p/QRBIfFZdIhpYy+G6jg28/RfsuIJtgq84hmLPaBIefHLT4xGorenE7iL71m6L51
 7dKki5YuXrt8XBYw4jlTpZrDKReo+aSS8H+ZdhQqrmKDcri7wapI8wwbYXYjKlwXi4aw
 3pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776764247; x=1777369047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VEioh2IayfhJrxVNIwfPDLydV5qmzTqIwQsaJf8KtQk=;
 b=p6nD9kGInmQe85ML5uKUayq0rdVda8D1J813ep1wWcXfp98cti8F9n4qw84tU6TTHP
 U0hsLL2uKP+Tf94uHvD+Bp60E5JZvK8hzDIeuTaS5X95o6xDnHQH7swZiLw+/8Fl4Va6
 SHBiGXyfDpGW9UKNMGN2f9XdM4R+urbj3HryEEGysogpz5u1sKQP1Hv+8m8fqQQ/fTI9
 Eoh1F/fiP1IopttCv64qzewIxcR7uU+lgOalDxTXDLmyssTMy7hWXRM4V4oDhfi7tv82
 J22+RhSAGHLMvp0EyGEZvgY4+o+S5g1fFg+F5FzWYrehwrZxzYHaOBlEBnzrboEQOUBp
 yC9w==
X-Gm-Message-State: AOJu0YxP9lft/614s/m2M2BkYTLsjKpV4qB1KBc6cfqSwY8WCJ/SIfgB
 kwzFAoenz+jcR/NZkY77AzrJiLjJKsQtcIARzrbz7TUokGq0GBJZyuq6iApuogydB/0FsCpXQHa
 rXs49WzLt3rp6j6uSpoOqSsve2szmvIP09VhtOJ62xfocmr36NNcBMJ7c6Gi+/86nlmYEsSiWzS
 A09+a5XXItR50BfjQQGE6lHfxR7J7eTvz/KKVNNHNburb5Yd25
X-Gm-Gg: AeBDiesF03K4S0Eax06TI2m9mHlVChZ0q6g3J12+E9A58I+kAVXiOX98MDnOI3wYOEl
 f7yJcMJZiNJXnDN88JQk294tYVGI6zT2I/PvnqsvvAQ2TUloh2Rw7S3Z3GDEMB6T5JUGYPCXw5w
 umOG6ubzCdPoQtSLIvEMDXjnR+RbFOHc2nOQnNsFioAr5mJuFDzFcXQVr6xh0kPJmReEwnAQzli
 SW33GVyqtTMZ0Qd9QjG9xly7HcL/KEnMpsRTA3PJIDg62896gTAMrn3M3AO/u5lNT9YjZr1ChCc
 mcNMrGDsNqBhDdd6MSSulQPNvJVSdV3v4+D4k2FbLvnppYfY6tNLgMT1KcycQodwmpqEn2dqHRj
 vZYstx2c5B+MimfWa5Q/WUOMtkaqHNEFlVOI58c9jJZ/90RJIBdyTmyXq4n13cpeIerxrIF3KZj
 FIuoh2lWzIlWARBefyhAd+RALEpbSgY8ZrSdwrX1GtqsqQWM9OTAMmjFzekjx/
X-Received: by 2002:a05:6a00:93a8:b0:82f:9c37:ea65 with SMTP id
 d2e1a72fcca58-82f9c37fbdcmr11126305b3a.42.1776764247101; 
 Tue, 21 Apr 2026 02:37:27 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981be6sm15904589b3a.9.2026.04.21.02.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:37:26 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 2/6] target/riscv: Add a helper to return the current
 effective priv mode
Date: Tue, 21 Apr 2026 17:37:11 +0800
Message-ID: <20260421093715.2995067-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
References: <20260421093715.2995067-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x430.google.com
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

From: Frank Chang <frank.chang@sifive.com>

This helper returns the current effective privilege mode.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h        | 37 +++++++++++++++++++++++++++++++++++++
 target/riscv/cpu_helper.c | 15 +++++----------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53b..672f0dab0fb 100644
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
index 659150c6462..513bad21afa 100644
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
2.43.0


