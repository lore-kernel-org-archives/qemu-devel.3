Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7893A106ACE7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mDs-0000Yg-Uc; Thu, 12 Mar 2026 16:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w0mDq-0000Uf-U7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:01:31 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w0mDo-0004PH-S9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773345686; x=1773950486; i=deller@gmx.de;
 bh=xlV+jnJkOsVJ0mi0CZDbQjzw5FLsDG+k4EI0CuCQrcg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GV4FxcgFP2XnzBU2xVzeJl5XaBq3ycw4WybpDxGiH4Z4g4N376zi2d2kUkYXdiGu
 jxwFi/ZmmhElIXS1B90wMo7MA+APq/lUVyjvxj0U09f4qYgJOEAV8cf8wSLh6fumT
 K8xErGWphc0TPl7AfIV0OB80P1LLZ74aTHdEkUCT086VVgBYER7EAeigv4wwF8keT
 gO3qbUGwqor9Yk7K27SKyYKx86mc+lVFUOKmd2fuuSmMU8lri7oIPfs2QAr917ohR
 i1NJFz4ii22OdT810Ow9O1D79xhP9nb04VhhTftRvFvVBpdTDXn4qCUwJZuK/S3fd
 +ug5fUdcZ7PhRjisbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1w8qrG3nBD-00SLJK; Thu, 12
 Mar 2026 21:01:25 +0100
Message-ID: <f8c8a7b1-d845-417d-b941-b200d23f7aad@gmx.de>
Date: Thu, 12 Mar 2026 21:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] linux-user: fix mremap with old_size=0 for shared
 mappings
To: Razvan Ghiorghe <razvanghiorghe16@gmail.com>, qemu-devel@nongnu.org
Cc: helge.deller@gmx.de, laurent@vivier.eu
References: <edf2a69e-810f-4555-bb0b-e476296377fd@gmx.de>
 <20260309233352.20760-1-razvanghiorghe16@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260309233352.20760-1-razvanghiorghe16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KMgmF93XsFnaKptzjmIu5jO5NMR5uJpda1rebcwlBMVI+PbMlUb
 1wUjhSnVL77xKUUMH5pazDsGMLcRvE9L5Prm2aYE6QlOuoiiYEHmypdRoCTw3uamBearITL
 QjGqqarUkIyihZDgu4/DhpiPwknaydX+kGAyCwT1HjKMxCR4l6+ZPgOJ/JO/hgGz9wvsoWc
 lfMU43K0MmUAI45YXIzmA==
