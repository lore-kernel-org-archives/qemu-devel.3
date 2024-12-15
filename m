Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC1BE77187
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0d-0005GJ-5W; Sun, 15 Dec 2024 14:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzu-0002KF-84
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:46 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzs-0001Vm-Et
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:45 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e15d9629bso679077a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289783; x=1734894583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LgtSkX9l1LaUxdbqZiUu1SCXP9yPXTGRSCaa4j0zPE=;
 b=W5W5UF1MuCs+DcQdnxxDW5R4m8ZqJ/duYNqah1WwgzbYwQCnzur1qqwx0c2xcbUL6T
 SiA0bbIvthOo7iAaHcyd8SehP11QJzvahe/2x9Z94Hd/EH06Vve281ZgwKJL9Le9d2pD
 fxgnBRFmeJ9RJ8Up6VmJm6cx4id86a1HZoOuBWOkwBbHoR0Y6tsk22TfFQtZqy2HlBBr
 GIC7TNFpD+qlMpo36BKoOT/WaRBp8ATsu0/Mm0O6tMS/0XVTahscfPvDYCUr1IUao8J6
 3e1UjtM17t/oZouiiTGJOaYxs+i8lBa4PCuhy2iwXeg20YMqjnjG+MQ06IObIaQxQzql
 gmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289783; x=1734894583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LgtSkX9l1LaUxdbqZiUu1SCXP9yPXTGRSCaa4j0zPE=;
 b=Qs6yV4cQ41jI9cPvsdwLE+nJUufu3oeg//35MCT8CLVCu3fA+TbluSusHujGSehamv
 udWK4C6TaV2XZLCIl6mTZZ79d4xn9RcVDHt4mCwhdCwCIy9cQoR3rTAUZnEwalez/RaN
 8+P6TdVAtxHdq3Fhc5kvR5VNsa1xCiGMSm2Zpx07Zwaw4zAA04SXJkryVF2vk2H2BCUn
 vdM4dtiIRPnGX/rT1j6wnSKv7s4ZXZE9kNBSKjab9AmE2fnLStDN40P417yCfJT4TL0T
 0MwcvAkJIdUOHSqoz0t1f/myuLibcO/sdBqXSLnNj7LkHvE3Xasp9sFDlLIv+UMt7bA3
 KXVw==
X-Gm-Message-State: AOJu0YzvY5P9hym3+cge3te5axrRwCsl+yfon+Y2zGDQRGKngeKZt4Jq
 jIle7VwUcKBMnuwJgbY3OFL7DY9VfwlmwYlvx0aXrBxsx6qCqgg58akcwtf2HQMqlMbOYXl6Iph
 AJZBcLRdq
X-Gm-Gg: ASbGnct4LYtZuyzPSojmF97uGQcFtAvoJGYBcOGvLql//AhBJA1R+jPFfgye6Rrl9W+
 t7cwUNT9hXtUa1ESVwLLvSDMuhqZ8psTL+/CJLv3ylEN3Yc5OM4T9QW0ReZljoFsaKDODKw0pj8
 yWEfZDMuVJGb0158qoxwf8XPoJ9MXhiu+9U3wFxYX/VLxgRsmJ0lBkbyc2SJS1gEFQIghEk+vOu
 yyFS/U2aJ1mPmNQfDMXeTjCBKM+18QXC9jwaHm/WMNWS+yknnJIbisHl3rbES/BOC0qgA8dE6i7
 bO6EcRvYhRutdadD2uDhCeJzaFCzwK6EkOR7NUzrxOs=
X-Google-Smtp-Source: AGHT+IGftcpsrxWPpj2iqDoL5KF93ifniCcCkdYiTZxKu193LLSq5D1T1tp1ecgcJGHggWf6OYz5tg==
X-Received: by 2002:a05:6830:3496:b0:71d:f3be:438f with SMTP id
 46e09a7af769-71e3b852d73mr5947265a34.7.1734289783369; 
 Sun, 15 Dec 2024 11:09:43 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/67] hw/riscv: Constify all Property
Date: Sun, 15 Dec 2024 13:05:15 -0600
Message-ID: <20241215190533.3222854-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/riscv/opentitan.c       | 2 +-
 hw/riscv/riscv-iommu-pci.c | 2 +-
 hw/riscv/riscv-iommu.c     | 2 +-
 hw/riscv/riscv_hart.c      | 2 +-
 hw/riscv/sifive_u.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index e2830e9dc2..8ce85ea9f7 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -306,7 +306,7 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_DEV_IBEX_CFG].base, memmap[IBEX_DEV_IBEX_CFG].size);
 }
 
-static Property lowrisc_ibex_soc_props[] = {
+static const Property lowrisc_ibex_soc_props[] = {
     DEFINE_PROP_UINT32("resetvec", LowRISCIbexSoCState, resetvec, 0x20000400),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index a42242532d..a695314bbe 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -157,7 +157,7 @@ static void riscv_iommu_pci_init(Object *obj)
     iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
 }
 
-static Property riscv_iommu_pci_properties[] = {
+static const Property riscv_iommu_pci_properties[] = {
     DEFINE_PROP_UINT16("vendor-id", RISCVIOMMUStatePci, vendor_id,
                        PCI_VENDOR_ID_REDHAT),
     DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index bbc95425b3..07fed36986 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2235,7 +2235,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
     g_hash_table_unref(s->ctx_cache);
 }
 
-static Property riscv_iommu_properties[] = {
+static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 613ea2aaa0..0df454772f 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -27,7 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
 
-static Property riscv_harts_props[] = {
+static const Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
     DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c5e74126b1..124ffd4842 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -936,7 +936,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_QSPI2_IRQ));
 }
 
-static Property sifive_u_soc_props[] = {
+static const Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
     DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


