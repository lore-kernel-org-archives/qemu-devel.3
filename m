Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB4AC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag2O-0000Wp-Cj; Thu, 15 Feb 2024 13:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag26-00005A-Lg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:30 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag20-0002Dy-SI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:23 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3c1a6c10bbso148263066b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020019; x=1708624819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jS+9vp6/zBeUdjn9j7q2jb24zwJ4YAirnAR4bT5ORs=;
 b=fPWoS6AnkQX2JTFUYhgQplZi8YIj2apSlqRRgo5MU8Gyn91qhFWeW7UcuMJt9cd2iI
 i74EiJb+4vpZc+RcYAPJmarNUWyB0xv08rbuD/iUujq2bb0VI1f+xrz/IMgsbb33gr/5
 TK8HVN74MCJ093RYlURpC0T52puRQKT29cEjUhrQl2Z/Nb+/fihAILhbeSeGzbt4ZoPF
 W+QOpWi/5RvcmFvZgn6rWdXN0bSZUewp8Ei1cqMcakHgH6uQWB/wnBKmuhK2I1mlfhAc
 Tqg5oJq2GukvmDBfAjZmFwDIAs4gj1607qZPIajmPdSYhqoMuq97j/h8Gp+oNYiecdXm
 C/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020019; x=1708624819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jS+9vp6/zBeUdjn9j7q2jb24zwJ4YAirnAR4bT5ORs=;
 b=T/0EwzxiL+bFuSnfUtYOzhEpI6N9ToklrpHx3aNyZmcFEXPSWBQwDRDj6VL1oHsFVx
 d5Y/DaQrSQM8eLwTB5Hpnm7Kx30RX78XTpwAzJtwkW2zr04YrNRdHBD6ALu9c5byzNXM
 UqkQXQXazqUpopaJNXnHlM2yezxHBffKe+M6JctUV9x8MJWE+XajNf8EMuPkHPoIG8jG
 80hWAVLxE3BBF8WEwkkT1632MaYk//k3Bf8DwuC1HN/3e5uz5mZGtvgDOm5oFe9wpluz
 EplsOjY1V5bDB4xcUOLUtd0xYvB/5PMcRlFWYXy2ItmqmCRFUyWjYrobCJqPJkKJ9H4e
 xiaw==
X-Gm-Message-State: AOJu0YzLeX0jvUa6B3aDomW3NInfYwxJ9LXxI1+9p2Uq9937WujsVJ1s
 AkM8GPWhKNL22NNyoCE12jLqYByG7UgjW+UCZyeIewL1/Ga6aEHZpRH0q2LfG+7vjSP+tvRuI7C
 Ihgs=
X-Google-Smtp-Source: AGHT+IFysf7R/90ikKzJ2/aUhTfp5f6P0V285zcNqc5dHIhwjK6A0+GzfWDS+XpyeTNhP7329OL3DA==
X-Received: by 2002:a17:906:4544:b0:a3d:abd1:6909 with SMTP id
 s4-20020a170906454400b00a3dabd16909mr1221760ejq.1.1708020018932; 
 Thu, 15 Feb 2024 10:00:18 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 pj7-20020a170906d78700b00a3d1b41bb48sm787064ejb.130.2024.02.15.10.00.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Damien Hedde <dhedde@kalrayinc.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 22/56] hw/i386/q35: Realize LPC PCI function before accessing it
Date: Thu, 15 Feb 2024 18:57:16 +0100
Message-ID: <20240215175752.82828-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Damien Hedde <dhedde@kalrayinc.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-5-philmd@linaro.org>
---
 hw/i386/pc_q35.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..b7c69d55d6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -248,13 +248,13 @@ static void pc_q35_init(MachineState *machine)
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
-    qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
-                      x86_machine_is_smm_enabled(x86ms));
     lpc_dev = DEVICE(lpc);
+    qdev_prop_set_bit(lpc_dev, "smm-enabled",
+                      x86_machine_is_smm_enabled(x86ms));
+    pci_realize_and_unref(lpc, host_bus, &error_fatal);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-- 
2.41.0


