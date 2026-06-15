Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE94BCD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyg4-0000YE-RC; Mon, 15 Jun 2026 00:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyfo-0000Xi-Rt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:11:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyfm-0002Ja-96
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:11:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso6366105a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 21:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781496700; cv=none;
 d=google.com; s=arc-20240605;
 b=CflNLR5rsfWoutuYWGEaThZvRJL9KjOtR7rUsWtIBytH8gEo/UUBmdG8blAQIIwRrX
 xmB46bdFIRKUwJiAu8ApFvbdM/rJZdZowlTTzSK43kkAKR2ymk3xO8/7Qwcb5pvk9Va9
 vxbJA2r3K8aJXTZ7ypTm8QeBkf07zjAgMUJFr1G/Hyzo+/oBsPccFUp4UUX10a6moCzg
 c2hPU8LlsUaXkPf2qbUBSjO82pSf8Nnk6B1Fz6SYzgJAIgWkodXTGvDzmV9HzY3YvdZ4
 gOIaJC8BmpB9Xp5fD6VeXvJjDM5KtmSBqXCfKPVIlWEBxKZ5nZ6YKrnwWEnZG0k2uWEV
 pDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hDCujn9qZ6SIkr4YsVfOCDiUztIzPfGkgQ9t/bnydbI=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=AuiJBQNoPgKehfT4gwieByE3axJzMn0D9jFH8LVniQnh0RIRTsnxrTTNcPzXWU14eZ
 XVXmVBXcSVywbRlFVxNvL5wpTIhN4iblYxLnrDcm1iCkjuAI7d4zwAufHe9mj6Q+iQbh
 OLdC5l9AXXVz8NW9/vzF9pr+rodRyBfLy5YC240h2UyuczAgSyntCkwkkSa8PXB+JpPC
 FIX679XU8HN5Xs/nUsNS7U1ry1OHpkKIcJUxq0mMnI0N4UayVcYEE1gXSpUVT2Huf51R
 3Hm1c6bvK0zyd9P+h11QCiISBhFiX8z+z2v9VOrv1d5c8cW0kX35PdWmQk8lazk+YHVV
 HhKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781496700; x=1782101500; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDCujn9qZ6SIkr4YsVfOCDiUztIzPfGkgQ9t/bnydbI=;
 b=dYaw3hRZci8x3tCEt4h9RRtbSJj7tGGX70PX3xdmCD8G6neuJsKIbVwltW5C7tPHIM
 KfK+ZzBMWF44VmKgNee9mqYMMsLnrCMnB32xvwmTsvj+qDACwSNIk2TmQgvVnI9TcgoJ
 voClJfMahVNWrL/vpGPp9GA0WInIb20/b4wTlYE42M1gWhWG4CPGoESTSreP2LplQ8nh
 ifOXsXW8to8si73IlDqBrvJj0fvg9X33QxRIK2t91tfuYMZi2rCopaEtO+JUypcfZ5pz
 HJYRtP7pfSmij2196k+GASaMX2WbJngb3Bj4+Ezft2XsbPhDNjpY34nMHbwossiy7cza
 LdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781496700; x=1782101500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDCujn9qZ6SIkr4YsVfOCDiUztIzPfGkgQ9t/bnydbI=;
 b=ByPx35B5wDh1gCjfc9ems3dvsqfWVfUTu8A/eYknIFYByVxuUeJ7JPgZh5+76Wo/62
 6t/l0J17UAaASXcl4+A92+t7JmC46U8ADWZ2HnbsWikMcB7NbCqAHwAF+44mjC7Ho7ri
 0JN/QhntbYzdHafMTXYNjA3oW+9KqTY+/X+IWTkLZnk3L3SgqGP8UVr3IgOBry9aWsp9
 umgtkrl/hVbn5cK/6Vyx6lrJ6nC0hnmcrrjvTsjHrJmKWnuTHWd+KrjKNDOasVVt6AwZ
 XApNrO3VziX38YMQXtLO8DeMdpY+lTpdX0jIAV+6JO9vds7dIgbc9TZJpQjUP9TI/0DU
 5IcA==
