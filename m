Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D985EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfN7-0008Du-C9; Fri, 17 Jan 2025 00:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMR-0007Xp-N8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:43 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMQ-00065E-8h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:39 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso28750165ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093457; x=1737698257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gv7QOud/iCFu+oQa39ideRr0A1jcyLVYktCIAh/NPS8=;
 b=C2Nn2zIl49fRE2TV0cnjxqKUUBUPoUI7u9+kAMi69JiHFLJzr0v6WqRCQeJJ1Rg8w6
 aFQZKR187BRqRwSmj+hC2X8H8W8iVjsE7PCCdZbFMA/ku+1qgLRD2q2sz6iEChBwq5p9
 Z/XaEQb5yB9vuBjKlP04PNzD60U1KWWxvqcnFgojlrRW9HYjHaWYQeR4ZmignCla5jQN
 EMuL6jVVG2Xc3cx22tnDovL2uXfQINLHGe8zDlNdQI4geM2uPKo+izp9+9O1/J7/qyFv
 Mdg1a4OU5jFIG6ekVX0Ko/h7L/hkBsrs3GNxGsGjRc8beNrmu7Nv+WSCfCZKPfdC4jIE
 NKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093457; x=1737698257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gv7QOud/iCFu+oQa39ideRr0A1jcyLVYktCIAh/NPS8=;
 b=OwEVPIPZTK49W5Lcmwp+PvT1aNw+B2/zG0cQjPcstgRnOcGrXK13cJ83HTR4bhptwA
 /cIIOqw/I8U2JcIMmvbFB1KH2fZwJrsQBFCW1DjBqtGEqIrN3m9HUgDAZllN1YA0gEko
 NfcEumlCvEKAmTzr7vbw+BpmDph/tFYLqEBNR2PML0WmQJ/br5nk/+8wvkAh+Kp26Tw4
 ARvTUHILkvC+iZrvAM+wmLAb2uppLEHoUvbGP2S8Cb+LwLUWEtW0A0oYjsi0MAeI/fMK
 oUh+tI2Q6Wv2csqr44d4pDH31e7awCLQpmQPhh78ijlrBiM1UFYhCuoVPC8DWL6VdgDt
 WssQ==
X-Gm-Message-State: AOJu0Yz/XYTLw/Sh4pS6qKOqTrw88R4dG/YomDPMPlFRV4r9mi5TJhuo
 PQ1Ug4ZofZPvY3FtQjUqpDC0OGC0QDcmLoEydDxuX6tS7Kl7KWvr4+HVNw==
X-Gm-Gg: ASbGncucilFAxZAvXK11EcSa7KHgenigrazJsMl6ToEi4+00ua8BoGAtxaa3nKyCR8N
 vYAfbo9XEpzsJJwFuc90H92QWSGReLr/dVrw6szZHn2EvFDGbpYS9RElF4jhcNZ9UACNdyCrdDG
 6SkkNd/jK23bPb1yKzPxzhAKt+FIi2JLUezoJTo/ubiiXwA7IAhRWHZyg4TqIS0rdAiWcSVKprm
 zFOCJyWJCtydYqVA5joH1piKoq1sUX3Cf78UFsyL5WKMgm/+Xc1T8wR4vNieETcyttIKXmeMdPm
 q6JZrDay5yNPBbEntwWZJM2bMI/QFjPb75cFI/wNGaGCAmk27NZPUYkJDTLC
X-Google-Smtp-Source: AGHT+IHu9dLeRMfFkNSTuNlHsGjiXT/58DspfjFO5TgoDH8FbjLSh0fY81OT35rcdOujZXo6MYkpdA==
X-Received: by 2002:a17:902:ef11:b0:216:3dc5:1240 with SMTP id
 d9443c01a7336-21c355ef44bmr23028185ad.45.1737093456780; 
 Thu, 16 Jan 2025 21:57:36 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:36 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL 28/50] target/riscv: Add properties for Indirect CSR Access
 extension
Date: Fri, 17 Jan 2025 15:55:30 +1000
Message-ID: <20250117055552.108376-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for sxcsrind. Definitions of new registers and
implementations will come with future patches.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-1-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 target/riscv/cpu.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ee7c908710..4fe2144ec7 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -79,6 +79,8 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_smcsrind;
+    bool ext_sscsrind;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dace670e5e..4f5772ae5b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -201,6 +202,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-- 
2.47.1


