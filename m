Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47AC6369E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuImU-0003Yq-5t; Sun, 22 Feb 2026 18:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImS-0003YV-3t
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImQ-00012M-80
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so29557185e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802544; x=1772407344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PT3NNfOMz/egDkpuwDqhNWih1n9TownqkAXdEwQEl64=;
 b=CZdnFicpuAG4j14pMCEeL86lU//6If1bCd2qJaKmfwQ/7Jl4EehHUFQ/CTJStdsBWn
 GdwRXk1QIeIuFbJUOslvMpheijg8GVXaFkYEwS85Yh7pIzEJkGQlh6S0Yo9swX4+3WBF
 YNqPAG8xnsFcp9w/JWqa7wKhbMrCgpUCtTvKTb0yx0F2aK7mH8dqKYFyF2jT49WMunZx
 +d7Zk7iW35JRbE624ecMazBasSxV5v+8WWYsZgR57mPbYodIgSIYCahmdZbf3VgwWR7t
 CahTjE19wKc8acRRuLtIrZzAggYiTke3EckPu7qyyEETlRBEIIvGn8rMoIJTsdvjNMq6
 MPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802544; x=1772407344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PT3NNfOMz/egDkpuwDqhNWih1n9TownqkAXdEwQEl64=;
 b=xTqdFTfD6uzkiyHrY/1S8dfVrb1o/D4/zuTKiCLhDUfUh6fRHZnvK7Qd0hiV22I9+R
 fs0rHi3FJOzgxcOpDJPqT1VMyHpBgINwwkR0M1nTwcfh+kaZRz67WrVVUA2/CNlDvAc3
 dguCzsAreKDrUWcZ3POCBvXnYUKQE7Kr5NvVvSUMFC3R281gWc8WSF7ze4bFKJ1x//r7
 UFlGgxDy7ic2ZAhUJSR37Fo/4K8uItPi4pQGqBS+etFPN5EZlz5NX30eDxI3PksoMHvL
 J4kVoL9sWdIhpVHrRJF3HgThe/GMvUKH/1lXSGb71OXbgEf2jyFc4jAwVpRf3a145BDY
 V54A==
X-Gm-Message-State: AOJu0Yy4KeZsHePcIq76bZ1pZ1Wq637NTG6qTstN4Nt4FgdmKDKdeAT3
 U5zmlx73m9nes5jbxL8vM25avLjn67dkiK2v1n8mFB/RM9VIkItsds4Tefkd5fxHGKOcDdTGIpx
 4BWeMVk4=
X-Gm-Gg: AZuq6aJzgLm3Y7/aV0evD+lEZv7AcT3xtXJaaiXpMEJ5HEx70qjmtn1QyXx/H8aH5H2
 lbGLJYIYwPR3SKnPuItNXukJ+RcZPdcM7DxW7cyvzKNtc02uLKfp00qixg+LoNY1CgPlfpZ60/J
 lFoyBvIL5S4+cTb/n1q3IsFipIbRHjmrQu/Kjg9LKsiRmK5W8ec7VRIJLrw24zwaQ5i13iysjnf
 tR2MWkABJRa4xdUKlMZEBCF78nedKK44m4j++aKuo23cm75pnCqBECBU38hdEkFJfHO/EpVYSCR
 Lxew4SSyhrBqkZrQ4VroKF3ihWkbZRvYuGCH6ghEce67uuLmdQ0fS8y5Z7CiergJ8YvuJ5AI3mD
 zruur1hjqj6BvuZM4sO8dytLciJEXf9lXde++MxRFY+kntJf5YigBmRE9Up/5uj8qsXu/udZ+VI
 4jfcN/b8qeAMlC0KxxhY+t6CFijNbDF5SUG3x1oLZADt/BPkF0AYfBhkQK6SRzOBPhFratp4Fze
 Q4slnaFwdo=
