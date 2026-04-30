Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191ACD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILKH-0003BA-VE; Thu, 30 Apr 2026 02:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wILKC-0003Af-9J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:56:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wILKA-0004kH-QI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:56:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so4561885e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777532197; x=1778136997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRwYHzx+YRSTdYK8LWGEjBu6KUTxkWOmqQ5WAGfz5QM=;
 b=fIAAWDz3rA8wxSd7EHuy9cfAZLmO/bQaug/bj50TJCz5egRsmIDKaooTggqxUtrkyR
 AWV8td6F299UvAeIWSPTXYyKFDkbOmPpZ+BE3AW1aFAFodFwwxqM8yx76NPjRla0gNTa
 Nq1PfEMKLBY2wH7lFDcAut1h9sEe7N+QIInc868hToLMmDRjnn/mcII6LQyVN0z9dpuZ
 90g88vgnWGQyiXZ18WJI7o/mqjK/JiXU4NDdfev9LPTAnpSuNBu69U/Z6yBMzgKdHfY4
 FGr+VviFeYqxTp5XL9rS92sFvFEL6N29fKIGelo1qAi6cVfKzO2/YKlPSnBAzQXXzFJD
 bxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777532197; x=1778136997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRwYHzx+YRSTdYK8LWGEjBu6KUTxkWOmqQ5WAGfz5QM=;
 b=Kwrouz9V4WnyOSOu7tUGqiTWQGwOaV689E1rCBBVLr+iUkl8MjANMl9C7xuiljmyua
 hCVaKB46mtfvtSO5szghIV/gQi9X29PdBOEF8kPnirRDLaBIH2VILBzbRXWTpiIkPwVH
 FZApfME07NDUoi6clpVRFrP1eRdNHsVM8pDPOu3F3uyGl8VMFq1BDPC8iq6pE6JUnEvR
 pJQLkMZDyQYwL07yGxS3DpuhxKWGZXLli1zPNaovOwG4ruGjZmyklVuc/h4MMNMDf6Zb
 6fUjXFAE9CqkhFnypoHgQmqseIf71VafFzQcRRioJOvKOLOzpdU2+D8CdPv95gbAyu2V
 pg3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WgVKdbKBtz6MskiGPohHrvAeYl8cbMQi+1T9lOUk+kUB55pvwLQ/oB76L7ZWrCzijMtjed1zUlFJ4@nongnu.org
X-Gm-Message-State: AOJu0YxVTp1NxdR6FQHthDo8Fy+dweXbql/N1/9C1NENJRIoY8Z3G5yq
 laQw2fRyVhwfaZVZyAPFL8iiHXpEBi08+Z9WC2KAkXEoUB58d0N00WJjBc4/hTPNiUA=
X-Gm-Gg: AeBDiet4G6PFrW3wBbNfcAVUoOX5FuU9pzrS20AhJ+cOjuB31sVAASBKgA167PGzfH7
 Jprbxn6X5qRM64QFvD+ggHnnh15hbXvrqqMVuniEzR5ZWLWV4zGfky+ihNb8B11mscKI0g7Jjqy
 9cpWdeU78SRSrHvCrPngHCKmTCbm55NLoysZwxzd5J6EvAHwGDKyJxkzGXNM+/68mZTqDy6lENw
 20GDJedyLTNvWsy8WIvNMImYi0iGEVIgG3amMlskcYj2xB/2VtHxhPHmrRMfrjMWRCZE34zdS9I
 fC6cj+r1ZtfBdaR0B7B1EefewyAE5Z5afEMerXJewCvdWMK1TDvalYScfRCaZHNLhIJZth5PkL/
 moTPpXF/Hvyx1J/fTvbyI8DuYJqxT3aEFmZMUr9Oa/JHJlowXXNv8D821EgkdLskMhWd1VhSu3m
 JuAaiwPzemab81DNG8XSDb+SkDQcM1UItScDgYrHX5llfEV8JpW6lWOvVvY7Z062E/qeR6ubGgg
 Jtm
X-Received: by 2002:a05:600c:628b:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48a84452792mr30292285e9.16.1777532196995; 
 Wed, 29 Apr 2026 23:56:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b57sm123924685e9.15.2026.04.29.23.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 23:56:36 -0700 (PDT)
Message-ID: <3badbe1e-98d8-4ba6-ad2c-bbf4a24afc0b@linaro.org>
Date: Thu, 30 Apr 2026 08:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/or1k: fix arithmetic edge cases
Content-Language: en-US
To: joel@airwebreathe.org.uk, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Joel Holdsworth <jholdsworth@nvidia.com>
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/4/26 19:03, joel@airwebreathe.org.uk wrote:
> From: Joel Holdsworth <jholdsworth@nvidia.com>
> 
> This series fixes two bugs in the OpenRISC TCG translation:
> 
>   1. gen_div: INT_MIN / -1 causes undefined behavior (hardware exception
>      on x86/ARM hosts)
>   2. gen_mulu: uses signed multiply instead of unsigned, producing
>      incorrect carry flags
> 
> Note: these patches are AI-generated submissions.

Someone (you?) should complete that with an AI-generated review.

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> 
> Joel Holdsworth (2):
>    target/or1k: fix gen_mulu using signed multiply for unsigned operation
>    target/or1k: fix gen_div INT_MIN / -1 undefined behavior
> 
>   target/or1k/translate.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 


