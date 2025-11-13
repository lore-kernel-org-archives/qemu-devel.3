Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E059ECD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUrQ-0006Gv-Bq; Thu, 13 Nov 2025 05:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJUqx-00062H-Vu
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:47:11 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJUqv-0001tq-MJ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:46:59 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e1e1bf882so501201d50.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763030814; x=1763635614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaB6ghXtlKE7aFOdY33OgqwnR+yIoT+NLjn+UxnfuLk=;
 b=ieSxp3u+KC3XwrNgrsYucDsKYBcFi71SNU3VdPpaZ06XCQL3crOB3Q2U++amrsi9sj
 zwxgr6N6PhCVFT1hLQ7iFo52lJP/C8ezV/iognKwr1t3nXBOWYPxetcjP/Q1M5vC3LQn
 d5+TIWhG3qy9bDPnsPZB3jCGVILb/iSq603jE+RFBwDOTCDF4wcqlwY1hJwjzI2pQTvP
 Qp0FM74/UW/MhieOu2cpOgeUbNUc3+cl8Pv3M/uYAigfk1z5YdjI1iWbwWNmAW87guRj
 TMPhZ4DTDXrbnWfS9teiaTvZr/wpNsEQek+43Kbx3XCUS4kUcnX3CN3fHS4Xv4WEfesn
 299g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763030814; x=1763635614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IaB6ghXtlKE7aFOdY33OgqwnR+yIoT+NLjn+UxnfuLk=;
 b=TJTO4drA1uIvV4njH0HkBZ6Q7OJBACx0p1jz8A/1v1Ez+z+pnX3ciZ1fpi+ceRRQE8
 LO+JCPCQsFiZznAF8m4Gxf8JEX3Z5K+T7t4e5cYOakzaHxAqAEGIEHjgmdXc+LBrTSDU
 fIZ1qp1J4uprM0LbS0Q24dQGi0lK5DDx4XcWweLgQ+d37Iy0/lsMc/zO7Dwv0UhzzVcT
 YRkg5uKMZcF/L2a1BZ83mMkTvr/iq2zGN/VhbwPOD94EWf2V8GOelFN3Dplt2ZZH5Cvu
 rWHb0svEYh42N7vJ66PAvs4Bw+mqjHuLusCd6AOq70rVbJfz0gAjghvBDI47EVuqDh/7
 168A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTO5SY4vCbGYrqas1YdN3gbaRzMx925b0v/cfe3do7YRsa3M4OhMYgCwL6P7d2/+NoskjGGpGERL6x@nongnu.org
X-Gm-Message-State: AOJu0Ywqx/oBIUg1eYr3w5dXIGjVrHZDMHBFFrmy5Oxal5jxrl5YzdC6
 VWA9YJcuzREhkxOF3bttcbBJtf+exjPaCigPQ8OE+f+Xr6apdsXNXfO/V/ENJ0q8ES7rfVnlZ2B
 +Kg+ZCz7FXT8+Q0hT5UQAsF1B6PWK2mpnB9oukDpHlA==
X-Gm-Gg: ASbGnctHuP+AwlvbGTOZX3DzHA1vtzJvj9ZvoqNREuYVsrwbk6hFIasimZMFPNPyqfI
 LqYNnm5AsQEoF8nLkzHMIJ5cK110F3EEqVOBXzeFKwPc2+mri87tfOitE5l45ABrOhQhQkK5UEh
 aowbi/QXGWtSLZ2ijKPZGKZ14ySJP5Frv3CtF1utjU4klklZG/LBript5G3xtYp6zbuKiIkcTbL
 jPNc5OotIZtUbPbDISAxR4dwY7hlMrSqvcllamXQA0utA/ZnRZ4+XM47aORcnVFJ2p1qIPz
X-Google-Smtp-Source: AGHT+IHOmENCcv3g6dRuoT78LyKFLpYroa5t4jciXREpubmouPDyH8uT4rYc+PfcZ3xKRc7tovbGpaDEenLxbsJTx4A=
X-Received: by 2002:a05:690c:a08d:10b0:781:32c:b359 with SMTP id
 00721157ae682-78813683a6cmr87761447b3.36.1763030814069; Thu, 13 Nov 2025
 02:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <aRWgdCWsEr3cCSNl@redhat.com>
 <84b8a084-d8f3-4515-a6f8-23aaca080b37@yandex-team.ru>
 <aRWz63pC5fsdYRsq@redhat.com>
In-Reply-To: <aRWz63pC5fsdYRsq@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Nov 2025 10:46:42 +0000
X-Gm-Features: AWmQ_blONuV9I2eknWju1jYBsPP1I4SFyTCSDzKDOdiWhhGpv_GBHG6RWo_3LHg
Message-ID: <CAFEAcA8433bHWqbb0cC2myY=7NKqPb1M3r+y3_mXH=QQuCoYJQ@mail.gmail.com>
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 13 Nov 2025 at 10:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Nov 13, 2025 at 01:20:15PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> > On 13.11.25 12:10, Daniel P. Berrang=C3=A9 wrote:
> > > On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> > > > Test, that fix in previous commit make sense.
> > > >
> > > > To not break compilation when we build without
> > > > 'block', move hexdump.c out of "if have_block"
> > > > in meson.build.
> > > >
> > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team=
.ru>
> > > > ---
> > > >
> > > > v3: change meson.build to compile hexdump.c always
> > > >
> > > >   tests/unit/test-cutils.c | 43 +++++++++++++++++++++++++++++++++++=
+++++
> > > >   util/meson.build         |  2 +-
> > > >   2 files changed, 44 insertions(+), 1 deletion(-)
> > >
> > > > +static void test_qemu_hexdump_alignment(void)
> > > > +{
> > > > +    /*
> > > > +     * Test that ASCII part is properly aligned for incomplete lin=
es.
> > > > +     * This test catches the bug that was fixed in previous commit
> > > > +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
> > > > +     *
> > > > +     * We use data that is not aligned to 16 bytes, so last line
> > > > +     * is incomplete.
> > > > +     */
> > > > +    const uint8_t data[] =3D {
> > > > +        /* First line: 16 bytes */
> > > > +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello=
 Wo" */
> > > > +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! =
Thi" */
> > > > +        /* Second line: 5 bytes (incomplete) */
> > > > +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is =
" */
> > > > +    };
> > > > +    char *output =3D NULL;
> > >
> > > Could be  g_autofree, and avoid the later 'free()' call.
> >
> > I'm not sure that it's correct to replace free() by g_free()..
> >
> > Documentation says "bad things can happen" https://docs.gtk.org/glib/me=
mory.html
>
> Note where it says:
>
>   "Since GLib 2.46, g_malloc() is hardcoded to always use the system
>    malloc implementation."
>
> I added that guarantee to glib docs specifically so apps no longer
> have to match free with g_free.  You should still not mix up the
> C free vs C++ delete, or  free vs g_slice_free, but that's not an
> issue for QEMU.

I think for this specific case (the buffer allocated by
open_memstream()) it's probably better to use explicit
free(), because the criterion for "when is it OK to free
this?" is not "when the pointer goes out of scope" but
"when we have called fclose() on the stream". Auto-freeing
the buffer by returning without closing the file would
be a bug.

-- PMM

