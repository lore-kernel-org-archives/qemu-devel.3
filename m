Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A122C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLoX-0001w6-SY; Mon, 28 Jul 2025 07:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLCn-0006X4-QV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:35:43 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugLCZ-0005JG-R2
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:35:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so3669370f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753698925; x=1754303725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m95VFUGib0NpZG8VWEe3xtFFBGJsxBRh2pSLO4LmoRM=;
 b=cMwCivMwqPOtPLyG+WJ7/Ig75m/Bix1Pc9THa8xNtB9BMzb4irSlPoBtwv/bwii/W5
 3IraOEvCyKbOuOQwTT5pJNf1zWHHeG/iTWdMZCkaB84RVmA3vdjKhX19WCaqQYxUNqgl
 e7MxeDNJwGLev5V3a+YO2qZUHra7Gq9UXbAmZ3ELYqAqx+9ydxCsYAbaCUls4IlqW2Yf
 i6c/yl1ji4tOMtwXeKfZf9E6TlN2Hu1igr986WMG5Ez0AXGjwmiYl0akEokROz4JZTOx
 du3lhh6bsWNzJb9OjqtKz2qc2WyX/pJwoRCiwkLqMf1m1r7i9YC+I1zGNlG3HbH0dfwm
 UvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753698925; x=1754303725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m95VFUGib0NpZG8VWEe3xtFFBGJsxBRh2pSLO4LmoRM=;
 b=YMVzbnyTvAWQHwyRRlT1vuifOcc/ZOWhBOCos+PMxfxUw2yUv2SaVjEcLs767ejxJn
 r/cHCC9KjyWQK5luC2J97I9K0Q3tYHlPfnVB8IobKn6+j/EwGp+o7j33pgbhDVqc7rjN
 JtM+RCgeSEK4biPLZwDU7tNOhcVl2j8HiB405Hp42oUojMFJGzSUKmMZAqKfgntXPkFH
 3eCTl5IKOswwtimMMXNGSueudCUZXrxomRHlEj7h5E7ohH81gw2A1ke9aMU1OD353B05
 ngOtsUojx3sZZ6c+TvNL8eweivBAGZ88w71qMVZFNExHoYPQbAej0z6Q8uLiXx3uXa/V
 3LRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHw6bVCJBY1TyCOcQ3iUABt1Qk2uqAkSZ8RQgbsouYQJaRT2jNpt2gcOmraa1GEbw/zQwkK4KqQTdL@nongnu.org
X-Gm-Message-State: AOJu0YzF1ZGGojUMkQAdRy+uikvYmPfaQFcLOhS/O41MA+nf8vmk971J
 98UgfUqIuDHoCK2EZqLSPbIZk234yNFwkWZsMqeM7kmCmPf28heJ85twoxU+abCyz6A4MpRz+QR
 r+Eeq
X-Gm-Gg: ASbGncu55X/6Pb7Ppw7n+AzD7+5E25v+odXv5cS120YTHshImOQXsM6yPYOaGzPj+JN
 F3AQfYi598HKZdP/IwHuXo3eD7LI90C1grjJyP56cnGr8ms6Qx6Ui67GYF7xwIgQ5W2QASBDoDh
 agIo0FclKFKGQQqgQz5GpjcVOOCbMsjhXivzVLWcwPKhYNo9BEutZ6Q+8WOf9sDxm1zNkIDOwoA
 ium1LFaMqtD1nQETMY4rRaz53+FDuh5NuJAB/FkQYLqD27qJxiW/UV4Y1KTG6+WSgKppMRwRBX4
 j7aIFOPsNvt8jOHwSZCSCFW2mFi9R+8C/S8NEJRYsk08LBp6nx8y91LbaVWbI3tLjJoV0BxwttZ
 YIMexGCh+UIYClEuy34/+3fUnuCvJ6P5F2vN06vA4dPeobkwhTn4w39/82ZJeyNjG+zzzSQQsSH
 1f
X-Google-Smtp-Source: AGHT+IHofaA21vS+S+C+2knGRsAiCluJ1EAbEyNNslyC66ft+L8dYZESj+WOLRPBkZgm7zjEMwrP8Q==
X-Received: by 2002:a05:6000:381:b0:3a6:ec41:b9df with SMTP id
 ffacd0b85a97d-3b776679a0cmr7916574f8f.49.1753698925049; 
 Mon, 28 Jul 2025 03:35:25 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac584d8sm96948235e9.21.2025.07.28.03.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:35:24 -0700 (PDT)
Message-ID: <aa27f93f-5591-4a6d-879a-991004ee5db5@linaro.org>
Date: Mon, 28 Jul 2025 12:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
 <20250725223035.52284-9-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725223035.52284-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 26/7/25 00:30, Mohamed Mediouni wrote:
> Instead of considering reads there to be fatal, mark it as unimplemented.
> 
> This is to allow experimentation on using configurations other than the Apple vGIC.

FYI 
https://lore.kernel.org/qemu-devel/20250623121845.7214-11-philmd@linaro.org/.

> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index f5b82cdce1..c3df7e07e8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -299,6 +299,7 @@ void hvf_arm_init_debug(void)
>   /* EL2 registers */
>   #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
>   #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
> +#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
>   
>   #define WFX_IS_WFE (1 << 0)
>   
> @@ -1398,6 +1399,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
>       case SYSREG_CNTHCTL_EL2:
>           assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
>           return 0;
> +    case SYSREG_CNTP_CTL_EL0:
> +        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CTL_EL0\n");
> +        return 0;
> +    case SYSREG_CNTP_CVAL_EL0:
> +        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CVAL_EL0\n");
> +        return 0;
>       case SYSREG_MDCCINT_EL1:
>           assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
>           return 0;
> @@ -1718,6 +1725,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
>            */
>           qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
>           return 0;
> +    case SYSREG_CNTP_CVAL_EL0:
> +        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CVAL_EL0\n");
> +        return 0;
>       case SYSREG_OSDLR_EL1:
>           /* Dummy register */
>           return 0;


