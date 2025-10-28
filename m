Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C5BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjop-00012e-3r; Tue, 28 Oct 2025 09:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDjon-00012T-KM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:32:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDjoj-0004Ix-7I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:32:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so117206166b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761658369; x=1762263169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5/bDuFb9njMVCZOzi760O2Yv8hdxoRK1eC/vDwEn9o=;
 b=f52a22wYjuJt+4KDlgT2fNBJT479632FM/WA0sSiWlzxigEpVGHXTxkSuezqKF6s+M
 KP7lsfRv/oBtv2cBwfSfH2b4Lr8dMb9AbOJ+H3tfX03WnczJhcxXGhf5t1D+PB+T2DkC
 brBHP2L0VXnw9booVZp732G7NPYqlgnc18zk3EJnvim6n48kVUaRc6P4VpR13eOyuIm1
 Ki5B4Q/axYtkgWWNbZ7AN0o2dih8M34k5VRd3k67b+ss1E69XONe7AUjh9eG0ZZSoMt4
 ZgyZtIkpXYBO2au1tWTt7u+DaiMzU9AfQwtET1+Df3+LrvlTSLQmevWe3+k2TgncfE7W
 C8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658369; x=1762263169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5/bDuFb9njMVCZOzi760O2Yv8hdxoRK1eC/vDwEn9o=;
 b=dNhOg4wzv6SyihuO9xNlxamqSX1JZmAbQbvhOpTP7Su3LcnJIM7HoX0mw4ogFJ3tKP
 8rB2fVqvBS3HcfvcYRWm0a9QZnXLkedxh1FphAyOV8uyYI5ukrWJgZN0PsRXCbUt27i0
 /XqXZSka0QqT69y/hhrCN7F+lD1DqI5cpvUsiXQJd+WLxwfF5NGYxJRFoDBCZOjJZ4tp
 RYFG4GCT4NFEJY/jM5ViV/QcNmtdeRS+Mjp66XCT8Z/K0wM3hSa3+6psbvzLTOq/MDVG
 5FB4dgC74aJFSmMKmGF8BDoF9wBx30/b7/J0V4h0BBt7+Uz7zxnfw2165Q+Ln2WtAaZo
 M64A==
X-Gm-Message-State: AOJu0YzhGfDneqC2grrnBgGmeFcN4xSoLxZg1t91W4dxiSazng+t9FAi
 TpzItdf1p/lhgI2PKbV37VDNcvAsAXkoUDmwQ9vrW9AYPT+Hc4W1KltivZW3Kzcc+gbj4sd/Cin
 Qs11U1BiBxYkogBBI2ER1Eez4NxzVxrQ=
X-Gm-Gg: ASbGnctvO+YuzF7g9CM3Yh1QMNe/fubv/cl7TdWCSBumhoPXaPtKO0kFwDNcSSJ9Xz1
 Zr8qVH1KqVbAPZEp3GrytN6e7Yn4z3Q1qfLcADn9+RIkSXS3zcj90Th9DxM3rumb3PCKMnmdJ/n
 60WTV67XOS8WI7Bnx6XtNAlTd2aYB4qvN5t43M/gw0bEPA7kiMs0pmpMBZ9OFC396BE+W93jMRG
 //mbClss0iZ8cBqSCrzTDubt3fj3O3jVG9Dm1iDlxN2kMffBzAHj1igh3Hzzsd6Hx4dvgH0uAyv
 yitKiN8Mcb9J9iYDjZVW7e6JYDQ=
X-Google-Smtp-Source: AGHT+IE2KfdSOP97V4K5DPWhD+1MiAClm1XZ6JsBte+V99xN/KlDtRyxEq5ffwjAySw7+Lstl6YnjgR+U7XwrAyGXbw=
X-Received: by 2002:a17:907:8e95:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b6dbbf4e7e0mr373630266b.16.1761658368803; Tue, 28 Oct 2025
 06:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-5-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-5-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 17:32:35 +0400
X-Gm-Features: AWmQ_bkeZsfmFKqhlsSM547hvTZ6gEzbonkNVizj6Tpz-b2zX3cD2I5jQLtj2e4
Message-ID: <CAJ+F1CLodiy5VcX8xAO0E_vAaYbqQBVmr4wE7F5Jf8La_G6onQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] chardev/char: Document qemu_chr_write[_all]()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x634.google.com
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

On Wed, Oct 22, 2025 at 7:09=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/chardev/char.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index d809bb316e9..8b1d5153dfd 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -223,7 +223,31 @@ void qemu_chr_set_feature(Chardev *chr,
>                            ChardevFeature feature);
>  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>                                  bool permit_mux_mon);
> +/**
> + * qemu_chr_write: Write data to a character backend
> + * @s: the character backend to write to
> + * @buf: the data
> + * @len: the number of bytes to write
> + * @write_all: whether to block until all chars are written
> + *
> + * Attempt to write all the data to the backend. If not all
> + * data can be consumed and @write_all is %true, keep retrying
> + * while the backend return EAGAIN, effectively blocking the caller.
> + *
> + * Returns: the number of bytes consumed or -1 on error.
> + */
>  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll);

extra empty lines would be welcome

> +/**
> + * qemu_chr_write_all: Write data to a character backend
> + * @s: the character backend to write to
> + * @buf: the data
> + * @len: the number of bytes to write
> + *
> + * Unlike @qemu_chr_write, this call will block if the backend
> + * cannot consume all of the data attempted to be written.
> + *
> + * Returns: the number of bytes consumed or -1 on error.
> + */
>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>


Mention that "errno" is expected to be set too?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--
Marc-Andr=C3=A9 Lureau

