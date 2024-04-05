Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C4CCD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl6-0005z8-Nd; Fri, 05 Apr 2024 06:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl0-0005we-PK
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:14 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkr-0004Ld-IF
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:13 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a4f7a648dbso1023493eaf.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312702; x=1712917502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=R4ePy5ciUd2E+714ofgTRz5T7ulF/BeZ73QAwIvTH+Q=;
 b=eY/GfjLzNOFCG0IM/3t40szXdRZStNxZjiBZKo//zAIRU/Z1HEAqccC1xKlA6i5Ot8
 e0ppEKrv3TU2IV7p23MYU9ZPgUsMFeDga5I5MmfNCg+F5jMvKoQnUfw4/Gez/XzYPipA
 vtB429AhxyDWnvrxeP0w19+Z3HGBpQu96erRJSoSac4UVnllJPwVAKrpK0uHAR3gxzO1
 mcdVCQ77vj7s7TJMMCPapBGtR8QSNeG26WxT/5vQkxusDwUtWZQEfXLsUQ8l85T8QIW2
 6Rl8cVFlZUlNYgMVyfYl1fQgBnCLYW+TI+znfmFTS3lrHgel8w8WOmDYgTTeYzRfVbGF
 Smkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312702; x=1712917502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4ePy5ciUd2E+714ofgTRz5T7ulF/BeZ73QAwIvTH+Q=;
 b=Rs+x87Q6VJVHz+LStPHcuEwgYDV/Z2D+/chyjro7pUYs5OtiUc+x7s3fjsH29GNrRl
 A7YjUVJB+p1wUYr/Cg64StkOFHnGGu3CLBV+Y8U9/lQA1jbxoFoyh0sOrSmfhZJxoXEo
 k/t1zKjk4D2V3km5RLsrhVJ/OTCnZ0Eur71UpWy/8g3i/dwlbFziCUYmWoNPZwzVXuxG
 X/JzcJBr8y2qSZGsruSof4sZmvdOFfhjDAXZ9HSLJck68lQ/EHaavO/waG1GFWxuQwVN
 wIkL86qIX2nCB1kBl3zQ7g+cB+dkRST13r8nNLNkVECyGydJT8I9wtOScuT3gbvYYoUp
 TLyQ==
X-Gm-Message-State: AOJu0YyBsS8PW7n2Ro/bUCcTpwIHCTRTx7MqoOVU3s3ktLS8BaIPlAN8
 FT7M8l3Jij57MrxtCVs1uLMscSyVo20tkVjOy+2Xwl6owqsy5fC7VF7CBx1/h0zn5vgtGAApAaf
 I
X-Google-Smtp-Source: AGHT+IGRXsDf10QxYq0YNg2T47txhP37YmNWsUvZhlGk9RQF61X980Gf0f6zrtIBkZYrXP+RTHq+0w==
X-Received: by 2002:a05:6358:6e8f:b0:17e:8b5d:c7af with SMTP id
 q15-20020a0563586e8f00b0017e8b5dc7afmr1234191rwm.30.1712312701987; 
 Fri, 05 Apr 2024 03:25:01 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/32] accel/tcg: Improve disassembly for target and plugin
Date: Fri,  5 Apr 2024 00:24:27 -1000
Message-Id: <20240405102459.462551-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Based-on: 20240404230611.21231-1-richard.henderson@linaro.org
("[PATCH v2 00/21] Rewrite plugin code generation")

While I was trying to debug something the other week, I noticed
that hppa_cpu_get_phys_page_debug was not using the same cpu state
as the translator, which meant that the disassembler read from a
different page than the translator, producing garbage.

I considered several ways to fix the issue, but I thought the
most effective would be to re-use the host page resolution that
the translator has already done.

Second, the same mechanism can be used to clean up plugin access
to each instruction's bytes and disassembly.

Third, the cache used for plugin access to mmio can be used to
allow s390x execute to disassemble the insn.

Finally, with the change to how plugins capture insn data, we
can and should use translator_ld* for everything the target wants
to read during translation.


r~


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
  target/avr: Use translator_ldl
  target/cris: Use translator_ld* in cris_fetch
  target/cris: Use cris_fetch in translate_v10.c.inc
  target/riscv: Use translator_ld* for everything
  target/rx: Use translator_ld*
  target/xtensa: Use translator_ldub in xtensa_insn_len
  target/s390x: Use translator_lduw in get_next_pc

 disas/disas-internal.h           |   4 +
 include/disas/disas.h            |   9 +-
 include/exec/plugin-gen.h        |   7 +-
 include/exec/translator.h        |  70 +++++--
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
 target/nios2/translate.c         |  10 +-
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
 44 files changed, 819 insertions(+), 862 deletions(-)
 create mode 100644 disas/disas-common.c
 create mode 100644 disas/disas-host.c
 create mode 100644 disas/disas-target.c
 delete mode 100644 disas/disas.c
 create mode 100644 disas/objdump.c

-- 
2.34.1


