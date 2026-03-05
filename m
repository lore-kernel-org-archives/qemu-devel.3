Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF06F3092C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 13:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy8dF-0006vn-3v; Thu, 05 Mar 2026 08:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vy8dC-0006ve-Vj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:20:47 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vy8dA-00013g-K1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 08:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1772716838; x=1772976038;
 bh=/wVLuffEBSb5wkpWmJPmZXOHlnmMqm87ltvW8Gu64qk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Znczhf8JaiutHkaaGbK+vm5u4gVESi++MrMneP1fbkG6WnqLMIP0JX9JnCXPZBeW9
 ySRI2emqDVc3t4EtpR93it71Nhdb0bhZKSipzqUmziLzjJHLF5bTCZZS+9tD+Kb1ov
 LNoliuk6YPlLD20NORikiXxRxTUJplZW2NWT2fDxi+EAJeaAx0Gw/MhUcVuUXRra59
 +1lOqb5dLiTMfPqfgM31jO7TP9ufYbD3PkHR9pL3RrqwtLMaUzZjXV4Z2BLsuqNPFl
 7MGMLJSYAs/yiMNTF4s3wdkFGB9r8TvrN+Tic/EypLrP71LSHAZJr5KdtdbK0MzSBu
 +koIcZbT60X5A==
Date: Thu, 05 Mar 2026 13:20:35 +0000
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
From: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/char: clear dangling GLib event source tag
Message-ID: <l7SUyMhQt6JPXzWAoUOEWkMw02yJQDvwHWNTpN6NnK6S8jrLk3AExgEqpOvvfSgJLYLBDmJ1ji3Eg5qB_NjhV21c1f01sC8ZkwBY5YQl98I=@matthewpenney.net>
In-Reply-To: <CAMxuvazif5c-wpPCG4dce-jm_G4MRxkZqP0qyp5TucudmwDLMA@mail.gmail.com>
References: <20260305003012.108262-1-matt@matthewpenney.net>
 <CAMxuvazif5c-wpPCG4dce-jm_G4MRxkZqP0qyp5TucudmwDLMA@mail.gmail.com>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: e8bdae0f08fa49a89d98d9d769b54511cc26fa93
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matt@matthewpenney.net;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks for the swift reply!

Should I start by sending a V2 with your proposed update just for virtio-co=
nsole.c, or do you prefer a larger bulk change across the codebase?

Best,
Matthew



Sent with Proton Mail secure email.

On Thursday, 5 March 2026 at 10:23, Marc-Andr=C3=A9 Lureau <marcandre.lurea=
u@redhat.com> wrote:

> Hi
>=20
> On Thu, Mar 5, 2026 at 1:40=E2=80=AFAM Matthew Penney <matt@matthewpenney=
.net> wrote:
> >
> > Clear dangling GLib event source tag when virtio-console is
> > unrealized. This prevents a stale tag from being used, and
> > maintains consistency with the rest of virtio-console.
> >
> > Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> > ---
> >  hw/char/virtio-console.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> > index 25db0f019b..11bf51e3ea 100644
> > --- a/hw/char/virtio-console.c
> > +++ b/hw/char/virtio-console.c
> > @@ -258,6 +258,7 @@ static void virtconsole_unrealize(DeviceState *dev)
> >
> >      if (vcon->watch) {
> >          g_source_remove(vcon->watch);
> > +        vcon->watch =3D 0;
>=20
> The glib >=3D 2.56 way is:
> g_clear_handle_id(&vcon->watch, g_source_remove);
>=20
> We could do a bulk change for the whole code base imho
>=20
> anyway
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> >      }
> >  }
> >
> > --
> > 2.53.0
> >
> >
>=20
> 

