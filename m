Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655DED1815D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0VaX-000263-WB; Mon, 14 Oct 2024 20:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VaW-00025o-Fr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:39:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VaT-0006D4-N1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:39:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso1645450b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728952736; x=1729557536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rqFBrmydJPchr5Ga4Fpad5Z0j/3GwRWQw2PwU0Forwo=;
 b=LviDaIaRquaHZcq2w4vj7tvXMAK47ftH/8ub0YmEeFRUD1kt+V6ckQuKp3n9yu7/uE
 hbgxfuK0YBR20PfELH2JetlvMGTtcD5e3xe/QaGTCtDdn1NvIHXtgSRhc4PuYJd3nwpu
 A9doQm63EejsUvM0LTlWduZjYVf0+SIelgqsrFWyhvl7yVJKXr42pBcswVI9NG5fx/FH
 SoWjasnkL7zJ/3S/6CqQVzOqCHDuU8DfWKjl3Zi3cSi3kuLIKFjbC/uupXmFIOWJcw21
 QXNLmMjjgeKQur1ehK6g0ieyXOcY6qqQCwG3oJbow4pnb/OGMOr97+Q55JGfLwFjdj/z
 7axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728952736; x=1729557536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rqFBrmydJPchr5Ga4Fpad5Z0j/3GwRWQw2PwU0Forwo=;
 b=C1kYkMaudAMrPb73BkZ49EWOLB6TAmIl4sgxo6CH32VBPPV5K0Dgs2miOmteI1vghQ
 RS3THBv/M78x1wA1N4IUyaSChOiME8aEQOEeJg/ICwBTIFH1HcLTnWnY9eAM8J5lo/vz
 0cpDlVs1tO/Cu8DLxM4Z/QjVLofGodbp0q0POL4Qf0VciB351i1ZJp0zXSzzheZbD57D
 qX9oO5dzkaMQSvqEkpThpTGU/bWsE7KLIkTnsfcAvm5cSw1j3aJa1zdOTQa+UGVFsO/D
 bajNtn8Isu7tVvzb+YVu7t0TTT1oCKZuWUNnxccr0b78uehK5+tM//rkh9+e2VEbf/Gn
 5r0Q==
X-Gm-Message-State: AOJu0Yw6Nh3N3hkelycYHa5daSxXFGWqsLqfNT2YatDoBojMdE1+pekV
 orNCvKG+Bs6XUtQHZI6Jy6g0StVo+dxn48jpgvZfv0Fwxl3Q7prurLwiIjGZG+cXprsqcTo1Wbd
 5zY1WYA==
X-Google-Smtp-Source: AGHT+IHCMSRLsQlL81PzrWze6lrs0vUWX1ZGZXATmfu3OQtSvfpWUhusuxMwouKdKCatSYpqNwqypA==
X-Received: by 2002:a05:6a00:2d0c:b0:71e:76dc:10f7 with SMTP id
 d2e1a72fcca58-71e76dc1a52mr716183b3a.4.1728952735729; 
 Mon, 14 Oct 2024 17:38:55 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774a2556sm143623b3a.102.2024.10.14.17.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 17:38:55 -0700 (PDT)
Message-ID: <80f9d74c-e7ce-447b-901b-4f6717bd49b3@linaro.org>
Date: Mon, 14 Oct 2024 17:38:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix qemu_plugin_reset
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org
References: <20241014223353.900481-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241014223353.900481-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Sent a v2 to fix a leak issue with tcg_ctx->plugin_tb.

On 10/14/24 15:33, Pierrick Bouvier wrote:
> 34e5e1 refactored the plugin context initialization. After this change,
> tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
> one plugin at least is active.
> 
> When uninstalling the last plugin active, we stopped reinitializing
> tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
> This results in an error as they don't appear in a plugin op sequence as
> expected.
> 
> The correct fix is to make sure we reset plugin translation variables
> after current block translation ends. This way, we can catch any
> potential misuse of those after a given block, in more than fixing the
> current bug.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 2ee4c22befd..2a8c8b2ad14 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -467,4 +467,9 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
>   
>       /* inject the instrumentation at the appropriate places */
>       plugin_gen_inject(ptb);
> +
> +    /* reset plugin translation state */
> +    tcg_ctx->plugin_db = NULL;
> +    tcg_ctx->plugin_insn = NULL;
> +    tcg_ctx->plugin_tb = NULL;
>   }

