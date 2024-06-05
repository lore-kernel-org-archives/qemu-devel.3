Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD00EC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExym-0000b2-Rm; Wed, 05 Jun 2024 17:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyl-0000aV-4I
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyf-0003NO-Oj
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-703f1e39c07so220025b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622123; x=1718226923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZthNw9PbI9iYokm2I4LRNqBbCs0cLjGdyhLxcIkkPF0=;
 b=R5anOzxJlL473dbHshMx+QWJt6TWSrGOnwj1D9YJEKo+xfCC0XEt49ZQ1XOzcxOHNe
 zGEjdrtHpz3YSTqj46gtmCbdoK05rEXqvJRLm6yvqcY0Y4ftOtSLW8dLeTtJ8FKl+pl3
 1PgC7dUTEGdigwPwIEHP0LqUJwhuVNRxGXG+QdtkTSfEMeB5iPKxpif33Qucsu0oW4dZ
 iWqXY3wwbD8hdfh/lUMCiNzxKIj42PZhE5Lij3YX2bWiuZp5SeOzo3pdxWGx61zCiBu7
 Z090qVwCcpWI8y5r6OKDGBLO8reqVphwD+6I92Lgp+mR4yfWJpMS0Z7OCGwG+w1CIEpO
 THow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622123; x=1718226923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZthNw9PbI9iYokm2I4LRNqBbCs0cLjGdyhLxcIkkPF0=;
 b=jHjLqgLsCQ4tM2YSX6pE4Mmtcd3cgQNP6ODOJTIlSomc+HU9z0/BzOFvvkktEVtAM2
 mQNptRPQh+zm6711tTjzR05JKMq9Q0MvYbxNtJIENDjV7625Wqownz9htCijnutZZONr
 IGWZ7IvR27Cm2MqxdqsH9A/y6eBE8hwLCXu7oh/KJVZqjVx7HqSAQbEpmiXuuPWWCFVj
 JhaZmK2aZMCfjByUq7nHM96eSREJoeQYpobmalhxyXpuArum+vQj3u6qZDyrsiS+NtgA
 ZYWpbCkS6jDeOiyGKr2QiA5oZtB0RyoVf+rRk0jKDrY2bcKKhAeqsGS8zkU7Uf2p6mBL
 qJdg==
X-Gm-Message-State: AOJu0Yw64h3vtaKT4RVg5iUkb8lckG1SbP8jg4H9D8mAQHrvNAjRK3Py
 Wm/zKJTWW7lELcVu1wr1ad+CvjPZgDjMYrrS7cOLPR7nK9BvadYhueLBQCZnI8U34mHbRLjSNlS
 B
X-Google-Smtp-Source: AGHT+IGJjwU+JCGd3+wcF9Zo+XTybU7HSt5hAtjujrNNalXDCDwFJXGnw5duwcpHEw5GVbcTvHMSSA==
X-Received: by 2002:a05:6a20:3218:b0:1af:fcbf:df28 with SMTP id
 adf61e73a8af0-1b2b712f4d4mr3912331637.41.1717622122729; 
 Wed, 05 Jun 2024 14:15:22 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] sprintf fixes
Date: Wed,  5 Jun 2024 14:15:05 -0700
Message-Id: <20240605211521.577094-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit f1572ab94738bd5787b7badcd4bd93a3657f0680:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-06-05 07:45:23 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240605

for you to fetch changes up to b89fb575fd467ed5dfde4608d51c47c2aa427f30:

  disas/riscv: Use GString in format_inst (2024-06-05 12:29:54 -0700)

----------------------------------------------------------------
util/hexdump: Use a GString for qemu_hexdump_line.
system/qtest: Replace sprintf by qemu_hexdump_line
hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid sprintf
hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf
disas/microblaze: Reorg to avoid intermediate sprintf
disas/riscv: Use GString in format_inst

----------------------------------------------------------------
Philippe Mathieu-Daudé (5):
      hw/mips/malta: Add re-usable rng_seed_hex_new() method
      system/qtest: Replace sprintf by qemu_hexdump_line
      hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid sprintf
      hw/ide/atapi: Use qemu_hexdump_line to avoid sprintf
      hw/dma/pl330: Use qemu_hexdump_line to avoid sprintf

Richard Henderson (11):
      util/hexdump: Use a GString for qemu_hexdump_line
      util/hexdump: Add unit_len and block_len to qemu_hexdump_line
      util/hexdump: Inline g_string_append_printf "%02x"
      disas/microblaze: Split out print_immval_addr
      disas/microblaze: Re-indent print_insn_microblaze
      disas/microblaze: Merge op->name output into each fprintf
      disas/microblaze: Print registers directly with PRIreg
      disas/microblaze: Print immediates directly with PRIimm
      disas/microblaze: Print registers directly with PRIrfsl
      disas/microblaze: Split get_field_special
      disas/riscv: Use GString in format_inst

 include/qemu/cutils.h  |  19 +-
 disas/microblaze.c     | 551 +++++++++++++++++++++----------------------------
 disas/riscv.c          | 209 +++++++++----------
 hw/dma/pl330.c         |  23 +--
 hw/ide/atapi.c         |  12 +-
 hw/mips/malta.c        |  25 +--
 hw/scsi/scsi-disk.c    |  13 +-
 hw/virtio/vhost-vdpa.c |  14 +-
 system/qtest.c         |  12 +-
 util/hexdump.c         |  57 +++--
 10 files changed, 418 insertions(+), 517 deletions(-)

