Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A6FE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 17:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRalC-0006eg-U3; Sat, 28 Dec 2024 12:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRalB-0006eU-OP
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 12:37:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRalA-0000pk-8w
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 12:37:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso58520105e9.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735407474; x=1736012274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vXv284q7RI/issoGnWuVaair+++I0WUUmjv72c3o0Js=;
 b=pPiS9Z3Cbr2nlkmxNfGbI7vHIKjLMTh3VYefZPM5vxEl1FGvnTqT7SFZTKWluGBA1X
 57QBWnq+Cx3dTH0/JI6LPw90YeUuq6+CQJACazXkjbxdEquf/2FNCc8kQxC9BlyfIb6H
 sNsSsIZtKBlZBm+sNr6UC79f3oX9obhOamyaGfI+l54Q+h2f/t7PN+/Zv+4OevJ2Xq1+
 vXtQLUV/szjuzmAfOlOiLoqoU4JbWwbqBvsB1xuCN66f8jcBcuzYmXz8HPWYa0TsilIY
 fjdNDa0vCPcJtoYvl7zoocNPNoVERV+K9NpsgxLePBKMgn9fru5MlnSIPhWeDzCGJuyF
 625A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735407474; x=1736012274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vXv284q7RI/issoGnWuVaair+++I0WUUmjv72c3o0Js=;
 b=jZ39J20GWWGpQnOhdH+ZfYrs8nV8a9Pa9x3Q6mB99gMHr0YCxZiKo495YQg7+SDov6
 8muDM33XWyTbBCs8pwPHmzrk62G8tMRrM+JIzS/5Hb+c+jJ3zQXx5cOJi9Ong6MKeCgC
 g8BSMcpWQY+1/rYEwHFSlpN6fiIBD6rPh5CdDJCIJTkqoot0h449hhPHmCr0paGgKawe
 FVKEUmCMfinGE0v7to0b3WBD8WXuLckBoEAJDkLGte3F5GjTEmLisui3oUDteaorfP8H
 /R+6hre0y+MChIasHjwV4e4R2YRa63XY1JzSDEtcjtrK2ef0R8yhiBU9c2ywi3SdqVAO
 KkCw==
X-Gm-Message-State: AOJu0Yy42rw8ITCk01lqhQsotYxqeTxRCl/GHSm6N/rpL+/PZ2TSPArb
 zH17u/6wky5Viam2pf6SuzXgOJ7UUPUXJ+lc3uEWbPs+3RmM1NHYiyWaBqvajZk=
X-Gm-Gg: ASbGnctbuawpX8UV6XBxFtpRFoo4hInm06UnjnNLpfpiqr+Zzd9C9YmmLFzvRCQsxBT
 xmM3a4dQWSBV02SqDqrXDkfj9VIqPiCESlEuS0rlHvvGERxmgb763zwAPuvw+f9HmgLD+vyafQa
 AiZbq8ocxw8Yr1RT3Q3pkZnbUpFGjqX7yoosbT/Y20S7Ct0cyfJWlaijPPrdZfXyP55//bz+ixR
 Nh3l0ARXeyeoeiynnwvus0LMUbjYiXDfvtZyyeErloCXsbeH4F817gtHXeGoiDKIQlokd0iUMMc
 s+sgLFVjdbzCPA8kDEpS48Zd
X-Google-Smtp-Source: AGHT+IHbSSmS2+baZyy4UVOUw/j1q7hjtf8qGrcAA52oI0lWgOmxQBXMBvwkNt8zjKPHaKNWeqiwWw==
X-Received: by 2002:a05:600c:45cf:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-4366864305emr269137255e9.9.1735407474360; 
 Sat, 28 Dec 2024 09:37:54 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm300306345e9.26.2024.12.28.09.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 09:37:52 -0800 (PST)
Message-ID: <018cfbde-96be-4d95-bb29-95cdf708187e@linaro.org>
Date: Sat, 28 Dec 2024 18:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
 value of MSR_CORE_THREAD_COUNT
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241219110125.1266461-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 19/12/24 12:01, Xiaoyao Li wrote:
> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
> Extract a common function for it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v2:
> - move the implementation of cpu_x86_get_msr_core_thread_count() to
>    target/i386/cpu-sysemu.c;
> ---
>   target/i386/cpu-sysemu.c             | 11 +++++++++++
>   target/i386/cpu.h                    |  2 ++
>   target/i386/hvf/x86_emu.c            |  3 +--
>   target/i386/kvm/kvm.c                |  5 +----
>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>   5 files changed, 16 insertions(+), 8 deletions(-)


> +uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
> +{
> +    CPUState *cs = CPU(cpu);
> +    uint64_t val;
> +
> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
> +
> +    return val;

Alternatively:

        return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
                         cs->nr_cores);

> +}


