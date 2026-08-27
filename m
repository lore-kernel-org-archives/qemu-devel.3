Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF57CC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgKI-0002Ni-SK; Thu, 27 Aug 2026 16:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgKE-0002NL-Od
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:03:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzgKC-00086h-Ql
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:03:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso2081955ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787861027; x=1788465827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j7e3hoduAqmNb6klSwN8F1H1zFa/hUTgMKq9pWglAX0=;
 b=D6DX0yyU0EJR0CVD/36hhWZdGae9GCBwr021pibkqgHNp5ju4QVM1rkWSK1A1vFTrC
 iCFfhXiyM/UczWIIng3nO+hOqcdEorTy7z31/w6l/C6e1Aji7E2e13PLBSTnnnpnVdLC
 xQN7ixmCkkavOdhLTVw7Dpw2Pg49KkvbQaBj0ufjPxQo/CRhxisK455ePOTcempjgIBs
 ZhMeHdZYQgULOXF8h5kA0cp3rPID/XTZ5AekeZ6nmWXm6x7QJqmQWiC39IaIXg3f1/b5
 o24/TlZhWXf9oLFAgEX/UGTiinhAtejWkuBhbWP1kZcuOUFmb63tSf6syizO/Fwbc6ZZ
 BooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787861027; x=1788465827;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j7e3hoduAqmNb6klSwN8F1H1zFa/hUTgMKq9pWglAX0=;
 b=LiiZdwAFaC7E4ukQ9kbt577owyhSMtMpkyIWT3qyBwwcT8Tu8urX9ju+NewSLch23R
 1lNS6D5ukpfdDlJ5oBLLGRro0XuPna5gxRVHESUkKn3D3tloD4RvzlScxd89ilfyDQw6
 Yzyw9w1Fm/99ehchaQiqK+GkpL/KYY+JNQLpMrtlDtgDYp2C+UUdRmSIDQYNNAg3Q7g9
 dU62g0hveyn9C7l7MUrwqRyNKj4NEVNQjiU2R1FbGHJHzlVgLeReukhxlmJ6wpNpY8yS
 cQWAUi6DuItPC6g6rnwa5C2ZQ/qTl+gieUKbFHgvT4iZc+tpbw9IlfMMPj2x5d7rL5dt
 6CfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfFHdGvYAtEA2v2hm1j6flWgtFVKkSpAGjLi1wtUQdffMRzgzHbtN1oTvx8jf8WDPmPT/U/Cmzr0sR@nongnu.org
X-Gm-Message-State: AFuF++meEG6d7OzApb/W9a9YmccnYrLQ01cIC8cmmk8qV/IJCqsLn7uD
 +nMQzbw7Wa9ftCaXaRcQQ1IJQ3YiMaAv7Q1g64urEJYfOV6/ydCTPsv6CQtHXEmwAE8=
X-Gm-Gg: AR+sD10bS7kId30iykq6AmCs11GQziAHIQF0WF/MTzg4D7TgP+rRioem3rWHHRy4lUl
 joe+coaE5RxbFEPTKYwBk47U4hzw0vIfo4qdag0cavkdgAP/XZ1VjwslVT+V5bLcPnh/svJ7Ywy
 kRpaGeq3qwjZBmqmEKiEwD9dzbqDHRYiKnv/cC87C7Zjmm7XSICIeD2QQIvFAdsslL0M0PxDfsq
 7GxySqKiDE7bgfF2YWh+S2TWRLpeAOVDFxJlBjvu32aUJ5xjxCgcAPGY777DRATu+OHbOjN7KN0
 y9mqWi5W5bKPBRwcYVpHp3+OsBHGor2p/VI+J4DctaQymGTtZMZN/3EJay+M//Ru2K4gu9p+W1z
 VZ+YyMdkDqnAQvk54p0tz4ajnzViYacbfzkd/IT+r3FxmuNrgIzsV/Hj9x1pv1dOMUNj31lSU3q
 KSPtCbjhzSAUYJHQSgAjB9lSe5eDSjO1OfW1M6hfYZvLN+QBgYQX9i2XaQE5xoLu8fcacRRiLvG
 UdvDXEpQZRrMUpdh2mtCwZVL5VUC7mWzn48EZw=
