Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB12E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1hS-0007r8-PM; Sun, 28 Dec 2025 20:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1hI-0007qe-Tl
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:05:24 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1hG-0008IV-Jl
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:05:20 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so7013778a91.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970317; x=1767575117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krspu5Ta32VEquDexhjjvIZdCRtt8WXCpn1T/BESWAk=;
 b=ZvGAjHWXKCRCcv0bhPEDc6ARuGdplIEfGGhLhg9g89YRBdjDjBXv5ZmZnJ93ACIMa+
 7/1rI8Ff9CBqlAupvlgOP+veW6dLLa/Pj6aXMQHKLdOHm8BZvTi2HmBnlhMcPkFEDs78
 k6NV4eLf7wpV5H0AH8p23VLQAZHv2zuGl4v+0RxDBlaxMa7spJfXPUcwiTZAss5RD0db
 CX2/fZ0SbhcHZOCmgRjxrEWJfkK9E4pX5t1kPIIWq/HIJs3iRP0XPM/ep0WmC5RLOe08
 tIw7DSUfiow6KLPD0LcqByjMZqaHPOKjF5zNW2t6/KN2RKUYps7tgOYwQpuj1ecfPRfd
 dDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970317; x=1767575117;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krspu5Ta32VEquDexhjjvIZdCRtt8WXCpn1T/BESWAk=;
 b=M0eO0LMM2Y7rYcljjbVXWsCUykJUvodJsCV41aliCXJxcHdNPktszm/cbHGjNTCRoJ
 MN/0tLDR83/BUt7600wcQEUj9q5b17VGrkaFdLxNl8DqKhprWzgBz+7uUARAX9O3152d
 2JzaRj8pFn5EBqoy8ZrScxTkc3h0GPHt/MKKbam4oltw9+xO6bVOTQnrYYaV+NzRguOS
 o0bZekr1dGwHqCq1idrf0/fXK5QmpKzTOSuZsTa/YEYWZnR+O4Wls53hgTC8U550YpRz
 GyABCR3zxLoh0z1WrqfzTEC7/TekAPJNseLLNLYb+KnMnpw7jxu+adkObSiG4stUcNGF
 o+tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs+XGvHUSO50pAfBA3yo2fd/d9PVKK+l7uWd4gEEXjpQGwg+J0+d22B1D2nwxiKdpZtWgf7+QuPMZT@nongnu.org
X-Gm-Message-State: AOJu0YxoYwqrMpwBBuYIs3qOXUqxOevgS0R5yX6mhoLTWzS+Qkma5wrc
 3vKZIOfJqy//nF2hotl4LB1D6B5fe6ocmplAeo/y4DuliRWWD34oYiBFS0+OzmYhpSo=
X-Gm-Gg: AY/fxX7PKZNmvAMCLLe4Vw5civbSkKK0gHTDrGhlDyuNgs1WxCqUC0ttnVG+3WWkm5t
 uIyu8W5h2HkpSZDoBKotCJjpUH1KGoOBNQuVlEQHBiohCw/j11QatBbbYYas5sxUtGdWM3wS1XS
 BGfg67SGcrDfCX2PHvVDJH/swLX8xN8HGjwiqUZXEidH27ANo/j6sfCtC2DcOAaPczteBb/YOki
 PuLTV8egmOZDObQ2ZuHVq7XH8VF0fC4LLjxmyUnExJOfys0ONLZ8ZklIey91K4fwzzyqSZAslA0
 Dgmdn83xmmXPZkdxufu6voRdb/aftRdM4ot+0i1oYPk+BY9iMZA5kCW2lSjHCGLoYCFbJsO4dFw
 ZGfEsC9IEFxNRPG5y7Iwke8mlQlLt/5xdNKng1jtbcaIuDtzy1xTC1KgbWn52EBfeN3O5GE5SC4
 gk05kGId39mslEANFcwJfSHmoUtsK/dtPsCFdCbcd0RA5N0NE9+3hIV5ZFNW3R9fHv8UwX3g==
X-Google-Smtp-Source: AGHT+IGZsKv3knuZQ/KyvSsJGBFeuZ3HqpGkko7mEQ+1sBHioD1SahPbJlPHWYtTV+BaN8Z9Q6+iSQ==
X-Received: by 2002:a17:90b:1346:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-34e921353c3mr27796768a91.16.1766970317082; 
 Sun, 28 Dec 2025 17:05:17 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e9223adf5sm25705118a91.14.2025.12.28.17.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:05:16 -0800 (PST)
Message-ID: <9fe352be-6d51-4821-a2f5-f0d927af5222@linaro.org>
Date: Mon, 29 Dec 2025 12:05:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/25] system: Allow restricting legacy
 address_space_ldst() native-endian API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory_cached.h   | 2 ++
>   include/system/memory_ldst.h.inc | 2 ++
>   system/memory_ldst.c.inc         | 2 ++
>   3 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

