Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F50C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRLf-0005lj-Qo; Sun, 23 Mar 2025 15:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRLc-0005g4-He
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:51:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRLb-0001rA-1g
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:51:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so8425744a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759461; x=1743364261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cACQA11NUfjHlZKukc9yFXklQ9Z28sUCMFdeYvHLg8=;
 b=o5umq/TmvLAFh8EuYtvvV+SAN/bEG9FB11gU6dYBd3Qe/I7rEDFc2bEg2B9G/TBNYR
 dte/zl/aUliH4vunUH+FniOMI6AxD1WXrLeYNgtHyeLKSN/UrErjma1ASpR07Ta2aprZ
 yEtHcWlJE/Q91Jtn8Aps2IVtNbJ0ZlQNSmh7lJJGGrEjnh1Yx3sDUndrPjMe+oVUFryz
 NoTbjcItVO2pJoamvC2nhTpl2n8aUNVe3wU4n4g+lE2MVJNfs12ExkSs+t5FDMnVxgt6
 hB6HGZg/tnY1XfmkCJ9IBM/SZ/DwBGqiCHIw2HJFa95WVRt1PKFVVOA9xnhLLDpQTPi3
 L50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759461; x=1743364261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cACQA11NUfjHlZKukc9yFXklQ9Z28sUCMFdeYvHLg8=;
 b=Lkwt8sjJDQ+jPZerPrW9mjTBBIn0OffB2PtWhV038JGqdywdN8vwVlf7bbtfIrkXdp
 +tRqA+UJBgBOqME7L5R2dYFSX1/mnfGAZYThg/a8mqNkxywtCAhm6JyWoOlpDfQkdGDe
 GpHpv2D9yiySo8igLrRYRGpTYdRiV+HaBip/FMEaEySExn3+K2leDg9akSWOj+iKX/zk
 9BahQyIejPpB13p1KDzi/gMOHTwaUhPdCkNh3da7ijfIJn301IjNhL8NI80KwZica1/m
 GBb3EhVk0ZAQcTuQe7DLObGa0PVb0HZVVeOyjL89xmf6/liaG1IQWOlkmfCBftlsVWDb
 hU3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtfpROdnBp4Fm7FRYCkLCugrK4RhZC/wRJB+QB4uydn6BDF2lZpdap9b/jH0Ryz1C4L61jRi1MXVVj@nongnu.org
X-Gm-Message-State: AOJu0YyMAxQf2bulm3nBz0BRSGKs6El7ui1kX+1Nze+LRp50jYbjlqNM
 c6jodJ3o8fIMi6dGV5qkXGPNQOpHOkKRu9gMadnWauW9/niQYoCG/a+fdhPB+DY=
X-Gm-Gg: ASbGncsBuJglXZRvGy+QmdKEx8X3rFXh8z+bF3B4Ggbzawos8ubOgYZSR02Xd1Ow0L1
 wOUH8qn0pbeHXNewneu5sSqJry2xGUjJwJWDf19oxb+dHnZG8WLyVxbLW0/g3n71P+HG4ZpB0mm
 Q48JysO4c0ckFjvENBIuUxaN3C2WjwMZ1ocnSdpWKAZRe3p0AkOssu1ur5ajD5Emt1+U14aE6YE
 2fFXe7FGD3XA0/qxjqYX1oOanrI8N/rXzoql17MiMWSFxjRve7FUETYAMENOkUcp81R0vm7HKYR
 A3bgbh3FpA//LXSkkO90voisyKVZCDvP/PeuOOwSNExEa8MpTSSl6pZXwHrbsw4JW6TtxHMwJyk
 RdgZWaFjm
X-Google-Smtp-Source: AGHT+IF9tILNR/1q7pcFaBhzR1mDJV3PWl9v+xc/N3wMTWCmiaYVNWI+gppKnB8IdDZBX6M6C/fgGw==
X-Received: by 2002:a17:90b:4fcc:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-3030fe9c927mr19623821a91.11.1742759461401; 
 Sun, 23 Mar 2025 12:51:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d8287sm6390252a91.15.2025.03.23.12.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:51:01 -0700 (PDT)
Message-ID: <c65629bf-dcd0-463e-8d72-5f8e5fba2f63@linaro.org>
Date: Sun, 23 Mar 2025 12:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/30] hw/arm/xlnx-versal: prepare compilation unit to
 be common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-30-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-30-pierrick.bouvier@linaro.org>
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

On 3/20/25 15:30, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/xlnx-versal.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 278545a3f7b..f0b383b29ee 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -17,9 +17,7 @@
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   #include "system/system.h"
> -#include "system/kvm.h"
>   #include "hw/arm/boot.h"
> -#include "kvm_arm.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/arm/xlnx-versal.h"
>   #include "qemu/log.h"

Likewise, re unused headers.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

