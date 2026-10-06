Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AE1CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENB9-0007pI-CX; Wed, 07 Oct 2026 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEImf-0007PG-4X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:57:46 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEImU-0003jB-Bs
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:57:29 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-533778ab0bdso14235941cf.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791345440; cv=none;
 d=google.com; s=arc-20260327;
 b=LljIbn7RMmnKHZHcPV6wxSmUOIyaHjdRp+F/s6BI1mBrNot/sSODYssHq5WjMWdeTe
 VrlxrB/591jcmTP5NEThbUfSQYHf/Wbtxv0WBXO3hCbAtVgW+ZGDoCmB5hhZUKbRvYOd
 dbFA5kYEhjp/qJxmu17BA08D+Q7i/3MsS5VP3VGn8VzihOuhxd7p1IaNEX/iwh9s1/bE
 vt/FeSoHxVVzXs6qWANO0pNwaNf3bNzxEfYr75IU96xUIcncPKAf/UAF86Aq/9RctrZM
 oPujUq96TiY5ppL1URJM75FjaeReElfz4N5TViTZMpNhXZC5e9sq1dtv0RnxNWCv/LdM
 MHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vCUogBX76A4PNkRqpBF2c8Vgx8g3b73735jcch5yTeY=;
 fh=ZdRLPsJgATejbzJwNBHiArBbO4T22+kK3eO3eLFrt5k=;
 b=BjXOfwpcovsWy/L7dzf7zkhnqs4GsdXj/GDNo4HZc8i9Uk9gngYpuRe0rk613v2/p0
 +upfo/zRPSj2HB+64Uj/E84rgnhmpaAa2/mLbD/F0mq0e7+rhe+bDgYjf90FlQYqTod8
 2aE3GxD9q/nr0mlH5d07dQl8HMz992+Dbwy7vZsa2tl+Ml0CSKKhiZy+YHlGTNZ016P/
 +6iLXCtSKDc6sMV3bU3QEXPYUJqyLFu6ccmtj7MTCGh803Z6dd+0iBcKonhDsGG3QIXc
 R67+cFen2decadnHdboXlsEMbzEoiyVCRDFERZGeSJAEZ9dV0KYs40xqq7mh2sBU8br/
 03lA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791345440; x=1791950240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vCUogBX76A4PNkRqpBF2c8Vgx8g3b73735jcch5yTeY=;
 b=doZCae5T5EHB1gQoX+Qzu4FEfqPraXdzV03WDBfStYhKgAcHo9dEdLcvOjJbE30Y8k
 2Cuy6oHcd/g5Vd75tsQJ6MwSLXDTOcC4A57PDQhUuMmw3pc6K/i7VOxZUzRoglWxumJg
 5+lDJMeLl3jp0WNTqRcizl8NM3DchxpUmofQET9xhdnvSe6THB8qUFJOXPVACDOIQLy/
 Q3MadyqixbwUagw+wOTMxlphMpwc485ihaeP7NtVJ+cDzzwpMZRnxYDKgbCW9oqWo8qB
 BbOdxBc+ux1ukL9078I6xq19RtCf8EN3NC1kYy+kAU8/lh+nf8GkrLGvmJBkPhNZ3F2Y
 X7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791345440; x=1791950240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vCUogBX76A4PNkRqpBF2c8Vgx8g3b73735jcch5yTeY=;
 b=bIj0QvxlXYa1DgItjlbs7GlH63J8FE7K2EukkrAOLWn5Q69srZANVcNgQLExCMtJ5n
 tAIDxy9pkcj0+TL8IJMZilzvJLU0VD3JzOCs6gO8H9PCZaliZz1N1BL7bAEu/MVmqFwr
 nTgSAh9QHIA5yUz08pL4D6anXbyFdUc1a/zc++uYpb5oJa2LIA0WXb4piTh6CfGgvyX3
 mWmNCF31ZYbBKByxDP8CVXttjxAWALiLNBEBmhM6MXx78ARJ4Uingpr7vIJBOrWvOdf5
 xsBV+O1rzZovpP99/pDCvqqawRR/jkQEm3oVAZfiBTMEUgs33t2osi06HR1WH/Vfc1Dl
 lVzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRSDMUJ2jLj1wqWh5YIkNHWI5WubzV0laeBhZ0J82jDFtjgJfDjG7vQhq0om+/SUnRD5VnymMHZ103@nongnu.org
