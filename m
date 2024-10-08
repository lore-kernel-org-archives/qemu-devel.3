Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60174CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyut-0008FV-6W; Mon, 07 Oct 2024 21:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxytg-0003Gf-6D; Mon, 07 Oct 2024 21:20:20 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxytd-0000Wt-L7; Mon, 07 Oct 2024 21:20:19 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-84f44816b1eso974009241.3; 
 Mon, 07 Oct 2024 18:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728350416; x=1728955216; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rbYRBfYga1tuey+kEmP39XDZmz7Rkg7RYbC+Fwev44=;
 b=i7094ypAaG3g9nZ7jhow6VO7j7bmbokMJkGKEAb3trX6aC+Ze3VRHinr+bLaeK75/h
 Is7E5ieGwpShY1wiRVdQqjwCdEyzCoObMTmTJpZWlXWhLTfKfPe8grhxJZhtCzxLcpnG
 J+V3WS6E1TowLnj8pihphS8ah7ejG1lmdmXEcGGKbJQl/9psZXPVBwAfrPKxc5Jpj1hu
 Qgr7aDhldY/obmyAvF47pTO53s/WvkXiq/W3c7S4aXsH5lFLHM6PDD96wY6TW2TSV42x
 F9Qxcn472d3UwsBx28JvyGJgvkG7K8s53oJxvPrEr5XudUrQ2veF/zaKDIw48Rmvx8+B
 B7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350416; x=1728955216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rbYRBfYga1tuey+kEmP39XDZmz7Rkg7RYbC+Fwev44=;
 b=IxloRV9u7BcToEVSECjvZW18raC3QGoHnnhuQdgTD9yTLJr5IyUJ8iq0Gr2HGWEG4O
 L6vKNxztKZ+MBQIwvq7IJff/t6lS8lIlFFcRwKPN7E5+IOw71FOxFM8gFtgthuVt8z0E
 mRuzYEIWFcVhl88q2LtODHMZRIBsJXGGM9vna8EPS9fFQ2fG/RT65jLOnH8JUApa+LEB
 LJtqC/9N6N7B+IJnQs4TUjIMHUf1uXf6lXk9BkCnR7lhNNKOk2B8iBiFEW2DpCEXvOke
 B7DR9FXANxyfSiMjsoXXKBVGOCG/HyZHSSxl3ZF7EMYk+uYcbNgqDMzFiE9C1sz3aHMt
 im0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsVqTeZpcc3wb0LS28ZjA6x5SSmX44MiLNQNHIDepVFWG8bMN5MufD/rfjNsi8a7U41HIZ0FRh63bv9g==@nongnu.org,
 AJvYcCXRcCPEQ6J0kIrtRaUkDt7qLpBCjdB7Azvy3N+woNEEeL9H0+Nmb7DoGhnuj18LgqmqOMuViCBwzZCu@nongnu.org
X-Gm-Message-State: AOJu0YxfQhSf9SM8lZuN/wJWel2955WqRwLoGfhyMYF08QBA5gj5ALLv
 CuoDcOreXoH3T1O6ZmGg/UZIU29Vih32AcG2dxelxCLU10DRFPfXNQo4jdLT8XjYyr7n9x66PPi
 z1Lo8qcjINdD4z2h2sPmk/C1E8wg=
X-Google-Smtp-Source: AGHT+IHxQfS1cYiAkZWrPtd1Py4HQPE4YNl+b11VhUo1PmyRMAQXir+r4b96vgu8NFWxxTe6g0kp539QlL9UEm5bDFc=
X-Received: by 2002:a05:6102:2ac9:b0:4a3:d99b:9970 with SMTP id
 ada2fe7eead31-4a4058caf21mr7885908137.19.1728350416125; Mon, 07 Oct 2024
 18:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240918140229.124329-1-s.makarov@syntacore.com>
 <20240918140229.124329-2-s.makarov@syntacore.com>
In-Reply-To: <20240918140229.124329-2-s.makarov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 11:19:50 +1000
Message-ID: <CAKmqyKOpBe9jYQwV9JsdsLzgs=rOJnS1g0Q7ER2WTd_JdqdzCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc: Make zeroth priority register read-only
To: Sergey Makarov <s.makarov@syntacore.com>
Cc: Alistar.Francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Thu, Sep 19, 2024 at 12:04=E2=80=AFAM Sergey Makarov <s.makarov@syntacor=
e.com> wrote:
>
> According to PLIC specification chapter 4, zeroth
> priority register is reserved. Discard writes to
> this register.
>
> Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/sifive_plic.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index e559f11805..3f3ee96ebc 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -189,8 +189,13 @@ static void sifive_plic_write(void *opaque, hwaddr a=
ddr, uint64_t value,
>
>      if (addr_between(addr, plic->priority_base, plic->num_sources << 2))=
 {
>          uint32_t irq =3D (addr - plic->priority_base) >> 2;
> -
> -        if (((plic->num_priorities + 1) & plic->num_priorities) =3D=3D 0=
) {
> +        if (irq =3D=3D 0) {
> +            /* IRQ 0 source prioority is reserved */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Invalid source priority write 0x%"
> +                          HWADDR_PRIx "\n", __func__, addr);
> +            return;
> +        } else if (((plic->num_priorities + 1) & plic->num_priorities) =
=3D=3D 0) {
>              /*
>               * if "num_priorities + 1" is power-of-2, make each register=
 bit of
>               * interrupt priority WARL (Write-Any-Read-Legal). Just filt=
er
> --
> 2.34.1
>
>

