Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAE9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 10:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE3bi-0002y0-Gx; Sun, 11 May 2025 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uE3bg-0002xq-DU
 for qemu-devel@nongnu.org; Sun, 11 May 2025 06:08:28 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uE3be-0001d0-Gx
 for qemu-devel@nongnu.org; Sun, 11 May 2025 06:08:28 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-47688ae873fso39169821cf.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746958104; x=1747562904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4MEPByNXR+Ey6MC57DvOKt/2LFE/ae+wjUiuQQNjlU=;
 b=biVhY9zzyNKmwPmbamMtk9u2/QOOwEf3UgoI/h/0WfA4K+oPpMFYK0jwbOLqk2MzIz
 RzJvAhHxlqAxlL+LiFmqu2iBHuw6xrkXY2XNl4/DvZQLcW7glvXJFzIob21uzg76R76B
 EerA3a1dwOldbX8gyw7BAz3ATHjRaIqsFfHUiFF2cZse18h2vBj3w0UJs5rvHYDH5lK0
 WOZANqLNXlHOTkdVYDDslq5WoCJXtUAoOi4s3sNXqq84YiNWGko6regf1hCiSyO6S0o3
 c+ZuRVqbXw0UCtiQTr8jkHrmnR08VZ5RjmHbesoRuT8qDd5JXStySt/n1dSKQEGtwyoS
 nkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746958104; x=1747562904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4MEPByNXR+Ey6MC57DvOKt/2LFE/ae+wjUiuQQNjlU=;
 b=XLGLJyvDVN3meqdkYQSfLmC5lo8LnutwbBLURoM2yo/1tHs6hXvrJkqflwzQ86w0WN
 jqHxoXXovEbshrI3sZOWA4m3J1VBZED/7O2f7kp9BBRsZW7qpzc7d90ccbnF9jsK9nCU
 XU8QMIUwXrObHDiaLVS0bqXv/6i6oilzlKwtjMCBl/Y7Jn5Ym9tiUNSEf2Lm0eNsBDTP
 ftqFe/aPcLwSzxcvq8iIVkyxT9KIM8mgrLZIAu/Dcpgsm0KnyC7jklerGsLrRL2QiqaY
 5Zubsn17VNJcKdSIuQYjDPcZLF4xVUb9fBM+0ijkHNv3vhvxUW7zwR2Sbih3lDZ6lHla
 0uqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE72XB94RFWQqu0lkwTxbZcGuf+J23tNHbx+ENe+jmdJy1Hc3FMn4gh05Zi3HY2aYl1bB5Kc63LBPW@nongnu.org
X-Gm-Message-State: AOJu0Yx543vMFRRHeRXG1PodvCN4GdyVLODI00AxjN6G69oX66dzevfN
 2OfvdO6GRqaO1kmFF/mNHLobJSokRQpcd/Svs0ABQxnOf3PzT/RsEcsA3HAvzlxRBZr0G/tNHnX
 mBSvSwYbM8TWhUqDtvXyEwAd+FCo=
X-Gm-Gg: ASbGncuY2sC39p2yQotZwOembPLhHyfr7rJDSXlYlyb2+Z58bnnxiHsVrjEgC6ofKph
 wOpxJJIpbxfv6ZNj+o1J6kvHkC9qMnc3nazqHljtBxLxQtzrvx6aOFQfc2DRWvDshymleihK5cp
 p5msYvjRhy/xwecDJo5trBqCaphCokfZT9YGtYTZQV8Dqd23brtU30Vi3DJFaziESWUw==
X-Google-Smtp-Source: AGHT+IGphxoG5+R79UUPVOaS/kQKBZJRPo64EKhsLrNPOu1yqVj3pkJr0qMDehMwP4aFIjKxxLWfHqHszQj5z6bSQbc=
X-Received: by 2002:ac8:5d55:0:b0:48a:6af8:58a5 with SMTP id
 d75a77b69052e-494527639aemr132439561cf.29.1746958104005; Sun, 11 May 2025
 03:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
In-Reply-To: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 11 May 2025 12:08:13 +0200
X-Gm-Features: AX0GCFsblt6uEW6D2YYgUmb6rScbVNzCHZaba0tjPAZZ6mTjlqvp467VjjwCyoM
Message-ID: <CAJ+F1CKF+yB5vGV5d-PQ3Yb3BOzoLUOFZqp1AA0kFtG7CAELDA@mail.gmail.com>
Subject: Re: [PATCH 0/7] audio related fixes for 10.1
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

On Sun, May 11, 2025 at 9:37=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> A few audio related fixes for 10.1.
>
> The virtio-sound device is the first QEMU audio front end that supports f=
loating point samples. The audio subsystem is only partially prepared for t=
his. The commit message of patch 7/7 "audio: add float sample endianness co=
nverters" has the details. The new code paths in patch 7/7 are only compile=
 tested. I don't have a big endian host to test.
>
> checkpatch.pl complains about missing space characters in the type punnin=
g macros in patch 7/7. I don't agree.
>
> Volker R=C3=BCmelin (7):
>   tests/functional: use 'none' audio driver for q800 tests
>   audio: fix SIGSEGV in AUD_get_buffer_size_out()
>   audio: fix size calculation in AUD_get_buffer_size_out()
>   hw/audio/asc: fix SIGSEGV in asc_realize()
>   hw/audio/asc: replace g_malloc0() with g_malloc()
>   audio/mixeng: remove unnecessary pointer type casts
>   audio: add float sample endianness converters
>
>  audio/audio.c                        | 11 +++-
>  audio/audio_template.h               | 12 ++--
>  audio/mixeng.c                       | 83 ++++++++++++++++++++++++----
>  audio/mixeng.h                       |  6 +-
>  hw/audio/asc.c                       |  9 ++-
>  tests/functional/test_m68k_q800.py   |  3 +-
>  tests/functional/test_m68k_replay.py |  3 +-
>  7 files changed, 106 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>
>

For the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

