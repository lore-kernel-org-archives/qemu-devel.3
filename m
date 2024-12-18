Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA7E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2er-0001Rn-Hn; Wed, 18 Dec 2024 17:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aa-0004Nm-Fl
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:21 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aV-0003Wh-BW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso1589715ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561133; x=1735165933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q91CPRzhK1oN/ujwAJK2FZ7kmB/x/zQicuDmdvSPzQY=;
 b=C+p6yZAzmhHWlf0cQZn3kZi0Xlt+zpRmzJud0behiJZGWkecD2KAvJfAvH6VfYxxRE
 wa4wFATTZB3oeZPYJ0EAdLA+bIWKbNv0DOThAbZ2yQEEBrzAReuQDGeqBqTLsM/7XIzk
 HxHqyhAMv+tLjzC7frjIsl9F2uC78HFglBz085+vY59rbz6jAHzeC9wXaFMYqJ36vuKl
 L/joLeRUUFlQX90+d2Sfzgx4pTKt5ZnGgl+1ZrQkDf1P/1j0GtNkjlxxVawSPCPnoN/x
 1C2rI1hybDz3cFCBTo3eDk4cYSL9E+RfYzaibEl7VA+di1LlXYibQlYtANd5Cd+J0y4E
 XKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561133; x=1735165933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q91CPRzhK1oN/ujwAJK2FZ7kmB/x/zQicuDmdvSPzQY=;
 b=uAut8wP3lUwVEmyTWkHduAVteTWxTaj/LBtLqt/WyXLhLd792AdBlbh0Ve05pzmffR
 SO2J5jcEMo8H88TQsdxo0LT1v7sA4AWfpTESe3gxbnr21jt3IXHHD9g2qLGXE6BUXQGG
 KrMDkXZg+m7HwPw2ZpEiqE/p59vo29PhDJNoCIBQF6s8Fh1fRyWj8UdrBaE96oVB+Hcs
 0Zt05LylZX4GuokPeDPSmrb3bXq8W210Zt+5deO1ngIgXd8RMxLIsUUorqoYXI8Sy9v7
 Baf/ay+nZqf/T5lkul+YdcGbNPlXC5rh+TR+UdhUi2RYJAuuylnYr5kohuQyxRHdf9/e
 pPyQ==
X-Gm-Message-State: AOJu0YwFquB9mDV0BqpYlYwpGDiIlqVufaKYSVDti4jRTfaN+Bw5nJAT
 732kul+YICtNDPheTGOZ4i5/OEZi+pPfHmVy02dk+xON/SjSOJMFji0c1RvK
X-Gm-Gg: ASbGncuOnMaP8MXos54EIm9L2H2dX2dVsYQMsJIjSDnvJZZIT2QiJknImtNq3qeZcIz
 BjJxwiJAc966a3d7ya7O25YmQ7SEco8j1eTCJuo97hJu9UsAHupVcDz0yphKE+N74YBfDklTpcO
 NcaDcbOs5+h+gqreLfOgZMiJC/W8m2SulzsMClRkK2p05hlgYZ+oUCa/FUUqc+Q5dj1tsqcBurl
 6ObWtR6vkOc+ELsWJ6d3+E3Ayna0y+8VT2yB17jdUKgmmw5dfL1dXNw+Xld5/1+AAtE61NgK4C2
 D42hILQn4OH7KtpVFGEMcsQv2fROb3czE4zPflKaYQv6jb0hNzO+0DbryrHXZmo=
X-Google-Smtp-Source: AGHT+IG0Bw5YIfR6pqUW2ICdNzY5crgDIeIUTpB94K+B5/+zYGQCblbPtJFwpHXluiC18iN2A09fHg==
X-Received: by 2002:a17:902:ce8b:b0:216:6f1a:1c81 with SMTP id
 d9443c01a7336-218d6fc3a38mr62278555ad.2.1734561132836; 
 Wed, 18 Dec 2024 14:32:12 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 38/39] target/riscv: add ssstateen
Date: Thu, 19 Dec 2024 08:30:08 +1000
Message-ID: <20241218223010.1931245-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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


