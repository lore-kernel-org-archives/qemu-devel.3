Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E5C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4z4-000295-Sb; Wed, 02 Jul 2025 17:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4yu-00026F-Ud
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:27:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4yq-0005y1-7Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:27:02 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-311c95ddfb5so5662700a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751491616; x=1752096416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnT9NdXE3ybydcEe8oSYwUjLjEOXETYq80rC4G+1H7Q=;
 b=ost+dgOJr+qywdaYEk9G2ds0/slWBi/ufuA9hLSbdAOZpYPvmwPCi0itNCnEYo1fkK
 1yTyNg7CyUBwm12eKfiehxwa+lOCyZEr71uENv7AnxKKQiJxUoLNX0m9etoX6kirt946
 zAMP5uDgXOVZgMpf4vpZO2U7Mya0ir4ipDOf/SFVS7VGQ7LIEFT3HZF+hlXfsyQOe0AV
 10CirXp8AZT3lsJxkPhDDMk85lIydtSxV3NMPGZsM6ruTAd9MMIeXSMXE4kMsMnf2W/d
 stFiGXjjMYpYUqIQHEqqRKzRoxiLMP+oVQHPtID2QKlGocJnJ731cZmIMLzz3YVcKqdl
 EcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751491616; x=1752096416;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnT9NdXE3ybydcEe8oSYwUjLjEOXETYq80rC4G+1H7Q=;
 b=R9jGBddvgQmCbNu11fef1DuvHc/wQO4NIcxdgbcNEMEM8VI0eUCzTxkUG3hMFm5aIH
 0Udtf4p7BN65mSlp4R36U8/b+0jfiKAI/5ihSLISF8a02q3hAAcA72yXdtm4rt1oKsPY
 dOChtPenXiFZlcVr8QCNaWLayA2NPNZ6cXEBcJWezcIDxpkEElENPHSUYhPoyxUx65HK
 OsEXsereU82ScU4vJ82/8DyOqJUJc0bmnZoiIsSoef46WpDPPHJR6Hsojvouqs380L04
 Id1QV/8IM1ztwV7ObrUOXOkGnndYCmvgqWljpBRWNRCDjqd6zX9r31s+6ECJF53++glo
 kxCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU12a+BwbgWx53tg0v6l+sBgN9625t0J4zTJ0lbunIoWR5yG1CqHhv8U0DRnhAc7/SVSRNEJ7b8KL2R@nongnu.org
X-Gm-Message-State: AOJu0Yxt0oRA6yNmPMAmvi42DYKzaygoMtqZE111tTxPKHlNVcLueoyZ
 XNQw8JzHwk1zW3/7n8zzieZxnGSS9yDystBxJlw+27BsnZ4XPBbOx1Pam+duCgQQV9c=
X-Gm-Gg: ASbGncsXHfjZ7iPDTWRvV7f/8d0B4Gq69P8vHOe/ucUE17oBoX6orPJ8F+GIbR2bP0s
 D3R/2y1QITzfx/NQLMvAjOEbDH8YMr5WiKpU/ZAuCLm5Gwvc3Vk7vGdpmY4i0VHfRI1fbg/QpEJ
 +CTe0pZ4QmXmJZbQ8lCsawuscjNAqW0UZ/MGr8zWtW3InCf+do1Ky6D2giVcpIDkv0ZQ0bmnDIM
 mfYtCIm5gyDwlApr8i4vPiZYvYGMrndWPILdv+bJ3rqlLO/aSueWZa7FOprPLJionqfPkAFhnpS
 4d0Yt5YSYZfx0pv0am3q62H1xE5TE7D3r0ggI1Wn9V6ewWsTPBubVP7FP6qp7ArwbODYgi22GzY
 =
X-Google-Smtp-Source: AGHT+IFcgjPigidp2JUObKIfrGnW+CVetFfi2zv1TnmMkn0UzMtONPXdsIJh8GiugT0++pMmG1OYrA==
X-Received: by 2002:a17:90b:1848:b0:313:db0b:75d8 with SMTP id
 98e67ed59e1d1-31a9d64e448mr1002562a91.32.1751491615640; 
 Wed, 02 Jul 2025 14:26:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9ccf8711sm570443a91.27.2025.07.02.14.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:26:55 -0700 (PDT)
Message-ID: <5348f155-5644-497d-b9f9-89924d961cff@linaro.org>
Date: Wed, 2 Jul 2025 14:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 57/65] accel: Always register
 AccelOpsClass::kick_vcpu_thread() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-58-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-58-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> In order to dispatch over AccelOpsClass::kick_vcpu_thread(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::kick_vcpu_thread() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h | 1 +
>   accel/kvm/kvm-accel-ops.c  | 1 +
>   accel/qtest/qtest.c        | 1 +
>   accel/xen/xen-all.c        | 1 +
>   system/cpus.c              | 7 ++-----
>   5 files changed, 6 insertions(+), 5 deletions(-)

Sounds good.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Unrelated, but I noticed that hvf_kick_vcpu_thread uses hv_vcpus_exit 
[1] on x86 and hv_vcpu_interrupt [2] on arm64.
I'm not even sure what's the difference when reading the Apple doc, 
except that exit existed before interrupt.
[1] https://developer.apple.com/documentation/hypervisor/hv_vcpus_exit(_:_:)
[2] 
https://developer.apple.com/documentation/hypervisor/hv_vcpu_interrupt(_:_:)

It might be worth moving x86 to use interrupt also, in a future series.

Regards,
Pierrick

