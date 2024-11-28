Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680ABD69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfGk-00058X-Hw; Thu, 28 Nov 2024 09:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGi-000588-1X
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGg-0005ub-E6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:19 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2142214abd2so6644585ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803197; x=1733407997;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaTDHyYGUwurrDx3I7AZnQtNa0ZJXKnA6MuUrQ8NqEw=;
 b=g6MP2DxEsKdzCUPOd+1rdLDxc8kp3pUrlsTHqx70EM+YZiWWw7khfsi8R8fdR9KwEz
 8x5rXW6IqebtbxYUCGKa6ytxraLvcB3IPPT4djGyOGaIERdVj2pcm9rO/H4nZwrRuEHk
 FI1FYon2ZDpvQe8SkABekKpxtTQFiRFDv5VWdou5Jq+lp8iK/U3b/cq3qE//iW7FgNkK
 59AIm2l35lMF+r80+82EMTbwxQrFm0xrflGuvu27ANUb0Yoi5B/X+LuO9lOH1x/xbDXd
 3FJI+BNX2z+N1r1v4Xc3+jMJP7FRqS1DLzO7GPcDz0xhx2u+3pCl3c/NIeWNoZHAEGVv
 SP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803197; x=1733407997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaTDHyYGUwurrDx3I7AZnQtNa0ZJXKnA6MuUrQ8NqEw=;
 b=JHV3ICCfY9C+E2qe3M2mpxfH1dGtPp5SPWO45g3AY9rqAkyk6FGYZavn8pznh0b5VE
 QWQmhaSMuErNws1DBw2vujUMuInr703aXNlxKljPxvVT5+cSrHgAstxwyyuxQ0lCgUjR
 hE47cLnaP5b4qmVN7ls6lzdi+0USl6nVdkS2zrNG6b82B6fZp6BShA6BMGzAUDnn+h8y
 zZ/dsDWEdmxgh8gFtIVoGkYt8+9sNWPoskaX1d78PGij0nkpJJZHk8i85UXKoQ56CeBa
 kNbfQWPjeH3zrE9Ysk1Y+sCIjxcaD9TlQBDUEo2algt7EihDJ1Gt6O4JkiMnbQVtVRoS
 vNOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDSbVHwf14+5MkvGMvQie/GOwQirTn1jMiq5f5LUvndVH5AAohqfA2Ro/vgxig0SG6xeLOWr3YT1uY@nongnu.org
X-Gm-Message-State: AOJu0YzFriOF+MerDdMYWf8ep7iyaWDjtKB9ePIISbjroytSeQJUUDMt
 xK6baYOycARKDZbBa8SmjO35GBA3s2RvykULK8fBGw+KLNXhmdRgxlXtNBuBT1I=
X-Gm-Gg: ASbGncsP4UPduTl4ljcfpJ5xhoK5tkA7cPEqmnfUeOiUnEImdG+dNiz2EPWB8zdCV9v
 3SLXBZUMSKToMKgzlFLWoUGroT6SJf5KvJRFvCPZHUzGqaFZ5n9xt43aqRtuvfiryFw7HVFNyHa
 j7/vqwXioLwRaMKRjFzR6oELfMAK5AVu2ORfHpmriLdrqJ05R9PN66pymQxo4RntMXtkWZA/Cda
 6eBZM8yx1j9GGb7ks/2QoVbhifi9q3Q3Li9kNJ+8XhjOXSQuz8=
X-Google-Smtp-Source: AGHT+IHXOSHBhQUDm4GJm/ij9WavbCZ/Ey4VnnTNbr+VuXy2Vlmxy6eDYCsj5qn3ExauY40+Wp3C6g==
X-Received: by 2002:a17:902:d54e:b0:212:5b57:80ed with SMTP id
 d9443c01a7336-21501087642mr100730045ad.11.1732803196949; 
 Thu, 28 Nov 2024 06:13:16 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:16 -0800 (PST)
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
Subject: [PATCH v6 3/9] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Thu, 28 Nov 2024 15:12:23 +0100
Message-ID: <20241128141230.284320-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62e.google.com
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


