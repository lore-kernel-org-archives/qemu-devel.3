Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6DFAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjnY-0003us-Jv; Wed, 22 Apr 2026 22:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjnX-0003uA-7m
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:28:11 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjnU-00020Y-MF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:28:10 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-50d6b9bca48so4187691cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911287; x=1777516087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p811x0tBKwQzxrYVtB7h7+KXKv2MtGby1ypB9DLPRyI=;
 b=qM5akEdpkVMswB5UnlNQjIKH127GQ3Sg06bqNH9B3yi6iPRPDA9S/MINf8Kelfp22c
 2RjPhuye7pEnmMbTQSl0UsegotpNc53NlPIyLib4ZbmlghWjMyTNgtC9uYTVXvx9N6Fp
 SXFGkhaGKGN7dcAWPxwEY4RqE7fmiUytGeznCX84qUWzhw/QTnDeDEFDlHlEYpp6hjmI
 MyQmyDwNxTLnQGE/yKg9Ys3s7hsJPJftnXjQI9tQDpSsnDP/rFBC2Nhxe2HD0gFiWKH0
 oH7CrbxCTFqI6dD2WljL+mISO4AZz4e35rwkbe2xFG/Mn6aAVbtOknE5p5OO1mhdg4g2
 aaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911287; x=1777516087;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p811x0tBKwQzxrYVtB7h7+KXKv2MtGby1ypB9DLPRyI=;
 b=OlsORBAbFY3eogtbegTj4nnMJW+eXu+J8Eler/aFkpiUvFOw4UeRDbb+uPNN9oDVdY
 qOw8GZ+1fNjfZ5pzV3ANVz1NoSAZ1/CtaUQKbQaDueM85ezXDL/ocCO8mMl3MbXxQm4g
 vgNwLRi+KhQuQYZSt4xLBdNB6GQOW7MneTT1dRcnwKJ4vnnvs3EpKDmGdBQy03q74Bk4
 EmuRJNlXajWXk0mwETZo5273QRaVa1pZUGVlrDDYHXWjKLBcmNarhV76GWk6FNAy672e
 3/ezkdDkrhwN89l1sdSbTHmmBfZV1vs3RxS5wdStAAJYOrg5w6rF4X9b8FEi0VqDwLmd
 RSwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FiHCfFUuV8IuEPF9rWwfmTTQSc01bd7EUfcRA07pAAvwxpl7y/LBNRsXnAVD9I6t6+Kc+jYBupgBR@nongnu.org
X-Gm-Message-State: AOJu0Ywq9wfuwpuW0Cnk/VEu7OepoVWmiTWMuvXLfys+/jwG7fpr8uC4
 9RL1hgZADeFbYPvkiXqy+EVjgxchfaoqz2l8rYOSvBmgTM/oWG0rUhrbB/6RmWN9CBw=
X-Gm-Gg: AeBDievWgFfl8lt6OGhVAqaiu9uL/jenngBea9XVyeaQJYREVQh1bpOW/ZOoVjF0s/r
 7Ax4PZIHMluyCn9ACRgInAZ842YHhjILSOfj4f+RigDuOqv1DvU7rs/MrjMY33oKlvmyENYBcqm
 CaCEhxiK8VV/zhfJBWWxzvpJqaFSuRUakAQ0yQuuSWtJkXOLsGaC35d6rLsUBLtKLoQSw1rt6ga
 /6pQepxVNgw/43dPmTbWUfeADsC/earLr3QklLz6PjAgYkJQoyHFlEYK1H5qdTj1qtiDt5GeGEE
 pyWzy+ZBSYlIjiwW/LcCo3VYAo8P6XNDMQ/KP2G/yLTCj1Pw9dxlAX2t8pvzCsZoLf8Vybory+x
 wwy6vJKP0YUtrlBD3GM68gdB94/mqbSwxyhKETtz6v3aA74WiwcoPfPNQ7WK9Uin+G0LrQQlQML
 Ugym1b8WnODBL563UZ01/HgJviCG7p8MpNWyoNd7A4nPmrPrf9MZXvOJ75bcPWKhDpN0Gbfsppy
 3LcwJE6oKWEV1lSxy1t11Sswx4P
X-Received: by 2002:ac8:5890:0:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-50e36b44bf4mr380224581cf.18.1776911287092; 
 Wed, 22 Apr 2026 19:28:07 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e393ff941sm151442661cf.19.2026.04.22.19.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:28:06 -0700 (PDT)
Message-ID: <0341e3ec-a64d-44f6-98a8-1c9862c0ecc5@linaro.org>
Date: Thu, 23 Apr 2026 12:27:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] target/x86: Make get_phys_page_attrs_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> For x86 this is simple: we just need to stop rounding down the
> input address to a TARGET_PAGE boundary when calculating the
> result to return.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c397a6fde5..108b02396d 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -372,7 +372,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>   out:
>   #endif
>       pte &= PG_ADDRESS_MASK & ~(page_size - 1);
> -    page_offset = (addr & TARGET_PAGE_MASK) & (page_size - 1);
> +    page_offset = addr & (page_size - 1);
>       return pte | page_offset;
>   }
>   


