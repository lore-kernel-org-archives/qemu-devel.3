Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF1FCD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxM2-0005ZR-LV; Fri, 29 May 2026 09:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSxLz-0005Yq-Sl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:34:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSxLy-0002x2-2L
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:34:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68c3421b009so596662a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780061660; cv=none;
 d=google.com; s=arc-20240605;
 b=Co/Z2pZpXmz7TOVBOGIFM8CMTFm/NrhkNchbfta1L+GTzfmWRHUOXFs8WtfmwNVY+I
 lRpsRIES+e3jp9uYcf+4ZftWBhdSMlp4vkxIjubtgmPnp/rBHzZhQTFQRK+ndEw6EHFc
 LzrjPUbbUsfldpe3yNhekRYzgALPy7JJjGZy4Wz2SMsLJEhz8gmcAdBZgrkQwP6syNaV
 9mAmt6+QYQt+ZRXgM8YBjv8i0vtiuY6s0fmfOytuHyH6kD2eC/nbhLGs4x/1AkTrex7J
 u2EOedlHremu83JZn7yRDovdKx2KtYeZHbRbMEQ9nA1E1q08vVYWMFBBjHca98XHakMv
 RRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RCP3boqmL1CksTuFPZhWSiyCMF7pbsCfQ64nyoU1SZA=;
 fh=TpNiJu7eWjoj/sj8B9ppLGSr7HqVokMiQY3poZNBRDg=;
 b=LEKHMCbKoHCMAyrzFDGe2Vwfbf080Ee8p1v2sR/IMiqJ9kk3A9ltHpDAc4uG58z2S0
 /trrrWRZFqOtZRJL8iyK1W8NCGscKldh0y8y+MeBrHl3wbzxUcbe2FsEXgdOA7c66ON5
 RmxeZQHlOiPX3rSC/0GpnJIVWacTXkaAVktKlrJeRYPCUz5g2F67pAhdTR4a2jPCtdWV
 Pm7cB+FOzU3NglB7V0hoySgC9GToGPGqEywSYhThxZ544xDahjbgTFq0ulKMXsgwSDtL
 N4StXaWUHPBe/J+AxUlcMpNu4j/bBbsz5AC1ZiDEGn/itVVBoIr3OHH1pH953MyZljGi
 zaKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780061660; x=1780666460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCP3boqmL1CksTuFPZhWSiyCMF7pbsCfQ64nyoU1SZA=;
 b=JFQDSluTsrcjT5SgnUhGhXacwQSt58GwKSjaGBwN/8NnkgoXJELO2nK4CougrqFXXT
 YrWOnbcZgogcS6swdU+LIpVBP8mu/LhlMwLKXRuI2eIUPwK0WW+FcdZCMXn5UCCKPGXm
 MCdk1cVHC3mluAPC80wfwoJ+dh7CbUiOTZLxFk6PUis7jqaY+NMhg2EVBJIMk+YBYM0q
 QkrOx7ujWB/Gl+NNqTmVU3FJA+EJK0rUuOE8Ww5KreNOf+YHcGJAN0TDQ7v/c5ZwIKzj
 p2/H2Fpdyn/UfLcGltMN7KN/A1166RVe92C+AxhnXCOSfL5ln+JkilGNXSURpaYp6dLL
 wW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780061660; x=1780666460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCP3boqmL1CksTuFPZhWSiyCMF7pbsCfQ64nyoU1SZA=;
 b=DfrgtLXM4xA3+F2QzExztss2kMt1z1amt1qP7f/ONRkiaqzTNecNt4C2XguyTa/lQX
 glRdBza9flVzFa8Vybi+7F0Vm8oRV2cljpi1guM1lO1E+5427ub2boQMeOqEysSOq9Q6
 +OBQxdztgv+vg0NiZ8RT0Qj7h5kERKRXbA6z/YY1rmoViFayavR0IFjls6LjTudgHpOK
 VvQfYCTwIF5KsuBdtcoaqe0f2VX/rSzBdxF5c2S2az1/CafKTFCzKZq1MLl3Ud1ZiWKB
 2OTk8hM2yiRdV8EELoik7MUOqMfRLPeaEVpdzsXSCofVpexdZGwmIfGNTHZNrff6mgaS
 m8sQ==
X-Gm-Message-State: AOJu0Yxv9B8aCX+k3OtDzI7Q84aNOg8iLqOyk+c8es3qkfRTviCL7JO8
 1fuqlEd8aFYXMAaQFbUZzqEXaS9BEbb44R4y/5ZkiSBf+fxCVdHXgB4Zt5qDPD/GpacAgL3+cw+
 gwfN7NxDRN+roI1dgN4Gd+PwKm5rg1lzaWAnSgwXDU1gn+xzEwWfHw4U=
X-Gm-Gg: Acq92OHOXqh6FqsIRRLWJ6+AkYw2kWxj7M5HS3ptWvtIxFy+BhJzbU4joQNzWvbvOP7
 gZmatdwAtp9r3UDQuJeQ2VQssyjwR25v5YmAE8qRaShWbeUg3RHK2dJJX6QtktiJkk49S+Ko3UR
 cNrxfeFWYSZEYbW67xqjJGlyN1znrvgnAFpzg+qdDaccTv99du8sRZF79cHVPpvbjGUvBNMZGRg
 XAxhH8Zn41VXP+cfqcXrdCRoQk1uaLjOLBSr93+WTeS1t0k6iOQSk04hxrQmkiaOWRS7rhhJS1A
 G0UWPTE0zizUfyCChqy7cXd8YOEu3xzoBGU+fJIOfhcUq7m6fUZ2e/dH/OvQGAv6PF4ri4mv5Qj
 HKw==
