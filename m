Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86572C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxFO-0001Zd-3A; Tue, 28 Jan 2025 20:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxF3-0001T3-VA; Tue, 28 Jan 2025 20:51:46 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcxF2-0005tR-G8; Tue, 28 Jan 2025 20:51:45 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4b6398d477fso1874946137.0; 
 Tue, 28 Jan 2025 17:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738115503; x=1738720303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Yohw8QFLHPuMEmNOOGbOPYydeiVvXPdbpMJ7UJSR3M=;
 b=Mr6JiQyzMNuq4pWQ3vteg0t/WJyQ0FHsDrDVxhm7Alwgyxgy/Vh5RjTLXQo1CfJPVi
 6pqAt/V0gfhEtMz1KPkter1IVsxsr92sKOBETyFSnqSlZ/h/890wZtsNanFFOETgUFno
 5BmmKf2Lpkg9L7NjDOF/+hTkAzNGCpbP5tCpOVIY8CUTSL8MUnY2fKIsJ/fLhblFvHvf
 qDJSbXHW8ptTrOPafFH0UtFxFHcIUA5xpqM5zO3leJQ6tVpAB1pKQmfbcFDfQXLGFMZV
 xi9zz+801NKMLGKp/PWmFS6XDMlybqhFnCoElCVPT+bcTs/Kz0dPp485cquqZ+94kUI2
 j1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115503; x=1738720303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Yohw8QFLHPuMEmNOOGbOPYydeiVvXPdbpMJ7UJSR3M=;
 b=A9FesXpOBmWFGA1YoJ4o5D/3FywqpVZF935wguQiWPFPt+4rGLxBi/e7opmJqD8idM
 xLscMTiEocsBd98EC+My+VoI74fYJhEts2FBMWiHEutlyiMNGKaN77PtwSSGdVE64qC+
 dU50z88yaauNM5AXc3k9R2q4HfotNsXPG/l/GpXfB1FOLq54829FJ74VHhXY5mk5ZeCl
 e3JNBxhK1Cc4ZJwV8aDm9NiH0yk6ax+tBS5OSnQOv7aMb8SuBpo0jR3HqRBMEt4qwMTX
 4SREofOSs7fTC74YYVTxYUP9qlPxqWOnEfkIIp++GeXV2AUK3tk1glGD6sqLxXxmMv4v
 zTKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpyP4zMgJM6ff4Pw6xC98zYbPlgwmLPr4T/ABWBW6vrNmsOlKQAnfyO6Vk+Uxesc+h8GMcAUxNB2r6Jw==@nongnu.org,
 AJvYcCXj9ISqeVVHmpGSvgRu2CaNq34ovtVep9K1Wh+lcOLW/QGmzFTmU/irqV4qeIA2AzEQhmgpk0q15Eo2@nongnu.org
X-Gm-Message-State: AOJu0YwQaNFtbjfMissOrowvE2QMvCFVL3qnbXBXusJEQ/ATn0tYfCMx
 pWSbYC5Jb79OTPXV7ONRZkF9JgnXSDMSAitXgez3SUphVZKj4IDA7ehEVmRuA3842CdY6aA0kBx
 ZKasHAZwFe/pSKry/tXvBRXMXcFg=
X-Gm-Gg: ASbGncu2EvwHdx4lmlY6/a9KSX9acaUU9XG47YoMGHyZsUvbrAl7PYzV9yED36U7T1l
 4uQIvBhWx/22sZlxVCoGRe47ylFhIqnw8Kw+tYMGK+CAKTzbToqyvo21CuXnicQyChgkNvLB4r0
 SyOAftZn+nxQSbWKgdK9mBUM2WMg==
X-Google-Smtp-Source: AGHT+IGlDiZCezVm4OT2ihiUTejNo55NogpI6srQZeGX90I7ShfDT0XX4nAbCQUiQR0KNBbLyYORqEfsbP9AXhWaHtY=
X-Received: by 2002:a05:6102:d94:b0:4b6:18b3:a4db with SMTP id
 ada2fe7eead31-4b9a4f10949mr1169635137.8.1738115502824; Tue, 28 Jan 2025
 17:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20250115035105.19600-1-huangborong@bosc.ac.cn>
In-Reply-To: <20250115035105.19600-1-huangborong@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:51:16 +1000
X-Gm-Features: AWEUYZlgSh5Y52ktMO-Z9ZT9WPAbpbPD3Bkze2p0qW9IQHpk14ATXUAiWVXN5t0
Message-ID: <CAKmqyKOWkFyrhBHT1wFdfmPJSSRZom1id+cV8KXpioMFDaw2iA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/riscv_aplic: Remove redundant "hart_idx"
 masking
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 1:52=E2=80=AFPM Huang Borong <huangborong@bosc.ac.c=
n> wrote:
>
> Remove the redundant masking of "hart_idx", as the same operation is
> performed later during address calculation.
>
> This change impacts the "hart_idx" value in the final qemu_log_mask()
> call. The original "hart_idx" parameter should be used for logging to
> ensure accuracy, rather than the masked value.
>
> Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aplic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4866649115..0974c6a5db 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -421,7 +421,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *apl=
ic,
>              APLIC_xMSICFGADDRH_HHXW_MASK;
>
>      group_idx =3D hart_idx >> lhxw;
> -    hart_idx &=3D APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);
>
>      addr =3D msicfgaddr;
>      addr |=3D ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK)) =
<< 32;
> --
> 2.34.1
>
>

