Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C23DCF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQgo-0001Jz-D9; Thu, 03 Oct 2024 14:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1swQgR-0000y5-Ty
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:36:18 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1swQgP-0005us-1Q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:36:15 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-834d3363a10so59799039f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980571; x=1728585371;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtigHOil7EqN8Y6u6SjVKClDbu3t0WwWIC5+N8s2M5M=;
 b=jEnbXbjWdGSid+3mOFv8nvksQz7F1JoqtAfblVB6FeZiUPI6Vx8fUUIhB5oDvMsXCg
 3cazpEsByVgdWIFaThKwj1kBeLInkWwSHysUUkPsCe8goGZUuEtbLF0Y/Vp6lBCbtAi1
 aoP26tAXdwvNfu5hk/bE9R9c+AYMk/jZRQ5mZlL2iCIWpI0paGdNlpKIkGQTFToSqOjw
 Ci8WiIeyhLQsjOweu8xJVQDxxF0TKIJBFbYWUOcdpWmprvYR1bztfs88CWkdNMYNHi7/
 rnTQOaLsCirnBWDDkeLewzpgUSCRl93PqJl0zlEa5ldGYrpRY90Cpx4CQbxZ5H16wsR7
 fwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980571; x=1728585371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtigHOil7EqN8Y6u6SjVKClDbu3t0WwWIC5+N8s2M5M=;
 b=n88f+XiX9LYA1XsZLh5F9CywsRkb5u37129PAEXljaBJ56IniVuD6pEaD3BHLrgU9l
 yXBTJTa+aSk/ZWTwLdK4EmeoDs0i4lctc+U+bCu+CYhkXrpntMOVtq6w3W0rMJJ2KkwO
 mmCMxH+nCrS2Qpgw5PrOsmky1CwZP0k1CmUWuD/3f3zc8Gk/j+FdX1WED9rsYBSetbs+
 bRNXvSglGt/Cq+rKhQCydPmy4sZ0FhGKKGJ2IcbbqMljj9/2xHIYMYR4U8kBR0v0WaJr
 pyKFkDD3UM+ONqQA2CxrCDIF6kEUUrgSrqXDBciWJVCcIpLYT3j23CYMo8vJySW9AZc1
 ExFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3yFgR9rqMKrimvzqVEug0avM4WSDWrjjvYB3JIKbm5FTt20cKAteblbBpI9DnpX3pdjTA9AQMHqz@nongnu.org
X-Gm-Message-State: AOJu0YwY66QpIMmDTI4+fPP8T4LRazY9qUlm2B1CtyrB/SMqY1m9iXQo
 T39G36AK5+VF1yNAGe/R2D9RiUZwQ8jRidVGQ1JMtsDWWVrTrsnBmLefTU9QImlAKrBJ4z9Bkfp
 irabOM4w9GNuCBDA0rI6jIOlEyocUQ77Q+YiMkg==
X-Google-Smtp-Source: AGHT+IFW97I7t5QbILn/y1GDRW0GrAwZ7OeXkaStItH9mskCvuzZitToeH96hvIQNbt+WF1EuwZgKE/p2z1gJAUmL2c=
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a375bd4f33mr1781655ab.23.1727980570836; Thu, 03 Oct 2024
 11:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
 <20241002010314.1928515-4-dbarboza@ventanamicro.com>
 <20241003-c10c27e0855533db764a1490@orel>
 <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
In-Reply-To: <7c5f0fce-fc66-4fca-90be-aa2d4f7a4b04@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 3 Oct 2024 11:36:00 -0700
Message-ID: <CAH2o1u6h5nOMuGq8opXQNm6M=D=TrvygmoS+hHwmrgViy3reFA@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, peter.maydell@linaro.org, 
 Sebastien Boeuf <seb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=tjeznach@rivosinc.com; helo=mail-io1-xd30.google.com
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

