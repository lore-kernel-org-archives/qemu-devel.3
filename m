Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F55C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 23:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnlXI-0003kA-5G; Sat, 25 Jul 2026 19:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlX3-0003h3-00
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:49 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlWz-0005ix-L5
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:47 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5c2ae02f69eso1027592e0c.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785021104; x=1785625904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w2ZMmkRhdQd7wygfGjNjQl2Q7y//RixNLAYn7fQ+oYA=;
 b=E0fJjLz6U+o/JR2RFnxakw1uZEHuA1ErBz78X7NJ9oI1mnjPvNr18M5VsNevXwduKF
 rdXgPbU7UMlkg8CKQCzacF1lIKVDZe1IzKtYa7kyLj2nkT4pj9Dr2dE80gBbB3LCN16V
 txZmRAUErbkMx1I5IX1e+TwMEVHintHSMHeBryyjc1YtUwBaFV9vdK19rWks2ilSQmhF
 jRsLVm2s2uVhgFftp28+9nE5yaKlOQzycM4iSUZeZfu+WfFwpHONOOOvUxCYD8MgZV89
 LrRPlDqjDBcuC0n6bn1huZpu5WUBzhQ/+3v57mY2AYEjkWsdNdacg7pHoccAMUA8yJQ/
 FBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785021104; x=1785625904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2ZMmkRhdQd7wygfGjNjQl2Q7y//RixNLAYn7fQ+oYA=;
 b=V+Zc07zvuAKYY2NsIMJxhu80DWBSa4lYdLsbZbuNq/XhTayjuFYEC3seTzt8P08At7
 advU3rUzto3XXucvyqpFPGhKpTAn/A7ZHX/4KdAuReXJcB5I479ZC6fAUqie2MaBmJ7v
 FI66ru/tIWu+ipv/jeTgtbMtYatKZEVAnBlR5FROgU7ThpKqdbDp9dDcfh7GLHFcgyPX
 8vldBow32hlZm/RUjfLniJi5OwRnycM3fA4yNKhHJFhFgqEDAwiGMnAG2G8szh1FIj9n
 nJr3E5NiTbYqOJKS3bVB/QTsmHBlIyrxFvlYZrAi4enWKHfsc+cM39BBZoXFV22ht2wa
 2X3w==
X-Gm-Message-State: AOJu0Yy2OnpazzxBjdc99XwxLCo4FJe7SfbwRzPZXLbjInOAsPrgCxvL
 fv2dj4EhoJM322c32TB3QpcakgUVkT880brDLSQRMBPmZWKU4k7MoU3eCUIm1A==
X-Gm-Gg: AR+sD11sS5dY5c7k2ZapOlDb2wO1Po+t1+AEK37qPdjaLueMTbGl7+nWKq1SQFUFw87
 lhhWHLwCbydDF2uCprxxf3IKF4J8WGdf6pjElSdJmS8urdy2a5OiEm/lF8LZ/ZJhcYTlUFm01EQ
 L2WRBny15WzroG3CsnSc/2og3XeCgAoiCxtipGIQPbTGFAjqALRUNud7Sp6FUzDNDs36sWD8ddP
 G2cQxvdfK48Aw7EECa+YfiFHYIBwk4OBa9abBR7Rzr6JSokoR3lyRjQ2cmkn1LuNvoX9Km/jXNB
 Zw8bE8W2opI8pHduZ+70LGvV3AvP1W/+XKAc+nmxyOgDI9+xSqVSJgZe7yfCf+szZPf19Zf3qfG
 ohmySC0+yFRrp/dd34NnPpr8njHmagmdgdzJMhnd7tFYsEfYC0iVHQgfAninNXKlnM+W+fQWJm+
 TkqaeVQhJ7mk/wvazneEV+1q/o35kmnTS0
X-Received: by 2002:a05:6122:3a12:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-5c306c8f990mr1749847e0c.8.1785021104312; 
 Sat, 25 Jul 2026 16:11:44 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c30549516csm2907015e0c.6.2026.07.25.16.11.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jul 2026 16:11:43 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>, Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 0/2] hw/arm/raspi4b: fix watchdog and GENET bugs hit by modern
 distro kernels
