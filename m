Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CB1CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENvO-0001KE-Rn; Wed, 07 Oct 2026 05:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9u-00017n-Lt; Wed, 07 Oct 2026 04:37:54 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9s-0006Vu-Bb; Wed, 07 Oct 2026 04:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=aJxLXG2QPDWUeRGEY2u0YENEyTQUou+AGyT4kYhvNXI=; b=GXaRajZ6UCRS8v9
 vKdjwKFmtiZf8Tcsn7rMoQrxpsb2CPbQ+CnnASK56Bz8MlF/Ew3atrIc3FbF+RnjMfASdDHO2z+pl
 A/Y8pjOduVVKutqYuEzXsvYa+FzYw4dusCR2FZxSx4pIunSOh4yBLgYsvz+lzBn8BG9h4hJ3lEFbO
 Vg=;
Subject: [PATCH v2 00/18] single-binary: target/riscv, compile subset of
 compilation units once
Date: Wed, 07 Oct 2026 10:43:06 +0200
Message-Id: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WPSw6DMAwFr1JlXVeOwy+seo+KBR8D2QBNIG2Fu
 HsDLFjOkzUar8KxNexEfluFZW+cGYcAdL+Jui+HjsE0gQUhJagoBuuh4WaZgCqKVKojXVMmwvl
 kuTXfQ/UqTrb8XoJxPsdLGPxIsSSJ0H/AGld7qKcFzDADJpwxS81aYe6V2FW9cfNof0ekl4dr7
 5GI8urxEhC4THSFadk2Sj7DP4+hE8W2bX/VIE6Z6AAAAA==
X-Change-ID: 20260325-rv-dedup-2b2437949c28
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362619; l=3137;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=zuq5AHDUS3aHHC13T97HdzUolczYlcXuP61ctiuArRM=;
 b=loIhaLPxbHXougds8Tz2ioMlK7D0CcwZhxndrMr4yTEiPiHYjKYkYkhC0bUEdrmGeEmqsSVNL
 mO1V1oedymCB9cDTqOEYSqbGVGj9g+YyDrEYjaEA7uCdId8L4ZMuadk
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All compilation units which do not pull in helper definitions are
compiled once for system mode by widening target_ulong to
uint64_t.

This series is motivated by the fact that riscv64 already handles
XLEN == 32 as a subset of the 64-bit ISA.  As such we can reduce
duplicate compilation units by moving towards riscv64 as default.

If anyone more familiar with riscv is aware of differences between XLEN
== 32 on riscv64 vs riscv32, please do let me know. No behaviour change
is intended compared to riscv32.

Based on: 20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v2:
- Define BARE/MAX cpus using separate tables indexed by
  target_riscv64(), similar to arm.
- Moved monitor.c HMP field formatting to printf specifiers to retain
  field widths (Philippe).
- Link to v1: https://lore.kernel.org/qemu-devel/20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng

---
Anton Johansson (18):
      target/riscv: Make internals.h target agnostic
      target/riscv: meson, add user and common system source sets
      target/riscv: Move pmu CSR read to csr.h
      target/riscv: Make debug.c target agnostic
      target/riscv: Widen CSR ops to 64-bit and compile once for system-mode
      target/riscv: Runtime CPU registration
      target/riscv: Runtime register MAX and BARE CPUs
      target/riscv: cpu.c unconditionally check larger MXL
      target/riscv: Stub KVM functions for machines.c/cpu.c
      target/riscv: Compile cpu.c once for system-mode
      target/riscv: Compile cpu_helper.c once for system-mode
      target/riscv: Compile tcg-cpu.c once for system-mode
      target/riscv: Compile riscv-qmp-cmds.c once
      target/riscv: Compile pmp.c once
      target/riscv: Compile arch_dump.c once
      target/riscv: Compile machine.c once
      target/riscv: Compile time_helper.c once
      target/riscv: Compile monitor.c once

 target/riscv/internals.h            |  31 +-
 target/riscv/tcg/csr.h              |  37 +-
 target/riscv/tcg/debug.h            |  11 +-
 target/riscv/tcg/pmu.h              |   3 -
 target/riscv/tcg/vector_internals.h |   5 +-
 target/riscv/arch_dump.c            |  13 +-
 target/riscv/cpu.c                  | 255 ++++++++-----
 target/riscv/gdbstub.c              |   2 +-
 target/riscv/kvm/kvm-stub.c         |  21 +
 target/riscv/machine.c              |  10 +-
 target/riscv/monitor.c              |  91 +++--
 target/riscv/tcg/cpu_helper.c       |  79 ++--
 target/riscv/tcg/csr.c              | 736 ++++++++++++++++++------------------
 target/riscv/tcg/debug.c            | 150 ++++----
 target/riscv/tcg/mips_csr.c         |  12 +-
 target/riscv/tcg/op_helper.c        |   6 +-
 target/riscv/tcg/pmp.c              |  19 +-
 target/riscv/tcg/pmu.c              |   9 +-
 target/riscv/tcg/tcg-cpu.c          |   8 +-
 target/riscv/tcg/th_csr.c           |   6 +-
 target/riscv/tcg/vector_helper.c    |  64 ++--
 target/riscv/meson.build            |  18 +-
 target/riscv/tcg/meson.build        |  21 +-
 23 files changed, 847 insertions(+), 760 deletions(-)


