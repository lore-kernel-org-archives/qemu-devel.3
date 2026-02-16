Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AC9E7BDBD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryoe-0003SQ-UV; Mon, 16 Feb 2026 08:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vryob-0003Ry-LX
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vryoY-0002Hy-7I
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771249141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wx8k2uu6ECWVGd/wabbWISL/AeSrmrXDqD0XagjQR1Y=;
 b=B1Ltk8s44zb3SVJJDJVyphwdUQRrVZ1KZ9EpDTVaep7DcdcADj3OWbOsqzMgIPWIKf5dVX
 hhna1MEhIQEcMOyxv8JprWKa/bsIw1OmaHaOuz451FJPK/LjgqM9BOcWCDzq006BsibnrX
 8Vh/eSFzIxzHXWhdJU7rGmqBCugfGho=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-KrQBvgy8NOyAFQw7h3Lj9A-1; Mon, 16 Feb 2026 08:38:57 -0500
X-MC-Unique: KrQBvgy8NOyAFQw7h3Lj9A-1
X-Mimecast-MFC-AGG-ID: KrQBvgy8NOyAFQw7h3Lj9A_1771249137
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-353c9d644b0so2295402a91.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771249137; cv=none;
 d=google.com; s=arc-20240605;
 b=aeyjmKBl0D7ZKf7ve0XDG0nAGQ1tsiriygsoruK/NbaSd1kipS4wLwus/NWJzvLUIc
 Ffcb5fc3o0DPmtUBEZkwS+GX9DRlB3xpBZtpflHwypQNHFbK4c+H3TURQm8q70vx3iqa
 MSCW6IQWd5Z2VPe1/hcH8dtMawuyPfVvXneJvysg/Utzi/sJWiQk+CSGb1EELrahOlQK
 GDsozvjDgn5GMHV9F3uvDb2PPYwTElz0hv4GNCLmHWG1lVnqF+wYPBDVvDIAiY8unmKl
 gzZYMrs5js5t3GGIMJ1deIvzAjMJptwkbkSmzU1AOhDRVDtCXQChGOFhAbV9sQqYsxMh
 dZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wx8k2uu6ECWVGd/wabbWISL/AeSrmrXDqD0XagjQR1Y=;
 fh=HtRR2RGq2iMr0HShhylZlqanZL00qdFByXw+fOjYKXw=;
 b=OFShnM49d7eldnixnukZd+ha2v3bqCL53YglKmIXRK0EAqja4mETSvG1SQm5p4pN+Z
 aeNtX0FF69F06T5l8Bwxs+yEpFnupcnihYLsVxTMjGmJMrX0ImT2OsiMgkLuos8yS4GU
 POk3t/wAzfoNRBBwpdMyIH040UzUrjO14cOOs5qzpO6Nng+jy7Rs39qINcdhx0TZPgsS
 hpMEkjwAhrD/huimmqGtocXQ9da4PhGD+hsVPG7mse2cZ2OH1PuR1Ld/o/G/sjiwoAMG
 Kky1wL0LO/jnPstINOTKIXQqcrpi/dKhsbkBhB2tSpR9qpPco5rCBMKJnIHs0IQjMiJ+
 QuPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771249137; x=1771853937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wx8k2uu6ECWVGd/wabbWISL/AeSrmrXDqD0XagjQR1Y=;
 b=qRc58fGIlFZz7sRrfWveJ0B1HEKgg30s5qcKnVk/qKCHInPyVScZK0lEWQhkCFoaAW
 IHW9T93j4rh7KePd9kouHkylRR4FEXWmxk0iqUvEzBprrbni6FB1ly1RjczBaVz4s5/o
 xbuF8JmoiFUQrjKhBVVOPL1xxJpr5PYmLn0RDzGT3aPFlg8YnokoOQjO9+yvTVcIe+yd
 e1jn7kxCHpetG3YIKfCjMt8JJF2/f7dNAa+2/sJhdnNH+FqE20Zn3xCjMav78J6JAstc
 atujXhKrhr1s0AFe8bFsgyVRZ7Zr0qnoDeBr9jRecKMpq6QeGqSU9VBJjFGLz5/AC/S9
 ns9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771249137; x=1771853937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wx8k2uu6ECWVGd/wabbWISL/AeSrmrXDqD0XagjQR1Y=;
 b=LMtN1ZscQDjj5aG1xMheFXs3Rgvpozh/mceOTEL9ddwhSjaTIAy1lyIz7pdEHiuCtM
 NwnjHOhQ0Ff88UWt1AiZc1w+tFQMXyIktPyCSdoVFeEgBywY4qTSbrlghZZGrJRW8n1W
 e85hEUyykGXGNYj5ZyelYdnOfCKg9bo7D+AQUGtJ5rvge1Hmjcg82Kjpdmkm7BEzsJfI
 soUB73qe/y1IqyM06ZwwH/svz5yuS0xA+p4JTNxyumUSrV9ewZB82Fb7BzgCunu6XdXz
 9dQjUi5Ot4TQh+AFqEBX1Vo53MG4HinA5qfpd+qoEviVBuWhhqJ1QKH4JkWmIjDozPpM
 NgNQ==
