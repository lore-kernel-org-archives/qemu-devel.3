Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAEECCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBapO-0001nm-ME; Wed, 22 Oct 2025 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBapM-0001nL-Fi
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:32:40 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBapI-00043d-Ud
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:32:40 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c27665ce3eso3592454a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761147155; x=1761751955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uc8YDJ6vhB0QcCAal9qq3pYeK85xKbvVkf6Y1ckJz0=;
 b=kyuVbMWLCZkVYyjjfgXcVvp4lsTondXeCL/EH+a36mbrZ7rlqkXoTKLesv+pllSrcI
 z8W4G/6jYE6u6xI0RyQOM90NSIRAk17JoAFTI5ReNV+NWxnId8eQGjAg/WJRNaRNJpv3
 +JF+lov8m/s7eN/noBfXrvP9dpI2sMEqCwCSV2CZyeHSUCsRHqC4gIBQF8kBSRea5BP7
 3LZ6BYN/0XZN8dlfW5l5C3UjZOrH52+fgZBv1ggwV5JmiEI7k3PtqEUXDVODQoZe/vTO
 /giRlKA9nGIy4BmdQmHrEpKNeuWNUsTZjNL8WQ2dSK1d0rL4FgICjVd+TrZq/W9YJ0Pn
 SqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761147155; x=1761751955;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uc8YDJ6vhB0QcCAal9qq3pYeK85xKbvVkf6Y1ckJz0=;
 b=HU5jWNjCc3olh9yEEGPYkXCMgLXoJZp98ng7YPlTzLMIreUe4PvR0mR3trTBfvMdTz
 ihMic2yfjbdyR7c7yo8ExIrPYK5EFFe+76T9ADXSjr5NUPiTBq+AN+nmJWkvs+y7fWIT
 9xU7v7uB8Aq43dV+yiuKzfrpGwrZmULnyjLHH4lC5KecH1spmV15XLT6FYeKg2kAPnMZ
 Hi46Dw+RqVLy7McON6lCEAQNRa6xy8pG79ejO5ZbBpAJESVgEHNoy28n2iNvCPfPkIrv
 7M3ZfbMQwKs/L8JET5XjiCAxF1RLYhgzfhPkX0qLdTCjPOiGQPdzHGl5Pq3LuXtvLnp4
 c/LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtJ5tkNKS8/ufT2wsj0E2khl3B91sbe13EAByerK/PIucNfO7/VqQ4WfLrj0ss1wdkPye2zsL51Bo1@nongnu.org
X-Gm-Message-State: AOJu0YwqYc+euUMIKjKmUnd2f00apeBtmOo6VIKoat0cjkvzlzkQEWnl
 s9Jxmg9OD/vHQ79r4qQKUbU5CqJk8SjneEpCu7OohmRrGYSYkr6MCdP0JKrZllhXTsM=
X-Gm-Gg: ASbGncs0AaeB0BdzKC2H5Hx7L2WIY+SCmsEnAcba2SfiefDrrYwk/ZU+xd4yRtZfyaR
 AfEvgrYdtWVqp/5i5MPUziQklCXHEGcj7RXTMx4t0S41Eol3ZoBTwFvttatC9d3NTLZWEUrB8IT
 s6GdqD5e7ittxmUcZ+InEoZqFBXfz3YtexOK10g9E9krJgTuWecV7AgSc59RlREKUfyNplab60x
 wfuF+qmNGjAgdiku9ZYEtv724rfeh3Dhbp0wwjGzlfj51KIGuafKDiSGmfeIp2JfuqSNAFV9P1C
 Ut5/0UTatjtGkPWmJiWAkyqDT26rqlmI+Ownscq/bLpLOP/kagPNS+A9XPgZ2FHdeDvooTUsBvM
 7CzW2HO4CILbvQegqFgcvf+9IoWYwLLGUsI+VlTtgXLdO79lRwZ0pgKCIdJWw1pw55SVfA+1S6w
 OhRXwExpTWZQZq6RYTVPfiYMFAP9Ige8kcmrKIfw==
X-Google-Smtp-Source: AGHT+IHLZ9RdIAX1JGQZ+ntcp/wQXyvE+8PCpke+wuQifD+xm8XlJgSZVEjiwzOVBvmc+PeTE+bBHA==
X-Received: by 2002:a05:6830:6585:b0:741:a5f0:bc82 with SMTP id
 46e09a7af769-7c27cb46301mr9929939a34.17.1761147154679; 
 Wed, 22 Oct 2025 08:32:34 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28879e84fsm4711628a34.7.2025.10.22.08.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 08:32:33 -0700 (PDT)
Message-ID: <79beaf9a-9558-40e7-a01d-5f80d8931eba@linaro.org>
Date: Wed, 22 Oct 2025 10:32:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Pass actual memop_size to tlb_fill instead of 0
To: Nikita Novikov <n.novikov@syntacore.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20251022115213.91457-1-n.novikov@syntacore.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022115213.91457-1-n.novikov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 10/22/25 06:52, Nikita Novikov wrote:
> Recent debugging of misaligned access handling on RISC-V revealed that we
> always call `tlb_fill` with `memop_size == 0`. This behavior effectively
> disables natural alignment checks in `riscv_tlb_fill_align()`, because we
> have to fall back from `memop_size` to `size` when computing the alignment bits.
> 
> With `memop_size == 0`, misaligned cross-page stores end up reported as
> `store access fault` (AF, cause=7) instead of the expected
> `store page fault` (PF, cause=15), since the “misalign” path triggers before
> the second page translation can fault. This breaks misaligned accesses at
> page boundaries.
> 
> After switching to pass the real `l->memop` into `tlb_fill`, the cross-page
> faults are no longer mis-classified as AF.
> 
> Fixes: ec03dd972378 ("accel/tcg: Hoist first page lookup above pointer_wrap")
> 
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 631f1fe135..271c061be1 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1782,7 +1782,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>            * If the lookup potentially resized the table, refresh the
>            * first CPUTLBEntryFull pointer.
>            */
> -        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
> +        if (mmu_lookup1(cpu, &l->page[1], l->memop, l->mmu_idx, type, ra)) {
>               uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
>               l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
>           }

How is the memop really applicable to the second half of a split-page operation?


r~

