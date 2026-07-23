Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D75C4452B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmkpF-0002WC-5A; Thu, 23 Jul 2026 00:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1wmkpD-0002Vr-7m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:14:23 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1wmkp3-0007oH-Bm
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:14:16 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81ed073fed0so1937137b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 21:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784780051; cv=none;
 d=google.com; s=arc-20260327;
 b=N5T5ITqN8TLkj2dHpwDG36pHih0DicimhGQIGGNNn5NDCp8J3KpxSjmbXnNY3A/9LW
 a23Rs8BxSUYOlpVOly14LkL0B4zDyNLoGRV209H/LfEcy+Fkn9cf0+JBXqLAEQO/4MT7
 7FKM6LzSuXz7WKYZ15y241MIVB8TM2KMmeOUTrQq/ObPcyZ5jlcF9GdXEFrXLeUIGzyo
 8mwJCsPteUQWx+x5autgFdW7OEqZHfmu8yrdvqbTefc8nKCKDhK1Aa2gz1CjP6oGYufy
 Aa7BTVmg3l6UO5eqYZeOiol9ZBV3yHSZ4e5mOKcLNBb4jEc92TAuulXgBiK4mqorDJSF
 +AFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/1dbRvGchufgc9GeL60Y30E5sq5Z/5ej3MLrv6SxgjE=;
 fh=Ka2BEepvMY/2XS6uCw+CsJHUs2FeeiPjQxobS0KU0UU=;
 b=kpXyeKXPNArleDQN+Adycd+vR2OgsFiOYqW3Sooj2wETVH5sFFUM6V4tjrAlM9jMhu
 AB2EYsGQInP4R49OdJ/slQmi35Apt7zVb1NwemuzvtMDs8HwI4Mve/4PEulbEnzU/Qnz
 Ltgki7FYHKAKxqRnO8ffIhmuIEhkZSipvIu7cnpwwhLppIobwMp0VP/xmMNf0JYQfs+0
 jG/j6/QPJ7M3aiObflhQ7AnwALkRNNtoV0dnBWaxQVRGYjo8WL1Bdl0w6d9k3WFqlpzk
 T3/pAe7JI5wCt2YuTWaZjmTYA9hcUpY8V119zCvSgmjA0aE/7KqvEnS5lEy1w8ri0IXT
 swHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=summations-net.20251104.gappssmtp.com; s=20251104; t=1784780051; x=1785384851;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/1dbRvGchufgc9GeL60Y30E5sq5Z/5ej3MLrv6SxgjE=;
 b=YwGSDKtNK0jURnUXPKKQRVQ93w6qzl0N6D1WSlfqG5g6IgnSwNJtNTg9upGTIdQPKl
 zvCC8EoQvysxB6jn5z3ZrRd0AJv9Q0bc1VIbUUsKm247hp06bOAmA8rZgzj2eeBGJ6w9
 gdpt6pgI5+34ujXf+IzRycenwcmsdAKKb/uTvgvcQrT+5NTr4CTP6tZZTy5DANKODEYW
 nuwyCMvygyEUy3I6TcxWFL3417d2EBI9sbJMMQD0pQsmwak/pZSVYEQa8W+66Pepy0s2
 FkJ9VwpWnYHe8xWl+5MGTNzIk7I1beljSQ43fyHymFbV6+wijVpP7S03z3oter1AImRK
 bsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784780051; x=1785384851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/1dbRvGchufgc9GeL60Y30E5sq5Z/5ej3MLrv6SxgjE=;
 b=rKoWCAPu2fTyxyKZByAQ9XHErTY9b4ei2u2FXO9+foyUnLrl4ZGduMNCJZ8CUzXXNP
 S2qO0W1xgahY4rrzCafcAFWVpJPigYlMFITSjYRHK/pRtqEFNXY/amd/FMBK7BdF7ouq
 juh4EraljrX5VYPO0jyCWokTfn2sDTTuSmL2su2yPkFeJtW0vZpOXuL2U0X40R2B+cn2
 oQfma8D9UF5g+GlPIa0nnWbc5MSqpqlv9bXet7NUShTApTgMxLzIiV9ZZJ0/K4dlU/4V
 HG/mQ4TtOrrMY0/9wPIkiTKBLQ2vUqR8F+U25hNKfdnlZP6Q+xxTAYNN1tEjY+8mVlyP
 vCNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9BSkzwsCtUybkCi4lxy/Bt+qV0dS6xsrIy5yL+rOcStHNf1TsBAb9fDI7suELoaGYNnH9OqFPvXys@nongnu.org
