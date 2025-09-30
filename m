Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF701CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gn1-0007aB-7A; Tue, 30 Sep 2025 16:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gmy-0007Yo-2y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:17:32 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gmn-0004u6-Ou
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:17:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32e715cbad3so7509927a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263438; x=1759868238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7Dzeh5NPF+rmy/kTwt/oxN+1r9oo9iiXZj2sBoZpxo=;
 b=rw+UG9BBsRAeBdsQ1VcyTyLRgsZTc+xyBoPiOvcrVy8yw9m2XRcLFXi4hwJpMsELCL
 VkqaLgzRKNV1NaNSQmTUvSpwmdZvYJyGVioSBoCTUi1riWAgGhBPy580YuB66K9p65gY
 0TG/koAS2OIMIxbahh6jsP5rQOQikyx+Zu57MODk91j10zi2d3pY/Q6vYsH8yalsEdpk
 qDvf5LCu8sQXQkk2uqTyEt+1j1IWJ34MVCbUov7SRwJnVD7ADMA4O0ioKoxSxb4txfIG
 ttl+a9b8YI+/O0oKniDpThVSxyVUWoNfZewsegBn7zbwcfgqaLroTpMYywsmIhzdX7P9
 EPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263438; x=1759868238;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7Dzeh5NPF+rmy/kTwt/oxN+1r9oo9iiXZj2sBoZpxo=;
 b=O+0N4P95yoZ2PeBtTGQMM6QUPKdCKhfrAzBSnXZIORHC209t3oE6z0KWaPWwArwWpT
 i7eo5dLNm4aXxwcStA0UyWWnmOSYARhM//6vcpeRbR/Mbgm9VHB5Vw5x8Ud2bB/DcyHs
 Rv02JLsbFTaBkwLwcETo9y2kisfMlIMDZOIrqiP4SbgaJFLPUEnc8WlxnPjiyA8i877H
 dFjGdvbqO6OH3x7OsuqjF/rY2t+3yYFWDIN8fohNWK7m46x9GrRht9NTChqLBMSTJ9B6
 3rgPT5PbNHRKSz17pxTzvKGcs9Do4wKUj+ZMGdP+S01Oh/TPMAXqmyGhKnafC7nWU0q6
 bfGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gNJ/umnCp18eJu8mTlLf5BCijXgVOElE10VZMTxIcVX5yr/mqZdPr6XKer163s6T8uZRTiE7K0/v@nongnu.org
X-Gm-Message-State: AOJu0YxDc8pULHMoTUqYC1VfFq4g0ffAFdoHTqTsrD9I7xu0QhH/BM6G
 MYEK4lUD7kOOhF/A2fh9HV43cZBcw21VPA0xMPjR40ytzqTmRJJngLh1fNNrtYsits8=
X-Gm-Gg: ASbGncsVGaPzvGyJ3F+h/bXz7MdntdipW1ntWJyRv2B9BrF8onJoYpia9B6Rc0xjOe8
 izU3CXJK+HEOGqOG3S4bnVFJTxPjTDPc0rk0ZLr8WDw411o930qXKG11neiFyfA7ROx3JUOujKo
 ZmqfRhs+3dzFzkDph2gRVz6G9TqzMxXPcURRts3Hl4V+Qp0mAGeSKQr/f64B959mMp15z2sLgs8
 MxbHR6p28Xf9IKZOb63D7gL3+CdwaEuTZiL1lRT6TQ67mdM7nCgRZysi35Nj+nM3HMPgWzeEGZ9
 dCQw06SdtwugDIR4GIxK2MrRd5qj0H8YJhwnMp9KuFFoWB/y2h/dsEkMmm8DoEi3Wbpax5Cz/Cy
 5a8Fd6hsHqCpxTcU938pK9j+W/W28Ms9L0V2pyhZJY3nTSK/NMRz5eYzY8a0+
X-Google-Smtp-Source: AGHT+IFSz9K4OOGvCfEgEQ/78yOOD/Zp143NRet+sDw9Ei0P85pQWelZXExIiU9jNqVXbZ2aOeIRMw==
X-Received: by 2002:a17:90b:3888:b0:332:793e:c2d1 with SMTP id
 98e67ed59e1d1-339a6f5c0c6mr751183a91.36.1759263438117; 
 Tue, 30 Sep 2025 13:17:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6f2697esm416695a91.25.2025.09.30.13.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:17:17 -0700 (PDT)
Message-ID: <571b6c5e-0176-47ec-929b-ccf0c2ccd307@linaro.org>
Date: Tue, 30 Sep 2025 13:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Since all functions have an address space argument, it is
> trivial to replace cpu_physical_memory_is_io() by
> address_space_memory_is_io().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/arch_memory_mapping.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


