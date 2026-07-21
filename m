Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33C1C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3x1-0004Lo-Ma; Tue, 21 Jul 2026 02:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm3x0-0004LY-ER
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm3wy-0003Iq-FM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784615249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R/BJssd849qiDjmGQTrnT1RxGusMo2pRAPgvI+7gJrA=;
 b=OYiEBLStBlYN7bUnurcrFH6p9LOpHha8CWGIAR8FWZOaM6+tCQwVBJJe2Mfujx6aAq1eNG
 7gOSeXJM5QZxH1IVBONm7r7wtIaxcLIR62ev/kMLpnTyl2lNMZZrni6bY35bXJdh6OhsFY
 cyMssekyFGkT0y11c+fjXyl4ThfQi2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-3Jy7UTeVMJCZM-nV1Q-Hzw-1; Tue, 21 Jul 2026 02:27:27 -0400
X-MC-Unique: 3Jy7UTeVMJCZM-nV1Q-Hzw-1
X-Mimecast-MFC-AGG-ID: 3Jy7UTeVMJCZM-nV1Q-Hzw_1784615247
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso6165533f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784615246; x=1785220046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R/BJssd849qiDjmGQTrnT1RxGusMo2pRAPgvI+7gJrA=;
 b=hd3rLT3qz1Swmwhru/6YEiYb2+ievKWbZOIH+POsho17JLZxxM6gmLXH9fGre9SyM7
 KOFOkhrkwOeNbhroyfgEAMGoEamfA4681PUlhQFk24lmL/+9yRpIgJaKmQxlLfVtJDuu
 AD4ywokfvMWALUoaH8iCGBTQr8TdzZCjjHtEj8fp2WYPN0BAd8HrT7qzYnNA2xwNjh41
 bGPnxKQAf9fn0Z7j/Oaa9sMnoIqZgFGw0/u7gSSCzBGB550NpcdXpuFyOd7O6r0jitQt
 jVHf802pVZboMets7+ga12RN4gpMvSYKl9Rc+l4fuRDxxOaQt6/S5YySG0royP5GyQcb
 2ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615246; x=1785220046;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/BJssd849qiDjmGQTrnT1RxGusMo2pRAPgvI+7gJrA=;
 b=YjrlnEm4J3W4qF16OLxOodOd+4VEibBu6J7UfujEkOFZOWjTtiX1rMGqyCBTF8hs4s
 DTAw5fe+C59tbM7iUO488joqsMeAEE6a6ObHXAMi9ZSgExMSKMAm7jwyWknFE7p5ziuj
 OnBDqc2tTU5EyBWtYpSv8sMzg4z46LUw+CRQMpoBYE5LLuaoTo0WeTkiXHFIXH9Ev+1+
 nW18hWWCWvVtNjM1t/GRWD89opL9e+TCH7KFl343vrtLWgt9DWhtgsI0zeGDv2E+FL1T
 pxwZqIAD7NAOgxgIinVub9YHTixE+9aPgVAXqmUPzOHljRQeOt2FoqZZGJug5xu3vb/K
 rv1g==
X-Gm-Message-State: AOJu0Yw7UAZm63exKS2HRB0a9YvgwST9XyqNTm35qgrwvaRtpD2wsEet
 mAXWlahKlktbVw9L0axeSUxYRq0d5x/NS4ywv6yZHZZC5acxMRJb46UQU4KTMoMP2XWf+ptPz5/
 e42t9t+xU3ulwF3EDCT5e23qXr755KImxCBHKuEpmTQHzYvc2+8VsvfYu
X-Gm-Gg: AR+sD10ExT09ADb1xZIjcV7UzxOISRDJVHWGBphY2+0mCaoW5VrWb0UAHmMhb1I11PZ
 8MWxORZDir38j1BZ1cu5z4UvPyuWf0XH8uKQUt0yjCwn2XfkuwznamvEgBrwJW7vnqeJUNSG+/x
 NIAI1O1d0ivs7OnYtSMsdkJAHKZzuvrsxFXSNgwGp9kAz98yO6Rn+7Th7GjfxU9Q43oyU+dZJL/
 jOlFxay7ymDEmTmUgdMOFPV0aoBsEiZdhL6eF0LoUpOg/IDCGFj8LCk1nDvMrzo571XQazKzf0J
 ibKXyDfu8s+em7zb2mQqT7L47+RwmhKOdm6AtWIoUYxGdWiMR2BFez4I2GK+ThKRv9QaqMCuAXw
 ZDAvzxPJJsLdh9EUWMCQNxJBjbFsuT3uQRbm4DWs=
