Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEFCED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQwv-00086l-RI; Tue, 18 Nov 2025 14:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQwp-00086W-Jf
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQwl-0005zC-Ky
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso1203815e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492456; x=1764097256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fm4tyjcS+8Cy0irXcSr4soVTSNXAFzQYmzr/abpLi04=;
 b=uV7yBS8WR/JsHBCplXb6X+cbbdBY45F9kUseWKH2Fk4qMMmqsZzp4DiDULUu4sZgLS
 X4s0TkE8MRNPvCY/Qd29au878fi1BvC2NSxZisRK/cEQRj4CYR0m615okTUwMHy8XPEW
 /+teosaQwq3IIxsAXzYip1GsSsSU1/Kuf5MLbyvrz8xx7MdwkmhpRA6JGGoH8V15hy/X
 nkt921zaYB+MTS+7ehm4+UlNWqmkaPr8VFlR14+GyNfZbVmQUrkg1DxkJhtE0+DjAmKU
 /Xpqv8np5G+Kq9jNfvZZvIX9wm3DJfJVdLZvXOgIzbL7oSsbcCYh+dvwguZLv216Yics
 zwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492456; x=1764097256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fm4tyjcS+8Cy0irXcSr4soVTSNXAFzQYmzr/abpLi04=;
 b=uMaVjX7j4zXlf51W1E6Nw3mrfn8wM3cr319OcxYutXyaPZyqbGKeBv8lRvpfH7nbtr
 fOF3a/hpy6QTxuov6/Sz2sbXyTOyCMfjiVJ0VXA4TpiTacdUIT9s0mjc7T3tof1MI2Xf
 A7Z1wep6K8Tq8HsB5CXSueyGoskPj16M0aoT7x/j38SMJj43prBzIc7OZHfFzH97RBZ+
 MhW9a9ZFbx/yhAF9Q6LjiiXlNVdWa8KWQKT/ZQFyxNRn3gA3Q2AopXeFVNDum+O3HzAl
 ENUJ+vYsze4QZMrsmAI8dOsxlYHkzc2liSnvsyJ9sVQ3Lvzwv1fngHbtKFAI7ULE6cEW
 EODg==
X-Gm-Message-State: AOJu0YwivYtN0QSZhvyev6JfaVgSgCAg24Y9nfPjd+e7oK9lZRsVEzPn
 yjChnOWb2BxM8VmyiHG5+A1N6QvQapZXCGm48+FidKbXets38GeRhINAfYWOwVtIs0FzbFON38U
 rmpmJU7yYTf0z
X-Gm-Gg: ASbGncsenHOqBeHi/GVCUFD8Fn2zwTMk0FhEa8DvwCCU9d2f6JxHtR2Gn+u9IkbF685
 aKezY8F8B1KASgIGzakcVzFcjSKC6mSKAa6BF4VyolVt/+GIMMD+W03I5cnswriSGSw6qcHageZ
 Qfu9+5oD95yLBJKNBwDzeH1OzL9DMxu3A/O41lXquvA2aGFLgCH/mQNJCKoO/u/GYptNjgJP4BB
 Cw5aKD8D2mEycOWwsRqgYA/ynhhPPBuDFIjUCXg6HjWqD6Rd3E4CT3taxm9wdR+Na0WpR8jYlNM
 ISB60mF2DbIc+2IYbph/UTUORCK6Rw4kD4StdZ/IEieRO5OoO4iGYKw/7smQPWv3ehHWem/ZmgH
 CAnpmXTc1YHVrWSCD3oFxWSxadPIdlw9UlFiRtrQYFPWFRIjkwxDGVJTP4s0jJo5+bSV0LzYazz
 2v8ESz6yPW/vHLtK11TChbrBMVfKQaGuKsILf7BciSZEMJQveiReffxpt1bYbl
X-Google-Smtp-Source: AGHT+IF1Lzvq3myo4CY6j8LjKK9CUhXGBzBhrYwIqIPjEsSgYTOswnlG7rX8jN+/a7EB5aMzrMf3HA==
X-Received: by 2002:a05:600c:6094:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-477b0cca7bfmr6259795e9.11.1763492456320; 
 Tue, 18 Nov 2025 11:00:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm34183260f8f.37.2025.11.18.11.00.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:00:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Misc HW patches for 2025-11-18