X-Received: by 2002:a05:600c:8b73:b0:483:7ea3:3de3 with SMTP id
 5b1f17b1804b1-483a949236dmr100856285e9.2.1771802543970; 
 Sun, 22 Feb 2026 15:22:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b66932sm162331125e9.1.2026.02.22.15.22.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/21] Misc HW patches for 2026-02-22
Date: Mon, 23 Feb 2026 00:22:16 +0100
Message-ID: <20260222232222.7183-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:

  Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260223

for you to fetch changes up to 7de8587b5317f0bb5f839e2f55855d6c9ee62835:

  net: mark struct tcp_header as QEMU_PACKED (2026-02-23 00:17:35 +0100)

----------------------------------------------------------------
Misc HW & Net patches

- Fix trace event name in m68k system controller
- Constify and rename virtio_is_big_endian()
- Fix heap buffer overflow in virtio-serial-bus
- Set graphic display dimensions generically (removing system/globals-target.c)
- Mark eth_header, udp_header, tcp_header as packed structures
- Minor doc / header cleanups
----------------------------------------------------------------

Alex Bennée (2):
  hw/alpha: remove unused includes
  hw/core/cpu: expand cpu_reset function docs

BALATON Zoltan (1):
  hw/net/rtl8139: Remove ineffective parameter

Kuan-Wei Chiu (1):
  hw/misc/virt_ctrl: Fix incorrect trace event in read operation

Peter Maydell (5):
  hw/net/rocker: Don't keep pointer to h_proto as uint16_t* in
    OfDpaFlowPktFields
  hw/net/rocker: Don't assume h_proto is aligned in eth_strip_vlan_ex()
  net: mark struct eth_header as QEMU_PACKED
  net: mark struct udp_header as QEMU_PACKED
  net: mark struct tcp_header as QEMU_PACKED

Philippe Mathieu-Daudé (10):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/char/virtio-serial-bus: Fix Heap-buffer-overflow in set_config()
  hw/display/macfb: Constify macfb_sense_table[] array
  hw/display/macfb: Constify macfb_mode_table[] array
  hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
  hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
  hw/m68k: Set graphic display dimensions generically
  hw/sparc: Set graphic display dimensions generically
  hw/ppc: Set graphic display dimensions generically
  system/globals: Build as common code

Pierrick Bouvier (2):
  hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
  hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header

 include/hw/core/cpu.h             |  3 +++
 include/hw/display/macfb.h        |  2 +-
 include/hw/ppc/spapr.h            |  8 +-------
 include/hw/ppc/spapr_common.h     | 17 +++++++++++++++++
 include/hw/virtio/virtio-access.h |  2 +-
 include/hw/virtio/virtio.h        |  2 +-
 include/net/eth.h                 |  6 +++---
 hw/alpha/dp264.c                  |  2 --
 hw/char/virtio-serial-bus.c       |  4 ----
 hw/display/macfb.c                | 18 +++++++++++-------
 hw/m68k/q800.c                    | 17 ++++++-----------
 hw/misc/virt_ctrl.c               |  2 +-
 hw/net/rocker/rocker_of_dpa.c     | 19 ++++++++++++-------
 hw/net/rtl8139.c                  | 24 ++++++++----------------
 hw/net/virtio-net.c               |  4 ++--
 hw/ppc/mac_newworld.c             |  9 +++++++++
 hw/ppc/mac_oldworld.c             |  9 +++++++++
 hw/ppc/prep.c                     |  9 +++++++++
 hw/ppc/spapr.c                    |  9 +++++++++
 hw/sparc/sun4m.c                  |  9 +++++++++
 hw/sparc64/sun4u.c                | 10 ++++++++++
 hw/virtio/vhost.c                 |  4 ++--
 hw/virtio/virtio-pci.c            |  8 ++++----
 net/eth.c                         |  6 +++---
 system/globals-target.c           | 24 ------------------------
 system/globals.c                  |  3 +++
 system/meson.build                |  1 -
 27 files changed, 134 insertions(+), 97 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h
 delete mode 100644 system/globals-target.c

-- 
2.52.0


