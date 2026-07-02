Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1584DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKG5-0006AL-R3; Thu, 02 Jul 2026 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKG0-00069c-PW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:27:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKFz-0005PY-8G
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:27:20 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-37d46e0d246so1771111a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783009636; x=1783614436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZN0bo5keuBO8kYNz9WvNjsEhWa0Ovogz6Hq6qNVnrq4=;
 b=Yw68K6W1E2jkJxf01pA3zYdziklPCQwTZnAnm/gBPEtv6zaWPMLOX7nFWeBlMcENAY
 OI7ru8aopotD98PJe+vVl60V4FHVGoaKvVSNlP0ZXE4pf6isyOwC/oVuIHSamLs88GR1
 msdBlTqDdGkAneVjjZbB+bB0xI1QW0l5M+RX3nW5HXHHsOzs4OOQFjIBgyjN8NzvfbNu
 A3QpYzSmHhxj9Vs8YHF3sqif/8Nf8BwPRArUNA6I38pN8VFyxL6rxv/E+F+MzOIwziYN
 pOi9f/0vbptcbgitCNZeR7u8mZXuOM10yYgXKkN6G+d/z52ANL+ZABTWH+Fo3I/fYvhw
 Je/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009636; x=1783614436;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZN0bo5keuBO8kYNz9WvNjsEhWa0Ovogz6Hq6qNVnrq4=;
 b=ba30xEYZMQtJtyElH7X4d8nfHD5HDyowV42bgZ95VHkk8dNyQVvNXnnrhDDGVsEiL0
 bKVPtOCBuy+vQ7BMg1L+NEQxDE27chkG9uUvlJ1fk2My4Y8l0aDswGbJpqHqii6QDMbn
 8oG6tq/E9+2mTu1WMS0f90ii8zjZSzu8WzGSDmUqk5vVSXL/y7dlTvAU2HXmXam8vNHI
 UDV3guWKkwtyCCeG0Y28qSGrQ3JdBGjtzzzDSefbK2ptr7IT0xConYIy4fV7ICrFvJ/P
 jOZfwWkfcCOZfg98/z0pIiruFUn/vNKyV0IhaHIM2Ig/rNrtCJRS3IM8XefrhnAuoXPC
 zIDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVFhlIsQsrMTM8mdQekQQcbcCVZr0VyvZ1IeMZVWc7Cg2dWvKUWgmlpyJTN5IxHABv2YeCeQpeQfYb@nongnu.org
X-Gm-Message-State: AOJu0YzWAk8iSCwyGLe1fqQdwQOhOqnGF5ED1uMvwGJkTAqJSDYu3HQ0
 7eL2kdHUXcKMBiLvKM8nuAnyRad4TUkQTujeKQo14duhtCQlyWD4RqGPMogAnOpEg3c=
X-Gm-Gg: AfdE7cnKfecbtkIfE/9kWWUGgf17JInmUK0SPH041viv0/++/0b8iFmM9obh6ymiWHC
 0dDFkodnUpfsveEpHUBTZySQuMpNjpSLiFPG4O0JO6x1L7zugAlSWQqdQXaFYfFG42mN8TN0gCH
 4qIwnznMB7NZwCcuMA9350FM6xztWTxuwH3DHgqtCA6RVOnGXaCMhCdE+JAF3zO4oHn7GG8DIza
 UnIWnSyIycBTVNGM15T6IQjvccnoqUXoqIIiWTHP1Cl9No9gEqVMoyrMKIdpOtVpA/tS1Goo46U
 hKrlpqeN9A0yDkujbLzKW4OelXGhWF6l/cLaq2ILqIy694Mv52g4kv1oj+/NH7yB/jgE2KzmcNW
 I5AaiixoaRpmsWfb9PKJbxxYYZn8jp3rjTSTVZ0hham1kTusxDfL9wCcy7GccUg8orHKJgckAYm
 YGKYP6F7QFgjA7uqTeLiC3Q6NNnusffOKdzpcIbsXSU1TpQAXSd2RSRSGDJHlnZ+BaDXU1
X-Received: by 2002:a17:90b:574d:b0:368:9da3:c496 with SMTP id
 98e67ed59e1d1-380aa1d3e7emr6665098a91.24.1783009636401; 
 Thu, 02 Jul 2026 09:27:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380e146f9eesm1450856a91.0.2026.07.02.09.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:27:15 -0700 (PDT)
Message-ID: <715e4e05-1ff2-4d06-9d03-0a5ba7da1faa@linaro.org>
Date: Thu, 2 Jul 2026 09:27:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Common vCPU cpu_post_load() handler calls tlb_flush() since
> commit 9656f324d25 ("Move interrupt_request and user_mode_only
> to common cpu state..."), no need to call it twice.

While that commit is where things were moved, using the modern function name would be 
helpful here in the commit message: cpu_common_post_load.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/i386/machine.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 1f5c517e562..df0e0c178e4 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -401,7 +401,6 @@ static int cpu_post_load(void *opaque, int version_id)
>           env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
>           cpu_x86_update_dr7(env, dr7);
>       }
> -    tlb_flush(cs);
>       return 0;
>   }
>   


