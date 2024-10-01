Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ED6CF318A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 23:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svmAB-0000z1-SW; Tue, 01 Oct 2024 19:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svmAA-0000yp-3M
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:20:14 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svmA7-00018g-TO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:20:13 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-82ce603d8b5so278898939f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727824810; x=1728429610;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdGhbwp0ppozRzUeLoEaa9umr+m+0RgOgoe2l2eQeyw=;
 b=f02REvOSXVKlnoR8wpTWbiJq+TbFwgETlw4+joHAvYGrLtd5o8UNezZzwouR/uy8x8
 myVPZLOyRDRgzmANe3sX7tmgTdD0fWXnhDXE1pwBQA8RV6QW+gPZx/bDlYFl3ggsV0i/
 oLchPUj/eWfBKeLmnciy9C6PibJnfutNS0FsiDNpzbkPJ9Xj4rnlYv2lYECnRCWqzVKF
 zIIyepuE94OJJViWMTFcq4OUArTZg982fgw1eq5q1XpRWdHUtoXegZ8o1vmF6cXfv4nR
 H3gS/kpGbdlAJz+LnEx8qun7M1g5tH1NZs2bbLJzqwHupJlqGPfNfXC+4JRpBUBplpHM
 JPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727824810; x=1728429610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdGhbwp0ppozRzUeLoEaa9umr+m+0RgOgoe2l2eQeyw=;
 b=w/0sDymUxw+yuXZLOrlLpwISt5n2owY29IHrHGCTweDVX885eVq0fHtle8T3PCGpos
 V82hXNCJeeE/Gc2eg7tKL2C8N8jY7SbUpYzHol6I8/ev8Tm+Be78N3yafp0l5lx+TKej
 MlW/MGvyrcbgRDaYTuzVH2Su0ZB7M30bEQGJmMxoCWyDXBblhZRsx6FF0z983JCYvBPw
 Fhx9TB3fTeD2ckyHsnapIZCfhxd2seAupz6ttAHDu7gEnDeXXfqXsr4v8mFn/j4gbolu
 ozMxhWDCHyvrf37b4Ym56vg9tZFBxZFLIJojVsxKFejLA9mWsBvOxFgGD3Omxeos50xy
 gxJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYn9YGg9+AnHwqjd15D0jQ89nBjOW7FdkB1qHBRYCTRiJ9f21wGc15rnO2TQLhkEpLE4BxGBIDBKzF@nongnu.org
X-Gm-Message-State: AOJu0YyeNM3KUkMYe2gGjx2M601gtmuugiQdeJezZ2twwf2xy95Y5b6j
 UaS3JQaVeG1xuEo6vae+8+Vg61WjXNqiZPYZLvpvzlM4oOj+0k0dorux8OwbdZ9WDloLVP7cWQF
 Z3M3cTry5ecC7Cj/hZUquncJEp1eyT5LRjTKxsA==
X-Google-Smtp-Source: AGHT+IEuy5gHgFkQoFsxkt9tvp4+bOSN6JzomX31bT8m6bvumMdOi/J3y7SFHZcyaHuDbwTnYZOg4ki7mikSyqwIRP0=
X-Received: by 2002:a05:6e02:180f:b0:3a0:8eb3:5154 with SMTP id
 e9e14a558f8ab-3a365913372mr15508075ab.4.1727824810038; Tue, 01 Oct 2024
 16:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
 <CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com>
 <634d685c-7e36-409e-9b41-b9162a5acf9c@ventanamicro.com>
 <CAFEAcA-=s9zatyYYOP01BO1o7jPpY45mWkDM3N_yydD=Ka3GNw@mail.gmail.com>
 <CAH2o1u6pQXOFbo6EyJAOfkAgE6VPK7MGsuvLD=nzhVeQFfrHwA@mail.gmail.com>
 <fe6c6569-4623-451c-bd4f-9325f294461c@ventanamicro.com>
In-Reply-To: <fe6c6569-4623-451c-bd4f-9325f294461c@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 1 Oct 2024 16:19:58 -0700
Message-ID: <CAH2o1u5fDUj+O+ZXSbX5grRi5ah_+FpMjp9n4vhJpXabRGRPDA@mail.gmail.com>
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, 
 qemu-devel@nongnu.org, Sebastien Boeuf <seb@rivosinc.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 "frank.chang@sifive.com" <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=tjeznach@rivosinc.com; helo=mail-io1-xd2d.google.com
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

