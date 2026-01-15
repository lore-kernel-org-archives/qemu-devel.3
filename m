Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A4D3CCA3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 02:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgD9k-0007Ql-8g; Wed, 14 Jan 2026 21:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgD9j-0007LZ-6F
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:32:15 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgD9g-0000wI-P0
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:32:14 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so712020a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 18:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768444329; x=1769049129; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko/6/rdcY70/txcGV3jeMgyd4oDblNbkCCLFNAt4WT8=;
 b=e710ntrnMNO59qoklpVHifQY6aOxRZ+7KyodAgIh8stTp+7mZnVowQV7RVmJ639a1Z
 Ht5Incjtr993C0+qh/tUGr4DaPRTLM5tJkTU4Zrppo+gRF73swOdb+54TmVOSXX4rrb6
 XwMLWgSC8D3xd0NByhsN4CcGQeVJjBQwqhyE5L2wjSwaq9jcTt3AzfYTs2YrLi2VpUqI
 R4/XrJWV3j7lotfVW7b2GY9U8BvpjsxYogcjYoCnLtaxV2WtjtthbR0TWX5lLd5xIk41
 OrXAQ8dwM0Z35SxyWI+1B53/eO8v4rmw0TmPuZjCmUILyq2iO+VfdxnhCspOcSg9S6Zp
 O7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768444329; x=1769049129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ko/6/rdcY70/txcGV3jeMgyd4oDblNbkCCLFNAt4WT8=;
 b=w61kee3RdZ1YSGFi9A5ejTlUisurN+QNjwgmDlzz7bSR9UcPjxRcJJq5+nllZKl8+x
 SBxYn9sAKGPKoDJwoHla14hvGFvwUyAsslF/GqVvF1JD2HyW2qkJE4sRj9lF4XhvfJ+B
 eFrVy7PpxX9Brjqj7NqRMZnrIYYDOXHjjzdNy7/dXx7ex6kAbGBQkzxkbUvvrVQGynmh
 Jbi18Uh4eo4Gl8NYIKQ0jK1SVpwPabOCeM0Zq9SNbWASh0DPIkcPCETeJdfWKC6NSPiv
 v92GnwO9hTJy5ofptFedwEWEdZgkk/PyuPWr7qZ3V55g44gg01NCFTPRX6t8O8mtCnbI
 KiVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjL/fOZmOKhhuDNo0gus8Cz4e9FudDPUwjiAsdtp0mID/zO0y5nIVQzuOmL0WbcQ+ET/XSIEiCgdfp@nongnu.org
X-Gm-Message-State: AOJu0YxzNjv9JB78iyzgRVqqZKJizYgAXoHUqHYCzAXr3hYP50ptifKi
 hGPScF5Bvox0AuYUtWQtE/IVpHHMFn4Oe0sji/Hn8qJ/Dv15vD0wM/csp2zCri2i3DmBeEJEHEZ
 Jp3c+Cxa7VmjdaDlQswBGH+vLfgsbs48=
X-Gm-Gg: AY/fxX4GTpMKivMNBhVXe4kAkR361mjsJ+K0NNLNo9Gb8MnV8d2DKaSE7Q0/1lgCFhA
 O7oCm3k3x5rGCJREYb3W8m8HNImOOMOCUhD+DO2cNLyZiRG0jQ5ciuBnhk4byx9ZXwBCDrR/Nu0
 qKFoLqKsKUr3Bn3hQTlvLvQ4HBX+/x6nMS89Fp4qy5OzTFCMrKuKAp5QjxQshrVDOdAVkppH2HF
 vPsSJHU62vkHbOnDxwmZKryTQrZBMkGpyB98Sz/3pbIffo3roy/LywW7eh2HrtjuQtZPwk=
X-Received: by 2002:a17:907:94c4:b0:b87:173f:630 with SMTP id
 a640c23a62f3a-b87677a827amr348080066b.40.1768444328532; Wed, 14 Jan 2026
 18:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
 <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
 <CACGkMEs08wX5yBWcs05wiUmReb7boxTNy4+Br0dDUi=npfo1Cg@mail.gmail.com>
 <CAK3tnv+j_7s5JhPb32C9FK565B6M2V9gRsGkg6x_J0YesEmgFQ@mail.gmail.com>
 <CACGkMEvuMW-KSOrFi-28pSQP8WNzmgk4Dnnd4KLhd7_DYih35Q@mail.gmail.com>
