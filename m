Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C148C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtMOR-0005l3-3k; Mon, 10 Aug 2026 05:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtMOQ-0005kb-8P
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 05:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtMOO-0005Xo-3H
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 05:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786354439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOw5wFcs0xcWyB6wigq0JHs3Sjz3xdjiEjcjcQojNhY=;
 b=Vd9afilmcpV4GECtjtxw8PAxzV9VTyiyW6hiw/JsZw/SJT3JvLlx2vbyq9j0eS0NkmzX6y
 1pziNmZs8qOKK5X3yNyx3qxUngYmkgauwHoB1AoCqk109DHJE9/B8jD3ud311l9r7TrWLX
 HFfnrtlYVd/1Frm/OAbkkDYi6IqDkq0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RAXmrMwOMSm_b4NoS5ilqA-1; Mon, 10 Aug 2026 05:33:52 -0400
X-MC-Unique: RAXmrMwOMSm_b4NoS5ilqA-1
X-Mimecast-MFC-AGG-ID: RAXmrMwOMSm_b4NoS5ilqA_1786354432
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9077b4c35c5so30929776d6.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786354432; cv=none;
 d=google.com; s=arc-20260327;
 b=PjxWU/y1MICEaTdUSQ6CfybQtvdZ2ylhzjiOPZNClyxEHMuKd9YecSKQHILAofEFWO
 H8lGm+0fnXLfZNMXm+mcB8YJh+LpEarj1Dg96CBuolxjBJE8+0vhV+E18wpLtwyX8jJG
 CR8//h8MWt7QN1Us7IF0zvRnogpnNoL1WUUohGoliK9PuyNYD/tuBpcQxpGInDMHLfqs
 ocwpHzAJMIkVGWL0PffIWltr++PP0RJYKIeMrrU6xDo7SGxMhITO5Ei8WTvLO11wlCP5
 IWE/E0bbs+VhGlPJuPtMF4cxbViTU4jTtehUslftZoldDQRUvX1c5CrvTdFWqjHOh0k5
 f3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SOw5wFcs0xcWyB6wigq0JHs3Sjz3xdjiEjcjcQojNhY=;
 fh=N3J9q6i2cr3eSlis9EdRMtBNO4p9skLMA7m+7t+A3/k=;
 b=MJ4Hw2Lwo76KBfMCeZgi+pLb1YBiA9YzXCNWtHhZT8eSmcHjzUlfa5gVWQdRd41cWp
 d9AF8b1XH0zlG3/g0BcykUhcKrU6Npxcg2CzHIn1moo1orbZ//cpCb8lmrsn4nBx2oq4
 yznFs1ERxdEAAu1ZEJsR6sw1IKFtqWA4gl3qpdmcdWvQQUhhyV2bZGHB+0GDKiBTuqoV
 prfMpE/2B3Ng2UQi1FFUDXhlYd/Z/V9n1Zd2JtjHPybcu2QunJhrizLkHdJLyYPI+UKx
 gobVMlaUuX8FpWZ81DP/hUO11ddI5tl3tWTYGw8YxGTt4qW5LRD2v76EB93zT4uAb4Te
 ghTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786354432; x=1786959232; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SOw5wFcs0xcWyB6wigq0JHs3Sjz3xdjiEjcjcQojNhY=;
 b=tXwh9+WJZEOqFB9E5yfhDJ3j0IfEej3KeMr9U/Ie6tCGyON7thcDFqQJDfhXVOHap6
 22gOnwXAi98oipYnHQHlpGbVb/DRDm7XZPC730xzUWgF07iWlU2oe29+LEdxsMzYnRdA
 vyQlS++VUvSkVVFGm3eAdctfdWzdf4zdRlsMtapEhSKhOJQTXDYuMrenVY45V/tuDPij
 tpF6MJwEYbBwiPv3nAeJo1NfEIQzAb+4pUsNWjHnGLxsfwJ7473ueD4/bPkdD0PocmDQ
 445YU9hb/OrUwjMZo+PqltbyfC+xn5MrIwK8GfEe+I/zXO/IHdeiDEmcOFb3DseeZwQU
 gqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786354432; x=1786959232;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SOw5wFcs0xcWyB6wigq0JHs3Sjz3xdjiEjcjcQojNhY=;
 b=b5fixKPQZ2Vg8OYvH03r3vjBCFSoAP2CEEzWIpVyG8Tq7k0gyXCtcHbidMdLDv4S0D
 Dgydwm6ebNjMNuWfSinN1mkZ032VdBFmDp+4sbJt+UNGMeTHeJIpTBVPKMlC9Guyp5iA
 OyymGjgK8ydUTEYHj9yDK42/oadClJYWqRj77FwoCh7krQbiRpvbrJXwAWy9HELzYIgg
 Iy9PEF13F0qemxyrClzwsbBrCLgoHYjZst5NmrzlnM5qAbTRO0R3/+f/8QgxnPXr6F1l
 TpeJcgMq9joFm41eYnQYKI9OIbX3wNOgntfzWAL+fYXOqR1sTmPOG6G776jGfD/IUuDB
 RfYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+5Y+tz2nOPsQxWdsKbbLc8rChSLm7x1aEDDsNwHtEcMWQ2K7mp7WMna4AgaQJHWoHr94FxhreJj0y@nongnu.org
