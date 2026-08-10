Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99F0C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNYZ-0003vb-1q; Mon, 10 Aug 2026 06:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtNYW-0003vR-TZ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtNYT-0001eL-UZ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786358908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edO+LZJhgTpzj4NHsdMHQS0+qsWA9b2sUQXS4xrXKF4=;
 b=J1V16bBckgCHJ1U3H3h09d6yKo+BOANpya2W89JcyeeYWxYT81luFGjyQKqgtebLu4On7a
 xw3tRyX+go14X2Fq48JynW6n5lcWvBjTIvTWC2bGTfCRgPSvZn2Rt7WEKz6+H9qq2LPf8B
 pPWgbEcM3qkFrfedTLBT/IB2FNSmzRU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-2E1YUfYtNA2kyl-0Rel6cw-1; Mon, 10 Aug 2026 06:48:24 -0400
X-MC-Unique: 2E1YUfYtNA2kyl-0Rel6cw-1
X-Mimecast-MFC-AGG-ID: 2E1YUfYtNA2kyl-0Rel6cw_1786358904
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ea75996387so32231806d6.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 03:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358904; cv=none;
 d=google.com; s=arc-20260327;
 b=TO8iTD1jQf1MCm41p6XQ4C/Q3TxXgG0MrGfvV3nszsC9N4jAKE8ydgr852ZcsS1G8N
 Rvw/gCyKokBtyWqy8h2vXGEO4dZPBt2kBidTYqOjkp0/sCy1uRU1ABzLz+4lqIe1phY2
 QKIaGJQc6p/9bWZWrx242iSFFQOeFA+qgID374oT88ldzLewzntVJ4uY+6kH4g45VJ3D
 dqY+GXhgV0eiISghXJG1s/IyxhvUXyYtyRJqFLNu3eDITbQ5O0D2Bvghxw09ZASlpVak
 MvUBYT1TLoVkygSjvNVClOsbdpPUM6Yld7b+Jj7Tj8JE9NyOR7LrGJy/iuXoEvNA1XTe
 751A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=edO+LZJhgTpzj4NHsdMHQS0+qsWA9b2sUQXS4xrXKF4=;
 fh=mFHYeVKkGQhIcHBL0v8Z4Ydk0tvzNfroyxe0OZaEAEM=;
 b=QNhpug3wMQlKxNyXkJmFjUXgZmFx4xEvxYcGB+POytLPAT59WwunQhDUuvoymMiun8
 /WYzRDagseBbcFl3/BtSI6pqbW6lxdz83ceMaIIdNdyalcY5CBRazsm61MZNCRQgdLm2
 3mTfC9WxkMPesdcckYHyk8bpH1PFXslS1SICgJCRZ7pl2tEkratQ06couvu9pG1lN9Il
 ypOw9rbELRYc62Rmq+uiIN92wYnDcjaGm2RHMjNBqe7g7kLYrLHWtaieow/wcu3b5Ad/
 MMfCTfcqwiG3tuDR5ZAXAY/iBvOEiPNj0xzQtsN4ATdzwah+ZhRwURLeT51QWTttKekI
 BJFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786358904; x=1786963704; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=edO+LZJhgTpzj4NHsdMHQS0+qsWA9b2sUQXS4xrXKF4=;
 b=G+uCXJXM9i1eg3/XLWNXWT1T2Zcdlp90CxM0uMHOyrDTZMxMWxomYYiZvHNuht+nmh
 xgE/2UZdN2so1Z2xGnsm/TLBBZbuLAOWJkRR5RUoFyLy/SYnqPrSdbPKAJB6p/ATfyJI
 ij9R+6Tkoj4oQ6tZ3URHAXJhVJmKUT3I1Upa8yVI2cQdGqcUFtfydtQtMXFWHOVXr3HO
 X6GoMfyYlDLNOItLulVAf/rHyHxlpRcF3GIBN96DBfYaYApYIyL439aahT+Z6na7Nm4H
 YSrVKubcAAzBxv2Wd1UHm+IPCblwmMhTeQReg5eoF3KGsqgZ027OpyisJbJUw8dAh/10
 kL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786358904; x=1786963704;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=edO+LZJhgTpzj4NHsdMHQS0+qsWA9b2sUQXS4xrXKF4=;
 b=B2lNOUsR5eTH/IetOzpEG+vUhWAqUdY5oLUEEebAnSdbUgQtvSObdfp1i0M/TYTXL7
 ZHFA33iWAlNDYgRYmkyIltr1QQnpf1CUv+sCvadWuaTOTPZgsUgtbwdDw+wLHd41EanM
 ypSgHF7a0cYzfT3Ni5e1K5biC9sznqzoP0MT7t6HMDIE7SMNe4GdVQgHe6xrLjuFKUPM
 QxXFzmw8vz5BJ+KetW5WnCXgXGlgYQMTWlWkbf+tqKwgY36gSzVVl2pWqjkLhQ79Zfkk
 vcPgSh3onyriyrxcKe063wqaoJiXjtW/R7w8tM3vOESb2pnFUIghDTuhMYQ3wmhA3soW
 m1tQ==
