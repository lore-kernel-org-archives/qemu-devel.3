Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792B7D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0tN-0001M2-RJ; Tue, 25 Nov 2025 16:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tM-0001GD-3D
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tK-0005A8-D3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso58841685e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107284; x=1764712084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqYEWVMngMY9irhHqURQ6nqbt3uGEvO/BqZ7WT6Zj/0=;
 b=LPS3nKi+14UymlxgOlyrCaVrIdNFBX7GKdG/+9x360pjWg/xik9tsCnudawm/uP2wQ
 ZwAzzaZgD2mWLIuExjFBSXZfv8RTtNPLK8Av+lvSFF/9lyj6BQtkBgD/rNdWOr3ClTy+
 6aRGR22YP3/Vw06K7kI+seLuR8tIEJizDNbte7LQBR7fvdCwIdte1EY6K/ADR8Q3q8Vg
 KfB3tmrBLljjkiJSHGvLNApNZCrBFlpv8c9WTPeOchC9eQ7OO9WybP9KOvRe5zadGkCP
 ozdtlqWKXNGL2pVu2O6S+3rhhK9Y3mFuLVEDi+r+XQl2Z9R4rBuq0VBIgYRlUAXZEp/Y
 +PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107284; x=1764712084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqYEWVMngMY9irhHqURQ6nqbt3uGEvO/BqZ7WT6Zj/0=;
 b=FN0YetgbnJLqiO6AH+ZrYny9MnkX85J7PecRX249DAA1xafMWb7ek13aFtxh+kOtMk
 SzryR3i+ASD51p1fWvffPffX/qXey0SpfuE6y2aBXD6v6i2ZmWK36yL7+8uJfdtapZh+
 ZQAltzxe2Jy/Q7KmGwtxj7CZ0sUqkO0edbYs0T//QiVk94wLRAfZY5SAk3ETtSy4bu3W
 aSaEQZ/fxL4V5J1aNaOSW465UoPKTHOeZnJ7imEIpye97slRJTvBODsDe1lChNKCKikG
 2VM6IUYSuXuQAW6dI4hxT2cmWZNygy7hcrFm+tBdKhjmYa16oUi3k8TBmPFer6s5WusK
 lnAA==
X-Gm-Message-State: AOJu0Ywpm+402a+K0PGjGSGnNu8G6JjISG9LIqSlBSMwBCJGja+Wb6+A
 2RQkckOS1L2scqiq9xpmIlXj21hC9ELLj2bJKmfW+ErhLhDdiKjFaPaL1Upxi99KEG3zwgSeRpY
 AW6075RFybIQr
X-Gm-Gg: ASbGncukJSxXkGPYuEjnXiF3ie9mfZdpGgnnxVvdW5q/9XqCG90LzSXaxk9v3FCIX4i
 WWzv8VGJMMDfenwu/sfy/L5lAphKi6WtGHYg8zeWa/VurjP0NbkgBjYP9ta6xZ7O0D+4SfJ8tDB
 e8VadrQAtRvH7XKiVHT35mahYB0sdpEVcTaPZthACLW2g5cO2X0R/m896ysfr4KdbkTzaXK3+Ra
 TY/0ZrDAxzGrgpXK/JQVT3tBYvB0+GiBO8JjnqUsdvoONf4z9w4/pN3j50YPePRCpMDZ1XvrgiP
 ztKhTl5C1xhom+giOkVjd/C5/EAjFt99FguUNB/DwObj/ZzCtRubLEGDOxWjw0FZWfbevOIRdM7
 wI+roggFiU4MMxnnt0j8P/ZVjCv77Df44WcsdLx6h8JdU5YgR63LL0M3mKT1+OME5Ueikrm/3fd
 2kRoh3M8hsHYoIXmvkgOIfiODxWawNm1hTBRSc8QRIcqGymYaqcBEr+4bb4KBH
X-Google-Smtp-Source: AGHT+IEoUA3zPkeCOkS0hLm68t/Qgynr0jkXYj6JQx0XXlOAt/wyOOJ+6Mxbeg2Zu378ferW2a25wg==
X-Received: by 2002:a05:600c:314d:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-477c0175164mr177413865e9.3.1764107283846; 
 Tue, 25 Nov 2025 13:48:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add2c98sm9444145e9.5.2025.11.25.13.48.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Misc HW patches for 2025-11-25
Date: Tue, 25 Nov 2025 22:47:52 +0100
Message-ID: <20251125214802.1929-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

The following changes since commit a8d023be622cab21e90bca8d9618068f0e49b74b:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-11-25 10:25:16 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251125

for you to fetch changes up to 57756aa01fe52c50d655929c43d9a80f8214cf1a:

  hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN (2025-11-25 22:45:30 +0100)

----------------------------------------------------------------
Misc HW patches

Few fixes in hw/; also including qtest and replay fixes.
----------------------------------------------------------------

Cédric Le Goater (1):
  hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN

Markus Armbruster (3):
  hw/usb: Convert to qemu_create() for a better error message
  hw/scsi: Use error_setg_file_open() for a better error message
  hw/virtio: Use error_setg_file_open() for a better error message

Peter Maydell (3):
  qtest: Allow and ignore blank lines in input
  hw/pci: Make msix_init take a uint32_t for nentries
  replay: Improve assert in replay_char_read_all_load()

Peter Xu (1):
  hw/core/machine: Provide a description for aux-ram-share property

Zhao Liu (1):
  docs/deprecated: Remove undeprecated SMP description

 docs/about/deprecated.rst | 14 --------------
 include/hw/pci/msix.h     |  4 ++--
 hw/core/machine.c         |  2 ++
 hw/misc/aspeed_xdma.c     |  2 +-
 hw/pci/msix.c             | 10 ++++++++--
 hw/rtc/aspeed_rtc.c       |  2 +-
 hw/scsi/vhost-scsi.c      |  3 +--
 hw/sd/aspeed_sdhci.c      |  2 +-
 hw/usb/bus.c              |  5 ++---
 hw/virtio/vhost-vsock.c   |  3 +--
 replay/replay-char.c      |  2 +-
 system/qtest.c            |  9 ++++++++-
 12 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.51.0


