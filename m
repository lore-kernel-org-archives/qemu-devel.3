Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C428C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0RT-0006ff-R0; Wed, 30 Apr 2025 01:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA0RK-0006cI-Ob
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA0RE-0000ux-AG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745992614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1sCs8Z3Lo4R9JcFbKiTxS9Hxc2nbvukLJLr7nKgQWks=;
 b=K2SXHfHE46fdbHYcZUKoOBZI49oINGsYCDJ+zboeIKe5xxaoqOwwqaXqMSDOphyabbdKVe
 tq/qiCPQj6WbZKODqtCH41IEuUgwSBy5p+JJR+oEiavRFr6LNGfcys5lNK9tCzgYF85XTC
 4gyUHnSwQLCa1ENmYEJ6bsYzvM1/YHA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-V27ox9_uOZupJGhEPbQiEA-1; Wed, 30 Apr 2025 01:56:52 -0400
X-MC-Unique: V27ox9_uOZupJGhEPbQiEA-1
X-Mimecast-MFC-AGG-ID: V27ox9_uOZupJGhEPbQiEA_1745992611
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso550432466b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 22:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745992611; x=1746597411;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sCs8Z3Lo4R9JcFbKiTxS9Hxc2nbvukLJLr7nKgQWks=;
 b=nVoTvxbM7DIUqpIBV6BZtsFqVTUMqojYosuzdkztO4nYIj209rKExEtB+TdLSqA4B6
 P5X5ThDRvtZwy/mb8bmhAtausGgOA2EDob8iqVd4fAXmN9pmiqBB1ipi/NycEXHWs1qJ
 bblo2rkeRpIHofqm9RMUfutxUEVGMRUKhPBVNM9hn8leBaJAjsrsNpAOFLNV3SCrxuKU
 ktTgbg4gYf9LUPEfuzgV+i0W3W8bQYQHab1CFvBIcBRsA9Ji71CXEjJ1WzeXdbdk+M3l
 i79U7PjGC5W6GYNQ0dEHy5NhcPQVxXUkJ7uO4ZfOsXcza2azleid4bW7/Nfu7WY1zkzM
 ZAgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnw1s3EpjtAMMuHn85IAJ+/HX6+6hTz7LL10FxzUmDECRV0KbuDdvGVu6gsK3bjBaVrcshkCw1FMK2@nongnu.org
X-Gm-Message-State: AOJu0Yy0CVqDXZXUA2vx4onl4QUSEKakT1Xb2j0bdNJZntyoZBdvOxL2
 B0AHgUbUA5D5gSSg2Mbptbb7n1rRLhPXXGobx4ppkPcThOVBgu1othsJM58ImO79/7rKci3XFdw
 hHPcccS1i7StXG1/Te/1PX3ykKaHu4WtcXvFIXwZRd1LnM5KoWWLgXY4gYOhbdGs=
X-Gm-Gg: ASbGncsfpFm5AKk346MOqfGq2hSuFeCxmjIidMuxrtJ1yDbnGOlYW8yz3szWIyuK5lw
 wbo5DWvubn2mfZcJ/aRQ3NN55LcxrmFkNGjsWxctUwIvKBW/frXJkaDs1kFCIAAbaamD6lewioH
 8XqNh9k360DZafwziPciWPbFGJ0pujYNDibM5ztfia036v3HAvqmd4qkAlp3Ad0ibE24lYMsE2q
 vFxoM+Bm+CeNZMzDxXKqKuIYOE0cE6GDs2+hUcCvnXgGDUPISnKn2FaaSHKQeWGYV38eWcu84rR
 nhEQbDdNvF3pg2BzeCaRMNbtHVIAOUX35AJuu6Kl
X-Received: by 2002:a17:907:970a:b0:ac1:dfab:d38e with SMTP id
 a640c23a62f3a-acee21a7048mr126031766b.15.1745992611047; 
 Tue, 29 Apr 2025 22:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0+Miyton+dGGQ7JFE4NfGPvnu2VNQr+Yo4tr99abzAZWdovBR2CQ9F7qRpFc5VkfcDOr7jg==
