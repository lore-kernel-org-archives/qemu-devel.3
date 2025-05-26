Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E704C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 17:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJbZs-0002rI-HE; Mon, 26 May 2025 13:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJbZb-0002mz-MW
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:25:17 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJbZZ-00083T-Hv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:25:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad53a96baf9so481730266b.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748280310; x=1748885110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RMm1NqqLVzrbDhM6JIumEG0AvpWGF5IbnPt7d9znfog=;
 b=BTQApE7QIrRLps0ogy6cy8aasrln5MofgPd8A1M5aQ61uZRjP/gWRVzbc83WTzjJxB
 CkToBB0z2y51t0+6M/VegMYTM2eX7gkFLfPRj0CiruEyb5wLvuvy1HhlP/coARn35BHt
 A0PYxzM3KTNoj0b8qEUl4C1kD6pKT19yiEsjIlSarEEMdxB4Xt8A5v2PnlWEWB6PLO4a
 YkVhhvGxzFpMoy53MqCIZJQq3NIStmlceHoaKrc4xcrDqENNV3r4yuGq47l5BhcPxewR
 dEH8ukOQp/z7gvgr7ZvFuKtoLd9UmsvLlfvDezbYf/xNZO/CQ3tKeQ4pKaoBgiW7tktq
 Ahfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748280310; x=1748885110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMm1NqqLVzrbDhM6JIumEG0AvpWGF5IbnPt7d9znfog=;
 b=rxfJECv/e0UhyoPaaukCDsOmxG6MHPLU3piGxQ4S2ZdK8spiF7ah5NH+ZCtXNyuIBJ
 zGz40pvtDlmQXNTwklxVUOJkL2U7CMRpT4X7IaceAheI62oPRGBTFxDg5L5aLYH0mDUO
 FqSOsqCsv9ou6Us+m6dfz/TZbwD+WTfPvF4xc1+g+43CNLTcDV+652zH2qwyBOlEg/3m
 b5cpKgiWGNzbunm2mGCuaEacCAt2+NCuMWxOQUP0J7wxqteSEK3SdFgHEsYr/6aFspwO
 kB0SDKNk55AOmVdJ7pnoagvwdyxodlBdWtOhumrnJYkw2ZmtCIjj1PYXf9xuu+K5wOSt
 YoZw==
X-Gm-Message-State: AOJu0YwXG73ls19bpr4IHD/bDfM8VUcIw479lIJNHo6NO33RnTPwsbff
 qyoepRISgfsiu3m+T3H839G+JCdf7wqzA0De76RG81LYjvD/NR738T35U/jQq0Dz+nEeuoogmrH
 xFsRA6vpkFQ==
X-Gm-Gg: ASbGnctIrE5DYGSyJOQCFe5Fp4pNyWToeLhUqaVWp6bwY88mKTsDSdRwCq3kCc2hc0P
 08VYQwQj4MBP3RdNqLA3D1g43s67NbgUHlBvS3Cdvf2FflaQK/f6evIsg4Z75dk8FIVlgoaX7h2
 DcYfd8hHsPRXz0Wi+r97pDON5SbId4e3LAA8gF6iA7a9sbVUpFe6E1n81QMaR0L/igu/qVJi7+a
 67Q5zBrMZ0s3/EKiTQhSjuRxjzVQzAk8/lbjFM/LN8MsRRqqT5jj2ktcjh6OZBrVon30gIFeerj
 pqMFapxplyaKpcN1rUQis1JgvDHJt5AcIaNHsRsL4sjWWFCB7yM/mJsPpMCqLAfHPg==
X-Google-Smtp-Source: AGHT+IH9q8s+VH3uKDj29Xd19+vSWtjrdUpMTVJV8MwPYrnJ1XaXGzaF+UF+9X4rTY0qdEEhDhgr7Q==
X-Received: by 2002:a17:907:8686:b0:ad5:27b6:7fd1 with SMTP id
 a640c23a62f3a-ad85b1827fdmr833686166b.17.1748280309800; 
 Mon, 26 May 2025 10:25:09 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04f263sm1705698466b.1.2025.05.26.10.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 10:25:09 -0700 (PDT)
Message-ID: <a4f267e3-4d4c-4560-942b-8957d3b04e56@linaro.org>
Date: Mon, 26 May 2025 18:25:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] semihosting/uaccess: Remove uses of target_ulong
 type
To: qemu-devel@nongnu.org
References: <20250526095213.14113-1-philmd@linaro.org>
 <20250526095213.14113-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250526095213.14113-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 5/26/25 10:52, Philippe Mathieu-Daudé wrote:
> Replace target_ulong by vaddr or size_t types to match
> cpu_memory_rw_debug() prototype in "exec/cpu-common.h":
> 
>   >  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>   >                          void *ptr, size_t len,
>   >                          bool is_write);
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/semihosting/uaccess.h | 12 ++++++------
>   semihosting/uaccess.c         | 10 +++++-----
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

