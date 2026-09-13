Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A77C88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 04:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5bO2-0003lE-4c; Sun, 13 Sep 2026 00:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bNz-0003kc-2P
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 00:00:11 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bNx-00034j-Ek
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 00:00:10 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747f01363so6149715ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789272007; x=1789876807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AzNsdNdRn4zhy/bOr3oIL7k+tzK+RLzhSSV26pz2MLA=;
 b=WUMN3Ozav4f8FBalGh3L1iEYhGA4w1puxKhXQX0oKpEZ8vHlDQvfvW5rGtbxcaUN9a
 Fh69kysThlhHXDVjD/DLDNe+KZgoCJ8cJm4Hhg7q/2LgnVQNTgDUlsnaNBoo6D2vD1IM
 RYUwVwL96VAS6WG/2cWlX9z4VGCYOGNhdxsJVzJPSfJ7v8JultuAUhTjjghsh8w7JoON
 HWn//FaXhNGaBF5huy7be3mH6a6ntusoZF4+KGgdFosF/N7A0ZeVMwD8V1lo/5hLw2MI
 f46+74a+eGUjQ4mqEda0ca35tCZEUawbDYGp9OqQqgR3CQOmJxUjzuBEoPG2s1P3ksTD
 dnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789272007; x=1789876807;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AzNsdNdRn4zhy/bOr3oIL7k+tzK+RLzhSSV26pz2MLA=;
 b=IkeMqCEx2DJexK3jzkAbaM+KZRSFzWCDORxN+hC8aWpTJGzRhS383NTxf5Y7rKBUr6
 S4SJDxmxMdAgrBvNCQfzHrHB6E1HXk2wfn6Z0/GfZzqLoYO6OQ351jZjvHoST/lIOhjK
 oxWVpOBlpaJWdW/xKkcd8DSVY4nevuLikICl/Su9kDBjmhtB5THQRMLUCoB39NxoI1ak
 GjOtLjg1Mur3jDVnoeHDHb6cMz5vBBHnedSXBpNjSUbQzBfMNFb2UKeddsnBPKEu+xdT
 x3jePbwgs5h0vXsoKsSLG899Jou3PDhgg+KQnFvjUD79yXZuG5jYahAnCWtrMLiZHqKg
 ZUCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpBeW+YT9S00lq5S17AQGQCP31HfdyHOMpejrpTyFnVy4zUNNhmSSCZn3q6q5x79sZ61pALd2yvgO0@nongnu.org
X-Gm-Message-State: AFuF++mxG9H/zxlJFPVLTks1LojAbbJyzOvl+no8K96ilYcWatC1YH5w
 c0Z1nNck6YWn0+/cXl8mlHKgmAOnhOAfB1xW/pNLIzc/ciEKu/wrw3FCiL+K2BqkpmU=
X-Gm-Gg: AYBFou2TOtBNwOAYbUOuvdsXUsOhJbHMrwFQZBI89jUGC9cgS/SCMBztdpKpzJ7Ykza
 0i+2CF9uFUFv7dxu7IZ7YnFaP1bqK0nB1KMsJpUAx500s78CxvAkYzllB3kJoButHZXiUB26Eu4
 dx4n4yj3y4jX/pro64qV5xK8V6jsyG9bIEmPeLvH0vPB7Oyd8IQ4MzCeK1mgx6DO9Q32YMbTIKU
 /HMahcnsRSePlLM8J234BFLXCL0FdkQocpmypbhxr9GIcnWsqH5/IhiPcxX4LcF5OmCj1Dzrgiv
 7j37BiadYSBociUT9MSDoeW2SH3fexcM8z6FdRGZqG97UEnpn9yOublBFhm4j2DExM5gMT5AIkV
 z/FH5x2XpTDfMDkIXUT6gKoavfrrNbmBIKvpo5yHPwDYYFUgHlOOd7KRozNbS9uK8omA3zlI1c3
 hM2pb5xs2GZL247PEh3F3wWk9/PxsUUB/0FFfsUSLwidP3UE5f2LRWucmeSwwFp26/qdLdWXtDU
 gGtJ/Pz/cPMf8e/BtJwOBPurVor5s0Sjb+jYiexhqTlZ+luZbb+6gJ5+nA14GWvhTsa+c6C
X-Received: by 2002:a17:90b:3c8a:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39dbbea2897mr9475306a91.2.1789272006757; 
 Sat, 12 Sep 2026 21:00:06 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8137fsm16824705c88.9.2026.09.12.21.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 21:00:06 -0700 (PDT)
Message-ID: <afa4d292-7292-4feb-8559-fb9186a4163a@linaro.org>
Date: Sat, 12 Sep 2026 18:00:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/11] targets: Move interrupt handlers to
 do_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> LoongArch, M68K, MicroBlaze, and OpenRISC interrupt handlers
> don't require external BQL protection, so move them from
> do_interrupt_locked() to do_interrupt().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/loongarch/tcg/tcg_cpu.c | 2 +-
>   target/m68k/cpu.c              | 2 +-
>   target/microblaze/cpu.c        | 2 +-
>   target/or1k/cpu.c              | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

How did you determine that these do not require locking?
E.g. why does alpha require locking when loongarch does not?


r~

