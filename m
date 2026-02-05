Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56ACE9128E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuPi-0001A2-D4; Thu, 05 Feb 2026 03:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuPg-00019j-U8
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuPe-0002sR-8f
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770278908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HJlGsHAp5uJ0NPgj0KlmzCfP799DZy3yJaEgYqy8Djg=;
 b=Mt4rVCikP2tWWO0uU5AFPN+oudTA8LeVHrLCxccc70/fHEeCvE0F6/U6AeVQWOPZleoBdl
 nacLiDbykAeoRZyMQoT6TUhBHPos57WeHIYoVrqzgcblaNr5uGdLk5shmNfXKzqyTceoxT
 4dYn8m4NM9+/J/rOEPAp/1YNydFiPPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ZPZt2KZbN_K9q-XYotEb9w-1; Thu, 05 Feb 2026 03:08:27 -0500
X-MC-Unique: ZPZt2KZbN_K9q-XYotEb9w-1
X-Mimecast-MFC-AGG-ID: ZPZt2KZbN_K9q-XYotEb9w_1770278906
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-482ef3af991so3443135e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770278906; x=1770883706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HJlGsHAp5uJ0NPgj0KlmzCfP799DZy3yJaEgYqy8Djg=;
 b=gAYVkxNU3/NrR2JUy+6wktEn2UaycfmIV87KR7j+WwN2dJCCP0cpmqBkE2ksvAPVY+
 ablFZU3PUBzeqZSdrlPz0a+NkzLQutNNoW45l/O9y0iT4Kl5ccJUPIkHsuUg9cxQ0xBV
 EGT/TQ3g6qCO07SETtGOqsDuH6PW2eoRU6yVxY837fFu1uMsAXrtOCgoXnqhMP0b5M7s
 9vwpebpKxQESDgtrPNyfUcnUanbufuLnYVoxrhUnw15wZUUp8G7U+RN2A4/J6ARkEKxQ
 8Q+vxoj7zpqCz/kFek5Cr1XVpOlYAexlNInJ83iimdVEgTjEk2kmoNraiUhENkqgV3RD
 WBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770278906; x=1770883706;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJlGsHAp5uJ0NPgj0KlmzCfP799DZy3yJaEgYqy8Djg=;
 b=SONXPFj8+9KySrKqbVOsHji8ieHj4GhWETaBODS2bxQS2gysRJ0zqE9xDqJu7Z2kOa
 IXhYJuv2bUxdhG0CF84mmDKCk1UMvoH5+f5xh9Ny5880NNwz8z9S5u2bXEUm/b3o9SqK
 josSoFAsIY1l3shVzTzcYbNdx2AGbM/3FSTZCh24OcTZFV/tzRwHZHeJr2wDsMg8DOxm
 ZzoKWUS5rHmoKSTUKEFyED5xG3jq7LI+RL71wWqGNqFy8QQs59ppgzTD/zRDmVlvblvC
 4DSAy6fU6xA8gyOSoCJlYJPR7MbacYhYCQX+MkX9IpR5b50qIA+WUysrS+VwdastDhdj
 jrAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZZ3Biv/+xl5W05PYXoMDD1UU5essEK9dRDaeqkw9SrqYT8Z6Nou9ya+/XPHpnXd411k3ShAyYo3h0@nongnu.org
X-Gm-Message-State: AOJu0YxwdqF7oEGrFfQzHERm+G1QGhuK69fXLiCpQ/7vi1Gf88N08C+p
 hA2Dxxg5Z067gYxIBv/MjnsE7K9uq3QKAzd3nO66+ET6uu6q7UvJZOREJzTgoAkSvsP0ZZHipBD
 ZJsZzkRAZM37eRjyr3jh14CELDGAQMXbSvkenTRPaueeRZ+CUmwl/dCSh
X-Gm-Gg: AZuq6aLNj4JCImgvZf231JYquQhK01xlEyIqH+tLi9SRSblLyR7KmImL1bjCS23dPw2
 j2bD+wE+8Ks/LTvbB0h/8vUKHkxyB7Sdi261ddDRmFndyIuOqzez8bheaKom9qedZCUY8o2qfbi
 K25nopvhXGX3Yr40USjUGygvUcNhnVXKNhKsfTnIkh2muVgCdMdF/wqSJzGZB8SxuycbiDkW0/t
 1uDremUAffM3B0WYW0ZzGjVvua6IPL8uv0GI47ZCpbAC0exzrf5FFqOxbd6PufIemAQkFt9x6Yh
 7XMvf3TYOlaHvzq8Q87mSNG0b4TmJ5jTMtf47/tm8rs5ajw6m+qDUHuGrj9K76AANtl0upalaXz
 IR2ymNn4=
