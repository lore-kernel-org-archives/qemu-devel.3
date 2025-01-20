Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6ABC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvZW-00086S-Ck; Mon, 20 Jan 2025 12:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tZvZU-000861-1J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:28:20 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tZvZS-0006gx-Fx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:28:19 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso6265877a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737394097; x=1737998897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ydPdjLQH7he4EwRUO275VGHvblf5LC8rIkqVSx80WxY=;
 b=cruQwXocmQAr8s7wUgOkBnITHSAhlsyRVM1TbHoZ8ShxsJ+HE5NlP7AryhSdxM8ne7
 lyRIruFjmMcEcVggJb6Zf7zklDZEabAobRGS5cyZZL9D23nsHHIrk/aI1s2Y5PG2GdOp
 4oPke2mNwZTFyezJPT9zOR09plBzB5zIIu8C3wbD8A/NJLQOX7oeWBAtjp4CSwOaJYgU
 /FrOyiksGICSClNoxAZ5An0PzBEMpsy/4rtIeWvK8DFg/mixXILIG1E7zW7PnTP599S9
 wn9BFbocE6nUpQ4Xc5FLXd7qAyzBWlCUm3uaY2imJXF8jA4W4NUd6XUqMDPaGDYZub3y
 NRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737394097; x=1737998897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydPdjLQH7he4EwRUO275VGHvblf5LC8rIkqVSx80WxY=;
 b=OPbVZEwV8QyzwLAWIlbYIsLbaTyzdM1No1KFQN/iE/zwnYMUEvUO7SQYhLbcPry2Vm
 38PjwydJHldRyp8JE5eor/q0ILcoDUzb1dJmb2hOqslrVux4B7gpPtQ2Ue6zx5vxvAiM
 JnDhDQU50cX14mtwr2rUhcbyPa7hp/oJqK2iTZMfP4xS6y3nmcn/r36Ttp4NGBvAIbI7
 qbPT4Bsaa6n0MzyLrRWcsP57dGaUTGShpmb69k8L9NKQ9s/9y1+q15a7TppZOnzROozr
 HjxU8SBKO4WUiJHmJfXDcJajfMhFok1JBNoCfdF9y28PEbCP8AlxpYNk17Jxs1MZB4Us
 v31g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwlA917W33sVBSOiAP3qyM2uy62ObMniV53kh16INDgDjMzAxoJeh4w12v3JsW8k+RtN3gu5C1XTKP@nongnu.org
X-Gm-Message-State: AOJu0YwQG1j/OqE12fG5fmIOtxhJGPrGjDYlnz9PUSXaO+zLO2TxACGj
 dh6eeQAuQvd3ib9izoVw/TRX7W4Qr3z6ru2LTo+6+Qlxy3T1nc710C0NChigEL8=
X-Gm-Gg: ASbGncu5Tc4HExp44vZkSg0aMtXZ0vfmvCyHGGpmzH2/uqRmTyGvr9ric1XxObE8ueZ
 +k6iU6h+q7M3wmpR6IKq9IxWSQOqzkl9K8TQ4TmSZ9nAobs/gWuW6To0wfkoEVy/e6L/QTAMGSK
 q6tv/l759WQ5a6H0eoIqsisAF5kCcJK0c7URR1qaqKzRtFlwgIFThfTfVp/m0v9j8pSi0iH+6WY
 6rYiOcis6os0dtqWQjIQ0SU4tTSkeVlnmwNWvTt2lsNEbH0FLtMCzx9PdZTtc0JIGboZ+fNaIHL
 DV+RDxgF6reOFCJuoWw8QGA4n+uTOFAIWVC+
X-Google-Smtp-Source: AGHT+IGqDPxVxtFkcus3he0fd0zKYmKcaiyn03xGIGf5HcRZH0CdFvd8hQVNLWRV4rWUyQc3VXL3Aw==
X-Received: by 2002:a05:6a00:179b:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-72daf94f5bdmr23977318b3a.8.1737394096843; 
 Mon, 20 Jan 2025 09:28:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f07e9sm7339325b3a.1.2025.01.20.09.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 09:28:16 -0800 (PST)
Message-ID: <37ea5a30-8d23-497c-819a-281e0e856eca@linaro.org>
Date: Mon, 20 Jan 2025 09:28:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: throw debug exception before page fault
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250120133949.1019000-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250120133949.1019000-1-dbarboza@ventanamicro.com>
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

On 1/20/25 05:39, Daniel Henrique Barboza wrote:
> @@ -1708,10 +1709,25 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       } else if (probe) {
>           return false;
>       } else {
> -        raise_mmu_exception(env, address, access_type, pmp_violation,
> -                            first_stage_error, two_stage_lookup,
> -                            two_stage_indirect_error);
> -        cpu_loop_exit_restore(cs, retaddr);
> +        CPUWatchpoint *wp = riscv_cpu_addr_has_watchpoint(env, address);
> +        int wp_access = 0;
> +
> +        if (wp) {
> +            if (access_type == MMU_DATA_LOAD) {
> +                wp_access |= BP_MEM_READ;
> +            } else if (access_type == MMU_DATA_STORE) {
> +                wp_access |= BP_MEM_WRITE;
> +            }
> +
> +            cpu_check_watchpoint(cs, address, wp->len,
> +                                 MEMTXATTRS_UNSPECIFIED,
> +                                 wp_access, retaddr);
> +        } else {

No point in walking the watchpoint list twice:

     cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                          wp_access, retaddr);

will return if and only if there is no wp match.
Then just fall through to ...

> +            raise_mmu_exception(env, address, access_type, pmp_violation,
> +                                first_stage_error, two_stage_lookup,
> +                                two_stage_indirect_error);
> +            cpu_loop_exit_restore(cs, retaddr);

... this.


r~

