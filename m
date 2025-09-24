Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Tli-00042Z-V6; Wed, 24 Sep 2025 13:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TlV-00040N-PB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:58:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TlP-0006O5-Cr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:58:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso94808b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758736722; x=1759341522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QjsKXGr578DBALV3go0ZKZPnEze9Qb3zmyX4BRZqFV8=;
 b=N5op1pyA/Y8PyBeOXxBs/lIUUBFwbElkK0Cq41CH/VGl77ytRIJD9Lar8xSwUpfUQI
 RHvklUTLRANcDz1BR7Ga4D3wZeoLNMRIoMWZY++dndweCYrK7DwI8PSiwwewc4vvoEGE
 lmICgWorEJsDy8DH5I6NbaaAt+nozVBHS80ZjohS3GZBJp/5t9i0xbDAe4kMgL/QLLIQ
 Aj656EkPg4SbGxl7Ba8X9NyhOaxbbqK+6GGGPKg8pB74/pdjrOelyKBXIbwnk5CS0adE
 Y6ocM9Vy6aA+fD+LyTGfsFMYqsBCLykWCml3QNl4maL6ZHNk4HPCH+C0cTNj5SOuUatN
 cw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736722; x=1759341522;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjsKXGr578DBALV3go0ZKZPnEze9Qb3zmyX4BRZqFV8=;
 b=FRhA7jWlbzogv8ZR+2AjBw2eSNLAVK5hHoypL21rWDXETyKf1fLt2cCCtv9+OEH6Ux
 rRh7pTbdPQpTIK6Cc1hLaFtT6ZUxKqs36y7bDJ3HBPtmnZ92fjHxb3tncp8SmP4EAxWJ
 JvyI3RhXnMuvJORDni5857hZdubx4rV/JFwQ2g31Gd6cE8DWlZq4Ft+V/7kkl39c1P9A
 PWDoIBTV9XuZS+n226q5SEHmlQ0HXD9ZAoFGZDC1/F9X+FVKu1ZJjsqV9GecoSM+WSYx
 Yrw6edEydqfHP4VU828f9zFMgLsMipcM97XkG9jJZj+/FaekqsH5AB+8X+hyK/THZlt0
 MBkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYHEErE72NDGfxjn9UeQnR5s2IWPatALgRiN7hCzNnNnaJiRRolnr38FybIdeB2oREmvviXM7oNuJP@nongnu.org
X-Gm-Message-State: AOJu0Yy63mQNRtCODU6XdPTtinc5OOFEmrXuJfZgCJtzPnYCvqodRHNw
 EkTN25M3qBOkn8FbpZC+m6Y8as1ttBSBuAK9hEyMCY/veeEdE9m1gfWrxhP7+BqK0CY=
X-Gm-Gg: ASbGnctD05R5Y0PsrZlNLfDKG6T/rnxuDzaAjcMZvDDv7JmvpbFXYv0fpQw9ZHb64c1
 VnXk8aCc0e8Fzp/xj9jSWYbkyBWL3LVMmpG8enLYrUe9xECIfT2EV4VFpXs+wlANe+GD9rUw/CU
 /mluMWA6voO0/DM7TRU56lerlSjpJWJPujS6bp9suWTTdqjUUXfIUc2lDS+qkv6IO7H8ALvG4NX
 SWxalH/VQFSW9ZXyNLLBimFUqpxYGJKNtdipKVtlyLJK/9rhsTyJxogRLd70x1Wwf12u/QbUcSe
 +ypTkiLVoDG5hVFWTFfvWbhA82bz+v7XYH6eAf8Ywd8YnwqPo/YlAH8bokkg4a9iotoa1hNRjEn
 rfftgxxltrBMWHcYxDi+ioHIkFlPqwJ9abvMz
X-Google-Smtp-Source: AGHT+IEtSnzptHaAMYgP+bAyR28CEgedzO14/tpfaZsirCH2rieGyPZryR3b88zu/pzxuvjjT8lByA==
X-Received: by 2002:a17:90b:1c03:b0:332:3515:3049 with SMTP id
 98e67ed59e1d1-3342a774d86mr349441a91.4.1758736722494; 
 Wed, 24 Sep 2025 10:58:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bda0e0esm3023798a91.11.2025.09.24.10.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:58:42 -0700 (PDT)
Message-ID: <439e1252-c222-4007-b9f7-301bb23be187@linaro.org>
Date: Wed, 24 Sep 2025 10:58:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/ppc: Do not open-code cpu_resume() in spin_kick()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924173028.53658-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/24/25 10:30, Philippe Mathieu-Daudé wrote:
> In order to make the code easier to follow / review,
> use the cpu_resume() helper instead of open-coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/ppce500_spin.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index 2310f62a91e..bc70e50e926 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -99,8 +99,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
>   
>       cs->halted = 0;
>       cs->exception_index = -1;
> -    cs->stopped = false;
> -    qemu_cpu_kick(cs);
> +    cpu_resume(cs);
>   }
>   
>   static void spin_write(void *opaque, hwaddr addr, uint64_t value,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

