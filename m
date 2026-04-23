Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F210BFAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjrw-0005rc-EI; Wed, 22 Apr 2026 22:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjrl-0005pc-8y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:32:35 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjrj-0003O4-7B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:32:32 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-50335b926c2so47735251cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911550; x=1777516350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yoR8Sg0gO1GA+WNZeZ9F9igNGNy1Be3/WnfjaXZ+AZo=;
 b=fdYJGrqM5xjEcqBPMqnH2RlONuTnvthDSzav2ieILKsSxBczxxayxmhaUQut8RHdko
 n+kSI1ZhHKDNCzuP8cNjYE5RDO/M/3La++4Gf+HqeOTFtlSR4y0EBm5yvHBVo9WzgFi9
 HAVUrPYhUDK6S+dp3LARCOWnp8VpzRc9SlgrcIXPI/7fnlNvp7sdG+CPMCYgswB0nQSY
 jgvsSAV2BEZsgIbLjAnWA/L3LSRohBmO1an1yvk9AsBeM1kJm53IgWBGasvCYFtaYk7A
 cQ1Cj7md2Mahf7qA5tOFwiBDcjyJ/Tu71maA+e/nkPON6x4mo/bheFsSPjFACtrxjhi1
 VV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911550; x=1777516350;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoR8Sg0gO1GA+WNZeZ9F9igNGNy1Be3/WnfjaXZ+AZo=;
 b=FrWDbLtbjP/iOFnWsePhGITj54OCn77XNWmiPBX2geehzVAeNqhH2EvkvQ1KWdXxvx
 gKJ8DUDJRYojVtmQvXETFoQDjmJyJiP7144CFqRpSc8EmTnktQty6YTtLnia23JHKkpu
 /sa/VW3CtrtF01S2I/CmhoeROROG5KMLXp8xjjppPeCpisrUo7RS83PhcWIaDUyhmsTF
 y3C+Q+KvItkRwPT6RGDcutQz/FWMJnXBSTNa3BTcPk6OWDNF5eXLpCWpIogH6j086PlK
 2Vjr5Qogk2HXN9A1UK+vPlvZl6mLLKvT/7k/XG8Np6q3Qyk/bc07e7Rn9rtLwlGvlIoz
 TVcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gDZpINwj+nQTSf/YFZS9QAL65Gj+U+WwSuJyKPz85BGpACxOeNA53DffsJdpWQS84Tq5mVrzK903s@nongnu.org
X-Gm-Message-State: AOJu0Yxakn/fFdLoENtXx1/IaA/+4eUNAzlYIbqE6v2zz8vwYiT0hsiD
 VcZ7Ptp8+3f7p+hrj98D68VOKtxDLfFFoODyorxohuXZquf70akh3QJ3UYZd+srfP/g=
X-Gm-Gg: AeBDies3dUdTamQ44lLSARaqRrisZfzO0F7jtnbgDUY8sq2vqCLWi6xS2YS0tJO/rBK
 1zGQW1NoSMEJIKzRCR6i0z8HspS1tupcHeA9BjOHGnAfv8D+f0LD3cDUFxvStQodr5efqgYCj1o
 J3LL15lBOj/vMy5KK2kuNGpOPYpJteWcGYd1UvPVjMLCQl0vvWvfjrDx3b7jySC3Cvvy3nXPb04
 Nj2CGMoX7D11snUkxsomBsZGsPOZYG976HcVlqT83TgIKnFwyptsgjpzNyCrKkrD5JCXSJPwuwS
 V6NoDUucG0azMVwqiJb8J51f90HbYoF2n2AF1j1mTxhmItx82fMzGd0a0o9V3ESQXJvncVZ/Iiu
 5Wh2n/qYreth5ymZbUGRHP0dSCMH9y8aAQx9t7pVWNzSNYO+mjfWiA79eOv/8pmaLqSlJe6Rr5h
 h4B+jWevq6x0W1BEoSyHpiDvhkeYDp0Y0fJZ7FGQxR0zGhoEP27ioGPDeDF5MPKbpgwypJUzaMS
 FNmeZUbmTfGSQsRO6f6X5+1mAj3
X-Received: by 2002:ac8:5889:0:b0:50f:135e:d5d with SMTP id
 d75a77b69052e-50f135e1247mr190131461cf.8.1776911549827; 
 Wed, 22 Apr 2026 19:32:29 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac42586sm149971606d6.8.2026.04.22.19.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:32:29 -0700 (PDT)
Message-ID: <71a08aec-1b1c-4646-a6f0-a24141e30305@linaro.org>
Date: Thu, 23 Apr 2026 12:32:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] target: Rename get_phys_page_debug to
 get_phys_addr_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Now that we have ensured that all implementations of the get_phys_page_debug
> method handle a non-page-aligned input and return the corresponding
> non-page-aligned output, the name of the method is somewhat misleading.
> Rename it to get_phys_addr_debug.
> 
> This commit was produced with the commands
> 
>   sed -i -e 's/_cpu_get_phys_page_debug/_cpu_get_phys_addr_debug/g;s/\<get_phys_page_debug\>/get_phys_addr_debug/g' $(git grep -l get_phys_page_debug)
>   sed -i -e 's/_cpu_get_phys_page_attrs_debug/_cpu_get_phys_addr_attrs_debug/g;s/\<get_phys_page_attrs_debug\>/get_phys_addr_attrs_debug/g' $(git grep -l get_phys_page_attrs_debug)
> 
> which catches all references to the method name itself plus
> the functions which each target uses as the method implementation,
> but (deliberately) not the cpu_phys_get_page_debug() and
> cpu_phys_get_page_attrs_debug() wrapper functions or their callers.
> (We'll deal with those in the next commit.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

