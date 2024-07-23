Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8260C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMHo-00038Z-O2; Tue, 23 Jul 2024 16:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHn-00037X-8q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHl-0003uK-99
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso2071024f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767139; x=1722371939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gpuGBmqnlaRNfBWCS73HM7FOM24QF/0y1loxuYQmhT8=;
 b=thgYyj/HyJglllcyUWB2kXoWF0+6xmrEQXWVwWluXUdiEv9fKQmf2iGvJacSWW4S7W
 0cmqlcrLqKB75d0vtXf+lxNMAxb785gUfUoLo1Dgt8XGiKa7y2hfoCnUud5HF7WzKHmD
 NErH9CENLZsi5D1+wWEanRxNiW5VGyut6KmrdG/W+cmNPtysFUQpsRkqy0aur6ZtUGyo
 csPfHqHB4PaMMozouhsh9fjRCp9Q0dg5A+eweVx++zvWL3sbjEDz1zzixWgm/wJNegfn
 XYdl+W1IM3cb0iBiv/Czj7iiAgiuSQsFpA8SiNyz/MMM0sp5NijsM/0lzUg2JI9/BAgg
 NjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767139; x=1722371939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpuGBmqnlaRNfBWCS73HM7FOM24QF/0y1loxuYQmhT8=;
 b=v5JrIxYdlmay0WOfbYXGJYXPMmwMWRlKowN9jzrU2CNwXlOLbP/WsOM/CZHON6A6iI
 hh3rxoJTu/brPFKN1vgjjm5Qix4zhDXQcmus/MoXHP+W7+1OhO1xYneTmRdhY+4Om9hd
 td6eBf3YPn2gAW6X1ncyZGvsCcO/plsNjwXPgjeyTuzd05hCbwAlnqSOB99vSlTUb4hb
 uyvTo/0+d7KZ4N3fPztCblVH6KEa4slsaAhnLezp1mkB50J8BmeTVU8elNrF/K5yS4O0
 doXcBvvMD5EoQJIlD1IJXimZJGkJEuJ705tQMYcqPcMZMijbfQYelkaTpGjLceaMx+wj
 xHMA==
X-Gm-Message-State: AOJu0Yzl/PXiDX/OwMjZ9Wvc1a40ctL2v34YgnRGfyk8V3YQ2N9TwGfI
 C9DV2I4dtO5xpZzvHWbMBbBvcMpeOnTD+LbNXg//eBJtrw7EeUyqwyPNqplJq0shVXa3MN2E3wm
 ZnCY=
X-Google-Smtp-Source: AGHT+IFdzAEDndG0qklvW/rulabgYHoMszbDvzAouDC65eHrFPciPg8O4Czoz7XRaiEG7Kv0+UXqDA==
X-Received: by 2002:adf:ffc3:0:b0:367:9988:84a0 with SMTP id
 ffacd0b85a97d-369f5b9ebc7mr17456f8f.58.1721767138935; 
 Tue, 23 Jul 2024 13:38:58 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ba9asm12456171f8f.41.2024.07.23.13.38.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:38:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/28] Misc HW+ patches for 2024-07-23
Date: Tue, 23 Jul 2024 22:38:27 +0200
Message-ID: <20240723203855.65033-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The following changes since commit 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-07-23 15:23:05 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240723

for you to fetch changes up to e4a44f94db11fcf873399c60ebb1d93a9ad1cd6e:

  MAINTAINERS: Add myself as a reviewer of machine core (2024-07-23 22:34:54 +0200)

