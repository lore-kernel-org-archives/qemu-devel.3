Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AC1C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURRJ-0000cy-Rb; Wed, 25 Jun 2025 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURRH-0000Xw-SO
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:28 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURRF-0005Km-Na
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:27 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-311e46d38ddso1636989a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862963; x=1751467763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6T9c5yqN79/bWwmMTawztUvEuHWRUeQ0QWwuoQMU7fs=;
 b=vc1NA2guV38JmGRcUg0VdouuJJ5tYqaK7am0EtiUb4iuO+Ic49kohnMfwDDLc/Rgrw
 rS6bWxWmXbl7v3x4oZHItVzzZ4kMiCDmJcB9owyxU5h/ed5Sst5aICyR2q1sQ355gqL7
 9Bqgv74LC6FaHAic0Czosqd8IqhlXnvdzc9hWjqoY3WzZjWk9e1TSZ+7z3kMFjfxzuah
 n0KBhYVn9rCvGY2kt8HiZnkFz/Ag+NOn3PNy3p59wCm4zb+yCTKionurIxeWJVHjC2Zu
 zKHSvWs1uZ8jAMApp+/ky5A8Ro8Ok7xIfx1es1WiO3WxQ+E9mK2IXTuSxCkmNumvfbP7
 M9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862963; x=1751467763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6T9c5yqN79/bWwmMTawztUvEuHWRUeQ0QWwuoQMU7fs=;
 b=OHIrV9ggGow9LtOv7cZQGpUpIqkrYZUgjUU+/BOtAIxUJACL6wqj4gCqEFyGcVhXgQ
 87beHjPUjZ0sKde7PiUx8qt3eUegV71j+8ex68LB9Z8JF+d0y1D/T5bLB/s09mmPrFpE
 4PDzPtLCVMDYS4eFfcC3e9auSxaazINgAQtPzOFovLTSi8CkxbQjrfNwrnVxvxbWyXTn
 doZxAr3Yjdc8b8L0qYe0D2EuoEokCG1IwuRtR+mHRqlA6xXz18KQvOsSJr0ur1mzKbt9
 uVcFeXAe/HSyXiqE5hHqWvedX1i5g4fbK7nnkyLB++rbB27MzVEZ8grSIDZQFPlJg81+
 drcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU04dtv35CrxD7M1Z/kF0QIG/5+wjN2IQI+1EVInAu+QxwucsHV4mFmV6R1p+69hPM5dg10imFcqzmx@nongnu.org
X-Gm-Message-State: AOJu0YzbCseqY3BacjtN1fjPD18G6vCuqF36FXrTvoc+ZtaBajwBkbrq
 Dbo2aJTiYTMYCkv5L8iMh8S2Um455WqmPjD0v10c0Tre7sltKTY6YIdkPTWQZlOq0bY=
X-Gm-Gg: ASbGncsWvKTD/TOAfrry9hPs6vkR/O2veihri/k4CS8SsGDuWX+tLHmiC8tHKXg+EFg
 /BVpZTnb+f/MBkCcnwJkvTGf5b7LR6O5rbajJxkPa8f0YORBRmYGIn7ucPCekg1pSstwB5Vgnng
 iSfjfPPUE5IT/zZdTF1/e3rOWlM4YRkFCnqLSk6YPDgrJtZSb74TIMGZ9oEKxdcWzQ2wfX1PWG4
 NySri9XHGSyQayjJHSsaW4vItCd0qBh/d3Ox2HNg3M2GMm+CBy2MOiyTnP1LdkHl2h80aDBajBP
 k1GnN2ykasVw1tlA8MS9FDFkAKTSAgAffz1tVu3TaQT5gNDgXCkLS4jR7kb/P0WTdedWHvRtQY8
 =
X-Google-Smtp-Source: AGHT+IFAPofSVrQzef23F/pZQIC1+Qm4n2Oo82Av3Z9pdhHTC1IfXERPJlzQHyQhOuXTio3/7/c18A==
X-Received: by 2002:a17:90b:5683:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-31615a78554mr227608a91.32.1750862963332; 
 Wed, 25 Jun 2025 07:49:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53a79edsm2055681a91.16.2025.06.25.07.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:49:22 -0700 (PDT)
Message-ID: <39c1beed-f5d9-4abd-8048-189177964e4e@linaro.org>
Date: Wed, 25 Jun 2025 07:49:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/27] tcg/optimize: Build and use zero, one and
 affected bits in fold_orc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


