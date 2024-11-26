Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47771D3B985
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFteX-0003ok-W1; Tue, 26 Nov 2024 06:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFteS-0003mu-L0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:22:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFteM-0002dm-Tg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:22:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434a8b94fb5so1170305e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620152; x=1733224952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym7MlPUFYz2GU5YCplhDtE7b6ovE3xgVe6aZRCcPdv4=;
 b=O269jXpeoMK9d1++iTv+YTvOFcSfjM9awFg3fi93MDx5LY5PIBYYL2fxJTNi/PeMWK
 x2kewtuNbVV/z1r6AvUz2mE8nnoIq27syZTxNoddQktPcmloj1pmUQjuFdR78DlCsOyN
 qjD3N0wCN4BXh/mWKHZYo19e3OsqHUC35LlXpXIteTjvVTBo06DaQHd1M2V3k3GJMbZo
 JsEeAtCeKrVL1ZmCAsz8mgrJqS+aHGbAgIzsytwNqskzatFWdf9oX6KUy5eSLVAYza0y
 S1xyhxT51OyYJTmSyUpSn/9iUDwkN5CYQT8mWDUn+4Rgf/edkkQqEIzdgoH4nq77KKN7
 FFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620152; x=1733224952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ym7MlPUFYz2GU5YCplhDtE7b6ovE3xgVe6aZRCcPdv4=;
 b=rKGiiqfEM2WqwRnq5WjlBvtohAPAWM8dUgR2lEtG3WITwOSow7w0Bj6yDYSKA+lbI+
 xP4EjUDEFnY1eZZY2tNrYMCsCKl0u87MQQBoKfSEI1E8JOQAzwJxBQKE4ZeDYG1w+1Cl
 j0r+pF+q/zn4PpY2tfnUSqznDjqHPk2n38GD+lNuKl7efSYzgUP//z/ZeMmXpXHlOKvj
 c0rejp9FM1zt/3ib8BCd9gYXJaDXfLDXknwiKpTDYSWymX9LqsbFR72bsdG/igUDeTxf
 GBYfOo3qWryr1BWSQa8Y/msn4DmpQeYTQu/Sh8uG6CAWCq5vjWkWx2H1zZwngwU2b4a+
 8J/w==
X-Gm-Message-State: AOJu0YzwLYZoh5n3X2KrlX5g8DVd7TkE58j9l9fAZLQmS7qiZ7lDUfvV
 njpQzeq3djOwFV2nokLUfqPwx0SlhFbKsiYuphTSLajoChy8Bon/ivE5Z6KJh6W5Lbn2A/r/PRf
 s
X-Gm-Gg: ASbGncvi2ZczQ4XJIWT6jjGCEmoaezyEXiUeOQvedoON+6SjPvwsooTdcLW1X97/R8h
 zZ/Bl4LVQOMEW+GSrjiRHLfOLFaZl4M/tR0NKbd9F4eT14nldejEwyJIIts/W1tZx6cnKk9c5RO
 3oqLqha1OTTv4K6ATRPrl6LgntkYmvt1vDQR4SyVNRv+h0x4A/dw71MsgS06kWCVDe1daNp7CUR
 xrYvBjM0wetYvjZhw0v6pb2YecuHAXhJLj8jAwZqtLcyUjA6o690L5CBeRWiqgfc/mgyNAt
X-Google-Smtp-Source: AGHT+IFBBmx/zRqWz+0+3nZ5bzn94HIXIH1xaptS/bJKBgN/Ji0e/N+lfNjKX8nxRbW8D6cFnG6cKw==
X-Received: by 2002:a7b:c85a:0:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-434a4eb786dmr23408865e9.16.1732620152605; 
 Tue, 26 Nov 2024 03:22:32 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb3134bsm12970699f8f.58.2024.11.26.03.22.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:22:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 03/13] hw/pci: Factor
 machine_refuses_bar_at_addr_0() helper out
Date: Tue, 26 Nov 2024 12:22:02 +0100
Message-ID: <20241126112212.64524-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since we are going to re-use access to the
MachineClass::pci_allow_0_address field, factor the
current code as a new machine_refuses_bar_at_addr_0()
helper. In pci_bar_address() invert 'allow_0_address'
logic as 'bar_at_addr_0_refused'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c3..e05f8a828bb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -520,6 +520,13 @@ bool pci_bus_bypass_iommu(PCIBus *bus)
     return host_bridge->bypass_iommu;
 }
 
+static bool machine_refuses_bar_at_addr_0(void)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return !mc->pci_allow_0_address;
+}
+
 static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
                                        MemoryRegion *mem, MemoryRegion *io,
                                        uint8_t devfn_min)
@@ -1472,8 +1479,7 @@ pcibus_t pci_bar_address(PCIDevice *d,
 {
     pcibus_t new_addr, last_addr;
     uint16_t cmd = pci_get_word(d->config + PCI_COMMAND);
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    bool allow_0_address = mc->pci_allow_0_address;
+    bool bar_at_addr_0_refused = machine_refuses_bar_at_addr_0();
 
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
         if (!(cmd & PCI_COMMAND_IO)) {
@@ -1485,7 +1491,7 @@ pcibus_t pci_bar_address(PCIDevice *d,
          * TODO: make priorities correct and remove this work around.
          */
         if (last_addr <= new_addr || last_addr >= UINT32_MAX ||
-            (!allow_0_address && new_addr == 0)) {
+            (bar_at_addr_0_refused && new_addr == 0)) {
             return PCI_BAR_UNMAPPED;
         }
         return new_addr;
@@ -1506,7 +1512,7 @@ pcibus_t pci_bar_address(PCIDevice *d,
        mappings, we handle specific values as invalid
        mappings. */
     if (last_addr <= new_addr || last_addr == PCI_BAR_UNMAPPED ||
-        (!allow_0_address && new_addr == 0)) {
+        (bar_at_addr_0_refused && new_addr == 0)) {
         return PCI_BAR_UNMAPPED;
     }
 
-- 
2.45.2