X-Gm-Message-State: AOJu0YydTIc0WWIleC7YXRpEsDQRykfEAEgr2aAPkB8khmQbYjb05i5I
 yiCX81+booAnnajo2S1u5g7hhjc7T0IMm6kdwTgt1Xy5hFE1pLSNLDnuoaUvQjJDnG1CdMmWo7h
 wR/aG4owYdQoFiZRPPBqdUf4RLyYBKl8p7YLEeuUgKy4=
X-Gm-Gg: AR+sD10UWeBBSmvSehQvXmksFEf/hYL2NMTLeMgpCaqCW4kTqAm4K3K3L7T9+kmxD9z
 qEBM9u3QXvGpSmOtE2Ez4Pkl+ybtRmmfs872Ov7HsEWRy8Fp3y9cMyNWAoSjfVTYod9uat9HBBG
 M94GI9xKRgXlp+DcmkHFFpFSqgTKeQ4pzgcptaHELdEvKcz7rgK7MPhOZaX3R5JxZm2IrBm6Z9b
 hUixJWOsvGK7arTiL8JZP8pfjcaxjQxQgeWVdJMQpehx5vVTzTYVbIxNl90Rwq2wgBgpigz0F/Z
 ZO0xVdXdQB0FfdtjpqOHb4ZZh42NNR1gIC+hLWVDSXzpO5Lb8x6884dehHW5gA==
X-Received: by 2002:a05:690c:e3c7:b0:814:651e:a553 with SMTP id
 00721157ae682-81f4c1d5e98mr4149257b3.28.1784780050925; Wed, 22 Jul 2026
 21:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
 <a568614fb2f7221583bbcc2c67cf7282d50e4d83.camel@alistair23.me>
 <db11d478-c0cb-4ca6-b7b4-3f53b281452b@linux.alibaba.com>
 <8cc10b77-22a0-40f0-b883-5d3491248fac@oss.qualcomm.com>
 <705186b9-dd43-4e8e-ba42-0b6d0af05081@linux.alibaba.com>
In-Reply-To: <705186b9-dd43-4e8e-ba42-0b6d0af05081@linux.alibaba.com>
Date: Thu, 23 Jul 2026 09:43:57 +0530
X-Gm-Features: AUfX_mx2w8tmlEr7phMRnY00XtbgWlyevpye4TQraJDGBtDtZAtwp68uahGrNpM
Message-ID: <CABdD5xnzP=mYH3n8Uexfka0G+JbceKxSt=T=4LzjvGfCF4BctQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair <alistair@alistair23.me>, 
 qemu-devel@nongnu.org, xiangyi.zeng@linux.alibaba.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, chao.liu.zevorn@gmail.com, liwei1518@gmail.com, 
 qemu-riscv@nongnu.org, cxx194832@alibaba-inc.com, 
 rahul.pathak@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=rahul@summations.net; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-to:  Rahul Pathak <rahul@summations.net>
From:  Rahul Pathak via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhiwei,

A.
The mmpt probe in OpenSBI was deliberately set to detach
the mode and sdid write dependency.
Spec says mmpt=3DBare then SDID and PPN must be 0
but it doesn't say whether this check is handled by hardware or software.
and upto the interpretation.

B.
Also, in your Qemu patch series, the mfence/minval encodings are different
from what they are suggested by the authors of SMMTT spec.
Please check the PR raised here in riscv-opcodes
https://github.com/riscv/riscv-opcodes/pull/389/

I understand that this is not fixed yet. However, in OpenSBI I chose to
use the same values as in the PR.

Though I haven't fully reviewed your patches,

If I change point A in OpenSBI and change point B in your Qemu,
I can make OpenSBI SMMPT work with your V7 Qemu SMMPT.

I agree with Daniel and appreciate that you agree to collaborate
and not duplicate efforts.

