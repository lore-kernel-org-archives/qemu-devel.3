Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1AD10F55
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 02:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCru2-0001DR-Cg; Sun, 17 Nov 2024 21:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tCrtz-0001DD-M2
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 21:54:11 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tCrtx-0006Sn-Re
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 21:54:11 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ee7e87f6e4so1294908a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 18:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731898448; x=1732503248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3oi7hlEYrPTU2on4Zxo9nj0hVVqroufyEKNN8B/ol+A=;
 b=AfPAQ1QgHg/df4olQstsujBSQ+sCg6J8J6ne+I+0cT7WaTiwYPnEHrST/WMIJMGRp2
 TaEHKUFHLIAcH4y2JaQUQUBUbazIUjqF2DPYz6T6jCTsYTCFQODPsP8opTwTlSedqQry
 C924/w3s96eYytcCN4tPQCGmxx5LTFcvhagWpT2VhaQozOYjrEjpveh1bF5P73OZhrkv
 4Zr1KGihAkMyMd7NgSzbaO9SUjdjvITBBj/dibS9y6GW0wbszRpbPgb2shrUsnf3Jzm7
 n2H/u9qPeC5bw7mgZR/PRBRhxlg3Bm7coXeTHqj58BzSOyG4XdRJIRoLpa5ZJaVLYKof
 dOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731898448; x=1732503248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3oi7hlEYrPTU2on4Zxo9nj0hVVqroufyEKNN8B/ol+A=;
 b=ECQMtv3I8cUIQwBFPf7ulkKgR84NqXgv5lTGI8oGl+cIfJS4ssmiXkhG7g+l00vSAN
 AtlTKNu3rHLHRnXUSltLJSx3r46mAs19hM35d0PaG0WTnysCNNDi/5BFSE+0ZZWrV8dP
 s/n4MbMBGAHV+SCC/TxbQOnQmvR7n4YK83JVG46GTuc/33wZ6EQ5YM+W4GgqrYQ1zm8J
 kBBFF8eaHKpHybXL06vnXNZj+YSqjDfaZ1Wd76O+g7LujTGmqwGmjE43OKb+iFwxuYgB
 I5z3piz/7c6okAwpLxpMRRE6MpSHoTRGb4xwy3cO0iTV0T9kG2h+ERzQh4mlPQGvYRZS
 g9sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEisxKlvkrQ2T3TLhn9LjnvaHK/+4fnWKDel8FVVRvU69wDvZxLpl8NULG5PFQD6QpOD/M5aqIu6p@nongnu.org
X-Gm-Message-State: AOJu0YwWrbI29rfTr73W4jA36qJ1g6Md7SL2kFix2xhnQOHZj8hP9Pf3
 bW3oOvF1doEQUHOK7wiUlF/Ifs3KURSFgE1gCwBnQo4uy9XpHRFjuGO9G0ss6bI=
X-Google-Smtp-Source: AGHT+IFL7MrPAps/AOOQ31R26BWJu6VPDtehbFWlL+n62Li1bACrsti9qMIqf+jigGZHp/fl3IDaPA==
X-Received: by 2002:a05:6a21:9999:b0:1db:ec3e:c959 with SMTP id
 adf61e73a8af0-1dc90b2354dmr16550276637.10.1731898447856; 
 Sun, 17 Nov 2024 18:54:07 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea7752f0a0sm792084a91.50.2024.11.17.18.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Nov 2024 18:54:07 -0800 (PST)
Message-ID: <c5e8775d-8fed-48f5-bf4e-828982f6c2d0@linaro.org>
Date: Sun, 17 Nov 2024 18:54:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
 <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
 <6bf88d71-e3a1-4143-b770-34e9bafb892b@tls.msk.ru>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6bf88d71-e3a1-4143-b770-34e9bafb892b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Hi Michael,

On 11/16/24 19:49, Michael Tokarev wrote:
> 25.10.2024 20:58, Pierrick Bouvier wrote:
>> When instrumenting memory accesses for plugin, we force memory accesses
>> to use the slow path for mmu [1]. This create a situation where we end
>> up calling ptw_setl_slow. This was fixed recently in [2] but the issue
>> still could appear out of plugins use case.
>>
>> Since this function gets called during a cpu_exec, start_exclusive then
>> hangs. This exclusive section was introduced initially for security
>> reasons [3].
>>
>> I suspect this code path was never triggered, because ptw_setl_slow
>> would always be called transitively from cpu_exec, resulting in a hang.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
>> [2] https://gitlab.com/qemu-project/qemu/-/commit/115ade42d50144c15b74368d32dc734ea277d853
>> [3] https://gitlab.com/qemu-project/qemu/-/issues/279
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> [1] is in 8.2.x. [2] is in 9.2.tobe, and marked as should be picked up
> for stable (I picked it up for 8.2.x, 9.0.x and 9.1.x).
> 
> Shouldn't this one be picked up for stable too, as an addition fix
> ontop of [2]?  Or is it not important? (I guess since it's reported
> in our issue tracker, it is problematic for someone already).
> 
> I picked this one up for 8.2, 9.0 and 9.1 stable series -- please
> let me know if I should not.
> 

You can safely integrate this on all stable branches. It will fix the 
issue with plugins, and might possibly fix an issue with the memory 
access if someone hit that path. The original problematic change was 
missing this fix from the start.

> Also, what about the 2/2 in this series, "cpu: ensure we don't call
> start_exclusive from cpu_exec", which is 779f30a01af8566780cefc8639505b758950afb3
> in master now?
> 

It's an assert to ensure we don't hit the same blocking situation in the 
future (with new changes), so I don't think there is an added value to 
integrate that on stable branches.

Thanks,
Pierrick

> Thanks,
> 
> /mjt
> 
>>    target/i386/tcg/sysemu/excp_helper.c | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
>> index da187c8792a..ddc51e3e0b8 100644
>> --- a/target/i386/tcg/sysemu/excp_helper.c
>> +++ b/target/i386/tcg/sysemu/excp_helper.c
>> @@ -107,6 +107,10 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>    {
>>        uint32_t cmp;
>>    
>> +    CPUState *cpu = env_cpu(in->env);
>> +    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
>> +    g_assert(cpu->running);
>> +    cpu_exec_end(cpu);
>>        /* Does x86 really perform a rmw cycle on mmio for ptw? */
>>        start_exclusive();
>>        cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
>> @@ -114,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>            cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
>>        }
>>        end_exclusive();
>> +    cpu_exec_start(cpu);
>>        return cmp == old;
>>    }
>>    
> 
> 


