Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E8C02188
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJuh-0003IW-0a; Sat, 18 Jan 2025 20:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJu9-0001o6-7Q
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:10 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJu5-0003Yw-5p
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so5276902a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249303; x=1737854103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usdi74Z2L8EQHLLHA61Sr3nutYeLak96FojtLJJZO5w=;
 b=AGb0fXqyYjcBdMozoaVhf2b9rh8LHPOHEtcmLKyo45kF5dbOki0V4OONHxR4uqsptw
 Kbnizkyy16sAcsOEj8WuNUx0pm0IqQKpZR2ccKPLIFiRUtS9hqYVlfW906dR6JT3SjPm
 bJmWW3b25qyNjyfTmNnrO+IyJ8RhJWfMIXxCEsZJryDbh8Ac5I8APAKSFl3B7x7mHq+m
 d54nRGeQ1DNmh1Rfnwgl/BrdQNdcr9hRrE9bHFSIHh784chz3FjRVGX3nuRjxO7+SOTh
 IDDhLByASmBVSNEEB6UgMmSoP7cXoWI/6t6p5dOeBxQmDDDQ5ChA9u3KsMIF7IuY4Rw9
 tMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249303; x=1737854103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usdi74Z2L8EQHLLHA61Sr3nutYeLak96FojtLJJZO5w=;
 b=nFBD+FlFff9ylNXhQ4CjOo3TRmIPVraCQzG0tV7ekERTkjCdSxTZv2xfGuXTT/yPdD
 FrwHQweuSOX1gF1IFuUuGjy5u5xoMW0IsIhz/dy41z+Fr1ySPjadXdAKldIXISPWLf3c
 AXWQ8e2I4UQBk1YWKrm7KMQ/N8pckO/Apzn3DxA+Aq7tYHJyVjblRZB+4e4V0o19KCsi
 4gOVLCs4DGg6iMThE0Q5fG3dHtSeP3EnxDeZAphPOmNeYU80rLzrjSEs9BInP8dVLe6j
 HmNObHGffVlMQepAQjxlP4gFeSrUpcYhvH0GgRndMEPUcKkIc1skkTTVJD7CwXUZ5CVC
 UfrA==
X-Gm-Message-State: AOJu0YzGVBvMu7WhTYVAqlGkBqYjhMWEijLAgX5NKm/bnBCDlt3r/vg+
 mk0bSMQPIdA/UahqHuwiypkcn3Fy2k6+3bqgKNGeRH2fJNZBCoLlTDakLnPV
X-Gm-Gg: ASbGncujmtUA5zs3XYIP/C/jyIYhrZY+8KASyvvh73AbofLLHjXX4L3q+5+QAdA0PPu
 FBRZC6OVHtxtab87JyYhm3BhpCsJQjzMDbn1cJ2DUIPZ5Hfnz/XUqVk5G0MmXBHKslMbHiipxcG
 yCrTha3e+b9ZEEqC+Ge+IQsXOZAgmufXTyBs0NfdyFHpvNI5wrCAy15twDJNNUWL1ZtR4bXGN+6
 lm+yNIMGbUCeVJA2QJYunzsH4T72MAhfsYYW1C9vuBj7YQK4QurOWH/84RqhAAj86ZznVtZSQyf
 dbbA1CFmZsN2Dj2YFl9yooFAs6w9rWRvvharMWnzmIubYgp5hLotBoovCeyL/rKFKIcABoym6g=
 =
X-Google-Smtp-Source: AGHT+IHl8E30wWlObsPF2BLmwx5b5HuDt0oxm0Ci8jimx7ujCt/DuSAmU7V1zaYYwkJwAGpaprJKOQ==
X-Received: by 2002:a17:90b:1b46:b0:2ee:463d:8e8d with SMTP id
 98e67ed59e1d1-2f728e47195mr24969707a91.14.1737249303290; 
 Sat, 18 Jan 2025 17:15:03 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 41/50] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Sun, 19 Jan 2025 11:12:16 +1000
Message-ID: <20250119011225.11452-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Clément Léger <cleger@rivosinc.com>

When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
to VU from HS.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-4-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c825336519..59c4bf28ed 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -294,6 +294,18 @@ target_ulong helper_sret(CPURISCVState *env)
                         get_field(mstatus, MSTATUS_SPIE));
     mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong prev_vu = get_field(env->hstatus, HSTATUS_SPV) &&
+                                   prev_priv == PRV_U;
+            /* Returning to VU from HS, vsstatus.sdt = 0 */
+            if (!env->virt_enabled && prev_vu) {
+                env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+            }
+        }
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -304,7 +316,6 @@ target_ulong helper_sret(CPURISCVState *env)
         target_ulong hstatus = env->hstatus;
 
         prev_virt = get_field(hstatus, HSTATUS_SPV);
-
         hstatus = set_field(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
@@ -344,6 +355,22 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
 }
+static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
+                                   target_ulong prev_priv,
+                                   target_ulong prev_virt)
+{
+    /* If returning to U, VS or VU, sstatus.sdt = 0 */
+    if (prev_priv == PRV_U || (prev_virt &&
+        (prev_priv == PRV_S || prev_priv == PRV_U))) {
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+        /* If returning to VU, vsstatus.sdt = 0 */
+        if (prev_virt && prev_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+
+    return mstatus;
+}
 
 target_ulong helper_mret(CPURISCVState *env)
 {
@@ -361,6 +388,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -402,6 +432,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     if (prev_priv < PRV_M) {
         env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
+    }
 
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
-- 
2.48.1


