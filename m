Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A10CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBfc-0008EY-0v; Tue, 19 May 2026 00:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBfY-0008AN-OI
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:03:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBfI-0001Pe-P5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:02:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso6600195a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163362; cv=none;
 d=google.com; s=arc-20240605;
 b=LhStj7FgffwxatPALyLPKwmyDtcHyFCynRRm68Ho9vT4cad2X40uXf1QHnl8jtwY4I
 XV26WPBOLIWA0FcYtdvztp+fmBtMwoeOY1xvTZrYXfxr2WzWl5sHBOlMYEUlpOxhmzYp
 39+0tjqHIdefHHk1cnDAKefwbfKyNlUD6L/c6GKWnedodItv1MK4cHRdqjGT0HCbwure
 PChRi/srAHyQdEgNYVRHA+poR9m3QVOZpj/6k4IRiBPQImdne/DdFqvq0Cjn/k4CtL//
 xb/u8LJfWj8yd5yHgrokD5uMxcqhlKVh0+JPLFz0uNugxoaSYoSslHy3f0zVN7O3CjhX
 b4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IlRfPW95yP91K29i9OZGhHWExIqlxVsEthmmze+Yy5Q=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=k4PGXWDh14bki5Uz/Xg1Y8pmocgNYRu6J4uqoR//ZBclxIcA98mD9g54qLMrC7S0WU
 WWBRjzlTY5CAlUOv17rVG8cl6HZPRfUNYRLO6rhxM8qgTkqMyyp3HSRbMYuCU9D6ElU/
 hoGx9uCfVC8iZjHk4IXvNprMmo6LLR8Rtlg2EYu6513Ebxe/JViho/Fd73TfF8j8r4hx
 yDQLuutBLgTh1hcB+k+1tpTItfZ+cc5Io3tDbxlzrAeH3AG5rzDx4JUVR9+TVUfIKo/M
 woFiX6FrfUKvb8O9XM1/AkJxSbTv+tEDNAQyj8KZOgyokzCnstD9k9PUad11p4khOZEZ
 SqIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163362; x=1779768162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlRfPW95yP91K29i9OZGhHWExIqlxVsEthmmze+Yy5Q=;
 b=ch6UprAiQlzvZIPC83QA47ZqC9nBD6R8vp2wbZvaQTNT5Omjf+mK0xFnejI77OGJhc
 J0J1RtkFtrZLVP6G2Jq3mFw3x1smZb0JobxXN7+lKquvOsD7hg4jQUbCXZP/bq+ar4vB
 cG94hrqUqkwqCUs7a3VTYeQYyH9JtQO8jtp9qtW5Wsl92FMNUQgMYIJMHgiuWBiT0EPb
 evf5gtfU/NUw2yxnnfdVvdp4QixHVl/4mIuOnvCM07JSJUN1VHHfZibTIWOtujlhWjhj
 uhdTv6NYrHFen7MJN8fXQhutSGdVFaBJ7j7ZsClEBCCeYl3Ha3NchyTbxNeQRcPl93Je
 xrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163362; x=1779768162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlRfPW95yP91K29i9OZGhHWExIqlxVsEthmmze+Yy5Q=;
 b=D23MYRcjzvDK6WIk86EPbbhNcd+CyPVz2PlnsEbI42BWuViibvKmpBu1EV8/PscPg3
 ivwEWhAbzACSgX3qZUYzDdQEd14ZVfbj08kVMieoi9426npSxcjp0sfviOh6SU+QiZzF
 spX0DUUv9j5mUm1UUMoEXnlL17dBwlh+O5QvfGtHWzbzV3EHnnGihnbtCe0TnRMUoTR/
 mqb2HhlwtmUDjA26rg2MGPioCh/oP7zYIFYY1Kx+pBVHtokz8gR0naMwNY/+PAilLOrA
 0BUYJv41+qTSiVIoBV2Cv5TzppYOZha0Gc1i8HDfD2h4rX1DqEvwDoDuz3Mrp9gE+i+7
 CeLA==
X-Gm-Message-State: AOJu0YzON+jl9vOveT0YyPwAdISWk0stb3okCmjCGeZlM7WHm4hwPVUY
 mjomVjA5Gl8dDFQEXM/XEWFp6XtJ0q5UumkILMIB4ED0C0pYkcZbttKx+wDAXkPBsSQbjU8B6Io
 fIcA1kpqpRby3l4dFx16TGsq/iI6yrjQ=
X-Gm-Gg: Acq92OF4UOJGjtGPTRwUlGx1aGib4gZiaOddbtHegveLTcuJpckkkUuAwvIlhBSyBUg
 C55Rdmd69UZQ+/z2nbd3nVk/FX7Hmw6SiwtauWjF9+GwtpzQxj+aNy9akY/M1lYN3wVBoIMCBFw
 uzY43cjpY54AlG7gZ/yR6J87UiK82VC/jV2AbBlDwslMCcBHA7y0V/BjXLLuLIghj5voweeKUBs
 CeMLtiwzFmfTZN/Gl6+PlqwPXZsQUzvDC/K6pN7gKxNjfiPpfFZMFNjDHwOUQPiPe3akLknDd+4
 qsNgekWxuTOQ95GG5tlolK4I4TxGY2wd8PiVlGgDMbTnWbIi
X-Received: by 2002:a17:907:8d8f:b0:bce:267f:19cf with SMTP id
 a640c23a62f3a-bd5177bfe13mr1074972166b.12.1779163362076; Mon, 18 May 2026
 21:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-10-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-10-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:02:15 +1000
X-Gm-Features: AVHnY4LCF-8Knodt6LcBLVGYsLOiw_uis1w1TIBgFBWr9W3_I5vEsuoQFariwZo
Message-ID: <CAKmqyKNufh285iFkRe=oQw+cpnT4ckSF7qTzMOJSkGxXhuj3kA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] target/riscv/kvm: use isa_edata_arr[] for
 unavailable props
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, May 12, 2026 at 1:30=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Use isa_edata_arr[] directly instead of going through 3 different arrays
> to populate the unavailable KVM properties.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..7f56f64d79 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -525,20 +525,9 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *o=
bj, const char *prop_name)
>                          NULL, (void *)prop_name);
>  }
>
> -static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
> -                                        const RISCVCPUMultiExtConfig *ar=
ray)
> -{
> -    const RISCVCPUMultiExtConfig *prop;
> -
> -    g_assert(array);
> -
> -    for (prop =3D array; prop && prop->name; prop++) {
> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> -    }
> -}
> -
>  static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>  {
> +    const RISCVIsaExtData *edata;
>      int i;
>
>      riscv_add_satp_mode_properties(cpu_obj);
> @@ -572,9 +561,15 @@ static void kvm_riscv_add_cpu_user_properties(Object=
 *cpu_obj)
>                              NULL, multi_cfg);
>      }
>
> -    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
> -    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts)=
;
> -    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental=
_exts);
> +    /*
> +     * Mark all isa_edata_arr properties that collides with
> +     * a KVM property as unavailable.
> +     */
> +    for (edata =3D isa_edata_arr; edata && edata->name; edata++) {
> +        if (edata->prop_name) {
> +            riscv_cpu_add_kvm_unavail_prop(cpu_obj, edata->prop_name);
> +        }
> +    }
>
>     /* We don't have the needed KVM support for profiles */
>      for (i =3D 0; riscv_profiles[i] !=3D NULL; i++) {
> --
> 2.43.0
>
>

