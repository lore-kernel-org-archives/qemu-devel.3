Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC8CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svB85-0006qE-BP; Mon, 30 Sep 2024 03:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svB5X-0006nJ-R4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:45:08 -0400
Received: from [2a00:1450:4864:20::629] (helo=mail-ej1-x629.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svB4x-0000Zk-O6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:44:51 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d6d0fe021so710801266b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727682198; x=1728286998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gRCWILJ5tP1CDEp4iIo0yM0ySxnxf6B3WCed3GxvioA=;
 b=IGP2mgu7/T2OoJ04wHAWdF64y60TYBkDyqdYoi1so0DWyhD+SA4OR9DeSQ91IM05xg
 FPxXRS22IlaX4f0kqgNXO7YO48EDrddndinSV1pENM+cRHZmlwOV3ZbrmiKSblXZJD91
 6tPzrQFOmSYowvJlcAjIgDafR/FzW4TpUORlvK1U68CIRZBQ5zWZ05MlxE/7UT6u0teM
 otfVO7UGh66jLwlGIAF2+Ja/HIjMgb8jcQ5x5mcQx1dwt0flwsKiuW0eF28es1i5AaK5
 LHbYrbSvCzrxfZLqG/Ul0rwY2D85qfhuzHW0R2poR8oBiac9g8iF/ig/DDzbAV08lyTW
 Db/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727682198; x=1728286998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRCWILJ5tP1CDEp4iIo0yM0ySxnxf6B3WCed3GxvioA=;
 b=dhkx4E82TWGLnfPYdN9bYH3Bmvhh/cQyHnV+NSvwgP969kP7PNagFfWe2GY3W/DVzj
 WDBD1ApsxanTuHHtXVls2uvj/7hsiYMQa9hMRFYNIQjtbEE8dWgXH6SHP0VAWYVsbLJZ
 mP24UryiVm5CIDqmTvlQX5+AikzBMctzBbn8pXifCBwuu/lVBlHGXSWvE18kDBd6bfDD
 XpyxJ43jRwnYzaLmqFh2p3CyGvW65thCrMDJ0m/OEFQAYU4NGvDVo4DV5OK/I2VDv75x
 ct6VDqd6snlh1igC5N4qzQKCa8O6pPOccCHiTfKBVL/+lEWnFpbiloOwmlAt9t0JfDlx
 zlwQ==
X-Gm-Message-State: AOJu0YyvBjDs907s2uWsR9VYp/IO4f99VM69HENuRO+gaf+jh00Yc6SY
 ILSlTSYff99HQvJJEj/Tbu3V6diJe70gSQ6DYWx9GIXmF2IGudUz6fklHakvNlEbGzqyqmsPQWA
 xrzI=
X-Google-Smtp-Source: AGHT+IGOtyU4Ofketg2XtEwaLaGUAiZZznXObn/Hil68D/dTg/agb5ZVPgC/bKHQcLcITIBmDftCLw==
X-Received: by 2002:a05:600c:1c85:b0:42c:c073:412b with SMTP id
 5b1f17b1804b1-42f58490786mr87695785e9.30.1727681696153; 
 Mon, 30 Sep 2024 00:34:56 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575dd04sm8282495f8f.114.2024.09.30.00.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:34:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 00/13] hw: Add ld/st_endian() APIs
Date: Mon, 30 Sep 2024 09:34:37 +0200
Message-ID: <20240930073450.33195-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1450:4864:20::629
 (deferred)
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

In preparation of heterogeneous machines, remove knowledge of the
target endianness in generic hw/ code. Move it to the machine level.

Philippe Mathieu-Daudé (13):
  qemu/bswap: Introduce ld/st_endian_p() API
  hw/virtio/virtio-access: Use the ld/st_endian_p() API
  target/arm/ptw: Use the ld/st_endian_p() API
  hw/mips: Pass BlCpuCfg argument to bootloader API
  hw/mips: Add cpu_is_bigendian field to BlCpuCfg structure
  tests/tcg/plugins: Use the ld/st_endian_p() API
  hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
  hw/xtensa/xtfpga: Replace memcpy()+tswap32() by stl_endian_p()
  exec/memory_ldst_phys: Introduce ld/st_endian_phys() API
  hw/virtio/virtio-access: Use ld/st_endian_phys() API
  hw/pci/pci_device: Add PCI_DMA_DEFINE_LDST_END() macro
  hw/pci/pci_device: Introduce ld/st_endian_pci_dma() API
  hw/net/tulip: Use ld/st_endian_pci_dma() API

 include/hw/mips/bootloader.h        |  18 +++-
 include/hw/pci/pci_device.h         |  35 +++++--
 include/hw/virtio/virtio-access.h   |  63 ++----------
 include/qemu/bswap.h                |  19 ++++
 include/exec/memory_ldst_phys.h.inc |  66 ++++++++++++
 hw/mips/bootloader.c                | 152 +++++++++++++++-------------
 hw/mips/boston.c                    |   9 +-
 hw/mips/fuloong2e.c                 |   3 +-
 hw/mips/malta.c                     |  21 ++--
 hw/net/tulip.c                      |  32 ++----
 hw/xtensa/xtfpga.c                  |  18 ++--
 target/arm/ptw.c                    |  19 +---
 tests/tcg/plugins/mem.c             |  24 ++---
 13 files changed, 269 insertions(+), 210 deletions(-)

-- 
2.45.2


