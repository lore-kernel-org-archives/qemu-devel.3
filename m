Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD78DC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFss-0001pL-D6; Wed, 12 Feb 2025 11:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tiFsq-0001oQ-Of
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:46:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tiFso-0004Aa-8B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:46:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso21993605e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739378800; x=1739983600;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24PKVHuS4ZAYJK70bA/hwkOnVsBJ4u5HfgzoQC2RTT0=;
 b=W7Z+NmCVf9Ziz4gbYc2UdHBZ3ugQG54foY+56dTUpacbR+lPUwpRj41lATJXwPbIHg
 1EgET2AUtv8GNLvFutRGXoSce/V1vyruQmO3cbrfMSFAZq0vsmfyYw1L9MS0TOr318FV
 C6MDHRpOtYBg0MLOJ3gUBKm19h4cOycueqtcc8gaeWA4vEyXB1qj+ZkcESN/s/WjB046
 iuDI/CuhMxox3oLytUe5IHKrG2g+DafntxN+EUYDM91jjwki/cfCjFId422qWaIwSy0G
 qHYfNEACrO1/QJgQyBraLpuMHAJadbAz2c+EmHOaC+8OBp1CGLYOPn8oij/VUyZK71se
 zobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739378800; x=1739983600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24PKVHuS4ZAYJK70bA/hwkOnVsBJ4u5HfgzoQC2RTT0=;
 b=RQbxqWdkIhIVBOZzJhabwOb+3oymHFKEDvWY8/lne1BtIRwcE2Ggne0dPgzz2LdzNm
 mLf7zFbof9aOvqobwHMpn5uyRLA0pRF5QJSj+rrCRMoscVMFzHLyFlK5nXzmZZtTV2lx
 jxqtyp00TJr4nbmpRDI/V7CG+Ts/9nHSbDRbA2eqaVA/FZ1ujuwc73bG7XyxiJnTJ/DQ
 gqGSg39mfR7O1iPam41D7yHR9QP3vox0rPwF/hKuBS8HKk2D+4H261fH3xC/3SAnUKxJ
 nevKg7ZapR0qy9g+nky4L0fMNld5nrfj/SKt0wgaOrob7CjkFq2n9c03eNj6/YIsWV1k
 ECMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlyuCMlo556kSdDpLHlM6cens8h4f0rfbN2JXhZH+4N+YRDx40OG5/8CWpB3JOKqS4kE2dn3qxf6vW@nongnu.org
X-Gm-Message-State: AOJu0Yy824HBJhxE2AzlIdcbdZbrD0ReYfNjUGygMlei1ctzayHB0VKi
 OtqsdpVjJWUqGKHto8zhX3AzDSQnbBGnVx3r8z3WGSC1mI94R8s1kNFPrNQ7z/XEtMiZfpObUfP
 JlVBnn8GT/vfYuuz4CciH877jgP4hep9o5RP8WQ==
X-Gm-Gg: ASbGncsPX4mGVQ5ny6N4r/gKSrv8g+HX7sRgDP20tiwuS2LlSY0hTdafDW223/pkUgP
 9O+AavepnHRJQ0aqX5ApOlFy+Su1fmXZwFUkhF+bKVF8KkM5Tad07B8xJ/PnTGd2FAWVhVqg=
X-Google-Smtp-Source: AGHT+IFtPXyrUyCEbjlMsgdX6XJrDOCippKexiYhU2tJ6R29xwg/eY7oH8RlshfMH/AJ/IcN9YvAd592Kzk5EaY33r0=
X-Received: by 2002:a05:6000:1a85:b0:38d:e3a9:d641 with SMTP id
 ffacd0b85a97d-38f244dfe03mr81315f8f.16.1739378799801; Wed, 12 Feb 2025
 08:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
 <CAKmqyKMhV8Nj2oUmD_vWCnZBjJgYcw=8CQ86P2jihy0S09TXTQ@mail.gmail.com>
 <CAECbVCubhhy4y8oJPGiW5r322Uv02oOyKY4e+qWSMFNfbgx8yQ@mail.gmail.com>
 <CAKmqyKNaxUn_99=+3EsCiE48Qx+64Lu=ybR1asGscP_UiPxnxw@mail.gmail.com>
