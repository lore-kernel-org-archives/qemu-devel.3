Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89BFC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3Vo-0003Zb-Lw; Mon, 03 Mar 2025 05:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3Vn-0003ZA-EE
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:59:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3Vj-0002pF-Vf
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:59:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso28918535e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740999538; x=1741604338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdPHSzncsJ65ha1HztjfPfZ8Lx5OaT6cZdisWVT/GOY=;
 b=hu/gvHX/ov5ORuaPLybhPCVNEwNuachdTImPH5l6UA9dyMp8cZ2gLighhGB3AO7iyS
 s91ZxSgfKfrAbwJpSJ8Sq5iSblrL3zs2C8fI6dbIV915v7xVB6dBuzF50jVZ7g4XW7tW
 K+2oNExl28XQuIyB8LrX8vy8tWUTBebbUWphpRhNlYDAGZCj+MLxDZlA95mA4VjrFJE8
 Zdc6ne2BJSLCYKu1LFLRBxyGYzSWLRu4um8LpSGa9hdiA2KN9/je+ltLQbT90ICvYImK
 lTdIr6uvNsB0Y4UITXrZnkd6JtoeIb12mXLlQgihF01M4abrw9JlEWdMxQ9ZARthm/+u
 gL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740999538; x=1741604338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XdPHSzncsJ65ha1HztjfPfZ8Lx5OaT6cZdisWVT/GOY=;
 b=UkVuXM4yTUKhv163XpCjFz10A+UFz133ktYd/vUN0pVWHPiiRGkwqsH5rX6LdC4Xn4
 yae38/AUkpGJ0AfexpGyBB4Dix1tiJV/Szea35yjhTMMBMaTMVP8bpZJzxcwBKmuktxN
 41XQSa5ZBU+b240pfzbiGmRKKCrq6KR1frvQfUGAmfsp6zRndlAANFyW+qmdTgKrBkl9
 fQEbqH254aVGZWJVFbw5j4X+XCXo0sYUJAidijDjkz1EoLRg3hfNGm52S3/vemKMqai2
 //2+oCdD5bo8g1bfANyTnfyQ4nze0ql1/N1zLlfOCv+Q+lQMGIbt+HDz7XHu9oAhKiTj
 4M5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVoT5hEmbHTzOtAvEkv9weY9JdKxnzc2SoNCCwYbicEhlc8Tdza/aMdD0GFug60BRRmpPFnB6qo8Zt@nongnu.org
X-Gm-Message-State: AOJu0Yy+JzqpNP2yvBwvhv/Lx/POi9bnSL198I64EwFpM/fELO+Yercl
 iNr0RquBXCU9smNrS4pNunPpiSIO7XgbwruUmtsEYF8dmq1WQ5tS/KnvVNmOgdU=
X-Gm-Gg: ASbGnctWJhzSVq5A8C4r0KXnL9G7cTHG5KkA0MkytHmgRxR1OWml3Yt/HNcKcdpCYBg
 W4hD2ZnGliUi6yR2FgqAKcQckXvQS9LMZoXuXYj8DtEJpXjBS3bl5UcDLSA2fhn9S7zKpjioNzT
 094DdZ67zHMISUv93u4Rd4DsjyTk+dYxJ/j2QvMFf/sMuKb4th5wPf7IpTpHBBVXAHyVSDxCt5q
 x18Qp220OcwPVREw+mKW/p1gzMGucRdycKjDle9zukMDaYE6pDbDZ8JFIHeQvr/CiZ0lg4ZXT3U
 JJd4pVmEXqBGqK6z514MEIpzPzzNMdN7TIMSFD/yENHp/uDtdUZumQ0y+yOtwWTPZqn8Bzx/2Fn
 UEhzX6gD9mWtY
X-Google-Smtp-Source: AGHT+IHnKvPjTnGsMu4AbDZ8jFM1eyMnjUqrkJZgcfMrXAax9qfNF8ODMPVSTwoHQC0ixFwWjhmIVg==
X-Received: by 2002:a05:6000:400a:b0:390:f6be:9a3d with SMTP id
 ffacd0b85a97d-390f6be9a90mr8713624f8f.35.1740999538007; 
 Mon, 03 Mar 2025 02:58:58 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d785sm14033805f8f.83.2025.03.03.02.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:58:57 -0800 (PST)
Message-ID: <918e9ae0-fb22-43c7-a2cf-376aaee0e98b@linaro.org>
Date: Mon, 3 Mar 2025 11:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
References: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 10/2/25 17:03, BALATON Zoltan wrote:
> The interrupt enable registers are not reset to 0 on Freescale eSDHC
> but some bits are enabled on reset. At least some U-Boot versions seem
> to expect this and not initialise these registers before expecting
> interrupts. Use existing vendor property for Freescale eSDHC and set
> the reset value of the interrupt registers to match Freescale
> documentation.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: Restrict to e500. Adding a reset method in a subclass does not
> work because the common reset function is called directly on register
> write from the guest but there's already provision for vendor specific
> behaviour which can be used to restrict this to Freescale SoCs.
> 
>   hw/ppc/e500.c         | 1 +
>   hw/sd/sdhci.c         | 4 ++++
>   include/hw/sd/sdhci.h | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 26933e0457..560eb42a12 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1044,6 +1044,7 @@ void ppce500_init(MachineState *machine)
>           dev = qdev_new(TYPE_SYSBUS_SDHCI);
>           qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>           qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
> +        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
>           s = SYS_BUS_DEVICE(dev);
>           sysbus_realize_and_unref(s, &error_fatal);
>           sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 99dd4a4e95..afa3c6d448 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
>       s->data_count = 0;
>       s->stopped_state = sdhc_not_stopped;
>       s->pending_insert_state = false;
> +    if (s->vendor == SDHCI_VENDOR_FSL) {
> +        s->norintstsen = 0x013f;
> +        s->errintstsen = 0x117f;

I'd rather do like capareg, and add:

   DEFINE_PROP_UINT16("norintstsen", _state, norintstsen, 0),
   ...

Then SoC code sets it:

   qdev_prop_set_uint16(dev, "norintstsen", 0x013f);
   ...

WDYT?

> +    }
>   }


