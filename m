Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA8C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdZ5-0007N5-It; Fri, 07 Mar 2025 14:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdZ3-0007FJ-Oi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:40:57 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdZ1-0000mR-Dx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:40:57 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so12041315ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376454; x=1741981254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6VFaDs4qzI3gkG2O72UlJNWG5bFmLZ0X+mno15f01jA=;
 b=StgiN4xCqwLKmJVU2tpg9j+aZ9CAMErg1JbFmzZ5w+eSFovDFoT2VPmEytcLHzR3+f
 gh68JOpYtiDEJvDlOSLplcUWfJ6/4TcS9s66uxeF09af1wTqaCebanieOhrSO5GWb4eE
 ESu8JvZgX6opeGiNzDWYiTxtOMDBY1QRJdatOitZqPclSJa9RFLxp9t6Rw3Q4WLQEcmK
 wx5iL+0eyZ/bA6lWJ6KWDlpWTzmsP5PhwE/z38oZcJUipNJoCbr0/xBjMTWasbiS27E4
 JKjNqq8AeWV6sRlx/cMyYnnCajERIm5BjbqRrpFHYWXHtWQUBBjM4ydZ+AFOnjSTLj2Y
 FZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376454; x=1741981254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6VFaDs4qzI3gkG2O72UlJNWG5bFmLZ0X+mno15f01jA=;
 b=V7gi0KGE12FsxV30AcOoyIhwd7aZflwMuzJ478U4y3Pztmgxrr6lXqE+EbTs6XntZX
 7POpTde4GZ1fiR7CvxE93uA+Nf/Bvf+YGBPJGOrMcN67anBkRAZBvgb+SRC0etykN/ti
 r/umYo9k+2KjwnjaPOnoXOSsMPmOM3IYJcZEg6p7i6RdfTYOgKoTVgxqvY7SjSl1iSII
 /lm1J9mI6d37RlcPwcH9j0YRVsKtS50qD5bqzkhBujzNjEGNwc5X2lI654HcQ62Nzcdm
 sZAycTx4U9Tms0VnbZx9eKAYYOvXzNYI/8nyuJpCkipvkLMwej9n3PJW16cFGC1UyYyq
 yiTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVqTfn7v62xMjWY7Sqdcpc/07lzQZaNkICyL0Jg1JjQOTMDN72hxOa4soGbBER/hTzNwRFtbJ1zDMg@nongnu.org
X-Gm-Message-State: AOJu0YxwGhJTFLB8L5wgW6kIJMadVFYERQtxlddk9KSmCiLa+LFIAAb+
 iYiLGoUJvcoQvMoJaUbtNNGlT4dv6WwAfhdwnh2QJZC9/mp44OkZaIPsE7qPrpk=
X-Gm-Gg: ASbGnctvzs4LXf0VzM3brW4x4lfrat3kZCVWLh7QZJUuX1CJDGCAFR+QaVPvGBAGkeb
 OrR/yumPa4B2kCiowfE3j1t6pvGGOZ5bcOFUdRBkXbPpoGRcMwrIjfEonyhh0NyJWvvDjTiS7vF
 L608gQBGFOUIQBJraBap3EbSvna3y4Iqq3JraQVQO1PZ7NUCg4QKX7n7i3u8F+hXSMsJXoa8piG
 6SYSc7728fig1763fk7krzZVsZ7kxQaGDO5sGyDnSu2OMkYJv9te5/eMEpL3jX7WbegU9RTKvhG
 A0oy++AxOZXtUwLMysDtSMyHerCThbGwWGhvF5nvelnv49bOspoOjqWNMoSa3toktDNda4tAWxk
 eOQyvMNgK
X-Google-Smtp-Source: AGHT+IFbR8uFzMVwZBHkamqsU3RZLu4obzPVZS8PVMt37/ZgRh8Ca6oNxgxIPPiq+/3AiJEmsw8qUA==
X-Received: by 2002:a17:902:f60c:b0:224:826:277f with SMTP id
 d9443c01a7336-22428c07319mr77647855ad.33.1741376454218; 
 Fri, 07 Mar 2025 11:40:54 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f949sm34024535ad.148.2025.03.07.11.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:40:53 -0800 (PST)
Message-ID: <dab2e5f4-eacf-4f42-99be-e5177f3d11c5@linaro.org>
Date: Fri, 7 Mar 2025 11:40:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hw/vfio: Compile more objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> These files depend on the VFIO symbol in their Kconfig
> definition. They don't rely on target specific definitions,
> move them to system_ss[] to build them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

