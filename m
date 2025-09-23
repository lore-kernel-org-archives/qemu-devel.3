Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B46ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v191D-0006Wt-KU; Tue, 23 Sep 2025 15:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v191C-0006WP-Oa
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:49:42 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v191B-0002Ey-4J
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:49:42 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-ea63e86b79aso4566596276.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758656980; x=1759261780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mipdv18VfFuC/432BNpDUrAwkE9so7YadlxCqijScAg=;
 b=OEea1NvFoK72idk0+1GgTNFfo/SorIYbZ/24+Up5DidHnztID43kU93qG0rPcEfIRZ
 bgqOnIQQQ/vlast4S3GuGPDE75Yrkh4YWiay9lRN2A2W3Yu7Y1BEjvM+Emteo8qs9w5k
 JQuJneOE1HwHwjlgh3ycyXJI7OpIhPzTu5V4Sogz0ykV8YnQoKdf5u1cylANhx8ljPsr
 oz5ErwMV/MlUjUZB20HFsD6mD2AWs6lRfvzo0ZbKtsWhQep8TZJ35WYCVBVyfbHtY7WN
 zSajQz+28tbGEDnuOF30oZCrkK0i0b1IklONzRzpzuVCTvitt0jwvL+2QsfJ5vNBJLv5
 MZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758656980; x=1759261780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mipdv18VfFuC/432BNpDUrAwkE9so7YadlxCqijScAg=;
 b=NMbavidCNuqSO0MGSm5yMDR0xioUqC8z1FVE0vT3XvjHSbiopsAPwl1D2u93WnPY3Y
 hDnr3K+1Gv/B/2VEXe1zVsdx799FDqs/Av0LM22q5VwgeJxH3A23wQaTnPZpXUvILGL2
 M+rwPc0NQk/526KZKqQumedg8z3SiBfafQwx2eYD9dahek/YATEoyGd/s8tBTSjwJ3N+
 k2T004HzxEuDfAzuHR8anvOSrECMa1+hiOpoZftw8aBWNq9NoORgPj7h169YQr3SeF99
 ADAFAQ9RgxUeHlvlqgYF9Hubk7p8ZdBnDQ4qyRi15JWcBeOcTbC3slD+0hqoUXmIfJIF
 xHHw==
X-Gm-Message-State: AOJu0Yy6JnxEib1kN1LhIdZQ1JaxrOXXzPgHuam/8V4ULT+aO49luGSn
 GL07gmfSqeLkg9pcwTHcreYyvTUreSiszApcN4NipRqo9I43BQVVm8pgDRJ/lJA1ymFjV4glAKE
 Orb3Iaq8vUTW61oYTnnnDU9NPFH6xhPg=
X-Gm-Gg: ASbGncuVyOg51IhmK29ou1/m0N47JC/itw85rIrvr3NTAfEGCVsBvdvg/zKrq/utHZM
 fyZGd38FLoxAPE40pcsQc5IF5rRfxTY19NufAQE6B5E880OONT2bonyvECS5sA8yvgVxuP0C/g1
 CEAZy2ZHE5ocbJTNWbhoE8FVHFAXSMz1srBMAh1iBVx/+3GEai+kkkILf9CR2DnQglLMoY0HVcw
 Kre0K2zgbKeKY9b4+gOgYIDowvqvO0/FovV49k=
X-Google-Smtp-Source: AGHT+IHIiejlUvpdy08I1Qmf2lHFdjaGyC15vCQqyzPscpLUbJdNBO04VoBkFjzJnJHI6KZ+rffJDU6QqrlFNExkEJ0=
X-Received: by 2002:a05:690c:4986:b0:721:10a3:6584 with SMTP id
 00721157ae682-75893dd5067mr32041817b3.11.1758656979527; Tue, 23 Sep 2025
 12:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com>
 <aNKFwDuH6jNglWUO@redhat.com>
