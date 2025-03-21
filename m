Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011CBC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveQd-00007z-E7; Fri, 21 Mar 2025 11:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveQK-0008VE-JY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:36:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveQD-0006ne-Qm
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:36:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso35363715ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742571389; x=1743176189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1XrcnI8/sSn+DKJfn9g/ACfk6EsflbS3NmSa9fiFXcQ=;
 b=a+QczoIOY2WEYZMq5KBw78enVMkQNZ2DPGoZORQUlDfSt2LWgbdJ2CEqIIhuKtlSTK
 8ZfGdLhMng1LnrQWGIhHddb+PMnGNknLyME5yb4G+sMFFae1/J/JlUN1CSfUpFEv7Q9j
 jDK2OnaRbs5a4lbAlbriD/UJQkyzY+MtmDaYWr5E7+3hqnufoWcWRFlMkDeWujG3rKZm
 58BtWn79eX7eaXuDUoKjc2hp8HR1+GctQxVMl/Y5JFF98qp+d1I5fvM8qjlOKiqymr1m
 9KVZyQmliHzaqh8w8Ax3VAkE9ITAIZassRq3qOjESR8YFfCfUZTKFZrUY6D9jVDv9T1Y
 +yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742571389; x=1743176189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XrcnI8/sSn+DKJfn9g/ACfk6EsflbS3NmSa9fiFXcQ=;
 b=JxRByUFIWKi4D1WgEKqrxU3pbJMO8DfHJ2luuiKj4hq7G31W1t5uhK8i9jI6TIj+P7
 ADXxe1XSdBeCff0rq8gXtEP9XhSyQjZQZIM+CbgG75KGKx32Nqw0x/9v0jIivadJefPn
 ecVEpn2pcxToy8kbHy54ImFSTYGEyRXLBCyf2YzFlnr+s1wSKUeMzerWLCsa6IYaxzr1
 yQUiVlxsy9h53qDt7eGTs19v2RcIKJzXttUmcp5z84u/aVbD4W9E9avp9Ce0pyCS9AIZ
 m/i9RRu5S/OcljIpHWCqENpxDj/AG+WSbO7Hk0FqT3ekhP/iXsxRzeOD8ww9zEcUdzca
 kdYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5yb8shX5OMFKrFuYdYKoimVdikfH7Spo5BUm+9MRJchmQMqhyduD204U7kFYpg9sqbzNgtqdJAm0E@nongnu.org
X-Gm-Message-State: AOJu0YwCUap0orAg8XNsqeOGz91IISaMN/ZqmTRv0JruLkootNcuKY/Y
 dyiAhZtTtBLgd9cmzOOHMxYOiyHMx6Vuek4RknUT8nSTkum872VrudiHeohf9P0=
X-Gm-Gg: ASbGnct8NWKptUZBIMiX3sGc25QAAr22g3blaSANGBmi6FHgBukK5aE0pgw41BRBZFv
 PsblR8kpnTIszoR7P7jscoyhb5GwtNWO27LRJztf7Lfr0ncbwE4e8RkZ7mMnNZST/yL8DiKw7l/
 ilmNtEy8qDWK2JPCLmey1y33Z6f+kQX3A+ks1GKiQa7Q1c5RIoBsuesZ1Wq0CKzyDd/iQ0GxaFG
 7gkABP6ZpscwMh1u0W3hxor9mgCI2VuuiQCeiRMCTSOTXE2HKY8oB+N+G4PWL9+ulxffDmTynPI
 BPvj0YYIDDD2My0xAqyQHgEaLb/8rZPU3/BnHHpZFPkkpwHjDUE+ugub2hkfXE64rORg3TO/lmd
 S3YJaHn8c
X-Google-Smtp-Source: AGHT+IHJWViTwcKfPKoLy1dU4C8myvJLYRcls55PV5nSU6Vmh6oW9S11ryDhM4HtSbU3j2AR+5qbTA==
X-Received: by 2002:a05:6a20:c997:b0:1f5:7c6f:6c8a with SMTP id
 adf61e73a8af0-1fe43311d2dmr6722330637.35.1742571389478; 
 Fri, 21 Mar 2025 08:36:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a28467e9sm1611739a12.37.2025.03.21.08.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:36:29 -0700 (PDT)
Message-ID: <85f93712-7612-4016-9fd3-4f8f135da95d@linaro.org>
Date: Fri, 21 Mar 2025 08:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/30] exec/cpu-all: move cpu_copy to linux-user/qemu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   linux-user/qemu.h      | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d2895fb55b1..74017a5ce7c 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -32,8 +32,6 @@
>   #include "exec/cpu-defs.h"
>   #include "exec/target_page.h"
>   
> -CPUArchState *cpu_copy(CPUArchState *env);
> -
>   #include "cpu.h"
>   
>   /* Validate correct placement of CPUArchState. */
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 5f007501518..948de8431a5 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
>   #define unlock_user_struct(host_ptr, guest_addr, copy)		\
>       unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
>   
> +/* Clone cpu state */
> +CPUArchState *cpu_copy(CPUArchState *env);
> +
>   #endif /* QEMU_H */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