I can send a V2 of my OpenSBI series with the change of point A
and you can update the Qemu with at least the current proposal
encodings as defined in the PR in riscv-opcodes. This will
align both OpenSBI and QEMU SMSDID+SMMPT changes.

Thanks
Rahul

On Thu, Jul 23, 2026 at 9:17=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
>
> On 7/23/26 3:52 AM, Daniel Henrique Barboza wrote:
> >
> >
> > On 7/22/2026 12:11 AM, LIU Zhiwei wrote:
> >>
> >> On 7/22/26 8:56 AM, Alistair wrote:
> >>> On Wed, 2026-07-15 at 22:50 +0800, LIU Zhiwei wrote:
> >>>> This patch set introduces support for the RISC-V Smsdid and Smmpt
> >>>> (Supervisor Domain Identifier and Memory Protection Table) extension=
s
> >>>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
> >>>> Smmpt provides a hardware mechanism for fine-grained memory
> >>>> protection,
> >>>> checked after address translation, which is particularly useful for
> >>>> supervisor-level sandboxing and security monitoring.
> >> Hi Alistair,
> >>> Can you include a link to the upstream submitted patches to use this
> >>> functionality
> >> Xiangyi is currently working on OpenSBI support for SMMPT, and we
> >> already have an internal implementation in place. We plan to upstream
> >> the OpenSBI support as soon as possible, and once that is done, I=E2=
=80=99ll
> >> be able to include a link here.
> >
> Hi Daniel
> > Please be aware that Rahul already sent OpenSBI patches for smmpt and
> > smsdid:
> >
> > [RFC PATCH 0/5] Add Smsdid and Smmpt supervisor domain protection
> > https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
> >
> > In fact, as I said in another thread [1], Rahul also has a QEMU
> > implementation of his own.
> > His OpenSBI patches works with his QEMU changes:
> >
> > https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
> Thank you very much for pointing this out and for coordinating between
> us. I was not aware of Rahul's OpenSBI patches and QEMU implementation.
> >
> > But seems like his OpenSBI patches does *not* work with this QEMU patch=
es,
> It seams probe_sdidlen in OpenSBI write a sdid to mmpt with bare mode.
> According to the specification, in bare mode, "The remaining fields in
> mmpt (SDID, PPN) must
> be set to zeros.
> >  but works
> > with his QEMU implementation.  Seems like there might be things to
> > improve in both
> > implementations.
> >
> > I asked him to not send his QEMU patches on top of yours because I'd
> > rather work in
> > collaboration on top of a single series, and I advise to not send
> > another OpenSBI support
> > for the same stuff in that mailing as well.
> >
> > IMO you and Rahul should sync up in both OpenSBI and QEMU bits to
> > avoid effort duplication
> > on both sides.
>
> I agree with your suggestion that it is better to avoid duplicated
> effort and collaborate on a single direction for both the QEMU and
> OpenSBI sides.
>
> Since the SMMPT v0.4.9 specification is already close to stabilization,
> and implementation work has already started in both OpenSBI and QEMU, I
> believe we should be able to converge quickly through collaboration and
> help move SMMPT upstream sooner.
>
> Xiangyi and I will continue to review Rahul's OpenSBI patches to
> understand the current differences and why they are not yet compatible
> with our QEMU series. I will also reach out to Rahul directly so that we
> can sync up and work toward a common implementation.
>
> Thanks again for the pointers.
>
> Best regards,
> Zhiwei
>
> >
> >
> > Cheers,
> > Daniel
> >
> >
> > [1]
> > https://lore.kernel.org/qemu-devel/2e2de5da-9eb0-4d56-b193-d8b06b7a3512=
@oss.qualcomm.com/
> >
> >
> >>
> >> Thanks,
> >> Zhiwei
> >>>
> >>> Alistair
> >>>
> >>>> The rfc patch set:
> >>>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> >>>>
> >>>> v6->v7:
> >>>>      The implementation is updated from the v0.3.4 specification to
> >>>>      v0.4.9. The main changes are:
> >>>>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
> >>>>      2. Update the mmpt register layout: the SDID and PPN field
> >>>> positions
> >>>>         changed and the RV64 PPN is now 44 bits.
> >>>>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2=
,
> >>>> the
> >>>>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a
> >>>> single
> >>>>         XWR tuple plus a G granularity field, and non-NAPOT leaf
> >>>> entries
> >>>>         hold per-page XWR tuples.
> >>>>      4. Treat XWR=3D000 as "no access" and a non-leaf entry with N=
=3D1 as
> >>>> a
> >>>>         fault.
> >>>>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits
> >>>> zero).
> >>>>      6. Rename the fence instructions mfence.spa/minval.spa to
> >>>>         mfence.pa/minval.pa.
> >>>>      7. Drop stale Reviewed-by tags on the substantially reworked
> >>>> patches.
> >>>>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
> >>>>      9. Add disassembly support for the Smmpt.
> >>>>      10. Add bare-metal M-mode system tests.
> >>>>      11. Rebase to master.
> >>>>
> >>>> v5->v6:
> >>>>      1. Use explicitly bit fields extract instead of mpte_union_t.
> >>>>      2. Use the same exception behavior for MPT valiation as PMP
> >>>>         valiation.
> >>>>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
> >>>>      4. Use address_space_*_le instead of address_space_* for SMMPT.
> >>>>      5. Only print SMMPT address check log when SMMPT is enabled.
> >>>>      6. Add implied rule for SMMPT as it depends on SMSDID.
> >>>>      7. Rebase to master.
> >>>>
> >>>> v4->v5:
> >>>>      1. Rebase to master.
> >>>> v3->v4:
> >>>>      1. Add missing review tags.
> >>>> v2->v3:
> >>>>      1. Fix build error in patch 2.
> >>>>      2. Rebase to master.
> >>>>
> >>>> rfc->v2:
> >>>>      1. When ext_smmpt is false or BARE mode, make other fields in
> >>>> mmpt
> >>>>         CSR zero.
> >>>>      2. Add patch 5 to fix smrnmi ISA string order.
> >>>>      3. Fix patch 6 smmpt and smsdid ISA string order.
> >>>>      4. Make smmpt and smsdid experiment extensions.
> >>>>      5. Add review tags.
> >>>>
> >>>> LIU Zhiwei (11):
> >>>>    target/riscv: Add basic definitions and CSRs for SMMPT
> >>>>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
> >>>>    target/riscv: Implement core SMMPT lookup logic
> >>>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
> >>>>    target/riscv: Implement SMMPT fence instructions
> >>>>    target/riscv: Fix smrnmi isa alphabetical order
> >>>>    target/riscv: Add disassembly for Smmpt instructions and CSRs
> >>>>    target/riscv: Enable SMMPT extension
> >>>>    target/riscv: Add system test for SMMPT extension
> >>>>    target/riscv: Add system tests for Smmpt52 and Smmpt64
> >>>>    target/riscv: Add system test for Smmpt34
> >>>>
> >>>>   disas/riscv.c                                 |   9 +-
> >>>>   target/riscv/cpu.c                            |  60 +++-
> >>>>   target/riscv/cpu.h                            |   8 +
> >>>>   target/riscv/cpu_bits.h                       |  27 ++
> >>>>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
> >>>>   target/riscv/insn32.decode                    |   2 +
> >>>>   target/riscv/meson.build                      |   1 +
> >>>>   target/riscv/riscv_smmpt.c                    | 339
> >>>> ++++++++++++++++++
> >>>>   target/riscv/riscv_smmpt.h                    |  26 ++
> >>>>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
> >>>>   target/riscv/tcg/csr.c                        | 106 ++++++
> >>>>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
> >>>>   target/riscv/tcg/pmp.h                        |   3 +
> >>>>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
> >>>>   tests/tcg/riscv64/smmpt-common.S              | 256 +++++++++++++
> >>>>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
> >>>>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
> >>>>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
> >>>>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
> >>>>   19 files changed, 1353 insertions(+), 19 deletions(-)
> >>>>   create mode 100644 target/riscv/riscv_smmpt.c
> >>>>   create mode 100644 target/riscv/riscv_smmpt.h
> >>>>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
> >>>>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
> >>>>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
> >>>>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
> >>>>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
> >>>>
> >>>>
> >>>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> >
>