X-Gm-Message-State: AOJu0YwDM2bqAbvp/cmTQvvZxfYDx4Nhtem4MU2T2I5m8QMf2Amv3Di4
 c5ArTzA2CBLLSho68fGNDvEk8uUiF4kcIDKOYeIFYFzEI9yKsYAHwEl09QsiQQDLS50XzjwbeiY
 +6mD6811vUz43KC+nab1a0UyKWSAxVQo=
X-Gm-Gg: Acq92OESHOMDSNQ3Qf+NLPYS2DDe6mgg96osqR2i75y+SaqrSCtEk2rx1B9YAYEBIBb
 pKFuDbkGYky3Hdzbo0kuuO5IrgZY+Z0JYZ6oBTjPQynImWXEfBoGYX7RuSZVxDGZUqNDsz7a6pC
 mzxbNJEHoJ264Smm1vdiBXL5MeUQGg1qyzfPWEn/AJgD5GogngeZlswjMsY30ucZRZu/YeViMAP
 LCg0w5SUl7TRWM+Qs+770wI1tc7UXU6v+6Yzplk35tukquNRtXKjqSzJXklvmXBWDWR1EeRvqV7
 glsH4ha1N3gfBDRkxcmHZ8/Ris1tBl2mQaMATg==
X-Received: by 2002:a05:6402:34c5:b0:670:d548:62a1 with SMTP id
 4fb4d7f45d1cf-69378d96d9emr5266684a12.3.1781496700212; Sun, 14 Jun 2026
 21:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
 <20260611162223.2361941-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260611162223.2361941-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 14:11:13 +1000
X-Gm-Features: AVVi8CeeEUWdUH3SfePys3wc6szzMlivUcp7Gcq7M_pOSLpDoiWWLqMG9bpuaEQ
Message-ID: <CAKmqyKP=nFiDXGdGCvEPbKoUvWkNedNjggd7nXYYqFgz4WO8Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/cpu.c: do not default to svbare for bare
 CPUs
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 12, 2026 at 2:23=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Back when we added bare CPUs (rv64i and friends) we didn't had a way of
> easily setting satp-mode to 'bare' in the command line, so we decided
> that if the user didn't specify a satp-mode we would limit the CPU to
> max_satp_mode =3D bare.
>
> We don't need to do that anymore now that we can set 'svbare' in the
> command line, thus users can confortably set 'svbare=3Don' if they want.
>
> Besides, setting svbare if no satp-mode is provided in the command line
> just for bare CPUs, while every other CPU will default to its
> max_satp_mode value, is yet another random stuff users have to deal with
> for no good reason.  And, on top of all that, this will make it weirder
> to use CPUs that uses bare CPUs as their parent type.
>
> Remove this special handling for bare CPUs.

This is a breaking change though. I think this should follow our
deprecation process.

Although I'm not sure we even want to make this change. The idea of
the bare CPUs was to disable everything by default (which we don't do,
but that doesn't mean we should be worse at it)

Alistair

>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  target/riscv/cpu.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d968daa404..c2f79a1ca0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -510,21 +510,6 @@ static bool get_satp_mode_supported(RISCVCPU *cpu, u=
int16_t *supported)
>      }
>      return true;
>  }
> -
> -/* Set the satp mode to the max supported */
> -static void set_satp_mode_default_map(RISCVCPU *cpu)
> -{
> -    /*
> -     * Bare CPUs do not default to the max available.
> -     * Users must set a valid satp_mode in the command
> -     * line.  Otherwise, leave the existing max_satp_mode
> -     * in place.
> -     */
> -    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) !=3D NULL)=
 {
> -        warn_report("No satp mode set. Defaulting to 'bare'");
> -        cpu->cfg.max_satp_mode =3D VM_1_10_MBARE;
> -    }
> -}
>  #endif
>
>  #ifndef CONFIG_USER_ONLY
> @@ -896,10 +881,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *c=
pu, Error **errp)
>      }
>
>      if (cpu->satp_modes.map =3D=3D 0) {
> -        if (cpu->satp_modes.init =3D=3D 0) {
> -            /* If unset by the user, we fallback to the default satp mod=
e. */
> -            set_satp_mode_default_map(cpu);
> -        } else {
> +        if (cpu->satp_modes.init !=3D 0) {
>              /*
>               * Find the lowest level that was disabled and then enable t=
he
>               * first valid level below which can be found in
> --
> 2.43.0
>
>

