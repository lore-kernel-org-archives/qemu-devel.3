Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADC3C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCDr-0005fh-FI; Fri, 24 Jul 2026 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wnCDp-0005fP-HI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wnCDn-0002zW-TB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784885374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4R9aT13C+0axqR6jP0+rzpEvnUVpH1pFF7Reu4c29dM=;
 b=SzMJQFMM2tdC4vdNmCpztCYxsLRvLiOkLyoiDrN1vCdsYkJtMjOOYp+2pojklAgCjLq5zG
 CZKJ35xOmIzwDEGvvK+59TFlXq04YpjktAwWOLtXYROt0KxBQpi81Z6Ymy9X6DbET6X9Ns
 JOw3Jb8HXRVoF92MAcO8bp4NTUnYhQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-8s0x-0wpNmOSKMte22l6nA-1; Fri, 24 Jul 2026 05:29:33 -0400
X-MC-Unique: 8s0x-0wpNmOSKMte22l6nA-1
X-Mimecast-MFC-AGG-ID: 8s0x-0wpNmOSKMte22l6nA_1784885372
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955e865174so1669515e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784885372; x=1785490172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4R9aT13C+0axqR6jP0+rzpEvnUVpH1pFF7Reu4c29dM=;
 b=Dm2Zwe+oz1AnIqpW9W9/4hwQ+etpjYK6WcC2tDOOOb39YxAhbbZes/7bohEGBa9ajh
 Wz2yMf8jdE8qpLFqb1mqqwWaoxTdxpwywC2qdt4po75fZd/awalAL82WDWBR6yR0vjZo
 5jOiEsCX2LEMColLrsgHFNKjhjYyNnR9DB4PKiAUMMIxaZGmXRg0+RcuDn6F0v3qPAEK
 DfRlu/V6KPeo7OGAUSU3Gyu395Pzq3LtPpJpyh2Cc2JKXBMS9Dz4TrpuXBl47ILVomT/
 U/6hgTWbryrWvC4CTOhSPsvs/JFOufM2eyjbPInIJ+nfNDh6bMIAILhYFPIxwefCCnes
 hFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784885372; x=1785490172;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4R9aT13C+0axqR6jP0+rzpEvnUVpH1pFF7Reu4c29dM=;
 b=kEhqSI/ZoUDlGTvFmDIwPY/JkPNMXiJYd2ctMXWIQSLPihAmiDFGFUIjzwag69Go3I
 gCXUKQPZsKD1hYdkEvF89jDSORHSOC/3AAIQ6YuSXVo2M0CZazCyXILwhj9RTweR0oDy
 tDUh0wJdBmXvCnuOsx3U1bGBxjahw4+vyGB22D9PGK1BRXqclFmniPhPd4yoIh6a9qy6
 gre/TuAZHbkSCL/Ih11n55iS9gJ8mMfyGpF9nMSzXy8AJUZORjNCVFtVipqRqapg4u3H
 We9vlCPrB4uv8xZ95mb+VRIdBLKRNo86mESRGFzt3JIgMcHSHcgNhwKlntgZjYoE+FGN
 0ekA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkDzHlT2oeKbFQBHwFYLA32r8z2EPBIGNc++lmDuVYkaMmZPsjgY4djqLXRIMTq1vKfVTPqbGTD6ZZ@nongnu.org
X-Gm-Message-State: AOJu0YyB9ouY6KS/fJQGcoDAOmiS+5UUOJL4uFe7vudr65STZm8+KF1w
 38kbRoBarwhroW0qIyAdUQAx+NnYYuODy+vChXvXxgtRGe3PCjieB8T9TEdu6OxlVGuPEVs/a0B
 O/5Vus52bNOksu8m3K5B8rfrVXpdYFv8QlNrYf/hrDLr1qDn3GPXUGHKo
X-Gm-Gg: AR+sD11kvgJVi9Gn8o7/qdI755WzVCFz26FbZM71hL6uCcuoUdELc0iV2jKwqlog4y6
 tkexlb6WkB3bIahEpwPBEKOA6enOFqOJksJijQNs9J2gsU318K8RQCjLymWo2AwIe90pBaAIdj/
 JWENk8J7dqUJImMlG0f4JqOeVzGa2U0jQNFpeHUAa6JwfJFrgDKUsCVH5uOHXzWjzKKkfXzg2qe
 4g8xh1wsKodrK5rXCLxX1Lt83HRVzNA6NqqJi7tBe+0fCQ/UrQCe8lcKQnfzriEEeOl9gDRxFfy
 2Vop9sZ7rA/YqBeIYYT0NnTpaZOlEnlz3yL9SDgYHtDe+s0TOte7T8eY0NFurUSJSJeB9FzmLyp
 BDGZmMULSLgWqA5PiMeYgGP2taBI0q4i1ccDMVZ8=