X-Received: by 2002:a17:907:970a:b0:ac1:dfab:d38e with SMTP id
 a640c23a62f3a-acee21a7048mr126030766b.15.1745992610574; 
 Tue, 29 Apr 2025 22:56:50 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acecbb956b7sm193122866b.2.2025.04.29.22.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 22:56:50 -0700 (PDT)
Message-ID: <564c25c9-1d8c-4828-9d6f-7fbcf58fad9c@redhat.com>
Date: Wed, 30 Apr 2025 07:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] target/ppc: Big-core scratch register fix
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250408124550.40485-1-npiggin@gmail.com>
 <20250408124550.40485-2-npiggin@gmail.com>
 <2d6dead5-f56c-43cf-b7d1-9567fef99616@redhat.com>
 <D9JJ5IIYVLVG.2RQ8C03WHFVBZ@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <D9JJ5IIYVLVG.2RQ8C03WHFVBZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/04/2025 02.00, Nicholas Piggin wrote:
> On Thu Apr 24, 2025 at 6:25 PM AEST, Thomas Huth wrote:
>> On 08/04/2025 14.45, Nicholas Piggin wrote:
>>> The per-core SCRATCH0-7 registers are shared between big cores, which
>>> was missed in the big-core implementation. It is difficult to model
>>> well with the big-core == 2xPnvCore scheme we moved to, this fix
>>> uses the even PnvCore to store the scrach data.
>>>
>>> Also remove a stray log message that came in with the same patch that
>>> introduced patch.
>>>
>>> Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regular cores")
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    target/ppc/misc_helper.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>>> index 2d9512c116..46ae454afd 100644
>>> --- a/target/ppc/misc_helper.c
>>> +++ b/target/ppc/misc_helper.c
>>> @@ -332,6 +332,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>>>        PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
>>>        target_ulong sprc = env->spr[SPR_POWER_SPRC];
>>>    
>>> +    if (pc->big_core) {
>>> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
>>> +    }
>>> +
>>>        switch (sprc & 0x3e0) {
>>>        case 0: /* SCRATCH0-3 */
>>>        case 1: /* SCRATCH4-7 */
>>> @@ -368,6 +372,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
>>>        PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
>>>        int nr;
>>>    
>>> +    if (pc->big_core) {
>>> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
>>> +    }
>>> +
>>
>>    Hi Nicholas,
>>
>> this patch breaks compilation when QEMU has been configured with
>> "--without-default-devices" :
>>
>> FAILED: qemu-system-ppc64
>> cc -m64 @qemu-system-ppc64.rsp
>> /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in
>> function `helper_load_sprd':
>> .../qemu/target/ppc/misc_helper.c:336:(.text+0xcab): undefined reference to
>> `pnv_chip_find_core'
>> /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in
>> function `helper_store_sprd':
>> .../qemu/target/ppc/misc_helper.c:376:(.text+0xda3): undefined reference to
>> `pnv_chip_find_core'
>> collect2: error: ld returned 1 exit status
>>
>> Could you please have a look?
> 
> Thanks for the report, I have a hopefully simple fix just going through
> CI now... Do you know if there's any reason to exclude a bunch of
> targets in the build-without-defaults CI test? I wonder if we could just
> enable all, it shouldn't add too much time to build test.

I think that setting has been added back then when we still built all 
machines with --without-default-devices and only disabled the optional 
devices. Then Paolo once cleaned this up (see commit bf616ce47be6802bbe7d 
for example), so that all boards now get disabled by default, too. Since 
that point in time, the runtime of the job is likely much decreased. So yes, 
I think we could nowadays add more targets to that job without risking to 
hit the timeout again. Could you maybe suggest a patch?

  Thanks,
   Thomas


