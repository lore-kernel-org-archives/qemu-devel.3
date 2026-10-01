Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E50FCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCE0F-0000FX-6x; Thu, 01 Oct 2026 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xCE0C-0000FF-B6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:27:00 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xCE0A-0008IE-DH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:27:00 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-1460bcc512eso3866328c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 03:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790850416; cv=none;
 d=google.com; s=arc-20260327;
 b=hVeEarfvNFzwykfTwuLVffbx1OiFgNRTwI3dPijZVNR8qq8p0Vl93ojs6P7//zjqvB
 yADaz0tQAOY4vKHMMSiGcMGBhZ7jcF1EzMgmXtuuC6Bb50cZKnwIYqMc62hcTru9FQ2K
 F3g6O3E3h1Ptynb7pMI4yU/spYk+v1Jh2OWWoPmXDIoQx4HsEvwl26al5Zd3u217zzHR
 Hckx4pOgCW6SbGPQrPFUSg7oj660tjBfNACurXDbQ2vVC61BlfbYU2rw8ak5IO3ozryl
 xxr9UixVvTPyGutwUoC7G7YYao6wKxsK+oOD11RQMi8pNE1fItRVkLqgG9il7vf0H7+w
 YF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n+jvYNVv1dU9/jErShFzkJ7AN6XGbpMT3IkYXNnOfWE=;
 fh=3XcdnKPPujWCgsoSlfyTIC7mLtr3DNVpLRjg7tPS1Nk=;
 b=dB5AmuCQVlisCAA+tmUIjYy670hEYUnM/pAPQZKFOrFvCVU77YFuFAI4lHDEMZKzXA
 D14km37LaJucQd6CPNBzG0Uj9pf+83eJJBsaYAqSypPLPeV0o6HQ56V+VgJ+FOG9t/nD
 kwMWYBnKKQ/hSCDXtqlLFigq3Vyi1AUrY9C81rXKe+MtXu0P7DrLBOoMHzo2OoqVI9rs
 kFqbKztXxKHQ7bt7JoVROXKAGQC3K5ObWkm0qC/sX6uTqgJrqon4ObsmpBHPWWCunj2P
 Q/1sTV1NRr0Fc0wpGqXdzMCyUUr3jHKSxT7WPrY/sKZozF9dmPTs0joKeo0tSN7siA2s
 VkRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790850416; x=1791455216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+jvYNVv1dU9/jErShFzkJ7AN6XGbpMT3IkYXNnOfWE=;
 b=n8Ylxli5/h8nLZOY5D308fo6+PQDL0X0vTxW1IbBZJdBBQgDVDOwGpD/UcGlW/BHFJ
 rg+j+QFDVYokL1ne55/1QTdWjvbcnljT53noakxku2Yd0wlK3eA8mOkFqqXmyG3B6V7f
 wHRbXMxKsItSQlXrmW7XfX8eR3LXvF0nwz5cn+Y8fpNvs6P9cbSBPfs4KjBYIfruJG76
 FzdviLPKsKxXMKbSNFZypsM+gQfrWgt8rjAbO4I+FbI0zM0llv8HPLi68m5EsbOmpkF6
 QGn8ZMLKS+TdRv6bzTSYXFtH6ou7xQS+hYDqFtb9LoYxx2A7UcN0cpGid58gcRPbGD9H
 WyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850416; x=1791455216;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+jvYNVv1dU9/jErShFzkJ7AN6XGbpMT3IkYXNnOfWE=;
 b=m4FPVYdDZcFKHWrVaTNPrKjFdVbX5BCKBv10l7JvWlnmFKMyq133bUbowpnlUH95kP
 OftaMasRR83TmYW2yYjnVPot0kB/iOsa6FnBIhwZBYLR69YTQYkjBTaAS3WDjUypobxC
 UwijA1nSY//hJdlhUAyi5hEvcmPf4eaB10KeVwnzNLK0vS98KFR+QX0OR77u+q5sSVP6
 pZLKhAOLq5YXqC4qj9NfvVVHtweHEjy9lKAI0JJXC7piAZygL+UdpuDdj672TdFgk1dS
 RKR6bkWJFaL5agGqioIC/10/muvHQqqea3ABeY1hYIGO9T6908P7JXJbVFmxKRbyVqRt
 Z0zA==
X-Gm-Message-State: AFuF++n/QR+aaS5091IkuVzOB/Qgkl3kEnwel8HhOy85pkJ2CR5B1Dnf
 uLOlJM1Q0UBuG3Dns5k2FQlUrRnKJpTGLJUUg+O1Q9FwDdWUQeJGAIur6XAleBDtnDlq5AsSWV7
 RB1i+mz3rsuzGnqZl+WYyUmASgEU7SMw=
