Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEC6C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyv-00077K-24; Tue, 04 Mar 2025 20:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyU-0005xN-PZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:06 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyT-0000H9-00
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:06 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2238d965199so61667435ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139703; x=1741744503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVR/Huqfaq4TbGUsXCBBJHlbyJU+hGBoWuEhfaSp23c=;
 b=L0toRI6uzfnihUsDxs25fnVtgzyH9lhaFv0QIXCRAjlUuWs1SW+CouxYLONelggg9H
 vVE7qLwxClbaQB+NXvxwuQlKSioxJqsaiOpUv+k3IqvJyzgygVn9QzUv0RSwwrPDixWt
 WdP0E6Ub8WkWecPKI0Jw9N2ytISMtmjo2GWEK1ehu3gUju+of4VKc3gPBSkr+u+aMcXQ
 cra3hPWIKj7KIpTrBvWN+z/jY5CNLf2Jv+s9mNw+dPN7x8cH1eOpphIZ3g1XJ6QHXrjr
 n35l8Z/KjEHAmPy+R/AeIsaa8wYTORhkVmOJDYW6S+4u4JQMuOq3fubMhBawHDCcc2lL
 ZSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139703; x=1741744503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVR/Huqfaq4TbGUsXCBBJHlbyJU+hGBoWuEhfaSp23c=;
 b=S59OLifTabO1ooAEqVncFOqL+I0qnspcnEjIlDc+jCorjHfI1FvtilOei1EBAprj/J
 s+HnvCQ0hAoahiBZOn4Lgt5sK683mMT0x9VbMoDb1zrWByfODd5PE6+ev5Ra3aStBdAP
 DdrQLghNNzKVtI50xWtJVM45LYDvDKCH1JBMkyhdsIJsGz8LdxsgcpRhZsS2oCoToSfg
 7l3sXhSN8OlZLW1kG8sVZ5JO53vfF8QqkCEi8L/4bpRBKsg6rE77h7LA+WaW+7E95hqG
 r0rS1iCMKMUp3LUu+5gbzpb7WkwYdfRxFpDxfJCwXLCKj+JFJynJpvnnrQ9BVUU+7xZZ
 hq+w==
X-Gm-Message-State: AOJu0YziLDvByztD9SRTrCegVnJhNRAgLzUDQSZW6KINn05XwFgNhObk
 wMVMIaJ4K19D5TCrr9DkCDuywG6XsDB6i2hNZA/eEszdA/7SymeMf++/Klb8e2g=
X-Gm-Gg: ASbGncuXY/NULN2mH+3ado/Xg6l8bvVpXYVW1H01qn4jYTyHVVgfndYRsSOIuVzazd8
 X/hp+gcKNG+19DSxL8ifeM5kFDBZBVssTF00zqhyTeAKY11EX0f0wqhlVfVujdvumrEC4KcVEjh
 Zem3SnYJqnb9yxzj9TxPiX9abB00bHWfcdEhKm5Fr6BOMV29MtsXdsNAhJWCBJ8eA3+N8Po2xnR
 qqOu9T3AkQ2ie6152gRrYWj0NV/06B9qfrPktN+3hO+D7lwTNLWH0dC1CTEZ5+cOGUR3G3FOavh
 fgTREuzv78+m2Wx2xWJHwGGVdPuz+Z4hcuRsVn0onU2JKilbXD/Qivb5nT5eCbKYY3Ex7ZxSrma
 bxfpep6r0Vnl9MIbIIMjzXG/IsMCuP9ceeubW44Jl+MJ8nZs/5wM=
X-Google-Smtp-Source: AGHT+IH7ma15kAKOu/g8ri6xiOrrtyDf2eHBhR4uXRETmNOocxQr3pZ6aez8CQ7aymlR+l6PJTRfFw==
X-Received: by 2002:a17:902:c951:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-223f1d0fa09mr21705455ad.40.1741139702727; 
 Tue, 04 Mar 2025 17:55:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/59] target/riscv/cpu.c: create flag for ziccrse
Date: Wed,  5 Mar 2025 11:52:45 +1000
Message-ID: <20250305015307.1463560-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

At this moment ziccrse is a TCG always enabled named feature for
priv_ver > 1.11 that has no exclusive flag. In the next patch we'll make
the KVM driver turn ziccrse off if the extension isn't available in the
host, and we'll need an ext_ziccrse flag in the CPU state for that.

Create an exclusive flag for it like we do with other named features.
As with any named features we already have, it won't be exposed to
users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250221153758.652078-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 3 +++
 target/riscv/cpu.c         | 3 ++-
 target/riscv/tcg/tcg-cpu.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 3f3c1118c0..8a843482cc 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -166,6 +166,9 @@ struct RISCVCPUConfig {
     bool has_priv_1_12;
     bool has_priv_1_11;
 
+    /* Always enabled for TCG if has_priv_1_11 */
+    bool ext_ziccrse;
+
     /* Vendor-specific custom extensions */
     bool ext_xtheadba;
     bool ext_xtheadbb;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a4ee381a07..47424fd5e2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -105,7 +105,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
@@ -1742,6 +1742,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
     MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
+    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
 
     { },
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 929ed5fd2c..f1d971eec1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -360,6 +360,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
 
     cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
                        cpu->cfg.ext_ssstateen;
+
+    cpu->cfg.ext_ziccrse = cpu->cfg.has_priv_1_11;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.48.1


