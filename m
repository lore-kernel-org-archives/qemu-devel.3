Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A95FCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBC4E-0000Uj-Ii; Tue, 21 Oct 2025 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBC4C-0000US-Q5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:06:20 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBC4A-0001Ks-0F
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:06:20 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-88e525f912fso820817685a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761051972; x=1761656772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X25/TdWC2RbEUKoNQr/cBr7R9FWZj0XYhBXwGZAfEm8=;
 b=V5avpmZ7NS/C2DdR7m4+AsddPFlKQFq7FxIDbCHXpZ5vZtaqTr3b59YrwZs1r7qQiR
 zRo2xSFNTUFDMfWYww3acuCkwAI78fSaWjJNxBadogc7cWNo2E9oNJELolkealQM7TKf
 XU1MXDcj6PAvkzX7c/yVUN8u9aHvETSFPKQwH3FyJYxMULIGZlP5fva1pZoJFzyXa50t
 Z3hQXCJTKhiKgTFg/9HCHCo4+FyQy7YaHZ7WTFkMi7HZrrcTY+14bccph6AfY4ODh3WP
 N74pPhKWMur2URPxOuEaDzA0e+cHyKz8L53hNWdU5ITcCUzd7tjm1R3e7r6MuxrVKP2a
 iRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051972; x=1761656772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X25/TdWC2RbEUKoNQr/cBr7R9FWZj0XYhBXwGZAfEm8=;
 b=nZBRE8x00KcH4sWw6p7UMnUqvsCn350rnY52AnIgtUWioux1Z7fbcAlUKF/jkYPJ5s
 FJP8fAC07RjfAux7bfcTnDA1fOlMO7mnleGpzG3JW+sZ9pSdwvOTTh0Q4Zhmq59ADRiu
 9G3lVdRt8b6VDtpC8q/VA7Z7H321weT9hsxSMp+GOdffEhf0iGGguqvbfe0jVO2yQNAj
 oOjkRfc8x0BGSVcUtBmpbxzfJqIO+Dfw23sZHwR58BHE7ulZMu7uBDlSeqeYUFJhQWeP
 MD3i9yP5iHFvuCSw0fw74I+Zxxch//U323WDXwOr5P6ilWJf9gz3gvEjYAP/DQ5TfN1z
 IZKw==
X-Gm-Message-State: AOJu0Yy8QraBk9znyw4oLdaDfpWOKl6iRtiuhmZaJVN6FN0c7C76FZMp
 MxS+D0RORhd9P2wnsHxWWzQ747olbt53HaNUe0JvkAqPdewZAt8SDJ9FALN/tS12zFRI/n0UMjh
 OKDIFNnt6RtIVdvmD97qd4yXQkJU5TQs=
X-Gm-Gg: ASbGnctjgydYYY/FqIMIO9VGeHZ+6Jqs3Xy5p5aoEqPNLkCAVPe+OUnv0Yt6sR6M0ZJ
 9OsOIWLZVEohwzQnVKtnxEDLeQUy2zAgQCXoK2BBtuV8nHATeLBEnnFnFSWFGH6VDx6Bo4lOUc5
 hlYQ1XtS7cmpeBTpWdjqhLiM1fIINBo3e+kLb3gyh00avFLLBdEk722ckRO/cMLkc1mBstkvhwA
 4gAR+zLuaOYkXGImkQuujT8yrDvaJOxbMitTEhvQcr/CxWwKfWQsvIkbHUrPQzelqbRz6PpvYiR
 OeGYoz0O8Ke0BY2g
X-Google-Smtp-Source: AGHT+IFt5en3LQpBehe8Qoe5/+UMS68TdvJuvQlXCeedqz5lQ/+hps/Zw6CM5ATTjbqtzB54JQDZOp9p0D4V2EzRMbg=
X-Received: by 2002:a05:622a:310:b0:4e8:9c58:3282 with SMTP id
 d75a77b69052e-4e89d28b3cfmr230722771cf.29.1761051972439; Tue, 21 Oct 2025
 06:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-36-marcandre.lureau@redhat.com>
 <e8232530-ce04-c542-d39e-c0e2dc5014b3@eik.bme.hu>
 <CAJ+F1CJ8Ojiwen+rPrrFAineLYX0-qyXVysCaUSNeSytWPSYkg@mail.gmail.com>
 <22226473-1730-9c09-4fce-0aa03ff244f6@eik.bme.hu>
