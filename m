Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5E7D58D4B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZjT-00026g-Vx; Mon, 25 Nov 2024 09:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjS-00025Q-Bp
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjJ-0006YG-FD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:26 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3823eb7ba72so3038220f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543579; x=1733148379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzQt7LYQ0+9fV8zZopMVzvqsJnnAOoFEcI7W3eeHOtg=;
 b=bug7QNopQ/aUzl6OsovFq2Z4orsEwFxEisewcRiZHc6IRI5VgBt8zAPYMk9EI5X3XM
 3iZ3pdlNdFvst8PmysalErnlvBtDo49AtI2hna9sDwkurup1o1HbvnbDH+VAyqJMSgAS
 wvQHfQpFkbicOgsjyaq+NQUAiXIstUnE5czgTsVDorkrNe2GGGylkwf833Ylj7KzPCn4
 FJeLXRjE/kZdBWAJD1ORwZ9LtLCnXeS8a8U2k3gvNBR13pu6EUJWn3jIg5t4uVejmvyk
 sCIYIQOknZvW805BlpRVF41sWjlwZMurqKbEIbzRDmd1v7MIFp7WzGsOw0+oGPRLWbKR
 UgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543579; x=1733148379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzQt7LYQ0+9fV8zZopMVzvqsJnnAOoFEcI7W3eeHOtg=;
 b=SF6c0nMFjQdwY+7zIe7ELBWB/WFczH2UG76ILeyHRlVU5ZrHvlA6YJrrm2ND2HlzdQ
 JtcdgeBFqXBwe9sBBVs3/x2TUtYPZY/7oR/9lOkNGFI4qyxAzXulGZvy1MTwAnpSUbzs
 z7QEwluqXmiCX3wc88TanUKoWSqLPJ6eQhZiZookR+W7dZDE8kq5LKxGSCJPQTvLlBNp
 +EUloECXPYKTZrYsGaDkA0PFJGGOl9RbOOKIUMnuQqRBp253v2Co9zeCYyPnaZdNQINf
 GHxsYMkW8GEV/j1lwE1dgRZRgg1qoUxai9t37viOVRio+Kh6d/474Lw/dDRBU0rMupZg
 hPuQ==
X-Gm-Message-State: AOJu0Yy07OzF2/djxyV9k6AC7HQwzW7TfmV5KlFiAhUOgEeleJHCZ+xL
 4yA9P5lkAWwyPH2WD4CZFoHDEI1PmGwPPwsnMkE86xeSSnERXZ7ZDMoSb79Rv/uAAWR9EVaKjxI
 X
X-Gm-Gg: ASbGncuOIduQ29X4OJcaGZqMn8AsZvypY2WKduyv2gTIymlcO8zS0IVmMDi4kt4Krie
 OJXieb8/jTWoKDJYMKHLLNieNP8Vv7isYRCUIR0/Y3Am30O4pvtI9EBMb/7uIhaUniGk0xJrNiz
 OZgRjfaAy4vLD1ZRLU/5XPCWEFdY0SwYlTdMAPUdPZQEjuvrC46oPYEAu+OCFA2zMsuiAXp/Kj5
 18awXs8FHHEuNYYS/xR9A8PmiGgJ8sAdknIl7aKF93tDBEVAemkUoqW0SWnvsXsXurAs/ph
X-Google-Smtp-Source: AGHT+IGwMIERKtvbCLVa/jlaw2xLM/e2yGIBWKEmlWh9JSu/Oqk+1Tp7JdQF1RrrmMBxC9Dnx1p7qA==
X-Received: by 2002:a05:6000:2102:b0:382:3419:46e6 with SMTP id
 ffacd0b85a97d-38260be1efcmr8856441f8f.52.1732543568479; 
 Mon, 25 Nov 2024 06:06:08 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedf40sm10338059f8f.98.2024.11.25.06.06.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:06:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 1/8] hw/pci/pci_bus: Introduce
 PCIBusFlags::PCI_BUS_IO_ADDR0_ALLOWED
Date: Mon, 25 Nov 2024 15:05:28 +0100
Message-ID: <20241125140535.4526-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
References: <20241125140535.4526-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Some machines need PCI buses to allow access at BAR0.
Introduce the PCI_BUS_IO_ADDR0_ALLOWED flag and the
pci_bus_allows_io_addr0_access() helper, so machines
can set this flag during creation, similarly to how
they do with the PCI_BUS_EXTENDED_CONFIG_SPACE flag.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_bus.h | 6 ++++++
 hw/pci/pci.c             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 2261312546..5c8b0d2887 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -26,6 +26,7 @@ enum PCIBusFlags {
     PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
     /* This is a CXL Type BUS */
     PCI_BUS_CXL                                             = 0x0004,
+    PCI_BUS_IO_ADDR0_ALLOWED                                = 0x0008,
 };
 
 #define PCI_NO_PASID UINT32_MAX
@@ -72,4 +73,9 @@ static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
     return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
 }
 
+static inline bool pci_bus_allows_io_addr0_access(PCIBus *bus)
+{
+    return !!(bus->flags & PCI_BUS_IO_ADDR0_ALLOWED);
+}
+
 #endif /* QEMU_PCI_BUS_H */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c..de3f93646f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1475,6 +1475,7 @@ pcibus_t pci_bar_address(PCIDevice *d,
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     bool allow_0_address = mc->pci_allow_0_address;
 
+    allow_0_address |= pci_bus_allows_io_addr0_access(pci_get_bus(d));
     if (type & PCI_BASE_ADDRESS_SPACE_IO) {
         if (!(cmd & PCI_COMMAND_IO)) {
             return PCI_BAR_UNMAPPED;
-- 
2.45.2


