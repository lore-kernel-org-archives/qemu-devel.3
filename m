Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85CCD185F3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2H-0000Yj-E9; Thu, 08 Jan 2026 08:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2F-0000WC-7q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:43 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2D-0003UI-HZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:42 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so2004274a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878800; x=1768483600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKpAcKRrXMRup1+LVEgxztSigEmbBzKNVUlhcSLkFw8=;
 b=Wpv6J4iGitRnbjihDR/G6CfzZ72nPCjj+rX43I/oLZ10mPiRe1b4et6UyKHPh4K5+5
 jn09CqW5UPBOvZb3Ew59KPHvOlNjFMhUBoK35yTUZgKYHKr98zbW9GTEUhx0/+byDKi+
 FNGyDSMpGGvrdFk16C4aF8cRVqyLcRml3rEAJ6u/iJI1mqDViBxKH6c98KaFbd0ExokJ
 NlnCRGqXH07hFYO4sxUZ8DxlY/r+4RQzWkEntmQgHcMmTNKUe9xvbDUt9iG8iYwwIalk
 6lRHGuyvRkcGkW7KEfWr0Rki1qR8UAGOt99Ry7h02VyKme1SUE3cMUObffoUiNAclMl/
 BG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878800; x=1768483600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GKpAcKRrXMRup1+LVEgxztSigEmbBzKNVUlhcSLkFw8=;
 b=TzS8w2xckCvyGEKQ750VpSMTx4Vk12c3EiyLcpdkyKquiewbptCyWj5tkLm3J6fGHa
 J+JU0GyMEIZd6kDQ/3wNnoAmxEvFkt0mgKBsr1qyVtxJQoHuFAVTV5iiFsbfE2nWsjET
 6L6JoefkPH9IS2otMOLWhPZo59VwxtXSPkzRFejuMQcXM0/nxyzD9Q4Q56M7yVPoYR6J
 MKc0p0tBdbIRkCGwbWEQ5wOIiFfjDxkvgFh4WHEvRhzpR4cD6VZJqz52kAaDf7d3XLvr
 Fa1f5c6go11+0luOFi900WYGn00DmPyFje0pxAzfQ5geX3r75PSiGhJYN46HjovqbtBk
 p76Q==
X-Gm-Message-State: AOJu0YwPAMHIQattgxbfcrAXiXPZzfmfHdvTE3K+xbBUKTLhiwK5j2wk
 vPEFZNrnVRqEDZvhsao/m/hZUXeDrY+k1RMLqWx2R0sIZ6tYkWG4yuNV9ikVwzyQa2NwK7txZxs
 FEHp0vUrpOaKP9GtEH56E1USrBHY9sNtEGmvTtHGi/gKFHKxsIIF7uF+1FfUy8JmUWLiYojoPnu
 4hEBznF33o30NYf/lR5Ay8ykdAsFKbbcTvCyH83HU=
X-Gm-Gg: AY/fxX4i2FVzom+icoeVujv0Y6rNWZwkoXapzCaowGyps3qaCWrQARA7v6+ZPHzjwxK
 9OQQZBLySBmTXn3dXYhTymHOIe87qPl/iwk8MhkjXEyt8QJBonPKye2ure7MB4zXS+FQKboyQDc
 h+9JIR4VjkIjIEI3hxhBfwpy1OD/INjxh33OTSBEO6MT2wq6FS3qh0o6OfEEdekGhBtbgZy6vT7
 nS9RRc8csG8mb8oVWNcIWWWx3RgDYIwFiNFgLpxgjgG/m/L0uLlwMhnl+pBUvnuSkFde1YJndkp
 CAyomaqMqShiEXIv2hB2thmJzUgboGyPAcyi6zkExhYYx2LtOMZnLefnHehXswCNZEdnDNeR5Iv
 1Ot5Fnv9sHDHqqX4C8RZ3yVfvzovC+SlvWvfqZBUolSRe1h0515NgbhNriKOy59PlZv500gKgCB
 SbVj5/gpWuBQ5cRsketFIwXIoeUaRjRclEeoOhxCXW6f1bW2GvrvflAAo=
X-Google-Smtp-Source: AGHT+IHX1bSauN5KzJUsIIrNPKnrHGBdWFcYPX3r97tjaf7wbaxor9pHIs/TqCwP7XYae8i+yEeS8w==
X-Received: by 2002:a17:90b:5810:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-34f68b83b04mr6337394a91.7.1767878799998; 
 Thu, 08 Jan 2026 05:26:39 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:39 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 1/9] target/riscv: Add cfg properities for Zvfbfa extensions
Date: Thu,  8 Jan 2026 21:26:22 +0800
Message-ID: <20260108132631.9429-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x530.google.com
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

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed..d8e2a7ced5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -188,6 +188,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
+    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..3696f02ee0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..720ff0c2a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfa) {
+        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
+            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
+                             "and Zfbfmin extension");
+            return;
+        }
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.43.7


