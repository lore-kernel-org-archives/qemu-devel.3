Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87716E8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHa-0007XC-Jt; Wed, 04 Feb 2026 00:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHZ-0007Wm-3D
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:29 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHX-000804-H7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:28 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso3488750a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182306; x=1770787106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtNhWeVMoZx4v3vlFITbXT3n9HHx54McIikf5l1fVU4=;
 b=XAkTbsF79DE/IVFKuQRHBUn8y8RiVP1nFdW6l/kZxNE4NeTDxD0zNYCYsc1WV+bOqT
 VxOg4iqDUU4ppi4uY+jgLhT0ar+sCFtWDSMIJHQ2Ov8T60qEEwJ+p1QVu2fALgjrWpBU
 UtbuquYCPtuNY6v1937XUQ+eaUWdQ4Cyi5lzw/KKpiLRG2pWK55szQ3kx/bu47YgIsps
 YEzrvUUYPcvUFwiIg4PUmhJPJX8OItSwsuMyC+/DYoflynV5yCbe18rMl+twNBi5xKaK
 eOPNbv2qypu91T9+55GiInXB1A3YZRR0UbchUtY7iAziZ0RE1FZf9Oq6hM362AojOv77
 DXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182306; x=1770787106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WtNhWeVMoZx4v3vlFITbXT3n9HHx54McIikf5l1fVU4=;
 b=XM5jauhKWP+u912XAWfMHAOqYiRiACSRh2KjznEbSxojFRh9jsyoVZqr/LQA2tyNg6
 elktzcHxz8OxPW5D+4tBBBWiFhOdLqgfCXd/m/bO01CG9qqqQeE0IiceGKRtTpFq5cTc
 eJ45XVmWBLiRlZbzJiGI0urCXnwOC+dRAbygYhu/+loKEOtjeMr6A80lYWhn7skaf5M0
 Iv496v8O72RJvYP317mF+VqQH2UGjovYjZMIyToqWDszvpVdtIDqu2PAMM1VlI9C529S
 nW9PweMXKSnqwT0Xq17bqgC9glvZJ3ctmpvzvYwplO0onJZmGvgxFeq+ieb9byQtoOAc
 7+mA==
X-Gm-Message-State: AOJu0Yyphi25iR0pPd7HJsUYeMwdpY2EG9fnO5J0ISUHbUjXuXwUHsBH
 Q4a0g3IYSpU1rSEgRRx0Mce+knR5GawFO2A3//KUHZgr1qIxPjlWPpCvXJDCdOBobKRhhZvZXG8
 7GPT7VwxQ0h0ViElD4OuAsJx1SL3QIeXH6fgdcTGZKGSMAcyuZbMPx8aararxjZaFDK75qQ43Uo
 Fv27WaGjq+LDRVoIk+wKkwuhvsouQ/XL/PP5aNuyq3evDS
X-Gm-Gg: AZuq6aIVZUIWuCL7LPMYYjDIHiAB1cHbstfsg2TDh6BeL2b7I8NzbzSi7ZStM7kHjdY
 4kHdQrgFMD3Bj4ajNhXhsLmvqp/bwGtEANUURFMoEe5CzBfNOewMHsIJsaXxo5nd/huRqTRDDzG
 9S3lnUgfWjaTTMy544xj0yirMG8xO79l3pFniZhMHzwpRwU+JaVoHvbxqhXwffk2xCeMKvAAzzh
 dYpyVolh+zRGsBJ7dUxi8VvhUhn/pLx0ghbG6F1G4S6eVbDRRkuVvkgilXduaA4Unih7HzNlmZn
 aGpX12H+Dhm3Ijr833bCc87AOEotrce5yzbE4wsepRh173IaZPFOSh5y8hB+k7sKd7gD2Lh8Nkh
 oX3MQGod08n8iyDOEzk6ABmBj3WAhchyRfV8Vx4dW8gJCC3KngVGYHk4IrWX+cAiqpcoeWKPQbK
 emVB157butdwg+0RvpEqc+ByZItx51mpsBwFWhGBP+dFr+Gfk9aIv6SZQ7YFWj7VYcXxWVfzyTQ
 45hbw/KTWLaBJo=
X-Received: by 2002:a17:90b:2741:b0:353:6373:590b with SMTP id
 98e67ed59e1d1-354870a8b7amr1700218a91.7.1770182305857; 
 Tue, 03 Feb 2026 21:18:25 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:25 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 07/19] target/riscv: Add cfg properity for Zvfofp8min
 extension
Date: Wed,  4 Feb 2026 13:17:43 +0800
Message-ID: <20260204051756.667397-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/vector_helper.c      | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bd17f61d7b..d6ce51ef5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 3696f02ee0..59302894af 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 378b298886..ba89436f13 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ec0ea4c143..ee5a1e595b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.52.0


