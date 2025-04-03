Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98581C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0TaX-00047H-Es; Thu, 03 Apr 2025 19:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0TaU-00046n-NA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:03:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0TaT-0002Tm-0z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:03:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227b650504fso14868465ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743721382; x=1744326182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0xmtolrmAm32jjQ/RPNXsGZDR73cYMLEGjI/B+c/hg=;
 b=GSDvIxK6c7JUiyOJe03JfMiFbhI+YYi8i4JbA61yjn2dqlQxXoftGbZ/DzoEUjqdbX
 tXxjpLZ3zOjo+DMzkbaMnPW1mcYfRuj/AHs0Hm6Q0mk8yrmxjlh+j9cwro4+/MmPb2+m
 loIHLlw5Uvgo/Ki5aUMiTiIlovoYKqIwrAyCNMHkA0rjHq2MQu+k1+Wiyx4LeGi6db4J
 +QqrabBWaA2Wk8C1Sdh09C9qY1J3IpFZpA/2wcE4RotT+fLv43OzNIyOD8h4fIyt+0Zk
 tn1nUsLyU7kjU2KJj/E6xCdouItQ+VmIJXgXcgxmhw8mwOzHZKcQwQRGNY9lHX7N4duW
 qAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743721382; x=1744326182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H0xmtolrmAm32jjQ/RPNXsGZDR73cYMLEGjI/B+c/hg=;
 b=RgiUNR67d1Da+rfoBS4YpG0mEqtLKabTkzvETVmBV56cozDnlgghd/1eEMj1rAc1KG
 4/caumSTkdVSH0OArSbi321XYA0sGQ/uHnyraSCYlHkf0UDzIenV/cMC6SXEwUDyRjj9
 026UTRQHMAXGU+qrDhdMICYQTpqVOdk5NxgrIryNduvpPbEokMXxvawvSoFjY/HojYJZ
 QKuaQUoXrcsuxpHxz24I3ayCBOhRFbwWE1++6K+Ngpb4aC+JQ+Uo0/8ftmLVMv8NDe84
 h3esnV6u7aNq+eDlDXvbcPW6RVJZtM1NlKOPuL3UBb2csDPvvQek4ZM+hsE1HcVyiWSk
 Jkmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU325RExmTtu/jAPEo+oYTDrbO7V2VohqxMAVH2VNBgoek8BgZaM9MxqRtWrRdsWZDaCvkFCO9nch5f@nongnu.org
X-Gm-Message-State: AOJu0YwYkjL7RMIQWWVZhNyxt6dsHorhv76gB3EtAboiJej/vT/HnWIy
 3T7t6JNvsMN8ogSYYM3ZcikOXaPb7Rm10z53xuJYXz424j8CLY9aOtZZ4Cvl6Yg=
X-Gm-Gg: ASbGncunG5GVkmCpCE2xs93RlyL4w7OzZx4kUxuwLuvu2qUNju0X2bzFOzXfVs6zONM
 Boa90ImbNrrJ4ABvisTPnhgXkrFzMbtB02Swv5qUTjseGyfcdBx2lHlv14+oVcO9/r+b8sJMdyp
 elnO600w78a756NWyDV0Y9Okyu5OvuxWt7tOdICAozSLj44GV6wyy7rdo4AkB3t15OuYhy9zjac
 6a6gqlcAxyVJHBMyHS1xSGw9NdbQs89wx35nfuskAspfGoYrAONj9QTFVaXWsnxsczdDPUuA6+E
 lMpFAAjzD1ED72KWtZg0byIDxPD/INhxAs7ceqHazhPR4082M1FzpEvhpHcxUSzf
X-Google-Smtp-Source: AGHT+IHBNPt4JCg5rp3hLHCHcYOTlcF6Q4crxqfPJeOEPSnrXNkNDNEwuAZBll7vlKXMLDa9mYdYPA==
X-Received: by 2002:a17:903:1d1:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22a8a06a5c3mr12550755ad.22.1743721381705; 
 Thu, 03 Apr 2025 16:03:01 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297877273bsm19938475ad.220.2025.04.03.16.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 16:03:01 -0700 (PDT)
Message-ID: <6bc1e1b8-93ad-44ef-8c7e-9cfe988cb7a1@linaro.org>
Date: Thu, 3 Apr 2025 16:02:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Helge Konetzka <hk@zapateado.de>
References: <20250401144332.41615-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401144332.41615-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/1/25 07:43, Philippe Mathieu-Daudé wrote:
> Be sure to allocate the temp frame if it wasn't.
> 
> Fixes: c896fe29d6c ("TCG code generator")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Reported-by: Helge Konetzka <hk@zapateado.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/tcg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e8950df2ad3..dfd48b82642 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4671,6 +4671,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
>           ts->mem_coherent = 0;
>           break;
>       case TEMP_VAL_MEM:
> +        if (!ts->mem_allocated) {
> +            temp_allocate_frame(s, ts);
> +        }
>           reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
>                               preferred_regs, ts->indirect_base);
>           tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);

Queued for 10.0.


r~

