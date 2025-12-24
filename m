Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFB8E776FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUJQ-0008I5-I9; Wed, 24 Dec 2025 14:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUJN-0008Hj-5W
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:14:18 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUJL-0005Bo-47
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:14:16 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so821618466b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603653; x=1767208453; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtJTbovlc0/XG689YUVVg4dejZnZJ8XHgUCuM3fJL08=;
 b=Eu/wELMyeZTdzWZ1Cm+gRcURxAPT3bEB7SfLdKLxmRi2SruoedGA67IekxgiYdJ+LT
 cH8KfEEACVBe3sDJ87jaPIPZ1LJjP8uEFBFcsIVYgGvNXCHt8t/zCz9eS4OFixcUCc/x
 qOiGzmXBCCRrh5rVxvN5KoiuB6gc3ONECJQjSUvOX5cRaDZTQe+EZ9Y8U5ZGJg/M6tyi
 Iu+Bx7Dnfm14pXS3GbM/GGlwtngh5Urws5HTSy6Y1GlEw+DmWuCnqX0w8aWDyIFUd939
 PsVxESzrkhepotS0h033jGMm0Vb0eQ3olK8dxtZFvUPFO9lg01jzssOR53/lBqe4F2zh
 gxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603653; x=1767208453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtJTbovlc0/XG689YUVVg4dejZnZJ8XHgUCuM3fJL08=;
 b=NPAC+XA6/HZqHKi6B3LMseIVTHeEG6Ji+CCyyMf9YqhXGtHymNXD+RB+nmxWKQG8UV
 6C3ffG6PZMBz7xqZSpfwF3BW9qnoOcaA25nyrQUYtzrp1STx03k5IiC7jYI4uM+1O731
 dLPerUCLeCnnqG6mIoyiM8EV43PxqKt80d80+v1Vri0m77rQw99aJIXTnRjbdq6TB1ff
 bazGFJgubsY8QrL+mdH9kjFjGunhehDsxpXZ47IPgVg60zcys8GMVu7KCUW3JJ+ZEOOz
 t18fLiGeq8dwXu3Jy/bbZPHgAQl3xozY2aD5D5yAXkujxmGagRYtSNkv+Z63q37XlrZY
 N5+w==
X-Gm-Message-State: AOJu0YwjtP9dUdgadiSnPUHHY3u7eDQ+uI8Pl26N0qFnjR3Dfd7e7IHB
 GJQp8Rqtpx8Rt3JKfQYaFHOudzAXjGM6mt5aGqArq7hCxAMvvpum9lc9s08sTUpD51cWEEdO0uh
 9kUrEPQYYCmswtnF6SIIm5LESr2gL+7ulPhewUUB5ng==
X-Gm-Gg: AY/fxX4K/IahoQdB3F6uYntIEL0cOXmfqxW+l0X/jBPMYMvalH0tOdWrVccs/d8PHTD
 92G1B+G9712c3PxFSV/pHTuEsE3J/kF4nD0bj14DMF03/LsP9Q/O+j7lPpZIDFAPc5R1IV8WGv2
 L9CMNnKYaIpI1SGFPgwWJnxSqEx+8xZJxQYEQwuSVUf94ZaTAR363Y9Q7C2yiSvhZ3NTfUI4wey
 6KspCLhHxI0TBJ7LabekSpvWUbzGdv/FSjeyVNGHYJM/dPEQqHLSgFizPpd3Wh0bh8DK0o=
X-Google-Smtp-Source: AGHT+IHGUCAKBw27rmIwPNxaV5IwAq+XIJ5k7TwR9TiqtOu0YKcyUj2ivocD5kChV/zz81vDjdzSK5n66Gy4V4fxiAw=
X-Received: by 2002:a17:907:6d05:b0:b7a:39a2:7f50 with SMTP id
 a640c23a62f3a-b80371781cfmr1949017766b.39.1766603652712; Wed, 24 Dec 2025
 11:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-3-philmd@linaro.org>
In-Reply-To: <20251224160040.88612-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:13:46 +0200
X-Gm-Features: AQt7F2qh0oOtwUfYq9TKBV5yFAI2BuAC8dWlXNl6bhSsR_UtzBqkUL5M7Uqxoog
Message-ID: <CAAjaMXYJqck3w6Bn2hU8RkCX5WhEBRdTOnpdQaCiTPFLDTm7ug@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/alpha: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, Dec 24, 2025 at 6:01=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The Alpha architecture uses little endianness. Directly
> use the little-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/alpha/helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index a9af52a928f..80542cb0665 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env,=
 target_ulong addr,
>
>      pt =3D env->ptbr;
>
> -    /* TODO: rather than using ldq_phys() to read the page table we shou=
ld
> +    /*
> +     * TODO: rather than using ldq_phys_le() to read the page table we s=
hould
>       * use address_space_ldq() so that we can handle the case when
>       * the page table read gives a bus fault, rather than ignoring it.
> -     * For the existing code the zero data that ldq_phys will return for
> +     * For the existing code the zero data that ldq_phys_le will return =
for
>       * an access to invalid memory will result in our treating the page
>       * table as invalid, which may even be the right behaviour.
>       */
>
>      /* L1 page table read.  */
>      index =3D (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
> -    L1pte =3D ldq_phys(cs->as, pt + index*8);
> +    L1pte =3D ldq_phys_le(cs->as, pt + index * 8);
>
>      if (unlikely((L1pte & PTE_VALID) =3D=3D 0)) {
>          ret =3D MM_K_TNV;
> @@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, t=
arget_ulong addr,
>
>      /* L2 page table read.  */
>      index =3D (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
> -    L2pte =3D ldq_phys(cs->as, pt + index*8);
> +    L2pte =3D ldq_phys_le(cs->as, pt + index * 8);
>
>      if (unlikely((L2pte & PTE_VALID) =3D=3D 0)) {
>          ret =3D MM_K_TNV;
> @@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, t=
arget_ulong addr,
>
>      /* L3 page table read.  */
>      index =3D (addr >> TARGET_PAGE_BITS) & 0x3ff;
> -    L3pte =3D ldq_phys(cs->as, pt + index*8);
> +    L3pte =3D ldq_phys_le(cs->as, pt + index * 8);
>
>      phys =3D L3pte >> 32 << TARGET_PAGE_BITS;
>      if (unlikely((L3pte & PTE_VALID) =3D=3D 0)) {
> --
> 2.52.0
>

