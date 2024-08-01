Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF364C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXIL-0003RO-5M; Thu, 01 Aug 2024 11:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXII-0003Fu-6d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXIF-0005DB-Sn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso47885645e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524438; x=1723129238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3HJATsCsPCrOO9QF5DRAwhE7YAIM++c6LoE21bzlU0=;
 b=P2GK3cHF6nGYRwhPaAsXZCza93/3K6IrOc5KSr01xTFKnjiBheX8p19+tPYYJzAKbE
 XJPQBkritk/dTPNMv1efTfshNc3SsqVZt0BFtH7f284Bh4GMLiAtkBNPz8BvDxE5akrP
 94Ml1CB5vwrOc0dfXD6YfxnRgzyca5s+PCRaPVZvOkWkySdOuqHttib7moDqDA7tsD3Q
 CoJUy3mEEo+dLqWs+3s9aZNR6nurSWHc0Nc6ygsBUdDe4I1ck27+KYpvhFxb9VrwHXQ9
 Pq/jZQfgHaq305T9kePu4AlMLoX7xnp3HXZV02HRPpm00X0f/iY9usMWE3ky+jLQNdYZ
 NxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524438; x=1723129238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3HJATsCsPCrOO9QF5DRAwhE7YAIM++c6LoE21bzlU0=;
 b=t3E9E7Lh8Govg4S2Z6j8kgiAtYSCBgT3O40N8YYw4ba20pLdSDpZq2WjDfEhRT1sYf
 /Khej+EQrBnjse2oN1nw+LMW4dPEXfUAphcqcFXxz4h2WGTCTUPk/pkmz7FcpZC6FUap
 1OeREuW9YqCvDW07077xvfRn13F3kCd2RQ3oDdv0rxM1LUVoZJBBfF9AiV8zZN/sLMle
 /2k0C5dS4mwL7HBK1zUrqS0sneGI3AadFh94dqYKCw/ioulq/RVCjN/ICwbsUcJbx7Ot
 FWpjCqSjNOiVHwnqupIqkrCkj/yvySvAkdvkI04CLU9msiGFg9Qy2kBwWM2wXfiSH75S
 covA==
X-Gm-Message-State: AOJu0YxL6o+Tz+pMSsTaiiHMqwenXbcjmRsoKYmQsznvcyHtKs2N0utY
 rz6o54v7uoDqy16bSJ6tWouoZkkwOkEo3VlxxF4DnZkL8regIxJ4SKh+8Z1N/AJoi4y2HtGO+fJ
 6E/A=
X-Google-Smtp-Source: AGHT+IEL1mWiSPTHc+y8GUHnU1PA1PohJbqNx9YufzC1H0uOP0J558I3ftLWhfcU98Qe/DQwQjMhbg==
X-Received: by 2002:a05:600c:3550:b0:426:4978:65f0 with SMTP id
 5b1f17b1804b1-428e6b07aa1mr1181395e9.18.1722524437772; 
 Thu, 01 Aug 2024 08:00:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm60922005e9.46.2024.08.01.08.00.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 08:00:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v3 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Thu,  1 Aug 2024 17:00:21 +0200
Message-ID: <20240801150021.52977-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801150021.52977-1-philmd@linaro.org>
References: <20240801150021.52977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

When booting Linux we see:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)

This is due to missing base address register write mask.
Add it to get:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
  pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
  pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
  pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
  pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000fff]

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b68d647753..344baf55db 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1224,6 +1224,13 @@ static void gt64120_pci_reset_hold(Object *obj, ResetType type)
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
     pci_config_set_prog_interface(d->config, 0);
 
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
+
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
-- 
2.45.2


