Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DABCCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 20:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2F0c-0008Ch-4s; Fri, 26 Sep 2025 16:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2F0Y-00089w-AU
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 16:25:34 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2F0Q-0008Tw-Jd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 16:25:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso1845060a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758918311; x=1759523111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbZcUgI1SmftbRBbeEpSCBLJYC9cSB7FOYm92LF0Jqw=;
 b=i4XgQ/bRTbbnprCO/KP9XqO4pqI34oX4ijhHx1IyWRcIGSgdaFxr4uH+dQfue1LsSN
 b4tgSVYxnnxYiH3dn/MMzC2suH8a3eIlVQn/HdTsklgypnEGLKLFkmri/TOyLHBNwmGK
 hZoFvKwUgwZKCMZHLqHpy+V/nUvSqNY+lUkGvA/dHm+LEPED76qn1liKdxmPHXZuZdYy
 fCcG/qlTfAh190B9eAhCVZtV8ltL4CybwBmpV6hpCW1utQWF2vQCdOEJY92I1+8+b5Po
 kRPuR4UErJLOyC1/AY60gQ5BExmYsqlOPN/DN/Q/TtDRLd+Wto201bEJ+ewUBG5ZhZSW
 ICLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758918311; x=1759523111;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbZcUgI1SmftbRBbeEpSCBLJYC9cSB7FOYm92LF0Jqw=;
 b=psML+V88QAm//F4KEm4cE5JwF2CpnoDpR1XNb7h/dX8RVgmxlKk/l+MwyHaOIEFVc4
 UDYIgpXds4ufJhCTq/GwnuQEhCkq9d9l2hOmM/AQrHrKsqig06JeWkFRP2iV02PDJUq5
 DIkgkCc3/PfXDF2FPSKdTFE/SCYgBnhkuNrHeBW5DrALjhvfbbyMjceyWTt9mcEIHSpS
 6r85hUf/8lLTbvfLJH5d/YLFZV9xZjIDehokQRTtv3qpmm9VjXrzWG4QTRaNcpP+/Z5Q
 nl+EElyUPhiODhZsClIbtJ7xZ8EynMdFZWfTTo3DCFu+BB+Z8AtJ8SyM0rXqEumx6G/R
 C2jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7cHEdkKR1kabJ2KvO9pTfqpVx7aEtThAJ96jYLZqscgb5A901vAEtS/LvfG2vxf9Vrl0tWGcAS22s@nongnu.org
X-Gm-Message-State: AOJu0Yx67q1Xklu/oK3cFZge8fnJXxzsT11RHQBSteuSVU9ttTKJ14KF
 5R0Me9ft2W9IVZ0zdA81YdayCk52wJVo5SZr0xlwLvXvBHKRbMh57Ta70aEcdQmYG8z6AuNJHqp
 gidUu
X-Gm-Gg: ASbGncskjwBAOljMOV0UQ8VNrY2W0uwOZmOe4tOWLVkdyhRqVZZb4qzLJ2ppf+bqpA+
 WmKm7VCPKQIqs5vxwTt0O1ApOHfZQebi8USAZ/wAxMvf96gNmFL+EHPWWeJCeNZbrHd+0phCEqs
 iSs5vhVvlYCDfbw5Vs59r88FHowjrQHLmuFGw0cJ0ui39/V5u3aNatp9NWY/bjsPlghaEMHWMAx
 TJaZ7K0RcjJXTLwpdauXZVsrY04SWbyBt8mnZiXa1FjB60kdAbt7E9DeF2lxOdwemOd/YRLFtLv
 bO2Dp5XjkDVCck56RHIxwF4ZU1Iu//x9Z06h1fqUYvXxoIKKXfyVS2cOkumh8znqVGW+EuLk/o5
 2afF+J2bO1QA75IVjEeyHY2HZUhZ/6rgHTw92KuEUtjcLmSQ=
X-Google-Smtp-Source: AGHT+IHxXlgAzFjPoeKaaTSttVHwhkK+WeA7hVI5yofvyI+VQ3OOtMVcSlNFsWf+YTKio2ns+R2Wlg==
X-Received: by 2002:a17:902:f682:b0:269:9a71:dc4a with SMTP id
 d9443c01a7336-27ed4a96183mr101939965ad.41.1758918311087; 
 Fri, 26 Sep 2025 13:25:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed671d8a2sm61998035ad.55.2025.09.26.13.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 13:25:10 -0700 (PDT)
Message-ID: <5fb78ede-5305-43ed-b215-84c6d7309416@linaro.org>
Date: Fri, 26 Sep 2025 13:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 03/11] hw/loongarch: add misc register support dmsi
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
References: <20250925060936.898618-1-gaosong@loongson.cn>
 <20250925060936.898618-4-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925060936.898618-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 9/24/25 23:09, Song Gao wrote:
> Add feature register and misc register for dmsi feature checking and
> setting
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Message-ID: <20250916122109.749813-4-gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

This fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/11511929825

You wanted BIT_ULL for 64-bit values.


r~

> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 3ef42bafd0..4ec50f6bd9 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -564,6 +564,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>               return MEMTX_OK;
>           }
>   
> +        if (virt_has_dmsi(lvms) && val & BIT(IOCSRM_DMSI_EN)) {
> +            lvms->misc_status |= BIT(IOCSRM_DMSI_EN);
> +        }
> +
>           features = address_space_ldl(&lvms->as_iocsr,
>                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
>                                        attrs, NULL);
> @@ -599,6 +603,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           break;
>       case FEATURE_REG:
>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
> +        if (virt_has_dmsi(lvms)) {
> +            ret |= BIT(IOCSRF_DMSI);
> +        }
>           if (kvm_enabled()) {
>               ret |= BIT(IOCSRF_VM);
>           }
> @@ -628,6 +635,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>           }
> +        if (virt_has_dmsi(lvms) &&
> +            (lvms->misc_status & BIT(IOCSRM_DMSI_EN))) {
> +            ret |= BIT_ULL(IOCSRM_DMSI_EN);
> +        }
>           break;
>       default:
>           g_assert_not_reached();


