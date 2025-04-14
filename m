Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A423BC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HI0-0000aU-QP; Mon, 14 Apr 2025 06:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HHz-0000a7-Hh
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:43:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4HHx-0006yG-G1
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:43:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so46253605e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744627419; x=1745232219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1MZ0v41VasWztOjswGKD3Mq1UKw/Yh0NDdJUxmOEsWA=;
 b=EwxFdu7IJVLeqcNpsk95wwhT/JEbQLgNwSxZGRhyvk7GVhiRvrCzb4lziMBF39/qj2
 dEfeyAwI6CObTnVwiNOol9X5c0bzpJn1xFhQImzkA+EFge978jbcsTa2y+WCRNkz40dy
 nl5gZyPJcWNEfW+UaQ1cuxJrzlxKIXY8vqhgbJKrgV64qhe59PVSeFK6yhRp+e16mpvI
 srKOVXFXh1vi37/MJABQmiDnznX6GkK8SMnkgKMz0iUl8ocilEURTJfJ99C8fj9TVBLv
 slDjISQ9U5etYnFMZ8v2GU/CviaUP9IYtg++Bn0PRcGgakgL4ybAYErz2mZ5wox4zr8b
 4XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744627419; x=1745232219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1MZ0v41VasWztOjswGKD3Mq1UKw/Yh0NDdJUxmOEsWA=;
 b=UIqlZJiIhDoBRNCnhnWteMCrdVArgWA6PYak/fPAPBFaLt0UBkfSwZkW2vJB/ZEev1
 ZxxzCm4fnVnVqSHJmUy99kGPwIVs1FzT3j3yUe2FRI0UUWaMGg2aZzPi9G7u5ftbNh6j
 Q0ujr74OV0FkF/Ws6h9beEB0RZPqVrU61L/qmzWc31nlu+fpz9ZELtmb5Zwl0qXZmNUM
 V7eGB5833hpN03Lu35Alf4aJa1iIkd78ShcmDFWYj9B0Af3K8yAVHUvQ94RDSTBvic3V
 6cvXuY9PtpeDOQh0/SE9ml/ZkapqpNphoKXs9cHgq61vpsQQybUSFbrErpvr1SPGcBNQ
 nprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH2vcDVhvdM2dQaw72ElEdWvVh7AaoluWkuuZY52XETcn5CBopubNvCsOYR35xAwm3AsqPSDGPXHgA@nongnu.org
X-Gm-Message-State: AOJu0YwLUUq6PhTHLO20VTQF/IcKmNfA4mdfxmRbUi7Cuj87abprpBjt
 SfNGqRBsiIk6WhmN74Lg0xKZEvcF0fkYC64UMT3MyU88A5femGDcIoRX0B58+Ro=
X-Gm-Gg: ASbGncvy05wKzLpJBbvm/iFx9HzgVVRYzxMK9zcJ/wfGWJBUK+0nwI5/Der6bCyA+WJ
 hmi6atSkSagiWP8w+g4hwulMNf0Bqn5e3n//DcDt6YFiYUtP6K7nALh+cKYicP0lSMn97HjyNn9
 Sxk7DCt+XYtCXftwyPt7eB/di/1qkBQqzZZaVuAevJUay6BSYlCPlj7AheYGl1RF8VsNtKQ3Rvc
 W00ZvIKdx880lHz8Isyi7KLBFT6JkQL8z3TtTUr8lJ3uoObwbn6eLWq24VpZzzk6/xrWC0k4XHc
 63kODjpQNu2dLTy0WSKydS91R20Q0I3ViT8ACt8dKLLbGhveWIw7GYj8UlUgbzL+z6EmkimFS1k
 Io7mTCOEQx41z9ZTMASo=
X-Google-Smtp-Source: AGHT+IG1rkQyspSfPt0t6mGKl09frEd6lB0m1zlCGK4ukpL+yupl2eciqtalGCQfyaV+atfIclpuoQ==
X-Received: by 2002:a05:600c:1da0:b0:43c:f81d:f with SMTP id
 5b1f17b1804b1-43f3a93f338mr93956935e9.8.1744627419312; 
 Mon, 14 Apr 2025 03:43:39 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979615sm10901367f8f.54.2025.04.14.03.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:43:38 -0700 (PDT)
Message-ID: <834ad4b1-9dac-4559-b4da-bec6e6d4a945@linaro.org>
Date: Mon, 14 Apr 2025 12:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
To: Tim Lee <timlee660101@gmail.com>, peter.maydell@linaro.org,
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250414020629.1867106-1-timlee660101@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414020629.1867106-1-timlee660101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 14/4/25 04:06, Tim Lee wrote:
> Nuvoton's PSPI is a general purpose SPI module which enables
> connections to SPI-based peripheral devices. Attach it to the NPCM8XX.
> 
> Tested:
> NPCM8XX PSPI driver probed successfully from dmesg log.
> 
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
>   hw/arm/npcm8xx.c         | 11 ++++++++++-
>   include/hw/arm/npcm8xx.h |  2 ++
>   2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