X-Gm-Message-State: AOJu0Yz1ESIzGgnyzdn1inKJyEprkctVNVm16Y28fSDI60IKYvVaLfFG
 6jmol7WvORFOzh0mwOR41zjxqfQs+2uVMjn+EJ5/Oy5+FY/QSIBEl3UYK07Ids731EuXKFm29Vu
 yCnWP6prXJlfd67nvqfDB3UeyGuuNI9TpjsKVp271X+ZyREex6NVemfg9XtNzijC/JaafFhj/FK
 36xmFIfTmgI5Faqec54SL0BgE0tmUktFA=
X-Gm-Gg: AR+sD11wluQIPsNB4RxTDIb/bxi5exxJTeoBCUanzK1o4xL4A1cVzWoISiu24vvypYA
 w+IHv5Fw6QgJ2ZK19ulLSU873PhVfsTxc5pyD8uZ7YkzKBLtfMbjrAFNcyupG4RsLUnW6umV/lw
 Xl/obWUFGrDK1AFUSlan7gyMFeu67m7oBkQS5M9l0xGDif6Lv6kNxcWhtmOW0=
X-Received: by 2002:a05:6214:2c0d:b0:8ef:ea2a:2728 with SMTP id
 6a1803df08f44-90a5dffb920mr4719046d6.19.1786358903833; 
 Mon, 10 Aug 2026 03:48:23 -0700 (PDT)
X-Received: by 2002:a05:6214:2c0d:b0:8ef:ea2a:2728 with SMTP id
 6a1803df08f44-90a5dffb920mr4718796d6.19.1786358903348; Mon, 10 Aug 2026
 03:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
 <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
 <anmJvO2PUDM0xa7l@redhat.com>
 <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
 <anmR9aKJcdtL_xTL@redhat.com>
 <CAPMcbCouxjFScnj54ETuBCbw6_rVx=kurAyWiFEPANMjM_QSHg@mail.gmail.com>
 <anmZxvE8f8BcaKEH@redhat.com>
 <CAPMcbCpkoSPbP0XFcunMeCQaCmPTpU7_+6_k9Nn2UGcQitxHbQ@mail.gmail.com>
 <anmgvCrijp_en1Bx@redhat.com>
In-Reply-To: <anmgvCrijp_en1Bx@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 13:48:10 +0300
X-Gm-Features: AUfX_my8diBZfHpL7FeOzxyBNGeRhmlEh_Pka6RMormqcWrHsH64X-ms-887lKw
Message-ID: <CAPMcbCqN722Z8+qDF0_kLhXXPpYdbPr7LHwwEG1zP-DMQJG_rg@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: Valentino Paulon <valentino.paulon88@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 yvugenfi@redhat.com, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000e033f00658af1734"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e033f00658af1734
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Version 2 with setegid/seteuid logic pushed
Please review and test

