Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764C8CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4LRF-0005By-D5; Thu, 02 Oct 2025 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4LR7-00059Y-Od
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:41:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4LQq-0006sm-T6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:41:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso1201477b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759419675; x=1760024475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Px2emP6ROhkv4xGAfiqCflc4uecgiLeSHdwUtniKE24=;
 b=Q3VcZC9SXw4Z0XPDA0FxE2IhdXUn3nM6VQmhTlhNTpl9lj1SMP1cRCQZUejraKjgwo
 fz5dBSA43ZVZBqgIops/ff8b9vq/iO7YC2/xlSOZZ7i3rYgheqz3WyWHw2gIVpDzZNZY
 AEs+JxXm41Fq5CHypB7B0HdKowhhJHGdug1JINJ2RhpWdm+wDYHqQhGNmyYhuOIZvTxu
 Z/i7BcK+ctIktGDOB0027Y+Ge5IHtSHX9CbDr3bOTi2wrDDQba3RVNwQnPCXAMvSWnQp
 PQZ9fkXgQeE+yViJZ7LWm6a8YLVI7sZVE6SI/2CVhbQVvUzzW9vCWTe/Q/n0GZh1HGOb
 bCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759419675; x=1760024475;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Px2emP6ROhkv4xGAfiqCflc4uecgiLeSHdwUtniKE24=;
 b=iXJ0y/G9fpgzLeonr/Ycq0bstPioPIE2xXRmXVS80oHr3rpdUS60HpBuTDBLIpF1DM
 V9p63zknGUSwP5d4YSxVj2UKv0DTD++IFl6vPoNF/UysmB07OmFMlqV8kP0u371LTR0L
 +hT5/wzSSkNucGevGJgONYQ/NIWo5K58KWaZAZR9vrFzrrFzy0no2V2EOlEPfLlqK2gh
 X3Z/ld5KIra/iCP+yemPB1zOH6LRAAJMCOxVQ2spJ5IjNtZReTj18zrkCDx13zUXzXc7
 uAoLTrAkFHcTjszcYMqRRt38v0o6PYm5A3gWpxVfrPpVBw+TJ9nNxAisdlqf8KvnOwB+
 lmaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHVeLfccCZY6pIFPMxYFNXuwodQya19mYWvr7T5Zuk4I71eprcptXW1T8A9qv9b6bEyDHyWvM2KlKo@nongnu.org
X-Gm-Message-State: AOJu0YygLzwDMCTH4mxvUr6s2L6WANOLZ6droOiVWDkWKepuicBGjAHK
 Lhy42Hwf81/cKPgh3SFJtZaqImEhPYBupsv/K1u/iqh7OBJimLUk4l/5iK9TtJmXtjc=
X-Gm-Gg: ASbGnctXM9Za5gMAd1Y3NkNqZ7uqpFktFaW7ko9uf4kNVnl0LL4XHnXky4NRKD+lir1
 jxY1/PO7hiEL7ytcvzvI+LogvfGtg0ka3VtpPUz1aKdun4uqTKTUbSyphBT30tFdxANhmx5QgUT
 fHjm0JkKug8rXOVl4nRm/Wd9y2HV9DG+gOkfWWXk5e438GJZIWfLgyTCH/8t/u0PMoIvlSSmgkn
 EbIjBE5mQ+KrfSgCGOwObd6fA7o8At/2YF4GVUJlqz3UY5/iwZol/YBHONAhyZtQlOVH94aSNB3
 U5OQkc2PVjGs5cSwsb5mLsU0l2gUeO6eaESoi01i4ALdVtAuOZui2csD8QTR6LFiiWDAq1lSXTP
 9HafEy7t3AF2JHCtqfmssnzFdmmri72vsFZW5k1Y1sWRa1ts7bTnEaCmwNwLkQHDL
X-Google-Smtp-Source: AGHT+IH7iz1L8xKKJ9weFkuet7A3+RStIapsBDfVili+8Hb3PVwY9tf/4h5U4hyAvTcqskYZ12oS0w==
X-Received: by 2002:a05:6a00:238d:b0:781:1cc0:d0ce with SMTP id
 d2e1a72fcca58-78c98cae836mr55041b3a.16.1759419674665; 
 Thu, 02 Oct 2025 08:41:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f9cda9sm2452099b3a.13.2025.10.02.08.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 08:41:14 -0700 (PDT)
