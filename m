Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A41C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubR87-0000QG-LK; Mon, 14 Jul 2025 17:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPT8-0000ou-PC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:08:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPT7-0006WR-1y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:08:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso2957051f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752523687; x=1753128487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ERVhG4+19VK8uLTMl2gB0Pc+pWnwUVPvUP3CACLwt0=;
 b=F8dp9Plr46fyYX0V+s2ZgvmZJQJWAsaFU0IH3zf0oYoGhP7D+i+GPXTk1AmMtdLAIw
 SL72LknVNJoZHunOrdU7LH99wq6S0eroY1XEssl3q/0hQ9ZO8LeDsGFxoE9HCxPdenmP
 mdZO7m9Xo/35pbTz5+pPB4zrtdfjbpnUlaQ7+M4csblP1dzRkGKvteh/IwKTNKacQw2H
 eLGYrrbbhRq9DGnOeK4q4VX1lyQU+v5L1VGTV4MDDCz9D+S5e9ORx9/86Oza+PtChY72
 PKSt9dS60aOKZQYNUBRkOk/6N9eS9cuu371jVJOX7u9CH9sRMzLo3qRu/WNkvA0ZZSQc
 tmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752523687; x=1753128487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ERVhG4+19VK8uLTMl2gB0Pc+pWnwUVPvUP3CACLwt0=;
 b=GeNmgWBmHbU0uSjUUqApp4J6wDaE5yVlPwzfU4tA0ZMl1hrZ7FkGd9ODQWOfRutDrr
 /XYm+eTfrEtGk8ANsELELdz8PSIG02Q7Cfi0chRxraGGLLWs7wm++sqfirxdGmczOCY7
 8JHPjhs7af5ZuXgmREBE5mwpPAbeQtkIj6aV2lv83xfS4osZRpWYQFZAjXXe9qE9ByBn
 Cbw+QghZXL1VvYk3ms4hF5kJW23/qRmnN8B6Oi87gBjyy/+ppGsR62c17uHw5ZBWdc8r
 7Q7DDsq4Y0FKPNeoAgIAj40tYBcwjELBCTO1ha3pKMiOycQqwCRIP/VTjKfr7wwUudjo
 GSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6BSpAU75xh5Q0ZErlIkon9qC55aiq2g3CJ0xrF8pANxJC9KBolLs/Oc5iUjvRRgiWiTsuuVUGlrDN@nongnu.org
X-Gm-Message-State: AOJu0YybL/bV/BES1pcVyM4Abwr/7MaaJrKXu7CTUkjKgB388zmxAnaI
 4hF7zFEnN1jjdFWjPO+3HKkJVGAjSI6kA96gKgNkTohhd6ZwsVgBNKzf6o2V41oz0Ya681NP1tL
 q9Fpa
X-Gm-Gg: ASbGncsK+krF8jcMBPcWZ6J64nZIXfyi515P7Hj1k7Aj/IQoIsHONsxyK8V2/6jt94U
 9b//EuQjc6MJN9Lk8IVApIddxKGtkxXn+kpHkgr/q3X+fFvxwByZJ6bOvsI+d38w5gtDgq2Lim5
 4/bxbzQrHJDes98QOcBAVeFYfCVQzkjRjynvDtKMzxpDdPjjoLaumIuVHWaAcbeNwQtrGCLbpEC
 roP5aCnAwV/uI2e/JWCAqfK3i2ZVFwtqFz/oPeUf/MTCrDelOXxx6gElz5MZTFC20Bsw7edFExo
 mK7kp7/JKN7RgP6cWrh02I8c/Z5c4oBN7UOgiV8pifzOt9o2pzqkmI/wBjGoMceYII6/XwI3DLT
 Jmbm4RR8IX1y4FoJAf/28qotHsUta6/zf4vgPCsl1PMBQK0Tt0Tu6FdCv2yaXJgQNJnOXW5CbnO
 S6
X-Google-Smtp-Source: AGHT+IHSlmOHR4/fgg/BkNfrqBUBdulpUUL5qzN3x6n5EZLyd0qDCF831ReBetRBd4pwDpRqxF03GQ==
X-Received: by 2002:a05:6000:4819:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3b5f18debb9mr12957796f8f.56.1752523687147; 
 Mon, 14 Jul 2025 13:08:07 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd241210sm142789715e9.0.2025.07.14.13.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 13:08:06 -0700 (PDT)
Message-ID: <3138a372-7649-404a-8e8e-53b097c33094@linaro.org>
Date: Mon, 14 Jul 2025 22:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/net/npcm_gmac.c: Correct test for when to
 reallocate packet buffer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
References: <20250714165523.1956235-1-peter.maydell@linaro.org>
 <20250714165523.1956235-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250714165523.1956235-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 14/7/25 18:55, Peter Maydell wrote:
> In gmac_try_send_next_packet() we have code that does "if this block
> of data won't fit in the buffer, reallocate it".  However, the
> condition it uses is
>    if ((prev_buf_size + tx_buf_len) > sizeof(buf))
> where buf is a uint8_t *.
> 
> This means that sizeof(buf) is always 8 bytes, and the condition will
> almost always be true, so we will reallocate the buffer more often
> than we need to.
> 
> Correct the condition to test against tx_buffer_size, which is
> where we track how big the allocated buffer is.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/npcm_gmac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


