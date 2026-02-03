Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79409E87823
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxA-0004VK-Sf; Tue, 03 Feb 2026 07:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFx9-0004V0-0l
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:23 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFx3-0003uS-9d
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:22 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82307c6902eso2867334b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770123375; x=1770728175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gsET48xM+KjjGEtQ/AYBvaMP2rB2bRx7mrLelgr2YnY=;
 b=cICWqxKk3yGiR2vZhxVeHAA0uLVB0qDlpKU1TTwEYCA7JBTEgxNZ/MhjsevpWU45CI
 FAPVuDt1h5e9fK1H1/4HaPf5TZ7kP7rXPPihAkXvvqQ0+AJW67Y/2uGNXDn6ZWtiCACR
 KxmvAzZTqqbtJGgF3cyBKIsusaxpqtUAx0f4IiteV+X2093ShckF5b3WrQciTbY7ZTKP
 Pr7OTPr0IIBef8+I3ElVGvlscvau6Jo5zJOwD3Ze3Svy337tnFfkuXl1vpAUa9wQqzG8
 e4gNHLjaGH+N3BN2s6pN2Yuho0nE+dy0qQtTwl1zEWSXMvW8k0/1yp5eUIp1Yo+5bhgY
 687A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123375; x=1770728175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsET48xM+KjjGEtQ/AYBvaMP2rB2bRx7mrLelgr2YnY=;
 b=xSofC61giAHBVHltj02168ordD+UfDkOajlnKs/V5s7iBzjaETaVGukfKPOVcyaVal
 ksA93BDdS+i3U3cHO/FQJC15hnxuhxc9yIWd4iHz9RvU6vd/8h8uF1GeHFD/rX0k7NT/
 FaBBTCGZdthqibUnGYgam17ZoJmFGG2Q2cZtpSX7GfdM7PIjkB4CVEsYUgv7bA0vg5W7
 LT1zMQzQsITpF5J7kanUiFpW/H9Y4U1UVkpxDxkihf4R/gzKPXxU/kNG3rggXk+qvEiv
 cpIq5VZayTmtwLDXdHNthRqSWSJlyMuX98jBqwApXbeY1nTCjkQGsX3EJ8jMY9un2XSr
 I4WQ==
X-Gm-Message-State: AOJu0YwcDJUnaJv2FT/nrBMydvoJF7eOCsNt/z181WbK+4CJJfdD/hOL
 Fayeb0JOMIGhdTPw1EFSPsXIDWqDLwGnrjRn4TT3l+ciACPnhVyFlTRF
X-Gm-Gg: AZuq6aJzfWTg8ZnTO6QGqrPbkXSlboWVFYuh5on7n9ugPW2bw1Bx5xaekL7735H7X6o
 PUXpLaEVwmOVIJt30BD0FHalCyBTOsLTVWjdHI2UiX5wY+GM5ut3KghdG6wHhQ7zwccTXkaSNhJ
 v2SOXieFyX0j2MlQy4pVXVDKxncPCr8FwSCZax9LcXMECQ9CCN/om+KAQuw4HN0N1fatjL7O68A
 /NhyXmJgjGcLmfTkZCaTdXsuRkwY74yY8qTA2Y8l10A3LQmT+QoShE3niKyBFFyGKssLAzQY3d+
 e+2PJW/ZEDtNeYB0TVhn0gFn3gvrKoWSR76fCq2MnNBF8MFFUYrS+K5T6qCAouZe9krNYMPAl6b
 3EGzT1xF5OQLt1+xiYIHLTJyRocFMQQbe2871xboMcnWmgPrXqkZMArQzNnLcMek5zOnsLNZREU
 Xb2ClUPCyJgp2bAsFLTelPp9SW1z3ADP6hzazIDjE15D6Uw/BaFoKCqNre
X-Received: by 2002:a05:6a20:4327:b0:38d:f62a:a9e8 with SMTP id
 adf61e73a8af0-392e00007d9mr14610052637.7.1770123375506; 
 Tue, 03 Feb 2026 04:56:15 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaf1308sm18214796a12.30.2026.02.03.04.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:56:14 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v5 0/7] riscv: add initial sdext support