X-Received: by 2002:a17:903:1ae4:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d74dc514f4mr26768065ad.4.1787861026914; 
 Thu, 27 Aug 2026 13:03:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70497730asm19695345ad.21.2026.08.27.13.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 13:03:46 -0700 (PDT)
Message-ID: <0a19da5b-e50f-447e-9630-37f951cc94db@linaro.org>
Date: Thu, 27 Aug 2026 13:03:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] accel/tcg: give the TB jump cache a second base
 pointer for generated code
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-6-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827050241.3713332-6-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/26/26 22:02, Matt Turner wrote:
> +/*
> + * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes the
> + * slow path when the entry it finds has a NULL tb.  Pointing the probe at a
> + * region that is all zeroes therefore forces every indirect dispatch into
> + * helper_lookup_tb_ptr(), which does the full lookup the inline probe only
> + * approximates.  The real jump cache is untouched, so no contents are lost
> + * and recovery is a single store.
> + *
> + * Only ever read from, and only one entry per dispatch, so one shared
> + * zero-filled cache is enough for every CPU.  Not const: that would put a
> + * megabyte of zeroes in .rodata and so in the binary, where .bss costs
> + * nothing on disk and only faults in the handful of pages a poisoned run
> + * happens to probe.
> + */
> +static CPUJumpCache tb_jmp_cache_poison;

Hmm.  Maybe we should mmap it at startup then, because while we're not 
supposed to be writing into this, it would be nice to enforce that.

> +/*
> + * Poison @cpu's probe, from any thread.  Called when a breakpoint is
> + * inserted, which is what makes the poison take effect at the dispatch
> + * after the insert rather than whenever @cpu next reaches its main loop:
> + * a vCPU chaining indirectly need never reach it, and would run past a
> + * breakpoint another thread had just set.
> + *
> + * A plain store is enough.  The value only ever costs a slow path that is
> + * correct on its own, and the generated code re-reads the base on every
> + * dispatch.  Un-poisoning is tcg_cpu_sync_jmp_cache()'s job.
> + */
> +void tcg_cpu_poison_jmp_cache(CPUState *cpu)
> +{
> +    if (qatomic_read(&cpu->tb_jmp_cache_probe) != NULL) {
> +        qatomic_set(&cpu->tb_jmp_cache_probe, &tb_jmp_cache_poison);
> +    }
> +}

Why do we need to check for NULL?

> +
> +/*
> + * Called from the main loop, which is the only context that can establish
> + * that no reason to be poisoned is left.  Cheap enough to call every time
> + * round: the common case is a load, a compare and no store at all.
> + */
> +void tcg_cpu_sync_jmp_cache(CPUState *cpu)
> +{
> +    CPUJumpCache *want;
> +
> +    if (qatomic_read(&cpu->tb_jmp_cache_probe) == NULL) {
> +        return;  /* not realized, or already unrealized */
> +    }

If this function is only called by the main loop, we shouldn't have to 
deal with either unrealized state.

> +
> +    want = tcg_cpu_may_dispatch(cpu)
> +           ? cpu->tb_jmp_cache
> +           : &tb_jmp_cache_poison;
> +
> +    if (qatomic_read(&cpu->tb_jmp_cache_probe) != want) {
> +        qatomic_set(&cpu->tb_jmp_cache_probe, want);
> +
> +        if (want == cpu->tb_jmp_cache) {
> +            /*
> +             * Un-poisoning races a concurrent tcg_cpu_poison_jmp_cache():
> +             * the reason may have appeared after tcg_cpu_may_dispatch() read
> +             * it, and the poison may have landed before the store above.
> +             * Order that store against the re-read below, so that the race
> +             * is lost in the safe direction.
> +             */
> +            smp_mb();
> +            if (!tcg_cpu_may_dispatch(cpu)) {
> +                tcg_cpu_poison_jmp_cache(cpu);

Why do we need to check for breakpoints twice?
I don't think I understand this race.

I'm not familiar with how gdbstub interacts with user threads, but this 
feels overly complicated.  Up to and including needing to poison the 
jump cache just for adding a breakpoint.

I suspect what we need is to add a CF_NO_GOTO_JC flag that suppresses 
the inline jump cache, which is set whenever any breakpoint exists, 
which falls back to the helper, which checks for breakpoints.

Conveniently, you've already shown how to adjust tcg_cflags from 
gdbstub.  :-)


r~


