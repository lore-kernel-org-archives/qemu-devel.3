Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACC6F3ED67
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkRh-00048E-IR; Sat, 11 Apr 2026 22:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRg-00047r-Ep
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:08 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRe-0008Eu-No
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:08 -0400
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8aca6bd57cfso1124896d6.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960465; x=1776565265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sPX+wLkZU5qabhE+HpCGpmaGNT/vhHnsut2qHd1zLXc=;
 b=jwFEvjcC6/L23yElJccUlTHGYS0I0VuQ10EaKhi/ZzamCqFJZSkBLyTiuDflSkpQOX
 vLBT3Ji9Xe2rsu9LQwbZWHk3nUxRv0rq01R3/e4RTYopgY+60WoUDuYiZKkd+Q9VYlwt
 Tzv7fSQe7qCAbC9OnXCI4oFBDCTJ6GXrRlwod2yZWYBfl1PsexMpMp6h8DQfy/+RaTMG
 As6AsBxYg9y8sBjtv7Y+xw8RU6ZXlcHhW9XfqLFEK+MHcRDG4xm9xTrPr8Ko1FrR/vc5
 FZJSnUrQso+gnCflhVk/xLSdCZB/0E5vAbVv1kfjx4THlmFARTNXYShKm0btD2cfXJAb
 ioCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960465; x=1776565265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPX+wLkZU5qabhE+HpCGpmaGNT/vhHnsut2qHd1zLXc=;
 b=b7vupZbfVP2EE4zRqIJjeth1vGtcP+cnDuTSHmFCLB/YI1PxSGYn5nJtVL7u9R9tDU
 jJbffJjIBnT/ykfscA92ABC2/fot+TFfuX345m5CSfuIZdvQdlv1OCHIm2GsJWfT1SM9
 Q0H0i9ajbtOXhs8U0MWW/UQk0i9nlLI3sDOCVlvtOTaEUtg1FZ/9Zzl6/Vt2ZxCeoHCh
 cHSrtBtaQXTsk7jajelUZ0ONJAfhdkBY267vkBqAuF+X21rV0vBe4+APzBCPwqUedfBG
 6Te4w0l8Ivz0TYKQCV1ELNwGsPs39FVZia/DlL98O+9OkSPV6jHigesC7LXFAGoM0qDw
 qIfA==
X-Gm-Message-State: AOJu0YznPyhKCy6fh84MGvGLSCiA4WsVMUTYWMpfMwNpELZA+FmjDLv/
 8Apndak8necR3ohIUfDwkQrCcOFLohJ+x0eNeaHbMxo7YG/2OH26oI2R
X-Gm-Gg: AeBDiete7yAZ3x9JTGn47tUVx6H7nYrUCLjrmlQsbtoXgP1YEwjDVbMGWWRgLUt8ICv
 TiHuT+VfuO+JHnvUe2IGE/V0pmxk2Q2d8C6MRlx9Zk3pnaeYBIfN3TOroHhAIzxtTLfCnFggYPN
 5jlN+Uvxl4iV8OIJgo6fbT65DpOANYqYQReWW7gY4B5yFA/lk1MqLwd2tKyxjeAitslJxRDQmPf
 9O7LVtnAV4rAz5qLtHJmt/JKxL3Bxwc61RP2g+3lFeLMpGkUljSJCr44PGXj49EWDPT/E75TNdS
 +JaHFMPKlElpQYWHBdT1Vldjdm3BtIYl9PfNRjOUagtw1TEyfQEx1YZ66dLzRQXMPmS839ONgno
 IiaBEAwUcJWbPk5JYUplwJtI32/QvaburWf8P1ttyBLJ/Y9FtrJkj782gpg0B5E4wekSzpUyv/n
 Dc8ub1WRhZmHoodsXzh6tH+qatsVEU9o/p7xwwOJ3YwdhQc6Zm9sFZnHD0Lj2mfyHnbXoy
X-Received: by 2002:a05:6214:524a:b0:89c:c2e7:97ad with SMTP id
 6a1803df08f44-8ac862d09d5mr150821186d6.43.1775960465452; 
 Sat, 11 Apr 2026 19:21:05 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:05 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 0/7] riscv: add initial sdext support
Date: Sun, 12 Apr 2026 10:20:17 +0800
Message-ID: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf43.google.com
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

This v6 series is rebased on Alistair's riscv-to-apply.next branch [1].

The implementation follows RISC-V Debug Specification 1.0 [2].

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

Changes in v6:
- Rebased onto latest riscv-to-apply.next

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
  the extend tb flags." (not included; apply it first) [3].
- Patch 2: default sdext to false in riscv_cpu_extensions.

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
  the extend tb flags." [3].
- Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
  inst-count triggers in tinfo.

---

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

CI (all jobs passed except check-patch which flags pre-existing
upstream style issues, not related to this series) [4].

References:
[1] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
[2] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
[3] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
[4] https://gitlab.com/TaoTang/qemu/-/pipelines/2446308835


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
 target/riscv/translate.c                      |  15 +-
 16 files changed, 544 insertions(+), 25 deletions(-)

-- 
2.53.0


