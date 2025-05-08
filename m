Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0677C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1BW-0005J2-8f; Thu, 08 May 2025 09:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD1BT-0005Ij-Ep
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:21:07 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD1BR-0001xu-Co
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:21:07 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30c1c4a8224so376714a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746710463; x=1747315263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ql3o4MtIjB95RrDWYHcFgA4s1q7bcYBSF6CJuxuxs5s=;
 b=HJCzkFU9Rucdi/N1WPdvLc/vYg+s+yb5UGbwN74IURioKLISvUHbiUmWGyRKFOWUtx
 M3CDOkrYv18JOfu8Zx86hBJzJ5ybKTG76x3A6AyChyWNiaeydyVT7AHuR68ndNAntOSH
 ilYOK3A3JyR3pWbKSXY2j6cv1JNeq5dd6stc9vAcU2ycClvXNJH31+yNC1NqS9E/hAsd
 t0az5J8Z1u3U8kdiIC3dq5LWIPBHqSE1ChRsFyZefnM2zsPOimnzUsZ3+fI5yviDZNGw
 EFCexz0Da7yvmCUtGFrmOBH/p8uCTq+vhNTaWByWTmBoEkie+RG/l8Tru+8aJJITirWm
 p2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746710463; x=1747315263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql3o4MtIjB95RrDWYHcFgA4s1q7bcYBSF6CJuxuxs5s=;
 b=FxuWLY7E2KOCxiWVAvIAeMnzkCxKlOYPL2jFrVzCRgKPFGy6WoMdqfzCkVPbMdcX9I
 xJUdZ8bgJJWpVAP7cVd4KFPNxD2q/Hmc8i0cBPu08t8BbwpKJ8KW+B1d+ELnSoLmF2sR
 TLhp0yK1wSm5+jSKMyhCIgj1UtEBkQzOH9bzAIxuUMN1EjH/M+I/N8/FVW+p+W9Gjknn
 GkiKgGK883wJ0Lt8xHXRJulgii8nXrMhFu/Cy0fijyKriDQ2rkbh5CheG/GV61fPafzE
 E8xsfvdrz1+Gjgl4uoA2XvSgrktrE5jYaDTYFgJ9aWFyeq+4RmfOpSYb2oaAd9FM5ytW
 1NiQ==
X-Gm-Message-State: AOJu0YwCLnfvZtjBvfhEtdyPzPv079wiPs7PYC/216jgEKXLHCOsGaeV
 3HoxB3NYgJ9IdYtpK4+60h97iisCFZJVzKEoVrN+xysKXlglaCRc6Bjlr1dDOBBWk7gk6kTUeQA
 u
X-Gm-Gg: ASbGnctvSg4xh7cWA9oNMVYoHQ8JqnkZCO+4nJnfG0EvxLIEEp0PklBBTVsqfwCQoq3
 UJSXrQ6YK3KKpGctnf8Dt8+T8u/0BtgF7DBhgxsHyUz95eHQo9l4kSQ5a852FONIWTNZ2ZWFUc6
 uBNCqEfLoys40sQOLvnhdDsOY+at6wiVEVZ6rBT51H2wW0N6e0+RIlvzmTSAdlyjcG4k+2Gmo/6
 aJZxKSZ+WuCI8xfzNLkv+cWrrVpfR/vwxIHrlbAOhVTvxB1br0vofrfJU0eGZfSX6zF51DfGLaR
 AcmZN8ltnSi2OfgVRxnvPkOJwXi4kr8aRpxK4eO2sOLNB3xu/FHAnMalAkUEqXNbYpNevJhGjqi
 5o26z+U4=
X-Google-Smtp-Source: AGHT+IHL8ZkEg3SZe9kOe9o+sstf2quvENasveMdYPp6iBVYvgrLeLoCEfQBLuaRZC+TrAfnI9IqGQ==
X-Received: by 2002:a17:90b:164d:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-30b3a66322amr4855208a91.20.1746710463518; 
 Thu, 08 May 2025 06:21:03 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad48400absm2139536a91.9.2025.05.08.06.21.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 06:21:02 -0700 (PDT)
Message-ID: <9e929fbe-468f-4046-b0e3-f490c219bc6f@linaro.org>
Date: Thu, 8 May 2025 06:21:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: drop --enable-avx* options
To: qemu-devel@nongnu.org
References: <20250508095044.468069-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250508095044.468069-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 5/8/25 02:50, Paolo Bonzini wrote:
> Just detect compiler support and always enable the optimizations if
> it is avilable; warn if the user did request AVX2/AVX512 use via
> -Dx86_version= but the intrinsics are not available.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build                   | 30 +++++++++++++++++++-----------
>   meson_options.txt             |  4 ----
>   scripts/meson-buildoptions.sh |  6 ------
>   3 files changed, 19 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