X-Gm-Message-State: AFuF++l5Sstng8kIVrghYQXGqWld+vcBRc2t+MezQD0GorbErf/YZOYP
 njNy0t2zvsIrh+HeqixemIR6FL6f02lvmOAehpjIURnLNr/Gm8QnmJ8ip67Nm70FDu3vDn0quRD
 ofhz4xuL+zeIk0P3P9I9CCVtouPkvw6R08bEr
X-Gm-Gg: AYBFou1Y/sCh1cpb2WQG0M2oT6AGcS0KSfoyV/qIpBJDtzrTfMzgdEqrUOrlnzTPb25
 mEZ6aceWjdJ1CoMS1rVG5dmPSL4ONZUfMeFHEuSh75T6qwxBwORDeulq4gi5C3BbQW+TDWanzpL
 5K0vW1iT2Z+A3kX/Ht5RbUZk4Y6M6lRDZMr90+A50vpXdmDsmkUXRyEV4a/swcktKdFOCFlIcXE
 k8BpxHmeVn2c5ndEfky7rwjWPeNlXwkWl4CKk1egJ77ldQvVENBN0OSUILnN3ihCg26Az3XfdGS
 QPUBm/jYjYpVptE/unda83EnpN1qMt9fFp6HLMGckbTclDFU9b3pSponsN7NM7cy8iShO53Gybt
 I9ypyWNB/14g=
X-Received: by 2002:a05:693c:83d9:10b0:343:80af:5ab0 with SMTP id
 5a478bee46e88-3514e3285e3mr1583202eec.25.1791297111054; Tue, 06 Oct 2026
 07:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <1b9d9cef-8f65-4e96-9e7b-fd136f64a75d@oss.qualcomm.com>
 <33ad7803-82ad-49f0-b39d-d3a23807ab75@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <33ad7803-82ad-49f0-b39d-d3a23807ab75@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 6 Oct 2026 18:31:38 +0400
X-Gm-Features: AclHuK-kbtdLOIWlDva4Svd6YVmMvahlYS-c4-tOA45DeYixouliCXuXbbxC1Rc
Message-ID: <CAJ+F1C+0A4_VU3aNk=fWwvR=MPbe3Zw2zyeFnyCGmJET6fAoKg@mail.gmail.com>
Subject: Re: [PATCH 00/10] monitor/hmp: replace MonitorDef with GDB registers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Akihiko

On Thu, Oct 1, 2026 at 12:03=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/10/01 2:18, Philippe Mathieu-Daud=C3=A9 wrote:
> > Cc'ing Akihiko who worked on gdbstub.
> >
> > On 11/9/26 14:27, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> >> Hi,
> >>
> >> HMP monitor supports printing $register expression. The lookup
> >> was done via GDB stub registers, and supplementary MonitorDef
> >> HMP-specific tables.
> >>
> >> Migrate HMP registers to use the GDB infrastructure and remove the
> >> legacy HMP MonitorDef. Use a "qemu-debug" register group, as they are
> >> aliases or synthetic registers, but gdb doesn't seem to care.
>
> Unfortunately, these aliases and synthetic registers appear to have
> several problems:
>
> - GDB already provides writable pseudo-registers for SPARC64's asi and
>    pstate. The new QEMU registers shadow them but ignore writes, breaking
>    previously supported functionality. See:
>
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/sparc64=
-tdep.c;h=3D93db3417a2a9f64790acab33288eb05764112e0b;hb=3D6a5e5259790e5a854=
ddbb69eb486b9245fcfeee8#l976
>
> - GDB caches each raw register independently. Updating one alias can
>    leave another stale, causing incorrect reads or skipped writes.
>
> - The new raw aliases do not inherit the original registers' unwind
>    rules, leading to incorrect register values when selecting older
>    call frames.
>
> The latter two issues also affect the RISC-V aliases and cannot be
> resolved merely by changing QEMU's register read/write callbacks. I
> therefore think we need to retain HMP-specific handling for these aliases=
.

