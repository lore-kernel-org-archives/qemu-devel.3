Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A14E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4W-00031a-AO; Mon, 16 Dec 2024 07:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4N-0002sp-9e; Mon, 16 Dec 2024 07:19:27 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4L-00009e-EW; Mon, 16 Dec 2024 07:19:26 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30036310158so35552561fa.0; 
 Mon, 16 Dec 2024 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351563; x=1734956363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHxxOwlnUxHuqwtnNL1F0EmUduhAuxOGlQ9xmeZ+TBc=;
 b=a3pZ3uziOIG/Z+obEG6Fz+38JcXqGB5csVi7xhVZG7x33TBplFPmAGUwmqrWUzeSPY
 XNSCiRDXwEvfbqVPLFDGJY8EFsqyEhJWeORvf+uZyS2zJr0ct4sBHHyw6P6X1gUadgKQ
 f98fLyUbU8ZgridH2DQCDZpmQ/4AFddNvY29iBuUOkVOSehrxzTh+PjzgeW2DBsr36DL
 uHFt1CnS5khgOw7CPGxnQRXqJxkeInsWFA1Cdi9YqXhK2TUzdMJJh7Be606BfbBw09NW
 PbpbEBMzVNh3EwEViKB2mvFKp1VddLfgLX0CwdLXWpzLKbjeX3x0uP76qBZoCmjRJm9p
 l+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351563; x=1734956363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHxxOwlnUxHuqwtnNL1F0EmUduhAuxOGlQ9xmeZ+TBc=;
 b=V1HahbSSlVUNBS/N/cvgd6MQ72AxEl0iWWAiOkHqZAYh6txWp0aTLJS6Hk9rQm/2BS
 W4BjWudDnXy+MR6iL4i509a0WYhmL+CowPMUgepyxTjZR+Biz92kVw3Q/bOhlKP6WChd
 mLAwQdzUiADX3D8P0fVcaH+0XhADefqTTz+8q8Bh/h2MaSpDRFMRiz31Y8/GlcnymdC+
 h5kXi/XoTh+scDc8hpEpL6pCfWtfw3flCXugRJg9kD4q4sLa5v1rpEx76tLnij1bZQNM
 TpgMGgvqSvG2/6stTOVp0Xfbv2iGkuYECjAEtHPnhM4b0Y6jVFpUtceP0Zl6ceS8aE5H
 2exg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD3rjwcgTu7ZiKm1z/e6kLNXVEWLh4g7YPcI0TsLocWHcEme4sdRh25VyPRQ3N+BIH3lvavMu0x9PygA==@nongnu.org,
 AJvYcCWvU8G4l0JYELwBxJ3b1uGV4TaWmJIAfsVvjBhbFxlO9lECsWkyGIuqDbh3te1Vskef2Wf108OqrBiX@nongnu.org
X-Gm-Message-State: AOJu0YwGulKHk0XL5aZffAqu4SwclDJ8oHtMwaWoZ6EjwjulWP2yeekm
 nUhFOgkM0G0ubViqxPGxCyYutDKeL53E0yAaNUdKxEbOVihNKWEi
X-Gm-Gg: ASbGncuaM///ic1MyztrCWfxnhNvZTM6Nw4pZbCyVIFzzVokBdtBLuWaRG6fCI3C0X8
 sw//WKc0gdDumQiz73YzyREksDxh7sYuMfTTm83TSSeyupIfqMi11yYAEzP1NAyI0NUf7hCeDXa
 +85ITnPNMc5iLgqN7lf+1MjpziioRToEJbuaTA8Vy5alp6MQGDpMbAnZMo7fDXTzirGfrAR6AmF
 53+hfOVy/lpPg7IrxQg/NLg53f1goxUtNPNyNTdQvoc7eljE76S4tov8tn/KA==
X-Google-Smtp-Source: AGHT+IGNa4Bch8sSN2kS6cIAu2ZiIHgwR8B6fcIXQe644DgO1yTSYA7zVhsX+6XjOQwihT/+7hCumQ==
X-Received: by 2002:a05:6512:39cc:b0:53e:df2b:df25 with SMTP id
 2adb3069b0e04-5409054e5c9mr4559392e87.16.1734351563155; 
 Mon, 16 Dec 2024 04:19:23 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:22 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Mon, 16 Dec 2024 15:19:07 +0300
Message-Id: <20241216121907.660504-8-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216121907.660504-1-baturo.alexey@gmail.com>
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8dea26e214..05184b9a6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1492,9 +1495,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
+    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
+    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.39.5