X-Received: by 2002:a05:600c:8b74:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-483179a29b6mr29104255e9.7.1770278906321; 
 Thu, 05 Feb 2026 00:08:26 -0800 (PST)
X-Received: by 2002:a05:600c:8b74:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-483179a29b6mr29103735e9.7.1770278905830; 
 Thu, 05 Feb 2026 00:08:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e174sm35021045e9.7.2026.02.05.00.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 00:08:25 -0800 (PST)
Message-ID: <26f386a7-0b4b-45d2-b2e9-afc746c0a311@redhat.com>
Date: Thu, 5 Feb 2026 09:08:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/s390x: Introduce CHSC_MAX_REQ_LEN definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-14-philmd@linaro.org>
 <5302604f-0fe5-4dfb-8baa-f072e279504a@redhat.com>
 <0fef147f-8268-47ae-b037-ce7d7063489a@linaro.org>
 <038cc071-1a40-47a8-acf4-55016af8d5b2@linaro.org>
 <6263230d-f108-4178-b5be-22fc61b81a93@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6263230d-f108-4178-b5be-22fc61b81a93@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/02/2026 19.08, Philippe Mathieu-Daudé wrote:
> On 4/2/26 19:04, Philippe Mathieu-Daudé wrote:
>> On 8/1/26 12:46, Philippe Mathieu-Daudé wrote:
>>> On 8/1/26 08:53, Thomas Huth wrote:
>>>> On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
>>>>> Since commit 166f1bb7968 ("s390x/ioinst: Rework memory access
>>>>> in CHSC instruction") the access is no more tied to the page
>>>>> size. Define CHSC_MAX_REQ_LEN to better express the relation
>>>>> with the length of the Channel Subsystem Call request.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   target/s390x/ioinst.c | 5 +++--
>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>>>>> index 2320dd4c122..d07773d14a3 100644
>>>>> --- a/target/s390x/ioinst.c
>>>>> +++ b/target/s390x/ioinst.c
>>>>> @@ -398,6 +398,7 @@ typedef struct ChscResp {
>>>>>       char data[];
>>>>>   } QEMU_PACKED ChscResp;
>>>>> +#define CHSC_MAX_REQ_LEN  0x1000
>>>>>   #define CHSC_MIN_RESP_LEN 0x0008
>>>>>   #define CHSC_SCPD 0x0002
>>>>> @@ -660,7 +661,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, 
>>>>> uintptr_t ra)
>>>>>       uint16_t len;
>>>>>       uint16_t command;
>>>>>       CPUS390XState *env = &cpu->env;
>>>>> -    uint8_t buf[TARGET_PAGE_SIZE];
>>>>> +    uint8_t buf[CHSC_MAX_REQ_LEN];
>>>>>       trace_ioinst("chsc");
>>>>>       reg = (ipb >> 20) & 0x00f;
>>>>> @@ -690,7 +691,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, 
>>>>> uintptr_t ra)
>>>>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>>>>           return;
>>>>>       }
>>>>> -    memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
>>>>> +    memset((char *)req + len, 0, CHSC_MAX_REQ_LEN - len);
>>>>>       res = (void *)((char *)req + len);
>>>>>       command = be16_to_cpu(req->command);
>>>>>       trace_ioinst_chsc_cmd(command, len);
>>>>
>>>> Sorry, I don't quite get it, there are still dozends of others 
>>>> TARGET_PAGE_SIZE usages in target/s390x/, what's the advantage of 
>>>> removing that one here?
>>
>> The other ones are really related to the s390x page size.
>>
>> This one seems to use TARGET_PAGE_SIZE as an optimization.
> 
> Also, making this file common, we get the page size at runtime,
> and that triggers:
> 
> ../../target/s390x/ioinst.c:663:17: error: variable length array used [- 
> Werror,-Wvla]
>    663 |     uint8_t buf[TARGET_PAGE_SIZE];
>        |                 ^~~~~~~~~~~~~~~~

Using such big arrays on the stack is not good style anyway - unless this is 
a hot path, which I think it is not. So maybe you could simply post a patch 
that turns this into a "g_autofree uint8_t *buf = gmalloc(TARGET_PAGE_SIZE)" 
instead?

  Thomas


