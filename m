Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FEECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gPM-0002u6-Ju; Tue, 14 Oct 2025 10:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8gPK-0002tt-P9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:53:46 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8gPI-00033l-Sv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:53:46 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-85b94fe19e2so6737085a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760453621; x=1761058421; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPYcPVss+ZInAj5PyUzc77++aE65+DP0L0L/6+FxU+g=;
 b=kOewxGqbmm51oW/N9ioS54YNq+2PcpejbSu3PpN9k+g+Z7RNB13WevJohgHWy7YxZ9
 JobM4orn2z67eRBWmR14yKRcim9C7eAFtgCHDd7vmF0MQR7OSmTXtAU7wqkgpRrzmI9G
 2pzhv0SAgfoo2cgsxyQSCM/vPEMbAR49dvUVcjSkDhDSr+bMWQWFQtQrxKPt9QufBtm9
 sBKhK9yr4qZJ/RvIXdft+TOOXWCG2DxVzKjZ2nqfMUvsbE7Pz1rMDquT5xRn9IGWlJIa
 ClgREjvAjSCzRgneXAcdzZUTNhNdmvkpTig/oqLkljyCo0fxK/N2qxWwHuXMys1jjaO0
 HthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760453621; x=1761058421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPYcPVss+ZInAj5PyUzc77++aE65+DP0L0L/6+FxU+g=;
 b=QBKHSTA37ipezgqmxZozy4+s6nSmVVu6WD0kY5YVR6Cgq8ibgriVUyIKlrK0cSalIc
 gIFxQXCBBA+cc6ar1IAxfpOhy1EaCfbcjDVLd3+BQV5LzT9F4BUnJut5CP2JBnij7cmm
 h/qGK7eR0Ji8DbOAGGKXmWlWj8PDC743Mmra4WGQX87KdhTk/unzRmOlJCgXHUq4Sd0m
 5BqwZsmT1Zay+a27vWegvp4kDm97YHpACASVRJymqHXSKCMuMIn6XyI28ZtYIDcyk+bJ
 RH8c1v07npAKdJ6tht7QmfknXUVQmjqAmaY6hQGnnKwZFmupSyJSKkycEfGT5Qtb5IhA
 o3KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0LjZCx8+9E472ASvHoBFkpKaYQsgVdmTzY6+sjy9l8nLFdUNqTpBJxaIk1GqwseOUHGhKL2vJAImS@nongnu.org
X-Gm-Message-State: AOJu0YxXTokM+hBr9q9USBm1+lw603cyFKip+ngP02F7smVHITnsp78q
 nB5wBnUhnToFuOzDlhsS1oor9dzuZxZfpVGt5Z6l8PRLbQCyfNGI36+FNvVj9q3bP7ew3U95OLJ
 1nzZQ5ac3zRSsMIFUbi/+aPT6JaQA8s4=
X-Gm-Gg: ASbGncugIbH/pYeNkuNgKOzwsqyEmBKfaKhb/5TTybL2w+ZyoPVZxwXQ3fl6zJe1b15
 dXcnp52IfVScjywLDfrlPeRy6rkwgY+jGPQ6BI4DmScp1ijfPvtB7cLTCzpwaoR13urHSCSFj7a
 UyN7v6MWjZxfRGSeOuUVrqr7re4BB4wjW5MXoq2iPz8BkyxlUstKHzPjfuqEJMUOKQgZIDwP6og
 QuVWqshaMh2KhhfKSh6S/Z6I9QlZFunPGKZnElr9tlZ9mUI5Tf7jtjWLw==
X-Google-Smtp-Source: AGHT+IG+V3Th7dbqPoc0tPNl2AW8gDkMidxZKs3gzdy3RP3l9cbbCFFxcDCSs6v7K2Oa3Z0Y9hQ1tRGiWL6kWJUm5w8=
X-Received: by 2002:ac8:7f09:0:b0:4d6:7286:7524 with SMTP id
 d75a77b69052e-4e6ead625a7mr321734631cf.61.1760453621490; Tue, 14 Oct 2025
 07:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251014145029.949285-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251014145029.949285-1-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 18:53:29 +0400
X-Gm-Features: AS18NWDxGH9BOfO8XXcflVs5fkBCEpdTPUAwadwH8xFkcEEwZW_PJ3c4UyoT00g
Message-ID: <CAJ+F1CLis2mgWw4R+X1+5MhhuQ09OTCbWsxZgqsx9VZSP1CfNA@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-file: fix failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
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

On Tue, Oct 14, 2025 at 6:51=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> 'in' will be -1 when file->in is unset. Let's not try to close
> invalid fd.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Coverity: CID 1630444
> Fixes: 69620c091d62f "chardev: qemu_chr_open_fd(): add errp"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> I was going to send it inside v3 of "chardev: postpone connect", but it
> seems the discussion may continue there, so, decided to send this small
> fix in separate.
>
>  chardev/char-file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 89e9cb849c..1f7adf592f 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -94,7 +94,9 @@ static void qmp_chardev_open_file(Chardev *chr,
>
>      if (!qemu_chr_open_fd(chr, in, out, errp)) {
>          qemu_close(out);
> -        qemu_close(in);
> +        if (in >=3D 0) {
> +            qemu_close(in);
> +        }
>          return;
>      }
>  #endif
> --
> 2.48.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

