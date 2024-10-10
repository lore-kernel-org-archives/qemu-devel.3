Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EADD24455
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13L-0007HU-8M; Thu, 10 Oct 2024 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13C-0007Fk-0G
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz139-0004cr-MP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso14387205ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597019; x=1729201819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y6VDUacv/t+N2b53bBz4BEo9jleuzzWeufmM8SdWIsc=;
 b=Io4BV64IFiS8+AafVqwrCs6Tu0UW1+bWfKIRM+/CSHscTba6q6zlnQfH/I7GcYpss8
 wjuGvLNFUs6BviGMq5jSIBzzC45mAOzbhrEIQTFIZFsfOcslVbJkLVmdvWIMJDvKwajG
 rXMRSe9lYLDR/yv1GacZ+9RGg3VZEgVzj6PFByUYCQ86u/35MW4CgKmJk21ByWcIclOP
 ecgcN18oRdZ3xnpxV8eN6rNq77M40N2qaLCI8R4tynx9A692HBgXQ6cmkl32GdD6d9Fx
 iFcVEhOahXvtk2qm2nPI+rcuii/srWichWAV7Wr4av8anmONrtVvH5XwzSAbbGs1kUNs
 zlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597019; x=1729201819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6VDUacv/t+N2b53bBz4BEo9jleuzzWeufmM8SdWIsc=;
 b=JT2LeX3rCqLkTIzZTNY6MKT2Q7qEqy9H6RbwSy9khEA27GfEE4OjSElJy73mw8TLlb
 WFR261yJzYmqGeWUHyIdbCKv5MDYRsopvhPe6LYPkGkcx3E5bEOIvai6Xgt/aQcvWdn/
 TQXelfIH3XatHjxovKFWlLxjenqQhNuQQ4moxBUsOmij42nGAs8TAACu42RCXl/4GYvX
 9MdRYZEgjyR9QZ5qbcK9sZFCn2AdSwDm9YBQ0agBLGpOD23CVJQDTMtQ0w7nOmFUPrwb
 jW/Zae7Gjbl0Xm1X5Gg7k7Wc1fMbQgFr7RZexOmWigpnPUGitayvImhXFGMJHmEr2aMR
 ED7A==
X-Gm-Message-State: AOJu0YzimRz96g225yFITmdhuZQ6iga4hS66yAm/WDwuyAzFXxuc2Iu3
 Lqqna3oVFqW2tnO5XMIZxOlOhM3ZCEqGfdi520Gb+EX2O00z05OqLguHqIx9O0mdJjhTey9OVJI
 j
X-Google-Smtp-Source: AGHT+IEGVEekTTvprkC9EOXfNjW3PFCtDSfcE2s0oVrWDUvjyb8RYGhHx69eAxilBhn8WakV2uCYrQ==
X-Received: by 2002:a17:903:2b0c:b0:20b:9379:f1f7 with SMTP id
 d9443c01a7336-20ca169e6b5mr4236645ad.40.1728597019591; 
 Thu, 10 Oct 2024 14:50:19 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bad344asm13777225ad.19.2024.10.10.14.50.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 00/16] target/mips: Remove target-specific endianness
 knowledge
Date: Thu, 10 Oct 2024 18:49:58 -0300
Message-ID: <20241010215015.44326-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

Since v1:
- Addressed rth review comment (adding new patches)

Get vCPU endianness from CP0::BE bit.
Propagate endianness at the board level, using QOM property.
Remove target-specific endianness knowledge from target/.

Philippe Mathieu-Daudé (16):
  target/mips: Declare mips_env_is_bigendian() in 'internal.h'
  target/mips: Rename cpu_is_bigendian() -> disas_is_bigendian()
  target/mips: Introduce mo_endian_env() helper
  target/mips: Replace MO_TE by  mo_endian_env() in get_pte()
  target/mips: Convert mips16e decr_and_load/store() macros to functions
  target/mips: Factor mo_endian_rev() out of MXU code
  target/mips: Explode MO_TExx -> MO_TE | MO_xx
  target/mips: Rename unused sysemu argument of OP_LD_ATOMIC()
  target/mips: Introduce mo_endian() helper
  target/mips: Replace MO_TE by mo_endian()
  target/mips: Have gen_addiupc() expand $pc during translation
  target/mips: Use gen_op_addr_addi() when possible
  target/mips: Use tcg_constant_tl() instead of tcg_gen_movi_tl()
  target/mips: Expose MIPSCPU::is_big_endian property
  hw/mips/cps: Set the vCPU 'cpu-big-endian' property
  hw/mips: Have mips_cpu_create_with_clock() take an endianness argument

 include/hw/mips/cps.h                     |   1 +
 target/mips/cpu.h                         |   7 +-
 target/mips/internal.h                    |  10 ++
 target/mips/tcg/translate.h               |  13 +-
 hw/mips/cps.c                             |   4 +
 hw/mips/fuloong2e.c                       |   2 +-
 hw/mips/jazz.c                            |   2 +-
 hw/mips/loongson3_virt.c                  |   2 +-
 hw/mips/malta.c                           |   5 +-
 hw/mips/mipssim.c                         |   2 +-
 target/mips/cpu.c                         |  17 +-
 target/mips/tcg/ldst_helper.c             |  15 +-
 target/mips/tcg/msa_helper.c              |   2 +-
 target/mips/tcg/mxu_translate.c           |  18 +-
 target/mips/tcg/sysemu/tlb_helper.c       |   2 +-
 target/mips/tcg/translate.c               | 193 ++++++++++------------
 target/mips/tcg/tx79_translate.c          |   8 +-
 target/mips/tcg/micromips_translate.c.inc |  34 ++--
 target/mips/tcg/mips16e_translate.c.inc   | 118 +++++++------
 target/mips/tcg/nanomips_translate.c.inc  | 150 +++++++----------
 20 files changed, 293 insertions(+), 312 deletions(-)

-- 
2.45.2


