Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298CFCFD2F5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 08:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBRb-0006tW-Ng; Fri, 11 Oct 2024 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBRZ-0006se-DS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBRX-00080o-Dx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728636968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l3Uc0vkaecKXr8tUjRujG/JyeNc2dwNKBQ6NGB7JF4o=;
 b=Rp6+9mTm8uHJ4LtPHU9/K7U/A6ZvXizyqR7h7CPo72nssp6U/HwB+dnW4CeNftzS3JD6lr
 8yTymdobUdpXnYh3PDAn3sO5NYSIfvgSe9qh2sJ8j/v6XA3xxkE40ouzsTU0GMLJy/mDzO
 t+7Fi/iwrysSkN8oxuTEN4HdvSJfR/Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-CgR4pYrjM6qdVQL9R6t_ow-1; Fri, 11 Oct 2024 04:56:06 -0400
X-MC-Unique: CgR4pYrjM6qdVQL9R6t_ow-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9959df649aso135948266b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728636965; x=1729241765;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3Uc0vkaecKXr8tUjRujG/JyeNc2dwNKBQ6NGB7JF4o=;
 b=NFK8kLNzoY84EWJmwdWqxPdndEUn4oediFPL5u+E8ZKHvomrllPzO0BRQiLbgMiWh5
 /7Iq7D6sf7ERhmrr/jpQc+nXI7RUL5E2uvoARU/plvRK17dxoc/AAmL7LZfFRmTBNy/J
 gjeKTdaqF6w1Wg5kx6aOyXOiaCz15KwGwU6ddQfqHkiUGeYM9y7sm7I2GFFk9qQFyrOQ
 ZrMkJrlKy58sLFe0jQup/cuaiyQpFksfwlMGH+Z3hy3Ja+fZh4KSjBE9q9cBIzEYH/OS
 kNLz2H8J8DDjQ+gylAqlc2/mHM3WHEgCI8jVszuZysHYqt0e8h9rHC3l1+xdUmnXr98y
 c9XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1A+qXyzDNgv2x4Xd6/PgtaN8ZsyXvjITT5PzUejoUugBE0A8qswm65AvEdpbCDp/3BVmeBblMFUGK@nongnu.org
X-Gm-Message-State: AOJu0Yz6yitcqQb+fDkFtZK2lPUqdopiS6JUepAzTNjCdWv1/h7FpdFd
 +W3CR9YTab7C1E/0ls2It7nkx6iwPJ6hWxW1VZdqUqVuv/EcoC1K6EyQHN07HtEr3TVM7Ks6A3L
 hqX8k62xPu0AZG+ZzyFy0v8SpDSlRDzPPTh+w/xiHwFkgA81a4kpc
X-Received: by 2002:a17:907:3609:b0:a8d:f04:b19b with SMTP id
 a640c23a62f3a-a99b93023c0mr184797766b.2.1728636965618; 
 Fri, 11 Oct 2024 01:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE4X+PuspvW3UDFGHe1vuXqBI+CdKSTUSpVIiUi80u/kCT6uz17NLpYegN5PGNO66cymS6vA==
X-Received: by 2002:a17:907:3609:b0:a8d:f04:b19b with SMTP id
 a640c23a62f3a-a99b93023c0mr184794666b.2.1728636965107; 
 Fri, 11 Oct 2024 01:56:05 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a99a7edea69sm188642366b.7.2024.10.11.01.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 01:56:04 -0700 (PDT)
Message-ID: <2758986e-72f4-4706-a3d3-c63c6283af86@redhat.com>
Date: Fri, 11 Oct 2024 10:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] hw: Strengthen SysBus & QBus API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240208181245.96617-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/8/24 19:12, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series ensure following is called *before* a
> device is realized:
> - qbus_new()
> - sysbus_init_mmio()
> - qdev_init_gpio_in_named_with_opaque()
> 
> and these are called *after* it is:
> - sysbus_mmio_map()
> - sysbus_connect_irq(),
> - qdev_connect_gpio_out()
> - qdev_connect_gpio_out_named()

This series is missing a _why_.  The original vision for qdev was that 
the whole machine would be realized at once from vl.c, and therefore 
there would be no need for realizing subcomponents by hand.

This probably will never happen, but it is still worth explaining why 
it's now considered so conceptually wrong, that it is (or will be) 
enforced by the API.

Paolo

> Patches from v2 enforcing these checks will be posted
> in a separate series.
> 
> Philippe Mathieu-Daudé (11):
>    hw/ide/ich9: Use AHCIPCIState typedef
>    hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
>    hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
>    hw/i386/pc_q35: Realize LPC PCI function before accessing it
>    hw/ppc/prep: Realize ISA bridge before accessing it
>    hw/misc/macio: Realize IDE controller before accessing it
>    hw/sh4/r2d: Realize IDE controller before accessing it
>    hw/sparc/sun4m: Realize DMA controller before accessing it
>    hw/sparc/leon3: Realize GRLIB IRQ controller before accessing it
>    hw/sparc/leon3: Initialize GPIO before realizing CPU devices
>    hw/sparc64/cpu: Initialize GPIO before realizing CPU devices
> 
>   include/hw/rx/rx62n.h |  2 --
>   hw/i386/pc_q35.c      |  2 +-
>   hw/ide/ich.c          |  6 +++---
>   hw/misc/macio/macio.c |  8 +++++---
>   hw/ppc/prep.c         |  2 +-
>   hw/rx/rx-gdbsim.c     |  1 +
>   hw/rx/rx62n.c         | 17 +++++++++--------
>   hw/sh4/r2d.c          |  2 +-
>   hw/sparc/leon3.c      | 11 ++++++-----
>   hw/sparc/sun4m.c      |  7 +++++--
>   hw/sparc64/sparc64.c  |  4 +++-
>   11 files changed, 35 insertions(+), 27 deletions(-)
> 


