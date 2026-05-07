Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AB9CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqWa-0000OS-8n; Thu, 07 May 2026 00:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWZ-0000OC-5F
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:39:47 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWX-0003r1-HH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:39:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aaed195901so2115535ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128784; x=1778733584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L+DnG1TLNJ0YCH8vmDdP9Ttj/IurXBmDSvvxuAlWMC4=;
 b=DfpgDy+5uasrU/4TGa8eezgub38k18teabnJ1mcQfJr9UPxi8uvsK2BG15LpCa5HYJ
 tqKlNYrYG1+8sW3R2XqdwcFJwxResjJ2mOT+Ecp5+vBA1pRHO99VtwxRJcoPnJPx6ryj
 ybtXiasoJwaeWjEJdQTfJuF9tdCDNoIqYiGgbHirmCMNjxfiIm8ZpupU9d79xEu230nK
 KJ/svmRJnAN1NinVAQ80xwZ4mO8FlwDsoafGjfPMCd5zSCJZKjitYYxk095l5GVROJbW
 291LwYuPTVwVmqGRxTd5EKgKQAhr6C3oCyt5jFTWIkJ32Ehd5/eA+ygWQiDzYoemuMc8
 I5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128784; x=1778733584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+DnG1TLNJ0YCH8vmDdP9Ttj/IurXBmDSvvxuAlWMC4=;
 b=QBIT3hQelzPa5ZxbwwhxRs8FB/NR/jw8OF6LaZsDWX8tEaw1RU7XEpHRk1B2pbq6cP
 qJRWTakrO10B18beT9mSdXlsKjWS5YIQS7AkuMuchuKCZpV5M52/ZLeT4YccvPqz+Di6
 YwcHAaC2d9S9sqskhJo3KikNzrEH+VUT/X2geOeC/sHHaEDaIh22h/POrTq6u1BREZw2
 k/IU/+VchBVqFZRs3YTVMt89GOcsMd8mAUDZLqOLB7ProToFdmeLOQskDuq+ge5/yUwJ
 xrQtZg5o/FS/BisvjVC/JorGYUn0ADMvO1nck5xlthokidaLSRTY03OXp1ln1/T7XdwE
 ax0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2WXGHg1PJppRxCpqR00xbvpFxO805/+hqECZH/yUzxsaj42RZlbhn9r9lsss7bs9Dnd8KEznMYSBh@nongnu.org
X-Gm-Message-State: AOJu0YzLWsBPU9W/nMgE550n3nFfJzEtiv3ku6960pf3HlNrJ8oxeuIr
 KKJeEcf7jMCmQ6/4yGMky9ZmWzGyXR7GVrpPSL9Z4GUVd5X3rsblHwPK
X-Gm-Gg: AeBDietmwgdPMOGVrn8iyHmHXK6/7k+JrXOfOPCDIWR1Q6V+tp6Ossn64J8rTOKzvgY
 wbNdAlRLJU5Lao3y5xWGlr8bsnf0m7OHWK1uC1iI/nfmUJ8uNEEZPGw5YiMuDdOmmf0zmTJYf5d
 9LPv5mMjhCSiu8fBa3dvTADv1oCN38CnyQay2IdwD9ja5n9YkybQHfoLgqj+VdY3JutvBhwDV75
 vsOj3zSATcyG5OoWbMcS4DJYK+2wOFyXeb5IvQpPHMo490VWjV42jrP1hnttSpJzpTxmN6bN3wa
 cVaOu8jha/tmAhP/CxjV2HdDM/IKpLfOCDI25xzhnNlaZLzhFCayfMs1BpUFx5WBuvM3HuxzGZP
 VEfvb7BMYEuPHZQ0EC7A+6MOG9x+Awi7z4PXEK6MFXZjf+4rWSUem90ee6fgvD2Ou0bhNJkH7j3
 a/GFUtzq89zlF2tGIKbiUefE7Qr3nr54FU0zNwhDq7oxEgc8CObVPwuw9Gg4aOQRKr61xRl9tCb
 hAJVQJo
X-Received: by 2002:a17:902:bcc2:b0:2b2:5099:2f3e with SMTP id
 d9443c01a7336-2ba78b43e9emr44992705ad.4.1778128782535; 
 Wed, 06 May 2026 21:39:42 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadf1242sm9087045ad.66.2026.05.06.21.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:39:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 0/9] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Thu,  7 May 2026 14:38:28 +1000
Message-ID: <20260507043838.45652-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

I will taking over this series while Joel is away. Many thanks to the
reviewers on v4, here:

https://lore.kernel.org/qemu-devel/20260425131721.932250-1-joel@jms.id.au/T/#mb1ef2824c2f1f37bf4574dc1ef0fb95566c3a2f2

Changes since v4:
- Drop PCI, to rewok with Designware controller in a later patch.
- Drop I2C, the model had significant changes so I will work on
  that independently and we can bring that back in Atlantis later.
- Move the OpenSBI dummy payload hack into tt-atlantis specific code.
- Remove AIA MAINTAINERS entry since it is already covered.
- Update microchip_pfsoc to use new discontig boot_info API.
- Update changelog to explain tt-atlantis machine DTB.

Thanks,
Nick

Joel Stanley (3):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv: Add Tenstorrent Atlantis machine

Nicholas Piggin (6):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  target/riscv: tt-ascalon: Enable Zkr extension
  target/riscv: tt-ascalon: Enable Svadu by removing Svade
  hw/riscv/atlantis: Provide a simple halting payload
  tests/functional/riscv64: Add tt-atlantis tests

 MAINTAINERS                                  |  11 +
 docs/system/riscv/tt_atlantis.rst            |  32 +
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/Kconfig                             |  10 +
 hw/riscv/aia.c                               |  93 +++
 hw/riscv/aia.h                               |  25 +
 hw/riscv/boot.c                              |  34 +-
 hw/riscv/meson.build                         |   3 +-
 hw/riscv/microchip_pfsoc.c                   |   8 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   6 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 583 +++++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  27 +-
 hw/riscv/virt.c                              |  96 +--
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 include/hw/riscv/boot.h                      |  12 +-
 include/hw/riscv/tt_atlantis.h               |  51 ++
 include/hw/riscv/virt.h                      |   2 +-
 roms/seabios-hppa                            |   2 +-
 target/riscv/cpu.c                           |   2 +-
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  57 ++
 25 files changed, 975 insertions(+), 109 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.53.0