X-Received: by 2002:a17:907:b80a:b0:bd5:1605:e1c3 with SMTP id
 a640c23a62f3a-be9ab50fffemr127126466b.1.1780061660106; Fri, 29 May 2026
 06:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
 <20241014133935.470709-19-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-19-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 14:34:05 +0100
X-Gm-Features: AVHnY4KgYSU0LKlszf5LKKjEh9FpBdxkmhPlASDS13IURAl0JBdqBMTLQgJqv5Y
Message-ID: <CAFEAcA9kBAUESA+ATfYLM8bPuNJ6xB_HLPAp9SrsuQ4LP4m_dA@mail.gmail.com>
Subject: Re: [PULL 18/20] ui: refactor using a common qemu_pixman_shareable
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 14 Oct 2024 at 14:41, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Use a common shareable type for win32 & unix, and helper functions.
> This simplify the code as it avoids a lot of #ifdef'ery.
>
> Note: if it helps review, commits could be reordered to introduce the
> common type before introducing shareable memory for unix.
>
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-ID: <20241008125028.1177932-19-marcandre.lureau@redhat.com>

Hi; this is a rather old commit (now 1ff788db9781615b in git),
but I have just noticed that it seems to break the usage of
qemu_create_displaysurface_from() by hw/display/xlnx_dp.c.


> @@ -517,14 +482,25 @@ DisplaySurface *qemu_create_displaysurface_from(int=
 width, int height,
>      DisplaySurface *surface =3D g_new0(DisplaySurface, 1);
>
>      trace_displaysurface_create_from(surface, width, height, format);
> -#ifndef WIN32
> -    surface->shmfd =3D -1;
> -#endif
> -    surface->image =3D pixman_image_create_bits(format,
> -                                              width, height,
> -                                              (void *)data, linesize);

Before this refactoring, qemu_create_displaysurface_from() always
calls pixman_image_create_bits(). That pixman function allows
you to pass NULL to mean "allocate me the memory for the data".
If you do that, pixman will always compute the stride for the
data (by looking at the pixel format and the width), so the
input linesize here is ignored. The xlnx_dp.c code takes
advantage of this in calls like:

        s->g_plane.surface
                =3D qemu_create_displaysurface_from(width, height,
                                                  s->g_plane.format, 0, NUL=
L);

> -    assert(surface->image !=3D NULL);
> +    surface->share_handle =3D SHAREABLE_NONE;
>
> +    if (data) {
> +        surface->image =3D pixman_image_create_bits(format,
> +                                                  width, height,
> +                                                  (void *)data, linesize=
);
> +    } else {
> +        qemu_pixman_image_new_shareable(&surface->image,
> +                                        &surface->share_handle,
> +                                        "displaysurface",
> +                                        format,
> +                                        width,
> +                                        height,
> +                                        linesize,
> +                                        &error_abort);
> +        surface->flags =3D QEMU_ALLOCATED_FLAG;
> +    }

In the refactored version, although non-NULL data still
results in a call to pixman_image_create_bits(), now a NULL
data pointer means we call qemu_pixman_image_new_shareable().

> +bool
> +qemu_pixman_image_new_shareable(pixman_image_t **image,
> +                                qemu_pixman_shareable *handle,
> +                                const char *name,
> +                                pixman_format_code_t format,
> +                                int width,
> +                                int height,
> +                                int rowstride_bytes,
> +                                Error **errp)
> +{
> +    ERRP_GUARD();
> +    size_t size =3D height * rowstride_bytes;

This function assumes that rowstride_bytes is not zero,
so the previously-working "pass 0, NULL" now results in
a size value of 0 here and an attempt to allocate 0 bytes
in qemu_pixman_shareable_alloc(), which winds up triggering
an abort in qemu_memfd_alloc().

Presumably:
(1) qemu_pixman_image_new_shareable() should calculate the
rowstride_bytes as pixman does, rather than requiring it
to be passed in
(2) qemu_memfd_alloc() ought not to abort on zero size


For a repro case:

$ cat /tmp/xlnx-dp.txt
writel 0xfd4a0194 0x00000780
writel 0xfd4a0198 0x00000438
$ ./build/arm/qemu-system-aarch64 -accel qtest -M xlnx-zcu102
-display none -chardev
file,id=3Drepro,path=3D/dev/null,input-path=3D/tmp/xlnx-dp.txt -qtest
chardev:repro
[I 0.000000] OPENED
pulseaudio: set_sink_input_volume() failed Reason: Invalid argument
pulseaudio: set_sink_input_mute() failed Reason: Invalid argument
[R +0.121066] writel 0xfd4a0194 0x00000780
[S +0.121092] OK
[R +0.121096] writel 0xfd4a0198 0x00000438
Unexpected error in qemu_memfd_alloc() at ../../util/memfd.c:143:
qemu-system-aarch64: failed to allocate shared memory: Invalid argument
Aborted (core dumped)

thanks
-- PMM

