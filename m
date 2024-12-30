Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9623BE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 09:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSCKk-0002Tc-Ov; Mon, 30 Dec 2024 04:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSCKi-0002Sk-K4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 04:45:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSCKg-0002xL-Rn
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 04:45:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso60588195e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735551905; x=1736156705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NeqSPlopQbxQJjHirFxEZvvtD9F8/TbqVL7nyWt5dJA=;
 b=QKsK/75RS0r66NlTv0nYDEMMVhAQWbE6CIhUBI6g/iIaTdapVEJdMpWoHradhVXCzC
 hmmHAAx/k6O1sQ7tQlua42C/YYEPuItmozlg7t8/4gRhGuDwPgLeLkSNEKmtnvlcDVKS
 dqsx/hoIOTVczDJfTIF2vaerPFokwNlseWgztoVMslldfl0wDr1EYMOofeyQYbiZXvjf
 W6TD25Tg1PD9FPMku5PAEgpoDNe5G9x5lBjFMLA86Wq3cokJ+hZJ0+4tOdHtiTacWPEi
 6W9oPlFjKO94QioC9IBvm619G5LLt49mZNsKtH2ZduDKXZ0L9xmwtD9yJaPlQe2FQwC2
 uZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735551905; x=1736156705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NeqSPlopQbxQJjHirFxEZvvtD9F8/TbqVL7nyWt5dJA=;
 b=haaDNXoxYSBUOrx5GSeWWYeWl5q/2RZNNe6ohfjL4yTRiZT81u22jt6vfBTOtQSzSK
 0MTu1jUaM89N/PAu4vinW8QYV3tj46rNpiqv0J4SDAwrg5O/jJSryr6YMAa9LAvWkm3K
 UCyBi3Tfrk4QQyvG4L1Xasybc8B6HpSp6FpyE6pMC6niHgJQZvldXJWYdk4SVtLYHbgp
 LamdcL9bsY+alz6sLz33PeXoafwh+vNHC1d3DB7rYp00JlUBxIlnOVXkmq9LwL65RMiA
 PELUWJkXWlf59RLaQZ6OmYtUeGfKflzASMxgQF0u4Bb6LJfVlBCmxAm/B/EmyLpFu0SS
 dTwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMz2Kcdk9MF73SZjH7NkVJSVpk6CtVarWa7DNyDrsbV7c0co8U0oQinddmk870okpRZsdjhgrB/tqd@nongnu.org
X-Gm-Message-State: AOJu0YxuEUVvx1AWL8X9mkXEL+MKBZw+elqWefO7D+QUSBIMvPGYx/VM
 Dz8s9ExxegZa7MDW/zljo5qW47JrAKOLAaBH9Neob2iR2q1w/m0oSWHfNMnfKII=
X-Gm-Gg: ASbGnctcExMwn4S1xvo0vyNwqZhRc/0HjV/UCUO7Cb9OjGlgT/FfW+SR92xpEWFL/tZ
 9K4LoD2ScqsabiW6QEziA1J4kn6IwVR8Hbahy6JTzrqROV4kjNKjGptWMtKtb8iRnCqtsc64LGN
 7RbNFIMl9AbHLZEJQlYcJMxhB8sBkaEIPb6z7Lr+BIFV8tPxoKhHpeJaxpdFR7DmjygGlkvdjfZ
 V0Ff6NNPTgSHROQRzWCQ72zx3A6UhB288bOYQQ57drgdnTz6uPSg1+HALgd24ErdsIs+9r8LwwK
 ctAowan2d5Qgi5BwDEsM+QMj
X-Google-Smtp-Source: AGHT+IHFMc/Ax5heVeE1L0HkcIq6f/hSEmyYb7poDnZsbioo3jHm19uzhIWllcAc1YKbOMczXoGodA==
X-Received: by 2002:a05:600c:3516:b0:434:fbda:1f44 with SMTP id
 5b1f17b1804b1-436686464e7mr291825775e9.19.1735551904262; 
 Mon, 30 Dec 2024 01:45:04 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b00cf6sm389240535e9.10.2024.12.30.01.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 01:45:03 -0800 (PST)
Message-ID: <8a46da86-f68e-465e-8349-ce9d043372a0@linaro.org>
Date: Mon, 30 Dec 2024 10:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Hppa updates
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20241230002248.33648-1-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241230002248.33648-1-deller@kernel.org>
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

Hi Stefan,

On 30/12/24 01:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1a7:
> 
>    Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-updates-for-v9.2-v3-pull-request
> 
> for you to fetch changes up to bd2fb633a931b192540522fd842151b2421824ad:
> 
>    target/hppa: Speed up hppa_is_pa20() (2024-12-30 01:16:15 +0100)
> 
> ----------------------------------------------------------------
> hppa CPU reset and speedup
> 
> Add CPU reset function and speed up runtime and translataion.
> 
> ----------------------------------------------------------------

Please hold on for this PR, it was posted roughly 1h after the v2
and I still have comments for the first patch.

