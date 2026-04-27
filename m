Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EDBFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSbz-0004qk-KU; Mon, 27 Apr 2026 16:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSbW-0004iX-Pg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:30:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSbT-0002Ye-TL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:30:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6244224f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777321850; x=1777926650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wQexbKPFckdZQVJZzWkr6sHDQQV3+9kWN2kMdbtTtT0=;
 b=tLkU0h10LAjksBK1/Yc/DwCg2DXbCiPIpq61aHlJ9deIbQz/832do+Ayqaqcku1xh8
 8bk8JFwzKzvrt0HL+xqQljx66XPoTRjp0I6pTiNtgyHM5sRTV0HESLQogw+MX0BpAGDQ
 qK34s2dA/j8YbsuCpqvXdqidHf38s0p3cUrhAyVTrlZoU8KaomspzZJkqVOD0QvwKLph
 NuGv061dSo7uMY585+cExAQMBnXEWYMfyRqKL7waBguaIl+8mpaSy3iLbRLs36Agk53h
 E/SEMZ64dZ+YKSJ7uZXH3j3yE1t0Gabdqy29XpSFI2WCy3RxQhJYiTQWoPKvb322mG8A
 aeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321850; x=1777926650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wQexbKPFckdZQVJZzWkr6sHDQQV3+9kWN2kMdbtTtT0=;
 b=GYfF7z2CmYsiCgArlFQxvMwOhGUTmerrnLCPLG1ECtAkC73EJej3nJM0dkG0gdhHg1
 eCnwtT/7ZLHn0H7cyXnzveVq+UQfYMZSz/TmGCCvqVZA9oR0M9XiWSvEyTVCfveaaqfz
 pD90mmIvr2/HYNJ5cfSEPKhjF9tJtGXib8lDbSd3Ueb3xcqe5y+GfCk5ZTNB+nhzP+Ms
 WqPs+7/DNuD/S6RmV0+sFQH8emE+iG5SyFY8s45YqUMCUI8sPVVVfTa2UBNpHFVlgegu
 bpAV5LchlCBnzYwnjHg//DXF51M9NaDFkH0OrirtukhErg7p7IA3oAOWjbXYJHBbwewo
 nLLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vAb+y1RiCna/137aFMnLCOdtXa5KyvxyBjgMI/O3sTeNeGPe8zImAIDbncdc/xb5sd+zWkXDyyW07@nongnu.org
X-Gm-Message-State: AOJu0YwxMHxro4skZ9clnwUdReSiaTOVDpFHc6Tqg7mdtDVa5EvPXQBf
 /TKwzgLw34b6BP5dk9X6sztjZIOQWRGynvz5qSaqffw/TUl2+vCj3N4Sj65T8JfZnFA=
X-Gm-Gg: AeBDiesdwmBaRqOA4DTx9cLg3h7L04DyWIIMzLNCprEt7jykc88KDGwWwnyDyncWgjQ
 WvFHGSKWBZl7z/mWKtgMmtyPiCxghQrC1+iQZRk4ggALoRuZzgp6XbYfH3Z7w8Wje1FK097WNcc
 OGRzIX1Sp/QL1o61xW1ddJpjnpG49K50oaJMMgT06NvchVyrLw5SVylExYiRSXJf8pETv9a58nZ
 LWYp/3FPqD7/jFBT1GPB5/hwqipkY/M6x30CofbKM56QOnsTxVfoiL27ESeJz7Smiv8Lbkti6uX
 fZzMI4THswsoUc77IuVcaAc44ya73EiluC4BbbUu2OlZ9/uqkLmiCuu9a5rXdsshaBMuvjv110I
 QIeuWsdTCDMUwSaExzQj8m0MY78syG1sjDENvFQPwXFGqW4dyhPQdvcLj14UWzrSOiYd+LnfVUH
 HYDxvbqhHgcLfhSJYpbaHbi4TzM+f4la9z5vJPPsLjT6WYhhP/6hj/CB6N+Fu0Ulgw57IaO6dCM
 Jx3jJ8bPr4Em6A=
X-Received: by 2002:a05:6000:2287:b0:43f:dc86:d61f with SMTP id
 ffacd0b85a97d-44647cda901mr556796f8f.14.1777321850066; 
 Mon, 27 Apr 2026 13:30:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4464004edc8sm782377f8f.37.2026.04.27.13.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:30:49 -0700 (PDT)
Message-ID: <a5c34e11-6d02-4aa8-b7e0-29d52633f63e@linaro.org>
Date: Mon, 27 Apr 2026 22:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/84] fpu: Drop PARTS_GENERIC_64_128{_256}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> These macros are no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

