Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453CAEF48ED
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqoyE-00020o-5Q; Fri, 13 Feb 2026 03:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqoyC-00020C-Qc
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqoyA-0003xA-Sx
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770972969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uWWyMHPpctBkXP8TQrP7xNS0+RnymwbOjQKPSG5vDs=;
 b=gn7aprZhw7QrEze5j4F4SdQqppQYBYHWN1G6eVzRHzMiFE0xFiFG2L7LA1zdrqr9lW97M/
 FzG6npA0wHm8L27tLtGq5cQ/T1vXPdyeqhryj8/qBP63FwXCMoT6FLEAaqmEsmu6cRHsw8
 CxGPLNPJLWJOVFopcbrLd3qSAhwBRmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-lQjiz-HNMVOAdk9j1_HjdA-1; Fri, 13 Feb 2026 03:56:07 -0500
X-MC-Unique: lQjiz-HNMVOAdk9j1_HjdA-1
X-Mimecast-MFC-AGG-ID: lQjiz-HNMVOAdk9j1_HjdA_1770972966
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so9290895e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770972966; x=1771577766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uWWyMHPpctBkXP8TQrP7xNS0+RnymwbOjQKPSG5vDs=;
 b=qF9aLmpRDA8NNzu8Je9lR02AzuoO3GLddysf84GwokgtoEAPlal5AoQ41ouLPy7i5Z
 YIXDE5va9h428/Fqce8sV9X4bVL6wSvRtJPL1dV6R6qTSLSy1qyGSIQGDpShpP31e/yO
 uZjYC2f29NCCiO5SRmhDdoQ1EVIsyNJC0c8m2Mhi5q81jPXs47rEusy0DKxjn3hOapUb
 paVG0r2cchYZuNBG47AGwRm3txem2yZI+2eiRUeYfPK6zD8edyA+p6xLJ4YBv9zLfY3f
 ifgXHjpNwFymsDbuwkI4exkmQiKAhVCBP9N+rfgZQmJX/RCKqEzz0W4DymNs1xsw/vWk
 7cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972966; x=1771577766;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uWWyMHPpctBkXP8TQrP7xNS0+RnymwbOjQKPSG5vDs=;
 b=WIXcRWUPFhFcOfI3zE8CrIFsFyemULWCDdLjWYeOqC1jzPXuaBxmTLRaA4LqtpR+BI
 bCOmePgbsafP6SpIWQajdmuRgHaXvfAvs1jY6Fre760CxyTGokkzblSeR9CJKAuUVzL9
 r+QUVXFUlLot31wQSaH774LZXCF31egydyutZNP4Mz+4k2MfX0gkPSFpClDiwTy0ocLN
 YjGssaI0xmUEQop2Vjd56yxkW+9rmzhxV5VX0dB9ugKVz74gZSA+qByJmsWktth6K+Ap
 dDrQu5gl7PR+M72oK+zRZuhsmNW5mYkPkmYFbg2sXmhZcVUGoms8cGPQaBlggjIApNDL
 PVMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbegWJYedRW3yAHzZXsbaKeiojKpXwqVueCnazjBAaQO6EoMQSFCQbQ1E8X5tPnfvdIcV/DOfSksXY@nongnu.org
X-Gm-Message-State: AOJu0YyizdDfzZD7AQrLfV84ZQN9Fi0aQd3o3FUFKkunmWzlabDtcF3d
 xmxBnQ0wAGgwTV4YNDadib0cDrImywqqiN61hkdpm/Wq9gsBpaXUAtipWMn0KdPXQQ1MbN2+me8
 h8exKAufaDj09+afTx4uW0gtsicX7yMcVIs0rK9rYLjB7h/u0RKMNhMbQ