X-Gm-Message-State: AOJu0YwmzQSDxZtMRU7b7NhU7M9ApHOXTv/6d2Yj5ky3QaBy9qUUpN96
 JqkVYAlIslhWBH8N9qWC8+uhtjeNOcJKY5WSbAW2iJRbvTj8JXi44VLVNy9RpQW0lU847u51gIf
 sRMBkgaOv1EnnyuZyQLLZqgWMmqoNp9LHaF0Y5lxWuiJp0lOWmN2fwH2Z5xuh5NOS7Cvq5gcEnv
 Na93VHkxvuBsHX3FKt2uGmAHxx1qpMefU=
X-Gm-Gg: AR+sD10+cGK+gsB/O+Dv103NzuWyeSmwjOBUUhnUu8Fx0iAP+kyf/Vc2Ph+W//fDK1Z
 JFy9siFq9eo7Y5FlpBMqZcffd/YYXoiAGzKzoq4APbPU2mQtJYmIq3T+gKU9K/GZi68s3gsX7SC
 4HSqoi3OMXwZhRGameZpSfeKCPB8Y+flKXOOpdxfkQOuzU7si7nD5z6oGdc/c=
X-Received: by 2002:a05:6214:21e7:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90a5e04ca4fmr691666d6.32.1786354431714; 
 Mon, 10 Aug 2026 02:33:51 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:8ee:fbc5:8110 with SMTP id
 6a1803df08f44-90a5e04ca4fmr691116d6.32.1786354431164; Mon, 10 Aug 2026
 02:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
 <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
 <anmJvO2PUDM0xa7l@redhat.com>
 <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
 <anmR9aKJcdtL_xTL@redhat.com>
 <CAPMcbCouxjFScnj54ETuBCbw6_rVx=kurAyWiFEPANMjM_QSHg@mail.gmail.com>
 <anmZxvE8f8BcaKEH@redhat.com>
In-Reply-To: <anmZxvE8f8BcaKEH@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 12:33:39 +0300
X-Gm-Features: AUfX_mw4-3onqB5XYlekG3dUNa5JiaxlFed78iv5lLyX5ZB9rVVtutzWY1lhabA
Message-ID: <CAPMcbCpkoSPbP0XFcunMeCQaCmPTpU7_+6_k9Nn2UGcQitxHbQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Valentino Paulon <valentino.paulon88@gmail.com>, qemu-devel@nongnu.org, 
 yvugenfi@redhat.com, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000501ac50658ae0daf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000501ac50658ae0daf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Aug 10, 2026 at 11:58:44AM +0300, Kostiantyn Kostiuk wrote:
