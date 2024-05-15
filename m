Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7998C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EPU-0003vb-RP; Wed, 15 May 2024 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EPT-0003vQ-3z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:11:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EPP-0004IO-N2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:11:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-351d309bbcfso6349f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715778661; x=1716383461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hprVYPKSryl4br0vLlVetJH0M/s8NVjlZ+TLSYmktCI=;
 b=K96HYmuITiqqI1OWD9cW1gS2+gKcp092QiaDkPYYizfcF5E55Qh94/7uuMdtDaFajw
 /2bZgepxCYlndcyyjKpY0SOWZuI3+zY3Nq6uHinjV7A171SEG/W68faYiGe8LRVHDzAE
 Fp94S54VzaJwnZH1xTW/qFuXqVMsvUFCK/N+GMFo1Dh2MfIYkdSkR+YKpyx2DQc+ypup
 MpLYkGi0dBxDTqK8XOyrNeXFxCBYKIXiOLV7u+DGDIfTYVUwJsCu+21d1LEOpp6m0TGt
 cxAT//wvKseBUj+hcH1t3juQN1wFyrnH2vXiNXzZehQJTW4FBhwfuTplx2txm7lIIBLf
 6z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715778661; x=1716383461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hprVYPKSryl4br0vLlVetJH0M/s8NVjlZ+TLSYmktCI=;
 b=kvTuTFQBU3eBy0Om+yy2vmS2wyEWQ7VkFcNzNfA6xYJuNEF0m1powbSdUvnQ0lPZ+P
 g7sUdnhEPzWf/+StSSbDKpq/QgAvRGMpjPtjfTCWMRt80mHBtdeyr7OQL5DOB/OSaEyX
 tpZ8w5rLv9z9e2eVhu5uWkFM+znwPNbzgD1ZVUcIDRoV3gk1DrZgSZvWyDhlGjiane7V
 hqb+r7vIcv+TzOJ603o/wblLsXvbvPCrVPuZ4ASicW2Rz9s+70aU+U7c8V4f9+46MYjj
 4kEMktP1+ly5yWnKcRThlPZB4Nm42Ap04P1JdUTkMRakmgW3JzZQSD/AGUGRjHMihMY9
 IhhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUv3Eaj1aLxoit3dPU8aa6h9+kmNDeSXWOXvgEO7p5Zdyg9cvnkGRCmW11FekRvyUthZhQ4Fe/3Eg19yfAaQsXDJTs+2Y=
X-Gm-Message-State: AOJu0YxLg2umedOJEXMD5/H0MjGFmcUzDzhiIuwSBU3Hr4PJLx3dTCoy
 X7lEOtNs9GD8Z3rr6bYFscLZpVM+zraAxHy+4JtTqhrLv59HGYRCEcN3U61gRZA=
X-Google-Smtp-Source: AGHT+IHFS72dIu312xqFehrMUh9Mt3NFM9Q39M//fO8NSBMVc61UEOdAv00puVJsxHl9zxtR/QpglA==
X-Received: by 2002:adf:c7cf:0:b0:34d:b03c:9a99 with SMTP id
 ffacd0b85a97d-351c87e7862mr4652504f8f.2.1715778661484; 
 Wed, 15 May 2024 06:11:01 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad02csm16320379f8f.67.2024.05.15.06.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:11:01 -0700 (PDT)
Message-ID: <e24b2563-b2cf-407e-a4b3-e0c5ef847ef4@linaro.org>
Date: Wed, 15 May 2024 15:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] ppc64: Fix <sys/user.h> include order
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Richard,

On 11/5/24 13:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu_ppc64.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/risu_ppc64.c b/risu_ppc64.c
> index 9df8d58..62cf6aa 100644
> --- a/risu_ppc64.c
> +++ b/risu_ppc64.c
> @@ -11,9 +11,8 @@
>    *     based on Peter Maydell's risu_arm.c
>    *****************************************************************************/
>   
> -#include <sys/user.h>
> -
>   #include "risu.h"
> +#include <sys/user.h>

What is fixed exactly?

