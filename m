Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01077C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZea-0001Q9-Ge; Thu, 30 May 2024 02:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZeY-0001PR-9x; Thu, 30 May 2024 02:52:46 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZeW-0001bA-E9; Thu, 30 May 2024 02:52:46 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c1afe1751cso138596a91.3; 
 Wed, 29 May 2024 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717051962; x=1717656762; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oj5HRQ5d3C9/ama6wTPDp/cgBgTcR+SpNNWXKNbplZw=;
 b=eCoU3XDY4d+ekKuslBqnlRHK3u/nm3ZB91mumTN2x4KINxeC6ogVHaYs3ANHReZ2Ma
 94kH/VWwQSrEmxNMg0xS1OFhd9wIHf6tb3JPyXY3fDpcAOvt+ZCMHc1qQPRhzpWlplfr
 GOLIWHivEV5ivZMz8viDlXyxPhF1Fsdo9rnwYIDopFwPQ/lYB4JdYHkU9ytNiMjeXRNx
 wZ4nvRrX43DCayD5BVViR+KQIOLq/AWYOiBTGJsYO8vsncCWyK7Ehlb6fPv9mo1QWTZM
 gz7rhDozq3L3zq323Z/7T8oQW4aLqy1kcXNEh9WVwJCuU0NYymEq3rHfHfBVocFfRE99
 Peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717051962; x=1717656762;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oj5HRQ5d3C9/ama6wTPDp/cgBgTcR+SpNNWXKNbplZw=;
 b=tn9EC4T2NxSM4W5dyQL7aUCD9yHVmyyg0VkBG3G4VfKCikJzPCYcoud0F52cPKYQM7
 eBu5NYRf1fJ2ZLvDNDx3LYac8wwbEFaXYWp4YR3IAwhrqvyU5MpIf7sYMz+Qo/Q6JKAz
 iuUhmfChl0vHxrq43XRmII1yqz23wWut9ln8CIFaD60VA0lJuwFDclpJJGpBwoNO+lir
 7ggNb1kv2Tf9dfGqPK/ujr/Yq/xVFZ6nVs8pQFXwj22YQbCHyZ6/I/tjYT9/wraB8ctf
 0HP2okOqe/jnH7HFcngsWITnTxb8jwMF9VARIpv0KKW0wfG18Rww/7jw/dE+O51z3Gac
 URdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBj5u/B4hIRDy6yjengaVG99OrE3TDbaU5HY8YwvYjVofAv7cM34WkHkcfgjDsq4zU4O3heJJnKsff/uqfRlcPQKulRcrJWt5Zn/c0jaJIirV+IrymUYSphE=
X-Gm-Message-State: AOJu0Yzs3KZU3mI1BSBohgUsh3bBLIY3SgiSecHuCRAOufkj86ntF6zd
 uncOwO3aT1Rff6zWlt6wg82GYYpYwrZy9AKA+FKATJb7dei6F5LE
X-Google-Smtp-Source: AGHT+IEPUoTCwfusdQtuj+46+PLHA7yHmnwlySQ9UxqKyUvjNjhibHA07r6pLNkZc7aD/z7nx/5Xwg==
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id
 98e67ed59e1d1-2c1abc12489mr1318487a91.4.1717051961950; 
 Wed, 29 May 2024 23:52:41 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77a70d8sm918104a91.52.2024.05.29.23.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 23:52:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 16:52:36 +1000
Message-Id: <D1MS4B4OOMP2.URZ3Y2R98BC8@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 08/10] ppc/pnv: Invert the design for big-core
 machine modelling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-9-npiggin@gmail.com>
 <eb04e4c8-26ca-4330-ae32-a58737d2a78b@kaod.org>