X-Received: by 2002:a05:600c:3b86:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-49573ccd0b5mr73954535e9.11.1784885372108; 
 Fri, 24 Jul 2026 02:29:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b86:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-49573ccd0b5mr73954185e9.11.1784885371637; 
 Fri, 24 Jul 2026 02:29:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6b049sm63884055e9.6.2026.07.24.02.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 02:29:31 -0700 (PDT)
Message-ID: <e0af22bc-bbce-471e-ad3e-41b070fbead3@redhat.com>
Date: Fri, 24 Jul 2026 11:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 Jia Jia <physicalmtea@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20260708063944.1788243-1-lvivier@redhat.com>
 <9ce8bdaa-70a3-4b8b-bb26-8cb84c5da857@oss.qualcomm.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <9ce8bdaa-70a3-4b8b-bb26-8cb84c5da857@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 7/24/26 10:31, Philippe Mathieu-Daudé wrote:
> On 8/7/26 08:39, Laurent Vivier wrote:
>> Fix a heap-use-after-free in the virtio-rng frontend when a delayed
>> rng-random backend completion arrives after the virtio-rng device has been
>> hot-unplugged.
>>
>> Fixes: CVE-2026-50624
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3917
>> Reported-by: Jia Jia <physicalmtea@gmail.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   backends/rng.c         | 16 ++++++++++++++++
>>   hw/virtio/virtio-rng.c |  2 ++
>>   include/system/rng.h   | 14 ++++++++++++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/backends/rng.c b/backends/rng.c
>> index ab94dfea850a..182269be4a83 100644
>> --- a/backends/rng.c
>> +++ b/backends/rng.c
>> @@ -68,6 +68,22 @@ static void rng_backend_free_request(RngRequest *req)
>>       g_free(req);
>>   }
>> +void rng_backend_cancel_request_entropy(RngBackend *s,
>> +                                        EntropyReceiveFunc *receive_entropy,
>> +                                        void *opaque)
>> +{
>> +    RngRequest *req, *next;
>> +
>> +    QSIMPLEQ_FOREACH_SAFE(req, &s->requests, next, next) {
>> +        if (req->receive_entropy != receive_entropy ||
>> +            req->opaque != opaque) {
>> +            continue;
>> +        }
>> +        QSIMPLEQ_REMOVE(&s->requests, req, RngRequest, next);
>> +        rng_backend_free_request(req);
>> +    }
>> +}
>> +
>>   static void rng_backend_free_requests(RngBackend *s)
>>   {
>>       RngRequest *req, *next;
>> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
>> index 66690a34dc97..a77ea5ab1385 100644
>> --- a/hw/virtio/virtio-rng.c
>> +++ b/hw/virtio/virtio-rng.c
>> @@ -234,6 +234,8 @@ static void virtio_rng_device_unrealize(DeviceState *dev)
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VirtIORNG *vrng = VIRTIO_RNG(dev);
>> +    rng_backend_cancel_request_entropy(vrng->rng, chr_read, vrng);
>> +
>>       qemu_del_vm_change_state_handler(vrng->vmstate);
>>       timer_free(vrng->rate_limit_timer);
>>       virtio_del_queue(vdev, 0);
>> diff --git a/include/system/rng.h b/include/system/rng.h
>> index e383f87d20b2..5b0893eb2bd5 100644
>> --- a/include/system/rng.h
>> +++ b/include/system/rng.h
>> @@ -86,4 +86,18 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
>>    * deleted.
>>    */
>>   void rng_backend_finalize_request(RngBackend *s, RngRequest *req);
>> +
>> +/**
>> + * rng_backend_cancel_request_entropy:
>> + * @s: the backend that created the request
>> + * @receive_entropy: the function invoked when entropy is available
>> + * @opaque: data passed to @receive_entropy
>> + *
>> + * This function is used by the front-end to cancel all requests to a
>> + * given backend. Requests to cancel are identified by the receive_entropy
>> + * function and the data passed to the function.
>> + */
>> +void rng_backend_cancel_request_entropy(RngBackend *s,
>> +                                        EntropyReceiveFunc *receive_entropy,
>> +                                        void *opaque);
> 
> I'd simply name it rng_backend_cancel_requests(), and make the argument const:
> 
>    void rng_backend_cancel_requests(RngBackend *s,
>                                     const EntropyReceiveFunc *receive_entropy,
>                                     const void *opaque);

I agree

> 
> I suppose we should implement spapr_rng_unrealize() calling this helper.

I don't think this is needed (at least for the CVE case) as rng_backend_request_entropy() 
here is synchronous and spapr_rng is not hotpluggable.

> 
> For this patch (preferably renamed):
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Thanks,
Laurent


