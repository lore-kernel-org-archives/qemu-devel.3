Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D542CE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTY6-0008Or-Cb; Tue, 17 Dec 2024 04:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXy-0008Js-3g
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXw-0001WC-4B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso24536935e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426434; x=1735031234;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaTDHyYGUwurrDx3I7AZnQtNa0ZJXKnA6MuUrQ8NqEw=;
 b=Vv3EJ6V79hhGPqZUNmJaWvyqGhb/UQ6dgCiDiF6zJM0GYQnbepWaH8BJK9wxJ56gY4
 fuFSpN7ZNRIvZYy2LvNEhFt8Om+hR1CVFb16HWvIQcGqGXmCGM/Mmd44RN0tjYArRj80
 MyjLZ9E5w2B588WMbhifw10BffbTu1utZ/4jRuo/YL+H01N0aorPWpYdExIFtGbkE/Rz
 sh4MD1BrvszdqccCapjpFzOVl8HhH/gtpAJc87Wcg4UGCbMC0N53RhN1ttEqbsAlA4q2
 pqrpjoA4Vh7ODZhhAeJev/NUEuCVhPgi5f2oI9oDSpperqc1bFfzcDKZskn31MKl1xgQ
 wCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426434; x=1735031234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaTDHyYGUwurrDx3I7AZnQtNa0ZJXKnA6MuUrQ8NqEw=;
 b=h41CFaF5nlNwmBXeVLe+3b33Rk/5+5r63h65schxiafTEk4bZMx2mlUHJqpaFs6wxr
 F4bzfoaVtky2XcFwNlhfVFp58REZTKw26XDytSK7w3C+IJco17MrxvXml9WXSMGEvYR/
 UhRTZgId/6yajv186f1q+2dWAI5oFNm62UABHUgatAjhdsvOspgVCJCZU4pFuo9ONVu7
 sT3S6yGDN0VlhgI37mK2tttpluHh3lKXCIkCXEK65+3y63FrdxOOhP07ize9rjUuDkqh
 Pg+XC/1r/TDES/JdwlXCQq4Obi98qG5wCcIoyjqFyFLLtoN94UxRFADPwLzQ437gPSM9
 YJVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhGQ0Q/EbnvvAGhkNN0lKYeTLY4k5m4ltwzGMcLsaXeNMS0jb8Uv/mXqXNYlgB5OO1di1P6N9OqdxN@nongnu.org
X-Gm-Message-State: AOJu0YwHFREo555vO3SDB/+AbafASScyqhCAAQLjzhigQrDhMIF1nPAh
 mkYP2fm2n3gSET38gSX32FuG16neMP9+hV1uJ1j495pDui6om/zjbF2O7PiRaBM=
X-Gm-Gg: ASbGnctrQZQf+UGwczYWxbj5i49vIuUsLAmxm4+KvMD6t443h6pu38/nJUsCqnwi9oQ
 3PZIkM9/5r23di24rMGjKL+aUBFpeu8nvpiGfjhEE+kjWNlForXh3qw4ZzMTDUjoWTkkCFKnSTF
 ZtMhryh+ovFQb+AtI3jUiACs826DNZE5aMLCxBjtFDGBVotRnJ35gxZlRAuFGPPiRbZKzfB18pK
 9P2tSQXRdQX+kmMXnFtwI0GNeLg0uoDcCoIw2jgTOh1XPe6zRwdjiCFiw==
X-Google-Smtp-Source: AGHT+IGGDh9sXxLmvUUAzIuM4BJARssM39arGx+NM1h0b0U+hixB7fOG/XI9R3mxsTAA5eQjz0JVwA==
X-Received: by 2002:a5d:5f4f:0:b0:385:d7a7:ad60 with SMTP id
 ffacd0b85a97d-388da380a9bmr2485601f8f.3.1734426434374; 
 Tue, 17 Dec 2024 01:07:14 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:13 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 3/9] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Tue, 17 Dec 2024 10:06:59 +0100
Message-ID: <20241217090707.3511160-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x335.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index a4b625fcd9..eeacb2d1a1 100644
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
@@ -337,6 +348,22 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
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
@@ -354,6 +381,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -395,6 +425,9 @@ target_ulong helper_mnret(CPURISCVState *env)
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


