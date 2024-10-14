Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC52CFC51B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0H0S-0005qy-KR; Mon, 14 Oct 2024 05:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0H0K-0005po-TU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:04:41 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0H0I-0002Po-N7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:04:40 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so1008180e87.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728896676; x=1729501476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqVnkYfIAsv+ZVCPAY6Ps8OjRI0IRu5BFxaz9+oT6Z4=;
 b=k9errVlJc8u5x/gjs/Zn5Il58ice4ktRbp3ls9XRqfauAYJjn88kiS/SFE7L8+6bEu
 XOzkEIpXDOLNlD7PGCMvL1HFpqgjuFNM124krYafoKRjwF1PZDTOBr6mktGlLUCPZIsD
 7W96PjuiKSNnbU716Zpp2JvYQkxHhshjPwlhG8+Crq59iBUlnGjZVh7QUQJpFxMPlUog
 A2jXF4/VykCQif/Azu/hXfGGkZFfGgTxMzB19YDlwGpaWaxUGmiQ/HIY9UdlkZ99DDL/
 705ezk8DDvGK5Wct9JmBhoZFWsNpcE2va/HMeh0aE7cBIE8TIBRqPPXrZs2+hta+AWkH
 H59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728896676; x=1729501476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqVnkYfIAsv+ZVCPAY6Ps8OjRI0IRu5BFxaz9+oT6Z4=;
 b=edIm1FNlSlDVvg1qO3mImxYLTe/unvX5i7LcM35nIe4zycMG496ZIek2JbbCh/LUdc
 sX0E4ZMeOK1Z4dTwVaz5FZpGrcUEs6H3uFaM7l3s7iP8NQZuGMpzUe3DXZQJ/acDu1St
 hyfUepJ6GX+QlE6xPdeMC1ciWyAo4cGdSLezUPTBf+Yu40pLFzd27PIeckKvOCrJI62Q
 RgRLmCxSf5to6f0+pik41TwXeLBO69enfrnwCJA5LoGCmz59Douv7hDG3QsFY3PWvqpy
 jfU3EpDbuiYXhc0pRMZEpYFIhOO5mdPcY+ICtyWglYyNTubmZjJCyQ+MlAkOiIZwvO2Z
 uGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPbgxacPiuBnKN8jjQM44OJzUW2Kr87zjkcu9Z424HBnzpncnEFfm53ffUFqnY+JXAGNgp/7nPXfx0@nongnu.org
X-Gm-Message-State: AOJu0Yz4hi9nGus1SHLXJwehkvAWH3noJ2r8DtLU1Pd9z54P7fc8lsvl
 O+0DKYRbTklmR/yGfZ7WF+i+b8oM1gwowtW5m5ZykRnydYmOY6a4EU27pKeP2rCOuil2rmO0TvS
 +kINrGCU1csi4Niye7LKIHSEjaveyyvG8pRPWO5QLG21ZDJVfrrW6YBtZ/mdc7+78B6+yTEDOFr
 DfVIWgu8ZwkGLx/xrIwDTSAItJaOXRouuUDK3nIgkZxg==
X-Google-Smtp-Source: AGHT+IESF7CBeh7rZHOBvq9iLyTkcnxmUXIuwutQtxN/dcEICwqghGwDqCJkOPcu4FI/M2O3U4Z6fg==
X-Received: by 2002:a05:6512:2c90:b0:539:e776:71f2 with SMTP id
 2adb3069b0e04-539e7767459mr2314546e87.52.1728896675527; 
 Mon, 14 Oct 2024 02:04:35 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539e790ed4csm847171e87.292.2024.10.14.02.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 02:04:34 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so3872561fa.3; 
 Mon, 14 Oct 2024 02:04:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUskseGLkbb0zsgE3w3isEqcyl1Asn9S2ivww5Z8TS6Q3Gab/NpkqGBMe26r0ho2PifV6M5vJfAlY1H2A==@nongnu.org,
 AJvYcCUvCNzUgbsl5miwhzCFdGX9+elqFBWL/U6o4LH9ygC+oORbPkhYSoYL/EfY9LRvCSMYrvzLQABBHJTQ@nongnu.org
X-Received: by 2002:a05:651c:2127:b0:2fb:4428:e0fa with SMTP id
 38308e7fff4ca-2fb4428e78amr18246521fa.36.1728896674556; Mon, 14 Oct 2024
 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
 <6e7a184f-3b47-480d-bd56-fef2e89beda6@ventanamicro.com>
 <c8460f0c-d82f-414b-b55f-d9f227244a9f@rivosinc.com>
