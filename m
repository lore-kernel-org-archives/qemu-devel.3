Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F316CC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79RY-00042Q-Au; Wed, 15 May 2024 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RU-00040c-Su
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:52 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RS-0001XM-Vu
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:52 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e1fa824504so85251001fa.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759568; x=1716364368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mnb/F7Iac+A7LQwaCdPGuqUXebHDd+Yk07U5+puyxPE=;
 b=Z5aesG8MhtkDIMVr7NlEApx2fcWHVkWmfzvL1C+EQKWkX4/vzVOXtnyKqc051AcGbI
 z5oEvux227eWCtrrwXMP6nfzUeFicqcIXXuoS2lAJ+o8YqfzRLsJq44UqmznZqqYJXn6
 smpa377N9zSvfhcSEOKm6UypQzUgXPcKE4489NznkKJszrd4ehc27xemW8Ut5vaZFdX9
 yHZ81JVCaC2KD/yYAL22k7GnwTrC5MS+U63uhtfAedox4p/hKGFcMzqHvymbo+agiCMi
 p5RpgRCasQAXs5AS59esYuWsQlmFAtt7ZAdk8g8X82Icv9PYaF6doAkvmklo68kYdCQY
 daEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759568; x=1716364368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mnb/F7Iac+A7LQwaCdPGuqUXebHDd+Yk07U5+puyxPE=;
 b=f8pX69gheebgwIr/tRVnA2MsF9qb5tvyO4reaoqzP7YK3BnXUJSpsfNPyVKl2TIDJw
 UYfINlCBapSv961KRkXYNAePmXfX+91RlwhojA6s2SuyAwMct8CzSXEntRork9TIXGPi
 ywMZ+nlXLQ5/nJwa7iVLSyCeoU93/madvBkBIh8Zr70vGYz5iSJW8LxYBiUtzkIMPzA1
 tFsOWPk5i4gUmXGqdHbnekS2aOp40PL1aX2PMBfo1jGRK3u6v93Sa2MLvS3xU8HC0JJo
 6ClqZnoYFRxUssgRQjLBTgVuff3Yqbx3DKaIr8LV1vP7EYz+z9EJWwEwoRM/NwsKSXRW
 zGBA==
X-Gm-Message-State: AOJu0Yyzr+vPuAftNXZ8tXaZKhHiVyiDC4WcFLDsv4PCvLE7lIeNvzev
 tLegchKAO1H0G10zKnip0WyluPBiw9A7TNSj4DcwuOTNpCkcmyuFwI43RXK363wPhyx44eO4k0V
 ksho=
X-Google-Smtp-Source: AGHT+IErGi0LeDZsq+mQUo7SOZ3YhM0Po+qxm5uvxVEaGdr27y2MFZbhO2F1D3wG3HiZBSMhejtwgA==
X-Received: by 2002:a2e:8ec4:0:b0:2e0:b713:6ba9 with SMTP id
 38308e7fff4ca-2e51ff4d5e1mr89133911fa.13.1715759568636; 
 Wed, 15 May 2024 00:52:48 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] tcg patch queue
Date: Wed, 15 May 2024 09:52:13 +0200
Message-Id: <20240515075247.68024-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
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

The following changes since commit 3d48b6b687c558a042d91370633b91c6e29e0e05:

  Merge tag 'pull-request-2024-05-14' of https://gitlab.com/thuth/qemu into staging (2024-05-14 17:24:04 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240515

for you to fetch changes up to c9290dfebfdba5c13baa5e1f10e13a1c876b0643:

  tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs (2024-05-15 08:57:39 +0200)

----------------------------------------------------------------
tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs
accel/tcg: Improve disassembly for target and plugin

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code

