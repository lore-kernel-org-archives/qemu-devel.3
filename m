Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D62DC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4I-00087j-RZ; Tue, 08 Jul 2025 17:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEun-0003iM-Ue
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:27:51 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEum-0007xF-8J
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:27:45 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6097b404f58so7037114a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752006462; x=1752611262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7gD989/IHbOEITDmnVpOY1i9RKKNw/TFq+kVhgQcyPs=;
 b=x6fWNRsTHVXEWd0JDtQAYiUrDvQW6Dvum/oYr/yU1zMWN23JLt4EwSwkYDJX6obHk+
 wykKqfXDkkWMRrIevYQqomuRMI8toXp5Phnfs99697BDUYixMZBTVC5Af1p/5RlC2QKe
 l3KiU1AjxQX0iN9fAu5MvuD70cWIEuv+KrYpWaEYi9e4qUaBWSSHXp4z4UazAQoa/Un7
 oI+idmklsGMRtyphk1eIwPAVVxDAIyOHiQRsm7XQjJK8djDZ2Zbwh0rhixrWAkVZvytU
 iuR1NtRTd8CPpGBf9uG8eHKopd26NCnV++vqWBQXqyKqoE2nQIMODiA8CNg70JH0i6/U
 Ry9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006462; x=1752611262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gD989/IHbOEITDmnVpOY1i9RKKNw/TFq+kVhgQcyPs=;
 b=jm0Z0l8WFBEfCjxeAs9/mZZ4eb2LNxP/P5LjZL0tlAE3c+hUMgQyBN7DDyQxhrYUpe
 1BXt4Cdvn6JJOzxSGVJOn2OoPsIZqHyd7tX/2i02PZCN+SdH9ijIZmu4wbRFsbwfKeDQ
 WX2BdQ7e1yW7wJW7VaYBuiKjo6B3LbkSHm+8DP8dQEIkOQ9Cc4FP9S+yH0cQ1QsnsTgb
 I8uzI/+1lFxxlj1gt6JjCUlGyfKQkJKcUq2H2MWhgzKEjjiZa5uSzGIw+70e6BZdLz9S
 eialZQhhxthK/G9mF/RDVnrUNyIizZL7nhkE10dEXKBWxeNtjWTk9lprFho1FBqBY1TA
 uzRw==
X-Gm-Message-State: AOJu0YxRnT0pOgdX+S17KVKE/oqEllzPiK03kIsEMzC4wpnNO0QLkVxq
 6rEgGXWSnpsoNdTGRit1qYKWPNAyzFJhQEOSPMS9pcaj9RIZ4b7Un/1uPajxiqyi/uSC/kyR7jF
 tltnVkZk=
X-Gm-Gg: ASbGncvy8+K5Mt8In14ouZed5yliAYhnDCb9RlI3w41rvuJNtDpxkf02+JbXnrm2mjU
 Wj9SsvrzErfnpvl9HUjcV1eJxU7s+5cwkFACJ98Tzl/36sraVvQPplcV+rFgVS3+R7PNeNNhbp6
 nuI4ryE9B2M9NDV27rEeqbrL7m45VK03i/ugZb9e7EC9Bw4UdQlssRUFhe+JcYvZrspTcEssmgR
 MeG4ELQhUSM1/nhFS9YWA07N2Px7/Gg1Lp7KsKle15cJc/vJUZvofaU05l8NMJgDVSC9JmdxJ52
 qh3urLRrYFNv5sSgrEB6v0vsE+G3FYCLjlsGHRd36M4+fDa5GpnGqBwEDr7illLOI1ro8X2sVyE
 2yEtzhwBX3Eg/WjrHpEOv/Ux4TIm1ZA==
X-Google-Smtp-Source: AGHT+IEWZpnoQKeFLfTnSEfsXdg67Cdt0sZyuOKGWl1tGNjLw36QOObt8l8PjxR+ae0QDRMyjwgpFQ==
X-Received: by 2002:a05:600c:6384:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-454ccc7fff2mr24082935e9.12.1751959237951; 
 Tue, 08 Jul 2025 00:20:37 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd49398csm13095705e9.22.2025.07.08.00.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:20:37 -0700 (PDT)
Message-ID: <b1d2f82c-7db6-49dd-8c4b-2f811c8616c6@linaro.org>
Date: Tue, 8 Jul 2025 09:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bulk: Remove unnecessary 'qemu/typedefs.h' include
To: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Bibo Mao <maobibo@loongson.cn>
References: <20250707170904.2908-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707170904.2908-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 7/7/25 19:09, Philippe Mathieu-Daudé wrote:
> "qemu/typedefs.h" is already included by "qemu/osdep.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/vfio-migration-internal.h | 1 -
>   include/system/os-win32.h         | 1 -
>   hw/intc/loongarch_extioi_kvm.c    | 1 -
>   3 files changed, 3 deletions(-)


> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 3aa6cee4c23..662cfabc5e7 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -29,7 +29,6 @@
>   #include <winsock2.h>
>   #include <windows.h>
>   #include <ws2tcpip.h>
> -#include "qemu/typedefs.h"
This one was introduced in commit f5fd677ae7c ("win32/socket: introduce
qemu_socket_select() helper") for Error type, but files including this
header should already include "qemu/osdep.h".

