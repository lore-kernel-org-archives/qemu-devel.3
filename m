Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75BCE8304A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 04:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn80N-000120-EV; Mon, 02 Feb 2026 23:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn80L-00011d-Fe
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:27:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn80J-0006dF-VV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:27:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso35010865ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 20:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770092826; x=1770697626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tUvty6tucvAvNgK45YmFODo3VxrvhkinANw58bVjh4Q=;
 b=t0IdQ35yAFM9iFdQKMXD8NrMmDAIsREWVlPAPWu6Y77UCj8ZnBPMEbWZvJ/iY5DtP3
 uPxh/zK8kqHWZoJzhFhxILDshdmS1km/NYqfBXU+uY9JO24qb0bEhN4NRUMv485CnP0M
 cBBMFjIwOFI7zc52SXmjovPRbr8nXhn4rR/Zq81ErjO1GCGicrWYW8q6AtAYBdUScUTI
 xdgKYjc0bNLDUrZquwQQfY8D89jOJM/Kqa8bbDmbc7vqhOAD7mR6f6QIe+rJSP2Dq+vH
 D/PcNBjwT4aRQwOcwZW/tOUxRxHGih0FOuM90PfS+cOYFsuohzUDBznxGPmSLXSNw3sl
 ajmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770092826; x=1770697626;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUvty6tucvAvNgK45YmFODo3VxrvhkinANw58bVjh4Q=;
 b=eIXrWGpDB7/PyQG61WhwMXrdyhBcUS/VUHG7Ta5LwyPUnrIb5XEyr1s9dmtY/jIsp2
 sEu9xVWZXgb4WkjDZV5b8qE7oixb+P0BlQJ0SZNe0cip70cv7q1qc2X0lZIz3yO1KXgW
 9pZmuIERvxVpsNHKVhbbdaT7GdqbkbJC4kr9V08hmuKTKPMclkYbaIb6MIXbFZE49H5n
 aDfXrzkyqc/Vvs1d0zFaPqd8JhHY6bQE299EqWwQ4+cRVgwlcnLTvbeoQsRHGXyXFwqb
 BciSgDw1VzhBWGb9SKzy96QHyOxerkjnDT0qf2XZADD6fG8pb4jgLc/DYnq7xNxtJOeh
 Izvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCSYsSX+ufVZ/9dqIQUb+Xcqf04Kqpt+B5yxVM4A+qTkesnTcP8OLMXCIT9cGOKVnMf/I5vcOkMQwU@nongnu.org
X-Gm-Message-State: AOJu0YzFU9bUp3dUyT6OqSvbNcSM4KeVnXd7MZgQUEmcWBIX+NAuXOYh
 b2CucwMKNCaDi0IBe7vf17Bp3zYmwAywmaH4WAeHamuN2ACgAvJbpBTl/KA62FMD988=
X-Gm-Gg: AZuq6aLaDrLnF0vFNr3XBmG2k9ZDBp0WRu3HxGBTIp6Xh47Xw9sUpqWu8cErY69E5C8
 UTnJpq3BP3oGItu1aBAJ8MoF64WXZB2lNvpmB53lNCrKnKHJ7V8DtGvdpPGCXctsxxzQtYQyXDT
 5x/qP4mTj0EvB05A73h6FdAVZeeKNmSj/LGQh+z4ARGxAe33++m71gv2YLv8Sig9rvnErfUQly7
 YsMMedTDftr/tkuhy1XvRaqWhFmeCog6WAXStHwI7DzfyvM/67Uu1mvf2IUPYjRofgzpEhKYLsN
 XIZRuzCn9Gbl1yrG703afew1T8y7DRuHNRclG6Qu9JQHd8X4cGc/t2ZmHKnhJgJveeOpvyjh5Bx
 KuaUv5OxVrbMUKhShnL5rp0Oi00VG/+FCl3iTpOOb1djJZOAC6w6HSzzfPo9ApW4bfUCiPbPz1v
 MWzkT9EESxnxSFkXre1Awi3Ub6lVqMP3UhyjSHaQ/8I0S8OxFBRcox27Yw/Pz9AMt53v+eucNkn
 YtF3jKsWRGT3rhfMxkRt50OMvvQWmQLmc9WvLTGZBfyhzcp6lyP
X-Received: by 2002:a17:903:2f8a:b0:2a7:5171:9221 with SMTP id
 d9443c01a7336-2a8d99440eamr127930435ad.42.1770092825663; 
 Mon, 02 Feb 2026 20:27:05 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b415b01sm159233995ad.40.2026.02.02.20.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 20:27:05 -0800 (PST)
Message-ID: <74937448-5e7b-4c95-95ec-fe0bcc999260@linaro.org>
Date: Tue, 3 Feb 2026 14:27:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "tcg/user: do not set exit_request gratuitously"
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
References: <20260202091753.28459-1-pbonzini@redhat.com>
 <7ed0c393-4d3c-44fb-a0e7-bd4375772c2b@linaro.org>
Content-Language: en-US
In-Reply-To: <7ed0c393-4d3c-44fb-a0e7-bd4375772c2b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/3/26 12:50, Richard Henderson wrote:
> On 2/2/26 19:17, Paolo Bonzini wrote:
>> This reverts commit b422a7bff64eaf55b8250225533ca1df42c3777e.
>>
>> The reporter says "The commit breaks go; if you run go build in a loop,
>> it eventually hangs uninterruptible (except -9) with a couple of zombie
>> children left over".
>>
>> Reported-by: Andreas Schwab <schwab@suse.de>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   accel/tcg/cpu-exec.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 7c20d9db122..ad94f96b252 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -751,7 +751,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>   void tcg_kick_vcpu_thread(CPUState *cpu)
>>   {
>> -#ifndef CONFIG_USER_ONLY
>>       /*
>>        * Ensure cpu_exec will see the reason why the exit request was set.
>>        * FIXME: this is not always needed.  Other accelerators instead
>> @@ -759,7 +758,6 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
>>        * CPU thread; see kvm_arch_pre_run() for example.
>>        */
>>       qatomic_store_release(&cpu->exit_request, true);
>> -#endif
>>       /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>>       qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~

