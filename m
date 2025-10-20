Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0934ECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqIX-0004RW-8I; Mon, 20 Oct 2025 09:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAqIU-0004Lz-MF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAqIN-0004Lb-Ul
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760968286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qN+/FReZbcWi2DGgBxGHXEDcVLR5EQpyBduOL0euK6Q=;
 b=gxztZhDkFHqkD0uxtvbDHIXbgZlFFB3I1QT319V6TYVqeIUZc/1XdxzFQiLMDu7o0p6oYG
 DGQbfS67ahDUlcPJZmrmup2XasaW2Ldz0Hl89V7EE/AiBibrVxXlyi/ucx63q03/YbYuZ5
 giCugk8vJs+5YqqS1RxIAGwG5b8p1jI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-lI4tOZwDMIWa7sitQv5R0w-1; Mon, 20 Oct 2025 09:51:25 -0400
X-MC-Unique: lI4tOZwDMIWa7sitQv5R0w-1
X-Mimecast-MFC-AGG-ID: lI4tOZwDMIWa7sitQv5R0w_1760968284
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47113dcc1e0so37066165e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968284; x=1761573084;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qN+/FReZbcWi2DGgBxGHXEDcVLR5EQpyBduOL0euK6Q=;
 b=GU+c8JMmr+L9+l0peM7B8Ijc7n1HAfKH8laQNgai2Ax9J8gJ6L06gqSQ66WmqREUiE
 3aYVC6mvq5V52lbnsQqN1mWHbqJwWBSGj2tf5yWIdZUR628m8vbSx0cSqsvu9gRzyg6I
 tL4W1YI2rSjxp2Kqn5rKA5t3t3Qp0W7vJGLJf/jDENVER3yetVsJMrBCrEP6PWg5/yCd
 tZR6ePUsCx43ogt9MbtNnDWVmkHzLQXsdFfYlvxWHYvc8b5J05I8oSRlcrvapy3iL6b5
 jhbkXvOBQ73eWMy19dKcKUgEEot1ROS4lb1XY8L6XP/Y6nqe1T4Au8jIs961EORo3/gb
 /zqw==
X-Gm-Message-State: AOJu0YzgrLiLXuwYOxE9r75r/mXGgaiaTPeXwFATvqpatL3ho4Y89sp6
 HOUg/UG+YUQ87hUVQfDxz5CZppAgPU1ttgWPF0ADNof+rUKQ8c4INoabxycDgPpiRhY96uFh3jZ
 e23FwW/e5m707y4qxYNdsdPN68tQD9p0+j3cC2QDP8ylPT7IouNTA/hHy
X-Gm-Gg: ASbGncte+c52tDFd2buE/D+ShfVa4q0yR0F9ZsUyb7lRBuyfEI1ZRaRyNn7uZD5kdm6
 hsY9L6uHJ1wyxWt8Shi2X4Ksja/CMMzmKD0EPmPkCEiDy98iKt8nD239BzwpRf5Cy+AeqX+0o9L
 8+ogIzIEPeWGLyMg1P+IKb3k9r16LobTG1Xf1eFnfuliGtkrSV6nxwZPNjFJOg86IjZ9QTiO2VY
 jEP8TVN4WeZbgppTppCOvG0cYRXyN8QD+JcSvfKrYnRJb+rhZE8qNlQMYYk69DBhtJm6f/VLu4M
 paCxG343tT7TrEDi+GiuaPSHe3CxgHzcrT/Q5Q52NfW/rpP0oIyb1sVLyyUhiMqQ3Uxx2UQySmW
 6Xwkjp1J0la7S8fRRp3QbkSOkKrJL7Mi7y19MPQkHPlB9lA0xEFANuCbLLhs9jBmjFYsjfK+mZh
 UuE/tTk4K4smHtCTxjYAKc4H2i/Sw=
X-Received: by 2002:a05:6000:220c:b0:3de:b99d:d43 with SMTP id
 ffacd0b85a97d-42704da613emr8492720f8f.19.1760968283920; 
 Mon, 20 Oct 2025 06:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvaldLAu3BbydD4R6WP2Bm2QPm3m9erwmfJc8tc2nrQoTn94ORobYkTvFP4W8hbkmeH0p2AA==
X-Received: by 2002:a05:6000:220c:b0:3de:b99d:d43 with SMTP id
 ffacd0b85a97d-42704da613emr8492689f8f.19.1760968283456; 
 Mon, 20 Oct 2025 06:51:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce?
 (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de.
 [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce678sm15713494f8f.51.2025.10.20.06.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:51:23 -0700 (PDT)
Message-ID: <597ff635-f256-48a0-b0e0-0978f9f5d742@redhat.com>
Date: Mon, 20 Oct 2025 15:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, hi@alyssa.is, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com,
 manos.pitsidianakis@linaro.org, Albert Esteve <aesteve@redhat.com>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016150544.GA1174075@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016150544.GA1174075@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 16.10.25 17:05, Stefan Hajnoczi wrote:
> On Thu, Oct 16, 2025 at 04:38:20PM +0200, Albert Esteve wrote:
>> v9->v10
>> - Fix transaction_commit invoked without transaction_begin
>>    on vhost_user_backend_handle_shmem_map() early errors
>> - Removed fd tracking on VirtioSharedMemoryMapping, it
>>    is handled by the RAMBlock
>> - Reject invalid BAR configurations when VIRTIO Shared Memory
>>    Regions are in use by vhost-user-test-device
> 
> Hi Michael,
> I have finished reviewing this series. If no one else has comments then
> it can be considered for merging through your VIRTIO/vhost tree.

Skimmed once again over it and only had one comment that could also be 
addressed later.

-- 
Cheers

David / dhildenb


