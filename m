Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3052CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNHU-0008FV-QI; Fri, 24 Oct 2025 15:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNHQ-0008Dl-1n
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:16:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNHO-0007V0-B4
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:16:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so22112555e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333399; x=1761938199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDlsCHLjW8G2DhCTmRjvAvj5A32lGQeNER622BWchio=;
 b=TZxWXh6JJa86ctZBewkITm391ndMopoqfCe5p0zcmZ6nKco1PeSR3SMp9p8dHNb4pu
 TK1Kxh6gSall8qZnay9499fsdyuMwhzOoaAaaoAcAyI5HGhaj1wzh9/R+xUQqsMFKGt7
 Mohm7DQWNuBnKWopUsnxLiFHDaLoPi86yOPwW3kDJDC2S9C+AY0eII6FnQ5ze5mlnNNX
 +45xOeFdJ5rWoapY12AKL86aWsei6dstcljmTR92dbal6lZLeRhtydOvp94uDV7QE7SM
 LkaiNSe5ukOobp3aCq+FqIiy0GfHmhCvjkSKQSNoI+u/kvJpvilu28Pyx1oJpADELQcH
 OHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333399; x=1761938199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDlsCHLjW8G2DhCTmRjvAvj5A32lGQeNER622BWchio=;
 b=D+cjTKmnFbsbFF4UkeGccpAdxdDE+/jc2liu7xW7julZBOd3e+ghjp47UtgaHkb7ky
 /ue+nCu2C2HMCGt6u+xKM6K222qTWjXdYbHmYksqBCdyZsweK3gGcp6Dvt5rKl5npJc3
 UaH9X3RmLDRaFKaFLX33KyFdAh/iuh7VYnJ54cLLeGz+Y6kI+RTRn2smxc69e4+6h2BU
 H+uHZBonnMeAXNVNMaWLuT83+NspPj1PfHiM8Vu0eViG29HeLW6DRbiZBCF8ZNV2KcCc
 S8to8oAEssKuYPViwF2x/qaaf1aycQhVWPDTrb77ijQA2Lw6qfLNdpp6tPpGgCQtEofX
 Gr+A==
X-Gm-Message-State: AOJu0Yyg1sX2GDUtHT1WoDH624bFAKGHDc+2Le8y9or1jL+NqD/zxVvK
 JHD7HWTv6bIlVbpDKkEzJk1gZug6vdhrJE6eZ0l1oKydpqvL3JpAz7icygzhBZiR5g62EOwUWvZ
 LT1eNFn8=
X-Gm-Gg: ASbGncudyLg5AlyrWi/XBqtnFq9t9CWd58G/iHFF515wh4vu4RWWZUHpZXz/i9YQH5w
 MzumGIT6x5LyfFBRJeLod5TCg1SLb3Rhq4y9qhsY3bym44mHEI/Rj5ekYh3ISnplfoYxIzFT21y
 ilTPr8z9AU6kOUCYVliv0mse+khJ3RGvCbqTPU6bKHh3D39e9w+7mI8Y5qzBoyuPMmCu4DN5f6s
 wnF9GUc/VrtGfdhTy1Z0otkVdW8NfLSNScmetnj7n3jTtp32bk0/AP+FV5b+9q6vykt2ynu2uPN
 TxZgNnACOR3ifMJSIXJ+HNgSBDVoD07/bgV2O0WfYaze+ocYKyjWgyORHXmcD96V9rFw1+QB+Gm
 6rfVhQMY91sNChbpe1krm1CoSAYarf0Sz3fY86GXuXyXEC6qxA2fbJd558R+QXgW2hetQcIH+R5
 SF9d0oXSVpCl2wqfDnVL5cvP6mfxulB/wtt2WlNyxC5d6bvXim0WOfh85QvfTn
X-Google-Smtp-Source: AGHT+IG+U60Ir9bRtfjEJVzelu3OzmRk1cfg5abPsD4lECTtWtXQXdua34LmaMXSL0w4T+Zl7suArw==
X-Received: by 2002:a05:600c:3f0d:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-475d2430687mr30364255e9.15.1761333399299; 
 Fri, 24 Oct 2025 12:16:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf152absm125783415e9.9.2025.10.24.12.16.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:16:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 08/27] hw/pci-bridge/pci_expander_bridge: Use proper SysBus
 accessors
Date: Fri, 24 Oct 2025 21:03:55 +0200
Message-ID: <20251024190416.8803-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

SysBusDevice::mmio[] and SysBusDevice::pio[] are kind of internal.
Use the proper accessors.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-bridge/pci_expander_bridge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4d..2e84bbe1615 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -157,13 +157,13 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
     main_host_sbd = SYS_BUS_DEVICE(main_host);
 
-    if (main_host_sbd->num_mmio > 0) {
-        return g_strdup_printf(HWADDR_FMT_plx ",%x",
-                               main_host_sbd->mmio[0].addr, position + 1);
+    if (sysbus_has_mmio(main_host_sbd, 0)) {
+        MemoryRegion *mr = sysbus_mmio_get_region(main_host_sbd, 0);
+        return g_strdup_printf(HWADDR_FMT_plx ",%x", mr->addr, position + 1);
     }
-    if (main_host_sbd->num_pio > 0) {
-        return g_strdup_printf("i%04x,%x",
-                               main_host_sbd->pio[0], position + 1);
+    if (sysbus_has_pio(main_host_sbd, 0)) {
+        uint32_t addr = sysbus_pio_get_address(main_host_sbd, 0);
+        return g_strdup_printf("i%04x,%x", addr, position + 1);
     }
     return NULL;
 }
-- 
2.51.0