X-Gm-Gg: AYBFou1jlon+Xyr3vPZ3gxhllfkZ4tRKyKLHkLWl/zDdLP0K1IQ1igs9Ph7fd4wgLKb
 SnfEKPwyEk+QSJATDDF6DK3KbPnqYN9f5b0Rv6fd5XNnEs3RYMf3+PkPxwykMk9rFs0FqoY5WJC
 Qaf+fLmUt0jz9sjXPF6HkdmD73lrRFQnjuMzXiicrhVLzm+ZT3MlEDxvedc7AedNmi9n0I7sNbn
 qd2qyN1fT0dXaRi0437TFmWcxpVOic3QxIUoxQ9FcXBBU67kK3ZhkM+q2iAFT5OvXz0cr333KFC
 51Lpegs9X11zX25kQG+mYfom0ygaA2LkBqakygZNV8Kg8UJRArJ+O6BmbHNz/N+ywaBNa8u7tKu
 9IHhYoZ8pPZQ=
X-Received: by 2002:a05:701b:2212:b0:14b:992f:c168 with SMTP id
 a92af1059eb24-14d2f7e64f6mr4419661c88.4.1790850416258; Thu, 01 Oct 2026
 03:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260729075743.333920-1-marcandre.lureau@redhat.com>
 <9ecf7231-b4f9-4db8-aded-818fd7a79df5@oss.qualcomm.com>
In-Reply-To: <9ecf7231-b4f9-4db8-aded-818fd7a79df5@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 1 Oct 2026 14:26:42 +0400
X-Gm-Features: AclHuK_LbPsuiIeKXQyOypp307mbE_2plILFjF5S_E-32HTJZoePr7_0VMZisio
Message-ID: <CAJ+F1CK7tGdEDrWMuEp447cAm6JFBGvxM3L25hh02EOiP-AbaA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/dev-smartcard-reader: fix OOB read from pending
 bulk-in ring
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
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

On Wed, Sep 30, 2026 at 8:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2026-07-29 9:57, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
> > active, but the slot is only truly free after ccid_bulk_in_release().  =
A
> > guest can fill all 8 ring slots, partially read one (leaving pos
> > non-zero), then send another command whose response reuses the active
> > slot. The stale pos > new len makes the uint32_t subtraction in
> > ccid_bulk_in_copy_to_guest() wrap, reading past data[].
> >
> > Move the decrement to ccid_bulk_in_release() so the slot stays busy
> > until then. Add an assert(pos <=3D len) before the substraction.
> >
> > In practice, the device advertises bMaxCCIDBusySlots=3D1, so a conformi=
ng
> > host never has more than one command in flight and the ring never fills=
.
> >
> > Fixes: CVE-2026-18204
> > Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
> > Reported-by: Warisjeet Singh <sinxx198@gmail.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/usb/dev-smartcard-reader.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reade=
r.c
> > index 964c142d1066..5f8b95be46b2 100644
> > --- a/hw/usb/dev-smartcard-reader.c
> > +++ b/hw/usb/dev-smartcard-reader.c
> > @@ -580,6 +580,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
> >       assert(s->current_bulk_in !=3D NULL);
> >       s->current_bulk_in->pos =3D 0;
> >       s->current_bulk_in =3D NULL;
> > +    s->bulk_in_pending_num--;
> >   }
> >
> >   static void ccid_bulk_in_get(USBCCIDState *s)
> > @@ -587,8 +588,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
> >       if (s->current_bulk_in !=3D NULL || s->bulk_in_pending_num =3D=3D=
 0) {
> >           return;
> >       }
> > -    assert(s->bulk_in_pending_num > 0);
> > -    s->bulk_in_pending_num--;
> >       s->current_bulk_in =3D
> >           &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PE=
NDING_NUM];
> >   }
> > @@ -1078,6 +1077,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDSta=
te *s, USBPacket *p,
> >
> >       ccid_bulk_in_get(s);
> >       if (s->current_bulk_in !=3D NULL) {
> > +        assert(s->current_bulk_in->pos <=3D s->current_bulk_in->len);
> >           len =3D MIN(s->current_bulk_in->len - s->current_bulk_in->pos=
,
> >                     p->iov.size);
> >           if (len) {
>
> This is the runtime path, but we need also to clear the reset (and card
> removal) one:
>
>     static void ccid_bulk_in_clear(USBCCIDState *s)
>     {
>    +    if (s->current_bulk_in !=3D NULL) {
>    +        s->current_bulk_in->pos =3D 0;
>    +        s->current_bulk_in =3D NULL;
>    +    }
>         s->bulk_in_pending_start =3D 0;
>         s->bulk_in_pending_end =3D 0;
>         s->bulk_in_pending_num =3D 0;
>     }
>
> '''
> Resetting or removing the card must also discard the active slot so
> that its stale position and pointer cannot be reused.
> '''
>
> With that amended:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

corrected, thanks

