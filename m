Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C099C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OuY-00013H-H0; Fri, 25 Apr 2025 15:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OuV-00010T-Qi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:40:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OuT-0007OE-Hh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:40:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1895688a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610028; x=1746214828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GljpmAfE2XxBlvDW/7WSOIHzyuXWxiT+7+/eskdV4GQ=;
 b=LwKETA2P0ZADHFFPUXg5c1q3Lwp4s6SXqG+JPYps0+oKmhqjycmY1wJbMOxT96wkB7
 HRuv6QTw9mvbPEF9dQiWoVnFiXzFyk4NDHtOjaeD6yOGYsQoul28Xi9MmPIw+XP4e5+c
 GPgTRdxPnDEPRGUPKCMc7GZVBss6oKCjn1ycy+ZoKtDvVmMeaMw0D7w0wxVpGeIM5FEQ
 Sfh71LMQMZfkylzvhLoLpEN9VgJ5BvDWKrc9v/65O+VvLJ2vNmGc3j8rvqeDnCUMmLYi
 P3vBbT8HPFlLTIlrVzHxW/U70WqgVDWuPhZaNnxvUfSWoGM7Qci0OTh8pYPfJ73ZXOCe
 RlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610028; x=1746214828;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GljpmAfE2XxBlvDW/7WSOIHzyuXWxiT+7+/eskdV4GQ=;
 b=U1FVg+80J0SOHzyxrWexkabYk4SotKFOYC/9g4p3Mh0sJ59mWh+Emx5zc08vS6TIxS
 +GN81L6eByI5jhA9hIg2zpxOCnJAgcoZOfdvqSj9aFthcxyEIqdo7ZOw8ls+FnJgBu/N
 d+Hls61RLj8M1EP9p+GoHfxZT9HJbdkKJx12OlryRS4t5/Zh5gm/4DmPv3Sr4up3lTH4
 tbRMlCkPUfjJHNuO97g12i2tRh3aIDf7vmW91nueqk0YL7k0gIFmUCR+sapQcEwe9c4t
 I44oDYLjWDZsTPpcHLS4rTawcc/iniRR+d6FvC7k3Ksc1o/5RiXhV0e0tJ8LA4MdCjXL
 bhiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKaceWVi7XzhUdgqKvbXvVjTH7eSaY3OQ8K9i89OqMIYHXjI2j+HNUkPddu2TovfASId5DoPBfVva@nongnu.org
X-Gm-Message-State: AOJu0Yz7Flny43a9k6/Ho8+JsWEqT4Djp/47X9/vtek9k+r4/PG/c5uc
 cKzIkJ4Us8XiXVvZP7HzEPUG4O6VFL6Xh9sH1EVhEpuksyHxylxHwYFF9NlIOHs=
X-Gm-Gg: ASbGnctJkn6dhag9WE+ErPhWTkYzFau79KrPYiagLKh0dKTUAN+GvQ+Vro0BjrbswI3
 hJJS60ZtiLD8GTckvaMF+HhbPWtssyA1TFrB9PrCEn7KZlSWzJ/Gi/hqiBV/aBz6BDH6FJ2+rdl
 MHnPi1lyWG9pJ2SdUZ8zrHqTmFKyXXTOCPfSWOvzaCRLU7e+Pi3v9fbRY1CF06JKfrMTI7M/zk2
 n/zDnfiXaOy0SZ8f8RC9TDK/lYOTNRV4qR4Ye9FY4A1dt2puk634XX9onkQ2AarACLAR+W73nP6
 eG3mgJIfHg+2/pyH43a1iVz82lsOrgWCSeRStZLWx23WIWYLZNV1FQ==
X-Google-Smtp-Source: AGHT+IE7Xv4FF8bakpTYMot4O48vrU7bJ2TM7YOgr7gp5AItgMndKwHgV+3ARoFXoE3B+Jkix4HGsg==
X-Received: by 2002:a17:90b:274b:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30a0133647cmr1096839a91.17.1745610027981; 
 Fri, 25 Apr 2025 12:40:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef146f92sm3911792a91.40.2025.04.25.12.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:40:27 -0700 (PDT)
Message-ID: <e7acdae3-de5d-453c-9197-0022f7b32374@linaro.org>
Date: Fri, 25 Apr 2025 12:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
> have each target set the 'precise_smc' field in the TCGCPUOps
> structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  7 +++++++
>   include/exec/poison.h       |  1 -
>   target/i386/cpu.h           |  4 ----
>   target/s390x/cpu.h          |  2 --
>   accel/tcg/tb-maint.c        | 32 +++++++++++++-------------------
>   accel/tcg/user-exec.c       | 10 +++++-----
>   target/i386/tcg/tcg-cpu.c   |  1 +
>   target/s390x/cpu.c          |  1 +
>   8 files changed, 27 insertions(+), 31 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


