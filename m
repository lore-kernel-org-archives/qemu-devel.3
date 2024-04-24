Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA6AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5V-0005lZ-Ti; Wed, 24 Apr 2024 19:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Q-0005iP-PH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:38 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5O-0003Ma-RY
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:36 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2abf9305afcso346688a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001493; x=1714606293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMGnRSLzMfjPcAWv+gJ2QDXKCclkbKeAZ+VbEIoyrQE=;
 b=xUi/nIQvn8MkDY6Nu3QxP2CCumO3PSoLJPXuxZYYMeF0i5xGc5rnaz2xh3MTv8e9vZ
 MTg0sgpCQ8yqrNoQJz673mlDtNlkeVGMC/Vcz/1jNHkl6ic9cDzMmj9pmZ7dh6ua8yHo
 LBYREg7nDpjM4bFf78/Oyg9T/liORKJP480ZhNvQaSxhgNU87aexQznLgaIt3utBvOWl
 dWpQrOqDlaybGz1hZ5ppypTS4e15VC60nVDOEa4FX40CZf+PApLkGhy/kd9gToDQZ2jt
 WwLtvZlIJX2AzDxi4kNB8Hk/mesXKIQRW6C7A4y3LDV+n5vtIBngALv6nxiByYIZ+CEu
 QpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001493; x=1714606293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMGnRSLzMfjPcAWv+gJ2QDXKCclkbKeAZ+VbEIoyrQE=;
 b=syH3gxqHkVaXMMGbccHX6ux2EiCjS0QWKKPPT+dlyUCGxdh5IPaquwarM2bJWVZinM
 FZ+rvl8n8kxXmHDsw4XaX0UO69tR5hEPmPAUDshtqBayhJ8Hh+wvd+kpaZ0bkKoeszom
 PgO5fKayzXIJOCPN/MHwbgO1fg9gJ+08LdEZwR/p5H5QXZ2CWSRHOjf6N1ddO5bRnZGx
 ts52s9yzRhzDC9qOXQm8Up5Qj7BpFWZT6ySVfhnZdGmzzC9kq2tCTptOQUYphZaecZsH
 FCjENIpZBo3IRhblUM6vurUtEa4rFK5OGk4LTn+3a3xtVCCvirddn5Pl+jYLWVBNZny1
 c2Qw==
X-Gm-Message-State: AOJu0Yy8+4Luo3BHPsaIrqh1yDC5WH+yTVGUcQcH8raGafc2w87IYpha
 xcHXxKWoORj8rb7AI3AEvlJccHJYQsTsL0LsH5t6c5z/3LSwwUClSo1FmP6vTM8fzoKFMdKa7yO
 +
X-Google-Smtp-Source: AGHT+IHUyqJBMoma2mBh3QzgKwOqbDPXhUV9ZXWs2LI7nknOSawXQUpsaDzZNEn2jSjwD+KR/ZKtLQ==
X-Received: by 2002:a17:90a:7142:b0:2a5:d313:4d3f with SMTP id
 g2-20020a17090a714200b002a5d3134d3fmr4405103pjs.34.1714001493152; 
 Wed, 24 Apr 2024 16:31:33 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/33] accel/tcg: Improve disassembly for target and plugin
Date: Wed, 24 Apr 2024 16:30:58 -0700
Message-Id: <20240424233131.988727-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Based-on: 20240424230224.941028-1-richard.henderson@linaro.org
("[PATCH v3 00/20] Rewrite plugin code generation")

Rebase only.
Reviews required for: 
  04-accel-tcg-Reorg-translator_ld.patch
  06-accel-tcg-Record-mmio-bytes-during-translation.patch
  07-accel-tcg-Record-when-translator_fake_ldb-is-used.patch
  08-accel-tcg-Record-DisasContextBase-in-tcg_ctx-for-.patch
  09-plugins-Copy-memory-in-qemu_plugin_insn_data.patch
  10-accel-tcg-Implement-translator_st.patch
  11-plugins-Use-translator_st-for-qemu_plugin_insn_da.patch
  12-plugins-Read-mem_only-directly-from-TB-cflags.patch
  13-plugins-Use-DisasContextBase-for-qemu_plugin_insn.patch
  15-plugins-Merge-alloc_tcg_plugin_context-into-plugi.patch
  18-disas-Split-disas.c.patch
  19-disas-Use-translator_st-to-get-disassembly-data.patch
  21-target-s390x-Fix-translator_fake_ld-length.patch
  22-target-s390x-Disassemble-EXECUTEd-instructions.patch
  23-target-hexagon-Use-translator_ldl-in-pkt_crosses_.patch
  29-target-riscv-Use-translator_ld-for-everything.patch
  32-target-s390x-Use-translator_lduw-in-get_next_pc.patch


r~


Philippe Mathieu-Daudé (1):
  accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code

Richard Henderson (32):
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

 disas/disas-internal.h           |   4 +
 include/disas/disas.h            |   9 +-
 include/exec/cpu_ldst.h          |  10 -
 include/exec/plugin-gen.h        |   7 +-
 include/exec/translator.h        |  71 +++++--
 include/qemu/plugin.h            |  22 +-
 include/qemu/qemu-plugin.h       |  15 +-
 include/qemu/typedefs.h          |   1 +
 include/tcg/tcg.h                |   1 +
 accel/tcg/plugin-gen.c           |  63 +++---
 accel/tcg/translator.c           | 331 +++++++++++++++++++-----------
 contrib/plugins/execlog.c        |   5 +-
 contrib/plugins/howvec.c         |   4 +-
 disas/disas-common.c             | 103 ++++++++++
 disas/disas-host.c               | 129 ++++++++++++
 disas/disas-mon.c                |  15 ++
 disas/disas-target.c             |  99 +++++++++
 disas/disas.c                    | 337 -------------------------------
 disas/objdump.c                  |  37 ++++
 plugins/api.c                    |  57 ++++--
 target/alpha/translate.c         |   9 -
 target/arm/tcg/translate-a64.c   |  11 -
 target/arm/tcg/translate.c       |  12 --
 target/avr/translate.c           |  11 +-
 target/cris/translate.c          |  37 +---
 target/hexagon/translate.c       |  11 +-
 target/hppa/translate.c          |  21 +-
 target/i386/tcg/translate.c      |  19 +-
 target/loongarch/tcg/translate.c |   8 -
 target/m68k/translate.c          |   9 -
 target/microblaze/translate.c    |  11 +-
 target/mips/tcg/translate.c      |   9 -
 target/openrisc/translate.c      |  11 -
 target/ppc/translate.c           |   9 -
 target/riscv/translate.c         |  24 +--
 target/rx/translate.c            |  35 ++--
 target/s390x/tcg/translate.c     |  26 ++-
 target/sh4/translate.c           |   9 -
 target/sparc/translate.c         |   9 -
 target/tricore/translate.c       |   9 -
 target/xtensa/translate.c        |  12 +-
 tcg/tcg.c                        |  12 --
 target/cris/translate_v10.c.inc  |  30 +--
 disas/meson.build                |   8 +-
 44 files changed, 818 insertions(+), 864 deletions(-)
 create mode 100644 disas/disas-common.c
 create mode 100644 disas/disas-host.c
 create mode 100644 disas/disas-target.c
 delete mode 100644 disas/disas.c
 create mode 100644 disas/objdump.c

-- 
2.34.1


