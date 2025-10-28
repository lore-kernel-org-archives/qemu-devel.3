Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE520CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkJd-0002A4-VP; Tue, 28 Oct 2025 10:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDkJX-000284-Kd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:04:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDkJM-0008Kw-0O
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:04:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b5e19810703so922828866b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761660266; x=1762265066; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co2Cq0Tgw8nNxOL7CcWgHb/a4macGftmYxRFNiuZn8w=;
 b=hXxTlJzcPql3ODrf2SDE4yRq9t158Ct+CoeNMhTShw/SCAON7ic4ys8awWEoAMJy9E
 uxVFCvtM/KbdiCQMXIDi3yXpd4lMVNGOGpi4W1MfO/nVjEXe+6AiutI6akeNNsaGnIfY
 a/Z7hhJyCkfS4eUoYf1YatKaeYPWC0bP0mQtmxGdWdkqUIfLHxXkjJ87vWXChbheoV9b
 1JSOOG6vkmq1heIIwZ1d8bOksE2jH8UigVOr+W9yGVmTIwXEPErgxicCFHQA9XVAiStn
 tIz/h8AYBY9gBqe+Zxrx+ziKBbvViiXPRCHRiPzkYIQFwPvivhbCxrIiXPJbesXFAu3m
 eYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761660266; x=1762265066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Co2Cq0Tgw8nNxOL7CcWgHb/a4macGftmYxRFNiuZn8w=;
 b=aVJwmDcS3PqsHYgW4mTQ55iez5bfbIXUauXT7xaQXcLynKO0eEwqTqpafMlPhfkONX
 1CWkY36d5FBhaFIFMWTkx4HCi0IZ7yz+vWjWAhdMzd2dHUNX9HOjqIdVuTvH3qTz49YU
 F7HzIjkVipbki/fglpw/k2E3KeVeQrL79BgtR2f8ibE2pNfPHGKuPUddHw4K5QTn/8vT
 rB14MEQlgTZqD/+oLBN/hSt2ftgu9i0D8wrc0RZ+FAbstbLJooJGAswqFTg/xjZNa4eQ
 1SJzkdJVZ8NtfzXifmf6QcV90NtsGd9iS3uuY2BtmUTtBTyttktNFsPhht0SGo7mWKiT
 RdMg==
X-Gm-Message-State: AOJu0YyZZZbcFYqBrxa3315GDYZy4Vr3ISP7M3idUBXotkToiOn789Rr
 Vp7XNn2TpYz5/uayiKjZ5P1uvu05gY0KV21wzoUrwvloBgh6dm4Rc8KhKOUdTSfBj1EhhbapSpe
 7z6f4bAJD0NhBmcLVq7mkTMVkrX/gQPE=
X-Gm-Gg: ASbGncuOaBZbb8uutNkwI9P3O+yQBqV8zzvzgP+8XZetnNQSY+JTdbgwZdUzOyJ03Hi
 H23uButXCBKTGnC8Mv45+gni9/yPe2nnDRB80jf94cSnyihpElgKY6A+xcNdOYbnoSknA9uTWuQ
 tLK5R0tK1+Z/ZlqQUiJYdAAirHlBQxooTB+5PNZA2RzQbxUO1QV6SXT3rsJUGs41RKL1WZi2fj4
 hlkHPB+1XENZgQJVDlsEiZbaFz+8IB2SZI+cJxoj/KfdnOWxT3UB7JPvC5WjjWn+mbWyzDmfd+D
 cDES09y9Lf9xlbnV
X-Google-Smtp-Source: AGHT+IFWlF7inrh2HYCSemjhxGpT3NH5gqeZbfGwYnSkxX1kBGJ5i+igiRpdwBkpxvUVaHPlmkDNU4Ecmen9qPnjaRE=
X-Received: by 2002:a17:907:86a5:b0:b4a:d0cf:8748 with SMTP id
 a640c23a62f3a-b6dba462ca3mr382536866b.13.1761660265696; Tue, 28 Oct 2025
 07:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-9-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-9-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 18:04:11 +0400
X-Gm-Features: AWmQ_bkM0YlfnQETuulnbLmCT2PCfl0rReaQoycthvvzyBKcepjG1PciI4KEv_s
Message-ID: <CAJ+F1CLp+frM+Mwwb3hq=8JOCnAsEQS_F=4GnN_gvw0aNqQ3cQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] chardev/char-hub: Retry when qemu_chr_fe_write()
 can not write
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x632.google.com
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

On Wed, Oct 22, 2025 at 7:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> When qemu_chr_fe_write() can not write to a backend and there
> is no error, it might return '0' to let the caller retry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  chardev/char-hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-hub.c b/chardev/char-hub.c
> index d0967c22336..4bbde9fb033 100644
> --- a/chardev/char-hub.c
> +++ b/chardev/char-hub.c
> @@ -65,7 +65,7 @@ static int hub_chr_write(Chardev *chr, const uint8_t *b=
uf, int len)
>              continue;
>          }
>          r =3D qemu_chr_fe_write(&d->backends[i].fe, buf, len);
> -        if (r < 0) {
> +        if (r <=3D 0) {

I don't think IO can return 0 and set errno. Can you detail a case?
thanks

>              if (errno =3D=3D EAGAIN) {
>                  /* Set index and expect to be called soon on watch wake =
up */
>                  d->be_eagain_ind =3D i;
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