On Tue, Oct 1, 2024 at 4:00=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/1/24 7:14 PM, Tomasz Jeznach wrote:
> > On Sun, Sep 29, 2024 at 8:46=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> >>
> >> On Sat, 28 Sept 2024 at 22:01, Daniel Henrique Barboza
> >> <dbarboza@ventanamicro.com> wrote:
> >>>
> >>>
> >>>
> >>> On 9/28/24 5:22 PM, Peter Maydell wrote:
> >>>> On Tue, 24 Sept 2024 at 23:19, Alistair Francis <alistair23@gmail.co=
m> wrote:
> >>
> >>>>> +/* Register helper functions */
> >>>>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> >>>>> +    unsigned idx, uint32_t set, uint32_t clr)
> >>>>> +{
> >>>>> +    uint32_t val;
> >>>>> +    qemu_spin_lock(&s->regs_lock);
> >>>>> +    val =3D ldl_le_p(s->regs_rw + idx);
> >>>>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >>>>> +    qemu_spin_unlock(&s->regs_lock);
> >>>>> +    return val;
> >>>>> +}
> >>>>
> >>>> This looks very weird. Nobody else's IOMMU implementation
> >>>> grabs a spinlock while it is accessing guest register data.
> >>>> Why is riscv special? Why a spinlock? (We use spinlocks
> >>>> only very very sparingly in general.)
> >>>
> >>>
> >>> The first versions of the IOMMU used qemu threads. I believe this is =
where
> >>> the locks come from (both from registers and from the cache).
> >>>
> >>> I'm not sure if we're ever going to hit a race condition without the =
locks
> >>> in the current code (i.e. using mmio ops only). I think I'll make an =
attempt
> >>> to remove the locks and see if something breaks.
> >>
> >> Generally access to the backing for guest registers in a
> >> device model is protected by the fact that the iothread lock
> >> (BQL) is held while the guest is accessing a device. I think for
> >> iommu devices there may be some extra complication because they
> >> get called as part of the translate-this-address codepath
> >> where I think the BQL is not held, and so they typically
> >> have some qemu_mutex to protect themselves[*]. But they
> >> don't generally need/want to do the handling at this very
> >> fine-grained per-read/write level.
> >>
> >> [*] This is just what I've gathered from a quick read through
> >> our other iommu implementations; don't take it as gospel.
> >>
> >> If you do need to do something complicated with locking it would
> >> be good to have a comment somewhere explaining why and what
> >> the locking principles are.
> >>
> >
> > Locking for the iot and ctx cache is still required as the translation
> > requests going through IOMMUMemoryRegionClass.translate callback
> > (riscv_iommu_memory_region_translate) are unlikely protected by BQL.
> > With ATS translation requests and eventually PRI notifications coming
> > to the iommu implementation, cache structures will be modified without
> > any external locking guarantees.
> >
> > To add some background to register access spin locks.
> > Original implementation runs all IOMMU command processing logic as a
> > separate thread, avoiding holding BQL while executing cache
> > invalidations and other commands. This was implemented to mimic real
> > hardware, where IOMMU operations are not blocking CPU execution.
> > During the review process it was suggested and modified to execute all
> > commands directly as part of the MMIO callback. Please note, that this
> > change has consequences of potentially holding CPU/BQL for unspecified
> > time as the command processing flow might be calling registered IOMMU
> > memory notifiers for ATS invalidations and page group responses.
> > Anyone implementing memory notifier callback will now execute with BQL
> > held. Also, updates to register state might happen during translation
> > fault reporting and or/pri. At least queue CSR/head/tail registers
> > updates will need some sort of protection.
> >
> > Probably adding a comment in the code and maybe restoring the original
> > threading model would make this implementation more readable and less
> > problematic in the future.
>
> I agree that the locks makes more sense in a threading model like it was
> the case in v2. At this point it doesn't make much sense to have both
> BQL and manual locks.
>

Agree, it doesn't make sense to have both. My only concern now is
related to riscv_iommu_fault() and riscv_iommu_pri() updating related
queue CSR and interrupt status register (REG_IPSR). Other than that it
should be ok to rely on BQL.


> For context, we moved away from it back in v2, after this comment from
> Frank Chang:
>
> https://lore.kernel.org/qemu-riscv/CANzO1D35eYan8axod37tAg88r=3Dqg4Jt0CVT=
vO+0AiwRLbbV64A@mail.gmail.com/
>
> --------------
> In our experience, using QEMU thread increases the latency of command
> queue processing,
> which leads to the potential IOMMU fence timeout in the Linux driver
> when using IOMMU with KVM,
> e.g. booting the guest Linux.
>
> Is it possible to remove the thread from the IOMMU just like ARM, AMD,
> and Intel IOMMU models?
> --------------
>
> Frank then elaborated further about IOFENCE and how they were hitting ass=
erts
> that were solved after moving the IOMMU away from a thread model.
>
> For now I removed all locks, like Peter suggested, and in my testing with
> riscv-iommu-pci and riscv-iommu-sys I didn't see anything bad happening.
> BQL is granting enough race protection it seems.
>
> I believe we should stick with this approach, instead of rolling back
> to a threading model that Frank said back in v2 that could be problematic=
.
> Nothing is stopping us from moving back to a threading model later if we
> start hitting race conditions or even if we have performance improvements
> in doing so. At that point we'll be more versed in how the IOMMU is going
> to be used by everyone else too.
>
>

Thanks for bringing up this comment. Yes, definitely makes sense, it
will add latency (what I've found beneficial for driver side testing).
Both solutions have downsides. I'll have a closer look if the
consequences for ATS/PRI processing are severe enough to move back to
the threading model. Let's leave as is for now.

Thanks!
- Tomasz

> Thanks,
>
> Daniel
>
>
> >
> > Thanks for the review,
> > - Tomasz
> >
> >
> >> thanks
> >> -- PMM