Ignored unrelated error:

    TEST    signals on ppc64
  signals: allocatestack.c:223: allocate_stack: Assertion `powerof2 (pagesize_m1 + 1)' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  timeout: the monitored command dumped core
  Aborted
  make[1]: *** [Makefile:175: run-signals] Error 134
  make: *** [/builds/philmd/qemu/tests/Makefile.include:56: run-tcg-tests-ppc64-linux-user] Error 2

----------------------------------------------------------------
Misc HW patch queue

- Restrict probe_access*() functions to TCG (Phil)
- Extract do_invalidate_device_tlb from vtd_process_device_iotlb_desc (Clément)
- Fixes in Loongson IPI model (Bibo & Phil)
- Make docs/interop/firmware.json compatible with qapi-gen.py script (Thomas)
- Correct MPC I2C MMIO region size (Zoltan)
- Remove useless cast in Loongson3 Virt machine (Yao)
- Various uses of range overlap API (Yao)
- Use ERRP_GUARD macro in nubus_virtio_mmio_realize (Zhao)
- Use DMA memory API in Goldfish UART model (Phil)
- Expose fifo8_pop_buf and introduce fifo8_drop (Phil)
- MAINTAINERS updates (Zhao, Phil)

----------------------------------------------------------------

BALATON Zoltan (1):
  hw/i2c/mpc_i2c: Fix mmio region size

Bibo Mao (1):
  hw/intc/loongson_ipi: Access memory in little endian

Clément Mathieu--Drif (1):
  hw/i386/intel_iommu: Extract device IOTLB invalidation logic

Philippe Mathieu-Daudé (13):
  accel: Restrict probe_access*() functions to TCG
  hw/intc/loongson_ipi: Fix resource leak
  hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
  docs: Correct Loongarch -> LoongArch
  hw/char/goldfish: Use DMA memory API
  chardev/char-fe: Document returned value on error
  util/fifo8: Fix style
  util/fifo8: Use fifo8_reset() in fifo8_create()
  util/fifo8: Rename fifo8_peek_buf() -> fifo8_peek_bufptr()
  util/fifo8: Rename fifo8_pop_buf() -> fifo8_pop_bufptr()
  util/fifo8: Expose fifo8_pop_buf()
  util/fifo8: Introduce fifo8_drop()
  MAINTAINERS: Cover guest-agent in QAPI schema

Thomas Weißschuh (3):
  docs/interop/firmware.json: add new enum FirmwareFormat
  docs/interop/firmware.json: add new enum FirmwareArchitecture
  docs/interop/firmware.json: convert "Example" section

Yao Xingtao (7):
  hw/mips/loongson3_virt: remove useless type cast
  util/range: Make ranges_overlap() return bool
  cxl/mailbox: make range overlap check more readable
  sparc/ldst_helper: make range overlap check more readable
  system/memory_mapping: make range overlap check more readable
  crypto/block-luks: make range overlap check more readable
  dump: make range overlap check more readable

Zhao Liu (2):
  hw/nubus/virtio-mmio: Fix missing ERRP_GUARD() in realize handler
  MAINTAINERS: Add myself as a reviewer of machine core

 MAINTAINERS                  |  2 ++
 docs/about/emulation.rst     |  2 +-
 docs/interop/firmware.json   | 47 +++++++++++++++++++++++++----
 include/chardev/char-fe.h    |  3 ++
 include/exec/exec-all.h      |  7 ++++-
 include/qemu/fifo8.h         | 57 +++++++++++++++++++++++-------------
 include/qemu/range.h         |  4 +--
 accel/stubs/tcg-stub.c       | 14 ---------
 chardev/msmouse.c            |  2 +-
 crypto/block-luks.c          |  3 +-
 dump/dump.c                  | 12 +++++---
 hw/char/goldfish_tty.c       | 12 ++++----
 hw/cxl/cxl-mailbox-utils.c   |  8 ++---
 hw/i2c/mpc_i2c.c             |  8 ++---
 hw/i386/intel_iommu.c        | 57 +++++++++++++++++++++---------------
 hw/intc/loongson_ipi.c       | 40 ++++++++++++-------------
 hw/mips/loongson3_virt.c     |  4 +--
 hw/net/allwinner_emac.c      |  2 +-
 hw/nubus/nubus-virtio-mmio.c |  2 ++
 hw/rtc/ls7a_rtc.c            |  2 +-
 hw/scsi/esp.c                | 38 +++---------------------
 system/memory_mapping.c      |  4 +--
 target/sparc/ldst_helper.c   |  5 ++--
 ui/console-vc.c              |  2 +-
 ui/gtk.c                     |  2 +-
 util/fifo8.c                 | 48 +++++++++++++++++++++++++-----
 26 files changed, 226 insertions(+), 161 deletions(-)

-- 
2.41.0


