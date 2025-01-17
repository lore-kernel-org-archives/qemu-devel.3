Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87385C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfOI-0003GD-FL; Fri, 17 Jan 2025 00:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNT-0000Au-Hv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:44 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNS-0006CZ-2E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:43 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso30677065ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093520; x=1737698320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWw653vkYWaSQiPHw0JM72ZZo5IhRzVCItNVY8qhg1U=;
 b=erBmAKWJ49ylxYVW2WSfLoVHSOA8jBO/w8loLIrKZ0G9pyMJ3PGryzg5wElmfNMjIN
 E6BTJ0SPRBRgTG4lf9DxrK1shAT6dhUtkoUMYGgzVAbmUltw+qToVY6oM9ksxtzDQVBz
 /5tK1FW/U1UZU8V3ryeGGI5G2dvQswZaSwQYotq9T+1reFStvywgjox7msBDWBYUoBNe
 0Se8uygNiRcZC9XcCTUOLbcw0X1pvfzJSG9rycaoypABy1swXukDUuLhJud7ellMpXT/
 ViG/O0mCv7tbmaYjlaBuRTtvgXkRIqnrJIr14caxpyU42zIiZn5ljz5+4WLmHvVfS8qt
 6UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093520; x=1737698320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWw653vkYWaSQiPHw0JM72ZZo5IhRzVCItNVY8qhg1U=;
 b=iPa9VKNp7hmZgDDOfqhmLML2pTx9OJj4cJEHz/wRpPDCXyNjbh3qBuN5zOxyb0qgQC
 0IZ+mICaSnjvtdxgPDSq4H96vD9t7hZPHkkeUzB2z7jlyeVhof5OmCWONg6DXMYPcBzm
 e/9sgNR1YoreToLn/FR81Eum/4dxfzOrQO4NRauG+Cll0+xyX2lbxOF75Z6jeyMIbUvw
 euMrjocxu6KrqfytrpgMjrvz00khRGBOQeNnwqKlJtpAqDUwAu4t7B7eAXAs0Fw1J27E
 ETfnCVMsXF06zvnodnfNasHIPLH3jCuuQpSvtQziXnlWq4kbFSJHex9tlCql2z3oB5/P
 P7/w==
X-Gm-Message-State: AOJu0YyGtBiUyvMjO2VnU6qeNXoEAF9zq9fmk+wvcUshkIfGcby0pBXJ
 FVYS1Az+It4NFpYDyFcwvUtvt6HsvCJVxsiBHJlvDJ4GlyQTCi9Hq/TzvA==
X-Gm-Gg: ASbGncs6qBXpOrzdaY1UYYbFicmDRFgd6vMuWp5pnE95YVkocmh9MkobjQ8Q2G2bM9+
 jjVjpCLDoi1MkwsIUZvsGo8FWy5Brj4gpQFADxavmUuxX8ExGRqqfBpSWEBueiuJQNootS3lUgn
 s6muwyc/s0NKBmgLYkcXdfnfPuRy8T5zW1/5e9NQQ1/DpSJfB/3V/ZbcgrOFHMErFrPeMzek7jo
 zLx1AQ1HkZf/f7hNtdteCP7G1oxX6uqLrkd3NikbJYUMaRrQQ1j+Mqax+qRcj3bi9b7J30b5RFy
 R8gSk2gGYTq/knNDtWyI9uaVlIZMDNq7wGSVxROPQXjEQqo5zyhgThitI3Mz
X-Google-Smtp-Source: AGHT+IFaRe4ro9MVMoyEWxgGlDT+g1ZSOdBrhdnZCnBwyEd4uCNI6+n0aqbwBqApYmCkA4yQfO0isg==
X-Received: by 2002:a17:902:d2c5:b0:216:779a:d5f3 with SMTP id
 d9443c01a7336-21c353edbd7mr25264425ad.14.1737093519944; 
 Thu, 16 Jan 2025 21:58:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:39 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/50] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Fri, 17 Jan 2025 15:55:49 +1000
Message-ID: <20250117055552.108376-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Clément Léger <cleger@rivosinc.com>

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-10-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3ed11b0fd..bddf1ba75e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
-- 
2.47.1