Thanks for the feedback and findings! Would it be an option to have
qemu/pseudo registers use a prefixed name like "qemu.", then it
shouldn't conflict with GDB. HMP would need to try with it if not
found. Wdyt?

Alternatively, keep the monitor specific register lookup, as a secondary pa=
th.

> Regards,
> Akihiko Odaki
>
> >>
> >> Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
> >> and vector registers now report "unkown register" instead of a
> >> target-specific message ("Unable to print the value of vector vreg 'v0=
'
> >> from this API")
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >> Marc-Andr=C3=A9 Lureau (10):
> >>        hmp: don't crash on invalid register
> >>        gdbstub: fix next register base after register gaps
> >>        gdbstub: set feature->base_reg for dynamic features
> >>        target/i386: expose segment limits via GDB
> >>        monitor/hmp: add CPUClass::get_pc fallback for HMP $pc
> >>        target/m68k: expose system registers via GDB
> >>        target/sparc64: expose system registers via GDB
> >>        target/riscv: bypass smstateen check in debugger mode
> >>        target/riscv: expose register aliases via GDB
> >>        monitor/hmp: remove legacy MonitorDef infrastructure
> >>
> >>   configs/targets/i386-softmmu.mak          |   2 +-
> >>   configs/targets/m68k-softmmu.mak          |   2 +-
> >>   configs/targets/riscv32-linux-user.mak    |   2 +-
> >>   configs/targets/riscv32-softmmu.mak       |   2 +-
> >>   configs/targets/riscv64-bsd-user.mak      |   2 +-
> >>   configs/targets/riscv64-linux-user.mak    |   2 +-
> >>   configs/targets/riscv64-softmmu.mak       |   2 +-
> >>   configs/targets/sparc64-softmmu.mak       |   2 +-
> >>   configs/targets/x86_64-softmmu.mak        |   2 +-
> >>   gdbstub/gdb-xml/i386-segments.xml         |  14 +++
> >>   gdbstub/gdb-xml/m68k-system.xml           |  32 +++++++
> >>   gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++=
++
> >>   gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
> >>   gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++=
++
> >>   gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
> >>   gdbstub/gdb-xml/sparc64-system.xml        |  22 +++++
> >>   gdbstub/gdbstub.c                         |  14 +--
> >>   include/hw/core/cpu.h                     |   2 +-
> >>   include/hw/core/sysemu-cpu-ops.h          |  16 ----
> >>   include/monitor/hmp.h                     |   6 --
> >>   include/qemu/typedefs.h                   |   1 -
> >>   monitor/hmp.c                             |  52 ++---------
> >>   target/arm/gdbstub.c                      |   8 +-
> >>   target/arm/gdbstub64.c                    |  10 ++-
> >>   target/i386/cpu.c                         |  32 -------
> >>   target/i386/gdbstub.c                     |  24 +++++
> >>   target/m68k/cpu.c                         |  22 -----
> >>   target/m68k/helper.c                      |  47 ++++++++++
> >>   target/ppc/gdbstub.c                      |   2 +-
> >>   target/riscv/cpu.c                        |   1 -
> >>   target/riscv/gdbstub.c                    |  52 ++++++++++-
> >>   target/riscv/internals.h                  |   3 -
> >>   target/riscv/monitor.c                    | 140
> >> ------------------------------
> >>   target/riscv/tcg/csr.c                    |   3 +-
> >>   target/sparc/cpu.c                        |  19 ----
> >>   target/sparc/gdbstub.c                    |  38 ++++++++
> >>   target/xtensa/cpu.c                       |   2 +-
> >>   37 files changed, 562 insertions(+), 314 deletions(-)
> >> ---
> >> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> >> change-id: 20260910-query-reg-80cd59cf4707
> >>
> >> Best regards,
> >> --
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >>
> >
>
>

