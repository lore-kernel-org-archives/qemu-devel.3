Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB38CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 09:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoIYn-0000ou-Fd; Tue, 19 Aug 2025 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uoIYl-0000oY-RA
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 05:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uoIYj-0006TM-3Z
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 05:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755595387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xBcXX6og9tYcPyrAzUBTB+eoBsY0fFhXf8lmvu8EFfw=;
 b=dHMbrfeXUQwAhXzwpUpzfIi4s1GWpvqZQqWMvMR8tP16FM4BS99lwqmlKj1xCADqX0BvVj
 9H3RmlEkVrnyfEqCU1hmwoKEAlG692brh/QPn9SB47A+b/Va4OeJkWnxNzHHEh7NpWMOHk
 FMh5Tr4xTjtxU8BJslAv2WEVSDSNuZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-ICZlxFIfM2az8C-RUpHV_Q-1; Tue, 19 Aug 2025 05:23:03 -0400
X-MC-Unique: ICZlxFIfM2az8C-RUpHV_Q-1
X-Mimecast-MFC-AGG-ID: ICZlxFIfM2az8C-RUpHV_Q_1755595381
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0cc989so29545855e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755595381; x=1756200181;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBcXX6og9tYcPyrAzUBTB+eoBsY0fFhXf8lmvu8EFfw=;
 b=ZNKiGqnhEGp4YON8pAnwYmnJPoCaFYdkIXlRE+x7veFc4gv6HDTbuiHOZdAEBx/knt
 XjDqu+SWWTzDV1TgnA7SNuEIKSzhQ+/8n/AE+5YoNL9350YKH13qa+iO8xx7y+Tjkq4d
 R4dhkGUQMEV4lKpjsUeXtikJEGernI+otw/gWF1JXWaort0rxJHqn1+J0+PRtKW6goZ1
 guAe/C7dWoi0m5V0MkPuJSlYGaxBwRGaiMiyTuiPJWcFyg06/z/F/GxEt3HzR82z5wYa
 jsMfhrljlS+/Lx5t3TlB5BknBY3XOaAqasL17p3fHiSMkfDzVXdzlZBhyKrmVOjkIE+e
 3lJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp5yf70/2n10yKXTq38f2lTi7HUJpOULbUb4uiCVzU4FWhgvWn6IcMPfL4W8sjLfuwhOduyYLTbr2m@nongnu.org
X-Gm-Message-State: AOJu0YyPEMdjcfWYfTbpQZA71H/MHLbQTHg/qn626R1M29K2/ofxukqF
 AOsLBnw6oQhMrUs/Xmf57fgb8puuYySzLBOnQ4PNbeWrcu1PlgUTI4yIJBQjyJ+lBm1zcMs6WJt
 Ge0zh+kYYfq91F+EJQjxdTfiDmL+vcXo7j5wvUunhGK9szJyfa65Y+Yci
X-Gm-Gg: ASbGncvoMBhbhRJU6rljYA99Ldj9ArzT37EwKDXhhUTCTKMHybLQWG0ItrHIDJcYQEn
 BocyTIhWVo12XC86s4BC+9jPEiMuZ8BXdi8XJU/YZjI3PuTfTm9y+k9KkYafszBOj7+fq7MT05e
 X5h4WmhPuY2gqioX8coCu8us9GOqJYfZ0P4KtFI5wjyceho1ZVJWLRooQw3ED/C9Jd6JsNrSW6E
 XB9PVg8acr1LQBQ/GJ5CMUSuEHuaw//NX6a/nPoAlD+lgpsSL6SkHXUxDNLm70ALZh5In5PyIAR
 pJozsPoCiW+84pCQsefIdmbln7XPO0DaR0F39oPb6a+yLUOzpruil3IHxUx4lt6TBPHQgZpcl7B
 iBDf10qWyUsLdl3JnelzU4NjQV95GVnipP4b3fSDXE1fLRvDQMb/Ykkzs6EwIskhKCAk=
X-Received: by 2002:a5d:5f50:0:b0:3b8:d138:41d3 with SMTP id
 ffacd0b85a97d-3c0ec7566b9mr1344386f8f.56.1755595380839; 
 Tue, 19 Aug 2025 02:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEdEMSRo6MLpqy/PDBVt9NPFyP/aLZs5Nq8qRrF7RPRKAQDrGs915Tr/0Tb3KyRZGS0t/IHA==
X-Received: by 2002:a5d:5f50:0:b0:3b8:d138:41d3 with SMTP id
 ffacd0b85a97d-3c0ec7566b9mr1344354f8f.56.1755595380408; 
 Tue, 19 Aug 2025 02:23:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98?
 (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de.
 [2003:d8:2f07:8700:71be:5385:87b8:5a98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d43ba5sm2994305f8f.22.2025.08.19.02.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 02:22:59 -0700 (PDT)
Message-ID: <dab1805a-aea6-42a5-bdbf-a58a0b87d868@redhat.com>
Date: Tue, 19 Aug 2025 11:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] vhost-user: Add VirtIO Shared Memory map request
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, stefanha@redhat.com, stevensd@chromium.org,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, slp@redhat.com
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-2-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818100353.1560655-2-aesteve@redhat.com>
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

On 18.08.25 12:03, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user for
> dynamic management of VIRTIO Shared Memory mappings.
> 
> This implementation introduces VhostUserShmemObject
> as an intermediate QOM parent for MemoryRegions
> created for SHMEM_MAP requests. This object
> provides reference-counted lifecycle management
> with automatic cleanup.
> 
> This request allows backends to dynamically map
> file descriptors into a VIRTIO Shared Memory
> Regions identified by their shmid. Maps are created
> using memory_region_init_ram_device_ptr() with
> configurable read/write permissions, and the resulting
> MemoryRegions are added as subregions to the shmem
> container region. The mapped memory is then advertised
> to the guest VIRTIO drivers as a base address plus
> offset for reading and writting according
> to the requested mmap flags.
> 
> The backend can unmap memory ranges within a given
> VIRTIO Shared Memory Region to free resources.
> Upon receiving this message, the frontend removes
> the MemoryRegion as a subregion and automatically
> unreferences the associated VhostUserShmemObject,
> triggering cleanup if no other references exist.
> 
> Error handling has been improved to ensure consistent
> behavior across handlers that manage their own
> vhost_user_send_resp() calls. Since these handlers
> clear the VHOST_USER_NEED_REPLY_MASK flag, explicit
> error checking ensures proper connection closure on
> failures, maintaining the expected error flow.
> 
> Note the memory region commit for these
> operations needs to be delayed until after we
> respond to the backend to avoid deadlocks.

Just a general comment: feel free to use up to 72 chars per line. 
Currently you're just a bit over 50.

-- 
Cheers

David / dhildenb