In-Reply-To: <CAKmqyKNaxUn_99=+3EsCiE48Qx+64Lu=ybR1asGscP_UiPxnxw@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Wed, 12 Feb 2025 16:46:29 +0000
X-Gm-Features: AWEUYZmSXzl_aGlP3DJiaShtRlhyF-XxX9bcjHDs8k3UNqYexCePlFbqbem85oA
Message-ID: <CAECbVCs==KyUB0LUyeqPSoy2d9rj1dH_Dw+XpVqpNjTL1mjEuA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32a.google.com
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

On Mon, Feb 10, 2025 at 4:11=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Feb 6, 2025 at 9:45=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
> >
> > On Thu, Feb 6, 2025 at 5:39=E2=80=AFAM Alistair Francis <alistair23@gma=
il.com> wrote:
> > >
> > > On Wed, Feb 5, 2025 at 9:21=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosi=
nc.com> wrote:
> > > >
> > > > This series enables Control Transfer Records extension support on r=
iscv
> > > > platform. This extension is similar to Arch LBR in x86 and BRBE in =
ARM.
> > > > The Extension has been ratified and this series is based on v1.0 [0=
]
> > > >
> > > > CTR extension depends on both the implementation of S-mode and Sscs=
rind
> > > > extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata =
CSRs using
> > > > sscsrind extension.
> > > >
> > > > The series is based on Smcdeleg/Ssccfg counter delegation extension=
 [2]