In-Reply-To: <eb04e4c8-26ca-4330-ae32-a58737d2a78b@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed May 29, 2024 at 4:57 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/26/24 14:26, Nicholas Piggin wrote:
> > POWER9 and POWER10 machines come in two variants, "big-core" and
> > "small-core".
> >=20
> > Big core machines are SMT8 from the software point of view, but in the
> > low level platform topology ("xscom registers and pervasive
> > addressing"), these look more like a pair of small cores ganged
> > together.
> >=20
> > Presently, the way this is modelled is to create an SMT8 PnvCore and
> > add special cases to xscom and pervasive for big-core mode. This is
> > becoming too complicated to manage as more of the machine is modelled.
> > The better approach looks like the inverse, which is creating 2xPnvCore
> > ganging them together to look like an SMT8 core in TCG. The TCG SMT cod=
e
> > is quite simple to do that, and then the xscom and pervasive modelling
> > does not need to differentiate big and small core modes for the most
> > part.
> >=20
> > device-tree building does need a special case to only build one
> > CPU node for each big-core because that's what the firmware expects.
> > And so does a special case workaround in the ChipTOD model.
> >=20
> > A big-core machine option is added for powernv9 and 10 machines.
>
> That's another patch.

Okay.

> It is difficult to follow all the changes. I think this patch
> needs further splitting.

Sure.

> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv.h         |   3 +
> >   include/hw/ppc/pnv_core.h    |   8 ++
> >   target/ppc/cpu.h             |   4 +-
> >   hw/ppc/pnv.c                 | 183 ++++++++++++++++++++++++++++------=
-
> >   hw/ppc/pnv_core.c            |  20 +++-
> >   hw/ppc/spapr_cpu_core.c      |   6 +-
> >   target/ppc/misc_helper.c     |   6 +-
> >   target/ppc/timebase_helper.c |   9 ++
> >   8 files changed, 197 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 476b136146..93ecb062b4 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -100,6 +100,9 @@ struct PnvMachineState {
> >       PnvPnor      *pnor;
> >  =20
> >       hwaddr       fw_load_addr;
> > +
> > +    bool         big_core;
> > +    bool         big_core_tbst_quirk;
>
> I think the quirk should be introduced in its own patch.

Good idea.

> > @@ -157,6 +157,14 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
> >  =20
> >       pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
> >  =20
> > +    /* Only one DT node per (big) core */
> > +    if (tir !=3D 0) {
> > +        g_assert(pc->big_core);
> > +        g_assert(tir =3D=3D 1);
> > +        g_assert(pc->hwid & 1);
> > +        return -1;
>
> return is -1 but it's not an error. right ?

Not an error just a "no CPU node to insert".

It's a bit ugly. Could return bool for yes/no and take a *offset
maybe?

> > @@ -1088,10 +1119,37 @@ static void pnv_power8_init(MachineState *machi=
ne)
> >  =20
> >   static void pnv_power9_init(MachineState *machine)
> >   {
> > -    if (machine->smp.threads > 8) {
> > -        error_report("Cannot support more than 8 threads/core "
> > -                     "on a powernv9/10 machine");
> > -        exit(1);
> > +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
> > +
> > +    if (pnv->big_core) {
>
> It would be interesting to have a max_smt machine class attribute too.

Yeah, as we talked about in the other thread. Probably helps
reduce code.

> > +        if (machine->smp.threads > 8) {
> > +            error_report("Cannot support more than 8 threads/core "
> > +                         "on a powernv9/10  machine");
> > +            exit(1);
> > +        }
> > +        if (machine->smp.threads % 2 =3D=3D 1) {
>
> is_power_of_2()

It does have that check later in pnv_init(), but I wanted
to be careful that we're dividing by 2 below I think it makes
it more obvious (and big-core can't have 1 thread per big core).

> > @@ -1099,6 +1157,8 @@ static void pnv_power9_init(MachineState *machine=
)
> >  =20
> >   static void pnv_power10_init(MachineState *machine)
> >   {
> > +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
> > +    pnv->big_core_tbst_quirk =3D true;
> >       pnv_power9_init(machine);
> >   }
> >  =20
> > @@ -1169,9 +1229,15 @@ static void pnv_processor_id_p9(PnvChip *chip,
> >                                   uint32_t core_id, uint32_t thread_id,
> >                                   uint32_t *pir, uint32_t *tir)
> >   {
> > -    if (chip->nr_threads =3D=3D 8) {
> > -        *pir =3D (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core=
_id << 3) |
> > -               (thread_id >> 1);
> > +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
>
> arg. We should avoid these qdev_get_machine() calls. Could big_core be a
> chip property instead ?

We could, but per machine probably makes more sense. It's
funny there seems to be no good way to get machine from CPU.
Maybe we can just add a machine pointer in PnvChip?

I'l probably leave that for another series and try to convert
most things.

> > +static bool pnv_machine_get_hb(Object *obj, Error **errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +
> > +    return !!pnv->fw_load_addr;
> > +}
> > +
> > +static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
> > +{
> > +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > +
> > +    if (value) {
> > +        pnv->fw_load_addr =3D 0x8000000;
> > +    }
> > +}
>
> we might want to get rid of the hostboot mode oneday. This was really
> experimental stuff.

Okay sure, I don't use it. Although we may want to run the
open source hostboot part of the firmware on QEMU one day,
we can always add back some options for it.

We do have a PowerVM mode too which tweaks a few things, but
that's no use for upstream.

> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 059d372c8a..05195527a5 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
>
> This change should come in another patch preferably

Yeah this might have got into the wrong patch.

Thanks,
Nick

