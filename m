Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1ADC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtiF0-0006H9-0S; Tue, 11 Aug 2026 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wtiEy-0006Gn-Cv
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:53:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wtiEw-00029D-Fz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:53:44 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so3056246a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786438421; cv=none;
 d=google.com; s=arc-20260327;
 b=LXYXE0/8DZ0TV+XWcCuFmlPnMepCKNAE2NEULIPqvfglyXBw20JOhyeoV5mqeptwBE
 Pyng3PFkU0LCafHPOKKDzT5oGbU0xhQRLQjtJqlVN37o9kr65tobcQpq3MI67x6sGRLa
 psFIk8GB1fND9Pks55qggifhIEcxH+lOt82ZKHf9bZ3+RCB8NYjfe/3yfwmmy3804TRZ
 fqRLWyHoORlHJk5JCRc1k953kIkfpf4rsHDf/jQONZTXPIl/bT4FEZJ5FUzuC5ReP9QH
 BMM33LP/nYm8Xa2sHmr5Lng2RJcVKUS89avDBVJ3sFyx5H0DPcRAl1tPsWqNbhv70Uz/
 iQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KntnWJht4JWG8q/8KPwv0R938uhXWrIG6b5ejF9Y9mk=;
 fh=MJlun3wUSRZ/tNORE8+1B5jg+j+FWhlvz5w8I+IrLxc=;
 b=oi6ptZZVIp9fums4aXFlHbJ5pDMcDTwnm5sMAiWpXP+NpUvKiotpsHtlaVjXVF5Jb6
 FzIJUXvxFHVO28f0mahLTIhQfOQWlf4ZFl9jj/q/GUPlmduXQYbFGwspPI/HFsF3gAsg
 gQRkUeII0uwCMPGrDYkBG6GqjmKpWOy65f8pSFZ0ExP8zQi/LfaYRqMJCiEJTCvO7qIK
 tnF788LQAONhKPztJlhqouu7obTWnTszaYzOj7mqRh05pjLQrJrq4+tnNCoeW52soRSY
 tW81DgmFI1EHu3pjpebn6ly5PsFb93Hfr8P4QTsANX2/+YktzNYMaPbtacnWuJU3hToo
 3ejQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1786438421; x=1787043221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KntnWJht4JWG8q/8KPwv0R938uhXWrIG6b5ejF9Y9mk=;
 b=e7AIUayAUnjhirqD8uzHxnuevpPQMWIhm0J54ywlsu6AWWnip2Tu7BXajaHAqJ93VG
 RcK0Z1NgURa9NH0YEzdx3++TTtoL0AEugQzE46XB1KIEJVwUPTKhybHnlafSK3y8O9le
 Y+4HLaVPZIe7BsSgc5kQQLrxm5ADTfOCKsyCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438421; x=1787043221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KntnWJht4JWG8q/8KPwv0R938uhXWrIG6b5ejF9Y9mk=;
 b=kX7GNCCjhhT4UBkXjh7VL27II6q9D61p7R4Votnbe5Gm0XSrRGlNH7bYEE/MWnjKFG
 qoQLiV3O6wIvNmTBjqUZ625JhmD5FfV67dHqr4VA9ElLanu9MUZGmagukQjO0aQkhwZS
 7zLRmZXRTHZZkStWSeNBw/2Co0d+nEMy9/GSvozGqOZEDK8lRG6e1cfY13xImVVzK5mw
 lED3P9WR/KuZ8j8N9HlMsxlI/FBvHqOceGBkXHCyKKsQkmNOHkDEUNM/0njKdQGlQGkZ
 0ZlBqUri53w+3d7dGvHnc12rwn0/eaHa/xd3AlAlDSuX78UN7SFJrzYFJI0hPOri4IC5
 N9ug==
X-Gm-Message-State: AOJu0YzhOd0gmUoDEPvsGYIdmLkp3O8dVWx35SLo8h8XGizTdSQLHQA1
 Us6qBz+BGFznK47IUXBFvwu9CCwMnsjq6eVGdsdY1DV0lmSiK9SiipfZFjBzLIr7hGNhNhYAUAY
 I3gX91yEhFSxNDVrbn6tmXDAwLZnY8f1wXybxF4z7Aw==
