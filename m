Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37310C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlIj-0007tl-Jp; Mon, 21 Jul 2025 03:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1udlI7-0007Z7-5B
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1udlHy-0003oz-P3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753084219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncMBR53AIGXeOgrPe8UjKqALGhybLctri0J4w3A0FvE=;
 b=PRCxgj6JglfcNGF7nXzsS7EdWu+DkjGZryXuEFUw7kZ4guUtN6khJw869Sl3GrNXjq2wsE
 aaMw7nQ/yUbyGiicLN3fpOOGbWbahCckJk9RibTg1bldeglRtodu22OKdTRENjHfi0JPNC
 c/1vtzmWv5OTgw2alZ3/caRobQjssBw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-QxUsLepFPl2q4iI9jOOCEA-1; Mon, 21 Jul 2025 03:50:17 -0400
X-MC-Unique: QxUsLepFPl2q4iI9jOOCEA-1
X-Mimecast-MFC-AGG-ID: QxUsLepFPl2q4iI9jOOCEA_1753084217
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e4ca52aedaso28710685a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753084217; x=1753689017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncMBR53AIGXeOgrPe8UjKqALGhybLctri0J4w3A0FvE=;
 b=e9gGWeE9X3sagGhYiJyq1rB978xwqasg16vdY4/oZu1nJfv3Ya61fb2btMJnYF/zaa
 GGnLMV1RKQJUtngHxoSfqlFqobQ0EMDbvAz9CMgK6plX1hYVUxgILgKXXA6AxbA1VRgT
 vVg71yGRjjMs08NQD5fDQKCR1Bf4y7MNVBhySmDFieshLbZnEmvvj4rQGahqgOKzAyDg
 iqZIUqYCRzNcEMiTQQImBrKR/8cAV8fELlU2n+CDL4O7U6PGeE7qwQ5oi4TDOTbnS4BK
 XICxnZ1/5pakuDfIwBXcmBN4zAuccFU1PQ19jLr5GMou54ZK9C+7DRU+Z558/qq+CjNj
 Cjxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHy70wGwjNabA1sT29Gwv9oh2AX8a6eWNzGHvtoEwcu0pBUKjaR2ul3BvNWcvRTSrX5MN5PnUYXnnh@nongnu.org
X-Gm-Message-State: AOJu0YzD9PrflzzqR75jVULl+u58Bh/oq1DT4Ofcsg7ttyNqCoVyMtYc
 gqWGlmlLPJG8bVuMTzucVOUJpcjHSHq3O8zybfwom3xIO26yuD2sPEcCjGY1q8Kl/7hXKVcQ7u9
 19tsdBMLNjwJmBINYkmstcZWZYODGvW9vPpW3+bISlCb5KMVwA6gZOyEA
X-Gm-Gg: ASbGncuaZgnpqvmIMsgpWKxuTi7lugwZapzkFUJAo2WGyjmUZ0a6oVGakBLG9qDv4CP
 S+o3pznWKb5g1c80YBqUHlmLvI/9ldvMvTPTNKvoradDT05F3auZAY0i9a4gaD7ygNC66ubg9Hw
 bNjwgmL9GOoV6RnKPcvtCd8j4wV6qhexHPrOyvqiw9joStmrWxJIne2mV2zXTGJ11RDeiCfDKsJ
 HLNM9qvv0Adqf1qKygZeZsYK8gp03wTaIFBd+3+T3Z0uaOoSz11RZ6W8B81sIe8w+zWOcEhs2Ip
 W0JQBXKRiQDZFk+4aTdG3SgWPsL+CNsWkFQmxEsUJCvQ+i7pePLWttqIK1rZWPikhoA2oMR+Sjt
 6Qma4OuZImqwpBe4=
X-Received: by 2002:a05:620a:8393:b0:7e3:30ac:8cb3 with SMTP id
 af79cd13be357-7e342a6041amr2449734785a.12.1753084217195; 
 Mon, 21 Jul 2025 00:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX+zz9LmKhXBgbRAanc3wnmPNYpU6Itoi3wASs/i7muplrz4cU1VJUiFKUAZ67OUTIx79/mQ==
X-Received: by 2002:a05:620a:8393:b0:7e3:30ac:8cb3 with SMTP id
 af79cd13be357-7e342a6041amr2449732585a.12.1753084216667; 
 Mon, 21 Jul 2025 00:50:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c72bf3sm403245185a.86.2025.07.21.00.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 00:50:16 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:50:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
Message-ID: <4wehjmkobd4tqmjpa2jgm3gzl46cmdqxltcglgmyvg42xgwhwc@kfmcvm2zexgn>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250721065220.895606-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 21, 2025 at 02:52:20PM +0800, Xiaoyao Li wrote:
>shm can surely serve as the shared memory for coco-VMs. But currently it
>doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
>flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
>require private mmeory.
>
>Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
>allow shm memory backend serve as shared memory for coco-VMs.
>
>cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>---
> backends/hostmem-shm.c | 1 +
> 1 file changed, 1 insertion(+)

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
>index f66211a2ec92..806e2670e039 100644
>--- a/backends/hostmem-shm.c
>+++ b/backends/hostmem-shm.c
>@@ -54,6 +54,7 @@ have_fd:
>     /* Let's do the same as memory-backend-ram,share=on would do. */
>     ram_flags = RAM_SHARED;
>     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>+    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>
>     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
>                                               backend_name, backend->size,
>-- 
>2.43.0
>


