Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEAE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSGy-000357-2p; Thu, 19 Dec 2024 20:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG4-0001mc-QF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:53 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG3-0004mV-2p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:52 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so1260190b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659810; x=1735264610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q91CPRzhK1oN/ujwAJK2FZ7kmB/x/zQicuDmdvSPzQY=;
 b=RKXfHEAz8wPZxYdQqAPIajKl+PkLeta3hIBuFhJ+kQI1ly0FeBaX9H7HPnKmyMURUb
 hFlGJxH1l7mMYzf2giSjt4IeCzs/UzBdNnsmAAUg3ACDrbohEMK7K2rEX97ToDSUZzLa
 Eh94ubzESZh9NGKYxrmFDyZqeGT2q93s4MM51p+jZCoOeU9YLUapav5hoFG3dOS85CCX
 /bbIYMhggMOFtMOHc2n3IYm6LRe16bOGLTqrR1RfORCUsIiDl1vHzBD0XoNHzi1z/yvw
 CWpHvfQJ/H+Lto30uy3FCwN7azygdkbZmNFKc5VIkCT1iIy3T/609VDmzvJUXod2k68Z
 yQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659810; x=1735264610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q91CPRzhK1oN/ujwAJK2FZ7kmB/x/zQicuDmdvSPzQY=;
 b=KftllEbd2ZnXLlEO9dGyKIQctxCwcOJcU96hOVdsu0TldDNCTWBmVk2u5ARtxBPXM9
 yPqP08O677hprHvIiPhSk+0sRptSts3EwfLA6HxkFp/AX5/fNH1uH0mJS6vETF8CiwKd
 kXbpPkMEuE0XusaZAvke4wlT20bVuacLYRHf/zutJkEE20P+8QVJ9ztn/F1Skv0mZ+kU
 h009HGh3AybbTT2hyY+1BVxh7MiSw2qMI0QRxzxY0ghlp/FaS/FLZx/wZ7SPmnQg5fRc
 62eN4qghkc+E3RO6nPFju12r+WWQFhzhsiRRIXKw6ksUO78uDh2D9QWhBVnLUdAczF0P
 aVCw==
X-Gm-Message-State: AOJu0Yw3rPGD98z4B/c//SAmZHa/JYTx1oCVScHA08wpZS5iOeUtj43R
 kGmTNvvvvV/AOQt8CsaozjtJvPXmF/G1TgKoGuXSXp+1nHjuxnhzh5e1a6Nc
X-Gm-Gg: ASbGncu7xGD5Q4JjAe0QXJFzr2Hai1CEb4CXYcLfcQLKCwK6sHuxSaEGu1/eFO+fawf
 spZxeDJLg3umWA69KTki3o3801XtWgjDji53H22SKELQzYHUYpexiOzW7O7gyWhCip9QHnQ7/Dl
 fsd6ZJQmKflnBvAT05dfcfMgChPnE41JW1saNY89trt9o0xkcW/sYz3ZIvay/y2u92fP2qMqIDE
 XNoOEPkniy6Fg6VRLOjeqkSU7DM6Pq7P0tsUxY1m/N8DVE2nWBAoT23+VMgHEOMSEgr2Pp4BpAZ
 xgntWh958YmxwSx1Sa4+IgMO6riRzr6vD3JQtI2ZCSqgzUPcbJY0P0IRoUcFCy4=
X-Google-Smtp-Source: AGHT+IFDOFjQnGp1ANq8A9mRq2tqQFgZyAmYP/+39ifBj1KlBtmEsYe4KyfP5ayirzqDY09DWzhWYA==
X-Received: by 2002:a05:6a20:1593:b0:1db:eecb:f7a1 with SMTP id
 adf61e73a8af0-1e5e0481aeamr1681452637.17.1734659809603; 
 Thu, 19 Dec 2024 17:56:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL v2 38/39] target/riscv: add ssstateen
Date: Fri, 20 Dec 2024 11:54:38 +1000
Message-ID: <20241220015441.317236-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

ssstateen is defined in RVA22 as:

"Supervisor-mode view of the state-enable extension. The supervisor-mode
(sstateen0-3) and hypervisor-mode (hstateen0-3) state-enable registers
must be provided."

Add ssstateen as a named feature that is available if we also have
smstateen.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20241113171755.978109-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d8771ca641..a1457ab4f4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -140,6 +140,7 @@ struct RISCVCPUConfig {
     /* Named features  */
     bool ext_svade;
     bool ext_zic64b;
+    bool ext_ssstateen;
 
     /*
      * Always 'true' booleans for named features
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 18f4d94b6e..d7b830d489 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1677,6 +1678,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
+    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 48a55ba1d8..cbf2cf1963 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -204,10 +204,15 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
       * All other named features are already enabled
       * in riscv_tcg_cpu_instance_init().
       */
-    if (feat_offset == CPU_CFG_OFFSET(ext_zic64b)) {
+    switch (feat_offset) {
+    case CPU_CFG_OFFSET(ext_zic64b):
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
+        break;
+    case CPU_CFG_OFFSET(ext_ssstateen):
+        cpu->cfg.ext_smstateen = true;
+        break;
     }
 }
 
@@ -343,6 +348,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
+
+    cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1


