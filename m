Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6DEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nIT-0008BU-Ot; Fri, 03 May 2024 03:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nIM-00089S-B7
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:25:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nIJ-0001hA-0E
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:25:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34d96054375so2029120f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714721121; x=1715325921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6aGcCypXISc00Ev78r2mZUkCtTqCV68eBzadieL1jI=;
 b=hIggeMSYkUEfw8KuiKmXaKY3fDXOX3q8jewdkzyih7CU5v1V7CnjUPrsQoUtYXGAHB
 wJh5xBD7VR27sTCTbsOvc9Hu1zvrgLsPAWbFPMtrxafzly86ByB1vrdpPRy8/Tbgosgk
 Eb5pFakhOq1wpfRfpRDGh5ozlVaUV+EkMvmGihOexvaZB0Kwmb81NdS4/INndu1YMqlJ
 fwBr6oWe2LfWL3yFib218ywXXNE7vp9iMDMKb3Rg9Q1VIGNvUB+uPbR4oq3ZpR7P2VXA
 FuirJSlzPTZ+eRNgO9kE3mt8yO+04Q4HUUgaPkxuCL4Ckz+IK45YIEl4+BFXhK17RyYU
 0g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721121; x=1715325921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6aGcCypXISc00Ev78r2mZUkCtTqCV68eBzadieL1jI=;
 b=lq2KehoOoxY46vM4oPtaixCpvB7ilnOFAD7IOKVDvDtIQkarHuCtSKcZtlFo9ouIOP
 kK3/0PuEoIseuxwa9ReAKGKpZ5SxSmOv2zNxKH6jJkpBD5bZk8Bc39DCfWByC4YbvQ3Z
 MiA6RI4R3Mc02o+W3QKpjZsiWIex+h4gsX6P9TzimSxLKXXHXYgZjKF/sqa3HED/ehXM
 dgmSQbHbC8cqfB48l5+yJDuYaYVBXNgh5PymytOuwurB2WJrN+KfY8kMqYStssWXQrNo
 BlZIuC0KOVD9Erb9rzOs04jxtd5Rf38SdTWwLBbk0DZpoMsveHn9FxAp1uh2SWjIQdJa
 yDyg==
X-Gm-Message-State: AOJu0YwOpb30ItmTylSmy0TD39hXh/+8JiOeCXAhGTd5YLxhQ/Oy8xDu
 dkgowHLcUSqrp6xXKIYLlMqwq2SZXHZLijW7j+atM0dPOuw6s2KC/Mkn/WEklmVrJTWaSL9+inl
 i
X-Google-Smtp-Source: AGHT+IGmJOD49/2zxtZj6j72+I2hUwZggIM2YKNWW8bXvkIb1mrQtLatgvzxB5mDP/drvCRMe69qsg==
X-Received: by 2002:a5d:4dc9:0:b0:346:1ab6:dbd5 with SMTP id
 f9-20020a5d4dc9000000b003461ab6dbd5mr1338335wru.20.1714721121321; 
 Fri, 03 May 2024 00:25:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d67ca000000b0034dcc70929dsm3034650wrw.83.2024.05.03.00.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:25:20 -0700 (PDT)
Message-ID: <b4494cf6-5b01-4891-9682-e0e3c868c25f@linaro.org>
Date: Fri, 3 May 2024 09:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] target/alpha: Implement CF_PCREL
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
 <20240503072014.24751-10-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503072014.24751-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/5/24 09:20, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/cpu.c       | 23 ++++++++++++++++++++++-
>   target/alpha/translate.c | 29 +++++++++++++++++++++++++----
>   2 files changed, 47 insertions(+), 5 deletions(-)

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


