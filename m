Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FFCF3C9BC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvMb-0006rO-IM; Tue, 24 Feb 2026 11:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvMX-0006r3-4q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:34:17 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvMU-0007CP-G0
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:34:15 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so815771466b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950852; cv=none;
 d=google.com; s=arc-20240605;
 b=V0qh0o/Ta+8uY1TmIDgYALGuiZOvz2pWvcfG4dzUMxtcAz3aqEuHB8beS9WHVgEEC5
 m8noNodFtUbq2NMCEZfjUUALmrFFqnoLL7hnpFpEX2W4/J2YEzptaqOod1MfkfkYE8TO
 FVWMY8wW5slacVbJRTjojFJZAMVNAI5Gqz1uL34eZV1ok0XlRZD9jjn3oxtYUGUhfe90
 tK9pdlp0RPnLdUi/UwE3K0M6VUvXX53ICuDR1r2oBJLeU82x93hLC6eNteM4adkwXa5H
 i+Ebsa/mREZh3v+2cKiIiLyMbUbGglX0Y5i030fqoLHUePp5srAMKSW/1N8Z0qMfuDFH
 Sz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ql92CPRvfuLtju3hs4yhS1ZBNZXR2nMezx24h7yv0HU=;
 fh=kL/ngBt8EPGU8+6uaRQ/ntBYkR5vo8tU1gZCgq7YGG4=;
 b=BLs3+trhIGqx834iuGGx9l7EUCqKXYUVTxS24Wk4d+9bzXjhfAF7c4R6Tf5//dyZ8/
 nspFErcrAek4tIbEl76qGAb+zVAYJMXfU2YmAowIXQ1/WMdr74QXuOvNy/LOdZga1mrC
 eNv5Dzx3rKhHtbJiQsD3vm3S7LGelb7k5dYntVw1xcuL1QJuWXtGJQo4YCawFqBjj12X
 kpDPCZubDMvEbomZ+aSw77HzD7ePNPrrQb4Vphe+qCHmbv65gHbd933iDza+lWH1OiCO
 A/4/bAYYRMYarPPyl8aF1n9t3y2vPGKVbwbEvBkSeotbUMoPFfnjylR74VyyhNGL+Xbf
 gGQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771950852; x=1772555652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql92CPRvfuLtju3hs4yhS1ZBNZXR2nMezx24h7yv0HU=;
 b=mHzr53jPD56emhq4SCZje5F/4huzSzB1N04qcou9cOU4KRbZP9Mp9JHlRogtX7FtF4
 eywXnLwHO3wGHdPUmlWXe1M3QBJbmlG0dGzT21n1X3FhK/TyVU1T2xcG3nTPkZ7yD0ch
 tB/nR6aFyxA3gw0JBDw6IBtI1VTHKpiw/lUgOO+hgAigRvUXqs2NI0ep3EbxGr9XRTlg
 UkxrKICGxxRxh+y6575B52hEhy8hfYpJ/g3GZDCaP4LfcTQ4yvTJYOx5YYB1izSGeAX8
 naj8F4BKaIsKmAsMC4v0jh2T/GkDfoYwPPxDtrYR4+eW2hDlKSvuREfUTqLHC6FrA4wO
 LpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950852; x=1772555652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ql92CPRvfuLtju3hs4yhS1ZBNZXR2nMezx24h7yv0HU=;
 b=epS4SRFRnXEl/E+Vctr76GS923VzQxE61sY+/RjnQsPtBEmLrA2c3HCKBmPHqMjO73
 Ke2Ecn/Lu8QBN/k+BsVJJTGfK8xG6iZU6p5+JA8yoxRluD35U7A0P9ObJfaGOVsfqk/W
 GSmp/RT11zgzpBRVZ5NA2i6WU5SOOL8/J61UIgJpYL5bFnZyXzRHB/tvioykVveF8gHA
 xVrPJSYcTFtSNRE8HPGO+LzNtlmA3mM1NJPWDkb4VbEGO3xQDuJsRT84JvVpTwlofx8C
 heLO7qrV/Ad0V7n3wmf2CdtzdSvy3/H6mxxPZk8QzBE7w9n1XmSg8DUcQa05eHzKfSy7
 pa0Q==
X-Gm-Message-State: AOJu0YzVK343SP/PajZA7QAJtMQ8uVjBHUWok0Bwts+xqXBVz0asEnkv
 rcJ9XAkK1t2shmFU3GOcOhfY7ZTi+KUWR0ga8bAkr1zPeleNXk6757aobYQNmmb8o6qPNgMqCw1
 wFAtiXKZjPZM9rracDtrQzVNnka/d6OUMKD6BH5rbpoKkHdSpnwyA
X-Gm-Gg: AZuq6aKnAMGOnI9W2h+qhsyCCknmxSZZlsjITnsfBj3AMYPgZvn0I3s/2vbhZDDkRHv
 Bi2WS7xrVFagIaHTGKyADoXyjrEhpJysq7uR5uG6zdOWEQaHS5NqmTAnBj2ghCr6mUOR18SXn+m
 DW26afLwctHJrq4vMNswMKoiXIEqCNuXFo2Cm6ZWxd3UryCB1pC1nlRopuzIqW9CeXvidT6tkoA
 sBPdh7yXhpZQuZ0XxM0NDz64u6Ly5Ygpt6AT4l7n9DNIUPzXjdw+P4PhQyiITfmDlkf7ldPgewN
 utKuVdzMAzFo6I1rAZbTHzxFuyums5o9psGmk3LyKh0np2eeT5P+AUKKB0Av1IfA2DU=
X-Received: by 2002:a17:907:3e8b:b0:b8e:a1a7:1a98 with SMTP id
 a640c23a62f3a-b9081ba7e5fmr819062966b.47.1771950851523; Tue, 24 Feb 2026
 08:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20260224163229.2918858-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260224163229.2918858-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:33:59 +0000
X-Gm-Features: AaiRm53LxZNrCB-Y-1exOMnhdBipr10t0lcgy19g3nWkqux2LE-sZGDdihNtikE
Message-ID: <CAFEAcA_Y2kUPQhVG0UoSWtT8RqAwE=shCWLDbzaz-EjVRW6tZA@mail.gmail.com>
Subject: Re: [PATCH] audio/mixeng: drop some needless checks
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Tue, 24 Feb 2026 at 16:32, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The NULL checks for be, name, callback_fn, and as in
> audio_mixeng_backend_open_{in,out} are redundant: the callers
> audio_be_open_{in,out} already assert that name, callback_fn, and as
> are non-NULL, and dereference be unconditionally via
> AUDIO_BACKEND_GET_CLASS(be) before the call.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio_template.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 228369cf9a1..fe769cde667 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -497,12 +497,6 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>      AudioMixengBackendClass *k;
>      AudiodevPerDirectionOptions *pdo;
>
> -    if (!be || !name || !callback_fn || !as) {
> -        audio_bug("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p",
> -                  be, name, callback_fn, as);
> -        goto fail;
> -    }
> -

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

