Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08249D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjI-0008WO-9J; Tue, 15 Oct 2024 11:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjG-0008VW-1o
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:44:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjD-0000TZ-66
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:44:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-207115e3056so45648455ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007087; x=1729611887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=asBe4QfNpqC0ic8duoP68+gRr9elED3EG2vwZw9zSTQ=;
 b=LLk2/sRbQxYTNeEOf/mFUoEiZ3HV+lcnai9slM9IiMf1Zy3DNUuhDBEj9SAoioxiad
 WH05Fa0Eo5CruSuqq0Nu6ipno/XapQhT963Tn7bCvD9khZdWHVpIFmBwl5NnCbsbU24p
 Z3YAlGL2RZu+bP9Jol5w05Dep609e0o/6kEdpPvXS/73bTTS/qEWIe29sO+umvP+fB6e
 hiO9ci5O573laOLiT4qs0+UEu+HKtP7Z5E8iiWCYn3zXnvAJU5H3qSARlvdPat+QTH8p
 ZL5ro8hEBRTOCbykyW4bcWhH01sGYJwHW8rm13w0Bq8XzGbQdtTFLvq5Gn3tKiEENbQE
 F3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007087; x=1729611887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=asBe4QfNpqC0ic8duoP68+gRr9elED3EG2vwZw9zSTQ=;
 b=dh55W8WLSOIZSghxhMrNrYw68anUDizNtrE94Il27U0lFvraoedoozi7W85nSKiQyB
 Qg6ZHkj01jbpY9tQ7ZpjxgsvSuSUIXic16r6xCYYEpJNLXZvd9yOUCAZ9Zfr231e0jqM
 BZkDNSl88XuGAJy19NiDT4L1ViIShgK2HlpPfLBBeHGIw3sjqj54+53zsd2aqhxM1nqE
 ghYIke2mFLbkhxUmhEBHZWblaB53QYAdV7FtZx6NIqf/GjsdON6ZzekuFLvL7u9TYxwe
 LryiWVYr0crT6ZS5PMVhJVkgA7v820rEYwOUsKdaHPHkTC4pVl6YRWUt1yVi4JO+tPhf
 GFOw==
X-Gm-Message-State: AOJu0Yy5hv+LYReLNwkFi6x1ssBdglwdRZW2wxkpmVeLVIasI+6w5Bue
 Zu6cvcchbZxx4by9VOzyqBljYolkKU4DUj9e/97oLUVmaUM26AgkVBEmUJckdTYChJHrm/ieZHK
 n
X-Google-Smtp-Source: AGHT+IEMMuREqhhjjoOCxd8S3kCbsWlRyzMCwtEiBwYhBpZPEY7FcbRjfuLai8Svx8L6V24W79o6vA==
X-Received: by 2002:a17:903:2410:b0:20b:7d21:fb8a with SMTP id
 d9443c01a7336-20d27f3fd39mr6890835ad.61.1729007086775; 
 Tue, 15 Oct 2024 08:44:46 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84502sm13522665ad.53.2024.10.15.08.44.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:44:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/33] Endianness cleanup patches for 2024-10-15
Date: Tue, 15 Oct 2024 12:44:09 -0300
Message-ID: <20241015154443.71763-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit c155d13167c6ace099e351e28125f9eb3694ae27:

  Merge tag 'chr-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-15 10:30:43 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20241015

for you to fetch changes up to 3e8f019be77d1b648bca0af0121da3bb37766509:

  hw/mips: Have mips_cpu_create_with_clock() take an endianness argument (2024-10-15 12:21:06 -0300)

One checkpatch warning due to wide comment:

  WARNING: line over 80 characters
  #108: FILE: hw/i386/multiboot.c:380:
  +    stl_le_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */

----------------------------------------------------------------
Remove some target-specific endianness knowledge from target/.

For MIPS, propagate endianness at the board level, using QOM property.
----------------------------------------------------------------

