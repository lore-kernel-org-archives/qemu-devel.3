Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D98CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfG6-0004DY-DG; Thu, 30 Oct 2025 22:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfG4-0004D4-Rm
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:52:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfFs-0003XJ-Iw
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:52:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63c4b41b38cso3562428a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879158; x=1762483958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DN2eO+00VwYRvZHlszZLVnLZ8vC/4eXpWquc99/6PjE=;
 b=XhB1lQNTDF18KW/YYPuDfINn1O564qm1j9vKjld19v3UTBKylagQiUnAiQRr9AEVMK
 bfNRHL8TuA8YUPYd/UGKitz1wppZHq09MDfUGCMVIh304v2La47suqaHGQM970foi6Bm
 k7Gr5gR2o/GTid61ZPJp35u/4qjPu9FXGp762Jgz+40spMmaUTmXIlPGqAxBXUpuJ5KD
 KiaqML2VK6z+jvkxDJwq0vfPjewlTR6yKEXj2r2zTS8fjOqkRvkCV1o5G+EVmEGy7QIn
 J61LG0RXj6CryKpRVyh6/jsQUDdaW5KfRGcnViVwVSUZWm89tCsQUmN+MXSrY7rIZxN4
 Hvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879158; x=1762483958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DN2eO+00VwYRvZHlszZLVnLZ8vC/4eXpWquc99/6PjE=;
 b=UDAqmbqcsNiYRBkKCthTLXTLUrIfcAJiw0kuqfhpK6vF5tOP/eun3TWC+D9K58lxU5
 QTsOpMcXBcPw00Re35aL6Tv50F0yioL1zdfzdSeRQwTI+Z3fq0RjWfqRjq9A/Wpk5cf6
 q3XRZoFDpoPcTf/r0oFwtlcqs2UsTCVI0hXJKDLs7p+cHKiuRkme1ks8Ig8/kz83+aPC
 etXPTFynhRQP6opsfvCIEPDQSY8yY/4dH18DuVFs3NpLu1IwxJ6GWF9Nn5EchhgwiK2y
 LtQglsPnjQtF1N13Pk61tlOUbuXGnCFlqOnZ71iHTE/3/Fyu/X2RGGPoUHiVP9I9WVte
 y56A==
X-Gm-Message-State: AOJu0YwC0RI5WvospHN1Wdp8moXBXcjG+JkIjazDY4Oaz+ojlAMuTsCF
 wCi2K41x5yC1c/GFSJJPNFIxF6PPMwq/CW6mbp4oZZkyKKcUIf6P6ee2pOfwbURBoXU0K81hJ65
 wZTc6Oh4EL/D3ii70mCjH2xt7d2cRpfE=
X-Gm-Gg: ASbGncuIWI1n8OIt1jplo/U6HogUgcT2aWkVGNRKkHj1oOcw10pmHfALXG+vsaN/2XO
 P/HTQrtcAdlJ8CXHdXSz4eWB7UUV5r1VJmu1L+ofKTvnoj1Vew7b9e6qlwvDicoySbzq5QopZdv
 lgw5qgRA832raXcHxDDLPsliFVM7gN/yGf+k0hMvDZzHR5++g4H+wZ5J3zUS5KHH7yCCiBIuHY4
 nEKhSudDUE0RfE2N2YWRS07OEogu0fUM7qzaq4m6/1dA46tAbSB2C+GrzuQ4082EpZHH/LaCCa+
 sbff1/xtnHI6d/U=
X-Google-Smtp-Source: AGHT+IG0LH/E8yzlMdSzPZHD9cil0oTwz62VphYs5bywHx+5vHdasaTHUJX72z1ywjss7vvKJxMTbiToiUL8TpVfyYo=
X-Received: by 2002:a05:6402:26c6:b0:626:4774:2420 with SMTP id
 4fb4d7f45d1cf-64077018355mr1429909a12.20.1761879158565; Thu, 30 Oct 2025
 19:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-25-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-25-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:52:12 +1000
X-Gm-Features: AWmQ_bniApzw4BHgKlBRC3S01pN_Qz_wnpAjJI3BvkmKJddl8kkpdSFJUSIi_yc
Message-ID: <CAKmqyKPvnuLRhAo-69JNaHcASmPtCJQ0CNO=zpqKC_3sL7A+kA@mail.gmail.com>
Subject: Re: [PATCH v4 24/33] target/riscv: Fix size of irq_overflow_left
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Oct 28, 2025 at 4:24=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix to 64 bits to hold all relevant values.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d6ad0e1896..604a356292 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,7 +224,7 @@ typedef struct PMUCTRState {
>      /* Snapshot value of a counter */
>      uint64_t mhpmcounter_prev;
>      /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trig=
ger */
> -    target_ulong irq_overflow_left;
> +    uint64_t irq_overflow_left;
>  } PMUCTRState;
>
>  typedef struct PMUFixedCtrState {
> --
> 2.51.0
>
>

