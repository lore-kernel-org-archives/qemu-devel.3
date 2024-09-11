Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A74EE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMFE-000512-D6; Wed, 11 Sep 2024 08:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFB-0004ky-0A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:45 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMF9-00079X-9r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:44 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so6074774e87.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056881; x=1726661681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5xvJFVBKMvbpa6Bm2hjf4HSkH6PCdIPkm949TYXsgc=;
 b=WLUN4V16Qd4ViDhOWGHZ6l92XH1kvxbSkfLple7g/EDomlwl2ZmALh1bFDTvThLwgE
 JrDd9vPZfLTbgYZj0Em1CfWOxyKoeHwGzX4BEEQ87Et69GITUNaEMWtqYJbQGMBxzZT4
 ucGIVVtsCCTaXAQdrm9b1ODB4Wuk6kxfg/tRmN61RQy19LxTLQAI5pxc2NYPbys3lIHR
 OSvHiG45aP76a8ug/V1HG0oAGl3eCuQzDLJ65VvlS4OvRpHl4C6C3S+wU1quL2My1clk
 BHb7cCG7ccUkgVeOucmeJJkkWBdocCYwCbeIsBVVNDHOK0kEOVAn7rgm/c6YngaECzwv
 Fdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056881; x=1726661681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5xvJFVBKMvbpa6Bm2hjf4HSkH6PCdIPkm949TYXsgc=;
 b=bQegbZ2279hfLAD99kVogQM82CoOI/0I0xCauNzF9/KH+XRN0MRha0hKdP8SteHQRw
 /0FA7PeYzebjNnBKQivIhNOgqv6xO1MxycD/zF21vxQjsFovJK5SqbSJA5QMm/TfIDKB
 1wJIiH8mVmYmixw/1ljSESBUmZKx32xh2bl7qC/aMvt3hKH8HxG3SvvQRRYfpcAjrxde
 dh/jMgf1X0BcWzzWpOBrsi2Op29i4vI/xBI6LCvskLGvkMknkvNy3nOJYUUv8i9aQZ/2
 mPDRaBvVSvSOWlPT2CBG6zEF8PrRutck5y6o0uzBah9Qo0O3u7IazEkIDSGsnucyIzaF
 5znQ==
X-Gm-Message-State: AOJu0YwPZ8dWtQVUg0iKid8+Qc9LKWSf1QtotnJDLj+QDklyxtosAMt/
 VurEwK9+zpg3xjaM27an70GeGqIBULYU0o/4IC3RNqf5vmzNMOHudIQPbRj7GcqNcf6a4vdQp+O
 u
X-Google-Smtp-Source: AGHT+IHkpOfAS8u5OKPiEwoGL9JPx1etr54IbWhS+ZkiktgkVMP/D1KeIv4b31EoSyMVA86RU0PKSQ==
X-Received: by 2002:a05:6512:3989:b0:52c:d6a1:5734 with SMTP id
 2adb3069b0e04-536587b2bf7mr11723296e87.14.1726056880912; 
 Wed, 11 Sep 2024 05:14:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d657fesm610095966b.221.2024.09.11.05.14.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:14:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PULL 02/56] hw/pci-host/designware: Add 'host_mem' variable for
 clarity
Date: Wed, 11 Sep 2024 14:13:27 +0200
Message-ID: <20240911121422.52585-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

designware_pcie_root_realize() uses get_system_memory()
as the "host side memory region", as opposed to the "PCI
side" one. Introduce the 'host_mem' variable for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20231012121857.31873-4-philmd@linaro.org>
---
 hw/pci-host/designware.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c8ec5e8ba9..5d0f2ad703 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -395,6 +395,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
+    MemoryRegion *host_mem = get_system_memory();
     MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
     DesignwarePCIEViewport *viewport;
@@ -435,7 +436,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         source      = &host->pci.address_space_root;
-        destination = get_system_memory();
+        destination = host_mem;
         direction   = "Inbound";
 
         /*
@@ -460,7 +461,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
         destination = &host->pci.memory;
         direction   = "Outbound";
-        source      = get_system_memory();
+        source      = host_mem;
 
         /*
          * Configure MemoryRegion implementing CPU -> PCI memory
-- 
2.45.2


