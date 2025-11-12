Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CECCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ99o-0007wH-38; Wed, 12 Nov 2025 06:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ99d-0007tJ-F6
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:36:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ99a-0005Mr-SS
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:36:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b379cd896so419679f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762947404; x=1763552204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuGEPMinRsSyf4OT/Ys7EFDIRyoLAeqt1kZN6UzuH14=;
 b=Nx2kTKLeVJ7COdsNqSon1Rc/32e0ia9uvbbC9C2vTPdKhIR38j87gnMmivWsEo5kSJ
 8USZ6kLPDVtH+5GFyOw86qoicEyvdAFyY7bBJDfwy/PbSTzGB6vvCIOu+z+jUk8AQ1mu
 v57CP56Mu7g5P1J5UhDA09MkVGpbs1s2Yv2MCQdyi2lEOPPYq+j0NVcO8GkamlEnWjNy
 3DYh9a7elAEULkD48sRYFglK+QUrK+3ZpVqpDJ9dMdgpJhIqxa9W5QCv7nRx5HNjAOdv
 SSrtCx4/gn/gTRo/TOhVUdEv2qe5jNZ5Z1mIoSTYa0T/4OfKFBg7RQerHdJ3bvT+VXSW
 biEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762947404; x=1763552204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuGEPMinRsSyf4OT/Ys7EFDIRyoLAeqt1kZN6UzuH14=;
 b=uQ4sTgZrPNZwP/hKFzgyCCPEhCdESrIDFXVuyUz2st/qrhhZILCqpZtrDEqsPtz+ba
 sS3p9NEqJUTPPlinn/CBN9x2BEPWE9CJmBA8EEzAITOU6J+IlmqGX8lG1s1se1J8HcAQ
 riK3tyOIf2wxuoycyLIMv4oDCFD4524B5Hir8f7yE5jFv6uBoymDh0FSK+3D1oPqyxSH
 AoFX+BtViTmq7JIUb9haQan32OwH++NMBxdYNI6B+313SD47kZsiJP5sR5mHqOMv81RM
 rM5p2ZBrWeVAGKBhSWsWL386qBB7dvPrVUMy95XBnEWN0xd7cnOBA8P0Ht9okdXtY/Op
 YfMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKZ3H44qDHviQvovDFbXrl5l2JOdIng44oeQoiJgbsqmhbBBnIYD60bQ3qLVd90FX9ivNw17FBH0Gw@nongnu.org
X-Gm-Message-State: AOJu0Yzxf0rS4tjKMN36Bf5QR/R5MVACe2YwHw2v1ImNKzPTGS/R5NJx
 Rp3dYPE51g2udF0ieyCGVZYF0q1XFSWdKqrB7WWFDkMaGtEZ4kDRSHBEE8ktiCFSBaM=
X-Gm-Gg: ASbGncs3gEpcD2nfgsbvme8BsLLILp0QEk31BpjRHvH1lq9MsyjVzAP9yeICETn9FFH
 CLKOIIk4XErO7wYMl+mNJ35alGRc5P11sH5VJsS6Pwj4GW8AF6l6xAH3JpR8BCGPPJHVcdttsTN
 lxjhsByBI6Yljzr9tbG2Iyn7X3AVQ97tgjkwun9TE4S0w27xsXsQn/fHQVrJNpvGsYbKGrShIgg
 ltTzkKtsqY1c4sJY/0NjRo3gRFAeonaJKYyDTwA9pL22rXFlqSDc2cx8HxhYtIaAMLUFCDJr+xW
 UJChVDSdZrYzHiXIlsvPFHvHUA+a0vt+XIu312WhImqPpCHsm/jMR6OStj/rdZVHhFyr89FbTKp
 NQ3lPrr3pHwaS+cwXaS/2mZz6dhrMn2dqt2jgWjplAXbjSS9WxNwZNm6F0rPn44yNQwuKE/+1lw
 ERSlbdZLxN0okk9/nSpShM+udD0dYTDta2ZpUJ+wmYuCs=
X-Google-Smtp-Source: AGHT+IGywUWY9ZzcscGVB2M4Ev8AaZQT8Lvp4W8LnHNx9cHUSJ+Lf2fBIbBFij/2ttFKNT4meBeKSw==
X-Received: by 2002:a05:6000:2892:b0:429:c774:dc08 with SMTP id
 ffacd0b85a97d-42b4bdd3e92mr2634479f8f.53.1762947404524; 
 Wed, 12 Nov 2025 03:36:44 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac677ab75sm32506552f8f.35.2025.11.12.03.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:36:44 -0800 (PST)
Message-ID: <f2c596fe-292c-4b82-a332-1087c1c61732@linaro.org>
Date: Wed, 12 Nov 2025 12:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] hw/misc: Add Beckhoff CCAT device
Content-Language: en-US
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-12-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-12-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> This adds the Beckhoff Communication Controller (CCAT). The information
> block, EEPROM interface and DMA controller are currently  implemented.
> 
> The EEPROM provides production information for Beckhoff Devices.
> An EEPORM binary must therefor be handed over. It should be aligned to
> a power of two. If no EEPROM binary is handed over an empty EEPROM of
> size 4096 is initialized.
> 
> This device is needed for the Beckhoff CX7200 board emulation.
> 
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>   hw/misc/Kconfig         |   3 +
>   hw/misc/beckhoff_ccat.c | 338 ++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build     |   1 +
>   3 files changed, 342 insertions(+)
>   create mode 100644 hw/misc/beckhoff_ccat.c


> +#define TYPE_BECKHOFF_CCAT "beckhoff-ccat"
> +OBJECT_DECLARE_SIMPLE_TYPE(BeckhoffCcat, BECKHOFF_CCAT)
> +
> +#define MAX_NUM_SLOTS 32
> +#define CCAT_FUNCTION_BLOCK_SIZE 16
> +
> +#define CCAT_EEPROM_OFFSET 0x100
> +#define CCAT_DMA_OFFSET 0x8000
> +
> +#define CCAT_MEM_SIZE 0xFFFF

Likely

   #define CCAT_MEM_SIZE (64 * KiB)

> +#define CCAT_DMA_SIZE 0x800
> +#define CCAT_EEPROM_SIZE 0x20
> +
> +#define EEPROM_MEMORY_SIZE 0x1000


