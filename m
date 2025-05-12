Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 21:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEaPb-0001xY-Nl; Mon, 12 May 2025 17:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uEaPZ-0001wd-Ob
 for qemu-devel@nongnu.org; Mon, 12 May 2025 17:10:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uEaPX-0005bp-KQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 17:10:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fbcd9088a7so1369771a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747084204; x=1747689004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WRkgm9XeDa7vJAraKEOJ2rUXwK2tRqBG6U3M/pzXGhw=;
 b=jMmLcNlVBb+FHYVt9ODa5+EsrfbgQsyFd0zU4p+D6XDHJsdcu9rtGqUsRSCjK5R5jI
 1fqzI3PTG0Ozr8hgC37rv0DVxzpMKjrCs/JBC8K5H9uBiJllDK/1TJkSjtP2OJB5JPKO
 0d4t+kH5USlb6xW+yDa88IuGk1q8V+3//LP3SETx4vC2uUufMDW5cgJBwtu+cUvllkxy
 VCqLg7knKHfsAIzmlyaKyhoeOy8ru3qtrnaWiqZr/KRu/UkQTAmOIqnugXGrl+lCyywM
 JsazLuWanflpRR2pnBx8lTfSrbnuqrCSTm8WCuvTBvn/7/n/Ij9OjnaBO5WbIVrgqIiV
 o4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747084204; x=1747689004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WRkgm9XeDa7vJAraKEOJ2rUXwK2tRqBG6U3M/pzXGhw=;
 b=TPPVazQkpNKJtHg2ZK2oM9Bmn8pJtVeXchwdpOO9w91FIBB6DpC0kIeA0v97T9D84Z
 f6kAhArQm3z3CcVKc4wSDa/jJJP7rh8tJ2aKFeGuJsbshsVCi7nCURmb40K53gPdL6mD
 BanH3KrUm9yaJw7wEYJoYdbCRWPi16422YmVP+85IwYve+k7h8yKEHPPqfHfbZzY62j+
 YnxIy8oveTGXwrODjbPSimWIu+cG+3K/uGHxeHyJVGnahHqdMSYtkWtX8WyP25/9yqA1
 qMNJvscaXIB4CtnCzlG2NIhbB3sWNcUwbNFhl1q+uv9ZL1ZNCQlsX458Tf2JJLenMV5F
 +LDA==
X-Gm-Message-State: AOJu0YwFi0fXnVwJQAUtdQZ3IWz3dupEfIj6cLrT+I/3jya6vA9/IpvY
 mAm/jjNqfhOw6bfjvuaspxAZDk1t6VsheDUUA/Wt12xgM/RXjLm6r4fyh9ny
X-Gm-Gg: ASbGnct2ePIIo98CaOsxwfdE8c5Eirl8GseYLM5BD1w7g2nbsejkWJzfRzh58d1jsx0
 0Fy1PyJC9aCzvOmV/GK2kqKTNTXWdC38v1E4QLN/a9ZGTPAOueCnrTAhP03YqVWQxj0BLw7xmdA
 VaPEWD+erxKUh1TRgKg2VrTFW4Zc5TgTuPJ+7MC0vqNl3MKVhrSTVgVigeo/Om5bMJZJDAoC4ee
 h7p7cdgLLGDbL0cn+FZq5C/D2ChxvT1LUYOW0FhyopD8Lq2gDFvYYdhUL/6vcZI9F7F533xDHH/
 5BndQymUQc31BX3cS21ODZxR+vVFs+x+/Yux1+te8Iaaf7KwQD4+x31hH3j+J/UVB7iKorY9bxZ
 QomCJIKQqwDTRwuZ1R8JFl+QsTOCsk5lnjicTQnRylFpePavwLKGPhNV4uOQI7wzURFvfjeYhrA
 ajsbI0Aw==
X-Google-Smtp-Source: AGHT+IE8xUENvgyBsmEg+5csGIVOVilg1U11Xfaxuq0QquGPQ/p5IuJUniGu23+2Pd1ppjzF4w/4LQ==
X-Received: by 2002:a05:6402:2111:b0:5fc:bf2f:4b33 with SMTP id
 4fb4d7f45d1cf-5feebc1b6d9mr782788a12.10.1747084203975; 
 Mon, 12 May 2025 14:10:03 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1dad-1c00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1dad:1c00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fd29f9fdc2sm2817516a12.4.2025.05.12.14.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 14:10:03 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
Date: Mon, 12 May 2025 23:09:28 +0200
Message-ID: <20250512210928.4195-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
attempted to refactor RTC IRQ wiring which was previously done in
pc_basic_device_init() but forgot about the isapc machine. Fix this by
wiring in the code section dedicated exclusively to the isapc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2961
Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_piix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f18..4c37f5419a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
         pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
+        uint32_t irq;
+
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
@@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86ms->rtc = isa_new(TYPE_MC146818_RTC);
         qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
         isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(x86ms->rtc, 0, irq);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
-- 
2.49.0


