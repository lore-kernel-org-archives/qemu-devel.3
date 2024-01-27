Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C54C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 20:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTosU-0000NR-EH; Sat, 27 Jan 2024 15:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rTosS-0000NH-HV
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 15:02:08 -0500
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1rTosP-00057s-J3
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 15:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=s9gkEmiqHa4btVJijOE5w4RIgWziak4MNB9tpKyIun8=; b=mOVidw3BPb/6p5d7fstnYFt/yM
 cBVsXwDh/klfl1yBqryrfdNkvGLlgFN2QcZ/2TTqMKtT4TWXb6rWbjhDBv0oI6F8Vq5BzJr+4sbwG
 7MGLzuzw2F7EQv+QvcrjxaBmtk6GoJgVD/49FnsLupoq8/ApllSCg04irxqMaORruzOsMr3ejMlNu
 ryzCH2J7pxPmwReA9THtSVwjGFWvxRrZ+nND1CEzlSJIej/uqMXujimCIJOkkbT+sr5GjOmTbdR6d
 D9+y4oeR0LC0LOEhFj9eVGrrVoDa/NidoQuh6eI55zRDhIhP+a2cuh0+znmTCKJ9vMT13jNaEDMaE
 kI2OJ2SA==;
Received: from p578ec111.dip0.t-ipconnect.de ([87.142.193.17]
 helo=shark.fritz.box) by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1rTosK-0037pD-2P; Sat, 27 Jan 2024 21:02:00 +0100
Message-ID: <53848323cd915bb82f00709c491953954321c873.camel@kernkonzept.com>
Subject: Re: [PATCH] target/arm: fix exception syndrome for AArch32 bkpt insn
From: Jan =?ISO-8859-1?Q?Kl=F6tzke?= <jan.kloetzke@kernkonzept.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Sat, 27 Jan 2024 21:01:59 +0100
In-Reply-To: <CAFEAcA8f5BBexmtoBHgV6o+KrHbjVvCTZ6VDV54muK_wdvgQTg@mail.gmail.com>
References: <20240119212945.2440655-1-jan.kloetzke@kernkonzept.com>
 <CAFEAcA8f5BBexmtoBHgV6o+KrHbjVvCTZ6VDV54muK_wdvgQTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=jan.kloetzke@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2024-01-23 at 17:58 +0000, Peter Maydell wrote:
> On Fri, 19 Jan 2024 at 22:40, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.=
com> wrote:
>=20
> > ---
> >  target/arm/helper.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index e068d35383..71dd60ad2d 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -11013,6 +11013,26 @@ static void arm_cpu_do_interrupt_aarch32(CPUSt=
ate *cs)
> >      }
> >=20
> >      if (env->exception.target_el =3D=3D 2) {
> > +        /* Debug exceptions are reported differently on AARCH32 */
>=20
> Capitalization is "AArch32".

Right.

> > +        switch (syn_get_ec(env->exception.syndrome)) {
> > +        case EC_BREAKPOINT:
> > +        case EC_BREAKPOINT_SAME_EL:
> > +        case EC_AA32_BKPT:
> > +        case EC_VECTORCATCH:
> > +            env->exception.syndrome =3D syn_insn_abort(arm_current_el(=
env) =3D=3D 2,
> > +                                                     0, 0, 0x22);
> > +            break;
> > +        case EC_WATCHPOINT:
> > +        case EC_WATCHPOINT_SAME_EL:
> > +            /*
> > +             * ISS is compatible between Watchpoints and Data Aborts. =
Also
> > +             * retain the lowest EC bit as it signals the originating =
EL.
> > +             */
> > +            env->exception.syndrome &=3D (1U << (ARM_EL_EC_SHIFT + 1))=
 - 1U;
>=20
> Is this supposed to be clearing out (most of) the EC field?
> I'm not sure that's what it's doing.

Yes, this was the intention. But I admit it's barely readable.

> In any case I think we
> could write this in a more clearly understandable way using
> either some new #defines or functions in syndrome.h or the
> deposit64/extract64 functions.
>=20
> My suggestion is to put in syndrome.h:
>=20
> #define ARM_EL_EC_LENGTH 6
>=20
> static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
> {
>     return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
> }
>=20
> (you'll need to add #include "qemu/bitops.h" too)
>=20
> and then these cases can be written:
>=20
>     case EC_WATCHPOINT:
>         env->exception.syndrome =3D syn_set_ec(env->exception.syndrome,
>                                              EC_DATAABORT);
>         break;
>     case EC_WATCHPOINT_SAME_EL:
>         env->exception.syndrome =3D syn_set_ec(env->exception.syndrome,
>                                              EC_DATAABORT_SAME_EL);
>         break;

Yes, that is much better. I'll send a V2 shortly.

>=20
> > +            env->exception.syndrome |=3D (EC_DATAABORT << ARM_EL_EC_SH=
IFT)
> > +                                       | ARM_EL_ISV;
>=20
> I don't think we should be setting ISV here -- the EC_WATCHPOINT
> syndromes don't have any of the instruction-syndrome info
> and "watchpoint" isn't one of the cases where an AArch32
> data-abort syndrome should have ISV set.

Indeed. I guess I meant ARM_EL_IL but this is not required either
because syn_watchpoint() already sets it. I'll remove it.

Thanks,
Jan
>=20

