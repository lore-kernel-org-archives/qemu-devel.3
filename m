Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AE6D3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMY-0007R0-Ai; Tue, 05 Nov 2024 17:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMG-0006yf-Jz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMF-0004LM-39
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431688d5127so47412615e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846945; x=1731451745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGtCoSE8gk09HIhJA89V3965nEV5mYL3yVeFFS+1W7c=;
 b=UJyDDGkAUQp4Y5YlGH8mcjCxcJvwcHDLRMYfWVZ8RIa9JUlqRwzh87Y8ScoD23GvTb
 DOtO3Zf962dtcr+mMbPC4Hd3usb+hko2ZYvUNp6kuvT5XqDJ0jpL7B8LWkcDqFElakgn
 pM7prKSuEfuqj4CJmm39vpE15O7Zt+HPZxpCQlG/bIvtRzRG8qtAN1y3qDjyrYtcuRwj
 A1Ba6+e18zsElO/u+QOBxSa599xX7npAMmYqL5kFqm0r7+1YYO96xu5yoXZ0VpggsD+z
 ydrQNVMfgX5AWtIwRyO4gfRzEXsw/o0kyPt+XH3veMB+gVpiy/WXQgffelCo57FXw2RG
 bkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846945; x=1731451745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGtCoSE8gk09HIhJA89V3965nEV5mYL3yVeFFS+1W7c=;
 b=iYIUYyVLsfvVhZ1AkNzgIDBlQgcSoxsLfENOzNutwwxlSeHQLMuL60SqNiWXXMqUeN
 hqx8t2P1Aw2JP4U1tI7j38E096NDuoddvYA+mrxOPe3iawOFy/NOkRk9zsDcL3UoODMP
 3XBxe8Bu1LJ6LxFLIblJqaRoAx2p1IIAeTxrkQp9gCv7CACvAvfp3ShKYBTv+mUO2s4n
 u4GLP6Dampnd3CBWICYke6iEiGLhgaziLUMWQEYpaAcsFg9KXf5bQ4Oo050uJdrbijzI
 K0pLXJpSkS4ChOrGODLSSJPIIjUvp87PNaXWEJdo5bzKZFjfnVwU3CNtzTw0Y1l191WM
 1LvQ==
X-Gm-Message-State: AOJu0Yx6xIDvBTX4zG4kZJwJ8iquMeROaILioo7XTOi04NgFcuKY2Zc+
 yUXu2CUKwIzToMaaNpwZBdJxlmPgHrDOfk4UTbcOEKAN0xljVz9ptCkKHiBZJPggRZEx90W+FGV
 FrpmWFQ==
X-Google-Smtp-Source: AGHT+IFcZTRlovfpZppdSOpL8u6FlAwRr9eGJSYfhLGjYo3MhlqHsBhaViJRFu0W9M9lCxYUyL2mvA==
X-Received: by 2002:a05:600c:1c11:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-4319ac9a725mr338327265e9.10.1730846945105; 
 Tue, 05 Nov 2024 14:49:05 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5b2dsm1120385e9.1.2024.11.05.14.49.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/29] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
Date: Tue,  5 Nov 2024 22:47:16 +0000
Message-ID: <20241105224727.53059-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Prefer a macro rather than a string literal when instantiaging device models.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-14-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/ppce500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 95b983b2b3c..5a4a924a2f0 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -475,7 +475,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple(b, 0, "e500-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
-- 
2.45.2


