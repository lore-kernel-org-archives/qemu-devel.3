Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E389CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdvQ-0007Am-IF; Fri, 02 Oct 2026 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCdvD-0007AC-6V
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:07:38 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCdvA-0000Fg-JQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:07:34 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c5so6776849f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1790950050; x=1791554850; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SvRi/NKV2i61RvjNaOSMrX5p1gIrbgzKqcqw+6GxgL8=;
 b=AZ/qhR4Yzv1Quu2omkHJ3Tf6+Wh1o8jnUq6k25j/tmkrRSzCzTts/32budZpG7uHEN
 cPYuLN4PMXyDIEBaRCfD1QdMDh1i1zLn0Kr9j7HsgG3xpKMTkT9sOA2WIpgbnao6TKhY
 29MAKdUuijbQ1LU95HPhfgn8qqutM+z3GSVE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790950050; x=1791554850;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvRi/NKV2i61RvjNaOSMrX5p1gIrbgzKqcqw+6GxgL8=;
 b=pfC1udifL7zzgpEtiwR6dFRWtJiUkEGEwvKJCtN7jmxQhdqyfiZLOLkDMpZLvfj9GP
 TwCX654f6BYPovJSQvBZm9xgXmf6ja6mxw2M0A0tTOS+pIYzpBMeRrb8ddM8G1KOZMbG
 1D1X3mFUUOLg3j6C3rEcXDwjTp51AsaqUkCKJVA5Iv7xaZlg8OhIvlMXS1MAdR87Wd5G
 mk7NyiR81Et7qzHBTjAEnsLT8CEikHgOTxsUecJACkf9lR8SJQCU/D0rBDLYGqmGLFl/
 olkfJdX5/HzmLIr6+NEWVF4X4m3QbO8PZ+2W6MKTgGaeoJJXt6MskT4upRXO5bjEKFkd
 gRNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSvkrdqGdZEd1wOxUwU+XRBJkJXr/OK5NEY2gc3GrtSibJ40qklgv5Vpf7LTmIeHi06M8/hVcPwu3H@nongnu.org
X-Gm-Message-State: AFq9FYKKblj3hnpCDhFsllCpwroJ+3jDlr9RejUlsCMqHJ+mkvqDGeBI
 9q7HX0D5J5yW0L6gHuBZKJUyOV8U9xw7eREeX7U/Yr5xOcUCRMujUfzjekiAONkRYG8=
X-Gm-Gg: AYBFou0G8TbeSNMi/ZNamf3unWEA0DybZDAzSQl7RiXQt9ZolrRbQS8esHP7MHFmJJF
 jMNgKO2CMBrTIS7BMaVD7GCYN/LiIOn+dhp55IHujxsUGX7hfAIeiPKVqB+n3/Vsj6yd7281JdN
 /1m9mZvAwd3z0+UDQmqgdVtJq7zk8Ft04fMiZ/H4l1jcp+WscrhUqEbJUpDXX8xLgqnIumNKH36
 G1iEm4H+zsGZ3vNUzjhyVboVOiVccheP5+DsFg/tLUxdKY7cYQi6prqa5s6VGGl2eq0YD0JjwH3
 5YMGrNoZ2RBeqf3egnoLbNCehaPiyEF3XKotzHma98NX7QUgQ4JSZw7hBUwJkjMxVN870+QhwKk
 NM5FRG5bETmKhgUf32RQCwrqcjdwjrAiC9OB1VvJg2GP94joFa0ilBDuPRJVZO2SjOty300y8fc
 qDO6m0bVv0Ybki7GCcXSGfdfBj7GR/NOJYeQEdp15KFta/CZtyIRh1nB0ndfONOwqGB7KOgVWad
 u/n+hWSjniPwGQf/7UEoxCXaUT5tREhORLJiUOjKlc2EocG4wY0sZMVqKzRqtYKSOOeq9KypIYc
 xle3HJLkBg0Q/vzV6c6r77G73DpaX9by2wQQ/wje
X-Received: by 2002:a5d:4386:0:b0:488:5af8:eabc with SMTP id
 ffacd0b85a97d-48b1275411dmr4688693f8f.26.1790950050142; 
 Fri, 02 Oct 2026 07:07:30 -0700 (PDT)
Received: from ?IPv6:2003:cf:574e:ac00:452:5491:4ae5:cb71?
 (p200300cf574eac00045254914ae5cb71.dip0.t-ipconnect.de.
 [2003:cf:574e:ac00:452:5491:4ae5:cb71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253e5bsm5456492f8f.1.2026.10.02.07.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:07:29 -0700 (PDT)
Message-ID: <c58c324d1ce1f095c0036c43691d61d9dcac6f1d.camel@mihalicyn.com>
Subject: Re: [PULL v2 10/10] hw/audio/virtio-sound: add missing vmstate fields
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: Peter Maydell <peter.maydell@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: aleksandr.mikhalitsyn@futurfusion.io, qemu-devel@nongnu.org, Volker
 =?ISO-8859-1?Q?R=FCmelin?=
 <vr_qemu@t-online.de>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Date: Fri, 02 Oct 2026 16:07:28 +0200
In-Reply-To: <CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
 <20260919085510.3388454-11-manos.pitsidianakis@linaro.org>
 <CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr2-x10.google.com
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

On Fri, 2026-10-02 at 14:49 +0100, Peter Maydell wrote:
> On Sat, 19 Sept 2026 at 09:56, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >=20
> > From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >=20
> > The virtio-sound device is currently not migratable. Add the
> > missing VMSTATE fields, enable migration and reconnect the audio
> > streams after migration.
> >=20
> > The queue_inuse[] array variables mimic the inuse variable in
> > struct VirtQueue which is private. They are needed to restart
> > the virtio queues after migration.
> >=20
> > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > [AM: trivial rebase changes]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Message-ID: <20260803081159.91981-11-alexander@mihalicyn.com>
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Hi Peter,

>=20
> Hi; this change triggered a Coverity nitpick (CID 1687010):
>=20
> > +static int virtio_snd_post_load(VirtIODevice *vdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0 VirtIOSound *s =3D VIRTIO_SND(vdev);
> > +=C2=A0=C2=A0=C2=A0 uint32_t i;
> > +
> > +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->snd_conf.streams; i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct VirtIOSoundPCMStream=
 *stream;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream =3D virtio_snd_pcm_g=
et_stream(s, i);
>=20
> Here we call virtio_snd_pcm_get_stream(), but we don't check
> for a NULL return, unlike the other callsites.
>=20
> This NULL can't actually happen, because it only occurs for an
> out-of-range index, and here our index is by construction
> in-bounds. So this is a Coverity false positive.

yes, I did know about this, but haven't expected Coverity to overreact here=
,
cause I specifically checked that NULL pointer dereference is not possible.

My fault, sorry :-(

>=20
> But I think it would probably be slightly better to follow the
> convention that seems to be used in the rest of the file, which
> is that virtio_snd_pcm_get_stream() is used when dealing with
> stream IDs from the guest that need validation, and for "loop over
> all streams" (as we do in virtio_snd_realize(), virtio_snd_unrealize()
> and virtio_snd_reset()) we write that like:
>=20
> =C2=A0=C2=A0=C2=A0 for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++=
) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOSoundPCMStream *stream =
=3D &vsnd->streams[i];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 }
>=20
> What do you think?

I'm happy to submit a patch for this if you and Manos don't mind.

Sorry again for some extra work because of my patches...

Kind regards,
Alex

>=20
> The other option would be to just close the coverity issue
> by marking it as a false-positive.
>=20
> thanks
> -- PMM
>=20

