Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1918C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfON-0003kR-Gq; Fri, 17 Jan 2025 00:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNH-0008PT-J8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNG-0006Ak-7Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:31 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2164b662090so31372465ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093508; x=1737698308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ha6R4w5o0eEsmWuIMDfoi06cN3XJ7oTSvRwcrmeSWXQ=;
 b=RomLDYkOlTYtZ3jfS8gp+V8Q0macCrt3vClBnhod35Y+piPG+ugECJ4TpZ82doBdny
 1P+Q6DKrG11ed9ASrPoyxr1O3iWpJq4BkcKRNHgIM72dClCguq4woc0c3tqp0eGZ82oC
 TyBtnOehqXPujJ3YR7A1531suSfN198lH0eDcUloles5etJpI66pQeONEbboqtIkLliT
 fYWPGDdcWW4thkJuhw8XIiYwo2/GvhPyua3PFeNNCSCv0u8iaYSkMUXruZoHKbLAJhbP
 wIqoUWGCFfIT/vS7E+hEFPUaFZEs6jmklBZmxyMJZvYC59Ar2ORJfx3c3Ox1hvz6/Js/
 tFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093508; x=1737698308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ha6R4w5o0eEsmWuIMDfoi06cN3XJ7oTSvRwcrmeSWXQ=;
 b=pVU8mCGRdNCCBfSFGfujNMIpj0nbg0Hg5NX7xaSGG2BPYqNjXe6dErnvz3XQXUFLRC
 IuVtsqPDSJetXStLpDPkl+nXpjvgDfv86oSgLHsCnPuSjW05JCVQ9Ol4P59HPbg1CzKs
 X2DWeO/Yq0X5OFfw0UUvaTMhKVysPcN/MhSgg0HCZPbbH6s8Pc+uvsOZ7bRMMOG3FQch
 PaL/4nX5ceyAd1gf6mXAW0ABGV6vxDzwpIAPD//AvGIdznI/RluLyd/i76QRlzXCUFTR
 Ru8GuUlCCFHLMlQafo619YyniBghrRJxsGMip0CK43HscEb43x51hGuWB1OWEK8qYm1/
 tGJA==
X-Gm-Message-State: AOJu0YwCkAZwdKcB876dCP9ptBANmHtQ/c37IZKPHnDyBjykVtFUQJEY
 NdwvswHsWOA8cBfwSMn3fnrovXit4VhnR6XEfZR7/WIrHesLXE0aVgeKoA==
X-Gm-Gg: ASbGncsDD5HgbbgNw7qBzH3fh0/Meu05hBN9Ffevl6O996HZac1CrrLrOuVAPzfZpoe
 aIVMIetTmn3upvdspP4C9/PhX0k5ioGaNGTbP5RFd8ZOggxI7MPbbTdXGcqvaDZk3sPQ4kJ7wdk
 GipQCMFsjsHOGlFJ/Y44eo1M+Pl5BCW+FWQvG5vB5tJJG5ZNgpRQS+M8LYWihtdrI2t+NYxIqUx
 C+Fld6zpIyKOIaRwfM9wChrP9dNi37nWMJbEhPCd8u925iENIdmiaDuxnGtRweN6zseix+YxTix
 Qx/ExiAf1TEdF04JC3thC/O+h5egv5uyltrAvCizn3NjelSzLxkdeEV4bJkL
X-Google-Smtp-Source: AGHT+IG/u29T5ev7zqMwiU7peSHrC0oicYlNzKIBb0brrAoKy69B53i0/nrYrUHHHy/Se4ciTRparw==
X-Received: by 2002:a17:902:d583:b0:215:4d90:4caf with SMTP id
 d9443c01a7336-21c353e700fmr26486545ad.14.1737093507707; 
 Thu, 16 Jan 2025 21:58:27 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/50] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Fri, 17 Jan 2025 15:55:45 +1000
Message-ID: <20250117055552.108376-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-6-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5540eb7f63..9e1ce0e1f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -205,6 +205,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1628,6 +1629,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.47.1