In-Reply-To: <c8460f0c-d82f-414b-b55f-d9f227244a9f@rivosinc.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 14 Oct 2024 17:04:23 +0800
X-Gmail-Original-Message-ID: <CANzO1D2BaPA8gxxKxdk59nYseV9uKZzNR9GiHS+nAict+WSPsA@mail.gmail.com>
Message-ID: <CANzO1D2BaPA8gxxKxdk59nYseV9uKZzNR9GiHS+nAict+WSPsA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] target/riscv: Add Smrnmi support.
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Tommy Wu <tommy.wu@sifive.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, alistair23@gmail.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:36=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
>
>
> On 11/10/2024 13:38, Daniel Henrique Barboza wrote:
> > Hi Tommy,
> >
> >
> > Do you plan to send a new version of this work soon? This series is a
> > prerequisite
> > of "target/riscv: Add support for Smdbltrp and Ssdbltrp extensions" and
> > we need
> > this series merged first. We have minor comments from Cl=C3=A9ment and
>
> Hi Henrique,
>
> If that's easier, I can still remove the dependency on Smrnmi and add
> support for that later.
>
> Cl=C3=A9ment

Hi Cl=C3=A9ment,

Sorry for keeping you waiting. I've reviewed the comments from you and Alis=
tair.
The comments should be straightforward to fix.
I will fix them and send out the patchset later today.
Hope that it makes things easier.


Regards,
Frank Chang

>
> > Alistair so
> > hopefully it shouldn't be too much work.
> >
> > The code freeze for 9.2 will happen in the first/second week of
> > November, so if you
> > could send a new version to be merged in the next PR that would be grea=
t.
> >
> >
> > Thanks,
> >
> > Daniel
> >
> >
> >
> > On 9/2/24 4:13 AM, Tommy Wu wrote:
> >> This patchset added support for Smrnmi Extension in RISC-V.
> >>
> >> There are four new CSRs and one new instruction added to allow NMI to =
be
> >> resumable in RISC-V, which are:
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>    * mnscratch (0x740)
> >>    * mnepc     (0x741)
> >>    * mncause   (0x742)
> >>    * mnstatus  (0x744)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>    * mnret: To return from RNMI interrupt/exception handler.
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> RNMI also has higher priority than any other interrupts or exceptions
> >> and cannot be disabled by software.
> >>
> >> RNMI may be used to route to other devices such as Bus Error Unit or
> >> Watchdog Timer in the future.
> >>
> >> The interrupt/exception trap handler addresses of RNMI are
> >> implementation defined.
> >>
> >> If anyone wants to test the patches, we can use the customized
> >> OpenSBI[1],
> >> and the customized QEMU[2].
> >>
> >> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> >> In the customized QEMU, we use the Smrnmi patches and the patch from
> >> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> >> the RNMI signal with the qmp command.
> >>
> >> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> >> [2] https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/master
> >> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.htm=
l
> >>
> >> Test commands :
> >> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> >> rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> >> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> >> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> >> -qmp unix:/tmp/qmp-sock,server,wait=3Doff
> >>
> >> Use qmp command to inject the RNMI interrupt.
> >> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> >> (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> >> number=3D0 value=3Dtrue
> >>
> >> (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> >> number=3D0 value=3Dfalse
> >>
> >> Changelog:
> >>
> >> v6
> >>    * Delete the redundant code in `riscv_cpu_do_interrupt`.
> >>    ( Thank Alvin for the suggestion. )
> >>    * Split the shared code in `helper_mret` and `helper_mnret` into a
> >>      helper function `check_ret_from_m_mode`.
> >>    ( Thank Alistair for the suggestion. )
> >>
> >> v5
> >>    * Move the patch that adds the Smrnmi extension to the last patch.
> >>    ( Thank Alistair for the suggestion. )
> >>    * Implement an M-mode software PoC for this with implemented handle=
rs.
> >>    ( Thank Andrew Jones for the suggestion. )
> >>    * Add a commit message to all patches of the series.
> >>    ( Thank Andrew Jones for the suggestion. )
> >>
> >> v4
> >>    * Fix some coding style issues.
> >>    ( Thank Daniel for the suggestions. )
> >>
> >> v3
> >>    * Update to the newest version of Smrnmi extension specification.
> >>
> >> v2
> >>    * split up the series into more commits for convenience of review.
> >>    * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_hart=
s.
> >>
> >> Tommy Wu (5):
> >>    target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
> >>    target/riscv: Handle Smrnmi interrupt and exception.
> >>    target/riscv: Add Smrnmi CSRs.
> >>    target/riscv: Add Smrnmi mnret instruction.
> >>    target/riscv: Add Smrnmi cpu extension.
> >>
> >>   hw/riscv/riscv_hart.c                         | 18 ++++
> >>   include/hw/riscv/riscv_hart.h                 |  4 +
> >>   target/riscv/cpu.c                            | 18 ++++
> >>   target/riscv/cpu.h                            | 10 +++
> >>   target/riscv/cpu_bits.h                       | 23 ++++++
> >>   target/riscv/cpu_cfg.h                        |  1 +
> >>   target/riscv/cpu_helper.c                     | 80 ++++++++++++++++-=
-
> >>   target/riscv/csr.c                            | 82 +++++++++++++++++=
++
> >>   target/riscv/helper.h                         |  1 +
> >>   target/riscv/insn32.decode                    |  3 +
> >>   .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
> >>   target/riscv/op_helper.c                      | 49 +++++++++--
> >>   12 files changed, 291 insertions(+), 10 deletions(-)
> >>
>
>

