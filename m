Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07150CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC53w-0003pe-UY; Thu, 23 Oct 2025 19:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC53u-0003pO-Ot
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC53s-00073W-LG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27d3540a43fso13374645ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263378; x=1761868178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=04/xSRj7ipZ9Qm1tVaaz6k08CkdaPczkvm+yEXsd83k=;
 b=BjECS1gAm/bEjQuWoUMnZhhyEuH4iPR0ktaqX3bDk9eJ/x3oXtb9FZs5Fkg7JxaYh9
 PgIxMP7qGwUGaGet7SkVuOQ2+js12vtWKOcNNgoko8LXesgkDkXACqyfSNQgnn2o9BvW
 4v1G76zNYpEPd6m9CKbtC8Uib+blb4RxSJtmE92st62KEJawDvJbvgS1CL0ugLHhiWnN
 xQsxH65z9OtbxnBst4UsjNDCK7skAQBWKLD5s0mk2OwCkD+HNyPVhaTEfPic85TR7I1a
 5XuPhNYfNK9+7fnNfkHHp7MB8CkibwK3wRMdgo/iezXv4G9glYPoQ9W9JTk0uDCKB0d7
 sulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263378; x=1761868178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04/xSRj7ipZ9Qm1tVaaz6k08CkdaPczkvm+yEXsd83k=;
 b=CLRyQqGDBeVyBLhKilK1kT03Fp6VF5yyK/Eom6/9oVcWMCBcuTjTUV/Tmow0NeGTqF
 wEK7ae0RUP3LWDc0jSbCB0xJeeFe+nj+codW43F4ATPpI7ou1Bv6P/mOVqQ0ley477Kq
 DAUytcdJbWU4Q7s/7yL8WlhaZOwQtCT11vaVIjgCSyrVjehYgseY3xyhnL4KgZqvromk
 nHL31dG3nBog37KSzL6QYm9W+pWIwbPq+rj3diWD+uAk23zGVbzK1vFd45njlZhwxD3B
 361RZysw+MNxXujO1CIYCxAsavYqdA+F9zsw1VZMOe5eEOO8hHKSC6pFzA8U/V+U5rIU
 8o6Q==
X-Gm-Message-State: AOJu0YyhbtLEYB9BS4/zOMZMNfRV39BGGslCccFnN3kfaDJMs1qtdhfO
 utO/PYL4mvHmcDVl7barL4vtXXsabdlCrdLqpx6/NkNDrF6h1jne4oE3S8JSuw==
X-Gm-Gg: ASbGncuNREBWCpKngZZg9+0ljoaDX8fT8QqZDePzA69xzW4Fh20yNXQoODVYqbtClkj
 2gvrU4KLOKffaWj/q83p1RAOzZxT2Axkj41YaqoSVCfEu6qLsSAz/hes9D4bBlZyT+FmYjpPvTu
 /nT27ggDCzUOvQGLUJOGpIHm7txdBTVo+BQFvgentU7dpB1jOaB6T40E2XKE1WGgj6BqP3YV18V
 dXiWtXfD97Bqv9IOSP+tGpZpC7WZTZyuebfV0Wk+tk+w3KgpdBSmTVl5p+YWR1BqH3IQetQr50F
 a14aSLXgs2B6DN9HltCxrWikenvBivHAloWWSGuMCI404ynSjHj66ArCURr08IF1SFcTiszSK1A
 yCZVLUA//8mu6Zp7TIMuOi3krsqUpMZG7CfCpghgibQuXBtwWZeE70Dms0vtPXjiGyhMgWJMMlS
 DqplFsHHpeToW6VdmKdS+pLgVAAdHQGczg3y9kqykpEU3i2E/s/XEOWrwHaRV/AEyjdajMvFkGY
 nYQSC/lWRxrjXaEdo91RGTobzSrUA==
X-Google-Smtp-Source: AGHT+IGiZNxeGoAS6DuuUyGJywxvXYqzvSi6H7tFCxEy3buR0DFwCR4KUAITYqoRXVPS0vUJVpmgww==
X-Received: by 2002:a17:902:ce12:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-290c9c8a765mr296440155ad.6.1761263378465; 
 Thu, 23 Oct 2025 16:49:38 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/25] riscv-to-apply queue
Date: Fri, 24 Oct 2025 09:49:02 +1000
Message-ID: <20251023234927.1864284-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 88b1716a407459c8189473e4667653cb8e4c3df7:

  Merge tag 'pull-target-arm-20251023' of https://gitlab.com/pm215/qemu into staging (2025-10-23 13:17:27 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251024