X-Gm-Gg: AR+sD13g70WX34JxP5uUJyIRrCbRZbR5zwWFhlCz+0aT4jlyuxfyiPK6tq8QwSESk77
 Uaz5qodUsWZVH+3aZzsa9I8F3NtI84Ff4oBr1IsZ4OxLlb73koxnCmxVrea8iJyOAVxF3LsorQy
 i0wvtNnl+IfbSjK3TMZgHIUlgQu2P+QmzAXgJ2/eLU/r3/5k0OfP0mvH1AHkI8IJHlwqrRpCiUy
 w+oL8+tvZRDyVUeRJdkD8YP6zvMqrsrb71OKiRVr8XkInO50sdbmsAf2hAeIH9aUwxqapFL9eLZ
 XHqQe4HXfHrOMT5cYYdjUUe4iIPRf2kiiRrq56hkEks2PXmDZatirwiSehpWoHm90Y7afaUtWmc
 adO3f0o8ldSI=
X-Received: by 2002:a17:906:f583:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c20e608810cmr75748266b.8.1786438420382; Tue, 11 Aug 2026
 01:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260811081401.51771-1-alexander@mihalicyn.com>
 <33a61f97-d058-466c-9793-98e2618790ba@oss.qualcomm.com>
In-Reply-To: <33a61f97-d058-466c-9793-98e2618790ba@oss.qualcomm.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 11 Aug 2026 10:53:28 +0200
X-Gm-Features: AUfX_myjHJrHUTybz8dXpWu44oX0xd9tthWOxjy7dmUdCYZpJpY4rs-m2Q505l4
Message-ID: <CAJqdLroHhv05B_4105eX1GsFGOdD-qfP9ijF36WWg9keuuYnUg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/pl011: support backend hotswap
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-arm@nongnu.org, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am Di., 11. Aug. 2026 um 10:30 Uhr schrieb Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com>:
>
> Hi Alexander,
>
> On 11/8/26 10:14, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Currently, when Incus issues "chardev-change" QMP command to change
> > chardev backend from ringbuf to socket it receives an error (with aarch=
64 VM):
> > "Chardev user does not support chardev hotswap" [1], [2]
> >
> > Let's fix this by properly implementing BackendChangeHandler for pl011.
> >
> > Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, becau=
se
> > if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is tr=
ue),
> > then after change we need to send break to a new backend too.
> >
> > Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-con=
sole-on-arm-architecture/23096/3 [1]
> > Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > ---
> > v2:
> >       - fixed a typo in commit author name
> >         [ I did `git format-patch` and copied this patch from my Raspbe=
rry PI
> >           dev/test machine and it turns out that I have a stupid typo i=
n my
> >           `git config get user.name` on that machine. ]
> >       - added RWB tag from Alex Benn=C3=A9e
> >       - adjusted a commit message
> > ---
> >   hw/char/pl011.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index cb12c3e224f..3622248ec0c 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
> >       s->id =3D pl011_id_arm;
> >   }
> >
> > +static int pl011_be_change(void *opaque)
> > +{
> > +    PL011State *s =3D opaque;
> > +    int break_enable =3D s->lcr & LCR_BRK;
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive=
,
> > +                             pl011_event, pl011_be_change, s, NULL, tr=
ue);
> > +
> > +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> > +                      &break_enable);
>

Dear Philippe,

thank you for the review!

> Could we factor the common code used in pl011_write() in a common
> helper?

yep, I think we can factor out CHR_IOCTL_SERIAL_SET_BREAK call
together with break_enable variable.

Please, can you look into our thread with Alex Benn=C3=A9e:
https://lore.kernel.org/qemu-devel/87h5l22faq.fsf@draig.linaro.org/

It would be great to have your opinion there.

Kind regards,
Alex

>
> > +
> > +    return 0;
> > +}
> > +
> >   static void pl011_realize(DeviceState *dev, Error **errp)
> >   {
> >       PL011State *s =3D PL011(dev);
> >
> >       qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receiv=
e,
> > -                             pl011_event, NULL, s, NULL, true);
> > +                             pl011_event, pl011_be_change, s, NULL, tr=
ue);
> >   }
> >
> >   static void pl011_reset(DeviceState *dev)
>

