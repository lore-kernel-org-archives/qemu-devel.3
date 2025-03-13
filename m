Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0F8C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslu3-00087U-Qp; Thu, 13 Mar 2025 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsltw-0007y0-Ed
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:59:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsltt-0002uK-Q4
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:59:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2239aa5da08so25190365ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741885156; x=1742489956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22ppXs6ee0w/Tlz4igwTFhe4yUVY3B0eDWqxJEQehBk=;
 b=N2yXZMqoAjC2yoJE5r45YoEsQ6wEfc7tluoGhlQMn7Hz04f7j6gLqD49kjvCTsz54S
 DrPwobthyWZAKaUlYb4qCLvCHritlskPIx5ZKc7RsTOzMaJXZdWT4eCb9DTJ505saBfY
 HDB4fe0AO5daYZnjE83EYKOqx0xNZYLBYaPqRDlZ8TVoj7ZlrDIjg9CLwRu3vVQrSv1P
 z4g98YF687bWS3yzjDhZ9uijvquLssNk5Age8Wki5e3LC/xYFWdOA4VQBoqPhJVT9hiH
 gm9yj19ZzRnRFHMjC7XGnOEiVq2r8QeEvksOiw4aIDYzoxpyaVMme+bc6jwmsli+6f/6
 qxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885156; x=1742489956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22ppXs6ee0w/Tlz4igwTFhe4yUVY3B0eDWqxJEQehBk=;
 b=O2i0NKvPgyQBnu5sB0Yt2CpfjLVZbJkF4ZysS0/TaGbpxnuG08NqMeAEo4T7Bk3qCH
 uN903olNymQ34qh2LNnb3lZ9ex+oNsZAkMHxSS73xJq6gxHJYl7uDQvz3bZZ/QIvzkal
 G3cVU4WmOfJy3u0NIPw3pXaCv+Pk+r5jYBxWckmkUxEC6uGBNZjnriB8jxuXZEmWkqnt
 L6ocRz0G24qRzvDAKZZNmfD6hN4+UCVbCNPS4RJOCGADSVhKIa57mz+1iRtE/anO0Fdi
 9WD3MXrWP5D0PkuO2qCLGhnNK8Jpb0qJHhuzj4n7pkkly65n5h6OX4rqHrtSvukmbLYH
 EaZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN0bR7YMRFcOYoXPOdi+EGrq+yyQ8nAX0vRDqhc6J/V/W7sv1vyKjHef90/BPCGWzTXA1yQS1uTF2r@nongnu.org
X-Gm-Message-State: AOJu0YziIW1T4vR6WbSGN4PPQ/DPjsp9GDOIgzunbGnKshrLYnNdgehs
 X3dUa0y3wArrw5s2i4NpHuOm8CpR/rdejQA9sXDz2TEpMsi29PgOH0vKIVPt3Dc=
X-Gm-Gg: ASbGncuxPep0FiafiaN9b5VPUmgrObY5zd0Lyyv6JAjHj1PZGwKpXnfygiIddLN6rX+
 tN4EJbi6h85VmEbCvzLXxFvhA8kCoUTCfYDIgcDzJgukAZOtNgFQ9A0PmnFmhzzhy2D0l0s2hNg
 SOReHc+gjt8xGNRUpFZJ8CzbuXs5malx3ufpjyc4oGFaBGodJu3I/6qtkZ0Ayp1Ea820pzMxfyG
 kbvEf2rfAA6fs1trD14rWGWYTDuPy+eQD5dCClhM7rKs+YQQumFzewlLkI9BbWuOS2AgEUEpqnl
 CFEtuOynqC7AaONt40zyr6haw3h34ZANyeWb/12qkJ7xhcVCwrGMaef4Cg==
X-Google-Smtp-Source: AGHT+IFianqVbTHicCeeH9OmzdxT0hym7aNO72nMzU3ZrmyrmkQi/ZLEVl9AVu0Jcy1N8Bcr3KozLw==
X-Received: by 2002:a05:6a20:b418:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-1f5bd9cd3dfmr895820637.36.1741885156085; 
 Thu, 13 Mar 2025 09:59:16 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea96d7bsm1291410a12.77.2025.03.13.09.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:59:15 -0700 (PDT)
Message-ID: <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
Date: Thu, 13 Mar 2025 09:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> These expand inline to the *_mmu api with trivial
> massaging of the arguments.
> 

I hope they feel relaxed after that :).

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 163 ++++++++++++++++++++++++++++--------
>   accel/tcg/ldst_common.c.inc | 118 --------------------------
>   2 files changed, 129 insertions(+), 152 deletions(-)
> 

<snip>

> +
> +static inline int
> +cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                      int mmu_idx, uintptr_t ra)
> +{
> +    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);

For my personal culture, is that strictly equivalent to doing the load 
with MO_BESW?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