X-Received: by 2002:a05:6000:3c3:b0:47f:7ff8:6bfe with SMTP id
 ffacd0b85a97d-47f7ff86ce2mr1553556f8f.0.1784615246572; 
 Mon, 20 Jul 2026 23:27:26 -0700 (PDT)
X-Received: by 2002:a05:6000:3c3:b0:47f:7ff8:6bfe with SMTP id
 ffacd0b85a97d-47f7ff86ce2mr1553517f8f.0.1784615246075; 
 Mon, 20 Jul 2026 23:27:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm38842119f8f.21.2026.07.20.23.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 23:27:25 -0700 (PDT)
Message-ID: <14b1956a-5d30-4d31-91fb-c20675a4f17b@redhat.com>
Date: Tue, 21 Jul 2026 08:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] build: fix sparc64 host
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
 <20260720171031.259f590e@shazbot.org>
 <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
 <a2273203-403c-4da1-b3dd-0933dd70faf0@app.fastmail.com>
 <de6169d2-15ac-4f46-a249-ddb753946be5@redhat.com>
 <a0d5c160-fc29-4c5c-b82c-d79151022e5d@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a0d5c160-fc29-4c5c-b82c-d79151022e5d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/21/26 07:17, Pierrick Bouvier wrote:
> On 7/20/2026 10:14 PM, Cédric Le Goater wrote:
>> On 7/21/26 05:33, Alex Williamson wrote:
>>> On Mon, Jul 20, 2026, at 8:48 PM, Pierrick Bouvier wrote:
>>>> On 7/20/2026 4:10 PM, Alex Williamson wrote:
>>>>> On Mon, 20 Jul 2026 22:17:13 +0000
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>>> It was reported that build on sparc64 host is currently broken, due
>>>>>> to inclusion
>>>>>> of asm/kvm.h, which is not present on this platform:
>>>>>> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-
>>>>>> ebe64edacab6@tls.msk.ru/
>>>>>
>>>>> Isn't is sufficient just to remove the stale <linux/kvm.h> include?
>>>>>
>>>>> I don't know of a case that fails, platforms that support vfio might
>>>>> actually be a sub-set of those that support KVM, but being dependent on
>>>>> a KVM supported host has no technical basis.  KVM and VFIO are
>>>>> independent features where neither should have a hard dependency on the
>>>>> other.  Thanks,
>>>>>
>>>>
>>>> It's related to a recent change that was made to get rid of CONFIG_KVM
>>>> in the file to deduplicate hw/vfio/listener.c between targets. So it's
>>>> now unconditionally included, thus the regression.
>>>
>>> I understand.  I'm suggesting the fix is simply:
>>>
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index c19600e980a8..008f488a3e7d 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -20,7 +20,6 @@
>>>      #include "qemu/osdep.h"
>>>    #include <sys/ioctl.h>
>>> -#include <linux/kvm.h>
>>>    #include <linux/vfio.h>
>>>      #include "exec/target_page.h"
>>>
>>> This builds in both a native amd64 environment and a cross-compiled
>>> sparc64 environment.
>>
> 
> Thanks, I'm ok with this.
> Do you have instructions (or better, a Dockerfile) for the cross compile
> sparc64 environment you use?
> It's the only host we don't have cross compilation environment at the
> moment.
> 
>> This leaves linux/kvm.h included only in the following VFIO files:
>>
>>    hw/vfio/kvm-spapr.c
>>    hw/vfio/kvm-helpers.c
>>
>> Looks clean to me.


With this fix, QEMU (sparc-softmmu,sparc64-softmmu) builds on a
UltraSparc T5 running debian sid with linux 7.1.3.1-sparc64-smp.

For the record, make check passes.

I will send a patch.

Thanks,

C.


