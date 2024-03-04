Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBD8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8fn-0003In-FG; Mon, 04 Mar 2024 08:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rh8fk-0003F7-3i
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:48:04 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rh8fW-0001ZR-SS
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:48:03 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e56787e691so3701509b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709560067; x=1710164867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHYc9D9CqEdlOc1mocVOUDC5Cbsy1iwrgcMBaLL0cac=;
 b=awnGAFPpfeWq/0tuSoECmGSpH1PF7ezjePJ5BdeQuzhSIn7i23y2qstVevu+AFRXe9
 C+8R20FaHW92uFB99qxoyHCBTdtXglZEXp3Sh0Rqm81GSMyQu946DY3RD312OFBkiXYZ
 uHwfbep/XwLUEE0aLjDAdCmlrq+UEWCrsjvgoDZSZTQ9FLZtBBoteClboFPJNDu695ET
 aXz4LXson8NfhYKgoDT1T27tjG2gX1vrC2iYIk1chNBesYPXGQ0dGI4Eg0TlJAdrAwOG
 Gqzq/PuPZENaPhQ+jC6dzFTSOliITV48VzAgWyGGuXaGDKRC+kAjZu68bsO9Ua8lKsrW
 g1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709560067; x=1710164867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHYc9D9CqEdlOc1mocVOUDC5Cbsy1iwrgcMBaLL0cac=;
 b=Dr9eKVqoBjLj0TWvfw7HA0nYOjCfmHVpz8NuS/XG8TFQvjh9pEmBhFfQtGht17R4Xi
 7f0OE1ucIOKsNupZSj8bJ8T4+abvvU8VCNNWr5bM3ECEfbvOBgnqOslfYWvhBvG8nHTV
 nLqDKksD55TA3TIHBRguhdb1InDkm7e242MmeMdByEm3Vhm9JdD+DhwbcCDBoBO3OHyG
 jMjpfMeOx2WFcyuWtywFNgMUmAEKA9CEkOfjcd8leSRX2O7+odQLDkJYRGZznCxzq9vU
 d9Ci/bfI0Ad4UNSL4NiXmHrMNIzdBe1GFMfaEWyuEGOl90gMkuROmqeQakwHcie7SLhB
 k4ew==
X-Gm-Message-State: AOJu0YwWArGF7XtI/Ocxy3cJDcXniBWvnmYxDuAXkDzn3gA3REHffj14
 vT+Ak48Gzc9ybBfAg7pYGjQ72TJitXFes0JM+101HIjPco45PFD4tO68Xfna0sDRcmrZWGW8QEt
 Y
X-Google-Smtp-Source: AGHT+IEv9lUlPZxqUiM5pDJSJ2em7B5p5dbyeSe7n64CwhGlDBsdTit1d/YQC26i9pzvSnkwwMzhTg==
X-Received: by 2002:a05:6a20:2d0e:b0:1a0:f7d0:e680 with SMTP id
 g14-20020a056a202d0e00b001a0f7d0e680mr15543044pzl.5.1709560067556; 
 Mon, 04 Mar 2024 05:47:47 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 23-20020a630d57000000b005dc87f5dfcfsm7285335pgn.78.2024.03.04.05.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:47:47 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] target/riscv/kvm: update KVM exts to Linux 6.8
Date: Mon,  4 Mar 2024 10:47:32 -0300
Message-ID: <20240304134732.386590-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304134732.386590-1-dbarboza@ventanamicro.com>
References: <20240304134732.386590-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

The last KVM extensions added were back in 6.6. Sync them to Linux 6.8.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 422e4f121c..c7afdb1e81 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -275,13 +275,42 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
+    KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
     KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
     KVM_EXT_CFG("zifencei", ext_zifencei, KVM_RISCV_ISA_EXT_ZIFENCEI),
+    KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
+    KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
+    KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
     KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
+    KVM_EXT_CFG("zbc", ext_zbc, KVM_RISCV_ISA_EXT_ZBC),
+    KVM_EXT_CFG("zbkb", ext_zbkb, KVM_RISCV_ISA_EXT_ZBKB),
+    KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
+    KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
     KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
+    KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
+    KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
+    KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
+    KVM_EXT_CFG("zkr", ext_zkr, KVM_RISCV_ISA_EXT_ZKR),
+    KVM_EXT_CFG("zksed", ext_zksed, KVM_RISCV_ISA_EXT_ZKSED),
+    KVM_EXT_CFG("zksh", ext_zksh, KVM_RISCV_ISA_EXT_ZKSH),
+    KVM_EXT_CFG("zkt", ext_zkt, KVM_RISCV_ISA_EXT_ZKT),
+    KVM_EXT_CFG("zvbb", ext_zvbb, KVM_RISCV_ISA_EXT_ZVBB),
+    KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
+    KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
+    KVM_EXT_CFG("zvfhmin", ext_zvfhmin, KVM_RISCV_ISA_EXT_ZVFHMIN),
+    KVM_EXT_CFG("zvkb", ext_zvkb, KVM_RISCV_ISA_EXT_ZVKB),
+    KVM_EXT_CFG("zvkg", ext_zvkg, KVM_RISCV_ISA_EXT_ZVKG),
+    KVM_EXT_CFG("zvkned", ext_zvkned, KVM_RISCV_ISA_EXT_ZVKNED),
+    KVM_EXT_CFG("zvknha", ext_zvknha, KVM_RISCV_ISA_EXT_ZVKNHA),
+    KVM_EXT_CFG("zvknhb", ext_zvknhb, KVM_RISCV_ISA_EXT_ZVKNHB),
+    KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
+    KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
+    KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
+    KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
-- 
2.43.2


