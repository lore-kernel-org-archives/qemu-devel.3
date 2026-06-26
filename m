Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C61C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 22:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdFSM-0002Sr-L0; Fri, 26 Jun 2026 18:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFSL-0002Qi-7d
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:55:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wdFSJ-0008Oa-AZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:55:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84592b55832so786857b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782514525; x=1783119325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCAnbUCnMa+qMLSmwnODeeup7O8oGMDV35YTT8MSyjU=;
 b=M4uXSGpWoCl3/YRs/ycmL/viFkFbXMqhyFly/RAkKn8BaBx4WNMyaYL0Evnh1iIMJJ
 tR96mdBZ5R0mhLXCi2QqjqjhZslIRmw4Wl8DtQWQYxMRJJEO7Ils3f2Qab/F/GoKPg1w
 OC2Atg5EQc2L00/9ThJz27lrrTjmjlxH+Q6+jO1e5eHbJq0SDk6jqYrajDEjkUFw7DpS
 gI3N46/geMqA04GyDZfNfTaYlkOgLEhTh5U5Q/kNJK//nbTq5FPPIaxUWJ3ijnTtxUSd
 4PINGTkQWOvC7eNXl6hSYTl2udMJ9Dh+2vzf64Hie3WCQ31MxJIKTN2leCovLcqR5Kks
 /FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782514525; x=1783119325;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCAnbUCnMa+qMLSmwnODeeup7O8oGMDV35YTT8MSyjU=;
 b=Z7WgdsI4ONHFS61iFOczid32C7I2+24BhJVXPszLX+ldw5lbDPPFGqajzvMN5KcspM
 e9A6Vb6p+k7YqxoXuB3p9B/FICLThD/MePg+dIWxEUuc9vnoZIQo5afhMkZaEosbAhWQ
 YZlyDzgmo6Kn7SKCy04lLIoyNXsw24TnecjtUUzV+T7FHnya0wqChAf4rw4OJik3FyWN
 tWc+33N6xXMre/Lbh+JWFqHHZEuZA4oPyJqziPZNd/yJbJdrg2TpdysPf9rtlB1pqec7
 413vpovkYKTSqVMGHlNY63X0RhVIKyjgDlSC5WgaAG0QKH432w8K/NFfhLoDWZlbKrgL
 R1Hg==
X-Forwarded-Encrypted: i=1;
 AHgh+RojH0UA9pQQ9jCFB0s4MTsvk6no9EMjiwGEhku+il+IBFj/GKzmIXFjuX7vFXGtEtmpYvGlYwIOC5bT@nongnu.org
X-Gm-Message-State: AOJu0YyeyAWw+UVfbSXWr3N1Ti1mgFUEFL9cxz+0L5KZyhbLwSYsIZrF
 Gn4wsd+auEVYp8TI2ybgM81ZpqL3NWf9nceHH5YhnxbxYiGZUUnd1EF007Qwq2xHm+8=
X-Gm-Gg: AfdE7cm29ndQyqsFj7QSagNdqym6TVOeWDD5IPWCtZf4UsvyUnpwT+luuNvzvXsCrSp
 q0GqytGGvlIQqxPI+5nOcQm1ILpC+B638jGx8xK2wqRe0sD5Ay6jbLRjrM8+1OSN6dRHhrXOpud
 pdig2nVB3CCaAUhvLdcBAQd+K5mW6XWP/kU8WYThytY9SH9175hXZIJ0Mm7ohO7Z9EBV86Dn6Cx
 VA+tnCQDTHcDaIJHPyeaolaN/prUjN8xNbP4/TVkqvY/hWGeItsT3f0LwQH1ULrDV91wmKgC1lu
 D8sUnWWL7NxQ5ynfWWRDkJ41jylY/2+2YCY50duyyx6IBhm5Pl/JOi79jUrj8v6k4w+LBE/J+S9
 oT+zyZT+V6gCxqFjHw8h0acAbiyDkYEyRuWfoKqxq9oS1RWlTyrVQfgcVXix6yx8rHgEb0kLfZD
 dFWMk9tD1ZHZck/cSC0Rc+XFh5ScsUXFehyrpNCEsp3+lYkdqUCxS/BmiKHw==
X-Received: by 2002:a05:6a00:cc9:b0:845:ce2c:2a2a with SMTP id
 d2e1a72fcca58-845ce2c305cmr2939902b3a.6.1782514525376; 
 Fri, 26 Jun 2026 15:55:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fec0f7sm7360946b3a.22.2026.06.26.15.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 15:55:24 -0700 (PDT)
Message-ID: <854ffb2f-a363-4c69-9a51-95151dfff517@linaro.org>
Date: Fri, 26 Jun 2026 15:55:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3
 is present
To: Oliver Upton <oupton@kernel.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260626203639.431191-1-oupton@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260626203639.431191-1-oupton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/26/26 13:36, Oliver Upton wrote:
> Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
> on -cpu max gets stuck in an infinite loop of stage-2 permission faults
> due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.
> 
> Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
> value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.
> 
> Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>   target/arm/ptw.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 1470de3010..4a7aeb140c 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1414,9 +1414,13 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
>                     PAGE_READ | PAGE_WRITE },
>       };
>   
> -    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
> -    int s2pi = extract64(pir, pi_index * 4, 4);
> +    uint64_t pir = env->cp15.s2pir_el2;
> +    int s2pi;
>   
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN))
> +	pir = 0;
> +
> +    s2pi = extract64(pir, pi_index * 4, 4);
>       result->f.prot = perm_table[s2pi][2];
>       return perm_table[s2pi][s1_is_el0];
>   }
> 
> base-commit: 8f1d3b586f1265023f75ea9c227c35d463321aef

Braces required for the IF.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

