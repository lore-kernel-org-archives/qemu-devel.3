Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF22C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLx9-00036c-CA; Fri, 25 Jul 2025 13:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLx7-00035P-7j
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:11:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLx5-00055R-6H
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:11:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23f8df98e41so20906885ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753463481; x=1754068281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfO6VYaR8QcO9j6pSNec1EV6+ztCInL98SlaMcONWk8=;
 b=jcAE0wqok6bom73vL+1UD+/Fi1uLe19rUzcu7Rb8LoeVQvBOlgwJW8m3UyKeEB+U4W
 5c+0JYhK8MgUI4OS3gqcEYP3FitqBpiJmaIsy3016WfOy7pBxcKnBzVPMc9SL2XAzHxM
 8KVNhlfC8OOv7sk2XwrZOeyVQryj9dUdewKXFIrY3V5hTDni4veNitP13IgiGS150Rbb
 TnUe9BgoscFM37qW687K9ddZOMs+V37Q/ZtkhyhZsm0ChbxORvWeosqGiskYbMYQm5el
 Dttz4GCFiosx1S/DeUhkJSRh/Di+aSHeEOcFsd3uPRIAxuPxQLdPoEdN3y+EJ121QBYj
 VfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753463481; x=1754068281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfO6VYaR8QcO9j6pSNec1EV6+ztCInL98SlaMcONWk8=;
 b=s+LEOcrmCYQ/p4s/8XfI5Z4ud0yKSMfoR/zNRpreArAeEynJuzz0h0bg/xGYMaiiGB
 n3ElySDbySx0+QGt9zHVUX+gri3yChMR2AH34uxUZ40uNvA04COZx1IhahgtbWV7Nklr
 3WfFhPBPKM5m3q5acwD+o6YS9VKELrtk6mA+buTNQGpilaNV3Nk8bb5ooYdwDo6dm7z3
 sCT5eyHUixSaMGNP1efNtji4PxK/tra/23Sp1h7L/mV2bztfL+WRUIm+Rsq8ampZ+FOc
 9c4wgxbhi8xmpqLz0MYkIM5vFRZjUND/Ph/JDYaByGKP9ptErv6fkTjve6h90/9HV/rJ
 I3MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9K3/2hZTZynKVNUwGc4ZwGhTyzKblxrfnwS98t9uSYOcOFfhAnmzIA8vKoz3hURvgYeEXl7oFNnB/@nongnu.org
X-Gm-Message-State: AOJu0YxNfQJmOQBYQdDbD7lpkPYvaSLmtv6lPrMOBQEZWX47sEYiQzu0
 dyowWcyIHk4EdNu+pfDXSSzrEP4tFQ755K20iXHgVHiTtKFgEsBnx8ko+uhhMN9yjD4=
X-Gm-Gg: ASbGncuZMLvxXG5erJnhfcrSxRpaoQ52S0beiUG2HdfAgmpoEMaBfmdQess8MQUAX7x
 sFmpTVOienHClS8otXVVmmVh/D06sBhCziNAyCgz9xRZaMdjQfEqkFzwrHSLHvQgzDnRVcdhYg+
 QURnEveO2nfPZapHJWlgUgJ7FQ+eVYuLoBZpgPUyLZ02DCJpfiiKdGldH+l6dZPrx9WhFEBLCX/
 R/bdibbeXsFGHUF9hBXX/rhIagqz8V1Ul4D+IFDrrLCXN5achpkWSlT+81EucIrDBFtF+WCUbkm
 o0b3wNt7sSEYivNG8Eg1LbiSl2NYFrNTrAr7pajr2JBtZ8eBmbodmYuA8+wMQaFp7ZYMIk74xLk
 vm8PC4kHFPgZiMHwSm34DGdbQow8YtfXjqsU=
X-Google-Smtp-Source: AGHT+IE4jcDvUtmPvPLcBORp9NDUKwJG0bF8k57DF13kbnjfsYoofhKMT96aIzLBjInn15Z082MW3Q==
X-Received: by 2002:a17:903:11ce:b0:234:d292:be95 with SMTP id
 d9443c01a7336-23fb30e7f54mr39334995ad.42.1753463481035; 
 Fri, 25 Jul 2025 10:11:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe343aecsm1573705ad.78.2025.07.25.10.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:11:20 -0700 (PDT)
Message-ID: <6f24a5df-d191-4581-a02d-753a98c6bbf1@linaro.org>
Date: Fri, 25 Jul 2025 10:11:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 1/2] linux-user/aarch64: Check syndrome for
 EXCP_UDEF
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250725165106.37105-1-richard.henderson@linaro.org>
 <20250725165106.37105-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725165106.37105-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/25/25 9:51 AM, Richard Henderson wrote:
> Note that we have been passing the incorrect code for
> uncategorized and bti faults.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index fea43cefa6..43a471b535 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -32,6 +32,7 @@ void cpu_loop(CPUARMState *env)
>   {
>       CPUState *cs = env_cpu(env);
>       int trapnr, ec, fsc, si_code, si_signo;
> +    uint64_t addr;
>       abi_long ret;
>   
>       for (;;) {
> @@ -63,10 +64,12 @@ void cpu_loop(CPUARMState *env)
>               /* just indicate that signals should be handled asap */
>               break;
>           case EXCP_UDEF:
> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
> -            break;
> +            addr = env->pc;
> +            goto do_syndrome;
>           case EXCP_PREFETCH_ABORT:
>           case EXCP_DATA_ABORT:
> +            addr = env->exception.vaddress;
> +        do_syndrome:
>               ec = syn_get_ec(env->exception.syndrome);
>               switch (ec) {
>               case EC_DATAABORT:
> @@ -99,10 +102,19 @@ void cpu_loop(CPUARMState *env)
>                   si_signo = TARGET_SIGBUS;
>                   si_code = TARGET_BUS_ADRALN;
>                   break;
> +            case EC_UNCATEGORIZED:
> +            case EC_BTITRAP:
> +                si_signo = TARGET_SIGILL;
> +                si_code = TARGET_ILL_ILLOPC;
> +                break;
> +            case EC_PACFAIL:
> +                si_signo = TARGET_SIGILL;
> +                si_code = TARGET_ILL_ILLOPN;
> +                break;
>               default:
>                   g_assert_not_reached();
>               }
> -            force_sig_fault(si_signo, si_code, env->exception.vaddress);
> +            force_sig_fault(si_signo, si_code, addr);
>               break;
>           case EXCP_DEBUG:
>           case EXCP_BKPT:

It may be worth for lisibility to extract do_syndrome to a proper 
function. It's just a recommendation though.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


