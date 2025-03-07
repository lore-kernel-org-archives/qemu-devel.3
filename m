Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCDFC282EC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqN8o-0008I6-Rg; Thu, 06 Mar 2025 21:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqN8k-0008HU-3z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:08:42 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqN8i-0007XR-Gb
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:08:41 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22185cddbffso47945275ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 18:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741313318; x=1741918118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XPm7vUDA5ufTI4bbQzGsBhjs3j6e558LlXKlob7pDOo=;
 b=Jzim5kTUplhdKSeP7fcxFPoSpWOKGtsTGZ0p3BJIJof4ADY920sNcJG8X17D7TVvLc
 Lnxck1Gao+rwdBCbATrGj1lx0AGELwEzhQj6FCZwqSsrdVqdVHWSEu0RMXqe/A3iZW1K
 BA+zLr+ZBw4TzwD1+OHPitUh8kyUnE/tUThhpnRmGkG1eLnda6ZWHL40xkCujf7ip6JP
 Jpwe6mS3ITLAlqYnFz5hcX4nxjWOxKm4a1F+QTSrrbLxEz0ccc+kwelkxJawLCTnV/Tj
 0vCkr68oEX6D5CfjYj3xLgsvoBcfnghLWfS9EMIJWBMYtmOO3nPLcteIaIEo0cOFHyoP
 SZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741313318; x=1741918118;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XPm7vUDA5ufTI4bbQzGsBhjs3j6e558LlXKlob7pDOo=;
 b=EKeGrBoo20IlL1ngMpiELXGkg6k09/em51nEuu39rLcsA/moZw/fYtYk2HBryleR75
 IW9/THQJBN4gg7Hf5yRw7ZVQ6Nv4KmbNDaBW/UG6UrmjMq1dmfvkWctkktneulnVwTca
 9OkZoy1LC9c47cDoDOHojBK8sdwSSZBX1Ky5ir7uU3nU3q9TFg80yVB782wS7yBn3qPc
 H44tkW6bM/NLmBHNwy+oGRvqU6ME+lb4bG8vCP7XzEWwArl7wvfbhByO5dDyWUk4/WKF
 EP8otk9AccyFkx8N+evRmYFRLRe3NYMcSvSdXKmriKORIvcNppbfVOwczrUV9lDdtqgz
 xlTA==
X-Gm-Message-State: AOJu0YzSSKmk8qgCEfPkLkdbW5Z/XTjlx41kBoiEvB1Ggnfk5bVM07ci
 lxDUV5YC1fFHCh/p/9IhC92bRGE4EF4sJCVPpj5E4JRroeDJBOvzRsLU3DwrixQ/itSjXr/Ir6z
 n
X-Gm-Gg: ASbGncvNAQVt0+0Y/HbxJsJ10OpCY29U7CcU0077R/XZ18DE9TjytTrEA3MGtAwqcIE
 UO0Yi77kMqrn9+MxZ2ySS9WCYZDn0jiqYbwq39fy3SulOmkodTMNrOFJaGzzj+Q46C32fZGz4nE
 7PFH5Is+ktHftxGWtpHIlhPuHCU0CRD2/Bniy+ELu4GNpzMN+i50CjERj9fs+WvpixTfpDz5PtX
 pYrIcr6UIwGNXZzsJ0WlMHTlmEFGXYGFFm9t8gLW4EfgvQ3WGwuBjer/8MEWR+NMxOuC6OkYLAM
 oM/Y0oYat3+r5nyIYGDCybML0GbrRTABKskHt6Z8vm+EfJeUyLqh+j3zyTUgPnietLoH/+2xqDm
 b15DsbphF
X-Google-Smtp-Source: AGHT+IHK/TboxA35bxI7syF7jO5+TnRsl7DxiHtyMKXxbkDpq1E5vQnRvLpr682OSZ2TKVVs0rppjg==
X-Received: by 2002:a05:6a00:140d:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-736a97086b3mr3212944b3a.5.1741313318043; 
 Thu, 06 Mar 2025 18:08:38 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ae61b68fsm183181b3a.178.2025.03.06.18.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 18:08:37 -0800 (PST)
Message-ID: <b44e107d-3481-4d88-a0da-e7587c69afe0@linaro.org>
Date: Thu, 6 Mar 2025 18:08:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec: Move TARGET_PAGE_{SIZE,MASK,BITS} to
 target_page.h
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alex.bennee@linaro.org, philmd@linaro.org
References: <20250306234108.378881-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250306234108.378881-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/6/25 15:41, Richard Henderson wrote:
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 343b4adb95..1b4a9a10be 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -37,5 +37,7 @@ void finalize_target_page_bits(void)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY
>       finalize_target_page_bits_common(TARGET_PAGE_BITS_MIN);
> +#else
> +    finalize_target_page_bits_common(TARGET_PAGE_BITS);
>   #endif
>   }

Actually, the ifdef here should be removed.
TARGET_PAGE_BITS_MIN is always correct.

r~

