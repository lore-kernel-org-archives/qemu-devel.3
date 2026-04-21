Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF2F327B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF60u-0005H3-Af; Tue, 21 Apr 2026 03:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60t-0005Gd-01
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60r-0007vp-Gh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:18 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so2085407a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776758355; x=1777363155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks68krkbR1ZbAf4VuNcdbmPpZZzHykV2qxAIKB6WeA4=;
 b=eK22hFD2j9ekCe6JQjtMM8qLyjVW8XKK/ejx9DN51/w7nBuCnuefcGroQ54PQRi/70
 3P79PKxfw0zmP0uA8uX2vKd3VrL0uvLn0DLQW+X+3zdq7Ff/2BoII8I3sq5EkyPhr7I6
 2NZVMFwhJHiwsmOMBF80D0LEYSrZDQRKP2lyEkK2mXaI3eqJ+1EL7ORnIMlpCu6Dis5L
 pfEBh9HxzW+bgHtpTWFJuL4TgZBd9Fw54YAIOo3I7Gty66X4Q3v05lf7F1Ol+Wl6XRaE
 cHhNZ+6leUj+9aE1eAZA6gZF0WolmHaPZf1UZMC23W4psj79icOddCFOe7pUp+PEAkPV
 3dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758355; x=1777363155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ks68krkbR1ZbAf4VuNcdbmPpZZzHykV2qxAIKB6WeA4=;
 b=BlNcb1cvhsrs0nDGi5ksbLt2Sk9vBmIVdG8tV6kPyznu0TrRmHkzHA6ViRm678TVH7
 BEDHZyw1v6XbDE7t3BiCRdfymglRZ1wdk3eoyLI0kGeorhhHfMfthjVEBJNQjdgzmX6H
 wxW0iu/6bh1VnCQfT8U4brbzPYtP92+qElDTQmIgXwhw99GE67mFt1kyzYFkg+mJADyF
 J3E3Nod7Qkmgj6If9etx9zEmXvq27jXbetxAk5+5nfvRbeaK1wZlhxcTiQ9AnT1R7nMA
 y7vUUyH0RpVFlPe/Wov3HN0htIxLagmGHmQ5oTtGtBgI0plmHmddMWxQsSOk6c+jzCcy
 XlKw==
X-Gm-Message-State: AOJu0YxoPbKLSTqAsuyjp56Ofwdv+JHFTFW+O3yt+NP5NgkCbSQeyML0
 uO0K/to42QRSARRrTCneelaruYIj/0owSwoR2earb+UPN3M9SEUb2em+YMRKZnTE+CVgCw1GlHb
 xnsOfh1EPrLNURYMq2G6b8Gue274n6xaR1KTLIrj2ylEPMlpVnQs7h7KBf96xim/SGmVKn1q5A2
 urXLHqXsNCtsricwWRfzZRCuDxarKYVtS+UZoOLZPL9JeAE+9N
X-Gm-Gg: AeBDieulPhHbWvnQuLZY61MWGOhrgVG8ruKDeVNzMxphZPb/qYQM0WYIRB62uhzd1WV
 /5NRt6S+DmXDS01vjBg7ETS/RxnBimFifwQhBfa9pivWNaX/C3qkx+/W7PIkfEvtlYVq0i+nW1F
 u0IthrHg0lfeK4Uv0nsMk/iYLk0+fVaVKTzBnBkHNtSVFoTJ4AMD01u2OjSumj7aM0Fh/bybFQ1
 O2tFrkK4FnID0A9yQ8ZCJecofhJy9fKjBtKCpE30WdhaW/zA93Dy5nBjLOqM/1ZS3iw1hdCvFPW
 OfgsVks9+sUN0U2hV06iOhhhgSd35ewv1nQW8PU8UWtWcl4tfzxBexSfEO2d8Ziss9Xs5pyYRCh
 MSuSLPuG64GMRSpqrpgdallC1D2jxpC3k14bnvL1AyCkIh1endWxOuBHxvuxC9xApv9Fv9qy2uX
 sujvdqMi8i/qeMOXvCgQk5mg4jr5t/cVb68OGt4Wo2dum406idVjVRrxl/rbY0
X-Received: by 2002:a17:903:1aed:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2b5f9ec9cc0mr164188465ad.5.1776758355349; 
 Tue, 21 Apr 2026 00:59:15 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff729sm155605695ad.15.2026.04.21.00.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:59:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 1/2] target/riscv: Update MISA.C for Zc* extensions
Date: Tue, 21 Apr 2026 15:59:05 +0800
Message-ID: <20260421075906.2928317-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421075906.2928317-1-frank.chang@sifive.com>
References: <20260421075906.2928317-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102e.google.com
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

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, we need to set MISA.C according to the rules for Zc*
extensions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f78088956..0f68560bac1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1163,6 +1163,37 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV32 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+        (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
+                                   riscv_has_ext(env, RVF))) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV64 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1170,6 +1201,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0