Date: Tue, 18 Nov 2025 20:00:35 +0100
Message-ID: <20251118190053.39015-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

The following changes since commit 711a1ddf899bef577907a10db77475c8834da52f:

  Merge tag 'pull-10.2-maintainer-171125-2' of https://gitlab.com/stsquad/qemu into staging (2025-11-18 09:18:23 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20251118

for you to fetch changes up to de285aa9076841c618d068f7b838e312fc8b26c6:

  ebpf: Make ebpf_rss_load() return value consistent with @errp (2025-11-18 19:59:36 +0100)

Ignoring following checkpatch error:

  ERROR: line over 90 characters
  #26: FILE: scripts/checkpatch.pl:3205:
  +  ERROR("DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead\n" . $herecurr);

----------------------------------------------------------------
Misc HW patches

- Re-enable xenpvh machine in qemu-system-arm/aarch64 binaries
- Correct Xilinx Zynq DMA Devcfg registers range size
- Correct ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo
- Allow for multiple CHR_EVENT_CLOSED events in QTest framework
- Fix ACMD41 state machine for SD cards in SPI mode
- Avoid confusing address calculation around eMMC RPMB HMAC
- Fix a pair of build failures on Solaris (guest-agent and RDMA migration)
- Correct QOM parent of LASI south bridge
- Clarify MIPS / PPC 32-bit hosts removal in documentation
- Prevent further uses of DEVICE_NATIVE_ENDIAN definition
- Fix Error uses in eBPF
- Update David Hildenbrand's email address
----------------------------------------------------------------

Bin Meng (2):
  hw/sd: Fix incorrect idle state reporting in R1 response for SPI mode
  hw/sd: Fix ACMD41 state machine in SPI mode

Cédric Le Goater (1):
  hw/intc/ioapic: Fix ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo

David Hildenbrand (Red Hat) (1):
  MAINTAINERS: Update David Hildenbrand's email address

Djordje Todorovic (1):
  scripts/checkpatch: Check DEVICE_NATIVE_ENDIAN

Jan Kiszka (1):
  hw/sd/sdcard: Avoid confusing address calculation in rpmb_calc_hmac

Markus Armbruster (3):
  ebpf: Fix stubs to set an error when they return failure
  ebpf: Clean up useless error check in ebpf_rss_set_all()
  ebpf: Make ebpf_rss_load() return value consistent with @errp

Peter Maydell (1):
  system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events

Philippe Mathieu-Daudé (7):
  hw/arm: Re-enable xenpvh machine in qemu-system-arm/aarch64 binaries
  qga/commands: Include proper Solaris header for getloadavg()
  hw/southbridge/lasi: Correct LasiState parent
  buildsys: Remove dead 'mips' entry in supported_cpus[] array
  migration/rdma: Check ntohll() availability with meson
  docs: Correct release of MIPS deprecations / removals
  docs: Mention 32-bit PPC host as removed

Yannick Voßen (1):
  hw/dma/zynq-devcfg: Fix register memory

 MAINTAINERS                     | 18 +++++++++---------
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  7 ++++++-
 meson.build                     |  3 ++-
 include/hw/misc/lasi.h          |  4 ++--
 ebpf/ebpf_rss-stub.c            |  4 +++-
 ebpf/ebpf_rss.c                 | 10 +++-------
 hw/arm/xen-pvh.c                |  2 ++
 hw/dma/xlnx-zynq-devcfg.c       |  2 +-
 hw/intc/ioapic.c                |  4 ++--
 hw/net/virtio-net.c             |  4 +---
 hw/sd/sd.c                      | 33 +++++++++++++++++++--------------
 migration/rdma.c                |  4 +---
 qga/commands-posix.c            |  3 +++
 system/qtest.c                  |  4 ++++
 .mailmap                        |  1 +
 scripts/checkpatch.pl           |  4 ++++
 17 files changed, 64 insertions(+), 45 deletions(-)

-- 
2.51.0


