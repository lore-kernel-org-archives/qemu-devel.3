Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C19C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXEb-0004uh-Ez; Thu, 01 Aug 2024 10:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXEY-0004sV-A1
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:51 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXEW-0004VC-In
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:50 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso80580161fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524206; x=1723129006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McDzB/oHM/+Tt1V4WsDekmxT5WVMgu7zHufwqqju/fY=;
 b=qAUTiFiS6h4G6Q0ULOKEkIS+FX87HJ29uLKBpc1xJRb9GZs6oOTgLB+OvUWTQuScVI
 40ruAQo/wDVp0SVc29GQAJtRnovkjCkidmG0NPdQK7r2n0tpA4az0ckL3cFqo/rhnWjX
 r02AzCmjmDj/D9RRodQDYjPTZpKauagdCbdOvdZ05ry4pZPdlqpmTXDim1s+YF3HgeQR
 Qeyz35bntqxcsdoTTsQWpqDFW6eDvP+rTKy/mM4HoMZk/izwxHXN76KKAkNNWQdq3iKL
 IgHSC2hs+v2pw1IPWAFDxLOgFLtWeLBM+VQxLZgGqZKKcSRsf2KUNqpQYg9Bi0UPe29Z
 eBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524206; x=1723129006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McDzB/oHM/+Tt1V4WsDekmxT5WVMgu7zHufwqqju/fY=;
 b=j7n49PfkANRyUGYLuVCCXm3hP8fSw41QfSloF4VsuSz5lmz81yTl5P7Euk/IcvD/2I
 X5bPgBc+1GNiVNLctbxKYzdo4cZbkjdxo/Gio+DaEN3XK4s+UuPcJwNT2PXD72c1pScz
 cz4yETQcZHMFQmIxJ+6JUugJWZIgJClOJ5iRK5U73SumDP9FEpUQqvLIkiIm9QcapNYz
 0rt6nVf0sbSOkdbvwxBtjAmvtY26N7Hypfwnc5YN2rUj4mxjiC8qZMTEG8XJvSp5DdBT
 McHTV+RF55JLFgsgwNymbCr2UdOeiuDwC1x++Haru3XVq/PwChYfHSmGxcsL4iqC+OhO
 MvCQ==
X-Gm-Message-State: AOJu0YzwfbjUw9BcCD9yHmv765jWXu8o+MNDAI8h3iMKs2g0y8/zslFq
 NjzLMcVMlWAUWUwiMf2IdEvjWKoYg4JViacWkV5f5SVZZWHGLEh7j9YkDFDC994fOe8Z62ZIAgH
 xCqM=
X-Google-Smtp-Source: AGHT+IHqj1pixFCteSWHuSZCeHB2g1nl4zHtbbCDvXDFs4uUZtoZUlRHpPM3B8UJaf9pIolYUySxtg==
X-Received: by 2002:a2e:86d5:0:b0:2ef:2ce0:6ac with SMTP id
 38308e7fff4ca-2f15aabd06cmr3589801fa.22.1722524206396; 
 Thu, 01 Aug 2024 07:56:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d95dfsm19603823f8f.35.2024.08.01.07.56.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 07:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-9.1 v2 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Thu,  1 Aug 2024 16:56:30 +0200
Message-ID: <20240801145630.52680-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801145630.52680-1-philmd@linaro.org>
References: <20240801145630.52680-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]

Mention the datasheet referenced. Remove the "Malta assumptions ahead"
comment since the reset values from the datasheet are used.

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


