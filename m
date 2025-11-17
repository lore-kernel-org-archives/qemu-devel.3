Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F388ECE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKv7v-0000pF-8U; Mon, 17 Nov 2025 04:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vKv7t-0000oz-8Q
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vKv7r-0000Rd-J7
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763370138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ImmC/R2NvEgoAvQam4eXs3eLYCfSP7RSMkYexY9azzY=;
 b=bsghdYNAtnzvDSbCP+ufhgi5F/65J3a+wXv4P4ia3aweUJttQ47NMHLtkdVCu5QIdPScCQ
 AgrcbtYRtAGsTIwDsVDbNc48L68eXsmD0DuRChBKy41WRLkQJAXWpL7kKWTmDH7RLsrkOI
 +GezRD5wehbx4qFYksh8X+Yl1JBYwqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Liu6bGFFOsiNlnbJmWj5ZA-1; Mon, 17 Nov 2025 04:02:15 -0500
X-MC-Unique: Liu6bGFFOsiNlnbJmWj5ZA-1
X-Mimecast-MFC-AGG-ID: Liu6bGFFOsiNlnbJmWj5ZA_1763370134
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429cce847c4so1673142f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763370134; x=1763974934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ImmC/R2NvEgoAvQam4eXs3eLYCfSP7RSMkYexY9azzY=;
 b=QhNBNEZo9dTo9nie/4FPvn3GnNbLg4SPt+inZuDuZFMeJrG7dKvHm1EERwdzmB0DCD
 fMvhzqmqo+Je78165mC08XbgbRFTE9MyRH5wmlzJ4AANQzw9Iwv3ZlI6JhVAduESEwrS
 cdF2eBocaTlMyPwfBm4zpLZx25IvPzvzbE+afHxMLIMI/dQlStASMr32oiBEyg/5EKgM
 MBwCtvQXdmFVJB4YIqflkJyEJ/piGyNp0F0wFDZvxZirLTYzpopTl+VbLJ3pSX40YODc
 m6t2D258XQa7Cq0SkiZS5FVUNis658v9msUeuWf0w5fGu899rOYe8+K8+68RbPOjGwb3
 Vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763370134; x=1763974934;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImmC/R2NvEgoAvQam4eXs3eLYCfSP7RSMkYexY9azzY=;
 b=pNYNnoOyzL+MCdy781m0pvX4UGfUWTlpU1CdUNjfd+LpcgizUx5IvntgWUI4pxksi9
 1wul9RcGLIDFrrESBr1g/2eJ6UJ4ppZBcjYN4nnHMyIPREjr3BIXP6Fq7VXAdkDfl9+j
 /K7plhJWlJosPmJKjQdTYDToor7jlOzln8YLbKFzKaPQFc1ZbmYwrPuzKuUiT5o0rAx1
 v31EFbZX+eRc4nPlKE9kwwWdbKbO1Nib360tBXhbcwXC1Rop1uwZiCNh5Cd9oiTVuLju
 /U3Ec/nRWCCGtaztIvmcCvt4CikjfrTGQ5SYtLqJAIwHqZj46bomLt13fI4abjuHhBQd
 MbFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV43fESQNLb0UGlM5VI+bH7I8M9CbbwE1njlY1NuorTPExYUqRA4Hv/fOE7d3iaxQkyIevFzQhwl7LD@nongnu.org
X-Gm-Message-State: AOJu0Yxwx9nA9pmr8DC0KBu6tzFoTNtJY9agRGIpMx/BM0pLxAW36RI9
 yvvqCoWc/61piiUtN9YjdhEREJGOYkMuPIODjuV6BS8otVISURiMm3FtzgeBHhFdVahMycZTtmH
 RMbl69SQLi9uLxwcSgTq2fb6LWS3pP7FjBK7EWk8j93ofYAIEMCC7mjSQ
