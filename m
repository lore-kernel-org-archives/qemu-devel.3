Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D1D637A0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0q-0000JL-JN; Wed, 13 Nov 2024 12:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0p-0000IO-B0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:39 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0n-0003oK-Fm
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:38 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20ca388d242so76068835ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518311; x=1732123111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIAieBmW047uDIhnx+/2hQRCiiVtdno4nQvJZeYlWlw=;
 b=BT0qVAJR6WGH6IWofvXlAz4cjIcXmi8nwZOhJ6b8xdt7DUnYaj0udXzl3EeTR5yfEi
 sH90Frvlib1vvVcqGaBOHnEgRZsbTZkd9kgIwTxn9AurinPx188GsbdxI1x0VDHuv2WW
 dmMS88M7QSMEC9+Oo0EIkmKoW6vLhpI08iq10R1S4TgXYdgP+NFjqhJv3iYKjdst4Yhr
 veXJagLco3ddR01YJBiD6KoXWNJs3GzdH5cEteS5f2K5Ml63mzw5aoBW7gL8/GUupvCH
 I0SMhm8ZF2fAYw676kfK0UGZlVamWcLDMknWrdeWd32xCgoKY2c0e80zfHvn274oCTCj
 /N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518311; x=1732123111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIAieBmW047uDIhnx+/2hQRCiiVtdno4nQvJZeYlWlw=;
 b=o8ZIBVH/nm22q5NDwmUu4u8+peaKiUoDTHNZFakXA9eBjg82uriz0Nt9yI7cfswk48
 PoDgw0nzoc4QJX2j4EQSOJZkJRjiGjhnvfKcUJoktR4xPyMbczLXywP4oQw9yJkzj8Er
 Jnj9HKer0MuChxhQobp960m7BB4109ci+OBNceay8Ts1naVj4Ipf66PvF42ZjeLu46QG
 ym8YkWxpXE3eqBjADbDGKBwoBxrQw/a6COZvS0x4HYS4LE1Kag2tMmkLBIUtg6T3xyNW
 D3vE1BKHhTuHyxn7GNdIy9t6GPhwWDKMLH6fdAGfsHGcRej0G7hFr74/mFDN6+f2fhdj
 W/wA==
X-Gm-Message-State: AOJu0Yy2pjaI7GL25pZ6b9darYec6WcD3kDNnzSd/Jmg7vIRQfPvXu/Z
 ZDMYGxtXKyhfEzO4zyC6BQOzSo/WUjMrd+vWYHaMsfwZLLZJ2UMrN3m69LJMslkVo7neRqNvrS8
 i
X-Google-Smtp-Source: AGHT+IFe/3SzphQ+oIR09CWG8x7/OksudLrg4yNImhZ6X0SaI7rUytK+j3hL0ZxpDohmpU8948q6PA==
X-Received: by 2002:a17:902:cf02:b0:211:6b68:ae89 with SMTP id
 d9443c01a7336-21183e6e6f8mr245130165ad.54.1731518310842; 
 Wed, 13 Nov 2024 09:18:30 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 9/9] target/riscv/tcg: add sha
Date: Wed, 13 Nov 2024 14:17:55 -0300
Message-ID: <20241113171755.978109-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

'sha' is the augmented hypervisor extension, defined in RVA22 as a set of
the following extensions:

- RVH
- Ssstateen
- Shcounterenw (always present)
- Shvstvala (always present)
- Shtvala (always present)
- Shvstvecd (always present)
- Shvsatpa (always present)
- Shgatpa (always present)

We can claim support for 'sha' by checking if we have RVH and ssstateen.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fff7010647..a8b8c9e775 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1615,6 +1616,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
+    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c7bf455614..7c60a5becb 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -140,6 +140,7 @@ struct RISCVCPUConfig {
     bool ext_svade;
     bool ext_zic64b;
     bool ext_ssstateen;
+    bool ext_sha;
 
     /*
      * Always 'true' booleans for named features
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0b9be2b0d3..b06638cca4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -210,6 +210,11 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
+    case CPU_CFG_OFFSET(ext_sha):
+        if (!cpu_misa_ext_is_user_set(RVH)) {
+            riscv_cpu_write_misa_bit(cpu, RVH, true);
+        }
+        /* fallthrough */
     case CPU_CFG_OFFSET(ext_ssstateen):
         cpu->cfg.ext_smstateen = true;
         break;
@@ -350,6 +355,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
                           cpu->cfg.cboz_blocksize == 64;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
+
+    cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
+                       cpu->cfg.ext_ssstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.0


