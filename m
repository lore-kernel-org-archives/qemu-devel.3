Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A82C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0K0-0004Z1-Qb; Thu, 06 Feb 2025 06:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tg0Ju-0004YP-Pr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:45:24 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tg0Jr-0005bI-AI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:45:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so343695f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738842317; x=1739447117;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZS5RcFLkVoy5OiPEmK/LufMWy48rpCL81gYGwgas8Q=;
 b=VwQZOU5ZLTjeGM+O9IKaSnjVWacMa9e53SLps2Ls8B49Sx2NsIiIhvW5/A8mVu2YbW
 rVN3Olq1d8U8+nFOEJKrmMuzOKnAHVDc609mw6BonzgTz9va3wFjl5VVgEWdgFANE6LP
 dYzP0lW+08I/DPEFSRp0S56m5Jb5OBPH6WLPkrz+hdINHSgkmym6PNDq7E9Wm4z1OPfy
 vfkaw626t5hSBY7Bjve/toI4Dl45YGeGCubnZJDpsgiqPan+ka0zMZsnv+jx8B3XLTG4
 4ThB2YhX2VUOLrymeJ/3BMff6QTztSELNIK5jKT36n5ZPaLMZ5tN3uftlu2ZID1B7Wfy
 NYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738842317; x=1739447117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZS5RcFLkVoy5OiPEmK/LufMWy48rpCL81gYGwgas8Q=;
 b=og3ihHICIeaoQs6A7avuCGIZJRBbuXQBOwG6XMhaiOozGa/eqEE9F/UrAHDL2lhCjx
 NnBV/qShWUIAVrqpzAkz4xhh7q7SoxpSQwaVPQ75mAtIQrxe8r70oY/oM4/3Yd2sy8YJ
 etrc7I0BNuhiIIivA6jfl7tyxINgG/+AHdlvbdN3t+f9+eLuHPvj+oqjNP6ZeltZe5b4
 owpc0carl21rvYMDFcOiSfxKZFJG4KXce8sJZxkfCGY6+At/h8ywUM7ZsQnwEIoTvVEe
 xRl+lfSASU7ZMZZNIaLzZs/v6ZqHYi4ESAaRq003MWUBh2U9C7FKB57dPd+kvpwcpKWf
 t6Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF4CPF9+CwlrZ0isDMJ9TYNBR2p4F7j9nZupKTrmYbwq2vcB6IEIwStvRybDDVAPhvl3FsKoQmbErJ@nongnu.org
X-Gm-Message-State: AOJu0YzQ8q9Oxs7uInnbOXhlZbuajDH6AC7GuXyvUcBxH9N0vaJFXHje
 pnXnKTutt17RQO23phvCg76FFncqfUfH0/mwhILrGAkUsNF5PJ8Z2DdcEqlTqRImyvFSCS8OHzN
 YwwBxF0Y0pYIeuIc91puag5iDZb7vp6S+QYkKpA==
X-Gm-Gg: ASbGnctzEmz2L2CB0KI76MknGdOz+K8ZDNJHbvNt6QXt/zaXGkCZLF0nHBsvJJOSNFm
 7vVqTCkSlymRcJFKLlyJZ+bT97PTrxMuEMG0N/0enmrRXRI3MkNUM9I6BVJn7moGxrLwa92I=
X-Google-Smtp-Source: AGHT+IG1q15/1AMRIV5KmUFZSp7PRvVaOSRYQ3WlHUBKeV3hTokKsmh3dE5OQKNsWOC5+C96qU/h92vM2qAfgLXHlr8=
X-Received: by 2002:a05:6000:154c:b0:385:ec6e:e872 with SMTP id
 ffacd0b85a97d-38db48fdf9bmr6021992f8f.38.1738842316660; Thu, 06 Feb 2025
 03:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
 <CAKmqyKMhV8Nj2oUmD_vWCnZBjJgYcw=8CQ86P2jihy0S09TXTQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMhV8Nj2oUmD_vWCnZBjJgYcw=8CQ86P2jihy0S09TXTQ@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Thu, 6 Feb 2025 11:45:04 +0000
X-Gm-Features: AWEUYZldt30CwD5qEPxoU1nF5WRji2cs23OHaSFb2KCRzw4kyYfRuBZbHHcrVu8
Message-ID: <CAECbVCubhhy4y8oJPGiW5r322Uv02oOyKY4e+qWSMFNfbgx8yQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] target/riscv: Add support for Control Transfer
 Records Ext.
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 6, 2025 at 5:39=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Feb 5, 2025 at 9:21=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
> >
> > This series enables Control Transfer Records extension support on riscv
> > platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> > The Extension has been ratified and this series is based on v1.0 [0]
> >
> > CTR extension depends on both the implementation of S-mode and Sscsrind
> > extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs=
 using
