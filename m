Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40696D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg3o-0004wK-VO; Wed, 03 Dec 2025 01:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg3g-0004ui-VG
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:09:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQg3e-0000im-CA
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:09:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso3428245e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764742184; x=1765346984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h6yIxWY+b5wcoQgBXJY0MYki1/ZVS69AjGSGZSERWm4=;
 b=UfrYD6ETYdkfWXZKP/g4wSUefXN7LCFi3JuLG+OYg+3dfp7vTwWu0frvkwnfdwrvsA
 hemraJixmhWKZRqwNL7YqTrfpaVzbTCxCb9/YlVv8skngR7mpE7VSK71pgsl/Wc5NUS2
 z3Q8BXIF+SgDYvqCvWAQoDKP9V7qCCbvTCjYNKro/ZWK8S+Rx4EOL0oZEP/oXOBJgu4u
 SeXPhWQq6itDYPEFutu6YdKmLL/anaS0R0sVPI04J4+g9RKuC8ht9tj8uEBSG+B8a/8h
 6TLYZF0fTmRwLblixm7BT7LD9N4ve+KeUNYaueydtULgtZjYaOp6Vhj7yHwZeCr7NlY8
 gEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764742184; x=1765346984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6yIxWY+b5wcoQgBXJY0MYki1/ZVS69AjGSGZSERWm4=;
 b=YSSNpFCGGGuYJc5Pl64bovU7InQnIh2nh6guWAI8XkGcT3I50yOqMXsvAJhac3IsJ3
 +B780tnY895AdLxDc3wLxEgXT9ZGhEe8iXmlhzzEAcz20cpIIr4kjnGeLDFEV9s+5Jix
 ZSpJ7/OsSJOeKlhBH8oVS0fGz/FWdA/J82AA/e3XxIfWdagodK4FMCwRqrOMSQR644Jb
 KILRrmv98OxKUsoeQ2pePZYCNtDoOfYcjkXLGqXhig1IgtJQZecvjCjz41uhp5w3SXf7
 Hgk7FHAktluxreus+PixIfetPJrYcIwruRfnJEXaQ+yiFZUUf+F6NtPTq+Jxm3LJQvIs
 p5yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/AQqOWukcLFrzOVAnvQPmWBCsgrlAhGlVRG9imFkxrnp04plecW5Eu1G7DEM+3poeLJLHJgH+f/07@nongnu.org
X-Gm-Message-State: AOJu0YwYQE502p9REqI/WURqX2r4B08jxw1ZW13zwOeAjJ4yQzSaKSXh
 o5+c6sDozhdG9eExN2ItDdIy6vh8FPUuarZDKJ0FRgbWn98YheF3F735siSp+Q13DOg=
X-Gm-Gg: ASbGncsBmEffp3QTJNW/VhWcD0AyBh70uNWIzNjcx5WZn7OF4lBhRmAj50lgj9OucNq
 Bc0MltkDNRoTGGFGT2apYwE5t2nHjaCN23Tae7I2xYeUD7fYE3fWG6uEXDWSsd2BE5oWuzpEmyB
 rhOaIee+yUs/WXXPwvSBSW8ayQjOfLuTdeUX+VExTuVWytXtyLmxZkhJqG843ZLKOGhfUpNTpEW
 GV0b4j2kgHrLSJyhY115QhcG7sI5CKvNbNQkNLYEU7X+6EY0kPBAbHDIKyHt/PSTvBCG8yiYRbK
 VN2wkJ6egX8JxExBo4M+yPvel5mjFQOjPa38oIyO2g6gs427L2ZbZpaKEY0GdnNrP++ikuArqsV
 AisIYqdNc6+OIE0/E8X/fHRvgZnYB681eiJfCLnfgxwM4HrTFbTffmVJ1NxHERwyiAnMFnR6lcM
 Et4RQlOgCQRHGZ2X1Nfvnhr5DugeoF5UExrIvRKU6RNJI1fTq9XvaPhz+U4sLE3lACMGNzymA=
