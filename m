Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92650FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfVW-0003ma-96; Tue, 28 Apr 2026 06:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHfVV-0003lo-0H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:17:33 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHfVT-0000v9-95
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:17:32 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so2968370eec.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777371449; cv=none;
 d=google.com; s=arc-20240605;
 b=ChdzLu0Bz4QBXxQhSHuaPyc7y9OZmoPUIRMN2A6edDa+qpE2HJVtqZ//4MZmyT4/ym
 5fYPNwrXQ/idJu/YQQ9qs2NUpn+i8E6x1iy7Yj4JuQU1r1b/fkUa6gPiHANireV8AYkd
 3o6SMczB2RrIFHBRRcHstcoPAp+Nmy1xyBR8syXsCPmQSc5hoTXMQJ9rNMmrpDxMmn9n
 27nHeDc8DWGekRBnonnP6PWPPvijYKr2Ay4ur2g+8dzqdnXijWdaCXIn/ek2btN5yEPW
 +UuKcdX0BrMk1aBTPCZMekcCbwsbz9eZTvkPZ6pFW9/De9Zz6vdwWidA+do2qEItxmbu
 fkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Mi1yJ503u+Doo3QDs87pihdsS2ollrbbDsZdS44yPo=;
 fh=BCuY/beMqJdGc2e0khfFuFCQpH3R3sHADBiZ/molWiI=;
 b=BTxNozscZ72vsbcH1ZmUiD1XCm+2ufKddPEX/KS+OQDxxzr8/sTIGHL88IdEASAhTi
 XMLd/+HJtA/XeaIuWk23SOp9WhJLGHHeSoaNc3VSFo+eMYgV/nqeuxkvcvEdDRR2stiB
 c4jfzTlrH7o/rFBoFE+KyA93NzZqdDcZeef9f/vnrZv1UmiiJorJxYbLzFDgx6X0eAu+
 oeb/yIzFT07tshwaavhzx6bae01q0KFQ99UiH3sUbwxirUB53QGRIrCF3S/QbqRWFOSW
 6e8onveBSiIa17bZiAwdY0xuPMhzpubG64ifyqI2ujyRTwhe87nwhdydei5jIV9l7mab
 sQlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777371449; x=1777976249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Mi1yJ503u+Doo3QDs87pihdsS2ollrbbDsZdS44yPo=;
 b=S/5JoyvCVxMRPWe5aB16JKSte++s6SSB/v07RT1bzI8BKNo0ICYbZxh/0EdCbqUJdO
 z7jZcN7KUdEEDKf61L/57y6MDaLWM0E2e9/2ouoI/BA6mqDt7lIzB+oew8zzzcwZMIEl
 KWI+EwANmiakiicr6xhhAArPFrDNG1TgX1nSHrVY6rVeVjsRSBcr9He8285PEISUtIhU
 q6VCOPsye6/mLTh8Djbbmx5CWt8IvsPbYPMXaFvPBeew28MnaJaJFAHlkhBUDGLTsLJQ
 JVf4+8A7EpR/UqETkfoKCAYcen6FYVBINKZNjIVjomrgP+VxSWvRS3BQoRX26+jkCQA8
 f1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777371449; x=1777976249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Mi1yJ503u+Doo3QDs87pihdsS2ollrbbDsZdS44yPo=;
 b=kmaQRbAC2EVAjWCBP2Nfw3NWstbG9/GJHdYq/6/TcfdQo0l26Y++OR66etZCyIQRlZ
 zgGcRGmVVJEWzZrhrdgCkSAzb2/Uz/pg+Z4r8XDXAxeZeZt02cBSKpKl37LTyoVRsp15
 PX9zkO3YK4yJ4xwMB6K4cefwfc5fzI9ooi6Kxlgs+3JyhVy1nmCaMug6DvsQ6fEyD6q2
 LoBF9FuoY+a8tiIuI6lkYMtQr7TNNDHZuv4c7wlj+8qsvNexMQCfIbilM94VxEHGGmFW
 GhL1uA9FgR0gQWQZ5LW7RtQ2UfeL9dhaTZTWGIwCj5TCt6eawlCzIX3Khn14WURu7rZK
 ILFw==