On Mon, Aug 10, 2026 at 12:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Aug 10, 2026 at 12:33:39PM +0300, Kostiantyn Kostiuk wrote:
> > On Mon, Aug 10, 2026 at 12:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
> >
> > wrote:
> >
> > > On Mon, Aug 10, 2026 at 11:58:44AM +0300, Kostiantyn Kostiuk wrote:
> > > > On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P. Berrang=C3=A9 <
> berrange@redhat.com
> > > >
> > > > wrote:
> > > >
> > > > > On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrot=
e:
> > > > > > On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=
=A9 <
> > > berrange@redhat.com
> > > > > >
> > > > > > wrote:
> > > > > >
> > > > > > > On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk
> wrote:
> > > > > > > > Hi Valentino,
> > > > > > > >
> > > > > > > > Sorry for the long delay.
> > > > > > > > I have a question for you
> > > > > > > >
> > > > > > > > On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon <
> > > > > > > > valentino.paulon88@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > > > So, you propose to call seteuid/setegid before any I/=
O
> > > > > operation?
> > > > > > > > > >
> > > > > > > > > > Yes, specifically for the SSH commands, because they're
> > > unusual
> > > > > in
> > > > > > > > > > that we're doing stuff on behalf of an unprivileged use=
r.
> > > > > > > > >
> > > > > > > > > +1 on the euid/egid direction -- as the reporter that's t=
he
> > > > > outcome I
> > > > > > > > > was hoping for. It confines every step (read, mkdir,
> create,
> > > > > rename,
> > > > > > > > > chown) to what the target user could already do himself,
> which
> > > > > removes
> > > > > > > > > the whole TOCTOU class instead of chasing one instance of
> it.
> > > > > > > > >
> > > > > > > > > A few implementation details that tend to bite with this
> > > pattern,
> > > > > in
> > > > > > > > > case they save a round-trip:
> > > > > > > > >
> > > > > > > > > - drop the supplementary groups too, not just egid:
> > > initgroups()
> > > > > (or
> > > > > > > > > setgroups() with the user's list) while still root,
> otherwise
> > > the
> > > > > > > > > agent's effective access won't match the user's in either
> > > direction
> > > > > > > > >
> > > > > > > >
> > > > > > > > Technically, there is no limitation to running QGA in
> > > unprivileged
> > > > > mode.
> > > > > > > > Normally, it is a system daemon, but this is not mandatory.
> > > > > > > > In this case, we can not call initgroups because the caller
> must
> > > > > > > > have CAP_SETGID.
> > > > > > > > We can call initgroups only when QGA runs as root. What do
> you
> > > think?
> > > > > > >
> > > > > > > In any practical sense it is a system daemon given the set of
> > > commands
> > > > > > > it is exposing. Thus, IMHO, deploying as an unprivileged user
> > > should
> > > > > > > be considered a broken deployment. We could make that explici=
t
> by
> > > > > > > refusing to launch.
> > > > > > >
> > > > > >
> > > > > > Makes sense, but we have one more issue with QGA unit tests in
> this
> > > case.
> > > > > > They are called by an unprivileged user (build user), and
> initgroups
> > > > > broke
> > > > > > it.
> > > > > > Is it possible to enter the namespace automatically by the test
> > > engine?
> > > > >
> > > > > We can't assume that is possible todo in all build/test
> environments.
> > > > >
> > > > > Doing things as different user accounts feels pretty dubious for
> the
> > > > > scope of a unit test too - that is really functional or integrati=
on
> > > > > testing.
> > > > >
> > > > > Can we somehow restructure the tests and/or agent code to avoid t=
he
> > > > > changing groups stuff in unit tests.
> > > > >
> > > >
> > > > There are two possible options:
> > > > 1. add #ifdef QGA_BUILD_UNIT_TEST into qmp_guest_ssh_* functions
> > > > 2. check the current uid and skip initgroups if it is zero (my
> initial
> > > > question)
> > >
> > > Surely you mean "if it is non-zero" here, as it is with uid!=3D0 that
> > > the UID changes will fail.
> > >
> >
> > yes. So what sounds better: "ifdef" or "uid!=3D0"?
>
> I'd be inclined to #ifdef so we know it doesn't affect production
> deployments, only tests.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000e033f00658af1734
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Version=C2=A02 with=C2=A0setegid/seteuid logic pushed=
</div><div>Please review and test</div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10=
, 2026 at 12:58=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:be=
rrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Mon, Aug 10, 2026 at 12:33:39PM +0=
300, Kostiantyn Kostiuk wrote:<br>
&gt; On Mon, Aug 10, 2026 at 12:28=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com=
</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Aug 10, 2026 at 11:58:44AM +0300, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrang=
e@redhat.com</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Ko=
stiuk wrote:<br>
&gt; &gt; &gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P.=
 Berrang=C3=A9 &lt;<br>
&gt; &gt; <a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange=
@redhat.com</a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kos=
tiantyn Kostiuk wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Hi Valentino,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Sorry for the long delay.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I have a question for you<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM =
Valentino Paulon &lt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"mailto:valentino.paulon88@gma=
il.com" target=3D"_blank">valentino.paulon88@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; So, you propose to call s=
eteuid/setegid before any I/O<br>
&gt; &gt; &gt; &gt; operation?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Yes, specifically for the SSH =
commands, because they&#39;re<br>
&gt; &gt; unusual<br>
&gt; &gt; &gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; that we&#39;re doing stuff on =
behalf of an unprivileged user.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +1 on the euid/egid direction -- as=
 the reporter that&#39;s the<br>
&gt; &gt; &gt; &gt; outcome I<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; was hoping for. It confines every s=
tep (read, mkdir, create,<br>
&gt; &gt; &gt; &gt; rename,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; chown) to what the target user coul=
d already do himself, which<br>
&gt; &gt; &gt; &gt; removes<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the whole TOCTOU class instead of c=
hasing one instance of it.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; A few implementation details that t=
end to bite with this<br>
&gt; &gt; pattern,<br>
&gt; &gt; &gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; case they save a round-trip:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; - drop the supplementary groups too=
, not just egid:<br>
&gt; &gt; initgroups()<br>
&gt; &gt; &gt; &gt; (or<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; setgroups() with the user&#39;s lis=
t) while still root, otherwise<br>
&gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; agent&#39;s effective access won&#3=
9;t match the user&#39;s in either<br>
&gt; &gt; direction<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Technically, there is no limitation to r=
unning QGA in<br>
&gt; &gt; unprivileged<br>
&gt; &gt; &gt; &gt; mode.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Normally, it is a system daemon, but thi=
s is not mandatory.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; In this case, we can not call initgroups=
 because the caller must<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; have CAP_SETGID.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; We can call initgroups only when QGA run=
s as root. What do you<br>
&gt; &gt; think?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; In any practical sense it is a system daemon =
given the set of<br>
&gt; &gt; commands<br>
&gt; &gt; &gt; &gt; &gt; &gt; it is exposing. Thus, IMHO, deploying as an u=
nprivileged user<br>
&gt; &gt; should<br>
&gt; &gt; &gt; &gt; &gt; &gt; be considered a broken deployment. We could m=
ake that explicit by<br>
&gt; &gt; &gt; &gt; &gt; &gt; refusing to launch.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Makes sense, but we have one more issue with QGA u=
nit tests in this<br>
&gt; &gt; case.<br>
&gt; &gt; &gt; &gt; &gt; They are called by an unprivileged user (build use=
r), and initgroups<br>
&gt; &gt; &gt; &gt; broke<br>
&gt; &gt; &gt; &gt; &gt; it.<br>
&gt; &gt; &gt; &gt; &gt; Is it possible to enter the namespace automaticall=
y by the test<br>
&gt; &gt; engine?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; We can&#39;t assume that is possible todo in all build/=
test environments.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Doing things as different user accounts feels pretty du=
bious for the<br>
&gt; &gt; &gt; &gt; scope of a unit test too - that is really functional or=
 integration<br>
&gt; &gt; &gt; &gt; testing.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Can we somehow restructure the tests and/or agent code =
to avoid the<br>
&gt; &gt; &gt; &gt; changing groups stuff in unit tests.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There are two possible options:<br>
&gt; &gt; &gt; 1. add #ifdef QGA_BUILD_UNIT_TEST into qmp_guest_ssh_* funct=
ions<br>
&gt; &gt; &gt; 2. check the current uid and skip initgroups if it is zero (=
my initial<br>
&gt; &gt; &gt; question)<br>
&gt; &gt;<br>
&gt; &gt; Surely you mean &quot;if it is non-zero&quot; here, as it is with=
 uid!=3D0 that<br>
&gt; &gt; the UID changes will fail.<br>
&gt; &gt;<br>
&gt; <br>
&gt; yes. So what sounds better: &quot;ifdef&quot; or &quot;uid!=3D0&quot;?=
<br>
<br>
I&#39;d be inclined to #ifdef so we know it doesn&#39;t affect production<b=
r>
deployments, only tests.<br>
<br>
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
</blockquote></div>

--000000000000e033f00658af1734--


