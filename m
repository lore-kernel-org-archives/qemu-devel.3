Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB02CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tpr-00035e-8S; Thu, 09 Oct 2025 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tpo-000313-Jd
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:49:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tpc-000519-SO
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:49:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-271d1305ad7so19474405ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028568; x=1760633368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e4IUYsP96UPEWIXvAkBYW0A8HUFj9jLrDatWi5phCJs=;
 b=PVlkpUqpdLs2RWdp5ly/3RXOfBCWLy5Sx1lS5em5X/5+EgSqg4fXRjao1P2iElurzN
 HSoqPEOs1OpF9MZTAfVwdv4ElsaBmGsQ+10hDUNqzmXQISQ8aA92/zUD/6kLhRM6AcFF
 ZlAvJe6PmqrxhirrDW7Mj+xH1B8TLSZ+/zXMGmqtm4fpxCI32ghfmeE+oeAM+Zgo+kvv
 sFCtoCC5c/WV4jZI8odHZ+tIbmdpKAI7JLcw+I5u5Kdof4undWDGB+ebABjz8stjK/hn
 CX2tHsV1w4q0zu62WI2R5l4+6kXkal4kxYQMhifqWvRQ87zY8np+st77+h0go5tca6RD
 0CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028568; x=1760633368;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4IUYsP96UPEWIXvAkBYW0A8HUFj9jLrDatWi5phCJs=;
 b=fnbFte0pueWfHQfOU49JLzhPGOW0fYWhpad61m6nQHjMtJxw9HFAcEHJSOVwwpRlkI
 UOyl6Ftj+zQYbHYry71K3jjQbPgbCxjPFAW28TbO3XP1d5ITL+Q53E0d/GYfZkMWfQkD
 1BBHGIqVCYmg97wHI3Pd0r95jcAgDC+SBi32riGOk32aRYoBuBY0hZjL2M58RYMcQCV4
 rvM1NNGY3RCShnfQaMPREZKnFWWzCF6dodoAsrdN0A39D6V41UxzSGkMPAbgzCmOFlsx
 dzcreQoV5JVUPgNmMh5jKfdLADFkgGAkIpI1cZGorH/+izff7+VbZ5hwpZSQXxMDInnK
 mm1g==
X-Gm-Message-State: AOJu0YxL8IEYZ7MfDUskmMKzcSC2P2Uclz2n8ICt9NWkK81lUATS9XQF
 jeDdqveKuNiCLdo2nX9t9ec/NQUZ8N8w8mZ+8YlaQX0oCPm/mvKKRJssEOYXZ9FqWAywEdKKvgc
 I+Dk3occ=
X-Gm-Gg: ASbGncv8ZwWESAIuckkyqYbQFv+ZXVkZ0XHTCtw7lcJu4amtplQQLXns3+FJjU9Ti1p
 EGKXjvqrx6aNAV3izM3E8xnLPPzr/hoyEqgJboPnuo4I+0aPiqi8mBMY/Bhi1A7/7FQFzukPGMo
 UieByOF+Yu8S9c6a0n3BeK9tTdBa+QHQDYizkvC+g75nB4TY/T4JpkyTxUVaFkFarUHjoOlKOWR
 1hMP29pn7rlbZGXjm2Loe/FSTQDDpKo0n5fcOH4nBFuhJKJXHAVx//ffvDM9bAWct6hRY1sszkv
 7cGohZiF9rwzVUI6lCoQa9vOVXT/pfm/NWjPIbcjb0POmuahjYwVh4wJjcho+U4sq0fzVWKHAV1
 7VoocxotpuPeB2XhYAmZdQk9ygvJ8fgkQzT4CJz4TKqYzokfjIqznMjQSx5vE98F8
X-Google-Smtp-Source: AGHT+IEoMg/mJBojgF8CAuD1/NW126sS/bbHNV8aqkE8xYAb0ZfulKxR2NYgJz96AmRCiY9cZrXe3g==
X-Received: by 2002:a17:903:3c6c:b0:269:9719:fffd with SMTP id
 d9443c01a7336-290273567e5mr101363485ad.1.1760028568346; 
 Thu, 09 Oct 2025 09:49:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de658bsm33897595ad.22.2025.10.09.09.49.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:49:28 -0700 (PDT)
Message-ID: <10e3525f-4332-4572-9fca-eb769db34c58@linaro.org>
Date: Thu, 9 Oct 2025 09:49:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] target/openrisc: Use vaddr type for $pc jumps
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator_*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> ---
>   target/openrisc/translate.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

