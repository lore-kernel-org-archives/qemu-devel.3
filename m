Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FACC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts54b-0008G3-QV; Tue, 11 Mar 2025 15:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts54J-0008ED-AU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:15:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts54G-0001p9-P4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:15:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223594b3c6dso106894345ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741720507; x=1742325307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YN/8lG0SEdZ4AtZ6RFFvdgybf2D4yUrtKFWLW/13bds=;
 b=CXC+ztFK9oYrbpWtWS3skzq9v4QQ1vxdf0EE1xCVPH3sLBrqyO3B5Eid4ug+zuEToX
 ffEUxnZBmmG9CmKyVk/R/YqyyjhdF6PB/2wPM1o7ejWLmqW00hVzS53URBDE0QpUWJ7D
 tntlKJ5s5Nlh/lm4rI/bGSm6IVhVlLMDfGurJc+XMVYaB6NEeiMlrtm7mm3j303/h5Ir
 3Nxa/oxmhngjL+dY8E92NhY6F5NWsflBDmvhjKIOhm7sVcc0lM1BTIi2FyKIUM3RHyyg
 RGYS6huCQFTyWAIvfVsXLDmopXm+khZPcj5rhtP9CZ9Nzdncn4ONNZEoGNKltlKjuJbV
 0E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741720507; x=1742325307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YN/8lG0SEdZ4AtZ6RFFvdgybf2D4yUrtKFWLW/13bds=;
 b=mNSlc5exQFv7cONGQxQ4DxzowoQQVUOP6vcIz0Zh1zAnX4RIMF6YwhjhaknUPR1pfG
 5Iq5SUe6pRTgY7t0YIlygUjVTfi2tIOrJvvgo5nnuKhxYhO7IhxIpmeY87oyhKMPv5I/
 yXlcsAETXwIIRHQpjBvVphEG7xbGuXZtsG4sniVRsRvyfduQE16Ldi6JZXVT74ZY/wdi
 +/0Cr942kpEGqJk7OmNl4++CEWcahCLmTy4fdPKmkTD4cfz/G/CZrXrrau+rLLaV79jU
 A5VB9S1eQUA3vk2yB6rpk1bOJYFW0D/vca1AYXMEz6fJ9Uv3eJdO7rRC6IHZJZ2cmcId
 1ApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOnutdT3cmD6kAA5Wo5NjQyziVp2meI+KBCncezd9WKtumP4SmnASH8DoWxsnGf+W8DJmH62ow/TuT@nongnu.org
X-Gm-Message-State: AOJu0YxvJ/JUeJ2jcQNFQoafoKUs9jWyhGWeECf39rcFkakat7mnNCIm
 9vgh9n4XyGm7L6p5VqxI6+7INJrV/vYxREWF3GvJ1xFcxDOGEaae/ZEIfqhCAZo=
X-Gm-Gg: ASbGncv8XNq23AVMG8SCrRaVZjBHrCPVo3rxxuklIjuLZk/nCuYxWtorqfEL6v5swSR
 jmMsCluzBWoBQrOJivX8TzRvqXwWBgiW9c6xz+kSj+0Q+nCSnHqFnINycfqZW4PV6xhrqW6EHTG
 lWoYNiv3JNuTf03cZBJE2Om39t1jpcnXqDh7XOTYo7CJKprVjsnCm9dxkT/RP2KpJycm6X7RImr
 +Q02xfxTsUZvSvpeAQNdcfVUYUjI3bpQW0Mfb18P8/4ONpZTtaHbaDzgzgtmLz+KvWVpr8+bKdQ
 naja9SdvH0wPcdxMT3GqaOXL3L+ZPnIMrIFPl4fSZTD9INPBvvNAbawrr0OgIueyrz+K90iq/ws
 kvVYu60Pc
X-Google-Smtp-Source: AGHT+IEtUkpMrd90Yi9cnR0Lt3Y83zYllQs9zT39aV53eCtZm39rNhSTh3k6HgcHiAVYPMp8a35yIg==
X-Received: by 2002:a05:6a00:4f83:b0:732:5276:4ac9 with SMTP id
 d2e1a72fcca58-736aa9e6750mr22171990b3a.9.1741720506808; 
 Tue, 11 Mar 2025 12:15:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698243ef6sm11153995b3a.61.2025.03.11.12.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:15:06 -0700 (PDT)
Message-ID: <344b0bb6-4beb-461f-af23-58d3a1b628ec@linaro.org>
Date: Tue, 11 Mar 2025 12:15:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] exec/memory_ldst: extract memory_ldst
 declarations from cpu-all.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> They are now accessible through exec/memory.h instead, and we make sure
> all variants are available for common or target dependent code.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h         | 12 ------------
>   include/exec/memory_ldst.h.inc |  4 ----
>   2 files changed, 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