X-Google-Smtp-Source: AGHT+IGm2knsh6XMaCfcj0jJhXjYPNo2KUE5ECIfLfoOZwCH04zvdODQCpqDFtKdNFYyHkhNBJm9hg==
X-Received: by 2002:a05:6000:178a:b0:42b:47ef:1d7a with SMTP id
 ffacd0b85a97d-42f6d5b9151mr5827384f8f.20.1764742184151; 
 Tue, 02 Dec 2025 22:09:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6181sm37266130f8f.18.2025.12.02.22.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 22:09:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 v6 00/13] hw/sparc64/sun4u: Use fw_cfg_init_io_nodma()
Date: Wed,  3 Dec 2025 07:09:28 +0100
Message-ID: <20251203060942.57851-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Zhao,

This is my answer to this comment of yours:

 > Although other callers of fw_cfg_init_io_dma() besides x86 also pass
 > DMA arguments to create DMA-enabled FwCfgIoState, the "dma_enabled"
 > property of FwCfgIoState cannot yet be removed, because Sun4u and Sun4v
 > still create DMA-disabled FwCfgIoState (bypass fw_cfg_init_io_dma()) in
 > sun4uv_init() (hw/sparc64/sun4u.c).
 >
 > Maybe reusing fw_cfg_init_io_dma() for them would be a better choice, or
 > adding fw_cfg_init_io_nodma(). However, before that, first simplify the
 > handling of FwCfgState in x86.
 >
 > Considering that FwCfgIoState in x86 enables DMA by default, remove the
 > handling for DMA-disabled cases and replace DMA checks with assertions
 > to ensure that the default DMA-enabled setting is not broken.

My series is to apply just after this patch of your series:

  [PATCH v5 10/28] hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()

Regards,

Phil.

Based-on: <20251202162835.3227894-11-zhao1.liu@intel.com>

Philippe Mathieu-Daudé (12):
  hw/ppc/mac: Use fw_cfg_init_mem_nodma()
  hw/sparc/sun4m: Use fw_cfg_init_mem_nodma()
  hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
  hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
    fw_cfg_init_mem_dma()
  hw/nvram/fw_cfg: Propagate I/O MemoryRegion to fw_cfg_init_io_dma()
  hw/nvram/fw_cfg: Factor fw_cfg_init_io_internal() out
  hw/nvram/fw_cfg: Add fw_cfg_init_io_nodma() helper
  hw/sparc64/sun4u: Use fw_cfg_init_io_nodma()
  hw/nvram/fw_cfg: Remove fw_cfg_io_properties::dma_enabled
  hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
  hw/i386/pc: Remove multiboot.bin
  hw/i386: Remove linuxboot.bin

Zhao Liu (1):
  hw/i386: Assume fw_cfg DMA is always enabled

 include/hw/i386/x86.h             |   2 -
 include/hw/nvram/fw_cfg.h         |  11 +-
 pc-bios/optionrom/optionrom.h     |   4 -
 hw/arm/virt.c                     |   2 +-
 hw/i386/fw_cfg.c                  |  19 +--
 hw/i386/microvm.c                 |   6 +-
 hw/i386/multiboot.c               |   7 +-
 hw/i386/pc.c                      |   7 +-
 hw/i386/x86-common.c              |   7 +-
 hw/i386/x86.c                     |   2 -
 hw/loongarch/fw_cfg.c             |   4 +-
 hw/nvram/fw_cfg.c                 |  61 ++++----
 hw/ppc/mac_newworld.c             |  11 +-
 hw/ppc/mac_oldworld.c             |  11 +-
 hw/riscv/virt.c                   |   4 +-
 hw/sparc/sun4m.c                  |  12 +-
 hw/sparc64/sun4u.c                |   9 +-
 pc-bios/meson.build               |   2 -
 pc-bios/multiboot.bin             | Bin 1024 -> 0 bytes
 pc-bios/optionrom/Makefile        |   2 +-
 pc-bios/optionrom/linuxboot.S     | 195 -------------------------
 pc-bios/optionrom/multiboot.S     | 232 -----------------------------
 pc-bios/optionrom/multiboot_dma.S | 234 +++++++++++++++++++++++++++++-
 23 files changed, 302 insertions(+), 542 deletions(-)
 delete mode 100644 pc-bios/multiboot.bin
 delete mode 100644 pc-bios/optionrom/linuxboot.S
 delete mode 100644 pc-bios/optionrom/multiboot.S

-- 
2.51.0


