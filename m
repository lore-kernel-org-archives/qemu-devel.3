Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB60C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPL-0005kA-41; Thu, 15 Feb 2024 17:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPJ-0005je-Vg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:42 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPI-0006Co-EW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:41 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso12363775ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036838; x=1708641638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTTNcK59UiSXYalt2ktdHl6kS2NT43afEsYVYkGvX6k=;
 b=Rk29nn/hg2m2WiO+S1DOschvUmvIXi3Y/oPtfUozkXpzlzF6pK/8kzo++RbsqUi4iR
 SN8d5VMvCYB4RRXJZrzgfvUi05X/hKAyIyc+1HKoW7259h9C7tpXjwGwks9Oic/QQEuP
 wQY8rLKR0ZeMabKL8vQPmxS2nDUhLHUP0hmncRG6rnD1+atpYgXL0nvH3NZqCtQJr0hD
 tUkOeRAsO0OS2Dp8isNwC5luaCIzsSt4ClWlyR6qOHTwxnMHrJifxAWuxXpG/7zJwF8m
 4KptHUINlTEuKWUJrLDFZH9kpoc8/Wwx6V2cKvBStQZjUs2O4XWh8rcbi28DOQgUZKoW
 vIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036838; x=1708641638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTTNcK59UiSXYalt2ktdHl6kS2NT43afEsYVYkGvX6k=;
 b=CcA2aKImqpdL1YiNNT92iOmnSEQGgM7mcrpzl/p+Efuc2hJweyWo4LP9jEKKwjChFI
 JiscMhetYRNpTmBPmiCjRESnOl3i7kd8/Vb6qPe59PSq1LucscBC7U9mvImgSYOBuJXU
 6HkX2YrZ5ND5Xd1zboc1v7/dM4NoeKoVoWUh1bnxFc9RcXIzioqJHNQmXPK8So+g20Ox
 aUuXCpnTqrAv1SXzLKwpegxy8IV0/7+UBk2Q/ckruOWRslcGRRbv7mtLcbjrrFms7YMX
 T52MQTapkKHzZf3nZQ2ApPERitmZq1KPTMrIYlk6dkODLHQ6p37c5bPTv4RzdI+SxV9O
 l+cg==
X-Gm-Message-State: AOJu0YzSUiNcDNYRJRHDvBmfY1+uBtL2GpA7XPUH9YvlhLmBEgzcKl2J
 hr2F4xOH3jr/W3QlUCu/CldFD8TE3MOBNJ9HYufJ1adAXvpI04qOrAD7mmql+fZParY/qwzcOrG
 +
X-Google-Smtp-Source: AGHT+IFXEYRKewXhM2hkRWrQtboAGIpmiggQRYIqQJWX1FL7856E0gtqEBWF4t+maF1E9Tn2jdDRLg==
X-Received: by 2002:a17:902:650e:b0:1d9:7046:fbcd with SMTP id
 b14-20020a170902650e00b001d97046fbcdmr2734641plk.3.1708036838141; 
 Thu, 15 Feb 2024 14:40:38 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 4/6] target/riscv: Reset henvcfg to zero
Date: Thu, 15 Feb 2024 19:39:53 -0300
Message-ID: <20240215223955.969568-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

The hypervisor should decide what it wants to enable. Zero all
configuration enable bits on reset.

Also, commit ed67d63798f2 ("target/riscv: Update CSR bits name for
svadu extension") missed one reference to 'hade'. Change it now.

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation")
Fixes: ed67d63798f2 ("target/riscv: Update CSR bits name for svadu extension")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 +--
 target/riscv/csr.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f424751962..e5eef3a4de 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -961,8 +961,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
                    (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
-    env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
+    env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b9..cc9cef3d85 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2133,7 +2133,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
     /*
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
-     * henvcfg.hade is read_only 0 when menvcfg.hade = 0
+     * henvcfg.adue is read_only 0 when menvcfg.adue = 0
      */
     *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                            env->menvcfg);
-- 
2.43.0


