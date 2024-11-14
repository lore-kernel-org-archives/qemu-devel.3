Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B13D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeao-0002Ft-Qy; Thu, 14 Nov 2024 13:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeal-0002FW-Vw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:29:20 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeak-0000uA-GU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:29:19 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso672335b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608956; x=1732213756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IID2hjTWPAH/vJIgWztozYD6kUD+Ax1e/V0HojZjqpc=;
 b=CyddusPajU2TX5Jn8OJZseIzuXvYVRSYuJa6M7P55Sbfvy2jczoMTxSfcyCBYzbRlu
 MsomTcbnA7kILRI4q5ZG7Vx/Xm11FNqqbcYvS/sfw1AbMtWlOvNtm8CuHm99TrkJBerJ
 +h9Tp8frblgqs2viE4XHxfxXPiGWmEB75rsKi/wkIUkWoTb78fHuUoRQLPIc5SfA37MT
 QWcg2bIkviy5CDK+/fQczJAo/b9Nlr6WpFdslpofaiguytyr/TUjrF373lvR5H7Fiqz2
 0yhRP+SQgYz8/keeDmBWKH/tok3H0by0vvNb0h1y3/+dNI4/wTyy6WyfU8nN+EdIq1Kf
 UQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608956; x=1732213756;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IID2hjTWPAH/vJIgWztozYD6kUD+Ax1e/V0HojZjqpc=;
 b=Lyz/Xke4Vyi8+v4wpWt63c229y3QsuRVm+w+3eavL/G1FdEZFKSgQPmXM0AKXEP8L9
 uHC4m0+AodV14CTlGECX+c3HbESRw/ZPPPedFo5zTa7L276DtwCT0cNgclPHhEaEO7dZ
 ohIhEXd/4yK/jlLRBL6GGPUpzQylyXwI6v0KIVl180Iyhtfep5+gHIE/iKfeltmZNuRo
 y9Hmp9fq1oHfcL2oYGhq2lPBKiz3RYyp/OZnOks9EdqM2OLUOw92Vsi3ryt8TOGjVdWv
 t31wE3Xsi6Rvsv4WFvUdPC33M5LqP2dzB5dfodk3daax3ugxt9qHt52deeNDkfRtgmh9
 AB5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKY83lE4I8v2pIGAVGkMdpQ2G3J7vzEJpzeQG0NtfIVsvDrT1csa62iI4csrwmaEItp9pzvFGv0uK2@nongnu.org
X-Gm-Message-State: AOJu0Yw18xpHUIjdRoLVIVjMNlFI6RewWQO8xIVnP/zewWI8+uxiz2/S
 m22Vl1e8+Wrf3plwCFcG99mGI4tknpOwqeC1Lpib6LHSaV+IZUFYIp4TAtiuefE=
X-Google-Smtp-Source: AGHT+IE+h5IqDtpRJy7JkkV68W+B/7Y07OzejDyttKKL2A5dsWJktTohH04gaH+fWor1522/X3Tr9g==
X-Received: by 2002:a05:6a00:4f86:b0:71e:3b8f:92e with SMTP id
 d2e1a72fcca58-72469c5e94emr4032671b3a.3.1731608955976; 
 Thu, 14 Nov 2024 10:29:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9a891dsm1607219b3a.127.2024.11.14.10.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:29:15 -0800 (PST)
Message-ID: <d46eee5d-ba25-4cbf-be8f-c0df3624a6e4@linaro.org>
Date: Thu, 14 Nov 2024 10:29:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/54] accel/tcg: Introduce tlb_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Unify 3 instances of tlb lookup, through tlb_hit, tlbtree_hit,
> and tlb_full_align.  Use structures to avoid too many arguments.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This is a great simplification.

> +static void tlb_lookup_nofail(CPUState *cpu, TLBLookupOutput *o,
> +                              const TLBLookupInput *i)
> +{
> +    bool ok = tlb_lookup(cpu, o, i);
> +    tcg_debug_assert(ok);

 From the function name, would that be safe to use a normal assert 
instead? In case we have a weird bug coming in the future, it would 
expose it more easily.

For the rest,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


