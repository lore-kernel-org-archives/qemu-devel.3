Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A92CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umApR-00026c-Hf; Wed, 13 Aug 2025 08:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1umApG-00025s-9m
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1umAp6-0000gz-IN
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 08:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755088996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BXnoR3UqMuKkmYEZxaLCYx8OwyCjpGUB5RXMn7lqgg=;
 b=Hna9y07keAYHNQ0rAiYkO5Czgfa5uGbgOaR0fsNNRTSsyM8gwvX9QUZSm+HQQPAhy6EooM
 07JEjPO3I48UDW8T9vsCVFk+9JMtkTwJqeNScvPZeAA8daWDTbYdoVK8Aq/lwzmNkLDDAY
 bvLAv52MthVR2mdgEYuMtRul6Cpmh0M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-8ye9dIzoPnChGtxxKA-RuA-1; Wed, 13 Aug 2025 08:43:15 -0400
X-MC-Unique: 8ye9dIzoPnChGtxxKA-RuA-1
X-Mimecast-MFC-AGG-ID: 8ye9dIzoPnChGtxxKA-RuA_1755088995
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b0791a8e8dso181980781cf.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 05:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755088994; x=1755693794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1BXnoR3UqMuKkmYEZxaLCYx8OwyCjpGUB5RXMn7lqgg=;
 b=ICJyKueRgPNFnbyuYitc/nrgEyJI5IUCHa9fsje/rB9nxa8wYJ2Sey34KEOY1ttz2r
 xuhvTvveYORINvJkPf6fBEbHkNSIlYVbrnal9W/I8PhJoNbbQyIWDmG+bZUg4AUxRS8w
 FvFovNR4DUzmsjJ8dGX0ZU7yQzLEZ20rdjCZhQkoQp3sasmQx2VRTZL5kVvSHiaWjAGJ
 t0N9y8fVvKi4keI++qrQFzjweuvYYYht/kteuQRZcNHaHLDW6i5Omvr3zWccj5JqY4+o
 BjV92/kOV4UjSPVShk2KrtuKHn+DSjSP2206x7CKeFFgT4j9IdaWcuXK8hQxLCVyhN/6
 BbGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJGVVNgMVB2i3a/o0Bw6eZTZIyDxU9OIJ7q6KTlTsst1o74gsxHXyFAHS5aUqyvIYwp9tS6ZU9SzW1@nongnu.org
X-Gm-Message-State: AOJu0Yzyn07r8TrwmrR+SrBnUk2TUBgOSlj0V9xJhx0wt6VxR0N2BIof
 FIsA1ToXbAFJ0HxpW0yetA+glqbqiaUQmZd3yw5JiXByiltY3Uhh1Fxy+VSH9KMzU36H5RU2AiM
 9m1ZsbdmVA9KMR1rxApsX9IxP131yUqOEx/8TAkT0LY7hpEaYzF4sMxWm
X-Gm-Gg: ASbGncsFpAdb/2wKESvYD5LjJFS9Sj7kybPAq3156CZrwAnJrobvUSgErvfZ/eo736c
 1g1nfRpwdURj1gGliludaE87Kvt6wzQelIA2HjW0xtkVHp4jkbSjCoo2iKU0KMtXH4W0K1Xxgze
 3T0cOWP9U8zOlD7cB3CoaDei1eeKPDAeVRX6vGmdTz58eKE5cUMzaysmhdN2YO2OYjrNWfabK+w
 8pxpbPxbbO1PhmdaJ+yFCDMFnqOZYF6SmIlStYK7ctY2FpvewyOOPKQdGLyZPagVHJHmTIU5bO4
 bLYQIvgvn4DDjvZj7Rp04yJm3KrsQRNhsTpopbNy4UOvAYg9DTn05/xRirJRqUKXs+SEbE7V7bl
 3lFy+/rJ9xBE=
X-Received: by 2002:a05:622a:5509:b0:4b0:e934:6ff4 with SMTP id
 d75a77b69052e-4b0fc89257fmr42801221cf.52.1755088994565; 
 Wed, 13 Aug 2025 05:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ7Go580hhjZB1xh76PzZyq47428ppMrt3Sho2hnvS4MiBFpjd1edQnBZgLNF3iKX7rTetwQ==
X-Received: by 2002:a05:622a:5509:b0:4b0:e934:6ff4 with SMTP id
 d75a77b69052e-4b0fc89257fmr42800671cf.52.1755088993961; 
 Wed, 13 Aug 2025 05:43:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b0aa1efe78sm92297441cf.8.2025.08.13.05.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 05:43:13 -0700 (PDT)
Message-ID: <5bb03486-0463-4167-bc40-b47445d9b6cd@redhat.com>
Date: Wed, 13 Aug 2025 14:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm/kvm: report registers we failed to set
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250721161932.548668-1-cohuck@redhat.com>
 <88812eea-08e3-48f5-b2f8-75ab0fff573b@redhat.com> <875xerfskt.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <875xerfskt.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/13/25 12:01 PM, Cornelia Huck wrote:
> On Tue, Aug 12 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Connie,
>>
>> On 7/21/25 6:19 PM, Cornelia Huck wrote:
>>> If we fail migration because of a mismatch of some registers between
>>> source and destination, the error message is not very informative:
>>>
>>> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
>>> qemu-system-aarch64: Failed to put registers after init: Invalid argument
>>>
>>> At least try to give the user a hint which registers had a problem,
>>> even if they cannot really do anything about it right now.
>>>
>>> Sample output:
>>>
>>> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>>>
>>> We could be even more helpful once we support writable ID registers,
>>> at which point the user might actually be able to configure something
>>> that is migratable.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> Notes:
>>> - This currently prints the list of failing registers for every call to
>>>   write_list_to_kvmstate(), in particular for every cpu -- we might want
>>>   to reduce that.
>>> - If the macros aren't too ugly (or we manage to improve them), there
>>>   might be other places where they could be useful.
>>>
>>> ---
>>>  target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 667234485547..ac6502e0c78f 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -900,6 +900,24 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
>>>      return ok;
>>>  }
>>>  
>>> +/* pretty-print a KVM register */
>>> +#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
>>> +    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
>>> +               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
>>> +
>>> +#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
>>> +    ({                                                   \
>>> +        char _out[32];                                   \
>>> +        snprintf(_out, sizeof(_out),                     \
>>> +                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
>>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
>>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
>>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
>>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
>>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
>>> +        _out;                                            \
>>> +    })
>>> +
>> I am afraid this is too simplistic.
>> Refering to linux/Documentation/virt/kvm/api.rst 4.68 KVM_SET_ONE_REG
>> ARM registers section
>> there are different groups of registers (upper 16b) and not all regs are
>> further identified by op0-2, crn, crm.
>> I think it would be valuable to output the group type and then the
>> formatted lower 16b, depending on the group type.
>>
>> For instance 64b ARM FW pseudo reg is formatted as
>> 0x6030 0000 0014 <regno:16>
>>
>> a diff on reg 0 results in
>> qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
>> op2:0 to 10003 (is 10001)
>> qemu-system-aarch64: error while loading state for instance 0x0 of
>> device 'cpu'
>> qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
>> op2:0 to 10003 (is 10001)
>> qemu-system-aarch64: Failed to put registers after init: Invalid argument
> You mean smth like
>
> Could not set FW pseudo register <regno> to <val> (is <val>)
> Could not set ID register <decoding> to <val> (is <val>)
yes

Eric
>
> ?
>