X-Gm-Message-State: AOJu0YxsneXN4VLjl+rwMnXj/b7Haq5/xixh29n6VQqOxkUKRd4oOpsQ
 HbXyvCThzkikoWiLur2c0cl43KTIIrAPgAXfsKK631ejo2lHLfHTAFct+ganDrhDLrrt+/m/9Sv
 i52zufGZgGojGJjoLhFaC4BKAcuLGLm4=
X-Gm-Gg: AeBDiesC3TRH8UMYRmiC0S6XNZUKYZONnrAl+biQcq9bAqSp54AxNHtVvGa7EnSJQow
 qscSlSKAm62a6ZUE/pP77GgpY2vPBrO0wpJQWzDcYfgsEvtclpKiqPX4TlkVmmPjYewHPqNYcRr
 ivIRMOyoUjT58kp7fhFco8sa2sFsVAYt18n2LGMbEcvHIB9q+7/u/yr8JU8ft2LJEYDYw417YIP
 xw77N2UFq4Sjyl5QtkECDfQasNERtiWRV2HhaGKrz44kPrfWkOSkwmCuJjhx5oTnHaZkefWhNO4
 9fRXyMSAi5+1NU1Fs1NFgxODs0gsT1dUCaYCuOkjuGVzRCu0R0xetHyG+LqZBA==
X-Received: by 2002:a05:7300:724e:b0:2c9:1943:e7ff with SMTP id
 5a478bee46e88-2ed09fd8f72mr1259921eec.10.1777371449172; Tue, 28 Apr 2026
 03:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-9-c413f3605311@redhat.com>
 <ce69a79e-5013-4a01-a333-cf979be17b3f@oracle.com>
In-Reply-To: <ce69a79e-5013-4a01-a333-cf979be17b3f@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Apr 2026 14:17:17 +0400
X-Gm-Features: AVHnY4IVlViS2gdkhfWI73L2OXgq_sDxGMrBSpLtRsgpxArKMyzwYAnV7JU4GXQ
Message-ID: <CAJ+F1CJ6z7uyjgr7yW-f5gLcPmLDufpXoa0Qzwv+0p__nhoyDA@mail.gmail.com>
Subject: Re: [PATCH 09/41] RFC hw/remote: guard listener unregister in finalize
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Apr 28, 2026 at 12:02=E2=80=AFAM Jagannathan Raman <jag.raman@oracl=
e.com> wrote:
>
>
> On 4/27/26 3:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Guard the unregister by checking whether the listener callback was
> > set, which only happens right before registration.
> >
> > This is probably better addressed by "[PATCH] qdev: test if DeviceListe=
ner
> > is in use". Just adding this patch for completeness.
> >
> > Cc: jag.raman@oracle.com
> > Fixes: c7d80c7c1d9 ("multi-process: Associate fd of a PCIDevice with it=
s object")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/remote/remote-obj.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
> > index 86192dc8dad..4e74ae76158 100644
> > --- a/hw/remote/remote-obj.c
> > +++ b/hw/remote/remote-obj.c
> > @@ -154,7 +154,9 @@ static void remote_object_finalize(Object *obj)
> >       RemoteObjectClass *k =3D REMOTE_OBJECT_GET_CLASS(obj);
> >       RemoteObject *o =3D REMOTE_OBJECT(obj);
> >
> > -    device_listener_unregister(&o->listener);
> > +    if (o->listener.unrealize) {
> > +        device_listener_unregister(&o->listener);
> > +    }
> >
> >       if (o->ioc) {
> >           qio_channel_shutdown(o->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL)=
;
> >
> Hi Marc-Andre,
>
> I submitted a patch a short while back concerning this:
> https://patchew.org/QEMU/20260427162700.89750-1-jag.raman@oracle.com/
>
> Do you want to stick to your patch, or want me to proceed with mine
> (while addressing feedback from Peter Maydell)? I'm OK with either approa=
ch.

I'd be happy to review/take your patch. Then I might include it in
future iterations of this series if you don't mind.
You may consider adding the Fixes: trailer.

