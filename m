Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD83CF8842
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 14:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swjZs-0004NV-Cz; Fri, 04 Oct 2024 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1swjZn-0004Mk-PH
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:46:41 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1swjZj-0007Cg-E9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:46:39 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a344f92143so9564535ab.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728053193; x=1728657993;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qBWsk8LjKGw/raRK0eJ8OBcUTdBZscuyVkJRyvmDoQ=;
 b=ZEICX+o1jwpgqR8VLtq9QiPEu2APzxpr0ItwtimKLjQNpQTwMxwVTKkTnRir+SAhuW
 ZM2D4FnJ55tDkkb6clf5nkOPcB7Lwn7nYgdNPN1/CMPPjpiGkWLibw+Ok6jHKzR4b/ps
 wLXSz5zcJPCZ/+fAzBUWoRv3fGiKwdb0pQoCv1gLsE+Un05w+yPq2/X8L/YRLYhk2KAT
 cSlkVDlWbpTR1bRzqDqlSZZDliI8vSZP7yQKMO1rJ8bKoSPVHCXWKTr7uZaVZ+J8C+Of
 VqAiToL97IL6aUgoWApP5J7Q+3/BWZt0ShgGxA+ny6VXlUIPVMOzA+m8jcLUIbqiH7sz
 V5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728053193; x=1728657993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qBWsk8LjKGw/raRK0eJ8OBcUTdBZscuyVkJRyvmDoQ=;
 b=KGzu/pMPu1rbDbM2zAx4v3NTe+P77L8kh/aYi1dIjFRFY7qqFF6FIlpmHFOug77N8S
 UfMzlEwpKi2a5oQWURTEhYaffS4L5SYzlNXcrcR4iYB0qv3as+q/OXE+f5zltTipZmeH
 n6292rAE7rEk5ym+HpMKGEOvQtX2kOls3VFFEbsZP4shv6uotLQTUvEForXxvDP89jfG
 a72NywLqUsgURnqb+atU0Z753dO0rc9X6EJt+YCXptwfZneVHm7GssZ+p5s+IJ7Q7fOw
 a4G/z1JTfdvqnGI5mS2PPVfcfTHGYGZ6wFb70A/7/sVm1vvsUup2QILD0WFR73gKhN26
 cSXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW29jbdoYV1JVB5QHM6CWEjGNupvGyhUp0vqiN8HfZkEuBrWG4sW0oDjo1pXexhwTtfLSgV8XblDAio@nongnu.org
X-Gm-Message-State: AOJu0YzNNLY1ra7RXjZgmcL8+LHJZSZ5LZL7oOGCcRbXX41tI89GgM0E
 34UQNIqiwgqdVmrjhm5nOL3tIRMwPjIOOIVGnKiUAc8aHJJlaucylA62eoMMlyhIws5Vt9+pakW
 lzLprYbgDEzWoBykhgQNcRQOnafKbOYIT7/mCfw==
X-Google-Smtp-Source: AGHT+IG7RwAG5rv5GvkT08KmE3JluVRgaavkn+LLjIUocHaMaDVgGiSMacwXVXypECrgr18OyWOooPdE2qobHop8/A8=
X-Received: by 2002:a05:6e02:1c26:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a3759918a0mr28922635ab.6.1728053193126; Fri, 04 Oct 2024
 07:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
 <20241002010314.1928515-4-dbarboza@ventanamicro.com>
 <20241003-c10c27e0855533db764a1490@orel>
 <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
 <CAH2o1u6h5nOMuGq8opXQNm6M=D=TrvygmoS+hHwmrgViy3reFA@mail.gmail.com>
 <20241004-2c8c6a6af4d598c78638a091@orel>
 <30b1d28c-ef1b-4f16-95ad-02a51066061b@ventanamicro.com>
In-Reply-To: <30b1d28c-ef1b-4f16-95ad-02a51066061b@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 4 Oct 2024 07:46:22 -0700
Message-ID: <CAH2o1u4m3hrOqtmdmXQoyUGQ1nADz3Psg+TFQk=CFEgEvM8pbg@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, peter.maydell@linaro.org, 
 Sebastien Boeuf <seb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=tjeznach@rivosinc.com; helo=mail-il1-x129.google.com
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