In-Reply-To: <CACGkMEvuMW-KSOrFi-28pSQP8WNzmgk4Dnnd4KLhd7_DYih35Q@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 15 Jan 2026 10:31:31 +0800
X-Gm-Features: AZwV_QgUDx4LQ2UqeUbGr-ZH89pvHuO35gjLAY0esUlhg5yxtyHHVxxotTwFC5k
Message-ID: <CAK3tnvLiAvfFXatS7MvwXe0=Ak=4Un6o-yPY9je_BA+FRY5dJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 14, 2026 at 3:35=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Jan 13, 2026 at 5:22=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > On Tue, Jan 13, 2026 at 2:43=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Jan 6, 2026 at 4:09=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Jan 5, 2026 at 9:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.=
com> wrote:
> > > > >
> > > > > On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > Currently, filter-redirector does not implement the status_chan=
ged
> > > > > > callback, which means the 'status' property cannot be used to
> > > > > > dynamically enable/disable the filter at runtime. When status i=
s
> > > > > > set to 'off' via QMP/HMP, the filter still receives data from t=
he
> > > > > > indev chardev because the chardev handlers remain registered.
> > > > > >
> > > > > > This patch adds proper support for the 'status' property:
> > > > > >
> > > > > > 1. Implement filter_redirector_status_changed() callback:
> > > > > >    - When status changes to 'off': remove chardev read handlers
> > > > > >    - When status changes to 'on': re-register chardev handlers
> > > > > >      (only if chardev is already open)
> > > > > >
> > > > > > 2. Update filter_redirector_setup() to respect initial status:
> > > > > >    - If filter is created with status=3Doff, do not register ha=
ndlers
> > > > > >    - This allows creating disabled filters via command line or =
QMP
> > > > > >
> > > > > > 3. Handle chardev OPENED/CLOSED events to re-arm handlers on re=
connect:
> > > > > >    - Keep the chr_event callback installed on CLOSE so a later =
OPENED
> > > > > >      can re-register the read handlers when nf->on
> > > > > >    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, s=
ync_state=3Dfalse)
> > > > > >      instead of qemu_chr_fe_set_handlers() because the latter f=
orces
> > > > > >      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an alr=
eady-open
> > > > > >      backend. Doing that from inside the chr_event callback wou=
ld cause
> > > > > >      recursive/re-entrant OPENED handling.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++----=
-
> > > > > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > > > > > index 8e01e98f40..aa2ab452fd 100644
> > > > > > --- a/net/filter-mirror.c
> > > > > > +++ b/net/filter-mirror.c
> > > > > > @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opa=
que, QEMUChrEvent event)
> > > > > >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > > > >
> > > > > >      switch (event) {
> > > > > > +    case CHR_EVENT_OPENED:
> > > > > > +        if (nf->on) {
> > > > > > +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirect=
or_chr_can_read,
> > > > > > +                                          redirector_chr_read,=
 redirector_chr_event,
> > > > > > +                                          NULL, nf, NULL, fals=
e, false);
> > > > > > +        }
> > > > > > +        break;
> > > > > >      case CHR_EVENT_CLOSED:
> > > > > > -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > > > > > -                                 NULL, NULL, NULL, true);
> > > > > > +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, =
redirector_chr_event,
> > > > > > +                                      NULL, nf, NULL, false, f=
alse);
> > > > > >          break;
> > > > > >      default:
> > > > > >          break;
> > > > > > @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFil=
terState *nf, Error **errp)
> > > > > >              return;
> > > > > >          }
> > > > > >
> > > > > > -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_ca=
n_read,
> > > > > > -                                 redirector_chr_read, redirect=
or_chr_event,
> > > > > > -                                 NULL, nf, NULL, true);
> > > > > > +        if (nf->on) {
> > > > > > +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_ch=
r_can_read,
> > > > > > +                                     redirector_chr_read, redi=
rector_chr_event,
> > > > > > +                                     NULL, nf, NULL, true);
> > > > > > +        }
> > > > > >      }
> > > > > >
> > > > > >      if (s->outdev) {
> > > > > > @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFil=
terState *nf, Error **errp)
> > > > > >      }
> > > > > >  }
> > > > > >
> > > > > > +static void filter_redirector_status_changed(NetFilterState *n=
f, Error **errp)
> > > > > > +{
> > > > > > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > > > > +
> > > > > > +    if (!s->indev) {
> > > > >
> > > > > It's better to add a error here, for example:
> > > > >
> > > > >         error_setg(errp,  "filter_redirector_status_changed faile=
d for
> > > > > the s->indev cleared" );
> > > >
> > > > Will do.
> > > >
> > >
> > > I think it's probably wrong to return an error here as we may only us=
e
> > > outdev but not indev, in this case status_changed doesn't need to do
> > > anything.
> >
> > This confuses me. The filter_redirector_status_changed code focus on
> > how to read the the indev, it looks not affect the outdev.
> > If we just return without any error, the user is unsure whether the att=
empt
> > was successful.
> >
>
> Consider the case where there's only outdev, in this case we don't
> need to do anything when status is changed:
>
> 1) we don't poll outdev
> 2) net core will bypass the redirector if the status is off.
>
> I meant basically we don't need to do anything in this case and it's
> not an error.
>

Okay, I understand now.

Thanks
Chen

> Thanks
>

