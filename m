Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0A5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCLo-0004uS-8B; Tue, 04 Nov 2025 03:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCLj-0004sP-3n
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCLf-0001mR-LQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762244701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g1QvV++slqm4E5s/uOPcHuzSOdYX94WVRo3pL5N49Cs=;
 b=M9LJU0DHRn09/o3VhTZXvururmsMO3cMzUIEwIBivfoIaW9wm9C3q3j7zee7RCG+UoHi+G
 5FlVzJlkGQGkc/JArsMEXwNfItfsr8f2N2C8zy4btegnhnpAsSoJcv7QXRigojeVMwaRZZ
 GRqmBlOUZ8nCk7LPt5KXb70VucICGeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-jV8791deNV6bcVs3O7X5Wg-1; Tue, 04 Nov 2025 03:14:06 -0500
X-MC-Unique: jV8791deNV6bcVs3O7X5Wg-1
X-Mimecast-MFC-AGG-ID: jV8791deNV6bcVs3O7X5Wg_1762244046
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477594aad41so181805e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762244045; x=1762848845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g1QvV++slqm4E5s/uOPcHuzSOdYX94WVRo3pL5N49Cs=;
 b=hVPrm69GuJbEavREulweBHPpdTmaR1XSTHkvP/yBvHniL/WXzz6MxYYhlhPnQo2xQX
 3Rvf+7UjatlvJtMpIMmhOwzrlwqDCtCOq/4UrtAFVKoMNuvXubjqV4F1UvGaTJT4dw0V
 XUKbkkg87RfYrMu6kEl5s4aUJ1f4+4hLT8k6t/DF4HKZ2K7CHgNry52GD2LW8YCRxfii
 a+Ok4EztVHTOc7+M6+dU75x+g6UBigLppVmRpTRbSU1oWW95WOHO1Lb7nl59qzP77Et+
 sAyaqKJvxu2UXRQjjAdJ9eAsWESGkOcSORTfXZkFnFB61akUVu4D14cdbaLJQDplQxv2
 OUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762244045; x=1762848845;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1QvV++slqm4E5s/uOPcHuzSOdYX94WVRo3pL5N49Cs=;
 b=PZe8bTXqNADxt9OTKg2B2vTUyq+pkrtbGHA65FzU8SGomdSAkrlQVV9LNS3dSeJIJS
 U8BjnpJN/lVbIC7RLruUGY17HkrAskzU351HE5nz7z2AqnBXJx2L16NaBBBR0a/CTEyP
 3Db9OwO3OrKUu66HVPg3lXD4tAvUfQrKsDrSNo3j5YrNJi+ypJSOWZ7Npd5jWCy5ZSO8
 dxpUAd7eXjkY2xLenCqwRprPXNdKB9KTKwOUwIMTCUw7DVjNuTTnWwHKgFScqGtKtifG
 TxTxn7tTK1mw9RZg3Q+jD7suwchXKcofBemeoz1JEhGihMtKlxabId+mvv82bqa8tWpn
 5+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr6iSxd9ybHq2QBZ7ZHvmuRizCAIh8qUng/uBT9hx6oRH7GT7inOxWbhczvCkPEh+GQcvehnoBU005@nongnu.org
X-Gm-Message-State: AOJu0YyaFbxWAg0g0i9pZ2XOKR9rM067ZQQVjemtyQcg3CaajKf4GbqR
 tGAhtkTwKetDP2vf1HAWmjG48WKUcGnmS0JyvFpWWeO9bFfi6VQCxEBJSk6ggLNnkjhXHTG5K0q
 6G9P8hNzesO2cCMegvI1Ow+DyvGgADQvs91FUWY1MaDeG2Qlm2uJjZk88
X-Gm-Gg: ASbGncuVajXkigWLDsyLVc2BoQ+sUBNs/JWBozpJ9MpuFQaSqBLBsWYzDaou/wp/e/s
 st9F5XpC3CdNcMvKON8/dN5jnW98B1MZ5zgjTPZT5/79Kmq7IMwoS3xKqcbp83H1waTJ458K2Dr
 7+bNWiUMR0JergTLgE7/uMxa4O2T+FsAzMzmk/4UY2NhLnWwYZG/QRpdfo7lzVHveLmqLNrdOow
 XaNO9N779Bjmj3jIe7c3tlyLFWmAipRyFUaUwSzUWUHRf+ZAHNe4RoJSj8lpXHFoin8XrCLo+mI
 0iQhS4btZXzdTmQ6fMwn4H2bdt3tHMCrBo0yT2iPK2SVMzZnDdZ3Rv2WZG7yOO6SJUE9+3X1If6
 DrxQKJ/kYKnoL8ef/9Of6PxtjoE3dkMUEhTQ6PA==
