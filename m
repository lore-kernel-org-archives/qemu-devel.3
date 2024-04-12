Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C1AC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ0-0006xC-II; Fri, 12 Apr 2024 03:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPz-0006wv-Ki
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPx-00074Y-Oe
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3f17c6491so5935845ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907227; x=1713512027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wA/Z0yFKpXqvP59rryTrHQVNqpWGjyyXV79BO4MCFxQ=;
 b=D32tte0eSPrIZcSxBCBbosnCrJRNabn0B4qKipx6jFcb1APh700luBYVohe/HnHmSL
 +2GFpUWzard54aXhiGl5RS7/JUTGQo+X2jX0h51rWeS+PRIvzwClok8ql7byDuBBYLUt
 wcvMjJqqBDAdQ1T+04SjjMK1JFEW59/C6U/4cUCF8Slds792RxfJoVoxIV0HQB8JQ+sg
 M/ilfaS2E9X/tRo0J0XYdDP8xtIiXSbJt7BDfYChYuj9NvdikASwZmxUcr4Z6pqbBeD8
 7gWaXvPYh3Z4CaT7tQr7RMqmcS8450xzvYOmWuhp6SlG/FGX/YJxArJV3ze1hGkmBWS4
 OPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907227; x=1713512027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wA/Z0yFKpXqvP59rryTrHQVNqpWGjyyXV79BO4MCFxQ=;
 b=LcgQTJbNV3bVqlHGjDyF8ae3ofKjQqtDxKL1T+GoE7TGDkEHdLv/hKItskHJZiNwn5
 ezJJjJ+AtcpXL30FeoomjsXpcNhJYV3gIUu3hvNw1JZGNWlFWk164nNlHWxrqdxh8Wl4
 1nL1tT2R9v2pFnAquiVNKe5dREmhg75HuML7ob+9f7ZY0RuUIsBZoBmfjIQLRQrPTlkQ
 9od7oTrecsIsCV5H/vNCfiHb9C0KFyJ60keat6bWa+eujBthPzJ7fIYGr8iEIC6Ko5f2
 5ZJ0bZwj8yGGxS1x7js6jvaOHjyiMH+kqCAwmHgJ4hkEGIwUAfx0N8iCRC/1sobX9DRy
 fI8g==
X-Gm-Message-State: AOJu0Yw7xU7ptWDs1eLCmT9iNzGbunmAlkUDPMsiiBPtEJ5KBPaDDpGH
 uf1uyYCRJU8Io0uHb4cxDmCatVP3f2wdSNPCmceu1PvU55LIRVc9D9NGnd/VdB07AZFreuHpawy
 s
X-Google-Smtp-Source: AGHT+IFRN7a1rypQ1UkNrUDXvfWLhtHfWLnskl+CSt73nhvGOVJ0WTJtjl0SncmP3C9emRgdg3KIuw==
X-Received: by 2002:a17:902:ec85:b0:1e5:559b:fa98 with SMTP id
 x5-20020a170902ec8500b001e5559bfa98mr2065437plg.34.1712907227406; 
 Fri, 12 Apr 2024 00:33:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/27] misc: Replace sprintf
Date: Fri, 12 Apr 2024 00:33:19 -0700
Message-Id: <20240412073346.458116-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Phil,

This incorporates my comments against
    20240411104340.6617-1-philmd@linaro.org
and
    20240411101550.99392-1-philmd@linaro.org

Especially cleanups to hexdup and disas.


r~


Philippe Mathieu-Daudé (13):
  hw/mips/malta: Add re-usable rng_seed_hex_new() method
  system/qtest: Replace sprintf by qemu_hexdump_line
  hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid sprintf
  hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
  hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf
  backends/tpm: Use qemu_hexdump_line to avoid sprintf
  disas/m68k: Replace sprintf() by snprintf()
  disas/microblaze: Replace sprintf() by snprintf()
  linux-user/flatload: Replace sprintf() by snprintf()
  hw/misc/imx: Replace sprintf() by snprintf()
  hw/net/rocker: Replace sprintf() by snprintf()
  hw/riscv/virt: Replace sprintf by g_strdup_printf
  target/arm: Replace sprintf() by snprintf()

Richard Henderson (14):
  util/hexdump: Remove b parameter from qemu_hexdump_line
  util/hexdump: Remove ascii parameter from qemu_hexdump_line
  util/hexdump: Use a GString for qemu_hexdump_line
  util/hexdump: Add unit_len and block_len to qemu_hexdump_line
  util/hexdump: Inline g_string_append_printf "%02x"
  disas/microblaze: Split out print_immval_addr
  target/microblaze: Re-indent print_insn_microblaze
  disas/microblaze: Merge op->name output into each fprintf
  disas/microblaze: Print registers directly with PRIreg
  disas/microblaze: Print immediates directly with PRIimm
  disas/microblaze: Print registers directly with PRIrfsl
  disas/microblaze: Split get_field_special
  disas/riscv: Use GString in format_inst
  target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings

 include/qemu/cutils.h   |  20 +-
 backends/tpm/tpm_util.c |  24 +-
 disas/m68k.c            |   2 +-
 disas/microblaze.c      | 544 +++++++++++++++++-----------------------
 disas/riscv.c           | 209 +++++++--------
 hw/dma/pl330.c          |  23 +-
 hw/ide/atapi.c          |  12 +-
 hw/mips/malta.c         |  25 +-
 hw/misc/imx25_ccm.c     |   2 +-
 hw/misc/imx31_ccm.c     |   2 +-
 hw/misc/imx6_ccm.c      |   4 +-
 hw/misc/imx6_src.c      |   2 +-
 hw/misc/imx6ul_ccm.c    |   4 +-
 hw/misc/imx7_src.c      |   2 +-
 hw/net/imx_fec.c        |   2 +-
 hw/net/rocker/rocker.c  |  24 +-
 hw/riscv/virt.c         |  17 +-
 hw/scsi/scsi-disk.c     |  13 +-
 hw/ssi/imx_spi.c        |   2 +-
 hw/virtio/vhost-vdpa.c  |  14 +-
 linux-user/flatload.c   |   2 +-
 system/qtest.c          |  12 +-
 target/arm/cpu64.c      |   4 +-
 target/i386/kvm/kvm.c   |  12 +-
 util/hexdump.c          |  98 +++++---
 hw/virtio/trace-events  |   2 +-
 26 files changed, 494 insertions(+), 583 deletions(-)

-- 
2.34.1