X-Gm-Gg: AZuq6aILwj6EAZ4e0ZJWZ+6yZI2o5qb89LWpBUDPQthnO+n6tG+cyHxLLxzIYGuqJFt
 EIhNnNvUuChKRrdGtRgYKzPt2c29YZB9ATJk3ci6xPvNZb0lexVYMGb170fFkjUJ2mx4jQTJF2w
 lLerpgM7tNXbUM00bQ8oWoBbGJh8fhizeOvXhdfx+5TZSCefrKhqdqDFCAJ13bTf+HcO2xnNwqh
 V+q8uCa5Ei1b1OlGomANsufo/4VT1B3B7ntHYrrncgjxzWU5IM0PY0Gaj6GYLqkp0IQNggtUHta
 pq4nRYWtw3reBaeZ1YLQ4n203c2ZoW0V67EAf0yWmLHI5SFfaAEatqdoYjC1ECxuiO3Qf5klsVy
 nTGrSu52vQWpkhN9RvC/lt6caFuLn2w5nUhLysf0RMMEoEWl2XouzGY+ggCx02E2BHL4VySr6vk
 qHxtHCWRRIMNQwcbozDENWSUEDaw==
X-Received: by 2002:a05:600c:3b1a:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-48373a7018cmr14096645e9.29.1770972966061; 
 Fri, 13 Feb 2026 00:56:06 -0800 (PST)
X-Received: by 2002:a05:600c:3b1a:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-48373a7018cmr14096245e9.29.1770972965573; 
 Fri, 13 Feb 2026 00:56:05 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48371a2d55esm16845185e9.8.2026.02.13.00.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 00:56:04 -0800 (PST)
Message-ID: <0f6fb483-f182-4063-a676-69a3d7b3edd1@redhat.com>
Date: Fri, 13 Feb 2026 09:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
To: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, kraxel@redhat.com,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Igor Mammedov <imammedo@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-4-anisinha@redhat.com>
 <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
 <CAK3XEhOh1m2Mu1LKMYQjHfF9Yiu8Dj2uWoeF8wNq3wK7v06AiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <CAK3XEhOh1m2Mu1LKMYQjHfF9Yiu8Dj2uWoeF8wNq3wK7v06AiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/13/26 07:40, Ani Sinha wrote:
>>> +        if (vmfd_reset) {
>>> +            /*
>>> +             * If vmfd has changed, then vcpufds have also changed.
>>> +             * Need to sync full cpu state for non confidential guests.
>>> +             */
>>> +            cpu_synchronize_all_post_init();
>>
>> Calling post_init() in reset() is dubious. It might work with KVM by
>> chance (because only KVM implements .reset_vmfd), but by design I
>> don't expect it to work on other accelerators. If you really think
>> this is the only solution, then you'll need to document cpu_sync*
>> methods very carefully.

post_init is called to do a first-time initialization of the VM file 
descriptor.  This is exactly why you need to call it here, the VM file 
descriptor is new and has never been fully synchronized before. 
Otherwise, kvm_arch_set_tsc_khz() is never called (doing it in the 
reset_vmfd callback would be a hack).

Other accelerators don't implement separate post-init and post-reset 
callbacks at all:

mshv => same except for abort vs. RUN_STATE_INTERNAL_ERROR
whpx => WHPX_SET_RESET_STATE vs. WHPX_SET_FULL_STATE, actually no change
nvmm => same implementation
hvf => same implementation
tcg => does not implement either

so they're unaffected.

>>> +        } else {
>>> +            cpu_synchronize_all_post_reset();
>>> +        }
>>>        }
>>>
>>>        vm_set_suspended(false);
>>
>> Isn't the confidential_guest_kvm_reset() API more appropriate here?
> 
> This above hunk I did, calling post_init() to do a full
> put_registers() etc is required only for non-coco case in KVM after
> CPU reset when we are enabling vm file descriptor change. In the coco
> case, the call is a noop as the guest state is protected.
> This part I am not very familiar with and used my best judgement. To
> address your concern that other accelerators might implement
> reset_vmfd() but does not like to call
> cpu_synchronize_all_post_init(), we can wrap it inside another
> accelerator callback like ac->cpu_synchronize_all_post_vmfd_change()
> or some such.

No, calling the post_init callback is the right thing to do.

I must say I am not 100% sure of the initialization flow in general; I 
think kvm_arch_set_tsc_khz() must be called for confidential guests too 
and, in order to do so, at initialization time QEMU could call a 
post_init call that only does kvm_arch_set_tsc_khz(), and then call 
post_reset normally. But this is independent of this series, which 
doesn't make the fix any easier or harder.

Paolo