In-Reply-To: <22226473-1730-9c09-4fce-0aa03ff244f6@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 17:06:01 +0400
X-Gm-Features: AS18NWACPpGmNxuill4bA7GPZx7TKrkwiAQTQ6TUNI0ELFxWEpvHu3p1GahowGI
Message-ID: <CAJ+F1CL9_vM0nXt1XKsx-SWG1kxdHfgNJWppx-aTZ7DK3MktpA@mail.gmail.com>
Subject: Re: [PATCH 35/43] audio: rename QEMUSoundCard -> AudioFE
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72e.google.com
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

On Tue, Oct 21, 2025 at 4:50=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 21 Oct 2025, Marc-Andr=C3=A9 Lureau wrote:
> > On Tue, Oct 21, 2025 at 4:13=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu> wrote:
> >>
> >> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>> audio/audio.h                       | 20 ++++++++++----------
> >>> audio/audio_int.h                   |  6 +++---
> >>> audio/audio_template.h              |  4 ++--
> >>> hw/audio/lm4549.h                   |  2 +-
> >>> include/hw/audio/asc.h              |  2 +-
> >>> include/hw/audio/virtio-snd.h       |  2 +-
> >>> include/hw/display/xlnx_dp.h        |  2 +-
> >>> include/hw/isa/vt82c686.h           |  2 +-
> >>> include/hw/qdev-properties-system.h |  2 +-
> >>> audio/audio.c                       | 10 +++++-----
> >>> hw/audio/ac97.c                     |  6 +++---
> >>> hw/audio/adlib.c                    |  6 +++---
> >>> hw/audio/asc.c                      |  6 +++---
> >>> hw/audio/cs4231a.c                  |  4 ++--
> >>> hw/audio/es1370.c                   |  6 +++---
> >>> hw/audio/gus.c                      |  6 +++---
> >>> hw/audio/hda-codec.c                |  6 +++---
> >>> hw/audio/lm4549.c                   |  2 +-
> >>> hw/audio/pcspk.c                    |  4 ++--
> >>> hw/audio/sb16.c                     |  4 ++--
> >>> hw/audio/via-ac97.c                 |  4 ++--
> >>> hw/audio/virtio-snd.c               |  4 ++--
> >>> hw/audio/wm8750.c                   |  6 +++---
> >>> hw/core/qdev-properties-system.c    |  4 ++--
> >>> hw/display/xlnx_dp.c                |  2 +-
> >>> hw/usb/dev-audio.c                  |  6 +++---
> >>> 26 files changed, 64 insertions(+), 64 deletions(-)
> >>>
> >>> diff --git a/audio/audio.h b/audio/audio.h
> >>> index 845e078169..a43ca0700c 100644
> >>> --- a/audio/audio.h
> >>> +++ b/audio/audio.h
> >>> @@ -70,18 +70,18 @@ struct AudioBEClass {
> >>> };
> >>>
> >>> typedef struct AudioBE AudioBE;
> >>> -typedef struct QEMUSoundCard {
> >>> +typedef struct AudioFE {
> >>
> >> You could also leave it as it is. While it's a bit odd naming it's cle=
ar
> >> enough and not at least the local variables now called "card" match th=
e
> >> type which would not be the case if you rename it to Audiodev or somet=
hing
> >> else but not rename all the locals. So maybe it does not worth the chu=
rn
> >> to change this type name.
> >
> > I think it's still worth it. Local variables are locals, and usually
> > easy to understand by the context and using their types. It's easy to
> > rename "card" to "audio_fe" or "frontend" though, I can do this in
> > this change too.
>
> The point is to have less churn not more so renaming locals from card to
> fe or something (but definitely not to a longer name than currently) woul=
d
> just be more churn for not much more clarity. Therefore I argued that

Renaming is making churn, I agree. But if the end result allows more
readable code, even slightly, we should consider it.

Imho AudioState and QEMUSoundCard are bad type names that don't help.
I value type names a lot more than variable names, especially now that
we have LSP, I am probably not the only one.

I proposed AudioBE and AudioFE, for simplicity consistency and to
avoid some naming clashes with QAPI types.

Agree, BE and FE are not the most readable, so AudioBackend and
AudioFrontend seems agreeable (local variables or in fn_name_for_be
use usually a shorter version though).

And Paolo suggested to remove AudioFrontend (QEMUSoundCard)
altogether, which I also think makes sense.

> living with QEMUSoundCard type name is better as it keeps consistency wit=
h
> local naming and avoids churn. The current type name does not match
> anything else in QEMU but it's clear (even more clear than the proposed
> AudioFE) so I'd accept this small inconsistency in naming for avoiding a
> lot of churn. If you still want to rename it could we call it AudioCard t=
o
> keep consistency with locals or Audiodev what Paolo proposed which is
> still clearer than AudioFE? But I'd just leave it as it is as the simples=
t
> solution.
>
> Regards,
> BALATON Zoltan



--=20
Marc-Andr=C3=A9 Lureau

