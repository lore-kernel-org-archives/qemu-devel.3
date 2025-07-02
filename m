Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBEBC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz8q-0001cC-QC; Wed, 02 Jul 2025 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz8m-0001bO-JZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:12:52 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz8f-00047k-Gq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:12:52 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-60f24b478e3so2222687eaf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469162; x=1752073962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WYLb8DO3bzPdMj1BjAHqnU8/AVCTz7GAwiddPqqrzQQ=;
 b=pNkxmbjsECm1pVa9/s9JPuwU8j4gfkz+NwoJhhBgePQqft1Bw9nxP602B6Tbizs1jP
 OUdRhR1cjqRNkokP7+sVg0hy99ulH1eptrpKIas1RdTNC6JIVJ9lBZR7Wpfo7J6CM5lN
 p2Co8lKInw2G8G264csSpI3hWVJjIhTifttU31onfzbntVNHlqJ1wQI2YEpP5fzNyP/6
 VwlMjI/C8XQUiLGIwGEo0oJo+rxByTBAU7vm3hCRBHixJimdXeBRyv0W8iK7WuJlA1Wv
 YTILKnBAEohBD47jQVk8FFqiukqitPC/D6d+DnMikNE7xUcR9YAjSGFYNidhTwAWRTih
 O1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469162; x=1752073962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WYLb8DO3bzPdMj1BjAHqnU8/AVCTz7GAwiddPqqrzQQ=;
 b=UkQhuVBRLuR3rIUt2bM1fksI+K+e4IP+BERC4ON8fLpZe4cua8sTUb/O24fVWsY2Yn
 FDywIYLnL9BUjbEl40QyfUcJCa2zmeu7r1BkDQ/fOhRtWekzmhtRKl/9CrCR1qH5ZX0+
 mwEhxc9kgjEeIaQ989KE9crlLufMIpT37FwEF53CxgLxrJ6gNlYp7UhyRWBgXxIDo6iS
 RTiyP6hsM/Yk7ATVAi4kDHaTeQaSbAeDfNJQPzXYBja0kMOHbN0q/Vm3Vv++7D9+Pf/2
 FCaQ5a9xyGTrS1D+neEn2pPBTZHANB8IIJELA+vS/LG0IfghVnAkdBuMAmWhsvik/vjV
 Cc7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW98KKOySqam2/PbvwksMuP/9d05/iRFlzcV0dJpPN4TtacyAB0MU4pHgxnw18kWZDgOhXop0zmPUKS@nongnu.org
X-Gm-Message-State: AOJu0YyhLRHYJtrG8mCuxyxO/gWgA58DSs6DjQDtaTKrG7UbcwveOwZS
 /+ySuxsXdZwN++vPHq5kuhTnpKyiNmgrB2PGCKrB8mHhi3pSgIghG3colAW0efXT5lostCMJz/N
 nwCSAzPE=
X-Gm-Gg: ASbGncuVOY/Jb/p14sCqGroPXiRdY40D804sxBqoIYGQ6J5sVJPeTIoK1fNVqREFc64
 g8/SksCuQqfsT2Gp4U66D3w5Loo3POxeYaYw200sst8kYcxr1plt7E/moiw/LTWsl2mLMWfhNNn
 rrG55upfizp6h0sNPPil349+EqejVXo10+TPi1BO+Y0CymC1IshzJohIP/03a/8ZlBr59uoQaIp
 uzw3Tm+8nCQmZvf8fGeBJbgCAzaLmfZKdxsMteSCJ5ZfaqDQ9kfhLvRI4ywB315DPU3dRR0Tp7x
 6sj0pz8AaghJlp7T3rXZZhshKIhd+VsTOPU3OzSMsg5qEGyAo4lXSq2DSLomqGaHnKFvZeKxV9o
 hklFSgRQcU9s=
X-Google-Smtp-Source: AGHT+IF4MSDCFF9vhxPFf/1Iq1s1xyg3naOs2TAZflePPpsxMEQgU3yNxUwtaLxfIdDXxXiMEJ111g==
X-Received: by 2002:a05:6808:13c9:b0:403:37dd:e109 with SMTP id
 5614622812f47-40b88803319mr1880916b6e.27.1751469162602; 
 Wed, 02 Jul 2025 08:12:42 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289379sm2527456b6e.2.2025.07.02.08.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:12:42 -0700 (PDT)
Message-ID: <aa6a1e0e-39b8-4b52-84f8-8affa7a906a9@linaro.org>
Date: Wed, 2 Jul 2025 09:12:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/68] target/arm: Use generic hwaccel_enabled() to
 check 'host' cpu type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-43-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-43-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> We should be able to use the 'host' CPU with any hardware accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c | 5 +++--
>   target/arm/cpu.c          | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

