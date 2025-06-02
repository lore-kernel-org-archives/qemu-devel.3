Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32267C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 14:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM5iD-0007sL-8x; Mon, 02 Jun 2025 10:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM5i3-0007ph-VI
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 10:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uM5i0-0007Wo-1m
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748872803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8QxnwFZuPL37lQK9oLt+RiMmKPNC4HugRnShmDUGihM=;
 b=eowWaDhqGy4hKu6KeKLSrPGKY8rvEtfUNe0ZVCYsxsIXsyDaJwE/LbQUIazCzSySFC+wLE
 YpZnLagTlGF2DDEbj5QRW/0Ufg4Y2JDxoVBt81AWxXAaiQ9byvGJIgOkENdp1pD3YBJpAS
 7MhFgtkzQxuyznDOyCP8/FhSuuPC5z4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-qLDnKg59O5unPnKcnGtoBw-1; Mon, 02 Jun 2025 10:00:01 -0400
X-MC-Unique: qLDnKg59O5unPnKcnGtoBw-1
X-Mimecast-MFC-AGG-ID: qLDnKg59O5unPnKcnGtoBw_1748872801
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso26852595e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 07:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748872800; x=1749477600;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QxnwFZuPL37lQK9oLt+RiMmKPNC4HugRnShmDUGihM=;
 b=w4cdqf1cHKdxAEJPqzv5LCfeNla929a/FGZsdQvxU8IywL+u9APsLQaQUACXqMbMy7
 eF/JJzLg/ApYRkNTI3qgrprf6itUYokn2TfMmoB5WD03nwtAbYEL33oatC6dms/hsVqq
 hB5BHkvQ7dhsRCMPCuqIthOTjXn0HpjEF/KUbP5a3jcKGmCYmbhjiGVT0GmY8VKFTvtg
 U9TIT1uN5kK5dzbPYd6xhvmnGyT9x6+Vt51V1URPK4MnMqSxpy+5kOff6Q/Vc2Odw5J5
 E3mu7icI0s0F2oyMiExtuXAKDT7vUCpEsdTb2i+D7Ahq9ujw3tuVaotcq2r7JvOsu+GB
 sFgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDXL9ZXKNf1ufpqa1C9kMFuBjUrBgr7RPdPt7QZrqGFGZUZ7iS8s18gIMEIHex2XZFgD+tyDjtSL6J@nongnu.org
X-Gm-Message-State: AOJu0Yx488HLpunNrpoVjv4j0q4ftt8+0s3hbp/fn6PcmpyDCDY4UkbF
 cXAxvCkVebSmW+z9xk/gnjYAz/OFRkbBhnPwtQbL5hf+8EYb9Bx27VVJdiHbIQTbN2YZtukUSIz
 3n+Axd68kMUcO6ZJMPct5THSYTUjXc+wJ8ltGWwwWwuIu1YlMLlyoUrRd
X-Gm-Gg: ASbGncu/N9DbHuGJq87LeaTEb/vAfuzkXvvJ71sBadOOncFr/1OeJum/zSbEeIQ/2MZ
 MfBha9acO2SF30vCv2pYPC0PNwLXV0mTESwDstuAu/BMD3AjOI/XENHNv6kDV8ozEMHV+cbxBAw
 Pg8eij4xzmPsz6U6cwlPibgHnMSNAwM1HE/jjoYNbvoBMlocj7BAwOxrdAn+tvamlY0/XSr3ghw
 l+pmhfMve11pZxWjmtk+kPcBrdupC+1EiQsTZCAjGNRkOt+bkuR0kyvax70s4dsF6+cnjkFlqeL
 A8av/O2fvEEE67x6Groxh/pkQZItfLF38Gv0UqMoLt0nnyOAiaeLctWPF6xT
X-Received: by 2002:a05:600c:4f46:b0:441:d437:ed19 with SMTP id
 5b1f17b1804b1-450d64d469amr117757305e9.11.1748872800489; 
 Mon, 02 Jun 2025 07:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUKiYrjS/e9tDTEFeGJlurzIrcrKV2YLg0KURFwoEk0vHp8o/FxFxMAqJ8XNPDhxiscVMJRw==
X-Received: by 2002:a05:600c:4f46:b0:441:d437:ed19 with SMTP id
 5b1f17b1804b1-450d64d469amr117757135e9.11.1748872800139; 
 Mon, 02 Jun 2025 07:00:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8ed27sm128668495e9.2.2025.06.02.06.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 06:59:59 -0700 (PDT)
Message-ID: <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
Date: Mon, 2 Jun 2025 15:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-3-pbonzini@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250530071250.2050910-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Pierrick,

On 5/30/25 09:11, Paolo Bonzini wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/r/20250521223414.248276-3-pierrick.bouvier@linaro.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/arm/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 5098795f61d..d90be8f4c94 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
>   arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
>   arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
>   arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
>   arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
>   arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
>   arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
> @@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>   arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>   
> -arm_common_ss.add(fdt, files('boot.c'))
> +arm_common_ss.add(files('boot.c'))
>   
>   hw_arch += {'arm': arm_ss}
>   hw_common_arch += {'arm': arm_common_ss}

This commit breaks building these files on Windows:

     hw/arm/{boot.c,vexpress.c,imx8mp-evk.c,raspi4b.c}

Error is :

     fatal error: libfdt.h: No such file or directory

Thanks,

C.