On Thu, Oct 3, 2024 at 6:06=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/3/24 6:26 AM, Andrew Jones wrote:
> > On Tue, Oct 01, 2024 at 10:02:58PM GMT, Daniel Henrique Barboza wrote:
> > ...
> >> +/*
> >> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> >> + *
> >> + * Note: Code is based on get_physical_address() from target/riscv/cp=
u_helper.c
> >> + * Both implementation can be merged into single helper function in f=
uture.
> >> + * Keeping them separate for now, as error reporting and flow specifi=
cs are
> >> + * sufficiently different for separate implementation.
> >> + *
> >> + * @s        : IOMMU Device State
> >> + * @ctx      : Translation context for device id and process address =
space id.
> >> + * @iotlb    : translation data: physical address and access mode.
> >> + * @return   : success or fault cause code.
> >> + */
> >> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContex=
t *ctx,
> >> +    IOMMUTLBEntry *iotlb)
> >> +{
> >> +    dma_addr_t addr, base;
> >> +    uint64_t satp, gatp, pte;
> >> +    bool en_s, en_g;
> >> +    struct {
> >> +        unsigned char step;
> >> +        unsigned char levels;
> >> +        unsigned char ptidxbits;
> >> +        unsigned char ptesize;
> >> +    } sc[2];
> >> +    /* Translation stage phase */
> >> +    enum {
> >> +        S_STAGE =3D 0,
> >> +        G_STAGE =3D 1,
> >> +    } pass;
> >> +    MemTxResult ret;
> >> +
> >> +    satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> >> +    gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> >> +
> >> +    en_s =3D satp !=3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> >> +    en_g =3D gatp !=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> >> +
> >> +    /*
> >> +     * Early check for MSI address match when IOVA =3D=3D GPA. This c=
heck
> >> +     * is required to ensure MSI translation is applied in case
> >> +     * first-stage translation is set to BARE mode. In this case IOVA
> >> +     * provided is a valid GPA. Running translation through page walk
> >> +     * second stage translation will incorrectly try to translate GPA
> >> +     * to host physical page, likely hitting IOPF.
> >> +     */
> >
> > Why was this comment expanded from the simple
> >
> > "Early check for MSI address match when IOVA =3D=3D GPA."
> >
> > The comment is now incorrect since the check is required even when
> > first-stage translation is not BARE. I just skimmed the spec again tryi=
ng
> > to figure out if the removal of '!en_s' is a hack or a fix, and I'm
> > inclined to say "fix", but it's an incomplete fix. I found a sentence t=
hat
> > says
> >
> > "If the virtual memory scheme selected for first-stage is Bare but the
> > scheme for the second-stage is not Bare then the IOVA is a GPA."
> >
> > which, in a way, defines a GPA to only be a GPA when second-stage is us=
ed
> > (and all MSI translation specifications refer to GPAs). However, maybe =
I
> > missed it, but I couldn't find any actual reason that the MSI table can=
't
> > be used when first-stage is not BARE and second-stage is (and, of cours=
e,
> > it makes no difference for single-stage translations to call IOVAs GPAs
> > or not).
> >
> > Now, I also see
> >
> > "If the virtual memory scheme selected for neither stage is Bare then t=
he
> > IOVA is a VA. Two-stage address translation is in effect. The first-sta=
ge
> > translates the VA to a GPA and the second-stage translates the GPA to a
> > SPA."
> >
> > in the spec, which means we should probably change the removal of '!en_=
s'
> > to '!(en_s && en_g)'. VFIO+irqbypass would still work with that and, wh=
en
> > Linux learns to support two-stage translation, we wouldn't incorrectly =
try
> > to check for a GVA in the MSI table.
>
> Ok. It seems to me that we can't rely on the riscv-iommu spec alone to le=
t
> us know how to detect if IOVA =3D=3D GPA, given that one of the main usag=
es
> we have ATM (VFIO irqbypass) will use GPAs with S-stage enabled.
>
> (Note: shouldn't we open a bug against the riscv-iommu spec?)
>
> I like the idea of ruling out the case where IOVA =3D=3D VA since that is=
 clear
> in the spec. We also know that MSI entries will always contains GPAs.
>
> This is the change I'm going to make in v9:
>
>

It might be worth it to quote spec definitions of IOVA, GPA, SPA.

IOVA: I/O Virtual Address: Virtual address for DMA by devices
GPA: Guest Physical Address: An address in the virtualized physical
memory space of a virtual machine.
SPA: Supervisor Physical Address: Physical address used to access
memory and memory-mapped resources.

From IOMMU specification it's pretty clear, an untranslated address is
always an IOVA.

If you look at the introduction section and section 2.3. "Process to
translate an IOVA", translation (if enabled by the device/process
context) to GPA, SPA is expressed as:

step #17: GPA =3D FSC[IOVA]
step #19: SPA =3D IOHGATP[GPA]

With that, MSI address translations always use GPA as an input
(section 2.3.3. "Process to translate addresses of MSIs"), and is done
as step #18 of the IOVA translation.

And now:
If FSC.Mode =3D=3D Bare, step #17 translation is simple GPA =3D IOVA
If IOHGATP.Mode =3D=3D Bare, step #19 translation is simple SPA =3D GPA

If both FSC and IOHGATP modes are bare, no address translation is
performed, and SPA =3D GPA =3D IOVA. However if "MSI page tables are
enabled, then the MSI address translation process specified in Section
2.3.3 is invoked".  This was the reason to put the
riscv_iommu_msi_check() function before check for pass-through mode
check.

If FSC.Mode =3D=3D Bare and untranslated address given to the function
riscv_iommu_spa_fetch() is an GPA =3D IOVA. It could also be SPA if
IOHGATP.Mode =3D=3D Bare, but it is irrelevant for the MSI address
translation.  That is the reason to put only the check for !en_s in
before riscv_iommu_msi_check() call.

I'm aware that VFIO uses S-Stage translation only, but it does not
change the hardware logic. For such cases VFIO can provide IMSIC
register mappings in S-Stage PT to emulate MSI doorbell registers (if
needed). When S-Stage translation is used, an untranslated address
processed by the IOMMU hardware is still an IOVA, even if the guest OS
/ VFIO user treats it as PA.

Modification of the check to include en_g ( !(en_s && en_g) && ,,, )
will incorrectly enable MSI address translation for an IOVA address
(as defined in IOMMU spec) if G-Stage translation is set to Bare mode.

I'd suggest to keep the s/g stage checks here as:
      if ((iotlb->perm & IOMMU_WO) && !en_s &&
          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
          ...
      }

Hope that helps this discussion.
Best,
- Tomasz

>      /*
>       * Early check for MSI address match when IOVA =3D=3D GPA to
>       * support VFIO+irqbypass. The riscv-iommu spec doesn't
>       * consider the case where a GPA can be produced by S-stage
>       * only, but we have real life examples like Linux VFIO that
>       * work that way. The spec alone does not provide a reliable
>       * way of detecting if IOVA =3D=3D GPA.
>       *
>       * The spec is clear about what is a VA: "If the virtual
>       * memory scheme selected for neither stage is Bare then
>       * the IOVA is a VA", in our case "(en_s && en_g)". We also
>       * know that MSI tables will always hold GPAs.
>       *
>       * Thus the check consists of ruling out VAs and checking
>       * the MSI table.
>       */
>      if (!(en_s && en_g) && (iotlb->perm & IOMMU_WO) &&
>          riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>          iotlb->target_as =3D &s->trap_as;
>          iotlb->translated_addr =3D iotlb->iova;
>          iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
>          return 0;
>      }
>
> Tomasz, let me know if you have any opinions against it. I intend to send
> the v9 start of next week.
>
>
> Thanks,
>
>
> Daniel
>
>
> >
> > Thanks,
> > drew