X-Gm-Message-State: AOJu0YyjSRAgrvIkE6StHaqzqyhQoZaDqn2BgCSchvG4mB6CEJjUKrpa
 rAEst8Zm+3xNyoYKXx2SnW1s+D4/Dsj0rjNKiymTvztAspaTphmIYN9A971BgZQfxaUXcjnGEC9
 zmx2uLHs5wiTs4ZlwUI9d9jBPrVvG+LLypH2BuX7GTtUecsy1Z05w4+sP61YSgBoW35vRED1q+o
 yu7IysvfIM6gkukQK467j9sWw3hE9Fknk=
X-Gm-Gg: AZuq6aK85amDoLhpEza9fywq+H5o6g/lVasQWp2n3adMbFSgMyOtK6ex33Od78/yMzX
 07RGIl2flpgj06dnFdF48Bx4IZtVTxim6PlkRe6D2cxAR4L0aX9pzY1UhQmISsxbpVu8CTiyb+W
 ipepvYWE5K5qVzCKGpqfnROQ0H4TJSBmHL8i0HKzkNFzPssFR77Bat1iLBdyEqk74UBb/P9nwBc
 M5tuSCvbrT6Nla2g4obQVaECj22ENdkTd/hiy4=
X-Received: by 2002:a17:90b:3d50:b0:354:ad98:7d1c with SMTP id
 98e67ed59e1d1-35844a354c4mr7103333a91.11.1771249136844; 
 Mon, 16 Feb 2026 05:38:56 -0800 (PST)
X-Received: by 2002:a17:90b:3d50:b0:354:ad98:7d1c with SMTP id
 98e67ed59e1d1-35844a354c4mr7103309a91.11.1771249136437; Mon, 16 Feb 2026
 05:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
 <20260216-audio-v1-42-e676662e4514@redhat.com>
 <ed0bd069-0660-b195-b639-b0ce7717ea36@eik.bme.hu>
