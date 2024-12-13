Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CBAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9U-0002sq-5V; Fri, 13 Dec 2024 14:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7V-0007dZ-Io
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:39 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7R-0007cl-Rt
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:36 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb9a0a2089so985252b6e.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117268; x=1734722068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOHSZv4UJCEktEuRNTiGAa+gSN3tW2NIQ00CdmYCkmw=;
 b=Fmf3PZcI2xSvN83oYFjbvpmypyvoDmA2OIBy893GQLEeRXd2zTtQ+kOkPeW+gWNZaz
 wA79Yg2XvXxQ7iYKB+hWvwtv7Q/wkNcomgo7eAF8Mj261Cmhptip4MY8qpC0YtwYN101
 Ibx4rm83yOQM9hms6l/PV2qxfVAN1tl/MXL81ddrRO1hjECtrCG6lC6fiBZJrP1pG9uk
 qdRb+JbUmVRH2ZH1kwXrDeSA+05hvgkVkxBLMGJUV61xGAGA+hp7kAF0CdFsxToLM0xB
 xyxQZyiccLmnFqY7dLOCqLOAElohkxbcEWTaeAMpiIKTT03ML9QO3KB+H8BIdJDUV063
 qkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117268; x=1734722068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOHSZv4UJCEktEuRNTiGAa+gSN3tW2NIQ00CdmYCkmw=;
 b=c42ZbwBxVX5fyvpWlAFLMIeMRHVwY4LUKDJXRoC8RaOmiKtr8AVPpXmzreMZZXNQ/D
 uP86fG74RTOsQ8ESTIUVbGr7HIaMv258NCe+z/E8ve8yrnYButrSnOErd4unhAk6TKzl
 N5sBVmSC6MFLbZFrAfVtDlxX9zxD4otyLsszOmv9BiOqgbEZp03rw8Gir/8gYKLhY6+o
 HEbMLJU9rMKlI71lzv+esYsVvA1BCETVNsewa7wAxVrOlQ/Rx0cjkzIlCCPoIQvev8wq
 N1351z+u+/KfuhyOqVJ5Okelgisp4EWBmbtsxMXi8fKMGo4QYyc2HZtR9Pu1O+8HCtNP
 wPTQ==
X-Gm-Message-State: AOJu0Yxh5TaP9YxAh9ThJsWeehnvFqysrrO0ubXUYCNQ9I3GaILG85as
 pTCPc9ciK+1GlLjsnZdLQXvO5vdUsMKhMlGE5TnTe7n89zatIkdsBf3e7wUFY4JRmjCThkpz6FB
 CQw2PIV3T
X-Gm-Gg: ASbGncuL7tlhFeqNSXkJTuo7MUM9SJFPh0NBYc2zcxjVSyWo0ejlWYZGJUQIjnv/7K2
 gaNk6yJrzN3hmKuJfC06SM95F17H+Qy0G2ioyp+45gPnqUssq+gLew4Al/K+4/pbjrQD0atTWxc
 r37wgvDQ/iMN9Nx4i0KIAbiKHDSg2r/IvOwVPHvH00LqNGK2BzbtiZ7dT7XWh49aPlLcFdK2Uix
 +TXizlNhaoIDK9pW3PXR9pYTbQNyoYIGPaoDojdYHptghDzhJJYHnEtrS+Jdr4S
X-Google-Smtp-Source: AGHT+IGDv+I2UhiFDy1K8kqQKhzztTTmffHYFJbe7CdHJpPZxObJ0/0BL74oQ8deflij1/ZIteAxpg==
X-Received: by 2002:a05:6808:2191:b0:3e5:ef2d:f53b with SMTP id
 5614622812f47-3eba6868153mr2325253b6e.11.1734117268658; 
 Fri, 13 Dec 2024 11:14:28 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 58/71] hw/sparc64: Constify all Property
Date: Fri, 13 Dec 2024 13:07:32 -0600
Message-ID: <20241213190750.2513964-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc64/sun4u.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 541c7f74fa..050cb1d1cd 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -374,7 +374,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
 }
 
-static Property ebus_properties[] = {
+static const Property ebus_properties[] = {
     DEFINE_PROP_UINT64("console-serial-base", EbusState,
                        console_serial_base, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -471,7 +471,7 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
+static const Property prom_properties[] = {
     {/* end of property list */},
 };
 
@@ -532,7 +532,7 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
     sysbus_mmio_map(s, 0, addr);
 }
 
-static Property ram_properties[] = {
+static const Property ram_properties[] = {
     DEFINE_PROP_UINT64("size", RamDevice, size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