Philippe Mathieu-Daudé (33):
  qemu/bswap: Undefine CPU_CONVERT() once done
  exec/tswap: Massage target_needs_bswap() definition
  exec/memop: Remove unused memop_big_endian() helper
  target/hexagon: Replace ldtul_p() -> ldl_p()
  target/alpha: Replace ldtul_p() -> ldq_p()
  gdbstub/helpers: Introduce ldtul_$endian_p() helpers
  target/alpha: Use explicit little-endian LD/ST API
  target/hexagon: Use explicit little-endian LD/ST API
  hw/i386: Use explicit little-endian LD/ST API
  target/avr: Use explicit little-endian LD/ST API
  linux-user/i386: Use explicit little-endian LD/ST API
  target/loongarch: Use explicit little-endian LD/ST API
  target/tricore: Use explicit little-endian LD/ST API
  target/tricore: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  target/ppc: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
  target/mips: Declare mips_env_is_bigendian() in 'internal.h'
  target/mips: Rename cpu_is_bigendian() -> disas_is_bigendian()
  target/mips: Introduce mo_endian_env() helper
  target/mips: Replace MO_TE by  mo_endian_env() in get_pte()
  target/mips: Convert mips16e decr_and_load/store() macros to functions
  target/mips: Factor mo_endian_rev() out of MXU code
  target/mips: Explode MO_TExx -> MO_TE | MO_xx
  target/mips: Rename unused sysemu argument of OP_LD_ATOMIC()
  target/mips: Remove unused MEMOP_IDX() macro
  target/mips: Introduce mo_endian() helper
  target/mips: Replace MO_TE by mo_endian()
  target/mips: Have gen_addiupc() expand $pc during translation
  target/mips: Use gen_op_addr_addi() when possible
  target/mips: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  target/mips: Expose MIPSCPU::is_big_endian property
  hw/mips/cps: Set the vCPU 'cpu-big-endian' property
  hw/mips: Have mips_cpu_create_with_clock() take an endianness argument

 include/exec/memop.h                      |   6 -
 include/exec/tswap.h                      |   2 +-
 include/gdbstub/helpers.h                 |   4 +
 include/hw/mips/cps.h                     |   1 +
 include/qemu/bswap.h                      |   2 +
 target/mips/cpu.h                         |   7 +-
 target/mips/internal.h                    |  10 ++
 target/mips/tcg/translate.h               |  13 +-
 hw/i386/multiboot.c                       |  39 +++--
 hw/i386/x86-common.c                      |  26 +--
 hw/mips/cps.c                             |   4 +
 hw/mips/fuloong2e.c                       |   2 +-
 hw/mips/jazz.c                            |   3 +-
 hw/mips/loongson3_virt.c                  |   2 +-
 hw/mips/malta.c                           |   5 +-
 hw/mips/mipssim.c                         |   3 +-
 hw/xtensa/xtfpga.c                        |  12 +-
 linux-user/i386/signal.c                  |   4 +-
 target/alpha/gdbstub.c                    |   2 +-
 target/avr/gdbstub.c                      |   4 +-
 target/hexagon/gdbstub.c                  |  10 +-
 target/loongarch/gdbstub.c                |   8 +-
 target/mips/cpu.c                         |  17 +-
 target/mips/tcg/ldst_helper.c             |  15 +-
 target/mips/tcg/msa_helper.c              |   8 -
 target/mips/tcg/mxu_translate.c           |  18 +-
 target/mips/tcg/sysemu/tlb_helper.c       |   2 +-
 target/mips/tcg/translate.c               | 193 ++++++++++------------
 target/mips/tcg/tx79_translate.c          |   8 +-
 target/ppc/translate.c                    |  13 +-
 target/tricore/gdbstub.c                  |   2 +-
 target/tricore/translate.c                |   3 +-
 target/mips/tcg/micromips_translate.c.inc |  34 ++--
 target/mips/tcg/mips16e_translate.c.inc   | 118 +++++++------
 target/mips/tcg/nanomips_translate.c.inc  | 162 ++++++++----------
 35 files changed, 370 insertions(+), 392 deletions(-)

-- 
2.45.2