> > > > patches [3]. CTR itself doesn't depend on counter delegation suppor=
t. This
> > > > rebase is basically to include the Smcsrind patches.
> > > >
> > > > Here is the link to a quick start guide [4] to setup and run a basi=
c perf demo
> > > > on Linux to use CTR Ext.
> > > >
> > > > Qemu patches can be found here:
> > > > https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v6
> > > >
> > > > Opensbi patch can be found here:
> > > > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
> > > >
> > > > Linux kernel patches can be found here:
> > > > https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
> > > >
> > > > [0]: https://github.com/riscv/riscv-control-transfer-records/releas=
es/tag/v1.0
> > > > [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/rele=
ases/tag/v1.0.0
> > > > [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases=
/tag/v1.0.0
> > > > [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation=
-v4-0-c12a89baed86@rivosinc.com/
> > > > [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic=
-demo-on-QEMU-RISC%E2%80%90V-Virt-machine
> > > >
> > > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > > > ---
> > > > Changelog:
> > > > v6: Rebased on latest riscv-to-apply.for-upstream.
> > >
> > > It should be rebased on
> > > https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> > >
> > > I applied the first 6 patches as they apply cleanly
> > >
> > > Alistair
> > >
> >
> > Sorry for the inconvenience. Strangely cherry-pick, patch and git am -3
> > all seem to work fine but git am seems to be failing.
> >
> > I looked into the conflict and it looks like am expects
> > ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> > but gets this in cpu.c.
> > ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
> >
> > I have tried following cmds on top of riscv-to-apply.next and these
> > fetch the last patch
> > only and apply the last patch perfectly fine.
> >
> > b4 am -i  -P=3D"-1" 20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivos=
inc.com
> > git am -3 ./v6_20250205_rkanwal_target_riscv_add_support_for_control_tr=
ansfer_records_ext.mbx
>
> The threeway merge is failing for me
>
> >
> > If you want I can send v7 as well rebased on top of riscv-to-apply.next=
.
>
> Yes please :)
>
> Alistair
>

Here is the link to v7.
https://lore.kernel.org/qemu-riscv/20250212-b4-ctr_upstream_v6-v7-1-4e8159e=
a33bf@rivosinc.com/

Thanks
Rajnesh

> >
> > Thanks
> > Rajnesh
> >
> > > >
> > > > v5: Improvements based on Richard Henderson's feedback.
> > > >   - Fixed code gen logic to use gen_update_pc() instead of
> > > >     tcg_constant_tl().
> > > >   - Some function renaming.
> > > >   - Rebased onto v4 of counter delegation series.
> > > >   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-=
v5-0-60b993aa567d@rivosinc.com/
> > > >
> > > > v4: Improvements based on Richard Henderson's feedback.
> > > >   - Refactored CTR related code generation to move more code into
> > > >     translation side and avoid unnecessary code execution in genera=
ted
> > > >     code.
> > > >   - Added missing code in machine.c to migrate the new state.
> > > >   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce=
6bef9432@rivosinc.com
> > > >
> > > > v3: Improvements based on Jason Chien and Frank Chang's feedback.
> > > >   - Created single set of MACROs for CTR CSRs in cpu_bit.h
> > > >   - Some fixes in riscv_ctr_add_entry.
> > > >   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
> > > >   - Improved extension dependency check.
> > > >   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
> > > >   - Added implied rules for Smctr and Ssctr.
> > > >   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 wri=
te ops.
> > > >   - Some more cosmetic changes.
> > > >   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-=
v3-0-32fd3c48205f@rivosinc.com/
> > > >
> > > > v2: Lots of improvements based on Jason Chien's feedback including:
> > > >   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
> > > >   - Fixed and added more CTR extension enable checks.
> > > >   - Fixed CTR CSR predicate functions.
> > > >   - Fixed external trap xTE bit checks.
> > > >   - One fix in freeze function for VS-mode.
> > > >   - Lots of minor code improvements.
> > > >   - Added checks in sctrclr instruction helper.
> > > >   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkan=
wal@rivosinc.com/
> > > >
> > > > v1:
> > > >   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkan=
wal@rivosinc.com/
> > > >
> > > > ---
> > > > Rajnesh Kanwal (7):
> > > >       target/riscv: Remove obsolete sfence.vm instruction
> > > >       target/riscv: Add Control Transfer Records CSR definitions.
> > > >       target/riscv: Add support for Control Transfer Records extens=
ion CSRs.
> > > >       target/riscv: Add support to record CTR entries.
> > > >       target/riscv: Add CTR sctrclr instruction.
> > > >       target/riscv: machine: Add Control Transfer Record state desc=
ription
> > > >       target/riscv: Add support to access ctrsource, ctrtarget, ctr=
data regs.
> > > >
> > > >  target/riscv/cpu.c                             |  26 ++-
> > > >  target/riscv/cpu.h                             |  13 ++
> > > >  target/riscv/cpu_bits.h                        | 145 ++++++++++++
> > > >  target/riscv/cpu_cfg.h                         |   2 +
> > > >  target/riscv/cpu_helper.c                      | 266 +++++++++++++=
+++++++++
> > > >  target/riscv/csr.c                             | 294 +++++++++++++=
+++++++++++-
> > > >  target/riscv/helper.h                          |   2 +
> > > >  target/riscv/insn32.decode                     |   2 +-
> > > >  target/riscv/insn_trans/trans_privileged.c.inc |  18 +-
> > > >  target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++
> > > >  target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++
> > > >  target/riscv/machine.c                         |  25 +++
> > > >  target/riscv/op_helper.c                       |  48 ++++
> > > >  target/riscv/tcg/tcg-cpu.c                     |  11 +
> > > >  target/riscv/translate.c                       |  46 ++++
> > > >  15 files changed, 986 insertions(+), 8 deletions(-)
> > > > ---
> > > > base-commit: 699291ba7774f1580584cd96f84ceda8cc4edb7e
> > > > change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
> > > > --
> > > > Best Regards,
> > > > Rajnesh Kanwal
> > > >
> > > >