> > sscsrind extension.
> >
> > The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
> > patches [3]. CTR itself doesn't depend on counter delegation support. T=
his
> > rebase is basically to include the Smcsrind patches.
> >
> > Here is the link to a quick start guide [4] to setup and run a basic pe=
rf demo
> > on Linux to use CTR Ext.
> >
> > Qemu patches can be found here:
> > https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v6
> >
> > Opensbi patch can be found here:
> > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
> >
> > Linux kernel patches can be found here:
> > https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
> >
> > [0]: https://github.com/riscv/riscv-control-transfer-records/releases/t=
ag/v1.0
> > [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases=
/tag/v1.0.0
> > [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag=
/v1.0.0
> > [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-=
0-c12a89baed86@rivosinc.com/
> > [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-dem=
o-on-QEMU-RISC%E2%80%90V-Virt-machine
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> > Changelog:
> > v6: Rebased on latest riscv-to-apply.for-upstream.
>
> It should be rebased on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> I applied the first 6 patches as they apply cleanly
>
> Alistair
>

Sorry for the inconvenience. Strangely cherry-pick, patch and git am -3
all seem to work fine but git am seems to be failing.

I looked into the conflict and it looks like am expects
ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
but gets this in cpu.c.
ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),

I have tried following cmds on top of riscv-to-apply.next and these
fetch the last patch
only and apply the last patch perfectly fine.

b4 am -i  -P=3D"-1" 20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.=
com
git am -3 ./v6_20250205_rkanwal_target_riscv_add_support_for_control_transf=
er_records_ext.mbx

If you want I can send v7 as well rebased on top of riscv-to-apply.next.

Thanks
Rajnesh

> >
> > v5: Improvements based on Richard Henderson's feedback.
> >   - Fixed code gen logic to use gen_update_pc() instead of
> >     tcg_constant_tl().
> >   - Some function renaming.
> >   - Rebased onto v4 of counter delegation series.
> >   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0=
-60b993aa567d@rivosinc.com/
> >
> > v4: Improvements based on Richard Henderson's feedback.
> >   - Refactored CTR related code generation to move more code into
> >     translation side and avoid unnecessary code execution in generated
> >     code.
> >   - Added missing code in machine.c to migrate the new state.
> >   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef=
9432@rivosinc.com
> >
> > v3: Improvements based on Jason Chien and Frank Chang's feedback.
> >   - Created single set of MACROs for CTR CSRs in cpu_bit.h
> >   - Some fixes in riscv_ctr_add_entry.
> >   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
> >   - Improved extension dependency check.
> >   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
> >   - Added implied rules for Smctr and Ssctr.
> >   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write o=
ps.
> >   - Some more cosmetic changes.
> >   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0=
-32fd3c48205f@rivosinc.com/
> >
> > v2: Lots of improvements based on Jason Chien's feedback including:
> >   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
> >   - Fixed and added more CTR extension enable checks.
> >   - Fixed CTR CSR predicate functions.
> >   - Fixed external trap xTE bit checks.
> >   - One fix in freeze function for VS-mode.
> >   - Lots of minor code improvements.
> >   - Added checks in sctrclr instruction helper.
> >   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@=
rivosinc.com/
> >
> > v1:
> >   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@=
rivosinc.com/
> >
> > ---
> > Rajnesh Kanwal (7):
> >       target/riscv: Remove obsolete sfence.vm instruction
> >       target/riscv: Add Control Transfer Records CSR definitions.
> >       target/riscv: Add support for Control Transfer Records extension =
CSRs.
> >       target/riscv: Add support to record CTR entries.
> >       target/riscv: Add CTR sctrclr instruction.
> >       target/riscv: machine: Add Control Transfer Record state descript=
ion
> >       target/riscv: Add support to access ctrsource, ctrtarget, ctrdata=
 regs.
> >
> >  target/riscv/cpu.c                             |  26 ++-
> >  target/riscv/cpu.h                             |  13 ++
> >  target/riscv/cpu_bits.h                        | 145 ++++++++++++
> >  target/riscv/cpu_cfg.h                         |   2 +
> >  target/riscv/cpu_helper.c                      | 266 +++++++++++++++++=
+++++
> >  target/riscv/csr.c                             | 294 +++++++++++++++++=
+++++++-
> >  target/riscv/helper.h                          |   2 +
> >  target/riscv/insn32.decode                     |   2 +-
> >  target/riscv/insn_trans/trans_privileged.c.inc |  18 +-
> >  target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++
> >  target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++
> >  target/riscv/machine.c                         |  25 +++
> >  target/riscv/op_helper.c                       |  48 ++++
> >  target/riscv/tcg/tcg-cpu.c                     |  11 +
> >  target/riscv/translate.c                       |  46 ++++
> >  15 files changed, 986 insertions(+), 8 deletions(-)
> > ---
> > base-commit: 699291ba7774f1580584cd96f84ceda8cc4edb7e
> > change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
> > --
> > Best Regards,
> > Rajnesh Kanwal
> >
> >

