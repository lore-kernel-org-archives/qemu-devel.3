Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E3AD4A5F5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxuY-0000oH-GS; Fri, 16 Jan 2026 23:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuW-0000lM-N2
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuV-0001Zh-10
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:40 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so1369503b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624057; x=1769228857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M0FbB8dK4EiizAZXE9IV2Z8FiC4c35NhVdV2ncAsdOE=;
 b=W6a3LAMbjAeawCgf6d//WpV5X2/I6p1MKj+QLtcDk/BjRQnHqreiu3PbQ6gKqXG93g
 fELNWB7Gc+/tbFlWqEdm2J+J6CIjaSoRFMkOZ49kvZqYPQEzs4fUTUyD8mPgoSjP+dlf
 kSoVl8tBfVMnlwzhLsLSMnfhFcCFFObt6y5N7tw1H/uqpbcK8L84yX+ODgBR5uENI9aE
 gdJ+DFetyhpXMh2rRPMzgMcT5JDSgMTCTeA1PrOLfMLXziC7whUeUoIhRgs8FWznECBP
 GP3PgK3a+w5RhJ8yy/3bW+TM+AWPs4ep4WWuQlLs3eRMKUBF4YVc8HbPMyM0CRpTaoRd
 JAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624057; x=1769228857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0FbB8dK4EiizAZXE9IV2Z8FiC4c35NhVdV2ncAsdOE=;
 b=eL7+DZXli3NmwsQJ9hFO8WuwiexjJnxlvjoVp2Py9ynR8s1RE1HOZkzpmLf+6/0yN6
 lJ4lzSgrVFAsd2+iFVG77aBqSBk9BPQJJkMtIZJqkaDt3hgfs3nlTT3s0k3KGroA83z4
 MOpxUMgtvg6rtjjC4wH03qmzLogB5eWSDZXK199iXtRJtIeJPWvne8DHzn5UjM2B7hHH
 Zmis7qJCZey3f4gxdyjhifhAbTJPYL3dT5wrZp1swnWz8BqoHOAvXUQv+YyixmkdY6m/
 G2ZobaiUMvkNj1QjumJKbvrxy5Smyt0EeaRADsNDq242lLDgngl+4AW8Dj6tReW6LlTC
 MqQw==
X-Gm-Message-State: AOJu0Yx8OsZ1H6b9XSlTRy1QIDsaSwfr1nJm6Esp51coApcaWG2g9iLK
 BpCEg6TEHYGcmlNM9Cm1mSm0FCib/noFcZ3nlvXnS+NrjLAAm1hlydUU
X-Gm-Gg: AY/fxX5Bk+o0PYhtqjMiGlpJ+irv0/VE84HzITIU3XlWqflyW6Gb63ZJAQBq/STvUE3
 6AMwQS44MwLQt4XJdUDnF9g911m4ag+9xuxe+Ph4WhMo20NtNUpN4Mj6TDWCbozfltthxesqXyg
 vpHYBnOwhnHJlDHBlUe+5W6xPFBFFwnvGM7bQ3kDgyh0ISJN/oNHTU23JajUA/4HjZzNMj0l4AG
 n8POIjvSrqsjgooJ5RtBatNutjpSbV55ES/zgQJY1P1GjFlvvuZRnop8uH/mr73Uf8NP25sOeyk
 A78VUYpBsttcyr/3cMc3Z1cbQqhemePn1+bWRgEFgfZ/+d8mcCjaPOglBOh/J1cF9ppYyXT0Kjk
 gTKeofSGB4lws2COmcykBVFnW4gw/QU7zoOvF6rnKymx6kQSkI4DDtBwbJY5eV3csBP7gWDv/NM
 04YaqkCVh1omlk+TQir45PYf2d0PR90Nw32OQSc0iO6KJVNjT0LoEFyIBn1IDvOUatwEuLik+9
X-Received: by 2002:a05:6a00:4f8e:b0:81f:49cc:ea11 with SMTP id
 d2e1a72fcca58-81fa03b3b73mr4363863b3a.65.1768624057152; 
 Fri, 16 Jan 2026 20:27:37 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:36 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 0/8] riscv: add initial sdext support
Date: Sat, 17 Jan 2026 12:27:21 +0800
Message-ID: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Hi Daniel,

This RFC series adds a minimal CPU-side model for Sdext and Sdtrig in
RISC-V QEMU. It is based on RISC-V Debug Specification 1.0:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.

Current status:
- Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
- EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
- Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
  It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags.":
  https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/
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

Thanks,
Chao


Chao Liu (8):
  riscv: split sdext and sdtrig config bits
  riscv: add sdext debug CSRs state
  riscv: add sdext Debug Mode helpers
  riscv: add dret instruction
  riscv: add sdext enter Debug Mode on ebreak
  riscv: add sdext single-step support
  riscv: add sdtrig trigger action=debug mode
  tests: update riscv64 virt RHCT

 include/exec/translation-block.h              |   3 +-
 target/riscv/cpu.c                            |  23 ++-
 target/riscv/cpu.h                            |  10 ++
 target/riscv/cpu_bits.h                       |  33 ++++
 target/riscv/cpu_cfg_fields.h.inc             |   2 +
 target/riscv/cpu_helper.c                     |  93 ++++++++++++
 target/riscv/csr.c                            | 142 +++++++++++++++++-
 target/riscv/debug.c                          |  58 ++++++-
 target/riscv/helper.h                         |   3 +
 target/riscv/insn32.decode                    |   1 +
 .../riscv/insn_trans/trans_privileged.c.inc   |  24 ++-
 target/riscv/machine.c                        |  12 +-
 target/riscv/op_helper.c                      |  72 +++++++++
 target/riscv/tcg/tcg-cpu.c                    |  34 +++--
 target/riscv/translate.c                      |  16 +-
 tests/data/acpi/riscv64/virt/RHCT             | Bin 416 -> 422 bytes
 16 files changed, 492 insertions(+), 34 deletions(-)

-- 
2.52.0


