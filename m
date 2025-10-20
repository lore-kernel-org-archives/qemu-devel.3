Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646ECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqHQ-0003IS-KR; Mon, 20 Oct 2025 09:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAqHL-0003GH-PR
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAqHH-0004FG-9q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760968220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1SmDHBXu2M4qFsb0wcG64194s6IG7eQFgbHLTv5xiKA=;
 b=ZhyxPs2kBCLBfu/HSHSlO4bnBMqdZRyBOiIoHfrelGTIsDr3nVlcIwGWLg4DoEdRN3Fz5A
 PEb1UrKG6fUt2ASb5txY0ASn2rhEDpbXx+MK+zgo2wTriQRP8wsNGLMwZwpehHpKL0AVwQ
 OnaohT+06UTG7y+34BDueVWuyDvIdUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-l7e8D3ctPNeZu-RNnmIb1g-1; Mon, 20 Oct 2025 09:50:18 -0400
X-MC-Unique: l7e8D3ctPNeZu-RNnmIb1g-1
X-Mimecast-MFC-AGG-ID: l7e8D3ctPNeZu-RNnmIb1g_1760968217
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so95333075e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968217; x=1761573017;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SmDHBXu2M4qFsb0wcG64194s6IG7eQFgbHLTv5xiKA=;
 b=r6PssxxmJb5TKAbzSmQwxryAcnxgXV2l4bOJ5tSQGLhEQ6mvztGm/U+4AcNYy24BJl
 kzSvkWR6tCVBQEtEPCTftUkXhxKCgjSD+NEv5FhhrWRSkKjTpT89MBshYC7H976oB4H/
 CHjtX8I4LclRPupf5JMVI68O1Cf3YBx+TA9KnFVCpndhYeFi8U9QLaXiXLOHyCBo44H1
 Itnu9ntU1KNUIRf0uufKCHDT7KJHyOmW8DcUflDbdjQ9UFgL1cqIKyILfoqx2Nr825XB
 Did0EHCz6cn5CZY1CIghBat8tgWEP+pFMIwiwa7HyWl0VadXpJggp7WvO9C1qKsk/zBS
 mMIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLg8xrOVOMPdjVDv6GFhghmxMMDzXWuRoBq5eQodZYHRnP+Nj6yeWe0P3l/4uj0l937sI+nuSFoZd+@nongnu.org
X-Gm-Message-State: AOJu0Yw0IdE4EUuE+jk1uixuoNh9hUBv183WqF4gBwpym9kYpthrwUBj
 xZwo0OimjZbWBZJKFMCo3elkiuXGl7L6sSjLToM9XySTSxRPIdLl8XiuOP0KtRhc4u2A1qr0jEF
 hDnA/CyhjnAMC1qxa9g1bF9U461R5pGLGzGFdrjx9t7Q4+trGagyBKsJB
X-Gm-Gg: ASbGncuzUE/8ZtBtAuwJTL0oR8xv88GP2eV4kEdBIcXUgjt9dLZEHTjW6rFdApzAcq2
 MFb29vO4vZxuHp2iLJ9jpdnIYAxo3FbE36jG4h/ideGRxhoJDtZxsvDZV0TqKwwBv8Pxw2qJ2Va
 DsXtyYE9GPuA+CzudPBbCODUfeA6Y6vtzhKsCKwruvmJ9GlgWsfcr9jXdh4/KKXTlXWOwuJQydd
 Fw7xv5FdZ7zodbVjxBmU8ji8N+C8zynHlEVL1MW3QuGAPOf8L09QTIRoi/gWo6qdWKhwFgcYnMn
 ZuBn34nK7YokmB3N4lc0RdZfAYk+VeXOzQwb6UHCY3SAIKVi/NxFMSHydaKh1v+QXa8/ZLQ5h5w
 ajrJIeOOu0HRI1KDpBVjlQjOpCiCMDserYugDFJUqtzAs1Xip0zjz8QP6rX5ESh2CBiZjTPj29P
 d3v8lnQWlByvGr1K1pPQLtnmtZgoo=
X-Received: by 2002:a5d:5d0a:0:b0:426:ff46:93b8 with SMTP id
 ffacd0b85a97d-42704d8444amr7368836f8f.8.1760968217380; 
 Mon, 20 Oct 2025 06:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt8OXbpHrWv2ofu+rkZJiun8WFyG6S91Y+Di8+9PafYhg1lS+NfSdAMs7RMv6n2ITgLNo7Ww==
X-Received: by 2002:a5d:5d0a:0:b0:426:ff46:93b8 with SMTP id
 ffacd0b85a97d-42704d8444amr7368813f8f.8.1760968216893; 
 Mon, 20 Oct 2025 06:50:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce?
 (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de.
 [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce586sm15625076f8f.49.2025.10.20.06.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:50:16 -0700 (PDT)
Message-ID: <a74da624-8665-46d6-846d-15fc932775cc@redhat.com>
Date: Mon, 20 Oct 2025 15:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, hi@alyssa.is,
 stefanha@redhat.com, jasowang@redhat.com, dbassey@redhat.com,
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 slp@redhat.com, manos.pitsidianakis@linaro.org
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-2-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016143827.1850397-2-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> + * Returns: 0 on success, negative errno on failure
> + */
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    QIOChannel *ioc,
> +                                    VhostUserHeader *hdr,
> +                                    VhostUserPayload *payload,
> +                                    int fd)
> +{
> +    VirtioSharedMemory *shmem;
> +    VhostUserMMap *vu_mmap = &payload->mmap;
> +    VirtioSharedMemoryMapping *existing;
> +    Error *local_err = NULL;
> +    int ret = 0;
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        ret = -EBADF;
> +        goto send_reply;
> +    }
> +
> +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> +        error_report("Device has no VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d", vu_mmap->shmid);
> +        ret = -EFAULT;
> +        goto send_reply;
> +    }
> +
> +    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> +    if (!shmem) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d not found or uninitialized", vu_mmap->shmid);
> +        ret = -EFAULT;
> +        goto send_reply;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        ret = -EFAULT;
> +        goto send_reply;
> +    }
> +
> +    QTAILQ_FOREACH(existing, &shmem->mmaps, link) {
> +        if (ranges_overlap(existing->offset, existing->len,
> +                           vu_mmap->shm_offset, vu_mmap->len)) {
> +            error_report("VIRTIO Shared Memory mapping overlap");
> +            ret = -EFAULT;
> +            goto send_reply;
> +        }
> +    }
> +
> +    memory_region_transaction_begin();

My only comment would be whether the 
memory_region_transaction_begin()/memory_region_transaction_commit() 
should be hidden behind some 
virtio_add_shmem_map_start()/virtio_add_shmem_map_end() helpers.

Talking about memory regions in this function sounds odd given that it's 
more an implementation detail hidden by other helpers.

Then, we can also document why these functions exists, and what the 
contract is for calling them.

-- 
Cheers

David / dhildenb


