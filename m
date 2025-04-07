Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCEDC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 12:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1lFJ-0002Mt-0G; Mon, 07 Apr 2025 08:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1lEa-0002KQ-GD
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1lEU-0006Gj-Gh
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744027539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvQUcEsgAl0wseJe4hxDdxpZFF+u6HEU4sgyJ3AAZis=;
 b=dcCCyKVEyUejOZ/y7xqZwNE/JjDTw3SPJYLT7fr0cZJgJDr6dgMiW4NXYKYKy4F8p93JEU
 0QJICbTQ/iw7WVW8jP3AsIfmH7pm5aMcsa4m9H1LQYC79RXfujtesZ04O+984xIOy77Og5
 IEVt+hqgJwls2TsNoEzT8vhhHRaj+Hk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-EHxD624WMwGUfxT1qX-awA-1; Mon, 07 Apr 2025 08:05:38 -0400
X-MC-Unique: EHxD624WMwGUfxT1qX-awA-1
X-Mimecast-MFC-AGG-ID: EHxD624WMwGUfxT1qX-awA_1744027537
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39c2da64df9so2600623f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 05:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027537; x=1744632337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nvQUcEsgAl0wseJe4hxDdxpZFF+u6HEU4sgyJ3AAZis=;
 b=HMvYbxmAnOFHUnVA73p4SpV6yZv/1cNuwvDal28gUQXGElkcjYBr07mriy1oA+ke9O
 K/CoEY0O8yUlU2fNxi2PFvwMey1ZEp7vRJxcuCae7i/VjMGoCyVXW7mNdX3HEXANCY/0
 qOXm1yOs1ypI2xecsxAhVTL06VVoMefq1ln9h1tSgmX86IUNTjvebufN0xoP17+skpK1
 Yya6pJrODH9YhHUIMoR897xGRf8YDeH/rooskfBy7WRxpaMSZNdPeqYrjutC/LgNypz+
 HdBCcVl5Ns5PX4VB9NqhbeZ2iJWpVAzRqeLMUJhuTn2QwEcl0TBJ/Gp5JqNxvRtqQyz1
 N7Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIQjRB61Lep4jzEx7+Z1j5qs8gyZToFa3pinB4TknGTxJlLP9SSyF8AmZT85xH6QuOmNnIdrKgROYJ@nongnu.org
X-Gm-Message-State: AOJu0Yx+50O//MfPfEpjGglEGmjIGGD+rlaDHHsPUsQk2wHaNBnYcbrU
 uGpuDRXF9WTgMW0aj5pTjeuTnjgfGNFX+HLhSINk98Egi5rolBjXdOGDKvRW18P4KZTrSB7pySf
 hk9/vRgU0n5BkjMZGbMiUEQlmwq8Nhlzin1ta9UfAkVVH0Ke9Iq+V
X-Gm-Gg: ASbGncvFBHlmWMPJi4IRm1dzkmpIo2xL6O4WXKfvHmMeHPC7/C7K+6pViaqZOkld8zE
 eAZKpKKZXmAaguxhupTUsLdDABFvO14jV5jwAqkCHYbRFZHOs/AggI7IIBzotgo0LB6vwLJHkLZ
 5sOkKXkXG/qi4zgpZz3fSPKLziS8DnW5wFP0pIbViBsAZ0BAhihaSQHkql4Mx/5PZZ9STtwdKM9
 sLr3WGkqINIj7UQYBW25x1xg8KtK5q2GZkj6H6xNFdCMtqo08TlYGURo96xxm/atoK5xoFpZiAx
 AH6YsrPJQodSBz8Lo3NQKfxQjW2aRl/PmUXcoBfC9OkJtah2rZbG+h/X+rJnQg8=
X-Received: by 2002:a05:6000:430c:b0:391:47d8:de2d with SMTP id
 ffacd0b85a97d-39cba93382fmr10231746f8f.23.1744027537109; 
 Mon, 07 Apr 2025 05:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHdqiJa0741zUZre7kCfN7vycTzR3KnDgQLW7H+pgXqqmxARP465gRljOL2ggZDGfV8Fm6kg==
X-Received: by 2002:a05:6000:430c:b0:391:47d8:de2d with SMTP id
 ffacd0b85a97d-39cba93382fmr10231702f8f.23.1744027536673; 
 Mon, 07 Apr 2025 05:05:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm130839775e9.9.2025.04.07.05.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:05:35 -0700 (PDT)
Message-ID: <3cb05082-cc4b-4de2-aceb-40c3c6166a62@redhat.com>
Date: Mon, 7 Apr 2025 14:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 3/9] hw/arm/virt: Simplify create_its()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-4-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250403204029.47958-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/3/25 10:40 PM, Philippe Mathieu-Daudé wrote:
> No need to strstr() check the class name when we can
> use kvm_irqchip_in_kernel().
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 177e9e0eadb..326986deb16 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -711,21 +711,15 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>  static void create_its(VirtMachineState *vms)
>  {
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> -    const char *itsclass = its_class_name();
>      DeviceState *dev;
>  
> -    if (!strcmp(itsclass, "arm-gicv3-its")) {
> -        if (vmc->no_tcg_its) {
> -            itsclass = NULL;
> -        }
> -    }
> -
> -    if (!itsclass) {
> +    assert(!vmc->no_its);
> +    if (!kvm_irqchip_in_kernel() && vmc->no_tcg_its) {
>          /* Do nothing if not supported */
>          return;
>      }
>  
> -    dev = qdev_new(itsclass);
> +    dev = qdev_new(its_class_name());
>  
>      object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
>                               &error_abort);


