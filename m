Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA3FC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XOm-0007yD-9V; Wed, 23 Apr 2025 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XOf-0007xb-Cn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:32:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XOc-0005Vj-6t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:32:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso3613440f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404320; x=1746009120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLKUt24uVFCHqBc2OY3g97vDK8b31Tak4nBbu7+kMK8=;
 b=b/1wIBye18zPte4m+UeMBoE1FdAA8QRpCqzBHOd3gFRfgiTrRiH6mZX73Vk2HSPWxU
 7PdMh9a1gIVVdWd1d6MdPk+PMcLMlBVYixo+02VgCymKokWTcmSw7um17ysg1gczlMi1
 32UG550cET4rr+kvQZLFR6ImZx+LtFtUg6EODaam8LMuL7RqyWShCaVyH6TPxgGG6fr+
 dD9uiJRa70ohwSDPF5HdO5WTbtcp8S0V0OISp69EGaGIxcJlBiraEudIXSM5FZNhLNxD
 1MvSKPU25M235rR7qnXsSlUF/ZNTNd7dfI1SHDqCPzWwJ/epMjKYVtpU8UIbQ/MclwQ8
 1DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404320; x=1746009120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLKUt24uVFCHqBc2OY3g97vDK8b31Tak4nBbu7+kMK8=;
 b=SU9MSHd4lNx0Hcgimq3kE17bsqgmcVIE5FvLXsRL0YEJFtAXoiRefuWQ4V8ppRVLWa
 ZNjuAtRxWRnKPYWmC6hh012dIFpYed6XwfB1MnpJ3wWodVBytutP9u/jL83xdYmuK8AH
 VQFL+4NfAjLpnYWqXGNpi9Eq7bTytgLmGUfatF5sxT9f5ErVd9Jv+hCQDD9FTcxA2mLk
 WdG3AQXuCYtb19UJhf/k1hLzEIcyDkkvRTWakMFmf1dGt3GUDqcl2ubLPyobnWHpbsze
 zc1YAhMhGY06XX4zjEO2X8mLp2wKyvsjtOMphnsTZCwVwA/JYg/2/juIXnCLZEAjJ568
 araA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqSVwRNQ2jvN5klC5b3ANcHidJjMT0opzBf52J8ZVoXxwxV8dnxkARgbdlMYex3n+ruCAEz/me21n@nongnu.org
X-Gm-Message-State: AOJu0YzECdayzfKoXxV8N6Aq5qqWFGU0VPJKiBIykX0upDQW6MAfqUhl
 /kN3/U+fXi3FggK5YClbz0s5E+/8XWrF2b73ssGsX4svjD3PrZaLDB2HuW77hIdf2XbdQ4SHwvF
 i
X-Gm-Gg: ASbGnct5rxJ57FMH9evPHt3pqnUAg5gtdHt688m9MyIzHPAXGyV99m0Mbh1v3wbo395
 hVfZzUM6u+Q7HQdJbm1XKXE+Rqx5hFSLbHW6iKkrGEnTKi7tRCSoRS+wq+YniHOGzchpiAYIFBl
 yRcn1UMHg3tJdeVdVsflviOh9h8GSqN9b1EuuOVuJ/TbpcahtVaCWaKqvPWai6cRadtrgqi+vJZ
 16Xp6ZjlyWWtdf2vA1SSUZ5CAeIlyhP3NtAbSmdXpk5nh/edPq2OHc1cJYW9FERpD16McYOAqll
 4isedwGN48xIHTFCnPRAqAeQCQmVwEsPy6yU1DrEDqK4Oy3CYHmQJfomfDkflXMWmJLMSuADBov
 4n+0+Pq9Sc2e3L00jh/U=
X-Google-Smtp-Source: AGHT+IEQ+AaNL/4rRILa4L1UecyY2n4QiDPR57y9wbE6FwvXoNp6GklM1MPJmSovJjg9OS5/Kebtww==
X-Received: by 2002:a05:6000:2203:b0:391:40bd:6222 with SMTP id
 ffacd0b85a97d-39efba470e8mr13037193f8f.22.1745404319915; 
 Wed, 23 Apr 2025 03:31:59 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931dcsm18609347f8f.63.2025.04.23.03.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:31:59 -0700 (PDT)
Message-ID: <a4f358c6-2762-49d5-92bb-aa526c4d8f73@linaro.org>
Date: Wed, 23 Apr 2025 12:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 102/147] include/exec/cpu-all: move compile time check for
 CPUArchState to cpu-target.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-103-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-103-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-4-pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ----
>   cpu-target.c           | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 2aaaf0548d..be462c4410 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -33,8 +33,4 @@
>   
>   #include "cpu.h"
>   
> -/* Validate correct placement of CPUArchState. */
> -QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
> -QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
> -
>   #endif /* CPU_ALL_H */
> diff --git a/cpu-target.c b/cpu-target.c
> index 519b0f8900..7f3b244ed1 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "cpu.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/qemu-print.h"
> @@ -29,6 +30,10 @@
>   #include "accel/accel-cpu-target.h"
>   #include "trace/trace-root.h"
>   
> +/* Validate correct placement of CPUArchState. */
> +QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
> +QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
> +
>   char *cpu_model_from_type(const char *typename)
>   {
>       const char *suffix = "-" CPU_RESOLVING_TYPE;

To squash:

-- >8 --
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 28bd27b8ed..10b6b25b34 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -579,7 +579,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=

  static inline CPUArchState *cpu_env(CPUState *cpu)
  {
-    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
+    /* We validate that CPUArchState follows CPUState in cpu-target.c */
      return (CPUArchState *)(cpu + 1);
  }
---

