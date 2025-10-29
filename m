Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D87FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBPc-00050W-ES; Wed, 29 Oct 2025 15:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vEBPX-00050D-Pc
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:00:44 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vEBPL-0000mA-US
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 15:00:41 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ed0d6d3144so1294111cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761764424; x=1762369224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXspraXHM0TPtF5KOO/3bIdmauHuTzRo+mAsbwuwqB0=;
 b=GdIem8LfYBbRsssP233ElUwrocIj0SBkxU2/e4hq6wf2EW5V61f4kRGnmY8PWiQ5so
 51l8t590/Dm8x4v46gvx4XGWHIGxgdFqqDUS9Bf85qwzO/jI/SPexwbn7nmpA8cx1QLA
 mywzTvSF7DrNv+7K4rtKYP3fnkjbtaGQUuT1iAlNcBr+T/95D1U/eXm3iPE40cjrF6EK
 03IPclk/EVpZgTh0wxv467ALvXct8UFb0b9jbUrFH8NHZebaJkZqxlxpsyeYL8LT7wWj
 V3Zyha4TYNK3MExt9kPSH7AgxN2e7RlxHFoFhXs8CiE8y3ZQ4xx4sSpmtG4ZGwi20Nky
 VvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761764424; x=1762369224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXspraXHM0TPtF5KOO/3bIdmauHuTzRo+mAsbwuwqB0=;
 b=lViT91i7H1ztfZXC/dp/O31xmDWP5NcQ6Sv80kF1S52H/WTKWUlN3YD8oAbWxq1Q/A
 kxPChjkXlhu+qCH1YVEy0Ztr+DMkwOvkOOx1Dtq+GE3o/miHdEE4cWhCGKat8zEmb7D6
 sXHbiOe5og2thjh4wS/7D6ODi4lyU2Jkzx4241Og6b5/jZEIGEOWIHlDSAlZ7HuXDiiQ
 GV6XuPAJRgf9bRh8aTwgXVfmpuDWG3tcfSZ51puvDvuvvyt30xYJJq3Ew4RxZN31zGTJ
 iQHv5wI5hn01v6UwhD3Ng/u/p9HaD6VkRIbtPKU622KrdeeXe9g6b444qE+VDVH84q3O
 maMA==
X-Gm-Message-State: AOJu0YwTpKgTJu8rUj1zG94i2KLgVi3tbhn90hfqhlwD+Y1c43vglFVe
 /m0HfWb7iJER9BHriisO54fl183eZXL9HUxNJ1X5HfmD2VEhdww9+1URdsYUJhz0YyEEYo3uCpq
 O/GvIaHgvZU9u2ksgRR/mWzHm5LtCtgc=
X-Gm-Gg: ASbGncsPlbCNr5HIgpY7y8IUInJooW1JcJOlqc+7tWpZVSA8hN8NXeBlI50FM4GcH03
 2qFcbkZmKhktFhFYmLxEpymqThqynsIrmWrv9LL1mU1TdtXa/5WjUGXOSvwsUncf0iMps4EmS+W
 fjSJyfi3ZIy2/4Ltt4OccgFWN7cKMsFzPeYNf0B09fLhfH+2ElObFJQ0Vg08eLYb8IRBCt4kFB6
 46T3YOxjVk4/h1MYRFb87d7tmCKSZHFl5rPVip2qHPiyc3+Nd7+sA4nycAKrteb8DQIXXaISNi+
 4y+q+S+ytG5sxvEf
X-Google-Smtp-Source: AGHT+IEvwl9ZaBXLgW6Jp5ufjUJvfE2JG69Ga6dE1zeEiTu7jaenR63Bdvl1/+S1N6+Y+zr2HCLCThIYwGdsoZ30zOs=
X-Received: by 2002:ac8:7c43:0:b0:4e8:a3aa:7a89 with SMTP id
 d75a77b69052e-4ed21f4e861mr6352201cf.45.1761764424096; Wed, 29 Oct 2025
 12:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-20-marcandre.lureau@redhat.com>
 <ffab95ce-9b5d-43ea-93a7-611de6044ad8@linaro.org>
In-Reply-To: <ffab95ce-9b5d-43ea-93a7-611de6044ad8@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 Oct 2025 23:00:12 +0400
X-Gm-Features: AWmQ_bm9VFQyXo1ysdqgFgjThZg-_49lCrPUaj86svbFMyq-tMJzIWSelD-c5CM
Message-ID: <CAJ+F1C+qnkm=F1q0YSHZ9WbAMcz+-NJo5mzj1b-DcU24dNpRLQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/35] audio: register and unregister vmstate with
 AudioState
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Ratchov <alex@caoua.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Thomas Huth <huth@tuxfamily.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

Hi

On Wed, Oct 29, 2025 at 5:51=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Proper lifecycle management with QOM state.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 4c3c3fd52f..853930bb48 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler (void *=
opaque, bool running,
> >       audio_reset_timer (s);
> >   }
> >
> > +static const VMStateDescription vmstate_audio;
> > +
> >   static void audio_state_init(Object *obj)
> >   {
> >       AudioState *s =3D AUDIO_STATE(obj);
> > @@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
> >
> >       s->vmse =3D qemu_add_vm_change_state_handler(audio_vm_change_stat=
e_handler, s);
> >       assert(s->vmse !=3D NULL);
> > +
> > +    vmstate_register_any(NULL, &vmstate_audio, s);
>
> Please avoid legacy APIs:
>
> /**
>   * vmstate_register_any() - legacy function to register state
>   * serialisation description and let the function choose the id
>   *
>   * New code shouldn't be using this function as QOM-ified devices have
>   * dc->vmsd to store the serialisation description.
>   *
>   * Returns: 0 on success, -1 on failure
>   */
>

qdev/Device have vmsd, but not plain Object (or legacy code without object)=
.



--=20
Marc-Andr=C3=A9 Lureau