X-Gm-Gg: ASbGncsUskh6J1OGJjTk2RisssXQN9B26QA9sSP/42b2ES8Dyr82fQMXpo6Lqx0P4pL
 wQhFZpcK0DomYwNzTgNNKpA59KkuMq1Vm2O7tgbx1sqcJropiUm6wXvs5o8j24kUWZChrbjdKIR
 lSzYX6N54p6e8nUKCUt/vLqiqK9A6oqPJbpM8bGY88Wp5i5RNiwaDOYeLaiz7xpVXAIoYArc7dJ
 skJISc6i0pXK4BU/iYKDAGeBrOfFBoSjFv8jSWjabVQtJozMgOn5D+PXjVUJSLnjswk0sMC/dXD
 Y9rElsMH9Qgh6l/dMZzBY2AZuBxQ1aNqjI2z9DM74N72lQi/86YIZl8T2qL8bid4yPK19sbMhJt
 kLZNxJztcP8jD5x2wySdtpRllgwCePAaP2KFkdA==
X-Received: by 2002:a05:6000:3112:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42b59339603mr11398288f8f.26.1763370133973; 
 Mon, 17 Nov 2025 01:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnXPAYiImQmOL/DPBdh9EdAnFbK6/TPoPSDcbf0rOsQ3bezs8MD6FfhdgLZ7sXahNpPCH5Mg==
X-Received: by 2002:a05:6000:3112:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42b59339603mr11398250f8f.26.1763370133510; 
 Mon, 17 Nov 2025 01:02:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b622sm24556664f8f.29.2025.11.17.01.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:02:13 -0800 (PST)
Message-ID: <4e05ba1a-9794-4df0-8778-d81b735ae317@redhat.com>
Date: Mon, 17 Nov 2025 10:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] linux-headers: Update vfio.h to include
 VFIO_DEVICE_FEATURE_DMA_BUF
To: Leon Romanovsky <leon@kernel.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-7-vivek.kasireddy@intel.com>
 <e546604c-d4fe-49f7-af50-faff53cde07b@app.fastmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e546604c-d4fe-49f7-af50-faff53cde07b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Leon,

On 11/9/25 07:49, Leon Romanovsky wrote:
> 
> 
> On Sun, Nov 9, 2025, at 07:33, Vivek Kasireddy wrote:
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> ---
>>   linux-headers/linux/vfio.h | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>> index 4d96d1fc12..bc11ca3663 100644
>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -1478,6 +1478,31 @@ struct vfio_device_feature_bus_master {
>>   };
>>   #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>>
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
>> + * regions selected.
>> + *
>> + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
>> + * etc. offset/length specify a slice of the region to create the dmabuf from.
>> + * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
>> + *
>> + * Return: The fd number on success, -1 and errno is set on failure.
>> + */
>> +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
>> +
>> +struct vfio_region_dma_range {
>> +	__u64 offset;
>> +	__u64 length;
>> +};
>> +
>> +struct vfio_device_feature_dma_buf {
>> +	__u32	region_index;
>> +	__u32	open_flags;
>> +	__u32   flags;
>> +	__u32   nr_ranges;
>> +	struct vfio_region_dma_range dma_ranges[];
> 
> Not important comment at all, but in last versions of UAPI, this line is
> struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> https://lore.kernel.org/kvm/20251106-dmabuf-vfio-v7-10-2503bf390699@nvidia.com/T/#Z2e.:..:20251106-dmabuf-vfio-v7-10-2503bf390699::40nvidia.com:1include:uapi:linux:vfio.h

The kernel dma-buf definitions will be included in the QEMU linux-headers/
directory with the update-linux-headers.sh script.

First, v8 of "vfio/pci: Allow MMIO regions to be exported" series [1] needs
be merged and I expect this will happen in the Linux v6.19 cycle. The QEMU
changes are then targeting QEMU 11.0 whose cycle will start next year now.

We still have some time to polish.

Thanks,

C.

[1] https://lore.kernel.org//qemu-devel/20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com


