Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E314D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rVM-0003D5-2z; Wed, 01 Apr 2026 05:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rUE-0002Yj-Vx
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:03:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rUC-0002fl-QS
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:03:42 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cfe71e5d3so2785821f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034218; x=1775639018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o5L1oGz4KFuGUfFqyRLy8ABv5gE8gKlzOtsCT2Netj4=;
 b=YTHGeKFIH/ugIbinoyhaD6DHjWhIlkyqGqITA9F+w8dNKVmI3GEDpJT0i6RQYdBAIr
 Q42kcqSeSqZnU/DSurZoMEpXksRnss+1M1RB2bR1mjE1jim7OPJsTaw+oJR3Fjp45B5A
 qE0IW4310TsGOiIeDH/rcGhK4TlAEusIx5iw+gik4XGSPNbBrXYv98ZuvMtLPrukrCNh
 xgZyngy/K3CMqsUGzr9e5jDUBFvN8l1+dmjApxX5JIZ2ssRMDcVv9DrsSvNBulNKN9pq
 r4XXeWWeKllMsPe/mKmx9FI5U2E9mZhSBweCUxWYLUDGCmlyziTfrYVySGPdFT8uX7m3
 eiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034218; x=1775639018;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5L1oGz4KFuGUfFqyRLy8ABv5gE8gKlzOtsCT2Netj4=;
 b=ZM/rWFv1huHs3oT1xugO9rBUMXQLQxpcFWG+qUAKRwhSNYpNwLfTOCG0kX28i+O5hT
 vWDWYvgDNtr6kReO/Vw3Khye8iPQ3GD39DnAqY0lq8crFQUZCgmhBPBt4Cvvx0m9NaU1
 bi7XDwmAhXCB/sLXxRFlxVrj7vtaRodm7XdC6imyuqlC9XlWfJpJawx/sGHtsi/YZj6X
 4gi4v5rUClQ7bgNVav6XQqQqlCEDzopiRsg6GCorO1yAIxOHDEAoKrzqNz0W6poiplGp
 6EGSWntOHaSXAlYlmIjdvOWfjkH142wwa6TbK/Z+RUQ9wiDzBgoj17NF0qD/tXBibuAs
 hwLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9kOWU+lBCZhjTczN0Avnbk5DykMNIMPikEdSlEAQ+ymypRwdcXdIjPsbpdFOP3K4iqSmbUjIFh76W@nongnu.org
X-Gm-Message-State: AOJu0Yy8ZT4LrbP8sbrXxkla0HlHWnmQfsykZ54DBY4/mzQNAk0ufB9r
 E5N7VvGMn6Owsj1P0UDQPdQkerz4tK8wAxeMFgVEaPvAJhIyqsRgkG35gEjZIvEIwf8=
X-Gm-Gg: ATEYQzwPuBGwT0YZP1+XZ4VUzS1+i7f/jb+Exx+lwgb6YIi9nTrrbuUyIiIxadfyLPA
 TOSieb+AZ5JXADe6A1uT60BYz9NOpAjBfbvzLIFmKKLwSoPkWVgzk+aRAvSvdWRhg368x69n26n
 ORm5Hi8a+31T9PhUBkMCVuMjzDol7CRHVrHqP5YocOulAPO0Umom6qvyq73ygacVQbn00Wwh2Dk
 hBLxOgzbzpHLYF2luvDWWWh9IpKFCqYoCl5oLkwcCjVouVJvsg0rOdhV9y4HB1ay7RxUC1q6chQ
 hCCkUkbfWDPcEEOZgaZ4qZSgL6ztwZ+3NwOfWaw8YvfwAXuW1TqHEKl46USLHjhffBbCJcrc+0H
 jv4MizkCvzN+EMmLlBXyLuFoEQFBRXQ4dLbnz6wDXUIK3moa7r1F4vuR/ecmQQGpV+5pc83Nt2S
 MQs3m75TTSoAgz4mmVJPuTgUfOjqNLMBFECRUKYibDCUrFhw==
X-Received: by 2002:a05:6000:18a8:b0:43d:d82:341e with SMTP id
 ffacd0b85a97d-43d150e8479mr5168715f8f.27.1775034218230; 
 Wed, 01 Apr 2026 02:03:38 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf247472csm29649636f8f.28.2026.04.01.02.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:03:37 -0700 (PDT)
Message-ID: <988f87d9-8edf-4242-b170-1f9fbc6a10fd@linaro.org>
Date: Wed, 1 Apr 2026 11:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Optimize flatview_simplify() to eliminate
 redundant memmove calls
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org
References: <20260331060731.82641-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260331060731.82641-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/3/26 08:07, Bin Guo wrote:
> The original flatview_simplify() implementation uses memmove() to shift
> array elements after each merge operation, resulting in O(n²) time
> complexity in the worst case. This is inefficient for VMs with large
> memory topologies containing hundreds of MemoryRegions.
> 
> Replace the memmove-based approach with a two-pointer in-place compression
> algorithm that achieves O(n) time complexity. The new algorithm uses a
> write pointer i and a read pointer j, where i ≤ j is always maintained.
> This invariant ensures we never overwrite unprocessed data, making memmove
> unnecessary.

Super nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   system/memory.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)


