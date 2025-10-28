Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A429CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiud-0007o4-Ke; Tue, 28 Oct 2025 08:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDiub-0007n5-Jt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:34:53 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDiuU-00053f-O1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:34:52 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-89c81839de7so313478985a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761654883; x=1762259683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQnjYQ0yGom/2oCJUwbsDLkSJOo+kap0BYVvQOuuuWc=;
 b=Xl/WJOs3ascQAfvsUJCDjsAzYH7v5+F8bIHxzj0vUBQWGUBW060c6EXtmJCCSOJJkw
 aGUBaJ0KhjSoWdvws6vKZmJxyGiNjVMsVGb6hcHJJ6s8O8ejBrhq1M1tCVGiLx3rhD8W
 dF86QfpJCoo+OZsXYV9S7NjnAyessbRTJMZHtBLqsW32V+6eYQbSqsMscEKFiXpJzvyT
 gYQuiOAY94i0C0BntSXE01yXYKtJ0H1fGA5RfiBcI4dV6uTnANtxoDWCdQIr9WrL2X1s
 L8oq7zL6ZlyjPUZGYlbIX9LYYd1HZgvjAH4BLrL41ge1ipcC2EzmkFNFZj30bhhWGHvo
 j45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654883; x=1762259683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQnjYQ0yGom/2oCJUwbsDLkSJOo+kap0BYVvQOuuuWc=;
 b=KTvhHEuecVrvsi3kyPEr9YTGWmGXUEGuLjBupkXNUbHoQmsJZOig2QuDyQhA66uMWn
 aTi1S+v0NJzfBi4kqnIHs27OyWONUX3kbS9Yn4mzqLMMtX9sk6ZXr5CFjN5B4MEL222b
 mnKwiSNH5/B/Grerd5uAKjwtExlhnrWh5xfVn6fsOIbSSxj/9V6LzlccYE93p7137DB0
 WoKzjulLU2l1Hv+VHatvWfNhhtlFuKwYd7WH8NKfO3yDYqgsEhJPIA4IBMHHImBVVtBl
 0rFrZYRZWQUm5XpadETtP7nNlv8v2XynRqb8BxqXUIa+J3W9EOdtZvaHYA1t8KmsHI4T
 Zg+Q==
X-Gm-Message-State: AOJu0Yyd4TEh7jdCa4y/ZkiN4elyTLkUqfdyw6j9QVtcB3g2uzXrdY/U
 6tVYIDjb+AqrMVabl+aqjKCVfiD5cnKDijXog98M3jT09EPoSfPEDn+MK3HmkbpbFSW+W1JpXBg
 xyvIempAHN26ZVitxedcNoHSTs5eIyXk=
X-Gm-Gg: ASbGncuY1vUr6MAf0MYLNDex3urEsD/DxhYKGw/qEXhbZtdNp2J4CWTImPqwkHNUtYW
 GEGn3h0Eb+JhLTW492tBAFKCIYC5ocQ1/rtH7fPsdXrZviSPW4FXx1S1qmXhm6t5ZxKq+d4mE2Z
 mu9jhuiB4GHGqUfsaPK1afSmUuE7JIsalpO2NU1e/ox0oyMGp61dv4YCkc5mvhUf1rlB4K/IyLL
 6imnnXee5kNB+VarRWdNYgzED2i5QCVfT8wkjHSBM3jPLh0nTemg+ZCRJPK145RrdIzJ+YZ43Xe
 OftmVdsrDtrjE1Ts
X-Google-Smtp-Source: AGHT+IEMD1O4irbieBoEOhfE5znusIqCe6ZhScWbrxZOSavPj+LeiG4RBN3SjnRNCbbGFkVGkEdLfsFXDgjdPzvT28s=
X-Received: by 2002:a05:620a:371b:b0:859:7e5d:efa3 with SMTP id
 af79cd13be357-8a6f3e24ecamr390126585a.14.1761654883326; Tue, 28 Oct 2025
 05:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-10-marcandre.lureau@redhat.com>
 <342519b4-4de6-f54b-606e-b1b3b1c97dc9@eik.bme.hu>
In-Reply-To: <342519b4-4de6-f54b-606e-b1b3b1c97dc9@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 16:34:31 +0400
X-Gm-Features: AWmQ_blNZnC3_C_4gNNJqKYn16ZoWmT3SY8KHGEr2VNmMH1EHPvD29EE9GfdRG8
Message-ID: <CAJ+F1CJj__oPiBwXKeH88tF8k6vEjqqe6KMO4g9HmcnNqbpRfA@mail.gmail.com>
Subject: Re: [PATCH v3 09/35] audio: start making AudioState a QOM Object
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Ratchov <alex@caoua.org>,
 Jan Kiszka <jan.kiszka@web.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
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
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 8:29=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Mon, 27 Oct 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > QOM brings some conveniences for introspection, type checking, referenc=
e
> > counting, interfaces etc. This is only the first step to introduce QOM
> > in audio/ (I have more in the pipeline)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > audio/audio.h     |  7 +++++++
> > audio/audio_int.h |  2 ++
> > audio/audio.c     | 43 ++++++++++++++++++++++++++++++++-----------
> > 3 files changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/audio/audio.h b/audio/audio.h
> > index eb5b5d662d..e41c5bc55a 100644
> > --- a/audio/audio.h
> > +++ b/audio/audio.h
> > @@ -80,6 +80,10 @@ typedef struct SWVoiceOut SWVoiceOut;
> > typedef struct CaptureVoiceOut CaptureVoiceOut;
> > typedef struct SWVoiceIn SWVoiceIn;
> >
> > +struct AudioStateClass {
> > +    ObjectClass parent_class;
> > +};
> > +
> > typedef struct AudioState AudioState;
> > typedef struct QEMUSoundCard {
> >     char *name;
> > @@ -182,4 +186,7 @@ const char *audio_get_id(QEMUSoundCard *card);
> > #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
> >     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
> >
> > +#define TYPE_AUDIO_STATE "audio-state"
> > +OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
> > +
> > #endif /* QEMU_AUDIO_H */
> > diff --git a/audio/audio_int.h b/audio/audio_int.h
> > index f78ca05f92..b2b4d2d10e 100644
> > --- a/audio/audio_int.h
> > +++ b/audio/audio_int.h
> > @@ -217,6 +217,8 @@ struct SWVoiceCap {
> > };
> >
> > typedef struct AudioState {
> > +    Object parent;
>
> Coding style says parent_obj, not sure other names are acceptable.
>


Alex, since you wrote that section in docs/devel/style.rst, should we
enforce that naming?

--=20
Marc-Andr=C3=A9 Lureau

