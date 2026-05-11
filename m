Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F3FCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGm-0007t1-32; Mon, 11 May 2026 05:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMNEd-0006sz-S0
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMNEP-0002xM-Ip
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778492824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hNEJOm+ttRNk0euvoKOyDWhN47NFBPVyPSsLG4bJlI0=;
 b=ZlDuv2U+HQLK64QO/TYG07/5VuP1AlPq9GlfVeV5msCq79/8WkdE8xtLeVQZk46y59TB69
 q8s1DZno7eRlJs/zUiq+0nFGKyhgk0oNQjqFRpVrcEyFy1tVeVA516kLSHfU6hYdPAMYz8
 F4jIXGL6GpzlqJIiXO9Zj0+SbWR52tk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-x0I8wIIBOKGgcRz4mqxPiQ-1; Mon, 11 May 2026 05:26:59 -0400
X-MC-Unique: x0I8wIIBOKGgcRz4mqxPiQ-1
X-Mimecast-MFC-AGG-ID: x0I8wIIBOKGgcRz4mqxPiQ_1778491619
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso3867771f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778491619; x=1779096419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hNEJOm+ttRNk0euvoKOyDWhN47NFBPVyPSsLG4bJlI0=;
 b=I+K4MX5psBHAMTn8BuJ/DBsPVTUeHhv0eJUakVHLc93rivsxqTvX90G3wAGBZ7Qwsr
 oNjleEmz8G9X5MbXKdzkhU0Y6pm4d86pTDpCt42VrDWoUulWq6m8nlpQJsjoDXhnvxCI
 SBH0I6P5JLN9r03so14+/xqrcxPQhVIUJMVaTjSTmF3EU6/kglkZmnnyU7GRePpkkY3O
 Wg1MAiYMANZ+SYtWdbvdeRFgDbNW3Z2mKt2doRQise7O3BqmzpGPYBAWbG0QClKvubqV
 hizZ/RLzCcg6b4EoX6qs/NIQI+bozjGFVhDm5tHf2qvbmAlzhTt26T1+iE2QKBzNB9dM
 r1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778491619; x=1779096419;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNEJOm+ttRNk0euvoKOyDWhN47NFBPVyPSsLG4bJlI0=;
 b=X6XjxVQd7RI1zNMQOqxhd6hRapkv2lvOGoAPrMtNVqnACnp9BYWEdNV5vgW65els3H
 8TouA4EM8vVa+7PMsBuuYrrjE27Wq34xRjwScN6sPJcI5soFSgwiLRqqZbE2yEaH9/if
 CWhzXIXweX76M/Gh2Sf46F1xVRCqp5h2ZFZs/iZu8G1kDe4cZ2moWHZMSsjImIDYYrkv
 l3gMhoymiFb1jJgfgxQ3A84ewpAElBuzT2QyxsVJbWoVXE4dYtdJwkkY/7EaCBkF4j/F
 JBdpsa+8Kz/d+dnQqQW0+1n5yQX3AnQ+HDpKM22mFuKk2jzdtAO5PJylAkUoGjOI5VXo
 u1TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WzrcI3KFB3fqmTFX/sBj2nEnQcjWym4gHT2JvnGZvSebVpNTw5xy+e6k+a9DAuwZtkB2C4HMrgr/X@nongnu.org
X-Gm-Message-State: AOJu0YzogNV9shRc5LovuwZE20w9zSwaJHiGaMPo5waw5ybkUYh829iX
 H1TmTooioA664VNx1ekJzYQUPEU4kDgt3uI5cmPdXzGoTATEGGtD/YqjoRIe15SV8mK/RvnoqBq
 TCQPq2Af3PcUDpBX9jrIUYfpv/+3lwak6zF6NugiBMjOV26EXhIFRGs/+
X-Gm-Gg: Acq92OE+w11u+24/ZzOOLNKJxwZ8C643Fp7JCLdyOsnLLb6kQA5ZSAPQr3V6qQCePjI
 8Z1/rqwigh4IDX3ogbItK4bQNNDTRAjCwkQyP4k9z3PEOFQWVQuiBktDf97NrZIvtizjV+dgguq
 NDAbRgc8lJBlx40ekgKjoKkmngmJA6dn8RDosPJE3mCKMPen/BeBos6dAByFJVqWP0ttozoFn+4
 lnTsr9USv44ApK49CXZr9bjfkaZDFjDP4gaxDunDXOf6sB8sv+pdajH4ubPU43UWcTPFRWaA002
 SYyZqFYWV1mzAupjY4byBBVzLBln9nKqtylzOAjqezJbV9wkDF8WlhlmSM9fnlxAi3c/49BJqIX
 iqPT/NTx4AhKJ8VgI7bvDOOjQj370pe1HnInTdzxYFYEXBdlufIyYKDtqq5bv
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48e70700e20mr149715445e9.19.1778491618678; 
 Mon, 11 May 2026 02:26:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48e70700e20mr149714925e9.19.1778491618176; 
 Mon, 11 May 2026 02:26:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702f407asm174640395e9.13.2026.05.11.02.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:26:57 -0700 (PDT)
Message-ID: <f1f3f8c9-4142-46ad-87b6-2681b9ec5bc6@redhat.com>
Date: Mon, 11 May 2026 11:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn,
 qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 Avihai Horon <avihaih@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
 <c87311a3-b214-4705-8ed3-7386aea1056e@redhat.com>
 <20260510161352-mutt-send-email-mst@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260510161352-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/10/26 22:19, Michael S. Tsirkin wrote:
> On Sun, May 10, 2026 at 10:08:49PM +0200, Cédric Le Goater wrote:
>> On 5/7/26 11:23, Song Gao wrote:
>>> diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
>>> index 22f6eb8ca7..7baf1968a3 100644
>>> --- a/include/standard-headers/linux/virtio_ring.h
>>> +++ b/include/standard-headers/linux/virtio_ring.h
>>> @@ -31,7 +31,6 @@
>>>     * SUCH DAMAGE.
>>>     *
>>>     * Copyright Rusty Russell IBM Corporation 2007. */
>>> -#include <stdint.h>
>>>    #include "standard-headers/linux/types.h"
>>>    #include "standard-headers/linux/virtio_types.h"
>>> @@ -200,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>>>    	vr->num = num;
>>>    	vr->desc = p;
>>>    	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
>>> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
>>> +	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
>>>    		+ align-1) & ~(align - 1));
>>>    }
>>
>> The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of
>> libc types") changed this virtio header and this breaks the
>> build on Windows :
>>
>>    https://gitlab.com/legoater/qemu/-/jobs/14297040230
>>
>> A fix could be to reintroduce 'uintptr_t' (available through
>> osdep.h) by modifying the linux headers update script. Ideas ?
>>
>> Thanks,
>>
>> C.
> 
> Yea sorry ( Just add
> #define VIRTIO_RING_NO_LEGACY
> somewhere.
> 
> 

Something like :

   --- a/scripts/update-linux-headers.sh
   +++ b/scripts/update-linux-headers.sh
   @@ -104,6 +104,7 @@ cp_portable() {
            -e 's/struct ethhdr/struct eth_header/' \
            -e '/\#define _LINUX_ETHTOOL_H/a \\n\#include "net/eth.h"' \
   +        -e '/\#define _LINUX_VIRTIO_RING_H/a \\n\#define VIRTIO_RING_NO_LEGACY' \
            "$f" > "$to/$header";
    }


Thanks,

C.


