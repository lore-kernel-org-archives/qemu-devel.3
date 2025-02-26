Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852F1C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIQD-0000f6-3Z; Wed, 26 Feb 2025 09:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnIQ9-0000e8-5T
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:29:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnIQ6-0001jy-Rh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:29:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso60399005e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740580193; x=1741184993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haPH8Hps0tqtuB3HirXD/jQb6LYEBqe6kqfNTpwisNE=;
 b=q1LXJdoFl79soAX7+h57B5ulxZy55P2ZCnRUb3RGoGqfe5Yb++rgWUivwWeclScEOf
 YeUmRbfmefPfxhmts4HUSap2xOID47A4tV+c3hN9fsYdtMzAhssYQAHdCHUMWw/bu+GP
 1WNfqD3nV3vpFuD00Fehw+WCH732aINDUIIsoglgzi51O7Zs/VYea15vh+gyEs/qQ+db
 nev80P/dPn2dDbjVG2I3gd/75P2rnslnAt1mLXNGPfhqbkXyECthgSP18XQ+BkjhyZg4
 50dVHJYIKvWf3DV6w+iVYkcHzRtGK7YtLtcQJZIC7tWKz1Bj2r16IpDjZfzR/jNDAj7m
 sC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740580193; x=1741184993;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haPH8Hps0tqtuB3HirXD/jQb6LYEBqe6kqfNTpwisNE=;
 b=YSPbL6UgYx4m8wptalEKeIJ+YbkpJvDvtq/eeZWVW1GIB3qsSPiG6hHU2dokt8dyrJ
 hoKATRnP8/6AVuWOQR+ENVFTGjBKmvf0ZuCSBpfs8OoaU5a8uL50LHgLfcaUy3gfctu4
 vLu3mt8XB69TV2XMX0lsvM8YrrMZDLdOQO3hjdrk0QR7y5SwkCCHRhxdkRAevizjh2GB
 8q7qwwJzhwI3udCIYyDTMi0zbRfoQnr4qya2IJNI3XBH+XBK3gX94EfBX4hnOmm7ksY9
 qlZfq1GBMNQWU0hYGSzSrxoN5M4e99XMs2R1OSOqdqj9f+s4LJncSfuTN14Dolrf+2C+
 72qw==
X-Gm-Message-State: AOJu0YxX59nQHAJXABaFY58oCJetPgr9pmasxtn2cySDPV+pON5ctzXH
 GCRNL+uLNdJ2CTB4GeOgsYf8qah96Mxuz/ZjFxd2WorgkEn3W+6UhMs8fV+U6GA=
X-Gm-Gg: ASbGnctF+lLGKj2aWw/6OwQkwszXJ1fAo4qjwU0oWKR7fQyzGv0pAgisobeV9W/OdW/
 HDcywO77/n9DSgJzzIpR1Twz86qyL+8mP+A4tOly6sLOpQXhrAwWKo+rFQXwvTzsHt5MBO+r4xi
 PucBPfkpihGLLjDjEu3XDcCtAPNAUFVFeJxf8mw7SHmeNpTWn+844n+pkzwwskw60+SqKAqBrqY
 uUMNG+qRwz4Wi17kYb9zHja7DRuL97VfcUFbPgsfX53ZtB56/kU2iZXP/JgvGJTcEO5nJkiyV5Y
 Pfk3R/0DFtf/TUxtaGQmThexAO55
X-Google-Smtp-Source: AGHT+IFCwqd2lEkReOt4FxaE9LcLdO9E+9p14O5qcvITN5zBpC+NIAY1DQPqTcG43Uq5MdZDbkVh6A==
X-Received: by 2002:a05:600c:5103:b0:439:5da7:8e0 with SMTP id
 5b1f17b1804b1-43ab8fe2fe9mr36991645e9.16.1740580192730; 
 Wed, 26 Feb 2025 06:29:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5393e5sm23409395e9.20.2025.02.26.06.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:29:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62C975F924;
 Wed, 26 Feb 2025 14:29:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,  Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  qemu-ppc@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/4] cputlb: introduce tlb_flush_other_cpu for reset use
