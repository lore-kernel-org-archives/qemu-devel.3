Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306DED26D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJls-0000Y3-MF; Fri, 09 Jan 2026 16:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJlq-0000Xp-P7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:11:46 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJln-0002nS-UM
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:11:46 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so2820409b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993102; x=1768597902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbaRGQJiyfMeNLqfRO5lcALNWK0r0h87Ye9QtYk8Y4Y=;
 b=kq8NY7vJafQApDLYz/7abAIqIj0alo3oyyjga2/hh0ME7RfghQRLEmwxJgrA1Iwcaw
 8+6Q6dqhWG7sA49jC9LqJ0cWySiZcXkZSkX3VDP+rXi6umZLgfsLANrnxzuLvGkPfU+1
 15sKshIG8rK3uP2ZoTIUmyFHSHHt9Mv/mnkDV7yZAF7OEJxuvBzw4HlGTPy2wQEs7vYl
 Gwpw87Ac6+jn0kNQTFmoMWjXDjBGujNeftGDCW1D0h5uZ1A12ssykIkaVO2MDP+WI4vo
 jPKREhPXMZNcuJyj24gCz/rVGMdIVxPhuaF8W24lS9rljjtf82sdVycMCRGixKbY2YyD
 dv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993102; x=1768597902;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DbaRGQJiyfMeNLqfRO5lcALNWK0r0h87Ye9QtYk8Y4Y=;
 b=XJZByemD5VJXBKH44EVfDDlvMoA4xkTsMF7edMZnOaRAc2H2ZVMWq9meOiJG1fzMOZ
 yh9cLLM2t8KWrpushYcVjURAfJJHu5GeNhFhFN3i/wnb/rNYeYLUHkVjvlE/40BshJbB
 ZYXN1oWxuuLc1qfAjGKNzRONXeDvcXPr6p50FMOsyXdGScW8GmAZugOKAOJzc4OzEDwU
 HopCvJFLwkEZRI68j89jNJV43vaqIKVD/tu2YNRyb/tntJ0GQimhkyYypArmuugEz/z2
 PqjNfxiGtHIVTH99xcC4bRW9IH62JcST3FOK0An0XN8U4vZfm5K3NXbpkWFowDa3vrKO
 CiFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEpbIbjPOGOh+0Y8C8LoqoCX23vhg0YS9Zy0Mco8+N3da9cUuoiZh0019RLqb1fn/QaLs+emGbhZbY@nongnu.org
X-Gm-Message-State: AOJu0YzHBxCuMiv+msxcWBDKYtBWfOXZNpDF9aYwBgnKOunbNyWaGtTB
 DBdePoybw5/LS+9tb2kqtoJvn7CZAbwi/+A7yTp6RAHNjXsnOpbovP6hV4YsdqW8gso=
X-Gm-Gg: AY/fxX6c3dWY465ZeLn7vKejvtzuIficyyt+mJc5drNYaDu1LHYGLf0hR/0nwlBrFtC
 hb/KUrWqpsCg+kKtvB3pEIC2pOVegm7UkkYUqlQ9yzAph/aDyBUaULBAk0e5EUc33Vsnipk3sv3
 /KB4Sk8BsNvTv8RvvRWUijG2M5uY/FjP4swpEq3qARDcvfls+Fia3r79g03JPrn22JgNCyMeJ6n
 9cP75FHJUzDGA/zQCS5B6PKebhRyiHSYEnr5b7+/d5MtglRJJI3xLm+vJU8qRs4gnGRDAE9BBNS
 +vuaCkNf3A/qb7q+CW26PzxReL9LuB7QzKnwqI40AUeaShuyaSgXKjqE2leWHOseHL0v2Nu9eW5
 Y3JZGlNIj+k2sanfTHI6IyQh11V/Pe6dHwHvf5DfC+Lmyt2dYPQTb5oLxTfr9+GZx48t9MCAKI+
 Trm7Xo191jKP2tgB425pUpAIlk/A==
X-Google-Smtp-Source: AGHT+IE6uNE7Tb1eYhfnK5SdKuNQtUP6mz7Y5L1QiIVlp6sDZhK+L3gHfOxBA7rh+ZaK4FvsJWuIIQ==
X-Received: by 2002:a05:6a20:e212:b0:366:14b2:315 with SMTP id
 adf61e73a8af0-3898f9f8bd7mr10491598637.72.1767993101638; 
 Fri, 09 Jan 2026 13:11:41 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc95d5dbfsm11289577a12.27.2026.01.09.13.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:11:41 -0800 (PST)
Message-ID: <8b585ee6-7d70-4c4a-917c-9107c6f41c8f@linaro.org>
Date: Sat, 10 Jan 2026 08:11:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] include/gdbstub/helpers.h: allow header to be
 called from common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Target specific variants can't be used in common code, thus limit their
> definition to COMPILING_PER_TARGET.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/gdbstub/helpers.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

