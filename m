Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9863CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoCD-0006Rw-2m; Tue, 28 Oct 2025 14:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoC6-0006Rh-OY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:13:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoBy-0001XD-Ee
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:13:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so35361325e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675183; x=1762279983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O0GGiZXrm4OzHdOc+19/N23vVvY3UXsMWqAq/zS3aok=;
 b=qajfihQZ3lc8367o1KJYvf8AnhMbt5b81oJBI9h4ArZBTmt+miX1zJVgTLrDj3dGNr
 vCeCuq+UV+ZpcXcV5av7cX4DQ0TfI36WQmU7rLHGO1IoKlbSsYEWYBiRzenyqDmod9CY
 a66G5T0aB9q/RvdjNuqPs1QmVsgOUaLliZ75G5BC/yCQYxiRn/y0lCR1DEFrpKQH4IXm
 TsZNOucR9LfNsAAnZKwh4on+MSdQuwJVVIWYiLnXi/Ezj44q9LqKLQ5P2iqj3bxJW3QM
 SOUgAr5eLH4l5T/BPaP/Kgcpqj5UwVAmg6TC0vsmKJGG8xxOzo9MgVSDHOQSWMkwsJLU
 nKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675183; x=1762279983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0GGiZXrm4OzHdOc+19/N23vVvY3UXsMWqAq/zS3aok=;
 b=XrCG9+b/uoz2MKzPisDobFwTenHtWBJwjmmmI9cd2nCLIXWZFUq9Yb/BKysmAmpW/0
 HKP0Z974atmmYcgOKiXyWdb1ZqAu5NhPdFMJZhMscFKhyqJZROkhzsRmbwX2joIc+XmI
 BYUV4kZJNGds2iX+21MdMYeu9ty7YzpilQmcg4SnWl1Ty1osX+r2gjbFZtkMl0kPYezE
 YcJ2sUWeidHnWzOfXdItTHyRqzkT01xj6UQtISqz2YlXvvCZUv3dh0BLo7Pm0uCmlc3p
 mOnhmxjGDADir15Xpu6TZwCS5yoRBkxPvI6aIlN79+70IxvnLzapFRfG5yC05TfSkV49
 1PcA==
X-Gm-Message-State: AOJu0YxqwFUhjPrZAbimGsOCoSAW8SWv9EPrv5ZZc1VLU4tHxoaPRTXM
 J4Rruc9tRV8PY2jzzrIp9F12v1P07REAhSjKfaIcoaYSW3MWjK2bb3KRS5+ahemp7ks31MRlXkY
 aHVYZNa0=
X-Gm-Gg: ASbGncu5/ugMkViZurfSnFD6HdJDKl+xZvWwGMewEsqtnbrCm45M95w02xGsyz/DGO0
 4UYHUvJEiMLZWe/L5ADN51nFwKnm3ylGSwBAzVONq97wmZAXLtChtRlhWH4gzvzGLe6JFPx3uHw
 PNAb1D8fdI7X8uMqalYjLCCZL0diBFPQ4fHuqs9aoXeQtx2O/gSx+Zt0BML0dYc/a06HDOvbuIX
 Fumm1ofwsGiezg4+qnNZcH5wCgLk+2TWNpNHmAkm209rHojEu9Yd43uGccJ1RTiLwCsXEjcO87g
 tXBlU55I5ayZD2oNZi402mo2HOsv/HSn9ATDIHXUFXZQg08BBfZmJ5l+7WB6BhJd5rnmp4N/cz+
 qqPca3da+KrzOIGHAIHIIOIa+KVIUTI0jJ7MjaDBVxhIbe++VJLidNJGmcJG4XYzloxsU9GPIrK
 XtasgOmzNua1OHH6z1Pl2YAHwGujdZ4qwofUYzqZ7uXzqNbUHReQ==
X-Google-Smtp-Source: AGHT+IFjK2ci8BodYlqQsw4T7KtvfGXcZAulUk9EPCLZXihdGhzOdLZjWG//I7VzhVMwGc/dq8M4Qg==
X-Received: by 2002:a05:600c:3b23:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4771e1e3abemr4503435e9.34.1761675182854; 
 Tue, 28 Oct 2025 11:13:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e387aa9sm3683645e9.4.2025.10.28.11.13.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:13:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/25] hw/sysbus: Spring cleanups (part 1)
Date: Tue, 28 Oct 2025 19:12:34 +0100
Message-ID: <20251028181300.41475-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

- Use sysbus_mmio_get_region() instead of SysBusDevice::mmio[].memory
- Use memory_region_name() instead of MemoryRegion::name
- Use memory_region_size() instead of int128_get64(MemoryRegion::size)
- Add memory_region_get_address()
- Use memory_region_get_address() instead of MemoryRegion::addr
- Remove SysBusDevice::mmio[].addr
- Simplify SysBusDevice::mmio[]

Philippe Mathieu-Daudé (25):
  hw/i386/microvm: Use proper SysBus accessors
  hw/i386/ioapic: Use proper SysBus accessors
  hw/timer/hpet: Use proper SysBus accessors
  hw/acpi/cxl: Use proper SysBus accessors
  hw/ppc/e500: Use proper SysBus accessors
  hw/pci-bridge: Use proper SysBus accessors
  hw/sysbus: Use memory_region_name()
  hw/nvme/ctrl: Use memory_region_size()
  hw/s390x: Use memory_region_size()
  system/memory: Have memory_region_size() take a const argument
  system/memory: Introduce memory_region_get_address()
  migration/ram: Use memory_region_get_address()
  hw/acpi: Use memory_region_get_address()
  hw/fdt: Use memory_region_get_address()
  hw/nvme: Use memory_region_get_address()
  hw/s390x: Use memory_region_get_address()
  hw/timer/hpet: Use memory_region_get_address()
  hw/watchdog/aspeed: Use memory_region_get_address()
  hw/pci-bridge: Use memory_region_get_address()
  system/ioport: Use memory_region_get_address()
  hw/sysbus: Use memory_region_get_address()
  hw/sysbus: Hoist MemoryRegion in sysbus_mmio_map_common()
  hw/sysbus: Remove sysbus_mmio_map_common() @may_overlap argument
  hw/sysbus: Use memory_region_is_mapped() to check for mapped region
  hw/sysbus: Simplify SysBusDevice::mmio

 include/hw/sysbus.h                 |  5 +--
 include/system/memory.h             |  9 ++++-
 hw/acpi/cxl.c                       | 10 +++--
 hw/core/sysbus.c                    | 57 ++++++++++++-----------------
 hw/i386/acpi-build.c                |  8 ++--
 hw/i386/kvm/ioapic.c                |  3 +-
 hw/i386/microvm-dt.c                |  6 ++-
 hw/loongarch/virt-acpi-build.c      |  4 +-
 hw/loongarch/virt-fdt-build.c       |  4 +-
 hw/nvme/ctrl.c                      | 15 +++++---
 hw/pci-bridge/pci_expander_bridge.c |  6 ++-
 hw/ppc/e500.c                       |  2 +-
 hw/s390x/s390-pci-inst.c            | 23 ++++++++----
 hw/timer/hpet.c                     |  4 +-
 hw/watchdog/wdt_aspeed.c            |  2 +-
 migration/ram.c                     | 11 +++---
 system/ioport.c                     | 21 +++++++----
 system/memory.c                     |  7 +++-
 18 files changed, 113 insertions(+), 84 deletions(-)

-- 
2.51.0


