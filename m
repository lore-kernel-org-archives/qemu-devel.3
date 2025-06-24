Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C7C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0Jh-000774-U5; Tue, 24 Jun 2025 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uU0Jf-00076r-M4
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uU0Jd-0003Qe-TT
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750758703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o1Xn7exViJ5XiCzBolqdsBU4hG+gJ473jKEJ6tSqefU=;
 b=MN1DRUV6itL3HUMUL2aEEJaG/xue/6DBouwxWcWQtXX7eKRi4jWduuxe2vAK+sIqXqXf74
 AMaQOARJiGCZzsYu22AN37OAQHHDEKkovuN5c3yghVdg8xRrnVSLH3OTDo1htjCLfiC7OI
 7rRXxOhPmbbRfjsD2cfS8s59JMlpDE4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-mTZyW0i0NaiWbvU1XKC0Lg-1; Tue, 24 Jun 2025 05:51:38 -0400
X-MC-Unique: mTZyW0i0NaiWbvU1XKC0Lg-1
X-Mimecast-MFC-AGG-ID: mTZyW0i0NaiWbvU1XKC0Lg_1750758697
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so137170f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 02:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758697; x=1751363497;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o1Xn7exViJ5XiCzBolqdsBU4hG+gJ473jKEJ6tSqefU=;
 b=o4kU/3mstO63wyCfYIM/MGyr3OrgyLeSaV8US6Nqi4XDW507hkDENPue55EzNQ14pV
 jG+YiXemxjWYrXcm4QUqJwz7kv4Kk6rSBcXquqwehFx5EmsyzWOBeKkaQjKEsQdZlTaU
 OGA2KxGAoMH9cjNArlaZlseSY/q6qbPzRXmTLfhqpIWKxAdHDQN04QYNTcFU15/OxW3p
 LiwyihsuCD1kI7rlQlu8VdEcnrwaHnr3drRKKMEXGyUUcZ+WYnAi+wpmHA6diHTiOlt0
 Id3JruPrWpQ1tzLWSnOQLt8C79yysy6DF2qVeIWhxO9FUfhQNLooJXnYDP6xPb1C3JwB
 t5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFpko98KyPLeFJQAhfFjHyW6EcEXWQSp0/TLUSt6uQew5NdUg0+LFElX8R0qZZJzAh3SnUMtRH+yFP@nongnu.org
X-Gm-Message-State: AOJu0YwCg2MP9FlClI2yM82KXO7AvUX+2piRfPqMyjKFWQK2xsFhPFlm
 vDHSm0FMm1GIzUPjEKHqWtfiW8A468Ki/qMnPsOrZBLbu1UuXQVH2bzSdnK2iaCcRCaJ6UphTf+
 28ptrLEpxLvLwh7NWeKROSHvAQy6C214VlKFZZCJaZ1e8ivQuR1c7XeCA
X-Gm-Gg: ASbGncv5tzqLYHQRS7bseLd7IX9yCNsi1Hi9HG29TAVzqhGc/ax8nnAprmCqZdd3jKp
 f8GMp3yY/HTEmh5jF72hs3hgbNxUT9vnllpyTU2Sh7EKRP0ahnl54nja/wQftmznl/NSW8OK6Ny
 6DQ/xFTZ/RR/34/drLwSX504CPHJ0qbMwL4E8PsFnGMUef5NZ9Sdk6D0xL/5ODyOxw9t5fAsyAW
 dlCd7bodpbivr247PxAYY4p7BtqDInzP3MZyIukTauYcec0PMZ5Vu2Dp3NY0pVv4uWCvt+VUaYg
 ZwQMX56s+DFs8QUR0Ib9YxYdxKEC5R2zTypg8vPDoLk/VqKfm1e451Y=
X-Received: by 2002:a05:6000:1acd:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a6d12e6b31mr13999537f8f.48.1750758697037; 
 Tue, 24 Jun 2025 02:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3kTOSeFqpR5aeqK4j2CQjXi3VDWGhNL8iC3p74SD6K+B2vgC1W40oOG8TRKJx50jXj/ToqA==
X-Received: by 2002:a05:6000:1acd:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a6d12e6b31mr13999500f8f.48.1750758696583; 
 Tue, 24 Jun 2025 02:51:36 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f22c7sm1504482f8f.53.2025.06.24.02.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:51:35 -0700 (PDT)
Message-ID: <5dafefe3-78ec-44a4-a784-9b2333a71364@redhat.com>
Date: Tue, 24 Jun 2025 11:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Enable shared device assignment
To: Peter Xu <peterx@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Alex Williamson <alex.williamson@redhat.com>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
 <aFM2hFgjiBm3nML6@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFM2hFgjiBm3nML6@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.06.25 23:58, Peter Xu wrote:
> Hi, Chenyi,
> 
> On Thu, Jun 12, 2025 at 04:27:41PM +0800, Chenyi Qiang wrote:
>> Relationship with in-place conversion
>> -------------------------------------
>> In-place page conversion is the ongoing work to allow mmap() of
>> guest_memfd to userspace so that both private and shared memory can use
>> the same physical memory as the backend. This new design eliminates the
>> need to discard pages during shared/private conversions. When it is
>> ready, shared device assignment needs be adjusted to achieve an
>> unmap-before-conversion-to-private and map-after-conversion-to-shared
>> sequence to be compatible with the change.
> 
> Is it intentional to be prepared for this?
> 
> The question more or less come from the read of patch 5, where I see a
> bunch of very similar code versus virtio-mem, like:
> 
>          ram_block_attributes_for_each_populated_section
>          ram_block_attributes_for_each_discarded_section
>          ram_block_attributes_rdm_register_listener
>          ram_block_attributes_rdm_unregister_listener
> 
> Fundamentally, IIUC it's because of the similar structure of bitmap used,
> and the listeners.  IOW, I wonder if it's possible to move the shared
> elements into RamDisgardManager for:
> 
>      unsigned bitmap_size;
>      unsigned long *bitmap;
>      QLIST_HEAD(, RamDiscardListener) rdl_list;
> 
> But if we know it'll be a tri-state some day, maybe that means it won't
> apply anymore.

We discussed some of that in one of the revisions, and it's not clear 
yet how virtio-mem will interact in confidential VMs with that (we will 
have to have both active at the same time). I shared some ideas, but 
they are all stuff for the future.

So how the bitmap(s) will look like in the future and how multiple 
RamDiscardManagers will interact remains to be seen.

-- 
Cheers,

David / dhildenb


