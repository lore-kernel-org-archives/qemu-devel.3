Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60F5D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhZ6-0004KG-M3; Fri, 30 Jan 2026 01:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZ3-0004IS-Ur
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:05 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZ2-0000lU-4s
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:05 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso664308a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752862; x=1770357662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZH7sJoSfMg2kzFmgDFkKMsPHtxwaJe2y2r2z/2QQsE=;
 b=CyGFYoFZhVhHfJwtlkvZsdkxoJ2fBmD6dp9YnmMNzs7EjI+A9wEybAbmsV78fImRlN
 rWBtaUoUmBb3TchmnlbphJFGN8vLYWlgc3f5ohmWCqJeqO7N+CTTiUeO2DURxfDRuHnr
 Q5jpUIQaj+R309aZb3OxccO3L3LENwtjQOzMXxrBDh/NRGqgh73sDeeemP5SjUL0ehOK
 HZNVX2hQ5efhMZrXNJpVQbp8vqaWw8zF9Ah+hSNB/gsN3EgPAmXvBVmog6IgIy7PhMws
 7W1Nr/ihO0jnUEW8+BEcG43JlrkviJDPtJOhItUMT8S1s+W5c4vF08/1g3SA1jXeRtdP
 Eqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752862; x=1770357662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZH7sJoSfMg2kzFmgDFkKMsPHtxwaJe2y2r2z/2QQsE=;
 b=kNSVB5smZutOKCPPEkVVnYXarOSUIJfY0UwLITiLLqB7f9B9YvT2InqSUlbm5PEdKu
 5PbZY9x7vzy2aKIjOhuGvhMSxNY1EQY+fhuSzK2U+NeNv+OJY1LqRrAFl7aXnEJK/dRu
 yZKSvV6Gy6mgohuRBzF5DQkg2accLLWUp8w10bUvukCgeFxEyPLDKSNYAoajWA9yUjaP
 iSif98F1yiMzJEIttNGOCuxx1AynxE/Kbr/Wjelv2+kyWw3lgMk147rYMPb5/HQkmMh1
 1lKQtFfdpN1i2fJALNc1ZcUx2KhAmdO8BTD2czCMm58Is4FqGZaLp5zlVYz6zGvzPRzW
 9A3A==
X-Gm-Message-State: AOJu0YwNuPA9o/79W00LX6z+v8bRSOVrNbIZsTvxlnObwbSUn3Gq4Mdd
 BBsZL/ZcFa1hxEmzFCtoOs9xjUw8GTRNrvPR26SQvVU9RWCb3KoYFiyK
X-Gm-Gg: AZuq6aJcOb8QE5a1L7Wp1A+HdEdD6XnAIVYQNYu2vZ2MoE0je3sPrE9zM+8zIGyhWUK
 oUnC1vnV/r6es7ef3u6zSGuguYLRL3Nta8JAxkwsTo/xC+pdS0AO5yL28aHNmUuLbd3RBJIhIu9
 H38IQU5V2Z1gC61ob3lL9Z37KjIXUGMuZKFSK6GTQEYfhppQl9mFLRMIyqJy/tFFK9QtRZwIbJJ
 qOk8/OlV0prS2uj/2R759qlUA/fML9VcfPpHKIJchArhQzvQj5HMNHwOCouWkZjNgYsaTvMkQR0
 uZFbxqgKxUG7lsKSeAxLQ9Z0gydgC6cR+v/M1omaN4pSWfsaFNrlrwnchIZxEnyBMvLZDntRLyu
 9evV67rqn2DVniK1eg6ABvdoWRQqbv0EzH7tKpmMLgKUKcn4KDlcHXbFOZ3dP3Ur+L6p22qQ7MF
 E7dREvzShfg1liB/k+sFqj2RlAImJ2PR8hjdVUohSQjElb8LVRHbcdbBznUwE=
X-Received: by 2002:a05:6a20:2d11:b0:371:53a7:a4aa with SMTP id
 adf61e73a8af0-392e005bbdemr1746518637.29.1769752862001; 
 Thu, 29 Jan 2026 22:01:02 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm66274585ad.2.2026.01.29.22.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 22:01:01 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v4 0/7] riscv: add initial sdext support
Date: Fri, 30 Jan 2026 13:59:59 +0800
Message-ID: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Per Daniel's review feedback, this v4 series is based on Alistair's
riscv-to-apply.next branch [3]. It depends on patches 1-5 of Max Chou's
"Add Zvfbfa extension support" v2 series (not included; apply them
first) [2].

It is based on RISC-V Debug Specification 1.0 [1].

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

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
 target/riscv/cpu.c                            |  62 ++++++++-
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
 16 files changed, 548 insertions(+), 25 deletions(-)

-- 
2.52.0


