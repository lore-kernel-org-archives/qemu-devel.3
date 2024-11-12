Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9558D597B3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 22:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAzJB-0006nP-Tp; Tue, 12 Nov 2024 17:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAzJ9-0006mS-9a
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAzJ7-0001LG-RK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731450261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fCIOP1bkYsLx4G3BTsPbOttcnEMUAhgczcADWOOaNmU=;
 b=P6163E0IdqTNCmRvtLy64543Gt6w/TwOXYFhy/4way0vkpyp7TTpogfYv4+AP6K0lU/jRF
 B4t+EdZAqcPuiSPPkbQAYCoxoBsvq/6YLtcj/otKSIRtGRDHpBDxhNVV5Wlu1kHT97mQSY
 EXnq91JiHW/OY8O1H9NTz6A8Lnf7j9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-y-IiB0HrOMWp2SREjtig0A-1; Tue, 12 Nov 2024 17:24:19 -0500
X-MC-Unique: y-IiB0HrOMWp2SREjtig0A-1
X-Mimecast-MFC-AGG-ID: y-IiB0HrOMWp2SREjtig0A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso43870815e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 14:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731450258; x=1732055058;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fCIOP1bkYsLx4G3BTsPbOttcnEMUAhgczcADWOOaNmU=;
 b=tZcAa1uaSbF8cRorLUicWw94VfaU+MPdI9eqCurB8K6e+uZ9iWSQA2VJAfG2N6DviL
 e4HjcPgo4LRJuIP+bnc/DGTi1vyHOQPaiZXY4O6IBxDrD+LvPrlqkv5EomB9//Mg22v1
 nH4FQ6p4xHzoGfgW9/fFqK3Kog1fruXoEjjXdBhw03rkUVynr+StUqJbEPxieD2n7l4t
 SNf6q2jyamkYRIBpHDtH0PGeJdii+OLfZe7+jkLqv8J/jWX7z03HihOtD59agzhM1Sh/
 +qEiyWTLIMy7yHJ/ey/tcxHO7RZm8dMuSvZJxffvN5vUh44x3vZeczIqfFNabPcCqsL9
 od6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyoxKROstucHftvuh/bSfWr+Ig//zYkyPzOMXzKuimqMW1INmYLcdR7Ti0RElb8QnBdQNQhxgOEsI@nongnu.org
X-Gm-Message-State: AOJu0YwGqABzVJAeNZbd2gdeGA03abIwziY2FhTnEU7O+qOdrpcDHSgS
 i6w5RN4NxH3RfiUSrCNZM7O/Wc87AQQoGrViVWu84kb50Rh1AHpVDON3xQl84wM/z8JMWIodiP/
 FT5SimGqGydm/OtUm+eb+myOyiEhTMQB4wd3PAxLKBKS+U3BYjYtC
X-Received: by 2002:a05:600c:a04:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-432b7517a5cmr155280655e9.22.1731450258485; 
 Tue, 12 Nov 2024 14:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW+/fTCwuLY3emJFf9LkjxjmK0ue2mqKaL5MpaEGKJoYVSxqo586sIsglbq7vQKAolutjEEQ==
X-Received: by 2002:a05:600c:a04:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-432b7517a5cmr155280405e9.22.1731450258100; 
 Tue, 12 Nov 2024 14:24:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d?
 (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de.
 [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d48c731dsm4281965e9.2.2024.11.12.14.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 14:24:16 -0800 (PST)
Message-ID: <093dd833-d03a-4149-8928-0f31e84a3e03@redhat.com>
Date: Tue, 12 Nov 2024 23:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hostmem: Handle remapping of RAM
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
 <20241107102126.2183152-7-william.roche@oracle.com>
 <3ed8c7c2-8059-4d51-a536-422c394f34e5@redhat.com>
 <b6bdff02-4ebe-466f-93af-dda572505995@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b6bdff02-4ebe-466f-93af-dda572505995@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12.11.24 19:17, William Roche wrote:
> On 11/12/24 14:45, David Hildenbrand wrote:
>> On 07.11.24 11:21, “William Roche wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> Let's register a RAM block notifier and react on remap notifications.
>>> Simply re-apply the settings. Warn only when something goes wrong.
>>>
>>> Note: qemu_ram_remap() will not remap when RAM_PREALLOC is set. Could be
>>> that hostmem is still missing to update that flag ...
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: William Roche <william.roche@oracle.com>
>>> ---
>>>    backends/hostmem.c       | 29 +++++++++++++++++++++++++++++
>>>    include/sysemu/hostmem.h |  1 +
>>>    2 files changed, 30 insertions(+)
>>>
>>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>>> index bf85d716e5..fbd8708664 100644
>>> --- a/backends/hostmem.c
>>> +++ b/backends/hostmem.c
>>> @@ -361,11 +361,32 @@ static void
>>> host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
>>>        backend->prealloc_threads = value;
>>>    }
>>> +static void host_memory_backend_ram_remapped(RAMBlockNotifier *n,
>>> void *host,
>>> +                                             size_t offset, size_t size)
>>> +{
>>> +    HostMemoryBackend *backend = container_of(n, HostMemoryBackend,
>>> +                                              ram_notifier);
>>> +    Error *err = NULL;
>>> +
>>> +    if (!host_memory_backend_mr_inited(backend) ||
>>> +        memory_region_get_ram_ptr(&backend->mr) != host) {
>>> +        return;
>>> +    }
>>> +
>>> +    host_memory_backend_apply_settings(backend, host + offset, size,
>>> &err);
>>> +    if (err) {
>>> +        warn_report_err(err);
>>
>> I wonder if we want to fail hard instead, or have a way to tell the
>> notifier that something wen wrong.
>>
> 
> It depends on what the caller would do with this information. Is there a
> way to workaround the problem ? (I don't think so)

Primarily only preallocation will fail, and that ...

> Can the VM continue to run without doing anything about it ? (Maybe?)
> 

... will make crash the QEMU at some point later (SIGBUS), which is very 
bad.

> Currently all numa notifiers don't return errors.
> 
> This function is only called from ram_block_notify_remap() in
> qemu_ram_remap(), I would vote for a "fail hard" in case where the
> settings are mandatory to continue.

"fail hard" is likely the best approach for now.

-- 
Cheers,

David / dhildenb


