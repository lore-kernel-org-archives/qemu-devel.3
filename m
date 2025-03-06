Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8928C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq09D-0000dt-44; Wed, 05 Mar 2025 20:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq09B-0000di-0X
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:35:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq099-0007FD-B4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:35:36 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224019ad9edso2340165ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741224934; x=1741829734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tWSBKoyMZT8K/sxvvhM3tHp4YdXInvVrlh5Vx/7TXws=;
 b=Epj3poUjxinianggPucThcUQUeX8VMKVm2Tncd1tzHwzxBAidpCQugQcVtRQOoAEpp
 cI0/mg/hATyS+lB5JpcUZRT2BlfhvBk6OY+EgdJwEpr0uIO7JDH/oTOK+M4twosV6MVH
 cWtt+wpNnugfmTQYavxHu0fk/NoRSz2l3SrxGqC63hBlH3HPyZPGOxFVjnWEKXI7+54L
 BG/BVLzCnYC+hT5xnvJaUwlGquC5VOfacGAJdD6YXo0mOy1IwBtwgDjdG3k1BshNCxeO
 DfkUZAfvjPfkZAjA1MOoFCckP6cCXk9zNHcSEG0ipUXaPxYDUz7xcFmpH4585wbnPYz6
 bYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741224934; x=1741829734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tWSBKoyMZT8K/sxvvhM3tHp4YdXInvVrlh5Vx/7TXws=;
 b=NBQLkfug3YuxQ96VPuCkTuzHf6KGzAJxC4lu4QMgPtZjTMN+dxKypkguV5Q7jOQxMp
 RBu96ruMBSu5N3Ss5nPGkpZvXnVy3wwx+itF1HL1ht5AANSN9SrzFeDIldK+MjZm51MP
 7TrJEZcggZOolK5vW3aIsJ0fJZ6zXIJo8d2Ipng8AGFGoxGyhQVFwfZzNvd8Vxs9nmOz
 XdQDv1SeV8lHv8zkBfPp3ZLZVw6uYTDv/vHFTRGWT8bK/tHuOrFv6B/ASESvLnPW+t33
 vhw8oCdZWx03J69Bpha3eEmb3RYft1r0UqA/DP5Eq7WkNdO0ez3QEFOOABEQSQHfLHBc
 tYuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsorkf+Uz9QpJX0xI3WqIv8G/SfhFbXjzFvx6zcmevMPf4xAUmbhR/tJtslyyc+fiZakMsFIaTM8yl@nongnu.org
X-Gm-Message-State: AOJu0YyFBz3PECXV6AcmpvydfIl7hSE6IwLQveQF0SEUxhzCWYhirBNW
 g9uQ5f55Ttfm1LPv0QWEoUS+GNhUGdL0h4ESNUTbj8YXf2NSy3DInIdPnJ6lqPU=
X-Gm-Gg: ASbGncs8O1W9vQXIXrIIpxhRidDPL5OB2VinTyQeZvtvOkKR18RJI/don3ymbyUOt9p
 GcoN/Yx5+B7gofpEla0aT+c0DRpz4mMhzS9Hms4byAeHSnUEY9sSbSrVJcWHZkQLseutehVz3fA
 2hAmoMZ7Hj9w4EPYsjIx7eBXE9sabHavgLLIoropFx1xlB/GkPNA8gxZ/1IJdVT2AyKJLci7AK0
 QFkEFSKgCYfM9pzFGk2naQaNfd7w4Wq2SmgR5TJ7XE0St/00Qs3yRXbU9GB1/kmYQRLRb0orObC
 Oy3YJRYurwg+dGkYldfqvzp8OqxBejkbdhrZq7QGxAMTq5iGJhZjujCdjVrA+bqFyUtV319O1G4
 aggw0JsVj
X-Google-Smtp-Source: AGHT+IEVcJImr411+9ooyYISH+rucxA0KxdrY9yov2y7RPRg0cSevIF+MjdQLfwFQ4A+wTksboylQg==
X-Received: by 2002:a17:902:f610:b0:21f:b483:2ad5 with SMTP id
 d9443c01a7336-223f1c98d11mr78931315ad.20.1741224933855; 
 Wed, 05 Mar 2025 17:35:33 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a80dd6sm777655ad.114.2025.03.05.17.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:35:33 -0800 (PST)
Message-ID: <5be2251d-91be-4938-8507-b2586f853a38@linaro.org>
Date: Wed, 5 Mar 2025 17:35:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] hw/xen/hvm: Fix Aarch64 typo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305153929.43687-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
> There is no TARGET_ARM_64 definition. Luckily enough,
> when TARGET_AARCH64 is defined, TARGET_ARM also is.
> 
> Fixes: 733766cd373 ("hw/arm: introduce xenpvh machine")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/arch_hvm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> index c7c515220d2..df39c819c8f 100644
> --- a/include/hw/xen/arch_hvm.h
> +++ b/include/hw/xen/arch_hvm.h
> @@ -1,5 +1,5 @@
>   #if defined(TARGET_I386) || defined(TARGET_X86_64)
>   #include "hw/i386/xen_arch_hvm.h"
> -#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
> +#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
>   #include "hw/arm/xen_arch_hvm.h"
>   #endif


