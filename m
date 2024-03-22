Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D615C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnalN-0001X3-Pw; Fri, 22 Mar 2024 05:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnalL-0001VR-0b
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:31 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnalJ-0002Dy-6T
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:30 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-696499bd61eso19436736d6.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098027; x=1711702827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ATuiYoLpuugVHqI4OxAuRWcDc9r7aEih/KU8sNmRL4c=;
 b=GSiYAUd7x89PHoP0HRZ1jE7egdAAglwJ3BOjmStshbF0DaCdnLIW7J8Q/RyurX7Hif
 I7WnJROd0z4+WjWxMXr+KiVfLXrmFy0c20p9BzPygW8uv4lz2VXecKF8GNcJV173yRDH
 YNLJZPE7kh0pHC0NvNwzxq9uu3PCXU0/kAWsHOXhfmhbWLs01tlPfDcYLBK74IfrKNDa
 WtVQJnaEeW56goGYd2Ui66JqCGFssuDlbc2NBFLbV3qyn85kv4eFd11BYRRIf797lUAe
 hl/yje62JF/0pNeU0Wq8ieESkE5hqsI2+BmuBCMl34kqDtqjeXS/rl5J29NBJ784by0Z
 z25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098027; x=1711702827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ATuiYoLpuugVHqI4OxAuRWcDc9r7aEih/KU8sNmRL4c=;
 b=KQ4qQocJHOEkcHgDRWLOHBFWLchDlNa8lc0P+3cFkRF7ESKBkI8qVrOLg+ZrKb3Rm4
 upx1m7hvCtc4C903WGkFS6iMJL2Toe/470WCShMa6V73sR7GQSBYsIblSrSwM5KP4Pvn
 9Zc3Yd4l8gC7AHpm/uR0ctbt+37yysCE9dOTB+6QjtzY3zWIa739Of4waRwY/CEJ7wJj
 DZUWXjymlT4JIq2gM1U0y9gNIzj2DgIG6q0O0JO6JNmwzzssuI8orgXLAe5V28iLI6eZ
 PgYnQ2dUkzhlqotYdOVbO73GLJtc2HLR6TiAv/4BbKK0+i6JztUG+q3IXDVxMaVUwRS+
 yh3g==
X-Gm-Message-State: AOJu0YxVU0Vydl95EeokaxQAzbEv4fgAh8wAk5EBiWnZiY8nJRkBUWbQ
 Az/8h9+Sz+Wz3l+woWeTLxBSw/XsY8xARMtPXQ4GA1146yM2FXX90PrkGjBkllia+A==
X-Google-Smtp-Source: AGHT+IGf0UQnk9gURlkpnZI411JmI7DGsJS1ePKX6nvcxV33RfvisW+HGheayyNWlrVUS0U8q4JmPw==
X-Received: by 2002:a05:6a20:3d1f:b0:1a3:a94e:9d64 with SMTP id
 y31-20020a056a203d1f00b001a3a94e9d64mr398993pzi.53.1711097607164; 
 Fri, 22 Mar 2024 01:53:27 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/15] riscv-to-apply queue
Date: Fri, 22 Mar 2024 18:53:04 +1000
Message-ID: <20240322085319.1758843-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit fea445e8fe9acea4f775a832815ee22bdf2b0222:

  Merge tag 'pull-maintainer-final-for-real-this-time-200324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-21 10:31:56 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240322

for you to fetch changes up to 385e575cd5ab2436c123e4b7f8c9b383a64c0dbe:

  target/riscv/kvm: fix timebase-frequency when using KVM acceleration (2024-03-22 15:41:01 +1000)

----------------------------------------------------------------
RISC-V PR for 9.0

* Do not enable all named features by default
* A range of Vector fixes
* Update APLIC IDC after claiming iforce register
* Remove the dependency of Zvfbfmin to Zfbfmin
* Fix mode in riscv_tlb_fill
* Fix timebase-frequency when using KVM acceleration

----------------------------------------------------------------
Daniel Henrique Barboza (10):
      target/riscv: do not enable all named features by default
      target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
      trans_rvv.c.inc: set vstart = 0 in int scalar move insns
      target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
      target/riscv: always clear vstart in whole vec move insns
      target/riscv: always clear vstart for ldst_whole insns
      target/riscv/vector_helpers: do early exit when vstart >= vl
      target/riscv: remove 'over' brconds from vector trans
      trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
      target/riscv/vector_helper.c: optimize loops in ldst helpers

Frank Chang (1):
      hw/intc: Update APLIC IDC after claiming iforce register

Irina Ryapolova (1):
      target/riscv: Fix mode in riscv_tlb_fill

Ivan Klokov (1):
      target/riscv: enable 'vstart_eq_zero' in the end of insns

Max Chou (1):
      target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin

Yong-Xuan Wang (1):
      target/riscv/kvm: fix timebase-frequency when using KVM acceleration

 target/riscv/cpu_cfg.h                     |   8 +-
 target/riscv/kvm/kvm_riscv.h               |   1 +
 target/riscv/vector_internals.h            |   9 ++
 hw/intc/riscv_aplic.c                      |   1 +
 hw/riscv/virt.c                            |   2 +
 target/riscv/cpu.c                         |  40 ++---
 target/riscv/cpu_helper.c                  |   2 +-
 target/riscv/kvm/kvm-cpu.c                 |   9 ++
 target/riscv/tcg/tcg-cpu.c                 |  19 ++-
 target/riscv/translate.c                   |   6 +
 target/riscv/vcrypto_helper.c              |  32 ++++
 target/riscv/vector_helper.c               |  93 ++++++++++-
 target/riscv/vector_internals.c            |   4 +
 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +--
 target/riscv/insn_trans/trans_rvv.c.inc    | 244 +++++++++--------------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +---
 16 files changed, 259 insertions(+), 259 deletions(-)

