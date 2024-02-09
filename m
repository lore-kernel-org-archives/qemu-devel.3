Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE13C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPCm-0001Yi-5D; Fri, 09 Feb 2024 06:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPCg-0001Xs-T5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:38:00 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPCb-0007dP-5y
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:37:58 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso1160803a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478671; x=1708083471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enA0BaGEMntcSBBNdJOGJgh98BdDjEDU+UY90EJ7IWU=;
 b=S5KKBbQIhoGu054u+NZf0ylyrbZA02sCDtmtIMIn9ovDhglOcZXYvDxXhVEsC1wbl5
 88gr8FCwCMt5nn/tDXmREuIa6u59RsOdKbaTKDMXGIA0ziGXPTvIZF+0w4ZYPlcywteL
 S8tcfyazLxM/9aoBVuSMvfFp7U8PTWZ/0qgQyzH87Zhy/0scg4kI60wlQShwYQYPOtxD
 F7IxJfHbnz2YvngBnPWH8Q0ug0zd4yNyjxH4cALQFFg0TddJuXJn589227ZgzRywwkHQ
 fX4IBKXiEQ583IJusgCJ5WSjiuaHILlQ//C+JmRpb0uP/Mb18jAA4vC/R02SP6PHy5oA
 xEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478671; x=1708083471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enA0BaGEMntcSBBNdJOGJgh98BdDjEDU+UY90EJ7IWU=;
 b=rssQisrKj3i7G3/dWa+hLpbQx0mE/Z3kU5VMeuVZETQJTckzzN9ufXkavDX5MuxMHG
 8fUWnZefpEwGV+FthfwdDj7gyh6u6WdKFE9xdtO1lc+l29Ps+otafrLTp7U0UJwhUqjS
 PGdoCcJjJCzCsaKbkihCiat3JclsKehH5n4zgS7HT1H7U2ZYTD2pRzWy42LEIkM/FyiW
 jENocfOFEY08dmXG/p4t2hU6M/d6vVAKsL7cm8wP1D94NkuCi6hnRLk/sRumo967etgS
 01p3Aqd8mvsRIwZ5tF2LUcbdAXLgkitpeR8lt/XTDrxqXfpNZLdL05NwBWDD9yoGd8zv
 r3Jw==
X-Gm-Message-State: AOJu0YwspJVrm91LCRa//PIvPNoadUFwE1fAzd9yAcTw1qrNZZQFTbp0
 mIh/G8mFTQxZZJGpQvPnrauSGFR5v0W51qHQl5H5El2Fx732MvXM70NmzpcHm8elLlvqBZ6ob58
 QceHlQxGKVKkQ52n2JspJ5TD4HFOtwTBX4csxgQ==
X-Google-Smtp-Source: AGHT+IHY9Em2AyXBP5G5TF6PQLzNHQtev+B+vURlDpZGtkw7MtqRn3xkyi690rXnIZ3qI0JZJLKe9H6xmixVeQvf74Y=
X-Received: by 2002:aa7:c408:0:b0:561:2711:9585 with SMTP id
 j8-20020aa7c408000000b0056127119585mr1146616edq.32.1707478671371; Fri, 09 Feb
 2024 03:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-9-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:37:40 +0000
Message-ID: <CAFEAcA8uO_TV=oezQ4+Ha4yjoP3oB5EVNehWkfnqfRudh_gwYA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] hw/sparc/sun4m: Realize DMA controller before
 accessing it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/sun4m.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index e782c8ec7a..d52e6a7213 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>      dma =3D qdev_new(TYPE_SPARC32_DMA);
>      espdma =3D SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>                                     OBJECT(dma), "espdma"));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>
>      esp =3D SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "es=
p"));
>
>      ledma =3D SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>                                   OBJECT(dma), "ledma"));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
>
>      lance =3D SYSBUS_PCNET(object_resolve_path_component(
>                           OBJECT(ledma), "lance"));
> @@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>      }
>
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
> +

(This confused me briefly until I realised that this function
is reaching into the dma device to find child objects to connect
the IRQs to. Perhaps it would be nicer if the wrapping 'dma' object
passed through those IRQs to avoid that.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

