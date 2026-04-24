Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E06CFDEE58
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 01:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG5V5-0008BJ-FQ; Thu, 23 Apr 2026 21:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5V2-00088r-Lg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:38:32 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5V1-00047q-8Z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:38:32 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50fb1932b62so32335741cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776994710; x=1777599510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lT/PBlX5fWx68/6Qf0lB19gMmlNpV6+uYAqW9h0JJh8=;
 b=JHOQYUAHX08c+zRPUXOG86ELm/wQLsUvi1oLYYnn47vWHepFiphQGIwGUq80NmkExi
 6hSJPL/X80kQpo0LDHopucH6l1mcXsUr8++N56jAgHSZitcu7a3diBZWcD0Cb2ZossKc
 8YwE3Gz30s1dKDQiQrUKBgetftAFCAAODhP5LAvoyhgiyyUycmNl2fxipdYnoLZZM0NF
 4VjQ/ojTb620VKKAHZ6Yrw0cp5FLyoknv5MifPqj9unKHRrWeTIJsHBDWHomc2jMV0Pq
 E5yoZ08vktmzzzxoJXyARugrZOCVxOnuUihLcWej33MmFuf9qp3c8Au3G1QaHTcgI6/j
 JsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776994710; x=1777599510;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lT/PBlX5fWx68/6Qf0lB19gMmlNpV6+uYAqW9h0JJh8=;
 b=jjM7x3aP4Opa9BSerCIlea6dFh8sto54MsM3pNOX7bL5IznmxnEs6rhuCFID1U3E8l
 y9IIkEOK+rithMOaetFTInsNbGalpVbItC8ob03M4G8PSTcfnwOhS8gWDaGj8lPa9PTq
 Ytk2bTWkAH3H6Zy/mKamWMzg+bKhnGGDsaHnJpMfKIqILSe80iFWIArrC/AekZUZo8p0
 Kd0YMI4x+aUhg4iyFMUzH/s4XIcVjhZnvJqIHdARt6ER8yzcAWzPDdJSxtTZ90Y0zFI9
 IakiMoqDDsrkUZHkdSFxBtnd4oyJ4GxXWNMuMm4s/ujptNIu9PMxl16tIS1ufQ7woDMM
 U+ng==
X-Gm-Message-State: AOJu0YxDQlsfaH8NvGlszPxyFnfo756j1MHWe/XRMa1ePMdZSPd1aywP
 PvQU4Vu3cR6ZT/Xou7pEokcIq/0xzNvMw6EEnhBKEWQpMt7mjHrB66uR0aOL4FW6LsPZACRDcRI
 +J2dIYjY=
X-Gm-Gg: AeBDieuRvUosauyKEL1zQY/zXFHQP8xGaZW8WRR6fBHBRhiYbN1MOE5mQs7uKtPhzyw
 1hO0w/RDtW48IRyOH7U/4AZUfdSYIh0T56Zitmv8Bp1c+psSC2SKUsokl+BxuFyFMLRvkvWO/Oj
 o/ITlqGb6gfEgR67MDwzKjwI/xv1tqzwNytZozmQEaaWifSm26aRrer+ttnXf2aXTzVsjDQrjAP
 NyceK8zar0zc/YndJspCSXLz6N56AJt5w9kZQGrph/vHE7ny2SR3IdjrwqEnFkGoOFSr+WMefwb
 XIVHI48mXnMe9ky19BYWk4Kn+q7XmjsEm4VH9f0K3yNO3Vt7dDRTmlwkxHXEc0MdxBEFlWOrxGc
 5t0TdHaQSgwhCVyrFOWSWzvpihwLlptRoug7CY87UhXVHhjDgawCZ1SQJ8u3dlc3MyCu2lLmMhB
 b4EDBpGU7AOpBKI25E3dmfjm0Btg8fctgnTX9yg87Pb9Cokwm4EGvygddIpBxFggtZodVOUlAun
 rlK++llRQ==
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id
 d75a77b69052e-50e36c8da62mr448068851cf.56.1776994709733; 
 Thu, 23 Apr 2026 18:38:29 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.190.12])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc83bff6asm45724191cf.20.2026.04.23.18.38.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 18:38:29 -0700 (PDT)
Message-ID: <073464ba-0be2-44a9-8ec5-40a45820401d@linaro.org>
Date: Fri, 24 Apr 2026 11:38:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/tcg: convert aarch64 feat-xs test to use helpers
To: qemu-devel@nongnu.org
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
 <20260417164328.1009132-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417164328.1009132-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
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

On 4/18/26 02:43, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/system/feat-xs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
> index f310fc837e0..e2324cef1af 100644
> --- a/tests/tcg/aarch64/system/feat-xs.c
> +++ b/tests/tcg/aarch64/system/feat-xs.c
> @@ -8,12 +8,12 @@
>   
>   #include <minilib.h>
>   #include <stdint.h>
> +#include "sysregs.h"
>   
>   int main(void)
>   {
> -    uint64_t isar1;
> +    uint64_t isar1 = read_sysreg(id_aa64isar1_el1);
>   
> -    asm volatile ("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
>       if (((isar1 >> 56) & 0xf) < 1) {
>           ml_printf("FEAT_XS not supported by CPU");
>           return 1;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

