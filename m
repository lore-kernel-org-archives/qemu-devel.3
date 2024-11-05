Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBF6D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLL-00058k-NQ; Tue, 05 Nov 2024 17:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SL5-0004xu-OJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SL3-00048y-UE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so1584535e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846872; x=1731451672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cshkwIBAh9vxV4PdRAMkkgYPz+e65EDoyTAngUcARl0=;
 b=xPrAu3u+rZFv2LkM6PjsP0pLGN8BTZk8Gib9w5sGUphXOUijpi8tcph1ghcAZus9zO
 u4P1vpPMNS02A+0dmY6YJuvKzXZZizbAxKWo0W7jwd4jebSTa1cwLCxT16v1D+IsW9Uh
 9YDseIpiE4OF/jRC3AHe/7EUpV+ihlCnIqgoMimwfbMJSUmdKg3apiXi920w4DTaOvD1
 M1gwCyUFy+4vSlWdy/k0yvyJK3luDcfG990yutdR1xfiB/uBe14zdYQrzFHU4HNntY7p
 lntL48348+8UCiL+foRW/RLyvzRLn9elhDKMfqrVr5Cl8Hm3ilUF93fJmkmU/nx93MfD
 MokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846872; x=1731451672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cshkwIBAh9vxV4PdRAMkkgYPz+e65EDoyTAngUcARl0=;
 b=MBKz8LbZ51jRRddV+q/SZhAH2aXuukWeqEZDgV/9WHlKjXFtV4RvVIksDjK5ZjFGwN
 KSd2tap65Btp/iEFvDZDAUAENiD5NxHuURvI+Y69BR5lRRAL9YJENYxhnu9erG6/RkWu
 amh5obCBexnHAJZPJtA9/bvoqloQn0LcWfGvuQYWrAlhTBPgHKGIjVEBs574nBMvEdC6
 kyoVfqNVrmk7CIAXqs10JqfdG+I/mKPGHzqQW8l8HgIRbSPY4kBDDhppOvQOx/PecY6k
 7GboMwwu18Ssk8omouCff/Y2sUKjJiZLIBk4+UgB/TdWw9T8J/WK8vVGKMVbWaT07S7U
 T2lA==
X-Gm-Message-State: AOJu0YyADvdagXO+hA8d8DF1ude63DK+i9T0AbLovlqTjVX0J5sP50fe
 1bbOsb6d037YNlh8NdKOewIl+A8gBvGMDaC+sUhUh07ys5B3J2soSD/KiETqO9rYnzFy4wR1fam
 RMq7kRw==
X-Google-Smtp-Source: AGHT+IGi6bc6ki4aEg7ax3doaY5+nj6C9Zbe93AYubOp+76oypBycycSXq2O6Xhxv1T2m+JvBhRsxQ==
X-Received: by 2002:a05:600c:35c4:b0:42c:b54c:a6d7 with SMTP id
 5b1f17b1804b1-432a9ae746fmr2836965e9.14.1730846871895; 
 Tue, 05 Nov 2024 14:47:51 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ac7dsm17369292f8f.105.2024.11.05.14.47.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:47:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/29] hw/microblaze/s3adsp1800: Rename unimplemented MMIO
 region as xps_gpio
Date: Tue,  5 Nov 2024 22:47:02 +0000
Message-ID: <20241105224727.53059-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The machine datasheet mentions the GPIO device as 'xps_gpio'.
Rename it accordingly to easily find its documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20241105130431.22564-5-philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 37e9a05a62a..581b0411e29 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -124,7 +124,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
-    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
+    create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
     microblaze_load_kernel(cpu, ddr_base, ram_size,
                            machine->initrd_filename,
-- 
2.45.2