Date: Sat, 25 Jul 2026 19:11:40 -0400
Message-ID: <20260725231142.61663-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Follow-up to "hw/arm/bcm2838_pcie: make PCI device enumeration actually
work" [1]. That series (plus the GENET/RNG200/thermal work before it)
got a real Raspberry Pi 4 SoC far enough to boot official, unmodified
Raspberry Pi OS releases end to end under raspi4b -- not just the
functional-test suite's minimal 2019-era kernel+initrd. Doing that
surfaced two further bugs that only show up with a modern distro's
systemd actually driving the hardware, both on paths the existing
tests don't exercise:

1. hw/misc/bcm2835_powermgt: the RSTC register's write-config bits
   (0x30) being set to the "full reset" value (0x20) does not mean
   "reset now" on real hardware -- it arms the watchdog so a reset
   happens only if the WDOG countdown register is not refreshed
   before it expires. QEMU's model treated any such RSTC write as an
   immediate reset. This is dormant on lighter userspace, but
   Debian 13/Trixie's systemd (257) writes to RSTC during routine
   early-boot watchdog probing, causing an immediate spurious reset a
   few seconds into boot. Combined with -no-reboot this looks exactly
   like a QEMU crash from the outside: clean exit, no panic, no guest
   reboot message, the last log line being the RSTC/WDOG write itself.
   Fixed by actually implementing the watchdog as a QEMUTimer that
   only fires -- and only then requests a reset/shutdown -- after the
   real timeout computed from the WDOG register.

2. hw/net/bcm2838_genet: three related per-ring DMA bugs. RDMA_CTRL
   writes never updated any per-ring status at all (only TDMA_CTRL
   updated a single overall DISABLED bit); enabling a ring didn't
   flush packets queued while it was disabled; and the RX fallback
   path hardcoded the last/default ring with no check that it was
   actually active. Bullseye and Bookworm's kernels default to that
   last ring, so this was invisible with them, but Trixie's 6.18
   kernel actively uses rings 0-4 and never enables the default ring,
   so every unfiltered packet was silently dropped -- no DHCP lease,
   no usable networking. Fixed by tracking a real per-ring enable
   bitmask for both directions, flushing queued packets when a ring
   is enabled, and falling back to scanning for the first actually-
   active ring instead of assuming the last one.

Testing: rather than only the functional-test kernel, I booted three
official Raspberry Pi OS Lite arm64 releases end to end against the
patched raspi4b machine -- Bullseye (5.15.61-v8+), Bookworm
(6.12.25+rpt-rpi-v8), and Trixie (6.18.34+rpt-rpi-v8) -- each with a
clean boot (no crash/reboot loop), a DHCP lease obtained over GENET,
working SSH login, and an error log containing nothing beyond the
expected "hardware QEMU doesn't emulate" noise (VideoCore/VCHI,
camera/codec/audio probes, GPIO regulators, Bluetooth UART, EEPROM
check) on all three. Before patch 1, Trixie reset within seconds of
boot; before patch 2, Trixie booted but never got a network address.
Bullseye and Bookworm were unaffected either way, which is exactly
why these bugs went unnoticed until a newer kernel exercised these
specific paths.

I did not add a functional test for either fix: reliably triggering
them needs a real systemd doing real early-boot watchdog/network
setup, which the existing test kernel/initrd (a minimal 2019 busybox
environment) doesn't exercise, and downloading a full modern distro
image isn't practical for the functional-test asset infrastructure.
Happy to take suggestions on a lighter-weight way to cover this if
one exists.

checkpatch.pl is clean (0 errors, 0 warnings) on both patches, and the
series builds standalone from a clean worktree
(--target-list=aarch64-softmmu).

[1] https://patchwork.kernel.org/project/qemu-devel/cover/20260725124231.86233-1-marcelomanzo@gmail.com/

Marcelo Manzo (2):
  hw/misc/bcm2835_powermgt: implement a real watchdog timer
  hw/net/bcm2838_genet: fix per-ring DMA status and RX ring selection

 hw/misc/bcm2835_powermgt.c         | 49 +++++++++++++++++++++++-------
 hw/net/bcm2838_genet.c             | 24 +++++++++++++--
 include/hw/misc/bcm2835_powermgt.h |  2 ++
 include/hw/net/bcm2838_genet.h     |  2 ++
 4 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.47.1


