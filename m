Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A1FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WSx-0003Y5-VE; Wed, 23 Apr 2025 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WSv-0003TS-S6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:32:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WSt-0007Oo-Lp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:32:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso45797235e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400741; x=1746005541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtueDHNQMsK568mC/rymypiKgkzlWQD0c0Rtg3Qc328=;
 b=dHHD1siGGS02BsUYH44RZ7lMn1GhfeTo5904h6T/kuGa6d3QaiuIiY20agdVw/ucR8
 VLHNLucubU0FWOcH2rS+HtGZheq0D7sqksc9CpafmqOJKY+v7z1gYUY4DeR6UxvUQM6P
 7Hs17hUtlsqTaKucRkKFH5DDZhi59Vt4XwVahM9eMvSY/hYsGszXEn6mKSbSuVtgcc7p
 jRiHdjMMm7m+QGDmfBi/U3PrcwCw1uyshx7+xPk9sfCobS6tdryLDMpcnyBPH1xdMvKY
 ZDbJ59WNpvEeLQR89xtme4ZHaQVc6z0GHk27cRtofRnM7t/sJK+FD0Z/rvOiEd9fowbj
 Pr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400741; x=1746005541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtueDHNQMsK568mC/rymypiKgkzlWQD0c0Rtg3Qc328=;
 b=veczvD+EkqDSXaU2FJUlGod2hGKDnXXGeRxhlWw9rpSNyfTpGVjSRbqS5H899husek
 eZLTBzwnrs8b6xTJ4FjUcRD5zQR6RQQNA6Z2eZ+PtHxKx420nRL1z1Cb/uMa0Gcs9IDX
 DEmHBJ5EBVXbb03IFofyGvPLF4T/EJC8m/qDis8AN1rMcD9A3zWK8SvTLle9VcC0yVYS
 +Hjf/zMjlJVS8NrnCT85XzuQRGzgDYmKfdXb2xb96OFL0wJ4EXvc4Nnmd5x7LjA61mjc
 0yQxY/x0JSThJUXK3SdjB11Lx0IknjtPGsPJP/35y9V+jnKhJwrIVW+bUZX7FsenZkLP
 pI+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKQtZfmaBhboe4w2WgFoqXsu2T+PbysllvvFFuMdVUMEjoNGmsUkoLubqx2j7UNv+TcFBDyQ/Cz7yS@nongnu.org
X-Gm-Message-State: AOJu0Yw/aTHoCdgylvIPwe0YwVjKySeM1lbnSs7VeLMRk/fvqzmV2FQf
 cqGPzck3q1G/CqcScqiJyIooJE9XyfQwNXxC1wWeRiEI16GjBSII8gOSk0DnQ1Q=
X-Gm-Gg: ASbGncv7uG1+b9TRfZItrSM3zsZcn4k6RMSmQ5PjqFY5NN83LcjlZuRS7B7YUny0CJF
 vX+Etygg07M8CmueTEOS1NBrbDSTG0lb4JfbjbZ+uhAwr4ouwKPyM7/F6eYIXPa8GSCpOU1xbuT
 IfVq8tlktI6BhRkFK2tB9afPNzziuWgy0Mk6smvB6UQa7Ji4jKyO0raRWgJVK1zupf7QKVEncV0
 R1lempScVV4to4+ukjyoXHvhT08v6Obwh2cLT85vantEzLsc/V6VtAEpJ1Vpnk/Z5EjUtNsFtjl
 ZazUm5radEMqMtUGT1AEOKBB/oUb4UPkD5OgCFDj70OqEmAwULZZolUyWRKvga4UqvgBs6SkNqW
 dkCeDl4/R
X-Google-Smtp-Source: AGHT+IG2c3LwUMUa9iRLKmwcuc1TVx4QIzGildiX3BmjvvJ6GmcBZCzIWR1cVfzq5flWdYgx9ktyNw==
X-Received: by 2002:a05:600c:1554:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-4406ac1a731mr136058115e9.24.1745400741418; 
 Wed, 23 Apr 2025 02:32:21 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d17a36sm19321455e9.3.2025.04.23.02.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:32:20 -0700 (PDT)
Message-ID: <8b21e5d9-04ee-4e44-9804-0af6f02f0305@linaro.org>
Date: Wed, 23 Apr 2025 11:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 036/147] include/system: Move exec/ioport.h to
 system/ioport.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-37-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/display/vga_int.h              | 2 +-
>   include/hw/char/parallel-isa.h    | 2 +-
>   include/hw/dma/i8257.h            | 2 +-
>   include/hw/ide/ide-bus.h          | 2 +-
>   include/hw/isa/isa.h              | 2 +-
>   include/{exec => system}/ioport.h | 6 ++----
>   hw/block/fdc-isa.c                | 2 +-
>   monitor/hmp-cmds.c                | 2 +-
>   system/ioport.c                   | 2 +-
>   system/physmem.c                  | 2 +-
>   system/qtest.c                    | 2 +-
>   target/i386/nvmm/nvmm-all.c       | 2 +-
>   target/i386/whpx/whpx-all.c       | 2 +-
>   tests/qtest/fuzz/qtest_wrappers.c | 2 +-
>   MAINTAINERS                       | 2 +-
>   15 files changed, 16 insertions(+), 18 deletions(-)
>   rename include/{exec => system}/ioport.h (97%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


