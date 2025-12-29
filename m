Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5989D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBOo-0002Ln-Qx; Mon, 29 Dec 2025 06:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOj-0002Ea-5O
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:49 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBOh-00073b-LD
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:26:48 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so1330176866b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007606; x=1767612406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sujQYxmQ0g1Ge3ybsrcsZi+vhgSfPpCI44RUfYPFics=;
 b=Y7Bj/bLhHsRANag4bB5yfzwI2FnvK2dIMQQvE8/XRrUpmLv9q1nOKPRMOPeJlrjxVo
 RoDnt/hjfhv6vTgbwKbnwTCPnHY0BrULu5CtQNGV9wfZG6yARokT08L4cPnmYGJoCxUn
 I7bZNW2E/r5fRY11s85Iyea/AgElRuw2dLbMLQbHGyHTHSp4ZqGhnLrqeula7bTxYVzr
 yAKNYPwqp3MwNmxYx+Urb27pV6M/KWQI+qFEKkgF8a51BwOzApeUmyznwOYJ1XN9Pb/k
 +zDBND7PyU5uFCz+2IxoyCJv95aJmOJt9w0L7pjxXppmCfMhKlO8RaV/8UiMXdBHDP3N
 Gpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007606; x=1767612406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sujQYxmQ0g1Ge3ybsrcsZi+vhgSfPpCI44RUfYPFics=;
 b=wLDICu20760Qd3Ie/4pX2DBsmtBRx3+v2zHUdO4xug4Y81y6ovGMfwaQTF654UDadE
 E03jUqh76Bg7EvEN5KtXsFDoQZyh0BKJOaK2/N00jvOh0qB006mikhWscbS7f8ogSgLc
 cr8/X+61EMad7ik0nprSW35VgOhvWRplWNbhOM1BgablR1pD3P95hYxbVmcaA16xVv0J
 dmrab9P/pesSeOYZDGDY0MQaYqou4twcGEEauDUYBeEHd4yWAkzbtIbvvs0KxUP+0oMW
 K+wcL3Nr9HFA8oFGOnngD7AHhgqwuJAWZ8w3/QdN7BC+0e501ERM+p3I1xLjTJ14w2M8
 V6Pg==
X-Gm-Message-State: AOJu0Ywcikym3bTRi1LWt1OaH1BnXqy4x5yxVVkqUd1UfCsKix1nvDrS
 HGTYUAGz3Tg7z+udcNQugf8yTGmWOYIzz25BiQ4/PbMYOG3PyRpzmQuTv/Ax76mgL7LyWypn6fN
 IF54gvt56qx9lkdp5pMY2pYNGy83LYZIsxmAbzIx5Xg==
X-Gm-Gg: AY/fxX6oYYiW3Xjqp4whxKkXo9UBt2fZUF/VrS2S6FbSFvYhTMvuC6DXFh7Nxc/5YTn
 f8aufgixuEYeyJFstjQf6eEYpYi3FH0GCss+Ra8b73q2M2ifC+us3dknFd0DicpdMRcnUhh27jL
 ysHB99e6xTKNdQMozfuKC/iW/UekF2Bn3P4LgB3u8UNX7RzzfWcHH6xslUeMHk+/ag3n0X+bPgh
 sj1sUnm1+IYK8CBDLmXRi2r/y7hZsb/7Ty0A7eh6EHDQ96LnA2RPU7xTdvLQ1OrFsBzlz8cKhEL
 zOjsOezH3iFF7HU/2Oph4C/FAGBrGMHesl+K9l4=
X-Google-Smtp-Source: AGHT+IHgOd9u99ufl4VYvkUOjxGU+WhBNw6IfFEZZz0wRZC2UnCor3PXB+vyoIbXzNSppd9eGlQtDBS6WayWI3NyYQ4=
X-Received: by 2002:a17:906:fd8b:b0:b7f:feb0:3ebe with SMTP id
 a640c23a62f3a-b80369644d7mr3109556766b.0.1767007606077; Mon, 29 Dec 2025
 03:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-5-philmd@linaro.org>
In-Reply-To: <20251224163304.91384-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:26:20 +0200
X-Gm-Features: AQt7F2oAxK5JPKPjGG3EHSw8NjZKRIGPehf8L03h7epTVcV1mSoZoW8s9QaKOTo
Message-ID: <CAAjaMXY6EDxckjeAScHuWrrNe-88TruV7up0T7Z2VOgJtKNN0g@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs/targets: Forbid Renesas RX to use legacy
 native endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Wed, Dec 24, 2025 at 6:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The qemu-system-rx binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Preliminary commits allowing this final change:
>
>  . 0f4af4e2672 target/rx: Use MemOp type in gen_ld[u]() and gen_st()
>  . 2062fa663c0 target/rx: Propagate DisasContext to generated helpers
>  . 8b71fd6ffec target/rx: Propagate DisasContext to push() / pop()
>  . 363fff6d1b1 target/rx: Propagate DisasContext to gen_ld[u]() and gen_s=
t()
>  . cb8e4556d58 target/rx: Factor mo_endian() helper out
>  . f9903a8a23e target/rx: Replace MO_TE -> MO_LE
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/rx-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.=
mak
> index 3a90f1b9977..281a165873a 100644
> --- a/configs/targets/rx-softmmu.mak
> +++ b/configs/targets/rx-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_XML_FILES=3D gdb-xml/rx-core.xml
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

