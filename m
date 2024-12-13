Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F7E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5of-0005Pt-2Y; Fri, 13 Dec 2024 08:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5nx-00057s-7X
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5nv-00014P-3Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:04 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so862163f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096835; x=1734701635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KiX5mmq4vCwE1JaaWuCTD5vC1dSPpb7XgZTnnxB1/+8=;
 b=JWpx8Txo4yV0xfb+CcmVIuM0cs2NVD2zEZhVGQ3MWUQ/GcyZpi2kj/DRhenwcsjtpB
 YRiHBzCY3zrBdD08AdQY2WGAuJ47U2mjze6DpX8fdFJn4k6grm34NQ25T+0+py1pta3n
 NDP1/h+ctsRCNme1NSUopcvnpoYXgT66APT/SKdyQFwIjlTdZpcV29sZi6MucZNtJR5Q
 BQ1qAPeP/j7DNSW4u1WrsepvUYj9V42nGaf+XIfLg+SCLkocT+v7e4IAiJYgKoImYeN6
 SMyr2+0GBvbAPzKQIu5rtMCnQJzgILlz+QVZPWxAnK/E9+w8o+IJDH7Sg1esxNZ6uyoc
 ZHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096835; x=1734701635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiX5mmq4vCwE1JaaWuCTD5vC1dSPpb7XgZTnnxB1/+8=;
 b=dL21G1Zs/CK1vA8XE6VrjjHb5Dj224gdOyO2ir4TSVi4NA/KMVePLaZ5jrmCTskVdP
 dbirAsXw17oCqwwjXsI540v0CkSOUt6j3g5g05kS9B+tVH8rDsiNNjSnm+VSdr8DRP2b
 2LF/bfOhrJX4YxCBm1JIoQ2sXyKHGpeWvoyPgPyz/LRCNWQOZJmHudNTWPTeo6Hbo/Hk
 2qNlofr3QoZ5LVaxKAo0J04G4dU+D3XKKV42wN9HDISa+GsgqFr5zuNEvM8nzwfH9yLA
 BK1G8j2zO0rVWv45rEG50+FXGicJeOdDuciv4x50zkSmm1t2XcgoK+2I9F4ETYiPDU1o
 ufnQ==
X-Gm-Message-State: AOJu0YzBV0bEQ9H/XRKokKETuMPbo6y0UxrfwcG+ylAsmeokWzSFBX7d
 LNO7h/gvj5TrtMPIW1+jCU0LPPGhTLDQQfwoHrK+MUBRlxoxgaeV2CA32M1xiYjD3p/8H+ZGdCB
 m
X-Gm-Gg: ASbGncuQynoU0SWf/zsf39k/MDLayT8ciYXJjrjQD1+nCLEfIZtDIpmHYBYVWEiBtsA
 YrDriLgLgyhoDVaZZ1aVeUl4gxC/I1VpzedQmCdS89OtPx/rx9qonDoCdbLnj+ihJL7/KsxWQbc
 GVIVIoIliSFXDkRCIcDd0efpHZ0l3WMGvWE6CNSrNAfG6Q3oAQ5xOObA5tZzvCkz1ERpzEnhHUm
 a/v96bLMCtc9tAaJuFxpQwNSXnXjBepqRyJj6NmwsqxcNDjmAdWzRZ3LWrDKh3S+RQWeyh13PdI
 bPg5mP5rWBdOA9dWuBlGloxNI3G6Vl5speJ6
X-Google-Smtp-Source: AGHT+IGddx9KfLGgDnL25uyhc3Icb7GdqW1q4P5IX/YrPH9PYPNcf1IYp4mMtGVpTex6k+GDBqzT+w==
X-Received: by 2002:a05:6000:1fae:b0:386:366d:5d03 with SMTP id
 ffacd0b85a97d-38880ad88dcmr1988971f8f.16.1734096834521; 
 Fri, 13 Dec 2024 05:33:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f440sm7089595f8f.17.2024.12.13.05.33.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:33:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/nvram/fw_cfg: Move PCI bus methods out
Date: Fri, 13 Dec 2024 14:33:45 +0100
Message-ID: <20241213133352.10915-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Missing review: 3 & 4

Since v1:
- Patch 3 is new
- Added danpb R-b tags

In order to keep fw_cfg device model clean, remove the PCI
bus specific code. Instead, the equivalent functionality is
implemented within the PCI_BUS object in hw/pci/,
implementing TYPE_FW_CFG_DATA_GENERATOR_INTERFACE.

Philippe Mathieu-Daudé (7):
  hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
  hw/nvram/fw_cfg: Pass QOM parent to fw_cfg_add_file_from_generator()
  hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when no data to generate
  hw/pci: Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
  hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
  hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
  hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()

 include/hw/nvram/fw_cfg.h | 32 +++++++++++------------
 include/hw/pci/pci.h      |  3 +++
 hw/arm/virt.c             |  3 ++-
 hw/hppa/machine.c         |  2 +-
 hw/i386/pc.c              |  3 ++-
 hw/nvram/fw_cfg.c         | 44 +++++++++-----------------------
 hw/pci/pci.c              | 53 +++++++++++++++++++++++++++++++++++++++
 system/vl.c               |  3 ++-
 8 files changed, 89 insertions(+), 54 deletions(-)

-- 
2.45.2


