Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F24EEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVV-0001hX-BR; Thu, 12 Sep 2024 04:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVN-0001Kt-Vm
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVL-0000Je-QT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so6349165e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130922; x=1726735722;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=990Tx1Qy7IC4XWEHL20LmKjYVwPDG37slOaxsBSKYtM=;
 b=AE7NsHRFtRKo/dh4GXTrW3BrANANcMb2EBLpepBXSY7mQIaBchVZ4HffM0aLBfzoHs
 iFbtY4YBEgXnDBphrw/+nPxDvsWsOejcIFm/5/d+usrYTVkvKa962VXnLh4aPIk/5WvF
 cxPM/EXEs0wfUz8lHdVvhMN3mLvJXR9+CnCc4nhh+fBSOta2qJZ7qTUFEM9C7ZtDd1px
 g2bC1ILSLtflbGtfHh9b5h2RCfqm638zVFuPMfZZtHgWwVCVDvW0ELh084JvHIJc0I4+
 VZC7f+LvLiZmnV/irCyODPvhcR/fStsCJ33901wqbWlVQ48I/a4cxjgqEzzOOnPhnU0w
 v2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130922; x=1726735722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=990Tx1Qy7IC4XWEHL20LmKjYVwPDG37slOaxsBSKYtM=;
 b=snDxTqXX84L/7j/laLmKHVQei8cXrebGZmTd5XIW7MGBKdqJAYNCBbZb2xdcfqshbw
 262gF0VxExdhoQkm0yDmRymYjhMZKYajMenfpAK3fC0m1zmYKRmPhXRoo/luBAk07Meq
 c8/0PJiS5qWO+reCYAA9FuwmiTm+ewH9+TRTBfVUAiYjfeGVKcFKLiJsOPkxtvQclJ0i
 RzhhNql0KKFvK3T8gjI+mrg1kra7NImvHRtnhKxWkj/RSv2QdLk8iekHak0IPRLZLPor
 2go+/e4CHNrILpqQO4hJ9I8EuXi4AswmNjzN4W6A0Idie+luVj4Kn6hcG7tlRk254gVT
 9Bdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjNINCsA1UjBCu2hLr5sZO19vaMdc3uZa0EjoMvN9j/6XfLw1h7+Eg97y9VjbHtWC0FaO41cOvO43E@nongnu.org
X-Gm-Message-State: AOJu0YxevdjtxXNV0wZzqbMJ4o/xA3ujeVvhYt5WkzgIEPb2uMdFn+3l
 Df/zBneB6t+0JwYIj+AlfQh7fciEx+3xSHgxhrES36choSLuaB351h29QyMppoM=
X-Google-Smtp-Source: AGHT+IHW2JEih895gu8DqoSbz+pLAUR1dMwyLOAQHA/mBXiE11NRo6WRI/Jfnw4UdIr3TX1pyHBjSQ==
X-Received: by 2002:a05:600c:1c1b:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-42cdb511e6dmr17114765e9.1.1726130921196; 
 Thu, 12 Sep 2024 01:48:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:39 -0700 (PDT)
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
Subject: [PATCH 03/10] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Thu, 12 Sep 2024 10:48:22 +0200
Message-ID: <20240912084832.2906991-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