In-Reply-To: <d033b2d7-a2b6-4ed8-ac46-85b52d46f8ea@linaro.org> (Richard
 Henderson's message of "Tue, 25 Feb 2025 11:49:33 -0800")
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-4-alex.bennee@linaro.org>
 <d033b2d7-a2b6-4ed8-ac46-85b52d46f8ea@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 14:29:51 +0000
Message-ID: <877c5c4w4g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/25/25 10:46, Alex Benn=C3=A9e wrote:
>> The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
>> TLB flushing) introduced a regression that only shows up when
>> --enable-debug-tcg is used. The main use case of tlb_flush outside of
>> the current_cpu context is for handling reset and CPU creation. Rather
>> than revert the commit introduce a new helper and tweak the
>> documentation to make it clear where it should be used.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v2
>>    - appraently reset can come from both cpu context and outside
>>    - add cpu_common_post_load fixes
>> ---
>>   include/exec/exec-all.h   | 20 ++++++++++++++++----
>>   accel/tcg/cputlb.c        | 11 +++++++++++
>>   accel/tcg/tcg-accel-ops.c |  2 +-
>>   cpu-target.c              |  2 +-
>>   target/i386/machine.c     |  2 +-
>>   5 files changed, 30 insertions(+), 7 deletions(-)
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index d9045c9ac4..cf030001ca 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, v=
addr addr);
>>    * tlb_flush:
>>    * @cpu: CPU whose TLB should be flushed
>>    *
>> - * Flush the entire TLB for the specified CPU. Most CPU architectures
>> - * allow the implementation to drop entries from the TLB at any time
>> - * so this is generally safe. If more selective flushing is required
>> - * use one of the other functions for efficiency.
>> + * Flush the entire TLB for the specified current CPU.
>> + *
>> + * Most CPU architectures allow the implementation to drop entries
>> + * from the TLB at any time so this is generally safe. If more
>> + * selective flushing is required use one of the other functions for
>> + * efficiency.
>>    */
>>   void tlb_flush(CPUState *cpu);
>> +/**
>> + * tlb_flush_other_cpu:
>> + * @cpu: CPU whose TLB should be flushed
>> + *
>> + * Flush the entire TLB for a specified CPU. For cross vCPU flushes
>> + * you shuld be using a more selective function. This is really only
>> + * used for flushing CPUs being reset from outside their current
>> + * context.
>> + */
>> +void tlb_flush_other_cpu(CPUState *cpu);
>>   /**
>>    * tlb_flush_all_cpus_synced:
>>    * @cpu: src CPU of the flush
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index ad158050a1..fc16a576f0 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -417,6 +417,17 @@ void tlb_flush(CPUState *cpu)
>>       tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
>>   }
>>   +void tlb_flush_other_cpu(CPUState *cpu)
>> +{
>> +    if (qemu_cpu_is_self(cpu)) {
>> +        tlb_flush(cpu);
>> +    } else {
>> +        async_run_on_cpu(cpu,
>> +                         tlb_flush_by_mmuidx_async_work,
>> +                         RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
>> +    }
>> +}
>
> I'm not convinced this is necessary.

I guess we want something like:


/* tlb_reset() - reset the TLB when the CPU is not running
 * cs: the cpu
 *
 * Only to be used when the CPU is definitely not running
 */

void tlb_reset(CPUState *cs) {
     g_assert(cs->cpu_stopped);

    for (i =3D 0; i < NB_MMU_MODES; i++) {
        tlb_mmu_flush_locked(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i]);
    }
}

?

>
>> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
>> index 6e3f1fa92b..e85d317d34 100644
>> --- a/accel/tcg/tcg-accel-ops.c
>> +++ b/accel/tcg/tcg-accel-ops.c
>> @@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>>   {
>>       tcg_flush_jmp_cache(cpu);
>>   -    tlb_flush(cpu);
>> +    tlb_flush_other_cpu(cpu);
>>   }
>
> I would really like to believe that at this point, hold phase, the cpu
> is *not* running. Therefore it is safe to zero out the softmmu tlb
> data structures.
>
>>     /* mask must never be zero, except for A20 change call */
>> diff --git a/cpu-target.c b/cpu-target.c
>> index 667688332c..8eb1633c02 100644
>> --- a/cpu-target.c
>> +++ b/cpu-target.c
>> @@ -56,7 +56,7 @@ static int cpu_common_post_load(void *opaque, int vers=
ion_id)
>>       /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
>>          version_id is increased. */
>>       cpu->interrupt_request &=3D ~0x01;
>> -    tlb_flush(cpu);
>> +    tlb_flush_other_cpu(cpu);
>
> Likewise, in post_load, the cpu is *not* running.
>
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index d9d4f25d1a..e66f46758a 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -401,7 +401,7 @@ static int cpu_post_load(void *opaque, int version_i=
d)
>>           env->dr[7] =3D dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
>>           cpu_x86_update_dr7(env, dr7);
>>       }
>> -    tlb_flush(cs);
>> +    tlb_flush_other_cpu(cs);
>>       return 0;
>
> Likewise.
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

