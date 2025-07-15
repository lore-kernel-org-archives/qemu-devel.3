Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33467C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubX8e-0001rj-Ql; Tue, 15 Jul 2025 00:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubX8R-0001hm-Cr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:19:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubX8P-0001uq-GL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:19:19 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so7215855a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 21:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752553155; x=1753157955; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X18Qb6El3DLoOk6eskeNUGsfPX0xeQm0MRvQWs8yl4M=;
 b=TYWnzwKous1G1GjkyXLNTS8geFS3Hx/EVv661sWZGWWkIoOlnYi0t/1ye2aPQ2CHQa
 agqGRodd3nrE+9tgxmBBVc85LrW4xaeO1Tv/EX5AP3sRKVw3trADDHq4OY5XQp9fJNfy
 2M7+7ryITFtvjZnP0WYCDg4VQs2XbJZyzfZyPxFHgNWWPu/FNDtcC7jGpCZKmJAaTYV0
 VLs/jvsDNlhdzGV+UrmTZcOubzgHtVFY548Ncl7SHcGTR9/AjCTaVVBT3aSwQu40bRsU
 Zjz2g/efl2DqbRvbms51qjJ8bwRO51GfwOZrCj4TljEtPgXKqgkAq5S9H0ipRxbj9fHe
 vVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752553155; x=1753157955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X18Qb6El3DLoOk6eskeNUGsfPX0xeQm0MRvQWs8yl4M=;
 b=RQemjSlCAr+UI63ap7cmJakqs5qD13NqtOn6mL3s7L1nosxH5WSRs9FE5faLHhmhNr
 MdX61heGkaGojQvag4iN2ZDHOe7QaJ5rIA8l1WwftqhigMgtIrjflR24y7x+B5V9bJhn
 xUKrqrsjzIfm+QYpZBsLMShmGJFbgrsj1orPvOsj9d4GRtUsGDG9+dAMM/gIJzlDJRQ1
 CPqKODVi3U7tNg+ClxzlMuUO7nWhusHY8Dwjghkh47eI3AZfwhcQyQteaxSaKRNCMLgy
 rf6O/oiGm153IGevJ6rlamyqewbiCBDZ8lyqND2dSv+d3h+6YM5bvIgjWtMbZRPoeMc6
 +a3w==
X-Gm-Message-State: AOJu0Yyqo/x3EdnikpBd6iQMKHfONwkY3K4x6XEw53glmeYBlt3CJH9Y
 ZospTHcHtjTXAWnZU9xM/VVXAr5Ri2ved+6VF+0rRmNrfMtBI+C+nnnAM2vTxPLKWCIG542ROE7
 5z2Tvd8WhfbUW9glSOzNbPD+Isx0Rc74=
X-Gm-Gg: ASbGnctaEt1A6zepbJLOTNuI3GsT1E2Z53HPwikuTq3Fatv7xg3LTD3K4sBsRotGN49
 5qhS1wqBj1L6yGzJZg+GD1qHK27tK0vRqmsiM4QCg0rPuK3Z7cb3+ZNCLZVT3Zun/x3hdlk+r+t
 EyEckWuI/F3Hwr5depnNN6CxMgs3gxnoUd94bX2g/oMnweyl6iYkBDyIJV85q4XLPhK7vJRUIc1
 es=
X-Google-Smtp-Source: AGHT+IFxuX44j9soZbBMvssO9gQwI0aqLfVGtYCYgs/ikOj6BLMiARjCARXsR1WP57HpK/b2SbRyCmtTp/2E5TsyD5E=
X-Received: by 2002:aa7:d512:0:b0:60e:b01:74c1 with SMTP id
 4fb4d7f45d1cf-6126b6e4e70mr680808a12.31.1752553154811; Mon, 14 Jul 2025
 21:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+SsUmNYVxMgRMBor+gxv+Yc6dz=4ZnmkY7pNisdgf+sw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+SsUmNYVxMgRMBor+gxv+Yc6dz=4ZnmkY7pNisdgf+sw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 15 Jul 2025 00:19:02 -0400
X-Gm-Features: Ac12FXxN7RJK0DxX7gY9l-het2KmdBXCXUaAppQfTwj8hmQvuqtp4Zy4d8Ueo-U
Message-ID: <CAJSP0QXdHHYqZNDF-QM==oxdbgk=A-bJ9p2pZe55552jhPdYXQ@mail.gmail.com>
Subject: Re: [PULL 00/13] Ui patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Mon, Jul 14, 2025 at 10:02=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> On Mon, Jul 14, 2025 at 3:45=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b54=
3336:
> >
> >   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into=
 staging (2025-07-13 01:46:04 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> >
> > for you to fetch changes up to c99b7e6d4aa8bcc12d47483ebe81072168de56fb=
:
> >
> >   tpm: "qemu -tpmdev help" should return success (2025-07-14 15:02:00 +=
0400)
> >
> > ----------------------------------------------------------------
> > UI-related for 10.1
> >
> > - [PATCH v3 0/2] ui/vnc: Do not copy z_stream
> > - [PATCH v6 0/7] ui/spice: Enable gl=3Don option for non-local or remot=
e clients
> > - [PATCH v6 0/1] Allow injection of virtio-gpu EDID name
> > - [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option
> >
> > ----------------------------------------------------------------
> >
> > Akihiko Odaki (2):
> >   ui/vnc: Do not copy z_stream
> >   ui/vnc: Introduce the VncWorker type
> >
> > Andrew Keesler (1):
> >   hw/display: Allow injection of virtio-gpu EDID name
> >
> > Marc-Andr=C3=A9 Lureau (1):
> >   tpm: "qemu -tpmdev help" should return success
> >
> > Vivek Kasireddy (7):
> >   ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
> >   ui/spice: Enable gl=3Don option for non-local or remote clients
> >   ui/spice: Add an option for users to provide a preferred video codec
> >   ui/spice: Add an option to submit gl_draw requests at fixed rate
> >   ui/console-gl: Add a helper to create a texture with linear memory
> >     layout
> >   ui/spice: Create a new texture with linear layout when gl=3Don is
> >     specified
> >   ui/spice: Blit the scanout texture if its memory layout is not linear
> >
> > Weifeng Liu (2):
> >   ui/gtk: Add keep-aspect-ratio option
> >   ui/gtk: Add scale option
>
> NACK, will resend because when Spice is not recent enough:
> ../ui/spice-core.c: In function 'qemu_spice_init':
> ../ui/spice-core.c:673:17: error: unused variable 'video_codec'
> [-Werror=3Dunused-variable]

Okay, holding off on this pull request.

Stefan

