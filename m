Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75B0C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbGP-0007b0-9e; Thu, 31 Jul 2025 17:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb69-0005pf-AL
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb67-0002Ec-R8
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:46:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bc5e68e26so1698258b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998358; x=1754603158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxtyRx8fKsPdu8DhCd389O0kPv+3onLsP51LDCsy6hk=;
 b=snVoZrhiIiXoYYBc1hwFSeew7GM3J8wgRuC+xbShZl65G98oAZd/MHqIVkddPz9ruK
 uh9W3VNlXAp8QO2Jz44KL30vE/mvjjZfZOOxxP1dihUQwB5hiSQZm9qV4zQbcNnmJ7A0
 OKM8YhMaxjKM49SMC+EW4XqW7b4z+nphwXR4P5yZXsWKmURtkGsv2fs6poxghO9l3HxM
 aM6U9CNEVVq0bfaIQEDXn08+q11ml0knHdpSkNfzgVyNSI5zoOT9cj7+de3KVoT4FDO6
 IvYoRaPVTEEcU5/XzBM53ZKp3/52RmOV7nmCE04fyAW9WonfofiuyJyLOPCUp1ryc+Y1
 zAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998358; x=1754603158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yxtyRx8fKsPdu8DhCd389O0kPv+3onLsP51LDCsy6hk=;
 b=wC6Aq6+3H7i3IAC4UchhWzM/3Ueam4NJ0gELreo+akM27RImXfbUnxAbNzA4d9AK4A
 mP7pZ5yKONSu29vooQ5OZv8lEiIpiImkejCHoowQfEijffD2n5YS0H9vHHWsk5QPdSPu
 tkKUexRaeUsPep7rRq+se2/1DVTlYkJDY9XwOkn+fsJtoagSCli1TFcG5FWj8YTrdI4D
 ktLY+DAEB+rpgHXZkQ6/k7HiW2Z6/Jk/aFCYaYQaylwkMAW5V+rgEmPjFLO1RgCgQ+oS
 A9Wn2Xj1m3r1MGxGip12PJRQH14vnCLINIq9aYtPAcao/LvNLpWN7D3DB3LTXHPbTzD3
 CgzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBsHi/LmylnR0PRE4Sa+K1q4AWyoZEXbY3hY2wRjoMFGvBKrddYGd/rNKwIkK0yhN24k3ZaGc2UmKC@nongnu.org
X-Gm-Message-State: AOJu0YxsKmo+0jh14pElAYfGDBcR5RCasWbf2M+oIisFgyyHNfoGZnha
 1/higrXUxxbh6YT5sl+fUPkqHDLf3uDwAdPmAbv7wxEh+hgpPos28o/kHMa3hAHBMJTB1MQ1tL7
 KK3bl
X-Gm-Gg: ASbGncsw7DEggiJga4lUmmsitxjsbDmJvUSyYJjIRI+cFXlW7NkLz+6exJmfx09svBY
 PFfKQMdBjSnYPuDbT4KvbtIONh0/f+y2qTiD6knUAoFvG8fIXmCGLKuzilMyh0x73Lm87ZW1ETK
 4lX6Wv5GCN5Gam4B7Zwr8/JdvtvMS2/fElDuz0EOo9zjT2b1XpvDzqtvl4F+e249LEEX1WRJDBS
 S1G8mEAXcx11UmRRmmg+OZ24SqeN4AwWbVDiyWJBBh7bHF41FpU1a5bzwqSM1S1lScpMH//UvUf
 WE1iOK4KfH/JCmyDVvuCelPbbnDDlzep8SO+UjtLxC38y6o3sadAuKAeJury0TVH6S7JqXzWNx4
 TAp+LuNKdMehrvPKdKfE8lIxHjPa/INGHVpQ=
X-Google-Smtp-Source: AGHT+IHqljx4q9Kx5rFufwrnf7pJwVO3YvKGTR6Rfz7PA8+8U/fYQn9YuZc1kx8eXDq7ahwMri5u4w==
X-Received: by 2002:a05:6a00:3981:b0:748:de24:1ad4 with SMTP id
 d2e1a72fcca58-76ab3067e9dmr12176170b3a.17.1753998358075; 
 Thu, 31 Jul 2025 14:45:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8a838sm2486926b3a.32.2025.07.31.14.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:45:57 -0700 (PDT)
Message-ID: <de6fbd09-1c98-4f9a-8448-bfe1c171a152@linaro.org>
Date: Thu, 31 Jul 2025 14:45:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 63/82] target/arm: Add gcs record for BL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-64-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-64-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