UI-OutboundReport: notjunk:1;M01:P0:fzsDeOT/WNU=;4TatCJlrbTWcyxmmV/SNXiEBXtq
 csei6UCJ/GyVEXVF6GBjBlMIIonsJqRSXxbjagd2M7RNyQcg41w3ZYosezTfqiodOWwuyPrBa
 IqW61MhdnN0G0oKhmHUiDmOozOayii3HSYTLa7IEgGBK/eVYD+HKufLaR4kuL0Fy9L/GaPxDN
 W1TNOtmr8u+09Zhu4wrbvrQeX+5NhbIcvfU+1Hamv6ZsbEJklLbMeaee10SeohhK9dUV22e3q
 o04r3pDDGPLheyzScJP7qjxPcr1aUTqlfgi6UZrxzkiE+NBqL/KTc9KA33EsCQ0Fzo0aiFoox
 OMguPDtNrRUALxJ7P7fe7HXraLWNm8xO6jGjDxQYhAYFMAwNLX/i0KY9pkbUrcnOCVQDsZe9j
 q3A66aZPAzSh3QJfg0SinS3lMDOEHLcPjrwOb3aNI9p0/6IYmLPBoR8D1awQTwrBjh+3JT2sK
 mF2liUciQ4Z+MGCw61vC0QOBpyq7g4TH82IJkF5zNh97aKsQ2XoBpJPM+osRo8gBxxuJoYjR7
 XNQGPwklQjjE2D1HgMuglbnDjAjhlAknBArpblzQtn0jdwYeaRC3ZvyN503B3RGXiav6O/oeY
 SlOQJAEYyMH07eTSO30vjFyowMFrqpfSTODyLBYPF1aeo8lmM9ZLN4ENKq/yi1+bvB6338Lol
 hQNzsGdiUOWO4ty4q22bGieOMI2O/XXLEdaqtioIx5xe2DbHKoWHavGfEFDj10uhJ6HAZH1rc
 xFiZQdsTxoySKdAIV9kwXvtYaxvy+pmLUP5TNASuYh+ImdyLc0BwYMTyQIZoJMayraiDHbLd0
 Ym+eJOYv6+y1NaMonGDY01cAqEdN2bO1p+7+KU2vXIEKPRSavLaOrouVqekY0w/+MFYtbF9yA
 9TssPiijq2YVBvl+Iy7DtNH7+9dRIwQ8NbE3c1QyqPPhnCRwT84T7EwaHV2VE0VPJokOCRWUK
 VpbscMk6rdY70ZxpyirMJ7M0bbH6pXdaD8DsJzlF8/RbQq+JFcFACxgpgdXP6Y7Kd/xbaImJS
 hmBYqOXbH40Ge1AVQkj4M3vpNQlyncBJEkuFmqeWiMTR24CgQm0McvAPrFpU6Tfarq9GMAGgW
 jcx5wPZdrCwpLl8thWhGww8xP6/hEjYBMb88vaB4jJQuHXVf8GTMbQsHyN1Qg7lKqTv2gR5BV
 wgoO246Kn23iPKIgq3lugLCVD/qiZcaQECbakNkVgxwjOKJ8xR5gQax1tM/wxcfdAdYtbGykY
 pz7RNg1a40n6I9pxi3wYGOukRrxxFzdSz6j9LjN6bNPZLydbHiPyUFBYzJEGTC2VQmY8nrRCp
 Z7F0aZuSUc1u92Fw4qPaqqrs6ep7waF2BY3SXtC5jTNmVjvx62DnujAxLFlX149iFhEZ4Uknt
 FAXPOaTqB+jmwBNjMFx+hL9aNla6pn0zRb8X8+S4xOGLhIDe4hMSHCu5PMk6xM3Rlgq0yD5pi
 TQ0UJR2loff0EZI3wDcyptSGg2ZRrrEkOLbd+21JomHeb0mRZrEbKr33oPuibLIs0isY5EnXm
 uVacK+iZPTlGqW8NW+w9XNjTZZhFqEKt0rFy09BSHiBEPKkZtCAmrKZeK+z1YngzG8XgqIXBV
 FhpV2eghxOdHQ3GwvLmlMaiihnLva4uYqbErritSDqG4fTVs5szVJut8737LndQ/Nb++28TwA
 mDads0xBilYn2cB5oGaQ/yTw//KVK09e+Q8TWY50s0R08F/beELutXA0nm6j6TGGlWy8BnsFT
 SW6GZgaBm4XB9vID89SZ5+uFoBm3tpoDuOlOS+AisbrksMKsKB2qugiF4X7cxTfX/EF/z4qou
 LlYme1bsTlckWYMSLcSROyKRRsCsTBf6xvSkwh3z8l+2bqyAw6IwYzruT+8ZBqFOfDecbcdfH
 GxmCtSYb7on9Q11DgUTdhFJw4yz97iTKL3GFROwxyQVMMmxuzFgKz9dKWn5BF2juqzXqbVg3e
 kKR9JQCBi5+lsM2Ii8CIreGbYu1Ihk968//J4Au7ZjBX5NwAmBUEKTbzJIXnVZcQtU/Dzzi8w
 7UiEkorLyhkHQGAMQXMMLqqP65R+r/2GFILL4F7Whs8PDmMVQdgi+cZ2pSTVUp5dBpMkgDApD
 OXbqmizMYtTf//AV20CL8DqL8DkA6sQ4KMPsnO8tlsdMS6USAa8BJzEohzFNBpi17LvCUV8Lz
 FpwmLJa1+YPO85YNH9M6c/GolMFCSV+2dJqp8AqO5z2+kJL5VNzDssp/bQkTr8TDaFF/Pu2Rj
 rWGad6FklshSdp+1ZCxH9Inrz2hPNHR/UoliH89/WLbI7rbmmtMgChaL3jHJhzrhJAewHD5hs
 L1Nn6560rDpE1JXcgDtr+9DYj9LsxR2m/daAleaSUIpN5tRyM9n0BW8xPFMyxc0Xt+u7VQjct
 uTyvL3chSjZvrEWr9FEl7Ncq0Iy1UB71g9DcZYiD1O+jMsf0xBFXUuNjNxaSzyLlPEkQ8QZwW
 YUMW99lzG3f7Ppur1yOpL3oHLFYgK9zkfby9YZW9qvMX5VgLobXPtL30N8HWraAT50P7Xq7ZD
 oP077jUj3i2zdpEF2tRnyZTford0AcwRR1Cr4ZTBFTpILjXdeOsYjA+AUoA3He+P/Snlr49Li
 ekYoIzvJpe2wFRhdO8PJr09OOLewAEeGYsTuoNEpOedeWSCSkwA7JMv0SnGgCB/nHAwJ/E6yv
 rNigxURUlGQ2YC7R3zEar+4s1p+MOVXjKUt7ULn9Es7SEDdDpDTFgnRpXOPzEK3SuFJkU9oxv
 5CiEjGsoHyJCLU9KTuvm32oKbjg4LF5QZYKwYtNk6lgB3H0eWGjf33SBYfF+x/nagiK3bHlYl
 clM7Ej+um+QNMclo3KPdvpDrf+EEln9rBfcUJNCwZlXSqS69dr9eOrsjyCsA7tflWpRC9w4Ed
 TUi9gfRgoDbeQa7e3lcsNLAhqGDZBUjwkHDH8g3gmsJ9GnMPwioDXjK/qZe5+F+y7UG4maMge
 yMLjgigPECmDfjFAD+FKSFRUS9Z8cN9+B611GBb6rOUjTH+Mz/Xv1qoqXz+XCW12eZaYSCVE6
 eFarywuBNCwbdvodzo7tLjpCZ4zMR8rlqBKXa6bSxxIL8OFSoAQVbdqo6rC3NLwZIofWgc/0v
 9MrgCbBe8Iwjem7Cm2u0KBOb5iQ38in7Ty+LDnkVP01tedQ5vIi6eM1NfJhdw2ckPzKcYxtbt
 ZWjVeYsKRaweNZ/PvUN/iVkTGI0mXNAi7LZrBJ1xw+Q/4XgX6UNlGFftUQH3NEBNxAXNa5KKE
 uAKySCdZu1oQU2Elj9ZNXbOjdLlWxTHh8oRVXfYRYD9bctGIoL0uMaBC1h1OKUXuKlAon1rtI
 lWvTE/RI7pIzO2bmKiEBdf9bhZMAPVnqkxj3uRfwo8/GZKQ/fj7HXDyvKZZ5gW3BXO6dbPtgp
 LAwFZGMYB+tJB0D2dPJOWp0SIzDLsuxTZL1K+Oleg/lGFzvuSNZmXDy+wdmtrV9fQsa9ICNSr
 X//JQr4M64AlPzCd7BDDzu4Q6NhFcXCDb1ZuT8g3PnYgUo4SNv1X3Z+qIu/gkTWqZX6XUIDjw
 l5tjBrmsyDST6A/PsVmxarF57jfsZ+X6Mg8qX5mO8Fj1Gt/r5M9QFHrN+tfKKWx2w8nk/nm1o
 us8pd/yP8qQmuyHhuryysLzP7frgsX/E7qVWGnztUE2LLxfDVz9HDStlw3U5+tTAWKe/0re0F
 0SJ6TnvpqVArUKDWDwSMKWMi48ToBmcrtRfwe0d6XXb3T9IJCcNEisy+8D5GA9qyubAmKPE+2
 pBFDQVeFcLINHSX42K3Z8yV4wtirnSCHsgB85jzCkxTnEpeQt2VrZGk28cohAAN0HSJtuyoKP
 y6V81Cn8IJEIzML5BAqIopQEm/6TDgd72dfV7nZ714vjMx5jBDXhhvRx0J72fgCcevimoerBx
 kksYkqMPm9RrfTpwWxGh9AJU97tDUCPECQvA93oM3v0ZsjKXRpKqVOLiEDoqlxXc2kCLwvQ9z
 ZFBLe5+Ok1taMwh0CDgAI7M7Fof/NVxNPmwS25vAAMR87N9c7qnRsoapI9Ke7kSyAwq5d8SGZ
 fkuPkb2N29i3YR9ey8R9+P/tmYaZL4wRKQgl5sliLZfBpyzwvyP2zbuyVF0vAwuYwK7/kTJ90
 BBB+DFuItxuZSvfP1PH3z7YzKN9GRsR/HwdWDtYSqvTOtOOuvkBzEtkaGRUsKATI/SBzTBo6J
 zNmyRATZm5bUYWN7mj+QDSzxZ/FfoH6vd3UI8jR8a6k3no1nWBbBOUz+Fm6RvBkHE3h1Xt2bV
 tY4CO4TNChNBUmZqQtDsWjrMbfEkCVHKaPHSBvDPc7FrE9SJuuTqrFz5YsZLQ8OShKbDCEGT6
 idZ7ceyJESLUteVSNs1EOwnr4f/MlheMC+3lHx6qCLkks4U02MVNWvmUn/IkIAznCGjAhEGXR
 0CNZkLSJmTL5xTft6/o8RNg5Ctusxgaii3skoMm9vtqlgRKUCqEbM97Jxo0af/MX3YDKTIHFg
 t6ViJDLvlTxPZ6eOTWBL9r8fRyxu+PCx6km5PQFyA8moytI/Djha1Os9Ga61MfvEqwkQtFHRj
 Z6kkX7Ju1aRhCsumXXpZNB+B0EspVF502u9lq+mMyNAsJMrfJfHSuzTF/7hwC/6maK530OOiz
 q32g11XTOWtgt345KBqXCPN6AlOGf9hfEsM7Vl/4rE81j4eaKq/Jw03FfsgYdwqavP4DhERx1
 Ay+tJWcTQJdZZNEs59A2ZjBm49N8rlNxy68aN8y+Zaqtdq8nJL/d2LlrVs01WdPhnYFnrRZu/
 nZbLbImU1fVErF02fEaGrlXXvL39b1JscZnS4QErNxVyjeRIoBcDTjkBjgIMHzHQmDFA4/E2v
 1o/4/JetSpuUy+oxoSuUeecexFCU+tlBqgp9bPMr826vbd+ADTZhrelwBotWfEDYP16EbfJdN
 F8L0aX4DC27+WjuaYvuyC00lI3T5dG50JRvQs9/nLQ1qwNEd4ai/1HusACod1JXdOoqOqjpXv
 XetS6UzrKBtgl7zkJYoqEmv3JduP6z3nhGO7/f6hNYAtRW2jUvmuRLR81q4v5TFE7mSl9KglI
 uH8njgtZZlxrWl0gTrugVFfhzFlmmRyiRgCqGcv+ghyFPICr28DyaMc+SkBN8CpAxUF36YYo4
 /qdDvA+zG5g9LM6K3lc2Xn4k2t2cEqKE8msp7WIBaQkzNzmzpbQhFxoQWyF7ZmLp3dwETyod1
 UyYzJ/eEJkehIVT/6zv8xI2r0YR7grtChT4UXaWA7PoWbTEfVjdogmxheCycWypMPd5EuBZMs
 bUaCPiMMea4IXkT2iS+0ypu6rE6jxlC2euxr3uUS4r/hNDyInkpytqpN4GcDXm8=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/26 00:30, Razvan Ghiorghe wrote:
> When old_size is zero and old_address refers to a shareable mapping,
> mremap() should create a new mapping of the same pages according to the
> mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this ca=
se.
>=20
> Previously, QEMU's target_mremap() rejected this valid case with EFAULT
> during the initial validation, before checking for the special
> old_size =3D=3D 0 behaviour.
>=20
> This patch adds proper handling for old_size =3D=3D 0:
> - Validates that MREMAP_MAYMOVE flag is set (required by man spec)
> - Passes the call through to the host mremap()
> - Creates a new mapping without invalidating the original, with both
>    being valid and sharing the same physical memory frames.
> - Ensures the new mapping address falls within the valid guest address
>    region before returning it to the guest.
>=20
> Tested with the reproducer from the issue on qemu-riscv64, qemu-hppa,
> and qemu-aarch64.
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
> Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
>=20
> Hi  Heldge,
> Thank you for testing and detailed feedback!
> V3 fixes h2g_valid assertion failure on hppa by using mmap_find_vma()
> to ensure the new mapping stays within the valid guest adress region
>=20
> Tested on qemu-riscv64, qemu-hppa and qemu-aarch64.

Seems correct.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   linux-user/mmap.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>=20
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 07175e11d5..b41308840a 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1117,6 +1117,58 @@ abi_long target_mremap(abi_ulong old_addr, abi_ul=
ong old_size,
>           errno =3D EINVAL;
>           return -1;
>       }
> +
> +    if (!old_size) {
> +        if (!(flags & MREMAP_MAYMOVE)) {
> +            errno =3D EINVAL;
> +            return -1;
> +        }
> +        mmap_lock();
> +        if (flags & MREMAP_FIXED) {
> +            host_addr =3D mremap(g2h_untagged(old_addr), old_size, new_=
size,
> +                             flags, g2h_untagged(new_addr));
> +        } else {
> +            /*
> +             * We ensure that the new mapping stands in the
> +             * region of guest mappable addresses.
> +             */
> +            abi_ulong mmap_start;
> +
> +            mmap_start =3D mmap_find_vma(0, new_size, TARGET_PAGE_SIZE)=
;
> +
> +            if (mmap_start =3D=3D -1) {
> +                errno =3D ENOMEM;
> +                mmap_unlock();
> +                return -1;
> +            }
> +
> +            host_addr =3D mremap(g2h_untagged(old_addr), old_size, new_=
size,
> +                             flags | MREMAP_FIXED, g2h_untagged(mmap_st=
art));
> +
> +            new_addr =3D mmap_start;
> +        }
> +
> +        if (host_addr =3D=3D MAP_FAILED) {
> +            mmap_unlock();
> +            return -1;
> +        }
> +
> +        if (flags & MREMAP_FIXED) {
> +            new_addr =3D h2g(host_addr);
> +        }
> +
> +        prot =3D page_get_flags(old_addr);
> +        /*
> +         * For old_size zero, there is nothing to clear at old_addr.
> +         * Only set the flags for the new mapping. They both are valid.
> +         */
> +        page_set_flags(new_addr, new_addr + new_size - 1,
> +                       prot | PAGE_VALID, PAGE_VALID);
> +        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
> +        mmap_unlock();
> +        return new_addr;
> +    }
> +
>       if (!guest_range_valid_untagged(old_addr, old_size)) {
>           errno =3D EFAULT;
>           return -1;


