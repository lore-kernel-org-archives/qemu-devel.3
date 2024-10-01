Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A13CF318C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 22:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svl8y-00077W-UN; Tue, 01 Oct 2024 18:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svl8v-00071C-9I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 18:14:54 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1svl8s-0002Wc-1N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 18:14:52 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a340f9dd8aso32918255ab.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727820888; x=1728425688;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+GzqC8c9YdleLt63VCp5J5sGSxaA+wjArykXVcb8gs=;
 b=iMH9LDADy/NWWdcyomy2ruPAxmjCWzVYtKfa61KZumLN6kOD/HAs5OgMIqWNxhmwe3
 JWpXTwaZ8vV4XhSr3/4DAphDDciZmZVp5wyHyRrRC3gd0731kkw1udFfPVav8RSGI1yz
 L5/8EY5eUUH3g2LveGcxtrlWKY98Bm1JOmT3NzE403Dwc1LuRab42ihwmCnXxG9yoogd
 /y06ZK6WsllEeP/gxRRQTogDQBMS7xssvOLev0IABWL1dO+dhAm563JqkxBUqEmkOQNy
 mqcUMlTWs+02ucN1wJbcDGguys+MnZgKYGH7AJULgm2ltYpaNibLc/dJUWYUGK9sdxGS
 0kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727820888; x=1728425688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+GzqC8c9YdleLt63VCp5J5sGSxaA+wjArykXVcb8gs=;
 b=ZSoBcdp70StTQbUG/4uR1A6b1rYpbMoqJhhUxDIzN/Yl9ssX8ArhYrgB6N4pAgioAM
 lRFr8UoLyQkS8h6n877ByaDPgmlE16NOKu3l023RP2m5IAKUp1CKvNI0au2zJ831ETVX
 mm9SHtrQV3778foWk+xWsHNp5bdgsbsxXqoAO1TNpEty/C0lpU7ttwviRehu1vYNmg76
 yEOzFLt4s3I9lAImbEE8nVo3eFCBZTFtg83qIc3F+QqdF3YXaKRqlztxXvN9NMCp1ezS
 8IacRACtq/KJMMgQNQRyKGwc/A2br5Co9JcDaRGBi8qDsddvPgHuk55WpcHKRUXljJ9S
 wx/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu/1qlD+PsWw4AKjHWmuKgE6DhPkn3KwT8T1OxjKOmjY8kJMD67sNGXWfGb25/TW/gtg0L6qtdQ5f4@nongnu.org
X-Gm-Message-State: AOJu0YyCqAc61qux1HpkqMYfUm0DPOqyyMIwrDR6G4JZKXvNV4fPyVbo
 hY+VfduxtfCLkTIhlAoOzB6WkWzTnl3ckNRzcIEASvHmbb7C5vI9kz+V0S6F/1pl2yJc2fFr5cE
 I3zfC/upJ+tm9MI8JtdXh5QIV0z1g6GOkrll2ig==
X-Google-Smtp-Source: AGHT+IHo0UH2UWgcLD0QwCluqO88w4IxTXa8iQmwtbUmhsow7MI6P27RYYw8rBDsz3wjNNVWH1L7DARhedfOxFpuDKw=
X-Received: by 2002:a05:6e02:1c42:b0:3a3:632e:f009 with SMTP id
 e9e14a558f8ab-3a36596147emr10253685ab.26.1727820888025; Tue, 01 Oct 2024
 15:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
 <CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com>
 <634d685c-7e36-409e-9b41-b9162a5acf9c@ventanamicro.com>
 <CAFEAcA-=s9zatyYYOP01BO1o7jPpY45mWkDM3N_yydD=Ka3GNw@mail.gmail.com>
In-Reply-To: <CAFEAcA-=s9zatyYYOP01BO1o7jPpY45mWkDM3N_yydD=Ka3GNw@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 1 Oct 2024 15:14:37 -0700
Message-ID: <CAH2o1u6pQXOFbo6EyJAOfkAgE6VPK7MGsuvLD=nzhVeQFfrHwA@mail.gmail.com>
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>, 
 qemu-devel@nongnu.org, Sebastien Boeuf <seb@rivosinc.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=tjeznach@rivosinc.com; helo=mail-il1-x132.google.com
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

On Sun, Sep 29, 2024 at 8:46=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 28 Sept 2024 at 22:01, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> >
> >
> > On 9/28/24 5:22 PM, Peter Maydell wrote:
> > > On Tue, 24 Sept 2024 at 23:19, Alistair Francis <alistair23@gmail.com=
> wrote:
>
> > >> +/* Register helper functions */
> > >> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> > >> +    unsigned idx, uint32_t set, uint32_t clr)
> > >> +{
> > >> +    uint32_t val;
> > >> +    qemu_spin_lock(&s->regs_lock);
> > >> +    val =3D ldl_le_p(s->regs_rw + idx);
> > >> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> > >> +    qemu_spin_unlock(&s->regs_lock);
> > >> +    return val;
> > >> +}
> > >
> > > This looks very weird. Nobody else's IOMMU implementation
> > > grabs a spinlock while it is accessing guest register data.
> > > Why is riscv special? Why a spinlock? (We use spinlocks
> > > only very very sparingly in general.)
> >
> >
> > The first versions of the IOMMU used qemu threads. I believe this is wh=
ere
> > the locks come from (both from registers and from the cache).
> >
> > I'm not sure if we're ever going to hit a race condition without the lo=
cks
> > in the current code (i.e. using mmio ops only). I think I'll make an at=
tempt
> > to remove the locks and see if something breaks.
>
> Generally access to the backing for guest registers in a
> device model is protected by the fact that the iothread lock
> (BQL) is held while the guest is accessing a device. I think for
> iommu devices there may be some extra complication because they
> get called as part of the translate-this-address codepath
> where I think the BQL is not held, and so they typically
> have some qemu_mutex to protect themselves[*]. But they
> don't generally need/want to do the handling at this very
> fine-grained per-read/write level.
>
> [*] This is just what I've gathered from a quick read through
> our other iommu implementations; don't take it as gospel.
>
> If you do need to do something complicated with locking it would
> be good to have a comment somewhere explaining why and what
> the locking principles are.
>

Locking for the iot and ctx cache is still required as the translation
requests going through IOMMUMemoryRegionClass.translate callback
(riscv_iommu_memory_region_translate) are unlikely protected by BQL.
With ATS translation requests and eventually PRI notifications coming
to the iommu implementation, cache structures will be modified without
any external locking guarantees.

To add some background to register access spin locks.
Original implementation runs all IOMMU command processing logic as a
separate thread, avoiding holding BQL while executing cache
invalidations and other commands. This was implemented to mimic real
hardware, where IOMMU operations are not blocking CPU execution.
During the review process it was suggested and modified to execute all
commands directly as part of the MMIO callback. Please note, that this
change has consequences of potentially holding CPU/BQL for unspecified
time as the command processing flow might be calling registered IOMMU
memory notifiers for ATS invalidations and page group responses.
Anyone implementing memory notifier callback will now execute with BQL
held. Also, updates to register state might happen during translation
fault reporting and or/pri. At least queue CSR/head/tail registers
updates will need some sort of protection.

Probably adding a comment in the code and maybe restoring the original
threading model would make this implementation more readable and less
problematic in the future.

Thanks for the review,
- Tomasz


> thanks
> -- PMM

