Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJSf-0003I6-Pn; Sat, 16 May 2026 14:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJSZ-0003HJ-8M
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:10:01 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJST-0003kE-Dv
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:09:58 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c80170db7d6so321277a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778954983; x=1779559783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8mlbprU+TGictMd0ht+tC2FriL8fiT0zKcP0VCCDj4=;
 b=m5VkHBh8pDcSERuPJfVOj9N3EnAjbt+XtBED69Scihjp9hs21Z+FASF+KLgbFIHB93
 tBB8uWS96BFJ7usns7Mm2KzpKjA1xBeyfrwHrAY/ZfVWEpBVlwedzpafpzK1B9IdGnEP
 AoxyV643VpFXKmeMoVMnL5wnQrnKQIpCFT2IogDqlc8WF+wtemqMUxcwU/5bmbZuHZy+
 rK6GI5NGIK1bEcV+vAjU59DiKIIQLZ6f0DIRX9fC2VjIcQMxlSPSyLcaQ9n6KW5LxrHK
 ymkrSsSqLJ8uKv+qatOtWlO4UvuIlF+BomaF3Ud8YfnuGT7yJxCpKno7jUmNLHg2cynP
 mzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778954983; x=1779559783;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8mlbprU+TGictMd0ht+tC2FriL8fiT0zKcP0VCCDj4=;
 b=GSyVwVe2mOFDUlYBpIy8AaSPjEsBNW2GNXrILRLJuhIPd990Ig01EC5hYFQWfwNpul
 EqPuC5dQzD5bQ4vRh64uDq4V51OeUyEhD2I12H8kiBXWi7s/i6DeKQuoN7uGEGS7pCIq
 QIv7Ms2+fwDF3fBDz2mhNfz6l2AdCZzsF/uTyvEpNDHkCXit8gNZMx0WiUhSxMbWvhWc
 bT6jX9epvwSrIMqHqmUC9qN4R4z+mcaT3hvDeZZRy4BvHruHi5Pq1GFdLx+fIZoX0l2M
 dK7O3G3L8Sowu33SSPM+m7kUe6Db96EHNgPIIKKMgcEhRTM+I2w+1wBwqFwN5iHdduvv
 bKcQ==
X-Gm-Message-State: AOJu0YyXRHCFaujXH+0Ljw0U5qOAMeZrD/xa21bcjSLJO0aNhK2tLG9q
 mTDDXSV16MhBAINmgm2Di2U3s2CeXALv/7nZrVf2gpFOeINrdtgZf+4yB+WnBw+I3iuqx0yrsbE
 qTRaI
X-Gm-Gg: Acq92OG/c7+HR1rUP3vqDfK3ZrqUMi+wD+F3aa1NrXEaj2ukkGhGMv5r9XfBpVpjPUU
 PbfLzVHYEmR2mHxfICQBincCs3z/pScwC+dQRVqFqJXj7hiLYCCV4mEsV3mSUNGjQdLkd8kRgXE
 EDbOYt0iSbK3ylI/CMob9WqjHRZ/AMao0hI5jIfRGx+4ep+mlW9xUOAvgryxPAGl9/cBm/nOFE4
 885BL9xUTIh+d4R81VI3GcxqL5fWKG4jiM85mQJUQXcqkOqZNY4F71MBU0XSaLBakuk1gDc3lUq
 FbQLXqdy/Q8CLb1c301h7sTOzlZfV4HMNeSv9fbXKMV55jBnQRKZmqT0uP6kuxLPlolgANrRrcu
 CwnX9By0CrenHfbMlhvEwCgSV85ixo6zlTf4VU1uAzUXCdW8enbsKzfb23H9zuIQ8OveOv9O1yo
 sRR5pECKlhQIElGBDk46yTYIOqo/zPDAjl+Lq3
X-Received: by 2002:a05:6a21:ec13:20b0:3a2:7ef4:81e1 with SMTP id
 adf61e73a8af0-3b22ecb36f2mr7275127637.47.1778954983020; 
 Sat, 16 May 2026 11:09:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm2518832a12.19.2026.05.16.11.09.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:09:42 -0700 (PDT)
Message-ID: <a5579cf6-5c87-4429-a44d-70f8dbc9786f@linaro.org>
Date: Sat, 16 May 2026 11:09:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/intc/arm_gicv5: Avoid NULL dereference in trace
 line
To: qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512093856.3197700-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/12/26 02:38, Peter Maydell wrote:
> In the handling of writes to the IRS_SPI_RESAMPLER register,
> we call a trace function, passing it information about the SPI
> being resampled. However, spi could be NULL if the guest tried
> to resample a nonexistent SPI or one configured for a different
> domain. Move the trace statement inside the "if (spi)" block,
> as it's only interesting trace if we actually did a resample
> and potentially changed the state of the SPI.
> 
> CID: 1959593
> Fixes: 33185e1d64e ("hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

