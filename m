Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95E0E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCO-0002EP-6S; Thu, 09 Jan 2025 12:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCJ-0002Dd-GB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCH-0000aA-En
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso945260f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443190; x=1737047990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0I0D9vIhTVdttaDbJCf9g1ChnLoybrKEbFzaI+YkUWY=;
 b=DWvPjQkQyEkGhJzx5Ao+Q6U96FRep4ixaJ2IGB2yodSz7IcQpCukk8+eUlLbg5Osbd
 bILm3D6cGF7GcCRFaGurI9Qs3Ic/ZNjUSR7WK45PDenGiNQG0J4oNB8YezUU1LoVRfhu
 vHbaFLBLSrGO5FEMzxAhYxZd1vxE9Uj/TkrzokvrQsuQqMXs68nYm8wBu+EVZDvtoSNs
 nerJ6b7MBp4bqVCcWntasVGU5OT3jNBy1726zMJkrcwe05zxH+9XwmY7q7WzKv6EeQP0
 hrUM1w2LJNkh+8Omad+XFERSr13i/8zQ670ZfSYAkEo12so/Na/WYxE8QgunXJ6hgtDV
 GoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443190; x=1737047990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0I0D9vIhTVdttaDbJCf9g1ChnLoybrKEbFzaI+YkUWY=;
 b=GozNlS8cEuMKVj6MqOdGYBlkzaVAA6Pk4tmna7b5C0OBWtlVgwbU7juCvCw58dNuqq
 Xay9mvXmd06tBuN9Chne8agSCqFMzyn9+TvjAK98OvHGCZKkkhDw++wpDpJayxMUEMWI
 zkgyfgk6xbF3w3yCWAhnD8ipCLg7/Pa0NbX0LVxOjruTqzyvvjgm6y/51yKXYfqdYJxF
 /k5HWBkjtz5AaQh534cJzDsz90kmePaKoFvoLhHDjfllbGLDTbig7Ippk6fMI9le4G0G
 T7Zocmp2TPfV2twqGiJU4/BTX3hIb4ZcbVws6s4grqElvCZekfuNbbSuqrqsoMjciqqz
 1j4Q==
X-Gm-Message-State: AOJu0YzmGSqJ6FXh+goa+AWXv6z5B8SdgGD18e7Ibucjo23Fu9CW+F+S
 PiMijMoBermXwmfdNxpQsYxFesk5nRjhs6H5VKBhHyq13pk6QAoj2rEhRKIKYjgdmr7ApourRFQ
 qwcc=
X-Gm-Gg: ASbGncse5c6Bgz74ihiVXHPdSOUVtriqjhxOlVozub2CHQ94C7OxhnGo+5UjSWW03mZ
 0J7mWdSbI/2GftHQ91a5ye0krkSCMhjzVTvb6tIVFxdAkUQexjaZcg+UqCXKHUTffVd4jyiPj/L
 ZTrcpajuIh+7siCrWf2m1OiOjLydY7tfJ6HjsUiehCZui3FugHU8u2PZRhwrD0mXZnDfMZgBJL1
 advMeP1YC0KORmmywF4jXkHmKPHgU62CZ3RHy+cD74t1MHsZyALMIjKRO9Z4vJGtoW0gST7qA+s
 nYYfbWvg4txHQ9EnW8QdKpHaRzYVVQ29Y6eK
X-Google-Smtp-Source: AGHT+IHW48fcnRI/sJxYuquHpB4CbxinQ2/SyFkEVQ3Ob7UaCFIt4zEwaKb69rRoYInkOu0l6UIlVw==
X-Received: by 2002:adf:ab04:0:b0:38a:88f8:aadd with SMTP id
 ffacd0b85a97d-38a88f8ad2emr5778091f8f.53.1736443190427; 
 Thu, 09 Jan 2025 09:19:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1dc6sm2332972f8f.96.2025.01.09.09.19.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:19:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/11] QOM / QDev patches for 2025-01-09
Date: Thu,  9 Jan 2025 18:19:37 +0100
Message-ID: <20250109171948.31092-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The following changes since commit 3f8bcbba3b320c610689576fc47595f1076198dd:

  Merge tag 'pull-request-2025-01-08' of https://gitlab.com/thuth/qemu into staging (2025-01-08 11:38:21 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/qom-qdev-20250109

for you to fetch changes up to 5f396935f8f1628005ef14a3c4c3dc84c6aa3d96:

  system: Inline machine_containers[] in qemu_create_machine_containers() (2025-01-09 18:16:27 +0100)

----------------------------------------------------------------
QOM & QDev patches

- Remove DeviceState::opts (Akihiko)
- Replace container_get by machine/object_get_container (Peter)
- Remove InterfaceInfo::concrete_class field (Paolo)
- Reduce machine_containers[] scope (Philippe)

----------------------------------------------------------------

Akihiko Odaki (2):
  hw/pci: Use -1 as the default value for rombar
  qdev: Remove opts member

Paolo Bonzini (1):
  qom: remove unused InterfaceInfo::concrete_class field

Peter Xu (6):
  qdev: Make qdev_get_machine() not use container_get()
  qdev: Add machine_get_container()
  qdev: Use machine_get_container()
  qom: Add object_get_container()
  qom: Use object_get_container()
  qom: Remove container_get()

Philippe Mathieu-Daudé (2):
  qdev: Implement qdev_create_fake_machine() for user emulation
  system: Inline machine_containers[] in
    qemu_create_machine_containers()

 include/hw/pci/pci_device.h |  2 +-
 include/hw/qdev-core.h      | 24 ++++++++++++++++++++----
 include/qom/object.h        | 26 ++++++++++++++------------
 accel/tcg/tcg-all.c         |  8 +++++++-
 backends/cryptodev.c        |  4 ++--
 chardev/char.c              |  2 +-
 hw/core/gpio.c              |  3 +--
 hw/core/qdev-user.c         | 19 +++++++++++++++++++
 hw/core/qdev.c              | 22 ++++++++++++++++++----
 hw/core/sysbus.c            |  4 ++--
 hw/i386/pc.c                |  4 ++--
 hw/pci/pci.c                |  2 +-
 hw/vfio/pci.c               |  5 ++---
 qom/container.c             | 23 -----------------------
 qom/object.c                | 13 +++++++++++--
 scsi/pr-manager.c           |  4 ++--
 system/ioport.c             |  2 +-
 system/memory.c             |  2 +-
 system/qdev-monitor.c       | 18 ++++++++++--------
 system/vl.c                 | 19 ++++++++-----------
 ui/console.c                |  2 +-
 ui/dbus-chardev.c           |  2 +-
 hw/core/meson.build         |  1 +
 23 files changed, 126 insertions(+), 85 deletions(-)
 create mode 100644 hw/core/qdev-user.c

-- 
2.47.1