for you to fetch changes up to eccf20c02a5ad913a910444dc6bbe5de0952d254:

  target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-24 09:24:08 +1000)

----------------------------------------------------------------
Second RISC-V PR for 10.2

* Correct mmu-type property of sifive_u harts in device tree
* Centralize MO_TE uses in a pair of helpers
* Fix Ethernet interface support for microchip-icicle-kit
* Fix mask for smsiaddrcfgh
* Fix env->priv setting in reset_regs_csr()
* Coverity-related fixes
* Fix riscv_cpu_sirq_pending() mask
* Fix a uninitialized variable warning
* Make PMP granularity configurable

----------------------------------------------------------------
Akihiko Odaki (1):
      target/riscv: Fix a uninitialized variable warning

Daniel Henrique Barboza (3):
      target/riscv/kvm: fix env->priv setting in reset_regs_csr()
      target/riscv/riscv-qmp-cmds.c: coverity-related fixes
      target/riscv: fix riscv_cpu_sirq_pending() mask

Djordje Todorovic (1):
      hw/intc: Allow gaps in hartids for aclint and aplic

Guenter Roeck (4):
      hw/net/cadence_gem: Support two Ethernet interfaces connected to single MDIO bus
      hw/riscv: microchip_pfsoc: Connect Ethernet PHY channels
      hw/net/cadence_gem: Add pcs-enabled property
      microchip icicle: Enable PCS on Cadence Ethernet

Jay Chang (2):
      target/riscv: Make PMP granularity configurable
      target/riscv: Make PMP CSRs conform to WARL constraints

Jialong Yang (1):
      aplic: fix mask for smsiaddrcfgh

Philippe Mathieu-Daudé (12):
      target/riscv: Explode MO_TExx -> MO_TE | MO_xx
      target/riscv: Conceal MO_TE within gen_amo()
      target/riscv: Conceal MO_TE within gen_inc()
      target/riscv: Conceal MO_TE within gen_load() / gen_store()
      target/riscv: Conceal MO_TE within gen_load_idx() / gen_store_idx()
      target/riscv: Conceal MO_TE within gen_fload_idx() / gen_fstore_idx()
      target/riscv: Conceal MO_TE within gen_storepair_tl()
      target/riscv: Conceal MO_TE within gen_cmpxchg*()
      target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() / gen_sc()
      target/riscv: Factor MemOp variable out when MO_TE is set
      target/riscv: Introduce mo_endian() helper
      target/riscv: Introduce mo_endian_env() helper

Zejun Zhao (1):
      hw/riscv: Correct mmu-type property of sifive_u harts in device tree

 include/hw/net/cadence_gem.h                  |  4 ++
 target/riscv/cpu.h                            |  1 +
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 hw/intc/riscv_aclint.c                        | 18 ++++-
 hw/intc/riscv_aplic.c                         | 42 ++++++++----
 hw/net/cadence_gem.c                          | 31 +++++++--
 hw/riscv/microchip_pfsoc.c                    |  6 ++
 hw/riscv/sifive_u.c                           |  2 +-
 target/riscv/cpu.c                            | 39 +++++++++++
 target/riscv/cpu_helper.c                     |  3 +-
 target/riscv/kvm/kvm-cpu.c                    |  1 +
 target/riscv/op_helper.c                      | 30 +++++---
 target/riscv/pmp.c                            | 46 +++++++++++++
 target/riscv/riscv-qmp-cmds.c                 | 22 +++---
 target/riscv/tcg/tcg-cpu.c                    | 12 ++--
 target/riscv/translate.c                      | 16 ++++-
 target/riscv/insn_trans/trans_rva.c.inc       | 50 ++++++++------
 target/riscv/insn_trans/trans_rvd.c.inc       |  6 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |  6 +-
 target/riscv/insn_trans/trans_rvi.c.inc       | 24 ++++---
 target/riscv/insn_trans/trans_rvzabha.c.inc   | 20 +++---
 target/riscv/insn_trans/trans_rvzacas.c.inc   | 12 ++--
 target/riscv/insn_trans/trans_rvzce.c.inc     | 12 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 +--
 target/riscv/insn_trans/trans_xthead.c.inc    | 98 +++++++++++++++------------
 26 files changed, 361 insertions(+), 159 deletions(-)

