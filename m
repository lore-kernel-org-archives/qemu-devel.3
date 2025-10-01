Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D84DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3y9r-0003qb-E4; Wed, 01 Oct 2025 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3y9k-0003py-9o
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:50:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3y9V-0005Zu-1I
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:50:11 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso8990962b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759330186; x=1759934986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+w2wg5CuDrzzNw/ic6QXuFMzFatMH0oGrk/zWVujuBk=;
 b=P/8VxVodK+jfH8J+wkzUDpNm8vNXUf//e7GIri1QNhCLEWDFbY8UFnk5oRhxLOiSwX
 exY1+lqkSOiBI4jw2QP1tPsUThhhyGnznbTiicbbsePjEkUay4rYVZl6aRONBIwdVcjw
 fEG5/qk9i8Vzet5e0AQaib8Cz/h0opJyoU2ehJLSWj1qFCc+AXRsH+87QeFFIKoee9cy
 B5yJFOLDOtgXqCdHeZLjKJTQflfbyV5g1R+VbIbcT84y5evA0CbmEJ3TGhLRmanPXSYW
 EBYY2HAl5JNOYKXiv/puOImXEvJ0RQN97r19jS7U2b6OSlKaaBvQGPUzCoamruT9m3G8
 x/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759330186; x=1759934986;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+w2wg5CuDrzzNw/ic6QXuFMzFatMH0oGrk/zWVujuBk=;
 b=EK0RFC17nmAq9wO8K3LcCz6S5PwoaN0sg38u0FUYrEJ/EC/HHrR+mBjW+6N5KxyyuA
 cGZS23D3lVfPP0pvdLMPp2fPoAomYw7zvWfzN6At2Dd8raJkg9zGKVxt69yqfGRD0dUb
 JwBKgMCx1R3atnVz/E435dedtn97hBT8WGRuWrAxCLEub+f9/9DLZlO6uxBgqrw1urGK
 0/ewtbqQuoaU27krFPh+L0ZuXnJxkl/KBk3oMOaJ+o50TVHqugOv9Vs8uJW6YERq69AE
 cWjz9DEH1UnIXR42mtUwCsdHD0Sm7WUniO/qTfDg6u6ZoefFp6SoV7iRnQgwYGrQ4KuP
 Wpvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsHcgR4OSquntD/1oD/34+ha050myj9wy3Znq6JIDZakShzWqRMBO/zPORdMmcoTCdOsV36A08NFvg@nongnu.org
X-Gm-Message-State: AOJu0YwYqQ03xfuIyQNT3rud7O3W61Cc967cB1Yvg6ut/3bSNEFckN19
 Zv+zWukyTK9mhPzO3InookJdQyJh1XAF0u9UTlFqa4v0rjKPOSGSSHl4Rl8G3RyQU3Q=
X-Gm-Gg: ASbGncv6Xeuz/VrXElhIrZvIdqRjwy1HH2WR6MwsQ30VydTOrPuGFlMwrQos8k1i3Qk
 F/5zu7DMD05tWuBoLMr/ixUoKhPdBeqzZ2jIG/mSRUpZIqBhs4OoBqyO2FqICjHEP0qhPTOUbO/
 Wqs8WKyQ7SiWcTQwacEijpG5rAJ2cJPa8abmD9ABGgHBF8kKIAsZn9sUNkg/ZmzhIDQmS+s2JcA
 dEOx98j0TIGXyIwRBE2uPVPMhSNUxIQ64mPHbjnoS6U4HmfYTJRAHYD5nNMx/NmLg1T3wJY+a6s
 evzu3SQds+ZU/iM4JV6OnBVCsGCA1ZukC2iuZPkugx3yME5NQwjn0HMsduw1guGS75nTjuWv+vl
 n1D93fqKgVM36kVxSSla6Sge18zFpPhBJhKHw0XkAdN2Kg5KDkyt1w3yJ0WHB9YfmedDC1aDV7F
 ULVPR2uwGy49V4+vY+5yWFfaLm/l3dPtU=
X-Google-Smtp-Source: AGHT+IHcmD0xQsc/wxrGWBN1ANPdZ3erm2Q1K1R4yon5SEPg7HmcLpHQk3nJk8BJS/XmRBnduaNLdA==
X-Received: by 2002:a05:6a00:14cf:b0:781:19fc:abf with SMTP id
 d2e1a72fcca58-78af41ef502mr4651718b3a.21.1759330186533; 
 Wed, 01 Oct 2025 07:49:46 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238b19dsm16543634b3a.10.2025.10.01.07.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:49:45 -0700 (PDT)
Message-ID: <3479f480-da67-41a1-85fd-c1d281575694@linaro.org>
Date: Wed, 1 Oct 2025 07:49:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/25] hw/s390x/s390-stattrib: Include missing
 'exec/target_page.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> The "exec/target_page.h" header is indirectly pulled from
> "system/ram_addr.h". Include it explicitly, in order to
> avoid unrelated issues when refactoring "system/ram_addr.h":
> 
>    hw/s390x/s390-stattrib-kvm.c: In function ‘kvm_s390_stattrib_set_stattr’:
>    hw/s390x/s390-stattrib-kvm.c:89:57: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
>       89 |     unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
>          |                                                         ^~~~~~~~~~~~~~~~
>          |                                                         TARGET_PAGE_BITS
> 
> Since "system/ram_addr.h" is actually not needed, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-stattrib-kvm.c | 2 +-
>   hw/s390x/s390-stattrib.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

