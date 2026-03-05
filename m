Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D889DF33A88
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAg3-0000pA-F1; Thu, 05 Mar 2026 10:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vyAfy-0000mV-9I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:31:47 -0500
Received: from mail-4396.protonmail.ch ([185.70.43.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vyAfp-0004tn-Mu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1772724680; x=1772983880;
 bh=Jiz7U0uIa8/G7Per5i6TXSyhmvn0P29CGRaIeid2qkM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LICSTmNcVSTDykTTpx9WUcFGZ5u1fakzaYYIgOTDHcRo2m/+k+jiAaXj/GvQclrRN
 dQdeATKZXhGIkMHwK6aimsDJWNCTi3EWrEN222k+KgjDNU2RvGHz4WziVC0upO0LSt
 tyvxN0Od2hhufNOhpn9JhYKRWUZUOnN+/i+l0FC2VANlNd5Rvv0wQa5oPg7MXPK2Ql
 iv5U9VEMxJAcNd50RbOfMwyYfkLQdz41j6+LW9nzWrHQ9YGtxQwWB8MwwQK7T+RVjQ
 FR1dHG0IIyfmXkhIn5Jz9q3OP75xa4UnHF18rk5ay6P/aBw5BB3pECBH3LZamNk45/
 jGbWwfuc3mlAg==
Date: Thu, 05 Mar 2026 15:31:16 +0000
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
From: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/char: clear dangling GLib event source tag
Message-ID: <9VW-yqM7ubKmrHUW7jRJTjphp9WqJZG8dmOYksy0wI_SO9ZuYEC6qhzeXXSzR5eiYvCjfydot5wjaiu5VimmKXtt8EpBQ0EpnGbNVf-2cWw=@matthewpenney.net>
In-Reply-To: <CAJ+F1CKh=00BPwvwumeU6N50J1YKi2Lq8T9oY1Sozk_3z=JYJQ@mail.gmail.com>
References: <20260305003012.108262-1-matt@matthewpenney.net>
 <CAMxuvazif5c-wpPCG4dce-jm_G4MRxkZqP0qyp5TucudmwDLMA@mail.gmail.com>
 <l7SUyMhQt6JPXzWAoUOEWkMw02yJQDvwHWNTpN6NnK6S8jrLk3AExgEqpOvvfSgJLYLBDmJ1ji3Eg5qB_NjhV21c1f01sC8ZkwBY5YQl98I=@matthewpenney.net>
 <CAJ+F1CKh=00BPwvwumeU6N50J1YKi2Lq8T9oY1Sozk_3z=JYJQ@mail.gmail.com>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 4e460677db6ee163fd324764195b2f048fcd7b7f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.96; envelope-from=matt@matthewpenney.net;
 helo=mail-4396.protonmail.ch
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Marc-Andr=C3=A9,

Thanks for the suggestion.

I will send a v2 of this patch updating it to use g_clear_handle_id(),
keeping the scope limited to the virtio-console fix.

I may submit a separate patch later for a broader conversion if the
maintainers are in agreement.

Best,
Matthew



Sent with Proton Mail secure email.

On Thursday, 5 March 2026 at 13:25, Marc-Andr=C3=A9 Lureau <marcandre.lurea=
u@gmail.com> wrote:

> Hi
>=20
> On Thu, Mar 5, 2026 at 2:22=E2=80=AFPM Matthew Penney <matt@matthewpenney=
.net> wrote:
> >
> > Hi Marc-Andr=C3=A9,
> >
> > Thanks for the swift reply!
> >
> > Should I start by sending a V2 with your proposed update just for virti=
o-console.c, or do you prefer a larger bulk change across the codebase?
>=20
> If you can clean the codebase in one patch, hopefully this is
> agreeable with all the subsystem maintainers.
>=20
> Though if your patch is actually a fix, it's worth it to make it a
> different patch.
>=20
> >
> > Best,
> > Matthew
> >
> >
> >
> > Sent with Proton Mail secure email.
> >
> > On Thursday, 5 March 2026 at 10:23, Marc-Andr=C3=A9 Lureau <marcandre.l=
ureau@redhat.com> wrote:
> >
> > > Hi
> > >
> > > On Thu, Mar 5, 2026 at 1:40=E2=80=AFAM Matthew Penney <matt@matthewpe=
nney.net> wrote:
> > > >
> > > > Clear dangling GLib event source tag when virtio-console is
> > > > unrealized. This prevents a stale tag from being used, and
> > > > maintains consistency with the rest of virtio-console.
> > > >
> > > > Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> > > > ---
> > > >  hw/char/virtio-console.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> > > > index 25db0f019b..11bf51e3ea 100644
> > > > --- a/hw/char/virtio-console.c
> > > > +++ b/hw/char/virtio-console.c
> > > > @@ -258,6 +258,7 @@ static void virtconsole_unrealize(DeviceState *=
dev)
> > > >
> > > >      if (vcon->watch) {
> > > >          g_source_remove(vcon->watch);
> > > > +        vcon->watch =3D 0;
> > >
> > > The glib >=3D 2.56 way is:
> > > g_clear_handle_id(&vcon->watch, g_source_remove);
> > >
> > > We could do a bulk change for the whole code base imho
> > >
> > > anyway
> > > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > >      }
> > > >  }
> > > >
> > > > --
> > > > 2.53.0
> > > >
> > > >
> > >
> > >
> >
>=20
>=20
> --
> Marc-Andr=C3=A9 Lureau
> 

