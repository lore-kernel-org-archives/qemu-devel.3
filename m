Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC40CC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8bO-0003Y4-NZ; Sat, 21 Jun 2025 20:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8bF-0003S9-1A
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:30:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8bC-000532-W0
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:30:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2353a2bc210so25859755ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552217; x=1751157017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w2vzrxt5VYm8fK7ua4D1nCO2F6HYolS2VxUlTuJthtQ=;
 b=h9i1vspfqi/XrgT8Ox/80oT7ybI1RI1OLqMOtLD82BhoPk8VPRl+BV6UlBI2zcHcmD
 KjpA41/sSAs3WeabAt549eCwRD7ts8SuyEeikFHljsoIX/zamtGPNdo84CA8vjVPtAaE
 4e/ZY7Lxj3ilE/ey+B316lbRHflkzb7CdL7xv+DL/Kz3TaEYglRtAH+R8WNHAT2enpAA
 3gTpElte1OnqrOBDDnMDk5ztGTq2j7fY3FqCuyWOSLjlIOmBIqlbojlI3C8B9DYo8j3z
 LrQk1rziLCAgA9TpWBEaFrZmz/2MlKJzR5vCNk1P+Wyo7oxrldOVAXwmRDVEj29fdmss
 zweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552217; x=1751157017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2vzrxt5VYm8fK7ua4D1nCO2F6HYolS2VxUlTuJthtQ=;
 b=hXbYd+cBDA1Rk+bfBL10xYsjS6tXnMCUhmVbUTMDAHGiyvHq0X/5OuNW9Xkz04DmC8
 N+7Hkj7HcI9QlsJkn16I/hMcUPwewSNTGxh+VIlO16B1eAsjeG/fC6qbnN9AqdEiRTjX
 u7IcA0B5DY0nu+bpqMeDjxkYhTu1cDjXuprErKpyNIk7ByAdFawlMxG5iUh728YlcBXb
 u30qNRF3g4yXEdSSW9vbbabKVmKBy9qjHGEHFPyn8Ov80E68gw1iDMxrxnKgu1YL130P
 rn12xtVhqkDmk5w8diRXNVpbJrihQcRKOeMQmtonU/v7Yd/SkPHDuaWQtMOapaBgAO08
 fIWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuGHn/4TcF9/HTbpizItDx1wunIckaj70VSM4iCi7ceuuSzo8X8lb7xd5h7aPT/aP9CmA0oDL06IfF@nongnu.org
X-Gm-Message-State: AOJu0YzI6rXR+6PFiArli0WpAGM2zLySWB6oLxIH/MsqYseU1zop8C2w
 0aYSbPXyHqHg3P25CiuvnjaxpA0ii/tiK4/pOda8tXRQnvEb/Dyn7KE5i1XNuqEzbeI=
X-Gm-Gg: ASbGncvocHprmAxrFy4we2YrLVHHUyl6yNN4jx254WQqB/XegcVZMOf6ufGROa+jRst
 BLIk5+ZwHjYzfj6APSD821wloH7e39DNcnkmZMg2mmvmgAdJLxH7t343q1prOHHUs8q3TJwnSEK
 p+fJzDcP0NIoTpHa0JhmBgRFGGB+aWULmDiWg4JMfFmLzd6L0IjCw1a4vCQg8dSWBl7asII2Vk5
 Xb8WZf6fuzRiVLL887+kurKG9WPiaOyGauHPO0kaVpt0N18S34qwnTynL83AUhtg49JWRgYibcs
 iqbw9p0uzQfAyiYQGhvKVOHWP2XZLUq8aaU8QpSC1tKRM+UmzgmPyJKP7yflLE/Ii2ObkiN1Tgq
 AeLC7L9GVBScoQRSXnqCaHPUcYV3V
X-Google-Smtp-Source: AGHT+IFIR7vnR91hWeTU40NzWMyn3ZhJuyxrTQ0v8KLEdI5pFY4iCGZqvQ4orXkDRxkUOPew0zj6ag==
X-Received: by 2002:a17:903:3bd0:b0:234:aa9a:9e0f with SMTP id
 d9443c01a7336-237d9872225mr119604715ad.23.1750552217594; 
 Sat, 21 Jun 2025 17:30:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393535sm49937005ad.8.2025.06.21.17.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:30:17 -0700 (PDT)
Message-ID: <5d0cdd5d-bdef-49b0-932c-e5748d114a60@linaro.org>
Date: Sat, 21 Jun 2025 17:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/26] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-22-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> QDev uses _post_init() during instance creation, before being
> realized. Since here both vCPUs and GIC are REALIZED, rename
> as virt_post_cpus_gic_realized() for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

