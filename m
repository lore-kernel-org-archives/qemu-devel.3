Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7D9C369D6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQex-0004mO-2q; Wed, 25 Sep 2024 07:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQeu-0004iL-Ug
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQes-0000fo-WD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso62058755e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265493; x=1727870293;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=990Tx1Qy7IC4XWEHL20LmKjYVwPDG37slOaxsBSKYtM=;
 b=UcYe/2xnFMxqHEFb7kxAu4QZAuEfrdXwt4G+IxzaI/QGCPymmno5547hdHjmYxkB5q
 2k0rO8GG7ovQZX5z4Gr7W3iL75Yp1loU9o8zE58/rMlrnfHv47ruZjl3JpughWCT43ro
 VvX8Cp4Z9D3ISpxAqnFlsxVqvtw5/wuUHxu34x9DanFPcqbETRLadafEpBrqAu89YEFP
 XrdtRYZ0N+GV2YVTA1wp22v11EsGz4ZZgkYC12nYpEUTUqpO5SAcg+1Nim5DbQhn5v0t
 4p/0b5k508wQf2Z7lrXPCKIgL7nhTyh9EOCVgOu2I5FlBGUZTLjyc1qZbp1X80/Q9oPD
 wNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265493; x=1727870293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=990Tx1Qy7IC4XWEHL20LmKjYVwPDG37slOaxsBSKYtM=;
 b=cdGDeFqtpAIW7PR/i6fR1pUmPhutemkzXLRTVtjScFHVeeSXLtTgsVUpdjazGUq1SE
 +p/aSFJ4Z7O42ygdrI7JJOuPekB9/uwVklBJhnhvh1vhPp4UePG++CZevpjaHafh5M+5
 iU1ilZ6haa7a1FD+liRjEWAro/9SRwN+bM4LWo3FB0I9c3edSyeQY9Pon1ykCpiU/+5F
 YeLzDDPf76Ayv5i/y2WlixWmOkGhokMbzEqt9UczM+Q1HBEa9r5tMANC8UzyvUXeeut+
 xeAoLXUxy0qTJejhbj16UiiEBkY/b/bAVKlH/BNJcEjh+sPHBEfIGUuL88wGO4q5uX4f
 RxeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPm6BaMPz5EFahgWQVe+KtQWQCQno1GCOT8T4oOtZm+4yKLljsLaSPqp5Z1IVeYYcqmli0kdHy7SAg@nongnu.org
X-Gm-Message-State: AOJu0Yz8MgIbWyiMM3RL9j0qg7wEdfb5jiAQ7vHzjH8SmWPnbiZNAw2i
 0dsv9LpqT0koU9iY+uwMUMBLOJE0wlfxOPkDq4SyMHsfihy6mRWu36KJwBzKtBU=
X-Google-Smtp-Source: AGHT+IFAmP7M/yn005PqgJh9q6e9uaHLk4r4Rj7vHaTeQJk/BGHH9eKmaTInvBGvkulQtluf9fAxLg==
X-Received: by 2002:a05:600c:3553:b0:42c:aeaa:6aff with SMTP id
 5b1f17b1804b1-42e9610c92emr18902635e9.10.1727265493398; 
 Wed, 25 Sep 2024 04:58:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:12 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Wed, 25 Sep 2024 13:58:00 +0200
Message-ID: <20240925115808.77874-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925115808.77874-1-cleger@rivosinc.com>
References: <20240925115808.77874-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
to VU from HS.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6895c7596b..00b6f75102 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -287,6 +287,18 @@ target_ulong helper_sret(CPURISCVState *env)
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
@@ -297,7 +309,6 @@ target_ulong helper_sret(CPURISCVState *env)
         target_ulong hstatus = env->hstatus;
 
         prev_virt = get_field(hstatus, HSTATUS_SPV);
-
         hstatus = set_field(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
@@ -328,6 +339,22 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
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
@@ -345,6 +372,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -382,6 +412,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     if (prev_priv < PRV_M) {
         env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
+    }
 
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
-- 
2.45.2