Richard Henderson (33):
      accel/tcg: Use vaddr in translator_ld*
      accel/tcg: Hide in_same_page outside of a target-specific context
      accel/tcg: Pass DisasContextBase to translator_fake_ldb
      accel/tcg: Reorg translator_ld*
      accel/tcg: Cap the translation block when we encounter mmio
      accel/tcg: Record mmio bytes during translation
      accel/tcg: Record when translator_fake_ldb is used
      accel/tcg: Record DisasContextBase in tcg_ctx for plugins
      plugins: Copy memory in qemu_plugin_insn_data
      accel/tcg: Implement translator_st
      plugins: Use translator_st for qemu_plugin_insn_data
      plugins: Read mem_only directly from TB cflags
      plugins: Use DisasContextBase for qemu_plugin_insn_haddr
      plugins: Use DisasContextBase for qemu_plugin_tb_vaddr
      plugins: Merge  alloc_tcg_plugin_context into plugin_gen_tb_start
      accel/tcg: Provide default implementation of disas_log
      accel/tcg: Return bool from TranslatorOps.disas_log
      disas: Split disas.c
      disas: Use translator_st to get disassembly data
      accel/tcg: Introduce translator_fake_ld
      target/s390x: Fix translator_fake_ld length
      target/s390x: Disassemble EXECUTEd instructions
      target/hexagon: Use translator_ldl in pkt_crosses_page
      target/microblaze: Use translator_ldl
      target/i386: Use translator_ldub for everything
      target/avr: Use translator_lduw
      target/cris: Use translator_ld* in cris_fetch
      target/cris: Use cris_fetch in translate_v10.c.inc
      target/riscv: Use translator_ld* for everything
      target/rx: Use translator_ld*
      target/xtensa: Use translator_ldub in xtensa_insn_len
      target/s390x: Use translator_lduw in get_next_pc
      tcg/loongarch64: Fill out tcg_out_{ld,st} for vector regs

 disas/disas-internal.h           |   4 +
 include/disas/disas.h            |   9 +-
 include/exec/cpu_ldst.h          |  10 --
 include/exec/plugin-gen.h        |   7 +-
 include/exec/translator.h        |  74 ++++++---
 include/qemu/plugin.h            |  22 +--
 include/qemu/qemu-plugin.h       |  15 +-
 include/qemu/typedefs.h          |   1 +
 include/tcg/tcg.h                |   1 +
 accel/tcg/plugin-gen.c           |  63 +++-----
 accel/tcg/translator.c           | 331 ++++++++++++++++++++++++--------------
 contrib/plugins/execlog.c        |   5 +-
 contrib/plugins/howvec.c         |   4 +-
 disas/disas-common.c             | 104 ++++++++++++
 disas/disas-host.c               | 129 +++++++++++++++
 disas/disas-mon.c                |  15 ++
 disas/disas-target.c             |  99 ++++++++++++
 disas/disas.c                    | 338 ---------------------------------------
 disas/objdump.c                  |  37 +++++
 plugins/api.c                    |  57 +++++--
 target/alpha/translate.c         |   9 --
 target/arm/tcg/translate-a64.c   |  11 --
 target/arm/tcg/translate.c       |  12 --
 target/avr/translate.c           |  11 +-
 target/cris/translate.c          |  37 +----
 target/hexagon/translate.c       |  11 +-
 target/hppa/translate.c          |  21 ++-
 target/i386/tcg/translate.c      |  19 +--
 target/loongarch/tcg/translate.c |   8 -
 target/m68k/translate.c          |   9 --
 target/microblaze/translate.c    |  11 +-
 target/mips/tcg/translate.c      |   9 --
 target/openrisc/translate.c      |  11 --
 target/ppc/translate.c           |   9 --
 target/riscv/translate.c         |  24 +--
 target/rx/translate.c            |  35 ++--
 target/s390x/tcg/translate.c     |  26 ++-
 target/sh4/translate.c           |   9 --
 target/sparc/translate.c         |   9 --
 target/tricore/translate.c       |   9 --
 target/xtensa/translate.c        |  12 +-
 tcg/tcg.c                        |  12 --
 target/cris/translate_v10.c.inc  |  30 ++--
 tcg/loongarch64/tcg-target.c.inc | 103 +++++++++---
 disas/meson.build                |   8 +-
 45 files changed, 899 insertions(+), 891 deletions(-)
 create mode 100644 disas/disas-common.c
 create mode 100644 disas/disas-host.c
 create mode 100644 disas/disas-target.c
 delete mode 100644 disas/disas.c
 create mode 100644 disas/objdump.c

