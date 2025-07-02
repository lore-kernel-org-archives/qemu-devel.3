Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC08C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4f1-0002IN-9x; Wed, 02 Jul 2025 17:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4eg-0002HN-M9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:06:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4ed-00009G-Sl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:06:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so7928000b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751490366; x=1752095166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=woAsz7NQBBXIl3T7NNBrgH9mk7oeS0QBMg3/vZsHoU4=;
 b=BaS0L/VG9VovjEMIPXe+cVhfVE7EcEOAbjwKtRFMAUK2L77unoCbEVldYa8rctegy5
 PF56r8u5d6QSrngS42Mq94qSgp2vWvE78vU0JwCXQsJDA50a+VSI8LbAmYYfjcpeTDpW
 JrBNfpS8Szj3/k37gLoK/CU8Wp5FJZmkaSMq/JZMxUFMaNb+LrI+4hRUtqWQXxuY9H72
 C7A32lWPF3b7e668+sulmhuIs+4ETyWFAhAdq0fy31IZI+FA9gy+EiG+CYrufsx23/aA
 HF/Ek3k+Dqz2fbt5LfdOc1fqiR5iw2iIZKXQTf3gc3WDa8/t5SiYbD8+EPSD+YcpWe1u
 9JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751490366; x=1752095166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=woAsz7NQBBXIl3T7NNBrgH9mk7oeS0QBMg3/vZsHoU4=;
 b=HCwU2jrzUM+NEM8u+YfU61vcJYFMGB96VJpQcF72CPmjLtaXQMhkWkwi1mbE3mNUTG
 UOPcLEs1R7M9ZLiZiOUuPPWj0hjk2COhcybuVX/2niwoZdkQJpsvHiixKJyX9Oc1ZLKs
 +ydVcynhRl09tPOhozgankXfFn+dDUS8e6S69E3qTLa6y2nrlObSoQSq9ddUt3YFQ/uk
 yzHL+E5mrR2z8o7hgnlG1gGQCztrU9m6GFxTLWakBrTGyU5J4gp73ZuOoPxvPGaIiMbz
 zaPwY9nF49UM4jMOYGCn6rFm5Wr78S+sYS+KH5a5C1AC6i3mPqWExXChyqo2XeG/NzTR
 SDoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyAUuJoV3HQ2AgdKPvV/sx4dSCFWjrOJrVPbyuhs2vA5CelXdYEFEPit5KFV4ySK8QzIc2e67Qdt1L@nongnu.org
X-Gm-Message-State: AOJu0YxukRn3hVT29TX/yBQScbJIgQ4vQ1MXnLiOu04e1mKwHMJP9Zk1
 sKGUDLxK1rozdL1PLBGcnG44YaLkz4dZSaQa2llWKhHBxET/tS1fshxOD6pQ9p/20Z0=
X-Gm-Gg: ASbGncsIJeVHVwgSeZnL9o7w+TJyxjzzwGrlqhq37WdeSP6PDuADSVwx/mNTBDGDp3b
 s+z/r3XgWxqP1G29nT0/aGasTdYYbmHE53k5nfs/MmHEF5fnBNXf7z1YMgoczgDxmrs9Cz08fwa
 mAcee5YVxWKRGFNXseckC7yz1UMDB0nDmrDm1EYPowCJq4onUk0i/bS5IWTlePCqfljrzUKfK2h
 2+igdf3TF0YIIKjvglb20Y/Xa24vdjZyunWh2agSqGvzHU2HNE3pSP0JOXW/RIgnPADRhdR0t1a
 5geAJfagFZjwpaDWyzZKddXdyU+tpUvZL06KDkNRRDjpH4k9DLPeD+R7gy2LpobTB+QWZAsQnjg
 =
X-Google-Smtp-Source: AGHT+IFhKI66N/KyK7daz24GPqIg+Pwy21APDKrSKQ/qXBCrHWHbP145FeKuR+b/4PElKT+0UI5jXA==
X-Received: by 2002:a05:6a20:3c8f:b0:218:75de:d924 with SMTP id
 adf61e73a8af0-222d7e9bfd4mr7524267637.19.1751490365993; 
 Wed, 02 Jul 2025 14:06:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e3039a06sm13697294a12.33.2025.07.02.14.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:06:05 -0700 (PDT)
Message-ID: <704ec3e1-9722-4d83-9c99-ab159388cecb@linaro.org>
Date: Wed, 2 Jul 2025 14:06:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/65] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Shatyuka
 <shatyuka@qq.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-29-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/2/25 11:52 AM, Philippe Mathieu-Daudé wrote:
> We need the QEMU binary signed to be able to use HVF.
> Improve the following:
> 
>    $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>    qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
>    Abort trap: 6
> 
> to:
> 
>    $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>    qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?
> 
> Suggested-by: Shatyuka <shatyuka@qq.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