X-Received: by 2002:a05:600c:64c5:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-477307c1fd3mr118931965e9.10.1762244045391; 
 Tue, 04 Nov 2025 00:14:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHgZ/gGhThLhiuI1ZhUZszVyc5hYAoyXvn1PE5t1Qz3bzf4GqmGzHz4UhFgD2KGCWM0BQYew==
X-Received: by 2002:a05:600c:64c5:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-477307c1fd3mr118931705e9.10.1762244044902; 
 Tue, 04 Nov 2025 00:14:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f5bb5sm3100160f8f.30.2025.11.04.00.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 00:14:04 -0800 (PST)
Message-ID: <3beb6b4f-90d6-42e7-8247-f89856f0abb1@redhat.com>
Date: Tue, 4 Nov 2025 09:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [SPAM] [PATCH v4 00/30] Split AST2400, AST2500, AST2600, AST2700
 and AST1030 SoC machines into separate source files for
 maintainability
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com
References: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/4/25 04:12, Jamin Lin wrote:
> v1:
>   1. Split each Aspeed machine into its own source file for better
>      readability and maintainability:
>      - Quanta-Q71L
>      - Supermicro X11
>      - Palmetto
>      - Bletchley
>      - fby35 BMC
>      - Facebook Fuji
>      - QCOM Firework
>      - QCOM DC-SCM V1
>      - GB200NVL
>      - Rainier
>      - Catalina
>      - AST2600 EVB
>      - AST2700 EVB
>      - AST1030 EVB
>   2. Make aspeed_machine_ast2600_class_emmc_init() a shared API
>      for eMMC boot setup.
>   3. Promote connect_serial_hds_to_uarts() to a public machine API
>      for reuse across platforms.
> 
> v2:
>   1. Restore ASPEED_RAM_SIZE() macro
> 
> v3:
>    1. Merged AST2500 SoC machine changes into this patch series.
>     Split each AST2500 machine into its own source file:
>     - FP5280G2
>     - G220A
>     - Tiogapass
>     - YosemiteV2
>     - Witherspoon
>     - Sonorapass
>     - Romulus
>     - Supermicro X11SPI
>     - AST2500 EVB
>    2. Renamed common API functions with the aspeed_ prefix for consistency.
>    3. Added detailed descriptions for the common API functions.
> 
> v4:
>    1. maintain :
>      Copyright 2016 IBM Corp.
> 
>      in the new files since the code is copied from aspeed.c
>    2.  Use I2C instead of I2C
> 
> Jamin Lin (30):
>    hw/arm/aspeed: Move AspeedMachineState definition to common header for
>      reuse
>    hw/arm/aspeed: Make aspeed_machine_class_init_cpus_defaults() globally
>      accessible
>    hw/arm/aspeed: Export and rename create_pca9552() for reuse
>    hw/arm/aspeed: Rename and export create_pca9554() as
>      aspeed_create_pca9554()
>    hw/arm/aspeed: Split FP5280G2 machine into a separate source file for
>      maintenance
>    hw/arm/aspeed: Split G220A machine into a separate source file for
>      better maintenance
>    hw/arm/aspeed: Split Tiogapass machine into a separate source file for
>      cleanup
>    hw/arm/aspeed: Split YosemiteV2 machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Witherspoon machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Sonorapass machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Romulus machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Supermicro X11SPI machine into a separate file
>      for maintainability
>    hw/arm/aspeed: Split AST2500 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Quanta-Q71L machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split Supermicro X11 machine into a separate source
>      file for maintainability
>    hw/arm/aspeed: Split Palmetto machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Move ASPEED_RAM_SIZE() macro to common header for reuse
>    hw/arm/aspeed: Split Bletchley machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split FBY35 BMC machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Fuji machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split QCOM Firework machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split QCOM DC-SCM V1 machine into a separate source
>      file for maintainability
>    hw/arm/aspeed: Make aspeed_machine_ast2600_class_emmc_init() a common
>      API for eMMC boot setup
>    hw/arm/aspeed: Split GB200NVL machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Rainier machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split Catalina machine into a separate source file for
>      maintainability
>    hw/arm/aspeed: Split AST2600 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Split AST2700 EVB machine into a separate source file
>      for maintainability
>    hw/arm/aspeed: Rename and export connect_serial_hds_to_uarts() as
>      aspeed_connect_serial_hds_to_uarts()
>    hw/arm/aspeed: Split AST1030 EVB machine into a separate source file
>      for maintainability
> 
>   hw/arm/aspeed_eeprom.h                    |   32 -
>   include/hw/arm/aspeed.h                   |   79 +
>   hw/arm/aspeed.c                           | 1678 +--------------------
>   hw/arm/aspeed_ast10x0_evb.c               |  109 ++
>   hw/arm/aspeed_ast2400_palmetto.c          |   81 +
>   hw/arm/aspeed_ast2400_quanta-q71l.c       |   87 ++
>   hw/arm/aspeed_ast2400_supermicrox11.c     |   82 +
>   hw/arm/aspeed_ast2500_evb.c               |   68 +
>   hw/arm/aspeed_ast2500_fp5280g2.c          |   89 ++
>   hw/arm/aspeed_ast2500_g220a.c             |   93 ++
>   hw/arm/aspeed_ast2500_romulus.c           |   63 +
>   hw/arm/aspeed_ast2500_sonorapass.c        |  103 ++
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c |   78 +
>   hw/arm/aspeed_ast2500_tiogapass.c         |   91 ++
>   hw/arm/aspeed_ast2500_witherspoon.c       |  113 ++
>   hw/arm/aspeed_ast2500_yosemitev2.c        |   92 ++
>   hw/arm/aspeed_ast2600_bletchley.c         |   98 ++
>   hw/arm/aspeed_ast2600_catalina.c          |  226 +++
>   hw/arm/aspeed_ast2600_evb.c               |   66 +
>   hw/arm/aspeed_ast2600_fby35.c             |  179 +++
>   hw/arm/aspeed_ast2600_fuji.c              |  141 ++
>   hw/arm/aspeed_ast2600_gb200nvl.c          |  112 ++
>   hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c    |   56 +
>   hw/arm/aspeed_ast2600_qcom-firework.c     |   92 ++
>   hw/arm/aspeed_ast2600_rainier.c           |  199 +++
>   hw/arm/aspeed_ast27x0_evb.c               |   89 ++
>   hw/arm/aspeed_eeprom.c                    |  192 ---
>   hw/arm/meson.build                        |   24 +-
>   28 files changed, 2515 insertions(+), 1897 deletions(-)
>   delete mode 100644 hw/arm/aspeed_eeprom.h
>   create mode 100644 hw/arm/aspeed_ast10x0_evb.c
>   create mode 100644 hw/arm/aspeed_ast2400_palmetto.c
>   create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c
>   create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c
>   create mode 100644 hw/arm/aspeed_ast2500_evb.c
>   create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
>   create mode 100644 hw/arm/aspeed_ast2500_g220a.c
>   create mode 100644 hw/arm/aspeed_ast2500_romulus.c
>   create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
>   create mode 100644 hw/arm/aspeed_ast2500_supermicro-x11spi.c
>   create mode 100644 hw/arm/aspeed_ast2500_tiogapass.c
>   create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
>   create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c
>   create mode 100644 hw/arm/aspeed_ast2600_bletchley.c
>   create mode 100644 hw/arm/aspeed_ast2600_catalina.c
>   create mode 100644 hw/arm/aspeed_ast2600_evb.c
>   create mode 100644 hw/arm/aspeed_ast2600_fby35.c
>   create mode 100644 hw/arm/aspeed_ast2600_fuji.c
>   create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c
>   create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
>   create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
>   create mode 100644 hw/arm/aspeed_ast2600_rainier.c
>   create mode 100644 hw/arm/aspeed_ast27x0_evb.c
>   delete mode 100644 hw/arm/aspeed_eeprom.c
> 

For the series,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




