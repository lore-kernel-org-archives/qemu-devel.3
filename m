Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B19C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrsz-0000rr-Ej; Tue, 28 Jan 2025 15:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrsa-0000mP-Mp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:08:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrsX-0000wC-Fx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:08:10 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166f1e589cso39844635ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738094888; x=1738699688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8vGqtwH427Yn7WVK0Iub56+XP5B5P3sodKxFPk8lOs=;
 b=k5e1pcGTGguCDOaYJhay3TBW0zQkUZUyj1trrkeOYHFGc3Hg8oMTf1OwCnpwS2kF2D
 x5NTH0/G/mKItYjkPkIjhaQP4GbvIweuenqefbGvNDk7A4n3vzFhgnYWkCS0CQIbjvwN
 S6Mt/Y9ofAQkY6YKP1hlN8la7ZWYGy+GvTSTa0y5XZoqwOQEAxZE1bvnAq8q402th1/G
 hep92rrjVt1FwAwTkh23SSOsEhE7dFZhPSiXedeh/byBtrvIXjWHOUdhRiomEKCZt2M4
 oMUOx//bcAX7mI9AYyTeuGLyIXupmhFe3WtQW1r2ADH9Zso2eTGqg0dLBAqtGB2IL7lT
 FmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738094888; x=1738699688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8vGqtwH427Yn7WVK0Iub56+XP5B5P3sodKxFPk8lOs=;
 b=oayruBXSOd9lArkET/jJfUUKjq9pkVz6FPwrt++xeNMBjx7JBSOWfvwusolBH7IrRU
 dq6bmmEc8jfWK8n/p9RKwJIbRkUq4zhwro6Rh2DrZL+f+yRVkims/fTXCBN/oYhaZtIE
 PYprkkn/mqg1y66erigICcs4XDN0eG/A7536Ju+KpzlvskPveMZgT9lukpICna9QiAKt
 KVt0rp+g98GHr7L6kEsJtfWvcs+q76ql5CITMsAANGDDdNvUITRlWbKmWDpDRER8aRab
 Hgsul0c/xX8sdu7beXZqts1ZzlaOKo+KNc+1YufrqCcAeXv/HPjh3sQRGWS7MFAIax1M
 R/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeGE1og3LWKeP2UaTPageVOVzJr6D2yQaxjy31JnXeG6HylFmCiqXP0qsF35mlAYd9hw2Dqr5nPj0u@nongnu.org
X-Gm-Message-State: AOJu0YwvR62/5ejLiDMvkFfQnjWCzUkN8N+VjfwX/HOO0Aziecl96Tvq
 c6rRRSmm2yafNXZfiySIWLXJ2g7jscT3HUry3bgUlWgxPrUcYEpDaAws5N8nOj4=
X-Gm-Gg: ASbGnctrFn5h+SZOktMeX76Vo8UctmoLT+qXSynr2OnTEXrfwpTXxXrLxBjH5fPtvjB
 nQKzNnYVOiFi6tpMYirYOij8EnqWIKoEOss8sMdXcyQmNjbGw9rZ7TDF95s9X4tUjZG5+RBrXxS
 kMtblUuj/KGiBgvOx8ZI2L9VwIsMU7e0O/9NKYf6KsSy70GA7r+oMi1CttBkAySl1TIEetm6SPR
 bdeayMwmpDwRFRe1hb89++TkyoxHYCun4ZSLfIdkB82rIoUNHvGYD4WvbYb210+h8kOsEPQcN/P
 0I3ZZFMSl7owTX2oYBqi8Znjc78JBmKsMli7lqh/JyzxLjgksJJwxYmYEw==
X-Google-Smtp-Source: AGHT+IGMvh23YHN9jSB1IcuWrcXCloNh/Nr5McHWBP563Xec/Hb97vfJ5XMCLdrcZfwy9/Eok1nQUQ==
X-Received: by 2002:a17:903:11d0:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-21dd7d7887dmr5588555ad.24.1738094887954; 
 Tue, 28 Jan 2025 12:08:07 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3b45sm87002455ad.97.2025.01.28.12.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:08:07 -0800 (PST)
Message-ID: <61b6b085-cc5e-4439-8af0-e51f45207a03@linaro.org>
Date: Tue, 28 Jan 2025 12:08:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] cpus: Remove cpu from global queue after
 UNREALIZE completed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Previous commit removed the restriction on completing the full QDev
> UNREALIZE step before removing vCPUs from global queue, it is now
> safe to call cpu_list_remove() after accel_cpu_common_unrealize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c9..11592e2583f 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -172,12 +172,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
>       }
>   #endif
>   
> -    cpu_list_remove(cpu);
> -    /*
> -     * Now that the vCPU has been removed from the RCU list, we can call
> -     * accel_cpu_common_unrealize, which may free fields using call_rcu.
> -     */
>       accel_cpu_common_unrealize(cpu);
> +
> +    cpu_list_remove(cpu);
>   }

I don't believe this is correct.  Why would we have an unrealized cpu on the list?  What's 
wrong with removing the cpu from the list before unrealize?


r~

