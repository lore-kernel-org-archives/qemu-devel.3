Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91852C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reazc-0000Nl-QI; Mon, 26 Feb 2024 08:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reazZ-0000De-US
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:26:02 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reazY-0001u5-6D
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:26:01 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a437a2a46b1so61500466b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708953957; x=1709558757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0pSgwdUsCu4IZL3guvtFpnGMwtBnvo50lTuekTfo38=;
 b=wMzgd0aZaBgQYgs5UiUy5r3+Tp4cUgypdqwlMsZBzOQ7jbuSIqASKQYGOsyHQW5AY1
 eOK1OWLRKEHQ4spP35rd/mRIR2PBTEd/u/nUkwaSivq3wrue+cQID1AhRp8wBEYOoOJf
 kPOCKiJuGmlwV8IZ9NVx9/kZ1TyyklVhc81NK32hKhP4Qweo1Slf++VA7D87K1ZFcnQ7
 Npn9ssEgbEXdliPU8o2b3Zig3o7c7VFQq21OeonH8e/cyoXrmikQV4/WWIuhiXfpCE+r
 Spxnblsyf5Y3sI6fOaVGxjJsbxtMFUXSRtXvDpMa7icl9xNiZ/dUnbUYE96RiVnTd745
 RJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708953957; x=1709558757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0pSgwdUsCu4IZL3guvtFpnGMwtBnvo50lTuekTfo38=;
 b=bkU2SqwB0y3W5HWQ7cMOYEwcCqzUWMKX0QF3no3AdQZsPQbdLaG3q924usBkngkxzo
 C4/5ROpxYAMQt6go0xgSeZQeQnpZuDbN7XX1xmFS2UtVWwfLH4YSesF46YldPayMFARF
 1HwOeraF7CavCSOgWozSkG0pWQN+7YYGi92TCIxXKqTRQlrZ7/PDExNsFXkaph0IuEoi
 ydxqccHkjfo91VZa9ElxIbKwzFY84aK3o2N6f3wSS1/3xzj+S4l94LqnzpFwj6PVyr2h
 6k2DZPI5QzEWiMcV3X1oY8vhU8S51bl44+X81gXKfZdz4ujAr+yyXzvQpyBG4kuewsx8
 syVA==
X-Gm-Message-State: AOJu0YwCMvYa1df2L14e23pddVIeVo0ZYP5QnQhaITu8vDLK+a9rDFro
 vvPv9WZBlv6a+bcb5KkA87Pd6QBDAEQMsIij/fmFnrT+NRXRkTBFD7J1HF5zemc=
X-Google-Smtp-Source: AGHT+IHWyzTve/yyVUWXHoVPKBIfk1PZqF0J8NvTwjRg485fBuwU8Z+JYSRHTTsv823TfXDbVd9BNg==
X-Received: by 2002:a17:906:c28d:b0:a3f:c115:3ac8 with SMTP id
 r13-20020a170906c28d00b00a3fc1153ac8mr4713854ejz.43.1708953957572; 
 Mon, 26 Feb 2024 05:25:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a17090612cf00b00a3f480154a3sm2415265ejb.65.2024.02.26.05.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:25:57 -0800 (PST)
Message-ID: <2860d4d6-4b5c-4867-a7f5-99e9fa6c53db@linaro.org>
Date: Mon, 26 Feb 2024 14:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/41] Add BCM2838 PCIE Root Complex
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-14-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-14-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Sergey,

On 26/2/24 01:02, Sergey Kambalin wrote:
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>   hw/arm/bcm2838_pcie.c         | 82 +++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build            |  5 ++-
>   include/hw/arm/bcm2838_pcie.h | 53 ++++++++++++++++++++++
>   3 files changed, 139 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/bcm2838_pcie.c
>   create mode 100644 include/hw/arm/bcm2838_pcie.h


> +static void bcm2838_pcie_root_init(Object *obj)
> +{
> +    PCIBridge *br = PCI_BRIDGE(obj);
> +    br->bus_name = "pcie.1";

Shouldn't we set the bridge name using pci_bridge_map_irq()?

> +}
> +
> +static void bcm2838_pcie_root_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
> +    ResettableClass *rc = RESETTABLE_CLASS(class);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(class);
> +
> +    dc->desc = "BCM2711 PCIe Bridge";
> +    /*
> +     * PCI-facing part of the host bridge, not usable without the host-facing
> +     * part, which can't be device_add'ed.

This is the host-facing part; you add the PCI-facing one in
the next patch.

> +     */
> +
> +    resettable_class_set_parent_phases(rc, NULL,
> +                                       bcm2838_pcie_root_port_reset_hold,
> +                                       NULL, &rpc->parent_phases);
> +
> +    dc->user_creatable = false;
> +    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
> +    k->device_id = BCM2838_PCIE_DEVICE_ID;
> +    k->revision = BCM2838_PCIE_REVISION;
> +
> +    rpc->exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
> +    rpc->aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
> +}
> +
> +static const TypeInfo bcm2838_pcie_root_info = {
> +    .name = TYPE_BCM2838_PCIE_ROOT,
> +    .parent = TYPE_PCIE_ROOT_PORT,
> +    .instance_size = sizeof(BCM2838PcieRootState),
> +    .instance_init = bcm2838_pcie_root_init,
> +    .class_init = bcm2838_pcie_root_class_init,
> +};
> +
> +static void bcm2838_pcie_register(void)
> +{
> +    type_register_static(&bcm2838_pcie_root_info);
> +}

Please use the DEFINE_TYPES() if you have to respin.


