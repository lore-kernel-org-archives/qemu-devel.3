Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1518C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufI2-0003Mb-64; Tue, 18 Mar 2025 18:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufHx-0003LI-PX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:19:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufHq-0003yS-1a
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:19:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22622ddcc35so5455895ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742336387; x=1742941187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VTGGUtCqvaeyCv5ha1EwY7WPOyRwsuePzUbQ67x00IU=;
 b=pr9SdcmK6u73BOmf+HRy2wcJkJjZ4vy7ReNFMbKeNzU5qZy7Vfhby0PpCRLe4RF0hZ
 b7gjI4uZo1U49UJrDUHZomRXfgZD0ufhS+a6N5qOT4eSy9OZWljKvrcNkpnPGWTI7gRr
 /s/ykV8o/Y1mbIGbb2xe5l1TfpvKLlESKOt72VwTftmia52JeY/xb/N57vnx6nYSRf7/
 pooyrJiMH8whttYnnOO+I3zXzDq8h9NG3lpKnnWhNKo+MtLax4J4sPCP8tU+onEjG0o+
 KPRXsmbFLsQzaAGXShWGIILW5WzfnhLoSQu1/2sQj7us4JvHop+VXBXIY5Bg9VALhPku
 0UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742336387; x=1742941187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTGGUtCqvaeyCv5ha1EwY7WPOyRwsuePzUbQ67x00IU=;
 b=OwPxYtmIkTWfmjvq/kN06AiqEoB6s+C8hZZt/ZtXCXhya2u24CgCse8GdjJntSO3U4
 LUnK3wn+ky9iCUhpGNjzcRhPjVU/9KGB4468EC17nGZbQt56WBLPU+bqLjmVi9N+nkjb
 uCxrVRTZ++Vx8XCwqW6eBb0TrYbAzABGwLaqO2dJQZEuF+jWWdBUTFhcbnYaCN2HlFUU
 tVu4m7+JYov8puBNX37AfZF03l0TQ1JNQU4+SqhI1oLQpibUM5dgf6B35rZTuaB9Q3B1
 RlrtfRpYaXo++ongpU31jZZhvTFDsOHR0KZEKI/jaFHlzwD2r+cJzk7AzMV1RsLsUGrn
 DW8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKijmbqk/mqdHjgyWUJ3Z95DeqPxXErOOTj8iY2kb5qZHYA6bnzh0a68KVacej102ZAXEXEunusxX@nongnu.org
X-Gm-Message-State: AOJu0YxmB9LR0+1yUl1js9AJJ/KNIKV9jFUrUC5Xxuvq6UKoCmqywG3I
 YtMJIvsVfSdvkpJovhtCtZ1M6LKFtNHs7+QY3p4ZDXxjdHsfIAXHVjzQVRj4GfM=
X-Gm-Gg: ASbGnct9TaPXdv3pBcYcTIm5yzo1vcZ0YAzTafLmLmWJmbHp8BqEvjYHyFahbnzETQ0
 ji9fBvqTqUqjbvSDsFFueLcvzJmHiistE3Q/JQl1ebogter7UNPDD/rtSsyB4fT3nQHM9yvYWb6
 6WZ7XZNwwgXMNXFQtW3ffV3wuULLLnt0nmlDXxl7UFR5eQc4y8GAZWBONJb9eA6Bw8ELBg2evTV
 gCwoAPJRxnXyxRSEQf1bExNnl38+Cd+mhJhECV3y9K6ZYYXvHcWTpdrqdLNzv2JX2LEvtauLQnT
 IvFt8tyCgZfTiLoL7LdiCQu5gDcX9vcjjcgn3KrOeYuPZcyUgzgKGbku/pl6aNl+5LcyYITjMSO
 OVeIrt4KN
X-Google-Smtp-Source: AGHT+IG3WL2UZjLRcBSxDIrHyiZ799+Zj+pvjdJn5gm7VGBFlAyVOVO0vmRFXWt9lA78bwybkCPvEw==
X-Received: by 2002:a05:6a21:168b:b0:1f5:9cb2:28a2 with SMTP id
 adf61e73a8af0-1fbebc846e5mr518960637.19.1742336387525; 
 Tue, 18 Mar 2025 15:19:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ca494sm8061555a12.5.2025.03.18.15.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:19:47 -0700 (PDT)
Message-ID: <f1ce73a6-717b-4230-95cd-45505fecf039@linaro.org>
Date: Tue, 18 Mar 2025 15:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm/cpu: move KVM_HAVE_MCE_INJECTION to
 kvm-all.c file directly
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f89568bfa39..28de3990699 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -13,6 +13,10 @@
>    *
>    */
>   
> +#ifdef TARGET_AARCH64
> +#define KVM_HAVE_MCE_INJECTION 1
> +#endif
> +
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   #include <poll.h>

I think this define should go after all #includes, emphasizing that it only affects this file.

I think the #ifdef should use __aarch64__.  KVM is explicitly only for the host, so 
TARGET_AARCH64 really means the host is also AArch64.

I think you should go ahead and adjust x86_64 either with the same patch or immediately 
afterward.  There are only two users after all.


r~

