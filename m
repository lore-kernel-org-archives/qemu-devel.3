Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E1AE83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6V9-00075b-4N; Mon, 02 Feb 2026 21:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6V7-00074w-TM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:50:50 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6V6-00053w-AB
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:50:49 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34f2a0c4574so5135268a91.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770087047; x=1770691847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmbR169lO8zaPGBA0wKR5lcpYIGPcf68oW+s7psWuZ4=;
 b=fWdSZfaeJ7b+4PPmub3QSTMZLq16Kl4JIairtmVEsxM2/E0pXgVDJpsJFmg6oPYWX8
 fZ1L++Su2CUTnhIz5HS88GKty5bNwXPY9HfBz/PuToi5eZGQb8DOxGaw2njIO//3M4QY
 U5pge5dKLwal6ofLH59YxK0qfC7MNVhUOs9fouMe8Bx7oCDy9WaYuCfk/X7QLD2TLOfJ
 CC8/EzAAZ5GsdwkcTsDzRzDpbSjocJV90bHr2qRatPc6wU114wAhyaz3xLuoXjEiCEEH
 9zNTr+Ovz/PhWbm43whjPLSXObp8ZYau3DrXI1jlIMlB3te4Xe/Z+SD0/kJOQxj3d/Aq
 bYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770087047; x=1770691847;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmbR169lO8zaPGBA0wKR5lcpYIGPcf68oW+s7psWuZ4=;
 b=r3TICBZrICHT9tJQpj3mpbMdzv8B5GOglR6PFdXOFuzAF8wWtxLJ28vVdZgAmGjU/D
 9hKB+3XpVmrSMeHekgPyS8M/MR3nLEd5N4en/Yh4HoP/nRc3Jq+I8leL0frxEbBZV8OL
 rHXOTevIOWD0XbjXrTcj8N9Gdn1r8J8V2VqvUBSyijd4c1yDfVrotaZgLIUBVprHfRdq
 cAOt2lT96Q63T1yUIsByxSAFAZ/FYcoasvMCCIeLZmzujuiHxweGumEWl+IiU3O1tKKR
 O5NYMS82IUGnX9JRhtT7zmrqeTsxluobIEbdMQbGdF75pbaRAWNKExqIlOdH5Y75/dDn
 2H7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDVkyiUyH5+QOM47dTq271BYQ2ytsLQhWZ9G1SrgdWeEuELdd/LVpZZJkPaMxzAMVEw26Q0tll5Csg@nongnu.org
X-Gm-Message-State: AOJu0YzvCsi/7MjAs78HDoWhyKeTDBCtRA4j8KBPI3HBURvClmbwE5T8
 JuSyOgnA6o5aweF4hyRqfJT8by4PTJtvG2vw3NK1RTmK42Un21MLYC8I70le4JLo4ZA=
X-Gm-Gg: AZuq6aK5XRucpBPKSe+hl36um3QBQJ623K/Cvx/htCp/walu2KxH792/mr+tMhhxFkv
 9cI9o3Od7IgA6YVCL+YaYzSrPQHdfX1J22Q6U1QnJVNsgTJM7MsBdJ/2JGpoaAAtUoI7jV8G0Lc
 ETXsZVXV6/f/OohOLGlmqlvUz/ZK4+ShYET6c51YJpesQhdS8Cu/m3cR9GoY82G14g/iyiH4LzC
 5yDWhTuSlLXeoi0OpKppCdPzoph3iIc8O47vEeLcYKAS7heNU2B3XDnpAbM0g5x82/K1+bTTPKr
 KN+sGdV9FTs0KWJFXiOooJdbPLjAKqJOMhONqQlj92ZAj4pAECF4ZzQDzDqEDEN/M/k0MsylzYG
 p6BNNlsmgYDXFYzNnlxjCoYzczPbg9VFXwExr+zq+lUJ7avjkPd+d2nd82C+t160HQG2tdJ9N4F
 TVVSFndBbSE9P7mKViNeu4OyctPw44n93ox6633a0jgBUAGvfe3HE+sJljs3R4HT2Yrpu9Vgjn
X-Received: by 2002:a17:90b:3c81:b0:34c:2db6:57d6 with SMTP id
 98e67ed59e1d1-3543b38b059mr13026667a91.19.1770087046573; 
 Mon, 02 Feb 2026 18:50:46 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3547b103142sm268224a91.9.2026.02.02.18.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:50:44 -0800 (PST)
Message-ID: <7ed0c393-4d3c-44fb-a0e7-bd4375772c2b@linaro.org>
Date: Tue, 3 Feb 2026 12:50:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "tcg/user: do not set exit_request gratuitously"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
References: <20260202091753.28459-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202091753.28459-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/2/26 19:17, Paolo Bonzini wrote:
> This reverts commit b422a7bff64eaf55b8250225533ca1df42c3777e.
> 
> The reporter says "The commit breaks go; if you run go build in a loop,
> it eventually hangs uninterruptible (except -9) with a couple of zombie
> children left over".
> 
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/cpu-exec.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 7c20d9db122..ad94f96b252 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -751,7 +751,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>   
>   void tcg_kick_vcpu_thread(CPUState *cpu)
>   {
> -#ifndef CONFIG_USER_ONLY
>       /*
>        * Ensure cpu_exec will see the reason why the exit request was set.
>        * FIXME: this is not always needed.  Other accelerators instead
> @@ -759,7 +758,6 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
>        * CPU thread; see kvm_arch_pre_run() for example.
>        */
>       qatomic_store_release(&cpu->exit_request, true);
> -#endif
>   
>       /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>       qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