In-Reply-To: <ed0bd069-0660-b195-b639-b0ce7717ea36@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 14:38:45 +0100
X-Gm-Features: AaiRm53HG3SbfTbeQfQWkjas4NYdanjH0k5TwSb_UxFCiqA3mdlvW_jCcQeZ33A
Message-ID: <CAMxuvawVZm60+KE5bOAphvYPSTZcKuEgYd_r1jt6J0oPvTSqdw@mail.gmail.com>
Subject: Re: [PATCH 42/85] audio/dbus: convert to QOM lifecycle methods
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 16, 2026 at 1:15=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Mon, 16 Feb 2026, Marc-Andr=C3=A9 Lureau wrote:
> > Migrate the D-Bus audio backend from the legacy driver init/fini
> > callbacks to proper QOM realize and finalize methods.
> >
> > The DBusAudio struct fields are now embedded directly in the AudioDbus
> > QOM object instead of being allocated separately as drv_opaque. This
> > allows accessing the backend state through proper QOM type casting
> > with AUDIO_DBUS() rather than casting drv_opaque pointers.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > ---
> > audio/dbusaudio.c | 76 ++++++++++++++++++++++++++++--------------------=
-------
> > 1 file changed, 39 insertions(+), 37 deletions(-)
> >
> > diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> > index 269db7877b6..fb059815de9 100644
> > --- a/audio/dbusaudio.c
> > +++ b/audio/dbusaudio.c
> > @@ -48,21 +48,20 @@
> > #define TYPE_AUDIO_DBUS "audio-dbus"
> > OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
> >
> > +static AudioBackendClass *audio_dbus_parent_class;
> > +
> > struct AudioDbus {
> >     AudioMixengBackend parent_obj;
> > -};
> > -
> > -static struct audio_driver dbus_audio_driver;
> >
> > -typedef struct DBusAudio {
> > -    Audiodev *dev;
> >     GDBusObjectManagerServer *server;
> >     bool p2p;
> >     GDBusObjectSkeleton *audio;
> >     QemuDBusDisplay1Audio *iface;
> >     GHashTable *out_listeners;
> >     GHashTable *in_listeners;
> > -} DBusAudio;
> > +};
> > +
> > +static struct audio_driver dbus_audio_driver;
> >
> > typedef struct DBusVoiceOut {
> >     HWVoiceOut hw;
> > @@ -105,7 +104,7 @@ static void *dbus_get_buffer_out(HWVoiceOut *hw, si=
ze_t *size)
> >
> > static size_t dbus_put_buffer_out(HWVoiceOut *hw, void *buf, size_t siz=
e)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceOut *vo =3D container_of(hw, DBusVoiceOut, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioOutListener *listener =3D NULL;
> > @@ -162,9 +161,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutList=
ener *listener,
> > }
> >
> > static guint
> > -dbus_audio_get_nsamples(DBusAudio *da)
> > +dbus_audio_get_nsamples(AudioDbus *da)
> > {
> > -    AudiodevDBusOptions *opts =3D &da->dev->u.dbus;
> > +    AudiodevDBusOptions *opts =3D &AUDIO_MIXENG_BACKEND(da)->dev->u.db=
us;
> >
> >     if (opts->has_nsamples && opts->nsamples) {
> >         return opts->nsamples;
> > @@ -176,7 +175,7 @@ dbus_audio_get_nsamples(DBusAudio *da)
> > static int
> > dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceOut *vo =3D container_of(hw, DBusVoiceOut, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioOutListener *listener =3D NULL;
> > @@ -195,7 +194,7 @@ dbus_init_out(HWVoiceOut *hw, struct audsettings *a=
s, void *drv_opaque)
> > static void
> > dbus_fini_out(HWVoiceOut *hw)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceOut *vo =3D container_of(hw, DBusVoiceOut, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioOutListener *listener =3D NULL;
> > @@ -214,7 +213,7 @@ dbus_fini_out(HWVoiceOut *hw)
> > static void
> > dbus_enable_out(HWVoiceOut *hw, bool enable)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceOut *vo =3D container_of(hw, DBusVoiceOut, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioOutListener *listener =3D NULL;
> > @@ -256,7 +255,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
> > static void
> > dbus_volume_out(HWVoiceOut *hw, Volume *vol)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceOut *vo =3D container_of(hw, DBusVoiceOut, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioOutListener *listener =3D NULL;
> > @@ -290,7 +289,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListen=
er *listener, HWVoiceIn *hw)
> > static int
> > dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceIn *vo =3D container_of(hw, DBusVoiceIn, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioInListener *listener =3D NULL;
> > @@ -309,7 +308,7 @@ dbus_init_in(HWVoiceIn *hw, struct audsettings *as,=
 void *drv_opaque)
> > static void
> > dbus_fini_in(HWVoiceIn *hw)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioInListener *listener =3D NULL;
> >
> > @@ -346,7 +345,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
> > static void
> > dbus_volume_in(HWVoiceIn *hw, Volume *vol)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     DBusVoiceIn *vo =3D container_of(hw, DBusVoiceIn, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioInListener *listener =3D NULL;
> > @@ -363,7 +362,7 @@ dbus_volume_in(HWVoiceIn *hw, Volume *vol)
> > static size_t
> > dbus_read(HWVoiceIn *hw, void *buf, size_t size)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
> >     /* DBusVoiceIn *vo =3D container_of(hw, DBusVoiceIn, hw); */
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioInListener *listener =3D NULL;
> > @@ -398,7 +397,7 @@ dbus_read(HWVoiceIn *hw, void *buf, size_t size)
> > static void
> > dbus_enable_in(HWVoiceIn *hw, bool enable)
> > {
> > -    DBusAudio *da =3D (DBusAudio *)hw->s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(hw->s);
>
> Are you sure we need a QOM cast in all these potentially frequently calle=
d
> functions? The QOM cast is kind of expensive so only needed if it can get
> other objects than the expected. If the object is already checked in
> realize with a QOM cast it may not be needed to check it again every time
> it's accessed.

I would not be concerned if the check is done every 20ms or even 5ms.
(and with --disable-qom-cast-debug it should also help).

If you want, I can look at providing some perf data, but I am afraid
it will be just noise difference.

>
> Regards,
> BALATON Zoltan
>
> >     DBusVoiceIn *vo =3D container_of(hw, DBusVoiceIn, hw);
> >     GHashTableIter iter;
> >     QemuDBusDisplay1AudioInListener *listener =3D NULL;
> > @@ -416,28 +415,31 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
> >     }
> > }
> >
> > -static void *
> > -dbus_audio_init(Audiodev *dev, Error **errp)
> > +static bool
> > +audio_dbus_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
> > {
> > -    DBusAudio *da;
> > +    AudioDbus *da =3D AUDIO_DBUS(abe);
> >
> >     if (!qemu_using_dbus_display(errp)) {
> > -        return NULL;
> > +        qapi_free_Audiodev(dev);
> > +        return false;
> > +    }
> > +
> > +    if (!audio_dbus_parent_class->realize(abe, dev, errp)) {
> > +        return false;
> >     }
> >
> > -    da =3D g_new0(DBusAudio, 1);
> > -    da->dev =3D dev;
> >     da->out_listeners =3D g_hash_table_new_full(g_str_hash, g_str_equal=
,
> > -                                                g_free, g_object_unref=
);
> > +                                              g_free, g_object_unref);
> >     da->in_listeners =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> > -                                               g_free, g_object_unref)=
;
> > -    return da;
> > +                                             g_free, g_object_unref);
> > +    return true;
> > }
> >
> > static void
> > -dbus_audio_fini(void *opaque)
> > +audio_dbus_finalize(Object *obj)
> > {
> > -    DBusAudio *da =3D opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(obj);
> >
> >     if (da->server) {
> >         g_dbus_object_manager_server_unexport(da->server,
> > @@ -448,14 +450,13 @@ dbus_audio_fini(void *opaque)
> >     g_clear_pointer(&da->in_listeners, g_hash_table_unref);
> >     g_clear_pointer(&da->out_listeners, g_hash_table_unref);
> >     g_clear_object(&da->server);
> > -    g_free(da);
> > }
> >
> > static void
> > listener_out_vanished_cb(GDBusConnection *connection,
> >                          gboolean remote_peer_vanished,
> >                          GError *error,
> > -                         DBusAudio *da)
> > +                         AudioDbus *da)
> > {
> >     char *name =3D g_object_get_data(G_OBJECT(connection), "name");
> >
> > @@ -466,7 +467,7 @@ static void
> > listener_in_vanished_cb(GDBusConnection *connection,
> >                         gboolean remote_peer_vanished,
> >                         GError *error,
> > -                        DBusAudio *da)
> > +                        AudioDbus *da)
> > {
> >     char *name =3D g_object_get_data(G_OBJECT(connection), "name");
> >
> > @@ -482,7 +483,7 @@ dbus_audio_register_listener(AudioMixengBackend *s,
> >                              GVariant *arg_listener,
> >                              bool out)
> > {
> > -    DBusAudio *da =3D s->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(s);
> >     const char *sender =3D
> >         da->p2p ? "p2p" : g_dbus_method_invocation_get_sender(invocatio=
n);
> >     g_autoptr(GDBusConnection) listener_conn =3D NULL;
> > @@ -667,9 +668,8 @@ dbus_audio_set_server(AudioBackend *s,
> >                       bool p2p,
> >                       Error **errp)
> > {
> > -    DBusAudio *da =3D AUDIO_MIXENG_BACKEND(s)->drv_opaque;
> > +    AudioDbus *da =3D AUDIO_DBUS(s);
> >
> > -    g_assert(da);
> >     g_assert(!da->server);
> >
> >     da->server =3D g_object_ref(server);
> > @@ -711,8 +711,6 @@ static struct audio_pcm_ops dbus_pcm_ops =3D {
> >
> > static struct audio_driver dbus_audio_driver =3D {
> >     .name            =3D "dbus",
> > -    .init            =3D dbus_audio_init,
> > -    .fini            =3D dbus_audio_fini,
> >     .pcm_ops         =3D &dbus_pcm_ops,
> >     .max_voices_out  =3D INT_MAX,
> >     .max_voices_in   =3D INT_MAX,
> > @@ -725,6 +723,9 @@ static void audio_dbus_class_init(ObjectClass *klas=
s, const void *data)
> >     AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> >     AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> > +    audio_dbus_parent_class =3D AUDIO_BACKEND_CLASS(object_class_get_p=
arent(klass));
> > +
> > +    b->realize =3D audio_dbus_realize;
> >     b->set_dbus_server =3D dbus_audio_set_server;
> >     k->driver =3D &dbus_audio_driver;
> > }
> > @@ -734,6 +735,7 @@ static const TypeInfo audio_types[] =3D {
> >         .name =3D TYPE_AUDIO_DBUS,
> >         .parent =3D TYPE_AUDIO_MIXENG_BACKEND,
> >         .instance_size =3D sizeof(AudioDbus),
> > +        .instance_finalize =3D audio_dbus_finalize,
> >         .class_init =3D audio_dbus_class_init,
> >     },
> > };
> >
> >


