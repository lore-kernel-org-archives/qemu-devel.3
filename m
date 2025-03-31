Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D4C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 16:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHnP-00020L-Nd; Mon, 31 Mar 2025 12:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzHnN-0001zU-Qh
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:15:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzHnK-0008MV-Mo
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 12:15:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22928d629faso51239305ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743437724; x=1744042524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9689pOzOcnr692n5+VxzO3lhYTf7JXr5AdR9IwYqDI0=;
 b=Cug/sfmfYgEy2RXrXrNjOUVaNKmeWsFwe11k01JdXGv8j2QIYXI8ctSJH3UOzAuo6g
 eP6B2WmjIGVthysHMsW+x2SzfgZidWUzDcZ0k85JcxQ91YzS4qTGzhxPm3h+82IS/iGN
 CBTdOyOlE9ZbmOYYvWaqhZlLmxplVg2aXMGyAA/YhZfunzRnwKZb4Lskmo2l2LWKoq4Z
 9ev8IMhEOsjryf8Quc10KiwcV6S7wyTwr8bbYzGgglh28k9mOu3XfKIqLatygofN3IrD
 7RcKH56i5kO7nzd17o54tyygjjcWavPd5TYEPVdqCyAZN3cZAYQpe6WX+ttQCPISMCNA
 /zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437724; x=1744042524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9689pOzOcnr692n5+VxzO3lhYTf7JXr5AdR9IwYqDI0=;
 b=h5BG4s8CHU36pIL29DFL8SgaD06VBXJfLdjnB4wYObQJ1PTm8HU3PUf8VEXTWaTjrP
 zBr969wopd+SO6fHQpKid366hERkRGzSEpTDAGfDs1GDTmuFzoqjtBreL9IvziPmn5PJ
 w5sSPjWVYv/Ie/HSDG88rrdW53u1XdOcOrepLw2BfaydlBWZp4EQv1YhP8Tt4NTTlsnK
 dz+8VQIG7SeMG0I/vht4T/6gV4rg0syeWb9IQwMCJ4U0uepxbnUlcrlDX6HQRWKgk+cd
 UlWxMZg5/s1c38JU1OsgQKP1ChMQTGmp4BdRe1nkRZ2zSPY7pG5HA29lUOLu0t3RLeRW
 4s8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF1KKM089ewckUXIHFs3tzdS3B1FKXhYIN39oufbwGjP5Y8CG84Del5BDBfITwg7VGM6OkQu0oETxd@nongnu.org
X-Gm-Message-State: AOJu0YwkAnNoHQHcM+AkYpe2Bd1SplpgXeJ2qbc+PQ90zZqXcezphbPy
 KAe3HQo5vitmwpZQaa+XoGSpQBouZHBqwcySgTpW6y0phOFvIEN5ySf+mlNY4+/wLj18I5Vh4fl
 7
X-Gm-Gg: ASbGncugeg9C/DsGwVOTK5+utyf3iSTG6SlZz3YmG/2qe66fbOSxUsnj2AcRly7lUHQ
 tuOnRzSk5gmzP9WBcMBFLSXoKA0e5K2adNJPS7IAgKqoQP5VKArwqlMThRcpOtEZPdS0arSl9TQ
 pp8MEg0WSKsgsPZJ2boR+sOXMFD4KAJCnWMmnQQvazbmscMkG1+eu0LaY50aOEgWmFUl+do1Bci
 msKpGeIFZoPN2W8OXmUtFYzEuL6ZMKSslQ3Jayg74ybG55KsBZVUX4G1xyZX2DbJ0N/G+IZ8qZT
 SBPWQIviatSY+varWk2qA9eGmlfhGfylMERqE+ClbtFHdTMNYXtqhFr1VAZCCvNdDcY=
X-Google-Smtp-Source: AGHT+IGw94lp3DvNLbq3wZYouVEha8tdiGl3NicnLc3k2v2IQiU3q/nDpFeTYaspmn5vOktnfI2Rlg==
X-Received: by 2002:a05:6a00:a85:b0:736:450c:fa56 with SMTP id
 d2e1a72fcca58-739803238ebmr12482252b3a.5.1743437724503; 
 Mon, 31 Mar 2025 09:15:24 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73971063d19sm7372763b3a.90.2025.03.31.09.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 09:15:23 -0700 (PDT)
Message-ID: <86700de0-42b6-4403-bd9f-1334e22bcfa8@linaro.org>
Date: Mon, 31 Mar 2025 13:15:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/2] hw/pci-host/designware: Fix access to
 ATU_UPPER_TARGET register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joey <jeundery@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-stable@nongnu.org
References: <20250331152041.74533-1-philmd@linaro.org>
 <20250331152041.74533-2-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250331152041.74533-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Phil,

On 3/31/25 12:20, Philippe Mathieu-Daudé wrote:
> Fix copy/paste error writing to the ATU_UPPER_TARGET
> register, we want to update the upper 32 bits.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Joey <jeundery@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2861
> Fixes: d64e5eabc4c ("pci: Add support for Designware IP block")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/designware.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index c07740bfaa4..5598d18f478 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -371,7 +371,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>   
>       case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
>           viewport->target &= 0x00000000FFFFFFFFULL;
> -        viewport->target |= val;
> +        viewport->target |= (uint64_t)val << 32;
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LIMIT:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

