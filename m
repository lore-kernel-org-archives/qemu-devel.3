Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C674C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIK6h-0001yl-HH; Fri, 23 May 2025 00:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uIK6f-0001yM-KL; Fri, 23 May 2025 00:34:05 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uIK6e-0000sn-0y; Fri, 23 May 2025 00:34:05 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-52b2290e292so2646820e0c.3; 
 Thu, 22 May 2025 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747974842; x=1748579642; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjUh1CwUK8mxoZVtJGOaaznjNCixznMw7V0d99g6Z5s=;
 b=WJe3lHAXgt+O/WK4x7eS0sH87iK7GgM6z7cxEdKhptRRVywSHxaDHGBcFaBD2QE9R/
 sS4mOYKlsybdy2YIkEAjLz1NOtMUmDHD6wfP1ottEwTwbTE8rWmFsC/RCuJRiaAN8gTp
 GX1pmEaMUUHtANNYFdPD2j508T52+vaKU4zbH8C1nSHUT1zF94yCWvjLTCsUTeeS/LT0
 psVp9sBtcfvzXczitynAChNf3AywgVqPR+ncQJ0fdX0ytj5w0+liKgUBAzH2xJywCtdV
 kbFrSAaHuvZUdbDwoA/kswWO0q0nO+5TWHjM/9Ko/rhroxOYGyPqywc7V3r5UUO3Tpqy
 CCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747974842; x=1748579642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjUh1CwUK8mxoZVtJGOaaznjNCixznMw7V0d99g6Z5s=;
 b=VIIR31RPaQOCei6/QNfVke7OYGqWu4WvptO3CKU/GRPqi2iSHQ9ZT92yoV35egZErt
 8XNEHIP1WimI2CgLziAZArDU8NMK7bCqSsu71furLPqzzgqCNDrJaSeE5gA4Wk25Bqws
 eOTu6LAVZtLyTdIlGCfMRN7b1TkZa9g+HjdiBp3syIMOZobrmI+e6zzNpif5UnwowlmH
 0bx7DsnNuyuYhBFse7GpugbTlHDET0JDe4rPxWeRRqI5Xms2HKzKmdLsD9/OH94ehl71
 1dgKgGQobaabQL524KKnkr6jJMWGiUKDDxlMRz/NiBUio0h2aOFHnSeUVoN5UEsUDCgr
 Q5Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlYpctjnsJdV1jC4FdDX059THOwI4N1GN9mPIsLZRdG4MarBa6UE7sZsuIpE3N4ZzKoMMwQ+27lAFrOvkx@nongnu.org,
 AJvYcCXwkY9tLnFNEb0f4ls7LCqTmPHeJsAlJuOeV/aYiguUKAWA7Po7JNmGPQFEklsh6SlEgbx4a7bc8XGD@nongnu.org
X-Gm-Message-State: AOJu0YwHusJYMqAKmTW1DlTdepz/mp8OTaySMSESdmKlIDpYGuZY4aJ6
 8dnrBmJX6vQ6iylKH4FKMrFMiGnWr8Csv3DdMolaPTcHNSttf2qOUQwDM4owUwUEZI0hTTC3FnL
 azipBSjGcw9x8fHGDfFoxjwQ5zyEJZKA=
X-Gm-Gg: ASbGncsawc/9wkCTS+BYEySHoXL3KlWebvWw784BDeJe+CEBvQ4sKDHyA1sBXjoWnCB
 YXjmAZS2Di3jFEDRooPJu67RSfEULT3hNm82E+9qwQ0UqTz99kCU3GGZntBg6OHYe3D/V4K2llG
 kCIkMu23l/1TIAw8Ti8UuKfEHT8F7GBgdGFYUX6HkqQNmgkBsTG3d4UxepFfY3G6gOLi5mkC5sz
 w==
X-Google-Smtp-Source: AGHT+IEVv+9EEHvPwMxe9SN1kFob+xb21Ha7XvvZ/7OBW7H81LCKuluWz5DJhMUVTx7EWNS15i9ifE+Z8fdlzwGTz1s=
X-Received: by 2002:a05:6122:da7:b0:52d:b8fc:991f with SMTP id
 71dfb90a1353d-52dbce2ab91mr23408406e0c.6.1747974841647; Thu, 22 May 2025
 21:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250522113344.823294-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250522113344.823294-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 May 2025 14:33:35 +1000
X-Gm-Features: AX0GCFtcBwjofdAJJ0NHsNuJgfYSQQTpNLNasjZYySZDQv0Rv6eBR8FU2ARPwZY
Message-ID: <CAKmqyKOY+Wxj+uHzUXvyFc7sTj2459__YYGPTz-GRTuEoH2rbA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/cpu.c: fix zama16b order in isa_edata_arr[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, May 22, 2025 at 9:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Put it after zalrsc and before zawrs.
>
> Cc: qemu-trivial@nongnu.org
> Fixes: a60ce58fd9 ("target/riscv: Support Zama16b extension")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..fe21e0fb44 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -127,8 +127,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> -    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> +    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>      ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
> --
> 2.49.0
>
>

