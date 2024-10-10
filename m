Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A6FCFC5F9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyS2-00061s-Q3; Thu, 10 Oct 2024 15:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS0-00060t-Nv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyRz-0004id-79
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df04d3cd1so1137927b3a.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587029; x=1729191829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufMG5AryEKYzOO3Km5eLPU0tnyg9cuTgKk08ESQiSrk=;
 b=dbcDyVhy51ognIYL1+mpRXFe54BAEni2A9776QGpItlXPnuCSxy7qvwxLZiW0nh7Ab
 1I/23RlsgHIQTIwrMEyiiFXF6mJ4oWUNNpocIS/4BS17/YJZ4Arml7TaBAifkL8pbsCP
 D8kFYbkxTu4VXDTS93TKNho1atG8iS2akTygdbB6Vqb/3nQL0OC+1nOFd94Wo1Tq3ex+
 T05TFzhEgSVRp7Hnm585lTfGaILbNPFJnhHO+eitOpxbAmQEKlF6ygqPb+8NxpFEqxJe
 RUaMZZTrVv56xWSZ612PWlT7qgVnM/Hv+p2F5FOxicCH6d9fMoY2v0FF4RWTJej3JXI2
 wz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587029; x=1729191829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufMG5AryEKYzOO3Km5eLPU0tnyg9cuTgKk08ESQiSrk=;
 b=Q+yyKcM+kDdHfwdeEk4bJcC6WEr059iVqDAfbZWqWpfSxmlmpImpCHq8pFA0HP9wMN
 NAcgAgDwf360g5Cwssucblpb+BJ1fU9whz9pPU42JqCdBtL4sMmnEVzDNoxy+Dm7n9y9
 SpwKwGWxbUwb+MffdAovoJhKwM7KdNmtrIaUIsp/6dLBTuz7NZoGQEow7MzbqG8m1MCQ
 Im35C1G823r435n0F7zolTtJEdam1d/vZAHVJfmFBMeakHX0+tOan79VGYFoX6WHtDIy
 5tMCs6CKPbnuKfTNnTTtKmbJPZArHWd2Qt/Q+hNlgD0DjtPag2U6eN9GtbIMUyzE33sH
 IkBQ==
X-Gm-Message-State: AOJu0Yxo0dYJbokKFjEhWJSqtcPBgz9c1WUf0MiOxl8zSeg20/ZOg+nd
 KM/aHKnRzJ9viQsnK6zYiE50AtM7uoSImBhVP5RiojYnfBApXLv+nLSGHFKvXm4neAU/KoGUAuu
 s
X-Google-Smtp-Source: AGHT+IFhGyQ9W9YcSmlCXMp3KuCr7lrYcg387ctaAmgKstqQNyVIcHZR59AmI90Ta0RAGTsH3Qhbmw==
X-Received: by 2002:a05:6a00:2da7:b0:71d:f0dc:ce94 with SMTP id
 d2e1a72fcca58-71e37f5e498mr75416b3a.20.1728587029407; 
 Thu, 10 Oct 2024 12:03:49 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/8] hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
Date: Thu, 10 Oct 2024 16:03:31 -0300
Message-ID: <20241010190337.376987-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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

In create_fdt_sockets() we have the following pattern:

    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do stuff ...)
    } else {
        (... do other stuff ...)
    }
    if (kvm_enabled() && virt_use_kvm_aia(s)) {
        (... do more stuff ...)
    } else {
        (... do more other stuff)
    }

Do everything in a single if/else clause to reduce the usage of
virt_use_kvm_aia() helper and to make the code a bit less repetitive.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ee3129f3b3..b5bdbb34e0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -780,6 +780,10 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
                                 ms->smp.cpus);
+
+        *irq_mmio_phandle = xplic_phandles[0];
+        *irq_virtio_phandle = xplic_phandles[0];
+        *irq_pcie_phandle = xplic_phandles[0];
     } else {
         phandle_pos = ms->smp.cpus;
         for (socket = (socket_count - 1); socket >= 0; socket--) {
@@ -797,13 +801,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                         s->soc[socket].num_harts);
             }
         }
-    }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
-        *irq_mmio_phandle = xplic_phandles[0];
-        *irq_virtio_phandle = xplic_phandles[0];
-        *irq_pcie_phandle = xplic_phandles[0];
-    } else {
         for (socket = 0; socket < socket_count; socket++) {
             if (socket == 0) {
                 *irq_mmio_phandle = xplic_phandles[socket];
-- 
2.45.2