Date: Tue,  3 Feb 2026 20:55:59 +0800
Message-ID: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Per Daniel's review feedback, this v5 series is based on Alistair's
riscv-to-apply.next branch [3]. It depends on patches 1-5 of Max Chou's
"Add Zvfbfa extension support" v2 series (not included; apply them
first) [2].

It is based on RISC-V Debug Specification 1.0 [1].

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

Changes in v5:
- Patch 2: removed redundant `cpu->cfg.ext_sdext = false;` in
  riscv_cpu_init() since it's already set to false in MULTI_EXT_CFG_BOOL.
  (Daniel)
- Patch 7: changed LOG_UNIMP to LOG_GUEST_ERROR for invalid trigger
  action=debug mode when Sdext is not enabled. LOG_UNIMP is reserved
  for unimplemented features, while LOG_GUEST_ERROR is for invalid
  guest actions. (Daniel)

Changes in v4:
- Fixed linux-user build errors: moved debug_mode/dcsr/dpc/dscratch
  fields inside #ifndef CONFIG_USER_ONLY block in cpu.h, and wrapped
  all code using these fields with proper guards. (Daniel)
- Updated dependency from single patch (patch 5 only) to patches 1-5
  of Max Chou's "Add Zvfbfa extension support" v2 series to avoid
  compilation errors.

Changes in v3:
- Rebase onto Alistair's riscv-to-apply.next branch.
- Depend on Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." (not included; apply it first) [2].
- Patch 2: default sdext to false in riscv_cpu_extensions[].

Changes in v2:
- Drop the RHCT expected AML update from this series.
- Replace the split sdext/sdtrig config bits patch with deprecating the
  'debug' CPU property.
- Rebase and update patch subjects to target/riscv prefix.

Changes in v1:
- Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
- EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
- Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
  It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." [2].
- Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
  inst-count triggers in tinfo.

Differences vs Debug Spec (known gaps):
- No Debug Module (no DMI, dmcontrol/dmstatus, haltreq/resumereq).
- No debug ROM, program buffer, abstract commands, or SBA.
- Resume is modeled by leaving Debug Mode at cpu_exec_enter.
- Step/exception ordering is simplified: if the stepped instruction
  traps, the normal exception is taken and Debug Mode is not forced.
- Several DCSR fields are not fully modeled (stopcount/stoptime, etc).

Roadmap (next stage, DM focus):
1) Add a DM core with DMI access and hart state tracking.
2) Implement halt/resume handshake and move Debug Mode transitions
   under DM control.
3) Add debug ROM, program buffer, and abstract commands for GPR/CSR
   and memory access.
4) Add SBA if required by tooling.
5) Tighten ordering rules for step/exception/trigger priorities.

References:
[1] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
[2] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
[3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Thanks,
Chao

Chao Liu (6):
  target/riscv: add sdext debug CSRs state
  target/riscv: add sdext Debug Mode helpers
  target/riscv: add dret instruction
  target/riscv: add sdext enter Debug Mode on ebreak
  target/riscv: add sdext single-step support
  target/riscv: add sdtrig trigger action=debug mode

Daniel Henrique Barboza (1):
  target/riscv: deprecate 'debug' CPU property

 docs/about/deprecated.rst                     |   7 +
 include/exec/translation-block.h              |   4 +-
 target/riscv/cpu.c                            |  59 +++++++-
 target/riscv/cpu.h                            |   9 ++
 target/riscv/cpu_bits.h                       |  33 +++++
 target/riscv/cpu_cfg_fields.h.inc             |   3 +-
 target/riscv/cpu_helper.c                     |  90 ++++++++++++
 target/riscv/csr.c                            | 128 +++++++++++++++++-
 target/riscv/debug.c                          |  58 +++++++-
 target/riscv/helper.h                         |   3 +
 target/riscv/insn32.decode                    |   1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  24 ++++
 target/riscv/machine.c                        |  44 ++++--
 target/riscv/op_helper.c                      |  70 ++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  21 ++-
 target/riscv/translate.c                      |  16 ++-
 16 files changed, 545 insertions(+), 25 deletions(-)

--
2.53.0


