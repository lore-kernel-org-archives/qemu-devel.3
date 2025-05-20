Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4794C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNIg-0007DU-IY; Tue, 20 May 2025 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHNIe-0007D1-2A
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHNIb-0003Ll-Au
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747748784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pCiO8tUZDdbwLGQYtZfCG3A4lN2oZWvihkhPNWimN54=;
 b=K6WxKY91KLMbSENTM7unEjJYkeVwrqumVrZKb3Ro28QLRv69caULdNF0d4VJJ9XiZ0nhh1
 jWNCxwFf3BIruDRbVW0ZYBJTUJzqgcU/PnKeijWwRml4ovPrd+BjATIG5FOUEkjDGhE27T
 TxOMOjlnHZwCAs/Do12DgcaBJ5PjxYo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-NscWL-mHPumzgMNFk2ccqg-1; Tue, 20 May 2025 09:46:23 -0400
X-MC-Unique: NscWL-mHPumzgMNFk2ccqg-1
X-Mimecast-MFC-AGG-ID: NscWL-mHPumzgMNFk2ccqg_1747748782
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so44655585e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747748782; x=1748353582;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCiO8tUZDdbwLGQYtZfCG3A4lN2oZWvihkhPNWimN54=;
 b=EMMTJlCef0h6sDqaGOQSEiNGcULRgD5gn/kYrLaQBBWc/+YbeE/0fETa0wvZ6Vg7aC
 0t2SrC9aT2Dk6CR4yNNAW4meVHyF45XrQvnbGQCvpH2nTxt/i2wGf9PluEi7ZbiMIU5V
 UJMs2UpV9le5B8gHMQKcAAEN3hogVo4B9jD/vwsP7HxiQdEHQwVMhPfJpWXGysbWtFTe
 +frKlt50aFII0XcMEpnCW+RWT0lsqvoHmK3ud8FOp7tspyJKJa47vAbZ36gWQPubatfh
 RtU8UmePJrQzHv5nk3rbz/Xsrr5GaFvLOfTQhVARDIZBti8jE6IlXSZ/vGHCaQ6xWWYR
 OOAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWll5rCE8NBuIs4+v+ZZT0qW6I7nPhy8x1HbHrW9bPlAF6YfaIq+kDWbQ3YoKNqzfra8T5/oxB/Ei0Y@nongnu.org
X-Gm-Message-State: AOJu0Yy4OPecr40sI+pcW9MJ6r57MT68H00Ak+7x4CJEg5WvLD9GJj/o
 o9GnyWML9qzuvsyBu/MqRlmfcaONhlL5b2w7gvKl7MdkyNAn5Uj0sbpK0vdRSzXFgTpLUVoo2tU
 xNPVI7ox8svkdEYbxlZ7evzG28r5GCZDnt4bhKGQHMk6+ZHKOuOV9sjfR
X-Gm-Gg: ASbGncuR19XdX3tHqtzo91MOkvNfDCvGVDoq+pc9sps0p3tZbbvHjkn5JVlQbT+xMMW
 Di/Gc1wlzcxnzkXt9QZo10u2DhkulwYyZEwrcoKlKlTmRxkNr8COJu6IPzzwNXSilPkSdBqTYiN
 rL0UFZlAu5XiMEMT1P2VN5oFUyeJea0V1A/OYkJEYru47kbgyg4z4HYgoxuA0Bha4R6Xj33sx5l
 /aAanCOQ3oYaLQLt91/hm+J9ruHNzmCJMms1uEpvGRvS6ZGF7cBeSD6cgTIaTO/2fReyxlxCl+2
 0Xwegk+lasvoJZkvJM7CxDmCB9/Ne5xTUcrfplT1CLR/7x0HtQ==
X-Received: by 2002:a05:600c:3d18:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-442fd672e0emr126616935e9.33.1747748781953; 
 Tue, 20 May 2025 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa75/5RbvLebh82cHUWpay6TzT0r3T/+GeBe4X0rFMB4ukf6Ev2sm5Za2ZVb38gL+tP2c5Cg==
X-Received: by 2002:a05:600c:3d18:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-442fd672e0emr126616695e9.33.1747748781582; 
 Tue, 20 May 2025 06:46:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a892sm16153384f8f.24.2025.05.20.06.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:46:21 -0700 (PDT)
Message-ID: <304064d5-7211-443a-8ded-43f704a7ab1f@redhat.com>
Date: Tue, 20 May 2025 15:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
 <bad3129a-8470-415e-8e85-0238b3ef1b26@redhat.com>
 <ef48d347-b36e-4442-b97e-bea284eab1ac@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ef48d347-b36e-4442-b97e-bea284eab1ac@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


>>> @@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>       ram_addr_t translated_addr;
>>>       Error *local_err = NULL;
>>>       int ret = -EINVAL;
>>> +    MemoryRegion *mr;
>>> +    ram_addr_t xlat;
>>
>> xlat should be :
>>
>>      hwaddr xlat;
> 
> Will you make that change when you pull, or do you want me to submit a V6
> with this and the RB's?

I can handle it.

An ack from Michael (vhost) is needed for the PR.

Thanks,

C.