In-Reply-To: <aNKFwDuH6jNglWUO@redhat.com>
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Tue, 23 Sep 2025 22:49:03 +0300
X-Gm-Features: AS18NWAaZRUhO0qptpDD06Y-F11CL9FWqbLjSGEiktFKe7jvDz9TEjm86duSOpw
Message-ID: <CAP4rq2BigKd6bbL=Q+rHhpT2mfvWQtwK18GsuEqk741wTfVWjA@mail.gmail.com>
Subject: Re: [PATCH] tap-win32: fix multiple tap support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=galush.horowitz@gmail.com; helo=mail-yb1-xb36.google.com
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

Hey Daniel, thanks for the review!

On Tue, 23 Sept 2025 at 14:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Sat, Sep 20, 2025 at 03:01:39PM +0300, Gal Horowitz wrote:
> > Currently when more than one tap is created on Windows, QEMU immediatel=
y
> > crashes with a null-deref since the code incorrectly uses a static glob=
al
> > for the tap state.
> >
> > Instead, this patch allocates a structure for each tap at startup.
> >
> > Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> > ---
> >  net/tap-win32.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/tap-win32.c b/net/tap-win32.c
> > index 38baf90e0b3f121f74eb32f1bff779c84ce03114..217a43cc2f5effdd92e1bf4=
9466fe8d2cd0490e6 100644
> > --- a/net/tap-win32.c
> > +++ b/net/tap-win32.c
> > @@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
> >      tun_buffer_t* output_queue_back;
> >  } tap_win32_overlapped_t;
> >
> > -static tap_win32_overlapped_t tap_overlapped;
> > -
> >  static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t*=
 const overlapped)
> >  {
> >      tun_buffer_t* buffer =3D NULL;
> > @@ -605,6 +603,7 @@ static int tap_win32_open(tap_win32_overlapped_t **=
phandle,
> >      } version;
> >      DWORD version_len;
> >      DWORD idThread;
> > +    tap_win32_overlapped_t *tap_overlapped =3D NULL;
> >
> >      if (preferred_name !=3D NULL) {
> >          snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_nam=
e);
> > @@ -645,12 +644,14 @@ static int tap_win32_open(tap_win32_overlapped_t =
**phandle,
> >          return -1;
> >      }
> >
> > -    tap_win32_overlapped_init(&tap_overlapped, handle);
> > +    tap_overlapped =3D g_new0(tap_win32_overlapped_t, 1);
> > +
> > +    tap_win32_overlapped_init(tap_overlapped, handle);
>
> I'd suggest chaing tap_win32_overlapped_init to be
> tap_win32_overlapped_new. Have it be responsible
> for the g_new0 call and returning the allocate struct
> instead of passing it in as a param.

Will do.

>
> >
> > -    *phandle =3D &tap_overlapped;
> > +    *phandle =3D tap_overlapped;
>
> eg so this becomes
>
>   *phandle =3D tap_win32_overlapped_new(handle);
>
> >
> >      CreateThread(NULL, 0, tap_win32_thread_entry,
> > -                 (LPVOID)&tap_overlapped, 0, &idThread);
> > +                 (LPVOID)tap_overlapped, 0, &idThread);
> >      return 0;
> >  }
> >
> > @@ -670,6 +671,9 @@ static void tap_cleanup(NetClientState *nc)
> >      /* FIXME: need to kill thread and close file handle:
> >         tap_win32_close(s);
> >      */
> > +
> > +   g_free(s->handle);
> > +   s->handle =3D NULL;
>
> The tap_overlapped_t struct contains many HANDLE fields. If we just
> free the struct, then those handles are all leaked. There are also
> some allocated pointers. We'd hope they would all be released already
> but who knows ?
>
> This is a pre-existing problem as the current code did not attempt
> to free anything, but with your changes the leak stands out more.
>
> At the same time though, the FIXME comment points out a risk here.
>
> The thread is still running and yet we're freeing the 's->handle'
> that the thread has access to. So if we don't stop the thread, we
> are at risk of a use-after-free.
>

I'll add a best-effort to clean up handles and such. I'll also
terminate the thread before freeing.

With Regards,
Gal

