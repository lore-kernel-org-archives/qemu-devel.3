Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43344C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkivX-0003Sc-BD; Fri, 17 Jul 2026 09:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkivV-0003SR-0p
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:48:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkivS-0001KS-BR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:48:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-383adaa461fso3222613a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784296100; x=1784900900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bj9MvHZHVxiWfbRbv8Labz/C9uhWOW6Q7VWO7WD17uk=;
 b=QhnL3qLpG0zmdWv32+eqnTDBGfSRFwfwdBifUN7QjCXtsZYeNjdR20Xf4tMzS5NffN
 DFzFYVYOXMaTasV4pClz5MPFSpeL08hHg2qU98k05tVLiWBUaOE9+KF6SJtH4osGZGnB
 aBl7eRfNKeTkBSbJGYDhFVFFQ5/pIsnP3PbpHjbaskrPzvWqRBR7GQ4YcQw+Mc5UAtRX
 oQdhx4Up3PPD3FYgqL3bboPxN5Z3RLAdXypo5ww2XYI5IZIb5Km9jH+kuTaxZfNTf757
 fyMuSBsZZaavtny4xgZeHaiKhYz4NuxKrH+SdX2hV/d/BM9cGZdsseg/4IISDOQ8kCWs
 jIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296100; x=1784900900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bj9MvHZHVxiWfbRbv8Labz/C9uhWOW6Q7VWO7WD17uk=;
 b=fzb4+G6/Op+J0pvfCM4rdsVupKvwke5syle0KK+1wBErGJg+978VZxrEW2T9dCe8d5
 mqP/YRO0F3h4PdkHuP4LnAm56khCMZ1BsXLCC1JuLoWl+XH1Yrh7A6FA8ATSGWBdDTGz
 bsHSvgPKL9ArqQACzFkU7DuHENwEegNPvyEcXFvnYQx4M3QwYyhE7OuHYyNeE594y2ly
 DJRJEpNCr5LF8MFHuZ8GChauG11OI369Fr27xpkjsfma3klP9I/eoVbfy3r+hQ0gYi/e
 MhlFN6vsXdjKmTdQFE5VEEwY4XRbb7pGMhOoXCbdPd6pzcGQkH6gsWbYzA8SZASJB1MY
 6ZUQ==
X-Gm-Message-State: AOJu0Yze64WjDBDWEvGqyFMUkrGoNbDqA4afslgrD1oS6ulkS8S+Re9z
 6hor3C6jrkzx8FtI8WP5B5o12JdDxj3c0g+p0IRq16or7vtoBuov7paPp/Lapb98shBWhG+Psic
 r1cQs
X-Gm-Gg: AfdE7ckDZFHu4J2s9xm3fG5F4LQc+Bh5BlLLLkDpJ8uneuxqz0BUNEtYN8WTwBqzuW0
 IiShP5BGONwqPKPEGoV6C6ybpMCiKXyQu7QVF71rSzJsGreTwnJGPUgrXT+pSOU9L8vtfy2UNkn
 4gFBvJ086b1RTpGrwljK7EZ/LdETNHZl1VYV9eFBa+tgYjstbLkYp/pccdj7Jm/rG3chMMi5/M/
 dtbEmeJ7uKnaBxKiR4eEf/3wQktXskzPczSyvoXO1JdkTeb0LLTLWT69QkjQrRDJDfXuK45sCwa
 ftxkDDcDwch6tIr0kBjvTdYXh2SXfTGQ9cyfen+qb5D614mbbz7NtsOmRuIsbZo2Pr4qpRUcpl+
 Nzl8+xowR/h4shPDfLwXNwazaYlWXr4f988K8udJxhjvq+8BmaGQooW0+7aXW7wLhyRUPRko1lC
 xJha9NhfQde9CYbkszcBD/w3/c3pbuDRWP5uwef2AKaS/uNUh0somAfewloeSs
X-Received: by 2002:a17:90b:2f4b:b0:37f:9cdf:f03e with SMTP id
 98e67ed59e1d1-38e4b540acbmr2842444a91.33.1784296099610; 
 Fri, 17 Jul 2026 06:48:19 -0700 (PDT)
Received: from ?IPV6:2607:fb90:9e73:45cb:78e:ab81:8ca0:904d?
 ([2607:fb90:9e73:45cb:78e:ab81:8ca0:904d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe1014sm7826743eec.7.2026.07.17.06.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:48:19 -0700 (PDT)
Message-ID: <86e5760e-badd-4e95-8c0b-2f016e29c5d5@linaro.org>
Date: Fri, 17 Jul 2026 06:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 13/17] target/riscv/debug: Fix migration
 post_load icount_enabled() test
To: qemu-devel@nongnu.org
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
 <20260716123535.3709148-14-daniel.barboza@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260716123535.3709148-14-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/16/26 05:35, Daniel Henrique Barboza wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> itrigger_enabled is relevant to the !icount_enabled() path, the test in
> debug_post_load() is inverted.
> 
> While we're at it, move debug CPU post_load details into debug.c since
> there's no need for machine.c to know internals of how debug.c maintains
> debug state.
> 
> Fixes: 577f028694 ("target/riscv: Add itrigger_enabled field to CPURISCVState")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/machine.c   | 13 ++++++++-----
>   target/riscv/tcg/debug.c |  9 ++++++++-
>   target/riscv/tcg/debug.h |  2 +-
>   3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0ab613a298..82d2e11eb3 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -228,18 +228,21 @@ static bool debug_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>   
> -    return cpu->cfg.debug;
> +    if (kvm_enabled()) {
> +        return false;
> +    }
> +
> +    return tcg_enabled() && cpu->cfg.debug;
>   }

kvm_enabled is redundant with tcg_enabled here -- only one will be true.

r~

