Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B06FC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOjM-0000PV-9f; Thu, 31 Jul 2025 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOjH-0000LQ-Ng
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:33:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOjD-0000Jj-Fn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:33:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so7016605e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950809; x=1754555609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KnmvQSXuC60PRJdaIJSREmzTD/ja2xfMhsheb+/py+4=;
 b=Lab6PU3vj00Z8FwY1t3+FafdORVRi3L46AXZU2MsPZVqPtjQpche8/Bk6pnwtYRwvZ
 sMx9+wMY6ZVcYLyp6MukHWm1NLacxG+dWF7tH4JO5T/dk8zy/iH415BFG3v5KhI2nwI7
 cxGQRvVzjPOj277CKgbxc0wpc0zaSboPvXaCjkqRYLO6wNsfuXiAHPcv6OTuyb8ihO/P
 F/2wNIB3Yia9a+am3FV5O1myC/8TrOQ5BoEYt3dALcHzCVEJQ4pIGFW5OJSbM5mSHYFw
 BLl3A+sv6/rTgTqOnFhATT+4dq7iXnpx7mhUlhCb35wnt/0Qe7/YvHv5WLG3h/m63M//
 2k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950809; x=1754555609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnmvQSXuC60PRJdaIJSREmzTD/ja2xfMhsheb+/py+4=;
 b=YrKtdM143LSi7a6bvrrxYGeBcXfOflzEhwcsYzLdYE1zz2WirjMIubnvoLyprBHmzQ
 AfoEWEvCR2KxZA34f7b/SKS6o8dUIKS8E1xB8rt+JtMZAKve0z1ZMFElhg0OmcqSNwD8
 fTnOr/cLGAOBX/AcrLabYstcwtawr3vXdnDXAxZ98u/XFffBXVvKp5kY5y5nLaTWvKFE
 DXtkeSVI6G1Co8EeTnf49o2Sl8xh2/VrPJPWfpZFn9uctkrNn9wEU1bvoZPy1FA3nDIm
 bVyUuT2EGl/8Pr3+oArlfGAG3Sd4AlEb28vi8Flce45or8fBSauYt+hy84vR0Jnm6tsS
 uiwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGtl9xmL+6kLADNC1UfEe2uGO9hCt9i9tNukbDYF8pK6tX2scwfl8JSHPzqM9l4Ydp5iFTP1Lj8IwW@nongnu.org
X-Gm-Message-State: AOJu0Yzy1Tan7M6C29vcOPOHT+rZJdPM+rzETYSR676G34JSj4p26eO4
 pGKezS0wkNhfHDtLq+W0DpJH001+i5etndnij0Mi/HvPd1lL/msH6iGsEj38v4rg21k=
X-Gm-Gg: ASbGnctQH0rewLfANXYm2WetdOEKCBRLDWr5YaLTofzDPcclBjHKjzUVx1JGXe+gKFP
 KHP8pdo2YoeZk7EeqlGpxPOp8obOoHFQX2kIxsktm6SPa28jvvvC4vlY9iZdTIdOzBo62xE1ry6
 QWoJX4A6H4OSeI9z2XTLv6BmCB0Z/9K0a20No9zJFmgB1LzGxcEpzE2afEFlmdBuJGh3Kt0BEtW
 r4eIijnnrDO+buwHgtJGePNBpgnAoZ2Q2PNlfAGDZO7X/JmeKyRq8cimY+rME3MI49bjVB7xtdL
 jbdRQZPyAjz0P+ezod7HsRKDhM1MgO7qSIiJ52BW2BFXE/cGzrlLTof7Ty8Zb1JOPb7tBdcbwEz
 SotTPJ5LHmofpmSqaVS5tp7JykSH7ukvO94aksbkNTWBvm7hR5UYjS8ElTbgJQNYr/A==
X-Google-Smtp-Source: AGHT+IFJM2YC4W5Aw8DhfKJiGfcqSAgxgdoUOJbZSw/ZEHR14mtoiBKk3jioYqESXbWMeCWbrewwqQ==
X-Received: by 2002:a05:6000:430e:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3b79d4ead74mr911189f8f.18.1753950808745; 
 Thu, 31 Jul 2025 01:33:28 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dd375e0sm67449225e9.2.2025.07.31.01.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:33:28 -0700 (PDT)
Message-ID: <24ca71d7-041a-4d21-8ae1-5f6976fa589a@linaro.org>
Date: Thu, 31 Jul 2025 10:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/9] hw: intc: arm_gicv3_common: add whpx
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-7-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731052753.93255-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 31/7/25 07:27, Mohamed Mediouni wrote:
> Redirect to the platform-specific vGICv3.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index e438d8c042..a83b075517 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -32,6 +32,7 @@
>   #include "gicv3_internal.h"
>   #include "hw/arm/linux-boot-if.h"
>   #include "system/kvm.h"
> +#include "system/whpx.h"
>   
>   
>   static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
> @@ -662,6 +663,8 @@ const char *gicv3_class_name(void)
>   {
>       if (kvm_irqchip_in_kernel()) {
>           return "kvm-arm-gicv3";
> +    } else if (whpx_enabled()) {
> +        return "whpx-arm-gicv3";

While you follow a pre-existing pattern, here I'd prefer to use
TYPE_WHPX_GICV3 (after defining it in hw/intc/arm_gicv3_common.h).

>       } else {
>           if (kvm_enabled()) {
>               error_report("Userspace GICv3 is not supported with KVM");


