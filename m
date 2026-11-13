Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1C606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=PKUnClPX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwhd-0000BY-9u; Fri, 13 Nov 2026 14:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRwhb-00009U-65; Fri, 13 Nov 2026 14:12:47 -0500
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRwhX-0002qT-K8; Fri, 13 Nov 2026 14:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794597160; x=1794856360;
 bh=BVQ+DK6YBIdZgslr+yl8OkWDFRD0PqgcNJ1+qaC8wMk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PKUnClPX2dfj1q1wVhCGuQc72NUjzh5CS/HUXUEFVdn6/zBQNiuaXNySyrRlXysXB
 xWNtphFwcX/FPKxooXW+FuJCVc7MtXB3cNp4pxBts+DHGksRnViwBK6OoZ3BhnlCor
 DMKvuQuEXJqDEEIM2BOAXSDx3cFA2V6IipiwReWpMt4dhyhGd8waMSmBqFmCglUapi
 LobntZBhfEH2DP31ItWgJNszg1qZ9cUSP9ZUq0GqJAceL0SP23XCy8VXD/CtCWcd7E
 MeZnzonEIvus+H8RvItP9AfZkIT1KNboGbWscosRpiRFnZJEp23oE/DIE+Iy74TL6L
 hZumkaKH1YWGQ==
Date: Fri, 13 Nov 2026 19:12:34 +0000
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
From: Christian <christianslima@proton.me>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/riscv: make mstatus.SPELP read-only when
 S-mode is not present
Message-ID: <CBPdDhVgE-QLG3L1IfvH9dommTgm0X4euIIaV2Pik_9DoitqWoCoJ4eQD1KSRWtxg4W2cKSqeTKoI1VO8pQQw_NIMgovyw19C44bgub1T0w=@proton.me>
In-Reply-To: <80cdad68-96a7-45da-aef9-53357ed8210c@oss.qualcomm.com>
References: <20261112214810.78747-1-christianslima@proton.me>
 <20261112214810.78747-2-christianslima@proton.me>
 <80cdad68-96a7-45da-aef9-53357ed8210c@oss.qualcomm.com>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 9460b18f63d6d6733888c6927ac18b86a57a0267
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.22;
 envelope-from=christianslima@proton.me; helo=mail-4322.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Daniel.

> On 11/12/2026 6:48 PM, Christian S. Lima wrote:
> > According to the Zicfilp specification the bit SPELP in the mstatus
> > register should be 0 (read-only) when s-mode is not present.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456#note_4=
181630619
>=20
> The code LGTM but this tag doesn't do much as is.  Gitlab uses the tag to=
 automatically
> close the issue when the patch lands upstream.  It can't do much with a c=
omment.
>=20
> Reading the bug I believe the reporter intention was to add this SPELP co=
mment
> as a follow-up of what you've done in 4456, i.e. this should be done in t=
hat same
> scope.  If we upstream them separately there's a risk of Gitlab closing 4=
456 and,
> if this patch is left behind, the reporter can notice that the bug wasn't=
 fully
> resolved and reopen it.
>=20
> My suggestion is to either squash this change into the 4456 patch or send=
 it together
> as a 2 patch series.  Both are fine, as long as we upstream both changes =
at the
> same time.

I'll resend as a patch series.

Thanks,
Christian

>=20
> Thanks,
> Daniel
>=20
> >
> > Signed-off-by: Christian S. Lima <christianslima@proton.me>
> > ---
> >   target/riscv/tcg/csr.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> > index af444e3e6f..340c61a1c4 100644
> > --- a/target/riscv/tcg/csr.c
> > +++ b/target/riscv/tcg/csr.c
> > @@ -2124,7 +2124,10 @@ static RISCVException write_mstatus(CPURISCVStat=
e *env, int csrno,
> >
> >       /* If cfi lp extension is available, then apply cfi lp mask */
> >       if (env_archcpu(env)->cfg.ext_zicfilp) {
> > -        mask |=3D (MSTATUS_MPELP | MSTATUS_SPELP);
> > +        mask |=3D MSTATUS_MPELP;
> > +        if (riscv_has_ext(env, RVS)) {
> > +            mask |=3D MSTATUS_SPELP;
> > +        }
> >       }
> >
> >       mstatus =3D (mstatus & ~mask) | (val & mask);
>=20
> 

