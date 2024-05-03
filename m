Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B2FC10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sFi-0004VG-Nw; Fri, 03 May 2024 08:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2sFg-0004UR-87
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:43:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s2sFe-0004FR-Hf
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:43:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e5c7d087e1so78400805ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714740176; x=1715344976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qlq6VIfdJwHqA6caJ5U7ZheAGyyg3EvLsPCnl6bh4q0=;
 b=SdUd7pf/tjMD+c8LiO0apipjRqoadvbF+yP9T8KA03LmLZiK+n0IZ8dLQhA5YWgbpJ
 84/2wrxtQjsLW8QXWLX8UtXI5x1qUrYiOp0DX5vC+oOtyHYxrov2SWIXZXSLx7ofg6EL
 vzSlk6zbH0OKVgzenLwoiocS1OB55MQGHnCUMS0paeftZwInf0UyGn1F9EIArwFLpNfq
 e7Xux8bjzoD3tO+OIX44WngVakmttw16reY37E9brSG6KJwv6SWYPSvfhiVfKyDIYFUy
 ou8PoxE9Joz1v/plk76tHeZWwEZgkFYzO5t+Wtx6sLxJ6//A8h/pceBiN6B3MOOLGjA4
 lPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740176; x=1715344976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qlq6VIfdJwHqA6caJ5U7ZheAGyyg3EvLsPCnl6bh4q0=;
 b=rgevhPbkMYpkIGKHiFkUBr+5Dkr5PVtG+MljvkUAOcj0cv+tQd27xh1s607Dm+Uuvh
 8lVR53NmHZG8N+f5dTTh5+oebdU9UXEXoayv4RT4tU3fm28ccvBTwsm+vC4KOUBpSdVt
 gN70kQco1D+Exit3SUAZF/7w0gDmehj2SRQSt95XYsNlTkp80o+JyGlv7DjtYUkihDR2
 vgdEPiCZnqKFozqNnsj9Ipi77E+1Ay9L4C2DCRX10mKPnEGvUT48zUjRpF0i3C5PN5R7
 ogaU8Q/IeczrvP6TJyIYJT3OwsGVZSO3xcCSrOY7ydBn5OOZAEjaoc9DvQfFaCuKQOoQ
 NkLA==
X-Gm-Message-State: AOJu0Yz2dR5R1jbL3wJRI4ElEpO2GYwQjax5G1eaVlorDAOwFyyF1fw2
 e3QBnreLmbvgGqeMO4zGtSpbMzNWdWvd1Y0ElHl9mGHvXztPE+SFXd6HV9gy8ZWw4jfSSF+lwKC
 p
X-Google-Smtp-Source: AGHT+IG1gM9agUJ/dMjKSSzwJ/2JXinRdi05iPmfbctwguryaSSRIQjYW1RhD46nd4+5RcDajyeBjQ==
X-Received: by 2002:a17:902:da90:b0:1eb:5c0f:6e78 with SMTP id
 j16-20020a170902da9000b001eb5c0f6e78mr2922553plx.11.1714740175702; 
 Fri, 03 May 2024 05:42:55 -0700 (PDT)
Received: from grind.. ([187.11.154.208]) by smtp.gmail.com with ESMTPSA id
 f7-20020a170902684700b001e3cee88212sm3192998pln.230.2024.05.03.05.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 05:42:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, kraxel@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 1/1] pci-ids.rst: add Red Hat pci-id for generic IOMMU
 device
Date: Fri,  3 May 2024 09:42:44 -0300
Message-ID: <20240503124244.8804-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124244.8804-1-dbarboza@ventanamicro.com>
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

Reserve an id to be used by the RISC-V IOMMU PCI device.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index c0a3dec2e7..a89a9d0939 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -94,6 +94,8 @@ PCI devices (other than virtio):
   PCI ACPI ERST device (``-device acpi-erst``)
 1b36:0013
   PCI UFS device (``-device ufs``)
+1b36:0014
+  PCI RISC-V IOMMU device
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d8..462aed1503 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -115,6 +115,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
+#define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.44.0


