Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CEEC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQ6-000668-5H; Tue, 12 Mar 2024 04:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQ4-00062O-1V
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQ1-0001CV-4x
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e8b957a89so1580176f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231807; x=1710836607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eq8dPdS4O29YZHMSjUomBAXNnVOWg/nPlLYlOBRYYnw=;
 b=TcVF8q6CVfURTxPJpFVhmfBYNF3AcQyeUARzttJCWT6au5QoD2EK4TnbjV0DAz4o17
 V2eVZZwVvivJNj2qn8Fut3l8cG35tFybALy4IgnxM+i5j9cmcaThLrikdrx5u/bGFEsP
 dfnIak911LM0Ygi8aU2nXkIfD/fB6pepAczg6oFsMmypp2mrwT8ujsd4w+T+qm7kt4ze
 u7U/ZdsL03pUFhL0Vk8Gfq/wsN8/GzUmvjqk9jeS76n5n8gZDrbWpuBmDcs1++JKZJt6
 WhoNMP+TaIWlpIXSRl0y6UL4cFjW7rE1WrKvpldJd+5PP1PFjGpt8/OEf0r+GTBsvZOq
 gt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231807; x=1710836607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eq8dPdS4O29YZHMSjUomBAXNnVOWg/nPlLYlOBRYYnw=;
 b=UiHK63kFY00iiB4Jl1N8ztOdIbqtDA9p/9A4lwSTnsRFijLiEw9CAlh0Y/hTlLhtQ2
 yBFlD7wNRhYyNAQPzBHOZmU5sRolLCC4UVgmPb61EWzMEOz5GFckpWOX04ZKjrAdymil
 ikA9xmgDMS+mwfnJJL1EUZWtJNmTMHRH4HprUmaxGycbp0kmOreb2SyQTiInADtVSdI0
 q0NVAKmK44Hispf8qKtvraM2y5w4wODNQwnwK8TqBSHwA1ckL0fCg67lWAannUs3ZdKp
 x1jH0gpeFUsRqxMybleAPzMjcMHcI958ViO3CYhaVUi/Ec3lKJnOtk6tkM1PeJEidO68
 NdAg==
X-Gm-Message-State: AOJu0YxeiThGYuco1Sfb85RtPWreD8a/Jq+mCaSpLtKaKY2tGYGkwbbO
 tpy3VesdQljrZvO9iOWwwzOYs4w1CdGs/n3kybzSiqNTTl0uOEeCt0DYuWAAaWDQj1ujWyYUGlp
 A
X-Google-Smtp-Source: AGHT+IFHYt65s7EEaSlDZ6EY6Mu48qwjmIYfw3xS43O3GxR51c7APuxncTcj8Zkr7G4BUn2581D0rA==
X-Received: by 2002:a5d:5505:0:b0:33d:277d:a2c7 with SMTP id
 b5-20020a5d5505000000b0033d277da2c7mr5082955wrv.16.1710231807243; 
 Tue, 12 Mar 2024 01:23:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 bx33-20020a5d5b21000000b0033e93e00f68sm5279431wrb.61.2024.03.12.01.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 07/13] sun4u: remap ebus BAR0 to use unassigned_io_ops instead
 of alias to PCI IO space
Date: Tue, 12 Mar 2024 09:22:32 +0100
Message-ID: <20240312082239.69696-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

During kernel startup OpenBSD accesses addresses mapped by BAR0 of the ebus device
but at offsets where no IO devices exist. Before commit 4aa07e8649 ("hw/sparc64/ebus:
Access memory regions via pci_address_space_io()") BAR0 was mapped to legacy IO
space which allows accesses to unmapped devices to succeed, but afterwards these
accesses to unmapped PCI IO space cause a memory fault which prevents OpenBSD from
booting.

Since no devices are mapped at the addresses accessed by OpenBSD, change ebus BAR0
from a PCI IO space alias to an IO memory region using unassigned_io_ops which allows
these accesses to succeed and so allows OpenBSD to boot once again.

Fixes: 4aa07e8649 ("hw/sparc64/ebus: Access memory regions via pci_address_space_io()")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240311064345.2531197-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc64/sun4u.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index eda9b58a21..cff6d5abaf 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -360,8 +360,13 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_dev->config[0x09] = 0x00; // programming i/f
     pci_dev->config[0x0D] = 0x0a; // latency_timer
 
-    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0",
-                             pci_address_space_io(pci_dev), 0, 0x1000000);
+    /*
+     * BAR0 is accessed by OpenBSD but not for ebus device access: allow any
+     * memory access to this region to succeed which allows the OpenBSD kernel
+     * to boot.
+     */
+    memory_region_init_io(&s->bar0, OBJECT(s), &unassigned_io_ops, s,
+                          "bar0", 0x1000000);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
     memory_region_init_alias(&s->bar1, OBJECT(s), "bar1",
                              pci_address_space_io(pci_dev), 0, 0x8000);
-- 
2.41.0


