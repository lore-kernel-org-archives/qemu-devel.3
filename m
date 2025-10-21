Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35164CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIeH-0007Bm-6p; Tue, 21 Oct 2025 16:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIeE-0007BO-5q
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:07:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIeC-00015C-5W
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:07:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so57404925e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761077274; x=1761682074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lpzl4JKhQhWfQ1GmJs4WWV8UkIn7iZ8m7JkisXE0Bhg=;
 b=EISOs7ZgJ1oByBgC/4WHrh0pTTCCN/g/b9GIg/UIrApb7lqIq1YK3sYRu4Gy80pi++
 dOlmRVfsgCTvKZjmtaaHq8P4AzGHDPTmfuEsN2md33vZ0a1lE5dkncjEh95gDltvMy2f
 YIvhUbJ8GCp6Lqquna14MN3UWw1NjlQRjUJNUdg5WV+sE7yNYHedz36f8AWNLnPJawIb
 bhnOpy4M47zdb0DEvL2joauuHETarcH90V5rfuRaHiShG2qejCfC8jnDzgOfqT+f5gYD
 6B0+zmoEcgDTTm9fwGeVNloNQh5gQU31PT+ucM42LCHnAn9tNZ6eEQYO2IL8APbLOoZp
 dnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761077274; x=1761682074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpzl4JKhQhWfQ1GmJs4WWV8UkIn7iZ8m7JkisXE0Bhg=;
 b=FJf5kwSO+DJHU2GlvY+UdDimxhCVZ1S/MyitpRCiPeQNQDLCB5ig0ee03LbmrJKT4y
 Q8ietPJX9l7CJvTGsU6sC+QYcaTUbrIoTKmyCh7fm8SWsF8Ceu891jCHa+PTyTbNEnr7
 alxhOPaw1H+qwDz0XjjRZ93dRHeUe4mYD3n03qtUF3JtbJDnQeHVVseVU55dbW6WZHcj
 LzxyXa1cpwJUWAG/17G7NOdWeZfiJ27EbkVRRbnpQ5e3D1TxicOpmuXsLdg65/d4tYHY
 b+hTlubIgCqvv5jBDc3RhtD59qVFAeGALLevn6UMA1P2PrtMIB0TtdcIqadm9VszTQdX
 KKmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZG8xwIg+BIk7ic4KuktSeirjLc47VcX7gvCeo0Z5kMbfqCO2PtzEpqURNU6D/I3Y5452PSQeG1Cl@nongnu.org
X-Gm-Message-State: AOJu0Yw1MTa+DLyCyTegcyuz8YK4cpTK6RhD1NWWVGwhjeJR7hTcrPCT
 azdb1/7KxTwPu9l2kLnsVAUXmIHEk1l7ccQK7BK2F1jr0b/eZW1LS9gTqtDyNj2ChnM=
X-Gm-Gg: ASbGncvT32YgItX0hZy0Ybv3l6EyzwRmAFpLVM1N3ZLJiUyiYbGpyF7XptWrZpXQF8h
 oZvI7djqoabm6cUMkFyOCz9HDCpyKP5j1kFvh6R6OfKruKPoXywzRu794mE+OUHvo/Ce1nnNOa9
 liUUhf2QG3ANE06Iagtvbi8ZDpyiznQrIQb4tI4NQNpA/3CcR7HinGCw8eQ5LNdfoyDJ+oojuzv
 LLXK8B5gcJi3+LEjW76fd2RhLTfz/7ue5F9n2RKNBaS6y+Z9A/J7qtJos32AsblFXRgOUQBf+kr
 SQXa/KzGYoQV8RfSUHwXefAX2paUI/qKr3rseegEAOeU8Tqve+uc0YpIyrhKqX4rz4Q+sREVU1q
 7pFssHSBHSgBj8MXj1huIow3xm91xaN5c3k1V9CPPSZ9fOe6okoo9Rpm6BVYkQpfUGVhbj026dh
 lXc1PwzEwIcMQ/yzrRkbRGzhJ91kUoxkhXt1z7LWQ6ro4j42P9DjSFDA==
X-Google-Smtp-Source: AGHT+IFeqhAfJI44IYioewXYx0vsEpE95kxDIa6lNJopoRHUzg0LgCQpN1dfmbyokRewlc4pGMDODw==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-4711791c522mr128824605e9.27.1761077274197; 
 Tue, 21 Oct 2025 13:07:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a6c5sm22370253f8f.28.2025.10.21.13.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:07:52 -0700 (PDT)
Message-ID: <ad294ba0-5c22-4583-9f24-8514c6bef633@linaro.org>
Date: Tue, 21 Oct 2025 22:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/25] target/s390x: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <cover.1760884672.git.neither@nut.email>
 <50a092042a41f7d679df2b6577edcba1d9316829.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <50a092042a41f7d679df2b6577edcba1d9316829.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Julian,

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for IBM System/390 targets. We treat "program
> interrupts" and service calls as exceptions. We treat external and io
> "exceptions" as well as resets as interrupts.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/s390x/tcg/excp_helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 0ae4e26606..c6641280bc 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -35,6 +35,7 @@
>   #include "hw/s390x/s390_flic.h"
>   #include "hw/boards.h"
>   #endif
> +#include "qemu/plugin.h"
>   
>   G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
>                                              uint32_t code, uintptr_t ra)
> @@ -502,6 +503,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
>       S390CPU *cpu = S390_CPU(cs);
>       CPUS390XState *env = &cpu->env;
>       bool stopped = false;
> +    uint64_t last_pc = cpu->env.psw.addr;
>   
>       qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
>                     __func__, cs->exception_index, env->psw.mask, env->psw.addr);
> @@ -531,21 +533,27 @@ try_deliver:
>       switch (cs->exception_index) {
>       case EXCP_PGM:
>           do_program_interrupt(env);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>           break;
>       case EXCP_SVC:
>           do_svc_interrupt(env);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>           break;
>       case EXCP_EXT:
>           do_ext_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_IO:
>           do_io_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_MCHK:
>           do_mchk_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_RESTART:
>           do_restart_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>           break;
>       case EXCP_STOP:
>           do_stop_interrupt(env);

Shouldn't we also track the STOP interrupt?

            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);

If not, please mention why in the patch description.

