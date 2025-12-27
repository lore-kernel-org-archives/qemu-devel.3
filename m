Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C689BE92715
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWPo-0001OW-FU; Sat, 27 Dec 2025 10:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWPm-0001HX-1w
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:41:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWPk-0003kg-7r
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:41:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47755de027eso47119555e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850067; x=1767454867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1+ztlfd9wrwmAsNc2ze/59DQCS8/8L7BHQYzP5XHBNQ=;
 b=Oa6DgGTNlkODnGmSYEwZSX8wD7F+9VL+0DvVNDs8XWBcPrpi4MlUjzTiTsgOdWjJ3y
 dlI7LWXOfN1wFAbIEb1vBZan7N8hS6v4nOJL4gvSFU/GWUFWVYPD+3X4a+mIN82luZe2
 mkBq6mFCstP63a1gmNHERhuD4oYtGhkpH3I/Q4rInuIr8HQR9O8EXHbh9v0UnK8AzZNp
 d3kIg18FvggX3HQJt8mgybA30vipMXu4zCtf6nux3WzTeSFUYBy1CavC8EU1IPJGDdTo
 jnIzDLbUJaw+HeeodWVUjA8yWcL18VK6kEountflc73FFLfQiq9YB0hr0oZAUM3tNPjD
 +l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850067; x=1767454867;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+ztlfd9wrwmAsNc2ze/59DQCS8/8L7BHQYzP5XHBNQ=;
 b=cqao9i0A6taqzT/644BNRwcRsV/AwmL7CR1hz1mtD6cfKhgMi2y5VxRv4cEZbXpm6X
 1+fkt4zKi+4l8Tc+djF1ATu3R3vtcD2ed7n87mZzRa8zaSRxdBj7fZPBxBQkSHlnVnc4
 umAFpV/y3u1jOYAb+3dW1a288i9LyZDHLVECZoybjcTS90UfYJPKfCdebuY9WQD6QBxk
 9W+LA+RpkEeE67KbIQCLqb7KlRlzC7y2quGsVSFzsPXoMSZOA4Cy1tubswZ/NOeQEDmv
 z8cdErwcfqI6podMaGiI0SbfOcNdr4EshFtHIRetNleLn86nUNLHGrtxCOFH/R0wmpGn
 A8OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/FH5lzhBNXj46+lpWfwsQ/mb0et+5K4TpS3uKfsm8U/2Hsduaylj6gA8qDSfmLOazfaAI1kMtWlR@nongnu.org
X-Gm-Message-State: AOJu0YyegEtDKUS2tGPpeX+/Am4UdG59RA326+A04OKf3uQ10prOVA1n
 AZUyjh+hbpfn8RMJxtKfshCxQaoxsQOpkeLspVzOtUTWVemupw0Jc3cdh0GM/Qa77HRW+BVhbM0
 Q/r81
X-Gm-Gg: AY/fxX5SQm2mhPNxi8RKJkC1Zj25C4f5BZtpJp4ai8c3MhBehknNotx2HUAZt+Aqg+5
 COsOskL8o4O4tTm8noBC+RK8XhOivxU5SBygYl93A6f0OEQCqA1bCP9QXgJkBT7nIkjmng3Hv0M
 +5kCPOFv21ZdqGkg5fmmzMwUs2JaILECzgwBE/4SbmnXZmb/4/NYIfUfdg2f3Uegw6aD+smU7V7
 sZ6xhZjADRkTyd+MvehSzZ9SVDT9E0xQfeIQ2Bv2dVTjYX/EK/dGpqOWIDg/qSXmrO6fij4QXyE
 VekPCMldyfwNZE9x/JCe/W2dK/S717EsY579OTgMemV5Eia9PdL2UvePMxbN/Tw6tdVKkyyg/ZK
 VvO+oogt0hETDdDQ2rZevktxef+zzrdGiOzroGv/26HEP60wFU3klh/y/EJUxH38HebemPaJywk
 kq35wB2aZc1JELFAVcq/9IPBv/3YJyt3ZmjGHEncspWa5Kh+FQS1zudObRv6HKcA==
X-Google-Smtp-Source: AGHT+IFSnNHzK8jErOeGSNV3lqs5E+yWRKFE0o57egwAqy143zLYvJDjRqYZ1hTSrj22lHJDNYMWZA==
X-Received: by 2002:a05:600c:4447:b0:47a:9560:ec22 with SMTP id
 5b1f17b1804b1-47d1954a2fdmr261090545e9.14.1766850066649; 
 Sat, 27 Dec 2025 07:41:06 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm447297765e9.9.2025.12.27.07.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:41:06 -0800 (PST)
Message-ID: <3395dd2c-0599-461b-8c44-f83850721c98@linaro.org>
Date: Sat, 27 Dec 2025 16:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 004/153] include: move memory_ldst* to include/system
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227091622.20725-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/12/25 10:13, Paolo Bonzini wrote:
> These partial headers are only included via system/memory.h, so keep them in
> the same directory.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/system/memory.h                           | 14 +++++++-------
>   include/{exec => system}/memory_ldst.h.inc        |  0
>   include/{exec => system}/memory_ldst_cached.h.inc |  0
>   include/{exec => system}/memory_ldst_phys.h.inc   |  0
>   4 files changed, 7 insertions(+), 7 deletions(-)
>   rename include/{exec => system}/memory_ldst.h.inc (100%)
>   rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
>   rename include/{exec => system}/memory_ldst_phys.h.inc (100%)

Similar to
https://lore.kernel.org/qemu-devel/20251219161953.72724-7-philmd@linaro.org/
which also update MAINTAINERS accordingly.

