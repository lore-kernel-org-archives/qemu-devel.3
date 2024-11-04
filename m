Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D95D1BDEB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t83U7-00088p-D1; Mon, 04 Nov 2024 15:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t83U0-00087u-Gp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t83Ty-0008Uq-S4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730751325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=stGYUO4vmvYz+Zs/XcdB9ZEgjgPcUQcnM2itXX0h1D0=;
 b=MEev4Tsg5+7rBvN6Xfh25mxbWUqLFdzmpqGDbA6kw077sQC1pJWlgwTRz42Hb0BF9/DZ+y
 C7BvW6hjptqEUrvDI3t1bPWlXN85TIOhuribBF9OXhOAVicOTVGJysIuXye+1wVNxCKK27
 MH4ShqJ5hDn8FK/gDVdEb3hB5e4OYD0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-pIWa-VnoO3Olbj3mVxVQwQ-1; Mon, 04 Nov 2024 15:15:21 -0500
X-MC-Unique: pIWa-VnoO3Olbj3mVxVQwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so34264225e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730751321; x=1731356121;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=stGYUO4vmvYz+Zs/XcdB9ZEgjgPcUQcnM2itXX0h1D0=;
 b=qtahzRk+L3fofEr9PhDDwLOEVTcRZ0bRm0DpwFu6EHXkJ4Lfie3HUA4ctkfWFrCdz0
 oQ02WgwSYttSvwDsKWQQFvcAR5jqx9VO0YMERbR67onybMEMqRHrOzl2m2h3xWD0gdIC
 LVAIi7dt+9b8uQ16MUShwYTsiqlEmPV+3gMU+8UqpKfCn8k8w61IWvUj4csD3/Z8Pf4p
 TVh8Xqd9AZzEMwjogFqhCzl0BHHXXH7HiMbjjFGxvhlARTcB7CTkXxrsTNeJBjmFlnzb
 a4NO14sNDjioQ2yJqoeEjDS9cdzOMWfXeYqpAQZ6ZqqymYOV/+Jgutn1zloHOnhQ70ay
 ohpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsYadO0DZYQb34lRPogYcyhUM94n47IylLyQbbnqUEylnoZeBKEsZhFg5yEulqr+8EsscdYKzv4ZD+@nongnu.org
X-Gm-Message-State: AOJu0Yy5Tr0cnVg5FZKkloSA+b1IqnCRDmNgjE2/11B7hnAntYO+aANO
 2dD0+9GlVsY/lH2NcvbeH/4Egp+T4EIHmavfRMTjE9LY6Ca3bpLXD+vHVJ2vkZ2cyb8ZEJUjVbf
 JHso2Uqk+XJtlKVLgBs54NnkBQDJENhQ9zL6wAV6+jiQt2OhavHfo
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-4327b6fd999mr148506555e9.13.1730751320696; 
 Mon, 04 Nov 2024 12:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnHwGPCmMceUFWjLc2SrIoYJmOv3UL/Qa7TUGCfQRtiHIPBbC9k65UDD3uQ/LVaPGoNhh43g==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-4327b6fd999mr148506325e9.13.1730751320339; 
 Mon, 04 Nov 2024 12:15:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:e500:e96a:8043:1211:8e6a?
 (p200300cbc72fe500e96a804312118e6a.dip0.t-ipconnect.de.
 [2003:cb:c72f:e500:e96a:8043:1211:8e6a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5230d5sm163047575e9.0.2024.11.04.12.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 12:15:19 -0800 (PST)
Message-ID: <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
Date: Mon, 4 Nov 2024 21:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
From: David Hildenbrand <david@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.11.24 20:51, David Hildenbrand wrote:
> On 04.11.24 18:38, Steven Sistare wrote:
>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>> on the value of the anon-alloc machine property.  This option applies to
>>>> memory allocated as a side effect of creating various devices. It does
>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>> the command line, or implicitly created by the -m command line option.
>>>>
>>>> The memfd option is intended to support new migration modes, in which the
>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>> and if the mode also transfers device descriptors, then pages that are
>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>
>>> A more portable, non-Linux specific variant of this will be using shm,
>>> similar to backends/hostmem-shm.c.
>>>
>>> Likely we should be using that instead of memfd, or try hiding the
>>> details. See below.
>>
>> For this series I would prefer to use memfd and hide the details.  It's a
>> concise (and well tested) solution albeit linux only.  The code you supply
>> for posix shm would be a good follow on patch to support other unices.
> 
> Unless there is reason to use memfd we should start with the more
> generic POSIX variant that is available even on systems without memfd.
> Factoring stuff out as I drafted does look quite compelling.
> 
> I can help with the rework, and send it out separately, so you can focus
> on the "machine toggle" as part of this series.
> 
> Of course, if we find out we need the memfd internally instead under
> Linux for whatever reason later, we can use that instead.
> 
> But IIUC, the main selling point for memfd are additional features
> (hugetlb, memory sealing) that you aren't even using.

FWIW, I'm looking into some details, and one difference is that 
shmem_open() under Linux (glibc) seems to go to /dev/shmem and 
memfd/SYSV go to the internal tmpfs mount. There is not a big 
difference, but there can be some difference (e.g., sizing of the 
/dev/shm mount).

Regarding memory-backend-ram,share=on, I assume we can use memfd if 
available, but then fallback to shm_open().

I'm hoping we can find a way where it just all is rather intuitive, like

"default-ram-share=on": behave for internal RAM just like 
"memory-backend-ram,share=on"

"memory-backend-ram,share=on": use whatever mechanism we have to give us 
"anonymous" memory that can be shared using an fd with another process.


Thoughts?

-- 
Cheers,

David / dhildenb


