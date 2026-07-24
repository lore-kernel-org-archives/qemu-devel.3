Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1CDC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnIZa-00024z-OT; Fri, 24 Jul 2026 12:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnIZY-00024k-8O
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:16:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnIZW-0000xT-No
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:16:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso9274245ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784909784; x=1785514584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vSg7Y6SBHwLd3VA9VQJSVm4AMcGRZOjivGHNc4tgrZw=;
 b=dbD9j7pBkvYZ8sdy7K5lXrKKDM97XQwdvoKkzhplMHIFUTeHzFyU2fo/oaICyCOynN
 AwoDdv6WpnQfmmYFsn7jMZZ995lBdeTe+eg47uGkx3ZKDtqvrXdnuqrRl5o1Qtb5rGpA
 7jCHVk7QOArDU1NBXxQbMOv0QzT+IhqNlQwyo0xUAbY2NnKqsGccdC79iXLlkmi1mqhE
 sM2ZYo/czIu1cxZCHD1RV6JCGaUvhWS2tfctO5zq6K8tk1FucHsmmGD+sPxmsXc8vAQC
 w6ylLCOI2xcWVzfjao97eK6z6jVlLGHf5PnJ+dnXe2Ye4XNNagvtttW3ER2YkxoAgOC1
 njNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909784; x=1785514584;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vSg7Y6SBHwLd3VA9VQJSVm4AMcGRZOjivGHNc4tgrZw=;
 b=Z1Pfy5MuvIXfgAQf+YKCfqqdFiAor33gWu3Tg4wnDPMB2pjmCV42FLb4FIB3RBVBZc
 CxXcprUf0/EIO7WxiUEM7Nc5sNchfuSxE8EDaVAwa0PtKGh4U6SDVgtiL8tjHwS1c+il
 eQel9kEoVjhysMyRAZRMEmtgw3MOLyYjJqewRpYq9AwgicULWpyXSqH8H1wxrWPjbi44
 oi6ujkQDWxTi9gMHT2c5Pg2ipcKeoW5YTY/lbe7za2ZArmr1pUQAwt0/h+FJ065XTFGB
 5/LnCRbkjI+3VAU6K5ENsCmuGFkUi535wkAyBOAhKYm+CACJ65JGX04dc3FESZBAqqRw
 GtOw==
X-Gm-Message-State: AOJu0Yy3CGb7DlSiIREAwKG9U/SKNGrNC2gxfg1GIeD2REwbE9uizWK+
 +h3KNR7SSTMql0NbyeXCZ7eGDav5+Evp6oODt/QP5VTSasAgf6U3yg1tivYgej4oi/bRiY3iGIe
 h4v8+
X-Gm-Gg: AR+sD10UmAHNqQuLHq6dVbtFmSrCCPvzjjMrzNkQDSbCN4H01UHVBLat382BDS9Uaij
 vIPstSkNsMJDiRQEDTjRKol1SqFDdls+TWr5wFVXQOcjOf8i6NcBNz00sAiewmgb4xhrkfPxiSj
 3pRYsMlOEWgdePYQwZu/7tva34SqeAOQwaMHibZAVqAvuyCmB2w9ei1/DK8z3BmcaOoILsghJZU
 tKA7nXMkP92fMJhaTkDHVUu5px9HSVtOQFYvOdArbrjpSU3HckXXGdKJsfbV3wt/HpgcsM/47ul
 xDXIuupm8VfO54zRIXVVdDcGSfXj7So739eCjwSIGGHgHnFJQYvhIPwCG+gvjSfyk1CMiUwtAbD
 B3fI6lvhCzf/w6Wc54P5h/dfMtoCaZZLstKSCxku/aY4SdN+xdYYcvoOLlWKst/1Yor/us6o5Np
 QLy3i15K1SNjjCqmgL1r/2qmNOyDzpN8mEBYZDtj3s3A==
X-Received: by 2002:a17:903:2385:b0:2cc:6329:b7ba with SMTP id
 d9443c01a7336-2cfa6b6fda8mr94100595ad.16.1784909783994; 
 Fri, 24 Jul 2026 09:16:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f350475sm53780435ad.70.2026.07.24.09.16.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 09:16:23 -0700 (PDT)
Message-ID: <8cdd73f7-919e-4817-ae00-7076be9716ad@linaro.org>
Date: Fri, 24 Jul 2026 09:16:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/misc/mps2-scc.c: fix scc_partno and cfg7 write
To: qemu-devel@nongnu.org
References: <20260724160943.52509-1-simonxhy0404@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260724160943.52509-1-simonxhy0404@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/24/26 09:09, Simon Xu wrote:
> Split commit from v1 into 2 as they are unrelated.
> 
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> 
> Simon Xu (2):
>    hw/misc/mps2-scc.c: fix cfg7 write
>    hw/misc/mps2-scc.c: fix scc_partno field width
> 
>   hw/misc/mps2-scc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

