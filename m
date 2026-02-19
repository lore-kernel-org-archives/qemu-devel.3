Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D78C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBAD-0001Ji-Sw; Thu, 19 Feb 2026 16:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBAB-0001GQ-PE
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:02:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBA9-0002RH-CD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:02:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so6552555ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771534936; x=1772139736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNn6Z59q1KzGVDvJOfL7hXBmg/bdDDH/vpbUjDC+MSY=;
 b=DAGKDLL4GWpD17jeeM2aKWpXkDENUkzWV9LwztNrqIbE3xeNL/vOTsMOOxdceU+IJQ
 sdf7KqW/GN28OaI8eFa4IblYrnHb9+dOuSrT/BSZmUgNerWGvt19ZkweRf6CNGo+LdeP
 m86WxHaAgfGRZblg/eegzSB3MDGJ55fVBVf43U/aMTE3TlXFDti1qZX38atIoZgNh7xj
 N0URlbRrr3ygnm+nRiC8/Ffk6vqxWpCp2Kdmt6jMwOQg/mThGS88MbZzJpFIgaTdcsGt
 2DyxBxxHTU4eQgfxU4d4ZSnfANW2iO9yOB+AWlLEHJ2ej0nVxsh8saV1Z6XsnqykdXXI
 9m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771534936; x=1772139736;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNn6Z59q1KzGVDvJOfL7hXBmg/bdDDH/vpbUjDC+MSY=;
 b=d03XNwUhyVPzBh6QswBx7ATkeYNCoLwUR5CeMjY3FtCzd9R2KyKYnGgNIJ1P7JakTE
 bFNz4nXFZzu7oBjAmmlaNr4VX7370C69430kCbMjRFvzrdrsC8qfSSCSmPvDBSNNtU0l
 tszqd7oaMSR24rXFUSt7yZvuxJXkkZUZHDWccAeFEnQVSRUekgOlzoZrEAm98P/UJ429
 PTkFLSXN1DEtJIsc75zGC7MMV2YTBnG1XO09GDmyL65nQtEbhcjeQ+4WkLqIFVysH1yT
 D9v3hn7tBO+ZN6NH4aZgKDZjiPtMlvyYG4ULT390WLqMs/eSdJLx8bmdVO0jmwSqfrn+
 H+9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuOiZ42RJqc5aQ/RPXu+SO6wgMjzoumMuafnn/6iGGIeaY7ouduNGCkro57W2KAGpMJwNvZ+XxOBP7@nongnu.org
X-Gm-Message-State: AOJu0YzOuJRnIpSGjCXja6ZfHbFnOq+wkiqy4U7rxAv3IxTPgIfxzH3H
 xBChtCjqE/MNfCwI21r1MSOs7SBckviFdph1BNZK452Ct73vDW3K+hiGNxL3pQ9JR8+vjk4U4l7
 RWrfS
X-Gm-Gg: AZuq6aJKnfuCIoCHIUmkIVUaPqsYBHuCs25ahJQf9jq+w6CwVxRx2Pzj9q+p6V2jbRS
 CMqgj0tdEQG5kDa45cmH5uJR27mvA4jfUp/cA9Pk0tKh7g5s8nIbRhMAmuddFQlkEBm6P+/MZ3p
 Nfsak3JpqqmLNeZCZB0Xdw6YKrcf+P55uTWzqzJOvB60kfM/Xknre9VPV0chd6SEe2D6sK6gInT
 VGFXZ8cWs46D72qecdQEAtR/I9tdZVhEPGoBaCrGk7Jad3M7J9g27sLIIYR42zkjsrgOEs4xtDc
 B0ZLG6kCewJeWKcVBuk5Cx2EZU8Wpm+WGbYRV7WrDonhot2mwnzwGFbQNBcRGjw542n1Fgh3QPN
 va7qFD8v2sRCjDP9snIGJ0q7OQOmhperB+EEPAPdFfoI5+2h7gkfoSL/eHQmqUcxGb9BtAKn7zn
 5Vsn3AY3uczRxXPUSXk2gT1p+OkvJZ4gEIR2FbaxE580tr7qvg0pjDxac2jD8Yf2CE/ukC
X-Received: by 2002:a17:903:2f0c:b0:2a7:3dae:de9b with SMTP id
 d9443c01a7336-2ab505e8319mr204854795ad.44.1771534935735; 
 Thu, 19 Feb 2026 13:02:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358a2b3425fsm48751a91.10.2026.02.19.13.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:02:15 -0800 (PST)
Message-ID: <d2cd469f-6c82-4bb0-9e27-e929e1f5709f@linaro.org>
Date: Thu, 19 Feb 2026 13:02:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/50] target/ppc: Remove PPC_DEBUG_SPR left-over
 comment
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> The PPC_DEBUG_SPR definition was fully removed in commit
> 61135639821 ("target/ppc: Clean up _spr_register et al").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu_init.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

