Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB14C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racV0-0002I1-9u; Thu, 15 Feb 2024 09:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1racUt-0002Cg-FX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:13:55 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1racUr-00074U-NN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:13:55 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563b7b48b9aso621140a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006432; x=1708611232; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiTGB6KKp0wG3lVP4vPXbHMx1ObJEV//yPylyml/O6s=;
 b=zdJ+FKdtD3USrjyD7mVATB3wCoSPeKJXX+PsO/7BFBNhhKGHt/n4tN67JN4okcYARu
 jLbo6hi9j5Kdsbl3HCz5INC863U1qxZ7moXqzQk1KnmskOY9K/Z4/G+MEhavhJ0gdwRk
 NHfsECbn9ZR/QQ0sLWDRvVuV7Or/8AIJKCgtqKVd2OvqO1YzfXQMssTjM2Xp3GxLxG8B
 ODYFA+KiMXRMXb5KUWu/FTJU4Uo1OsT1AmDS/Mv8JYMmrQFNzYOBWZh/Mr4kh2Lpiq7V
 O7E2tgRjL2u26kkHHoaQcBJJq+uVU3/4Hjg/6T46Fi1UyAPowlpzKYAdH7jgoC+XnYVt
 mfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006432; x=1708611232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiTGB6KKp0wG3lVP4vPXbHMx1ObJEV//yPylyml/O6s=;
 b=lOVLcK4tfkdUUXyiY4ZN0bRCvtVGmKU0sT8cdK67LxpfoYNGMTRun2igxJnnE8CLrP
 XWG/qqDs1hw+M40bRUiF8QAZAWf8aHQmrdYp7RNV2Cxeb0r886627QrzYPLJKYjEBX+m
 XOWRWZgQyopDtkuM8HVZ53AWoTSdPwOI2CqrgLevDWa5Ka2DCliuOKtACdQrRX+DUeQS
 QM4SFwOwldsIPjkSNlV8JhAg/FupUPZC1/ukuq6WFIPUfprYn+IOTUSYeA5iwt5jDtrT
 4XTiJu8Le02fCWFEUSIUt9lRs8fAh6fqn9xWw7YvgGuNV1ghHtKHrxazQzBaVIizsXIY
 cbLg==
X-Gm-Message-State: AOJu0YyceHutlI3Ji7IOl2ZRPrvKWRrxGe0+HbxGRkznKIa7sPkflApe
 gh7mIqeKu+LLn1HSX4gBF4j76l2MSIy6M7NZZ6DP/FecAIS7enT4iSbmMvgvfQIboexnQKMeEm8
 DUq/3Cjykzv20nfrBY9Y2h9OAeyhK6GqkEBsuIw==
X-Google-Smtp-Source: AGHT+IFpCgk71dCyH0lnXiL8oZsCXXvIBtEhRD9+EPg1Zqg2JKnQ89uv4F3JUi8GrakS+g/UKRm7ZYKFjnjMiCuHdWo=
X-Received: by 2002:a05:6402:2904:b0:563:c22b:2b40 with SMTP id
 ee4-20020a056402290400b00563c22b2b40mr676822edb.21.1708006432209; Thu, 15 Feb
 2024 06:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20240215132824.67363-1-philmd@linaro.org>
 <20240215132824.67363-3-philmd@linaro.org>
In-Reply-To: <20240215132824.67363-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 14:13:41 +0000
Message-ID: <CAFEAcA_we0joWBdAeyhRAAWaTF_gZSSUVJTNv=jQwpS+cUUuGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sparc/leon3: Have write_bootloader() take a void
 pointer argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-trivial@nongnu.org, 
 Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 15 Feb 2024 at 13:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Directly use the void pointer argument returned
> by memory_region_get_ram_ptr().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index d096fb04cb..8717c72e77 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -94,9 +94,9 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr a=
ddr, uint32_t val)
>   * state (eg: initialized by the bootloader). This little code reproduce=
s
>   * this behavior.
>   */
> -static void write_bootloader(uint8_t *base, hwaddr kernel_addr)
> +static void write_bootloader(void *ptr, hwaddr kernel_addr)
>  {
> -    uint32_t *p =3D (uint32_t *) base;
> +    uint32_t *p =3D (uint32_t *) ptr;

I don't think you need the cast any more now ptr is void*.
(If you do, then our coding style doesn't put a space after
the cast.)

>
>      /* Initialize the UARTs                                        */
>      /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> @@ -338,10 +338,7 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>               * the machine in an initialized state through a little
>               * bootloader.
>               */
> -            uint8_t *bootloader_entry;
> -
> -            bootloader_entry =3D memory_region_get_ram_ptr(prom);
> -            write_bootloader(bootloader_entry, entry);
> +            write_bootloader(memory_region_get_ram_ptr(prom), entry);
>              env->pc =3D LEON3_PROM_OFFSET;
>              env->npc =3D LEON3_PROM_OFFSET + 4;
>              reset_info->entry =3D LEON3_PROM_OFFSET;
> --

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

