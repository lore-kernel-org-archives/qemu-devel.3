Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB69D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBLn-0007Xe-JI; Mon, 29 Dec 2025 06:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBLl-0007V0-B2
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:23:45 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBLj-0006Ve-OS
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:23:45 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b7277324204so1335699566b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007422; x=1767612222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+A8/vPCQAGEeede8cV/qfohMpvI7aoIb1apxfDSGkw=;
 b=UWdz1lHK/uNLmaaJm3eclJRL6bnlgkPi8SvIzZQKDNxdAST1VWsRUr6LBAGc/davxA
 eTg2ygZq/PGK4W76Ogrvqb27s/unLgORCgzsE/Y+/UBPNetAIqAZes+F3e2VLxzJx19d
 Zxe5QRLmEGbViH8D5yVJIfjo3JjB2ip99uOUL4MsdHrNM08DBWOw9CHweAH67UD0EZdm
 VcjmMxmI6++Lmb0HRQWzqLybBuoclQWRqUzkO80v8deHF42wVS8qe5uvGmKrddhZ+iwU
 yExMQDCpkXm7rk7m1zVc8cgxaVsucs3in6mRrxz6o8CnNaPTXUwqgz3pBdqaW/kxxp0t
 1vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007422; x=1767612222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+A8/vPCQAGEeede8cV/qfohMpvI7aoIb1apxfDSGkw=;
 b=YYYs3eV1lTtIKsyeYFguRJfeO3QyxCxyrPYjwhIDPSEc7wgNVUTu7AgEkp3zGFIJZc
 Yj8H5ya9tIYn6Cm9lw0NpfYsKW226owWApW6b9Gl6iLifVTsGf05JhyipTdjcw3SOfuI
 I43+gbNnScF7Rk+5g5cMjBWsMkZoTz55mZZTXk7e2lOaYCkIFTTBBd0mh7Hm+4IcVKu9
 lCR6UREdxa/K9J96WDSc3ZyyhIRV9Fqr+aWZbmFYHNCBBvRKe8/xb3E5ft8qbWTYxCqL
 F3fvfYGIYoMi9ELOjyt+bTY3fbk1CjV671nxMTZOGfmwfKzsCxmZKedtQGjGIQJYMOZr
 sDKQ==
X-Gm-Message-State: AOJu0YwxAQ0GYmDHPfAY2AIOuhf02Qb9EUC8rJwCU21SW4PfXQSWPDtd
 OTHala79Z6P8l9x6nRDklKLOxnekCeE7S436gfAW4OiWHnTkP5p4+gvnp7Rr6czvf6I2X83y+io
 1UFxqsZsizTIHAbhPESJkgB54jjXbAtZUDVoI0jrGbg==
X-Gm-Gg: AY/fxX7mKwca7NMAyp1XHj1fJB49gyle20rHY17xilH7WmxeWCNePWRmIAVZEv9SG9B
 eIdVJfUMb34H7TFULt4S+6lvcfLcl1ap1OqZa+4ndntnEPupK86jSKkwVHR7jf9Gnjo1FBFbyti
 pLsFhZPEsdOND31izUJvgfmREJyJl6RZwcCIMuOe+LKgPAqLbLFeOAQCNG6lJRvtP7fKx4XAyGW
 iTuESjhQIXbI6AuzoW+/7cHKnh4e3h1CjGCbLdwFy1S/NtAc9Gyxn4c7QxCexJgUdH79wjfmhZq
 Pb46acPJLX3r41oHi5eABn1kgEM6swqEjj9c8OKgoMcI4t9n7g==
X-Google-Smtp-Source: AGHT+IEUoV4Up7z2UwnLN3lXo6KGyU0soNpru0lv6YDoDklkKcei0UTEFsSxsp6sxflUH3sJHu7vLOHBKBqVzuTUhWY=
X-Received: by 2002:a17:907:3e28:b0:b80:34e8:5eb with SMTP id
 a640c23a62f3a-b80372699fbmr2985340266b.55.1767007421926; Mon, 29 Dec 2025
 03:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-9-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-9-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:23:16 +0200
X-Gm-Features: AQt7F2q86JhLGUDpxuuPljXD-0-voEYNhc0iCcVgId0Jw_-5yjOseIrxKiUniog
Message-ID: <CAAjaMXYdUG26SP7=b4wRfXgUWdSLMm-M7K0X-+cfDfEgHWRsTA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Rather than ldtul_p() which uses the underlying 'unsigned
> long' size, use the ldn() variant, passing the access size
> as argument (evaluating TARGET_LONG_BITS / 8).
>
> No need to use #ifdef'ry to check for TARGET_ABI32, since
> it is 64-bit:
>
>   $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
>   configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=3D32
>   configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=3D32
>   configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=3Dy
>   configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=3D64
>   configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=3D64
>   configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=3D64
>
> Directly expand to the big-endian variant (with the '_be' suffix)
> since we only build the SPARC targets as big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/sparc/gdbstub.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index 134617fb232..d265681f6d2 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8=
_t *mem_buf, int n)
>  {
>      SPARCCPU *cpu =3D SPARC_CPU(cs);
>      CPUSPARCState *env =3D &cpu->env;
> -#if defined(TARGET_ABI32)
> -    uint32_t tmp;
> -
> -    tmp =3D ldl_p(mem_buf);
> -#else
> -    target_ulong tmp;
> -
> -    tmp =3D ldtul_p(mem_buf);
> -#endif
> +    uint64_t tmp =3D ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
>
>      if (n < 8) {
>          /* g0..g7 */
> @@ -170,7 +162,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>  #else
>      else if (n < 64) {
>          /* f0-f31 */
> -        tmp =3D ldl_p(mem_buf);
> +        tmp =3D ldl_be_p(mem_buf);
>          if (n & 1) {
>              env->fpr[(n - 32) / 2].l.lower =3D tmp;
>          } else {
> --
> 2.52.0
>

