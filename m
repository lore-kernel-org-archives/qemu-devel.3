Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73288C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree3u-0000nt-N2; Mon, 26 Feb 2024 11:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree3p-0000h2-8c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:42:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree3j-0004xG-Ux
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:42:36 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso4236849a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708965750; x=1709570550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QkBRgOqryAmNxb1waI8xBDsOVAVJ/bcpv8hsuSt+q2Y=;
 b=Uc0siva3rihPY8xVUKl0wd/zO6CWjZuDzisQJcPjyM9fK70Fl5kvMtyqRSxdGCf4OR
 hgIsSBkeyTITYbrx/6k/mj4It2idiaUzbygTuEs+FKENZ9dkb5l1Smswnjqg/EmOWsCC
 G2T/+iQ5lvrgmCJ0MFMPuzbL1Kc+D5BwPtYasiJcZjHaGKgqg25Zxx4rIHJBsU9DxKJW
 O6jENKlNLZS08pgG80AjWhHA4VEmJiTge/BUz/7dGJ5iFBQl4Z5RrzY+OpGPHFmx67Ei
 vVbe/uGHzHu1Nh/VA8ocnRy21IkfT2ZzzX1JqMh+5sauri+eFOnyOlWZGM/l7UdnwLdE
 wJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965750; x=1709570550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QkBRgOqryAmNxb1waI8xBDsOVAVJ/bcpv8hsuSt+q2Y=;
 b=f93+ShqNjnDsXLqcAGb5vnM0kZ/Wcjdlh4+E+utEw5/iB/wlsRYvd0PTHnStlXumuI
 u59fI2TOVFGTxCPR8O2Jpbykky0NTZNWAhhAoPE919TqBJXYjFAyQQkWW+Vped7B5xny
 oAu0gcqtI80woXZvMdC89IbxCN3Gyw0mPL+krJhHBjeOJG2kwAkGn5jhEMYGxbG4cZZ9
 p/FKX92TOG9Iqnc68qVlXhX24L4mJ850lH+RrRRDn5pCN0GbP4ZtXlix5JVU4kzvutLZ
 v0adLYVarWTvEduwPqpTisWkZA7IwbNVhASp6nhi3jbhTyNMAg4uATGOeunuEUa+XoS0
 6r+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCmdj2JS3ZwIMldj3ABTe5RKUubrsPg/NjFYPGtlAukp2dO5KRCFyfItvhNbALl0GHRhh3yL0TiznBnmtJPsifDcax7mI=
X-Gm-Message-State: AOJu0Yxw9RZwvMANIdhRdh/dv4cxy9uRFMSPai3ynahuRR/Doypey3fs
 b2TnVj6YG+sicXa+1sDOa2B2NdMSaMmYudE7i4ddDSreGq5qpSEknevy8cWc4CRqJKJncCdLj+T
 s+v+ofjDTPfsUlalEnZ3GG4aiMy6aSn2Mfejbrw==
X-Google-Smtp-Source: AGHT+IHiu9KcBqpQnAYpUWjUFrxlfdkegshelZnVs6vafnZTQ9qKMeGVT2RlbV6g7pxHsn+iY4+5eclXru/otnOixq0=
X-Received: by 2002:a05:6402:3411:b0:564:bcb1:45f6 with SMTP id
 k17-20020a056402341100b00564bcb145f6mr5193402edc.15.1708965750672; Mon, 26
 Feb 2024 08:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-42-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-42-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:42:20 +0000
Message-ID: <CAFEAcA_xdowvZkxFC7ypEFRJSTLDkdx+9E3_fwPNY=S2sK5=UA@mail.gmail.com>
Subject: Re: [PATCH v6 41/41] Add RPi4B to raspi.rst
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:03, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/raspi.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
> index d0a6f08b2b..c21b27744e 100644
> --- a/docs/system/arm/raspi.rst
> +++ b/docs/system/arm/raspi.rst
> @@ -1,5 +1,5 @@
> -Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
> -======================================================================================
> +Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
> +======================================================================================================
>
>
>  QEMU provides models of the following Raspberry Pi boards:
> @@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
>    Cortex-A53 (4 cores), 512 MiB of RAM
>  ``raspi3b``
>    Cortex-A53 (4 cores), 1 GiB of RAM
> -
> +``raspi4b-2g``
> +  Cortex-A72 (4 cores), 2 GiB of RAM
>
>  Implemented devices
>  -------------------
>
> - * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
> + * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
>   * Interrupt controller
>   * DMA controller
>   * Clock and reset controller (CPRMAN)
> @@ -34,6 +35,8 @@ Implemented devices
>   * MailBox controller (MBOX)
>   * VideoCore firmware (property)
>   * Peripheral SPI controller (SPI)
> + * PCIE Root Port (raspi4b-2g)
> + * GENET Ethernet Controller (raspi4b-2g)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

For the "no PCI/no ethernet" initial version, I'll drop these last
two lines; we can add them in when we land the pci and ethernet
patches.

thanks
-- PMM