> > On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
> >
> > wrote:
> >
> > > On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrote:
> > > > On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <
> berrange@redhat.com
> > > >
> > > > wrote:
> > > >
> > > > > On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrot=
e:
> > > > > > Hi Valentino,
> > > > > >
> > > > > > Sorry for the long delay.
> > > > > > I have a question for you
> > > > > >
> > > > > > On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon <
> > > > > > valentino.paulon88@gmail.com> wrote:
> > > > > >
> > > > > > > > > So, you propose to call seteuid/setegid before any I/O
> > > operation?
> > > > > > > >
> > > > > > > > Yes, specifically for the SSH commands, because they're
> unusual
> > > in
> > > > > > > > that we're doing stuff on behalf of an unprivileged user.
> > > > > > >
> > > > > > > +1 on the euid/egid direction -- as the reporter that's the
> > > outcome I
> > > > > > > was hoping for. It confines every step (read, mkdir, create,
> > > rename,
> > > > > > > chown) to what the target user could already do himself, whic=
h
> > > removes
> > > > > > > the whole TOCTOU class instead of chasing one instance of it.
> > > > > > >
> > > > > > > A few implementation details that tend to bite with this
> pattern,
> > > in
> > > > > > > case they save a round-trip:
> > > > > > >
> > > > > > > - drop the supplementary groups too, not just egid:
> initgroups()
> > > (or
> > > > > > > setgroups() with the user's list) while still root, otherwise
> the
> > > > > > > agent's effective access won't match the user's in either
> direction
> > > > > > >
> > > > > >
> > > > > > Technically, there is no limitation to running QGA in
> unprivileged
> > > mode.
> > > > > > Normally, it is a system daemon, but this is not mandatory.
> > > > > > In this case, we can not call initgroups because the caller mus=
t
> > > > > > have CAP_SETGID.
> > > > > > We can call initgroups only when QGA runs as root. What do you
> think?
> > > > >
> > > > > In any practical sense it is a system daemon given the set of
> commands
> > > > > it is exposing. Thus, IMHO, deploying as an unprivileged user
> should
> > > > > be considered a broken deployment. We could make that explicit by
> > > > > refusing to launch.
> > > > >
> > > >
> > > > Makes sense, but we have one more issue with QGA unit tests in this
> case.
> > > > They are called by an unprivileged user (build user), and initgroup=
s
> > > broke
> > > > it.
> > > > Is it possible to enter the namespace automatically by the test
> engine?
> > >
> > > We can't assume that is possible todo in all build/test environments.
> > >
> > > Doing things as different user accounts feels pretty dubious for the
> > > scope of a unit test too - that is really functional or integration
> > > testing.
> > >
> > > Can we somehow restructure the tests and/or agent code to avoid the
> > > changing groups stuff in unit tests.
> > >
> >
> > There are two possible options:
> > 1. add #ifdef QGA_BUILD_UNIT_TEST into qmp_guest_ssh_* functions
> > 2. check the current uid and skip initgroups if it is zero (my initial
> > question)
>
> Surely you mean "if it is non-zero" here, as it is with uid!=3D0 that
> the UID changes will fail.
>

yes. So what sounds better: "ifdef" or "uid!=3D0"?

Best Regards,
Kostiantyn Kostiuk.



>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000501ac50658ae0daf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,=
 2026 at 12:28=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Mon, Aug 10, 2026 at 11:58:44AM +03=
00, Kostiantyn Kostiuk wrote:<br>
&gt; On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com=
</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrang=
e@redhat.com</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Ko=
stiuk wrote:<br>
&gt; &gt; &gt; &gt; &gt; Hi Valentino,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Sorry for the long delay.<br>
&gt; &gt; &gt; &gt; &gt; I have a question for you<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino =
Paulon &lt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"mailto:valentino.paulon88@gmail.com" ta=
rget=3D"_blank">valentino.paulon88@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; So, you propose to call seteuid/set=
egid before any I/O<br>
&gt; &gt; operation?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Yes, specifically for the SSH commands, =
because they&#39;re unusual<br>
&gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; that we&#39;re doing stuff on behalf of =
an unprivileged user.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +1 on the euid/egid direction -- as the repor=
ter that&#39;s the<br>
&gt; &gt; outcome I<br>
&gt; &gt; &gt; &gt; &gt; &gt; was hoping for. It confines every step (read,=
 mkdir, create,<br>
&gt; &gt; rename,<br>
&gt; &gt; &gt; &gt; &gt; &gt; chown) to what the target user could already =
do himself, which<br>
&gt; &gt; removes<br>
&gt; &gt; &gt; &gt; &gt; &gt; the whole TOCTOU class instead of chasing one=
 instance of it.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; A few implementation details that tend to bit=
e with this pattern,<br>
&gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; &gt; case they save a round-trip:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; - drop the supplementary groups too, not just=
 egid: initgroups()<br>
&gt; &gt; (or<br>
&gt; &gt; &gt; &gt; &gt; &gt; setgroups() with the user&#39;s list) while s=
till root, otherwise the<br>
&gt; &gt; &gt; &gt; &gt; &gt; agent&#39;s effective access won&#39;t match =
the user&#39;s in either direction<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Technically, there is no limitation to running QGA=
 in unprivileged<br>
&gt; &gt; mode.<br>
&gt; &gt; &gt; &gt; &gt; Normally, it is a system daemon, but this is not m=
andatory.<br>
&gt; &gt; &gt; &gt; &gt; In this case, we can not call initgroups because t=
he caller must<br>
&gt; &gt; &gt; &gt; &gt; have CAP_SETGID.<br>
&gt; &gt; &gt; &gt; &gt; We can call initgroups only when QGA runs as root.=
 What do you think?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; In any practical sense it is a system daemon given the =
set of commands<br>
&gt; &gt; &gt; &gt; it is exposing. Thus, IMHO, deploying as an unprivilege=
d user should<br>
&gt; &gt; &gt; &gt; be considered a broken deployment. We could make that e=
xplicit by<br>
&gt; &gt; &gt; &gt; refusing to launch.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Makes sense, but we have one more issue with QGA unit tests =
in this case.<br>
&gt; &gt; &gt; They are called by an unprivileged user (build user), and in=
itgroups<br>
&gt; &gt; broke<br>
&gt; &gt; &gt; it.<br>
&gt; &gt; &gt; Is it possible to enter the namespace automatically by the t=
est engine?<br>
&gt; &gt;<br>
&gt; &gt; We can&#39;t assume that is possible todo in all build/test envir=
onments.<br>
&gt; &gt;<br>
&gt; &gt; Doing things as different user accounts feels pretty dubious for =
the<br>
&gt; &gt; scope of a unit test too - that is really functional or integrati=
on<br>
&gt; &gt; testing.<br>
&gt; &gt;<br>
&gt; &gt; Can we somehow restructure the tests and/or agent code to avoid t=
he<br>
&gt; &gt; changing groups stuff in unit tests.<br>
&gt; &gt;<br>
&gt; <br>
&gt; There are two possible options:<br>
&gt; 1. add #ifdef QGA_BUILD_UNIT_TEST into qmp_guest_ssh_* functions<br>
&gt; 2. check the current uid and skip initgroups if it is zero (my initial=
<br>
&gt; question)<br>
<br>
Surely you mean &quot;if it is non-zero&quot; here, as it is with uid!=3D0 =
that<br>
the UID changes will fail.<br></blockquote><div><br></div><div><span class=
=3D"Q6ibn ng" style=3D"border-style:none;background:none">yes.</span> So wh=
at sounds better: &quot;ifdef&quot; or &quot;uid!=3D0&quot;?</div><div><div=
><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div>=
</div></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--000000000000501ac50658ae0daf--


