Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B98FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWTv-0001KX-Ro; Thu, 01 May 2025 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWRA-0007FY-Jk
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:07:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWR6-0005wu-Ip
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:06:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1042822b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115614; x=1746720414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n/QTXsakOxtKwGoSSmKXGLQ9cZMpySQcCKNjhQ2UAoQ=;
 b=fAiX3izroJOkkDtDRyfTHlDwz8JPTPxlkDGVqsyDVViEV7Hhas98Gd7XTPBh7bqPRP
 SvSprEr2mntgM0FYALgkXxZarAeALyjGc7aGluxl753yZapg09mQqTYh1lAqCu4iwrQX
 RawTLZLj2JA2DjocPR1/fFBEU8nwC/TiKUp2nebt7E2x7mgoPv6kplmACPIMumvTre4i
 S8UdeOJlnHydrEpbYExTK6m+CDs0gyfEqCvI6f+Ipyg9phfEJQeNA34r0Rs4K3JPms2W
 webx5cWAL7NFIOqcPzaFRiuE9ikEjeasZV/SKBvKU5rnlg9FEFW5bYfCHRmlpwBqrvI4
 +7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115614; x=1746720414;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/QTXsakOxtKwGoSSmKXGLQ9cZMpySQcCKNjhQ2UAoQ=;
 b=EaiGsKId9CpHCCdvIhMvPr+e7Ya4cJWtnZS4rOu6U+643ln7n+fb+6oUa31h+YLjo9
 hfrkxmuKIPnBaDSVAFGJqmvkABwpiJyEGAI05EvRCuvMC8W8IrM8N8Z37uJ4N1+YgQgp
 vs9IQa/oyx+7PFJoo/69AnfyPh7lhD6JG3ysgpjbKKOlHkSxXzQBMFbWGasVvcWbAKFj
 K5zPmwJNtLAlIjXA18ALxu/U63qtfx0n0R+DDI5XRtOS+CONJYeri/mlVdFYCHujtbTJ
 4Mn97OLjvQ9js44zZewMvAU5cyS/4GN47eUIjsqTjVYpTX+T5tBbRvF6DtCu/YkM1yGB
 NiuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc0SMYZfPXwj5fnX2F9LD+3Qupc+ODjQU63BalSt3QsKDTtNMjLzUZ4/enQXJZnPYvcljMVN7r5yaM@nongnu.org
X-Gm-Message-State: AOJu0YylRf11LRUNjDxGTOJ7Agn8V8IqQGDUJxBkRqjAPrxzCKzSrWAn
 8WcmmIpZhoUwuYCTAKmsXRMB+EKei2n5kJ5Vy2yBuNNipPGUq3wz6nNV/RdiSNI=
X-Gm-Gg: ASbGncuJe9LsiUMkwH18bJZ8LN3+OpmRXxZpXHAstL4g2FCGglyEynY5lBaOFC5PGk6
 B3zcZsJt21Ahx+3yVcThMgUn2oEsxy0ghwU6kx6BgPpzxF6XLXCSzngumuJDr57a+eYUpcsPylE
 HY2DqECN6Cgz89AabENF8C7zxwhA1fblIrCfTCj0WJ6KAbxwRd6oUBRS+c3wPfVmvcAJPHwHcaS
 HRAxcBuwgHK1YBuHJ/OA6fzHalVAG9qzx3DqqGIyxbQhGZrLZWnU0iBUsz70cSpOZTNglOQgiu8
 BSXoaDd6g1e1Kr6tVzax7VAQoWARDeKxrDRacgMx+va76SkQFTuOSw==
X-Google-Smtp-Source: AGHT+IG8qSAxLjxHh8gCUMUOwuSkH7rHfRY0jM39RLsWDhp3mLjuC0VaoIQkmzO9gcr4Tn5nRkbuEg==
X-Received: by 2002:a05:6a21:6802:b0:1f5:839e:ece8 with SMTP id
 adf61e73a8af0-20ba6a201b2mr5920779637.2.1746115613792; 
 Thu, 01 May 2025 09:06:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d4f31aesm916323a12.43.2025.05.01.09.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:06:53 -0700 (PDT)
Message-ID: <107f9576-b241-4e62-af17-928169a2c03b@linaro.org>
Date: Thu, 1 May 2025 09:06:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/tcg: Remove TARGET_PAGE_DATA_SIZE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> This macro is used by only one target, and even then under
> unusual conditions -- AArch64 with mmap's PROT_MTE flag.
> 
> Since page size for aarch64-linux-user is variable, the
> per-page data size is also variable.
> Since page_reset_target_data via target_munmap does not
> have ready access to CPUState, simply pass in the size
> from the first allocation and remember that.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h |  8 +++++---
>   target/arm/cpu.h               |  4 ----
>   accel/tcg/user-exec.c          | 26 ++++++++++++++++----------
>   target/arm/tcg/mte_helper.c    |  4 ++--
>   4 files changed, 23 insertions(+), 19 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


