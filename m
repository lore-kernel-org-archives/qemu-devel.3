Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DD0D43346
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90H3-0001Ff-Lp; Thu, 07 Nov 2024 06:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t90H2-0001FH-OU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:02:00 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t90H1-0000mC-8n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:02:00 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb3debdc09so6435581fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730977317; x=1731582117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDq9D1U8taeFULz8W5ddU7nLUTOFAivkmxpUM45Z04A=;
 b=v1/hS8NXkQTeRL2Q87/KFHBxShVEIrShLnQpMk6clc3ybcZXm81MKUXFvoxChlKSaf
 WUCYm4kHltAWoQuC+v/TN/lvWUTgmsc0uAidlOKmaFzk/MTpdmbiznJ/T7gtBvNbGOhT
 yguK6ttuBOC9stNMDGUbrGKS3V+f3/xpNc/D8G+tilT/CUZlBb7KaNBLnFf99ZITEpO9
 uHKoiOUTZGeBTzOvmARJF5wcgWLWwvtQa8Wvkdumh9FlraYxBKMtlFgSYRKvrnxIwH/K
 ZSIRhHiK9VM13l2VohpYFUs/9Urqk1Gbn/XpiHSuCim5jfawtJU5D5heSx4OuBcMzYoE
 R6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730977317; x=1731582117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDq9D1U8taeFULz8W5ddU7nLUTOFAivkmxpUM45Z04A=;
 b=TQ+Gi5NiqHBnjpJB/cKLEoB1fgHrHc2ub5EuJ7JARXrpfo3OIr4AEHDltMiHmVLGde
 JwEHt+vfPjmam2n69QN4297qLAcPq8pKK7JWtpyFPrLnt6P2V3vCTUzcLYlkWERDA9+c
 W/Hcnqf3rPlGcspL2QS1d8r9hZNMn7Mf9hyOzjkQqvMoNaNtSXk/qkc/6GU+EUncrioc
 eaMCsQ7yAqgf0LaiqDV5BqjbboFXy883NupB1x90SE9BfrrJ5dau3YZOl3443X+imIGt
 7Ydfaifc3b2t2itghoiOG+Y3D2/UMd/P4bzdl7WV+VLV6qFTnZXy/EI/P6CuD5h/7zPn
 zInA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfjzu9PnIskYIdGLDvrk972E+XZ/xJlsxWg6K502+rXFtYXN6T/Ajr/rlPGbfDIeJtjmL898v+8eoI@nongnu.org
X-Gm-Message-State: AOJu0Yxa+FBkoq/BD7OUvdvofUSqFVfG6ZJRneakY2CMLk80nROUHuPS
 9AKhJbrveaeWNj62fNVFntdecCtmaMqVD36y51dPtNnghYa/9uMhm/mSnnn9DBQ=
X-Google-Smtp-Source: AGHT+IFYXdqzX49eSOPVm5WsTzx9Q+dNFuwIqNx1vgnoC1M9PHGbiOrfMOVmdtIOI842OG7Cvpxjdg==
X-Received: by 2002:a05:651c:1b13:b0:2fa:d604:e525 with SMTP id
 38308e7fff4ca-2ff1aadd768mr6195211fa.28.1730977317218; 
 Thu, 07 Nov 2024 03:01:57 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b054b34csm20140695e9.14.2024.11.07.03.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:01:56 -0800 (PST)
Message-ID: <4b678b54-0f1b-4b3e-8201-fb22c7cd7cd5@linaro.org>
Date: Thu, 7 Nov 2024 11:01:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] hw/ssi/xilinx_spi: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness on the single machine using the
> device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/xlnx-zynqmp.c |  4 ++++
>   hw/ssi/xilinx_spi.c  | 29 +++++++++++++++++++++--------
>   2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index ab2d50e31b..e735dbdf82 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -714,6 +714,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
>           gchar *bus_name;
>   
> +        if (!object_property_set_bool(OBJECT(&s->spi[i])), "little-endian",
> +                                      true, errp)) {
> +            return;
> +        }

How might this ever fail?
Despite xlnx_zynqmp_realize having an errp argument, I'd be inclined to use error_abort.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

