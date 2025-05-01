Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZBG-00087v-PH; Thu, 01 May 2025 15:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZBC-000873-Ak
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:02:42 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZBA-0004Jo-Cm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:02:42 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d589ed2b47so4352275ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746126157; x=1746730957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgcGSZOdA5PkQNmUlsgmbprxhpBnjZCzinx8Cu5Y0dA=;
 b=iX/606hi/q33Suy9sRp7bpGAixLhSVfiK4884poJvilOZMwQ2yA2KzbS8408Ef1Jxy
 JdU/jhNUA4qCa9XPKr53uSJp3FolC4KnWmy7i0dfdMgmVjrkdoTnQ8pmoTmGLSe/pmT8
 jaElCh47J5BdjGu8VPxMq/op83m6wThIe5T9nz33ToZ6IIoN85VKCic+1/iUUFy2Amn9
 Rnyg19FfPzqNYbwQHg32zNgab0BvSYQ7zF9p+0u48EVQ+rQ7AYIvVQK8mJG5RLBsGJLO
 MNShgMrUmXCZIGklTEEchXnKtWex6jExzLE4aKD9VWAaYz+4QoGbKx1luCuLyzOYnGHV
 rslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126157; x=1746730957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XgcGSZOdA5PkQNmUlsgmbprxhpBnjZCzinx8Cu5Y0dA=;
 b=aFsRP8eiU8nzzZQNNcOIRRRW3oAGQgwwzKmTfOEu7leBb15LDiTszXNYGpjpXnIJul
 o5r4WyxUSpxFHWOnwlXDJTDDkYjzCn+mqYKHgHMnCEMvD5am3bHG/reiLizoPATuEXq0
 EGc31x0T9ngDz80kns4TGNd5xUOQB5+dsPuacmMIOHMAVJ5Z7gN8oTvT9uK+FWvhZrbN
 dC40z+BlyLR/iI6lc0/6CVZM0ZrJm+QW96B8wGsRlmtkOaJe14qPSvgMTD4ecGJYnwuR
 vx9Qr+xULCyF6DjaE+BlwiIoCYYsJKDOPz9g/cKWm20li30ReQq2N38Cyz38wQ0a6ABh
 k6Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+LMFQph0L0fJUAwu2/b23ZD3EmGrBSMF5/Q4Dsx/MLfRx2dmahGu/XbvzpI0M50VXBYG9qXGg1TJV@nongnu.org
X-Gm-Message-State: AOJu0YxVqnzQ7jtnBxBVTmJARUpo/87iNnKRDdgWr2vb852WM9ri6am3
 yALeZiYaYA+sy3MnI8a7idjoVunjMBjvQArzFUIFw3FmahbX/WVHT6sx/k7sXsFwLd34vAukQj4
 6
X-Gm-Gg: ASbGncs9cGg9sTNVhSCJNDnEUHVtyzOTA9hHe3eri5sq8+e+nxG3ulLDeJODyxPp0LU
 2Ou/oaxZWUFxAo33NFLex8Yzjq3rg0p5WeAl9XA+rEU8Ed/CycqsU9sDn3tdEZn/fjvH4t6eaxX
 hBAd9rBXlmP4si0Eu/HWh5lmSe+ALXD4oGbJc3SVnbJ6YvYOSi0sQVFCtZSKV4S84jWa6thjQEL
 WY/Vj2kTSvKAaPuqnvZNecKUNHyvM0p5bkdXrleCr8YgCuTwhgl7LtB7/0NmvtmVzkAYMyeLmPl
 sWNYVSO2Rgr/3D6KCfmkzyKq8F5xMPGswGZn0l/X7C0eeudOVkx6S+V8Y3D04ZaspqfvQ8zFwGG
 LDbHUgQRHMGGw8A==
X-Google-Smtp-Source: AGHT+IGnL9Aep5oKsjoUrhSnvaWXehEUiFZjWiK1ZiuCtwN/Qj1yZQ79ku5ItwYi1+BkLvIZUpUn/g==
X-Received: by 2002:a05:6e02:188c:b0:3d9:6d6c:72be with SMTP id
 e9e14a558f8ab-3d97c15cfc8mr440065ab.3.1746126157361; 
 Thu, 01 May 2025 12:02:37 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f6dd89sm2664605ab.66.2025.05.01.12.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:02:36 -0700 (PDT)
Message-ID: <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
Date: Thu, 1 May 2025 21:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/pci-host/designware: Remove unused include
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501183445.2389-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-il1-x136.google.com
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

On 1/5/25 20:34, Bernhard Beschow wrote:
> The DEFINE_TYPES() macro doesn't need the qemu/module.h include.
> 
> Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types using
> DEFINE_TYPES() macro")

The 'Fixes:' tag is for bug being fixed. Here I suggest:

   Since commit 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM
   types using DEFINE_TYPES() macro") which removed the type_init() use,
   we don't need to include "qemu/module.h" anymore.

(I can do the update when applying if you agree).

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/designware.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 183f838392..b4bff14579 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "qemu/module.h"
>   #include "qemu/log.h"
>   #include "qemu/bitops.h"
>   #include "hw/pci/msi.h"

$ git grep -L type_init $(git grep -l qemu/module.h hw) | wc -l
       50

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


