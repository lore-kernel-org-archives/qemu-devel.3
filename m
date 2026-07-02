Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E933EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLW5-0005Hq-VS; Thu, 02 Jul 2026 13:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLW4-0005H8-DP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:48:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLW2-00050z-Nq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:48:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so932907b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014477; x=1783619277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jarGAq9UtBEsWRSpavBjyY9I9biAQ+HL1GdDN7+6QeM=;
 b=EU+TDSWWdqmNumDrKbXnH/QHlB3g8oL+zkPLEIaXMRe86YEbY+Q817oSRdG63+gm/3
 26QS6pL1Y19rzHl/9rfCmLZcxOBrG8G6vPYefaLGfCoNBgUesWrBAVtOYGJuFBhRRQqr
 DG6M1g/rvg97PW9tsDBuskuherRlVdZ0vgtPra8VEWfO3GU6W3cmF3ML5C5cneuGz5o1
 /h6y8L98+LWl8OHt0uZv5dEcN0EzsCtKGDRHIZeZ9fZMAuwrGSKV5Hv4zge6S9JjaMKF
 0SmCUXMEmvCV1A8sfYv1QkKIm+I6BPuQo9E3JsfT/wRuISpw5qIIXKsmcaYHjJVapI8/
 rAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014477; x=1783619277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jarGAq9UtBEsWRSpavBjyY9I9biAQ+HL1GdDN7+6QeM=;
 b=OIX63+4aV/ypfAyZZPvIZErYbdrunTx9yPGyXtU/7vJPFmUnF/ZPeh09ltfHEefkUw
 8q4ggt5hpvnqBs9mNWFzHSuoOjFJI6+vvJZVXvAV6e3lcNYv5PAQrl/1u11zoHIieSU3
 cxnXZXVaxt0myuldWJw/9LXfvu95wdyhP9gf8GHQYvVwtlDc/BRVmcmYZXQsHYQgwSAA
 Kf5ql0/L5CFS/z2faXxpbhybd8LoyQps1re46ybh8oXJsKW2jjKpw9YNRZBouC9mkRzb
 TSD4VWn0MP+BOusSUu0v465+hUqcc8Wikc78K8HrMjXaSCFLSXUfsC5wxbzPyS/qqixH
 3VGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQFTmUKiWw8HTGocT36NNGrNSJX7h79VmHFoORenaU9YpJtJIUR7VxrUXIiJCtp0pWcjMOnqFJedG0@nongnu.org
X-Gm-Message-State: AOJu0Yx04dfg02F/bTtJQcW4YGijMlO7bnqsjaBe8YhL3oCG/0RSHVlE
 CVZ2te9j8G+BPqiMHazZMC6iXTP8vGOABwGnBSiP3d15lwZD9s5NzwkAy/cRhvKZnc8=
X-Gm-Gg: AfdE7clRQjunXvjWspnm8bzCYekGxDFxCHEVA+kBETdvUDMFt9HE/UxWdFJcGK9J3T8
 vP6ujkbEkGg2slX2ojeTGf9eJpY3QYshwEUU49MBU2/JHCKT2v/ynE8wdx5zenvqsUrmMwMFy6c
 ThZY5jBr2wCIVfV/jZIPgpaVdtAc4YIF6qdXhg9O09pI4M929v7AafbBdr8nLgr5JHlBhjSdLh8
 1kvAytlHrG9edapc0ZNsAmwjho2jMO6OHtptl6b0boVDmoMGjVqZda7O9wIokhpxUu5AB7j4nnO
 odZuzEkMXEtb1Kb0RVm3a4RfstmGfCdVIblpQ3UBUcuSLHXKo3QiQb9RilnF5odDfomK8nfVtn4
 U9eJA867WV/OWCaH6CDguwH195TfOIrjakhT6dkV4vOhfUCUnol0xJped9E6b9NoBGFyjbkt6D+
 uLXVhQaT5UmddauWISlMIWd50g5ok3LDwDWUHg4p4tFWVqJtkywvkU9eVjiw==
X-Received: by 2002:a05:6a00:400e:b0:847:9570:d408 with SMTP id
 d2e1a72fcca58-847e173635bmr724837b3a.2.1783014477011; 
 Thu, 02 Jul 2026 10:47:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb97d96fsm1707284b3a.40.2026.07.02.10.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:47:56 -0700 (PDT)
Message-ID: <cf668e5d-83a1-4864-ace7-acb1d7cf7e87@linaro.org>
Date: Thu, 2 Jul 2026 10:47:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] gdbstub: Reduce @type variable scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-22-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-22-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   gdbstub/system.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 414aef431ec..d5e09802323 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -126,7 +126,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>       CPUState *cpu = gdbserver_state.c_cpu;
>       g_autoptr(GString) buf = g_string_new(NULL);
>       g_autoptr(GString) tid = g_string_new(NULL);
> -    const char *type;
>       int ret;
>   
>       if (running || gdbserver_state.state == RS_INACTIVE) {
> @@ -152,6 +151,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>       switch (state) {
>       case RUN_STATE_DEBUG:
>           if (cpu->watchpoint_hit) {
> +            const char *type;
> +
>               switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
>               case BP_MEM_READ:
>                   type = "r";

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

