Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84247D58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZj9-0001yW-AJ; Mon, 25 Nov 2024 09:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZj5-0001x6-63
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZj2-0006Rx-1N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so5421295e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543562; x=1733148362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AeD0P2OiM6dGib9Y7QdKZWERXOxrMdWt2Pcq04zPLT8=;
 b=iSfBENEsO7tDUZ4jhNgFqw9os/WT4E5JWDfhoRd1Jp8KLmTgNicdWukMBPLQJt03I6
 QfryLUmJFzcQHKJkIfVC+nKi9lG5jLFT/GW/6YdNzjtzhJdLjBIX0yqu/vKA9ZIwNvX2
 wyYOUYszT3h1DDjVMHL2+9/W4CDkVS4jZ2RVBe6zh+nJ5W8KNKEV1Q5fAQQt4QicuE69
 Bfivhrn21AFndV33UhNPStwymZ3MltSYoEOg+KncklR80Q8ILjE6ayGYh4BGu4sYXsEt
 nc3SboCxlHJgPgZeoTaTxwXtDNMY1IhaFc/U/11OnKtL9fT7xOXo8lvZ5XDzoldgCK/w
 QXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543562; x=1733148362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeD0P2OiM6dGib9Y7QdKZWERXOxrMdWt2Pcq04zPLT8=;
 b=mm/7eOWs5XMQ3k7WPX8zDGQDreYN9tkNm/Qk1DzPKn6xHpjBW4wWHmDe//0oW38xY5
 Z87dMHGgglk27deVL17IPG2/G5BFYIOJ15yOKjx4jalQNXAPBaWY5c0/UMJ4LHG6sUgy
 vQxgrCA00p1mKUSgfLUnP9FwjwrIYoNdRLjJnfoXBxplCIZVjZXiHjz2W5/u98hgklG5
 gqk2j6Qi0awtXwPseRAXDQfqXbIEsGIztATAjjK/G4fJrlKHPcaoseng87rN8rQbcBEJ
 GwSgKUIwuRwG0I6A1k5Zjy3YHXA4Yap+gXnWJq4QT0wiYBMoU88NePkZ978WOsKO9+KY
 5oNQ==
X-Gm-Message-State: AOJu0YyETek3M9itAhwZjzYB2KXCzoNi3faaieR1eTZxsK9YDF3h616W
 uwMB9aR/cuLIF4kQraGMN/wZ8gOlbylKELybAjgWFIGZ/Eb9Z9FgZrIYZYOvx9OvEm90U2UT4kB
 z
X-Gm-Gg: ASbGncuElhCcbF+4Rs0RQ+yiYXDbmwcLa8qs8X49aC6krwLrimgD+P7HVNTtOVirfub
 Tr65h3zjKhCVI8us+UWGu2H2S3qYwlNGJDPWEq6JP6BXEqV8iVlfCXUbY4PZM3Sm+njTkGGcRQO
 44jggE7V99Xu9/PH2HYmrgtGLKvl9G/ddAdQEm8de5wP5Sez2fYdbh9Hjs1EHxKQGEkRrWx2tKl
 bQkAtNrv1J5fmrM7Y3YI3YWp2xSxe008miNkIgwseEQsmrGlLMbSomTzcVQsnLExqyq2LLK
X-Google-Smtp-Source: AGHT+IHLP+UUX6cL/ixIRSYIjytDfrJPlkfU51kAk2X6zzlDdsnbX5ilVe2fdWmGidmW5A1KKvscvw==
X-Received: by 2002:a05:6000:1882:b0:382:4fd6:405e with SMTP id
 ffacd0b85a97d-38260b86b69mr9463747f8f.29.1732543539222; 
 Mon, 25 Nov 2024 06:05:39 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a340369asm4387695e9.3.2024.11.25.06.05.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:05:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 0/8] hw/boards: Remove legacy
 MachineClass::pci_allow_0_address flag
Date: Mon, 25 Nov 2024 15:05:27 +0100
Message-ID: <20241125140535.4526-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

This series aims to remove a legacy field from
MachineClass.

Rather than a global exposed to all machines,
use a pci-bus specific flag on each machine
requiering it.

IMO it would be cleaner to add the property
at the PCI_BUS level, but we only provide qdev
properties for *devices*, not *buses*. Meanwhile
we could register the property using plain QOM
API, but at this stage I thought it might be
over-engineering, so I restricted to property
to the GPEX device. After all, there is no
concern by similar PCI_BUS_EXTENDED_CONFIG_SPACE
use.

Philippe Mathieu-Daudé (8):
  hw/pci/pci_bus: Introduce PCIBusFlags::PCI_BUS_IO_ADDR0_ALLOWED
  hw/ppc/spapr_pci: Set PCI_BUS_IO_ADDR0_ALLOWED flag in host bridge
  hw/pci-host/gpex: Allow machines to set PCI_BUS_IO_ADDR0_ALLOWED flag
  hw/arm/virt: Set PCI_BUS_IO_ADDR0_ALLOWED flag on GPEX host bridge
  hw/arm/sbsa-ref: Set PCI_BUS_IO_ADDR0_ALLOWED flag on GPEX host bridge
  hw/riscv/virt: Remove pointless GPEX_HOST() cast
  hw/riscv/virt: Set PCI_BUS_IO_ADDR0_ALLOWED flag on GPEX host bridge
  hw/pci/pci: Remove legacy MachineClass::pci_allow_0_address flag

 include/hw/boards.h        |  1 -
 include/hw/pci-host/gpex.h |  1 +
 include/hw/pci/pci_bus.h   |  6 ++++++
 hw/arm/sbsa-ref.c          |  3 ++-
 hw/arm/virt.c              |  3 ++-
 hw/pci-host/gpex.c         |  6 ++++++
 hw/pci/pci.c               |  4 +---
 hw/ppc/spapr.c             |  1 -
 hw/ppc/spapr_pci.c         |  1 +
 hw/riscv/virt.c            | 23 +++++++++++------------
 10 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.45.2