Message-ID: <7605b216-8aa1-4897-a96e-6ed9953f4e91@linaro.org>
Date: Thu, 2 Oct 2025 08:41:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 24/24] tcg: Defer TB flush for 'lazy realized'
 vCPUs on first region alloc
To: Salil Mehta <salil.mehta@huawei.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-25-salil.mehta@opnsrc.net>
 <60631203-626f-4628-8a40-226bd45d1c8e@linaro.org>
 <bc780e0c68fa44da975d8f6fcdb38cd7@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <bc780e0c68fa44da975d8f6fcdb38cd7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/2/25 05:27, Salil Mehta wrote:
> Hi Richard,
> 
> Thanks for the reply. Please find my response inline.
> 
> Cheers.
> 
>> From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
>> devel-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Richard
>> Henderson
>> Sent: Wednesday, October 1, 2025 10:34 PM
>> To: salil.mehta@opnsrc.net; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; mst@redhat.com
>> Subject: Re: [PATCH RFC V6 24/24] tcg: Defer TB flush for 'lazy realized' vCPUs
>> on first region alloc
>>
>> On 9/30/25 18:01, salil.mehta@opnsrc.net wrote:
>>> From: Salil Mehta <salil.mehta@huawei.com>
>>>
>>> The TCG code cache is split into regions shared by vCPUs under MTTCG.
>>> For cold-boot (early realized) vCPUs, regions are sized/allocated during
>> bring-up.
>>> However, when a vCPU is *lazy_realized* (administratively "disabled"
>>> at boot and realized later on demand), its TCGContext may fail the
>>> very first code region allocation if the shared TB cache is saturated
>>> by already-running vCPUs.
>>>
>>> Flushing the TB cache is the right remediation, but `tb_flush()` must
>>> be performed from the safe execution context
>> (cpu_exec_loop()/tb_gen_code()).
>>> This patch wires a deferred flush:
>>>
>>>     * In `tcg_region_initial_alloc__locked()`, treat an initial allocation
>>>       failure for a lazily realized vCPU as non-fatal: set `s->tbflush_pend`
>>>       and return.
>>>
>>>     * In `tcg_tb_alloc()`, if `s->tbflush_pend` is observed, clear it and
>>>       return NULL so the caller performs a synchronous `tb_flush()` and then
>>>       retries allocation.
>>>
>>> This avoids hangs observed when a newly realized vCPU cannot obtain
>>> its first region under TB-cache pressure, while keeping the flush at a safe
>> point.
>>>
>>> No change for cold-boot vCPUs and when accel ops is KVM.
>>>
>>> In earlier series, this patch was with below named,
>>> 'tcg: Update tcg_register_thread() leg to handle region alloc for hotplugged
>> vCPU'
>>
>>
>> I don't see why you need two different booleans for this.
> 
> 
> I can see your point. Maybe I can move `s->tbflush_pend`  to 'CPUState' instead?
> 
> 
>> It seems to me that you could create the cpu in a state for which the first call
>> to
>> tcg_tb_alloc() sees highwater state, and everything after that happens per
>> usual allocating a new region, and possibly flushing the full buffer.
> 
> 
> Correct. but with a distinction that highwater state is relevant to a TCGContext
> and the regions are allocated from a common pool 'Code Generation Buffer'.
> 'code_gen_highwater' is use to detect whether current context needs more
> region allocation for the dynamic translation to continue. This is a different
> condition than what we are encountering; which is the worst case condition
> that the entire code generation buffer is saturated and cannot even allocate
> a single free TCG region successfully.

I think you misunderstand "and everything after that happens per usual".

When allocating a tb, if a cpu finds that it's current region is full, then it tries to 
allocate another region.  If that is not successful, then we flush the entire 
code_gen_buffer and try again.

Thus tbflush_pend is exactly equivalent to setting

     s->code_gen_ptr > s->code_gen_highwater.

As far as lazy_realized...  The utility of the assert under these conditions may be called 
into question; we could just remove it.


r~