On Fri, Oct 4, 2024 at 6:00=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/4/24 5:33 AM, Andrew Jones wrote:
> > On Thu, Oct 03, 2024 at 11:36:00AM GMT, Tomasz Jeznach wrote:
> >> On Thu, Oct 3, 2024 at 6:06=E2=80=AFAM Daniel Henrique Barboza
> >> <dbarboza@ventanamicro.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/3/24 6:26 AM, Andrew Jones wrote:
> >>>> On Tue, Oct 01, 2024 at 10:02:58PM GMT, Daniel Henrique Barboza wrot=
e:
> >>>> ...
> >>>>> +/*
> >>>>> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> >>>>> + *
> >>>>> + * Note: Code is based on get_physical_address() from target/riscv=
/cpu_helper.c
> >>>>> + * Both implementation can be merged into single helper function i=
n future.
> >>>>> + * Keeping them separate for now, as error reporting and flow spec=
ifics are
> >>>>> + * sufficiently different for separate implementation.
> >>>>> + *
> >>>>> + * @s        : IOMMU Device State
> >>>>> + * @ctx      : Translation context for device id and process addre=
ss space id.
> >>>>> + * @iotlb    : translation data: physical address and access mode.
> >>>>> + * @return   : success or fault cause code.
> >>>>> + */
> >>>>> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUCon=
text *ctx,
> >>>>> +    IOMMUTLBEntry *iotlb)
> >>>>> +{
> >>>>> +    dma_addr_t addr, base;
> >>>>> +    uint64_t satp, gatp, pte;
> >>>>> +    bool en_s, en_g;
> >>>>> +    struct {
> >>>>> +        unsigned char step;
> >>>>> +        unsigned char levels;
> >>>>> +        unsigned char ptidxbits;
> >>>>> +        unsigned char ptesize;
> >>>>> +    } sc[2];
> >>>>> +    /* Translation stage phase */
> >>>>> +    enum {
> >>>>> +        S_STAGE =3D 0,
> >>>>> +        G_STAGE =3D 1,
> >>>>> +    } pass;
> >>>>> +    MemTxResult ret;
> >>>>> +
> >>>>> +    satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> >>>>> +    gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> >>>>> +
> >>>>> +    en_s =3D satp !=3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> >>>>> +    en_g =3D gatp !=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> >>>>> +
> >>>>> +    /*
> >>>>> +     * Early check for MSI address match when IOVA =3D=3D GPA. Thi=
s check
> >>>>> +     * is required to ensure MSI translation is applied in case
> >>>>> +     * first-stage translation is set to BARE mode. In this case I=
OVA
> >>>>> +     * provided is a valid GPA. Running translation through page w=
alk
> >>>>> +     * second stage translation will incorrectly try to translate =
GPA
> >>>>> +     * to host physical page, likely hitting IOPF.
> >>>>> +     */
> >>>>
> >>>> Why was this comment expanded from the simple
> >>>>
> >>>> "Early check for MSI address match when IOVA =3D=3D GPA."
> >>>>
> >>>> The comment is now incorrect since the check is required even when
> >>>> first-stage translation is not BARE. I just skimmed the spec again t=
rying
> >>>> to figure out if the removal of '!en_s' is a hack or a fix, and I'm
> >>>> inclined to say "fix", but it's an incomplete fix. I found a sentenc=
e that
> >>>> says
> >>>>
> >>>> "If the virtual memory scheme selected for first-stage is Bare but t=
he
> >>>> scheme for the second-stage is not Bare then the IOVA is a GPA."
> >>>>
> >>>> which, in a way, defines a GPA to only be a GPA when second-stage is=
 used
> >>>> (and all MSI translation specifications refer to GPAs). However, may=
be I
> >>>> missed it, but I couldn't find any actual reason that the MSI table =
can't
> >>>> be used when first-stage is not BARE and second-stage is (and, of co=
urse,
> >>>> it makes no difference for single-stage translations to call IOVAs G=
PAs
> >>>> or not).
> >>>>
> >>>> Now, I also see
> >>>>
> >>>> "If the virtual memory scheme selected for neither stage is Bare the=
n the
> >>>> IOVA is a VA. Two-stage address translation is in effect. The first-=
stage
> >>>> translates the VA to a GPA and the second-stage translates the GPA t=
o a
> >>>> SPA."
> >>>>
> >>>> in the spec, which means we should probably change the removal of '!=
en_s'
> >>>> to '!(en_s && en_g)'. VFIO+irqbypass would still work with that and,=
 when
> >>>> Linux learns to support two-stage translation, we wouldn't incorrect=
ly try
> >>>> to check for a GVA in the MSI table.
> >>>
> >>> Ok. It seems to me that we can't rely on the riscv-iommu spec alone t=
o let
> >>> us know how to detect if IOVA =3D=3D GPA, given that one of the main =
usages
> >>> we have ATM (VFIO irqbypass) will use GPAs with S-stage enabled.
> >>>
> >>> (Note: shouldn't we open a bug against the riscv-iommu spec?)
> >>>
> >>> I like the idea of ruling out the case where IOVA =3D=3D VA since tha=
t is clear
> >>> in the spec. We also know that MSI entries will always contains GPAs.
> >>>
> >>> This is the change I'm going to make in v9:
> >>>
> >>>
> >>
> >> It might be worth it to quote spec definitions of IOVA, GPA, SPA.
> >>
> >> IOVA: I/O Virtual Address: Virtual address for DMA by devices
> >> GPA: Guest Physical Address: An address in the virtualized physical
> >> memory space of a virtual machine.
> >> SPA: Supervisor Physical Address: Physical address used to access
> >> memory and memory-mapped resources.
> >>
> >>  From IOMMU specification it's pretty clear, an untranslated address i=
s
> >> always an IOVA.
> >>
> >> If you look at the introduction section and section 2.3. "Process to
> >> translate an IOVA", translation (if enabled by the device/process
> >> context) to GPA, SPA is expressed as:
> >>
> >> step #17: GPA =3D FSC[IOVA]
> >> step #19: SPA =3D IOHGATP[GPA]
> >>
> >> With that, MSI address translations always use GPA as an input
> >> (section 2.3.3. "Process to translate addresses of MSIs"), and is done
> >> as step #18 of the IOVA translation.
> >>
> >> And now:
> >> If FSC.Mode =3D=3D Bare, step #17 translation is simple GPA =3D IOVA
> >> If IOHGATP.Mode =3D=3D Bare, step #19 translation is simple SPA =3D GP=
A
> >>
> >> If both FSC and IOHGATP modes are bare, no address translation is
> >> performed, and SPA =3D GPA =3D IOVA. However if "MSI page tables are
> >> enabled, then the MSI address translation process specified in Section
> >> 2.3.3 is invoked".  This was the reason to put the
> >> riscv_iommu_msi_check() function before check for pass-through mode
> >> check.
> >>
> >> If FSC.Mode =3D=3D Bare and untranslated address given to the function
> >> riscv_iommu_spa_fetch() is an GPA =3D IOVA. It could also be SPA if
> >> IOHGATP.Mode =3D=3D Bare, but it is irrelevant for the MSI address
> >> translation.  That is the reason to put only the check for !en_s in
> >> before riscv_iommu_msi_check() call.
> >>
> >> I'm aware that VFIO uses S-Stage translation only, but it does not
> >> change the hardware logic. For such cases VFIO can provide IMSIC
> >> register mappings in S-Stage PT to emulate MSI doorbell registers (if
> >> needed). When S-Stage translation is used, an untranslated address
> >> processed by the IOMMU hardware is still an IOVA, even if the guest OS
> >> / VFIO user treats it as PA.
> >
> > This would work for guest interrupt file mappings, but MRIFs won't work
> > and the note of the "Device contexts at an IOMMU" section of the AIA sp=
ec
> > points out that VCPU migration may become more difficult to manage.
> >
> >>
> >> Modification of the check to include en_g ( !(en_s && en_g) && ,,, )
> >> will incorrectly enable MSI address translation for an IOVA address
> >> (as defined in IOMMU spec) if G-Stage translation is set to Bare mode.
> >>
> >> I'd suggest to keep the s/g stage checks here as:
> >>        if ((iotlb->perm & IOMMU_WO) && !en_s &&
> >>            riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> >>            ...
> >>        }
> >>
> >> Hope that helps this discussion.
> >
> > Yes, it certainly helps, thank you. It points out that step 17 of "Proc=
ess
> > to translate an IOVA" produces a GPA which is consumed by step 18 for t=
he
> > MSI translation (and there's no other way to get to step 18). OIOW, we
> > must do a first-stage translation before we check the MSI page table,
> > which means we can't do an early MSI check unless we have strictly !en_=
s.
> >
> > This is unfortunate, considering the current state of VFIO+irqbypass an=
d
> > the IOMMU driver. I also wonder if it's really necessary. It seems to m=
e
> > that the MSI page table should always be checked first when either S-st=
age
> > or G-stage is Bare (so there's only a single-stage of translation) and
> > msiptp.MODE is not Off. I can't see what harm could come from that and =
it
> > would give system software the ability to leverage code that already kn=
ows
> > how to manage single-stage IOMMUs for device assignment.
>
> I agree with all of that. But at the end of the day we need to adhere to =
the
> HW spec as closely as we can, and it's now clear that the assumptions we =
were
> making in this particular check, for the sake of VFIO+irqbypass support, =
is
> sort of spec violation.
>
> I still believe this is something that we would like to discuss in the sp=
ec
> space, but for now we don't have much to do w.r.t the emulation. If we wa=
nt
> VFIO+irqbypass to work the Linux driver will need to do extra work.
>
> This is what I'll do for v9:
>
>     /*
>       * Early check for MSI address match when IOVA =3D=3D GPA.
>       * Note that the (!en_s) condition means that the MSI
>       * page table may only be used when guest pages are
>       * mapped using the g-stage page table, whether single-
>       * or two-stage paging is enabled. It's unavoidable though,
>       * because the spec mandates that we do a first-stage
>       * translation before we check the MSI page table, which
>       * means we can't do an early MSI check unless we have
>       * strictly !en_s.
>       */
>      if (!en_s && (iotlb->perm & IOMMU_WO) &&
>          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>          iotlb->target_as =3D &s->trap_as;
>          iotlb->translated_addr =3D iotlb->iova;
>          iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
>          return 0;
>      }
>
>
> It also came to my attention today that the kernel support is waiting for
> the QEMU pieces to land due to the Red Hat PCI ID we're adding. I'll post
> v9 later today or next Monday to see if we can speed things up.
>

Thanks. I'll be sending out kernel iommu/riscv v9 patches later today.
Updated PCI IDs and few minor bugs fixed,
All re-tested with QEMU riscv/iommu-v9 (fetched from github).

Best,
- Tomasz

>
> Thanks,
>
> Daniel
>
>
>
>
>
> >
> > Thanks,
> > drew

