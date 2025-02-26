Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50B9C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnE6P-0008Rc-M4; Wed, 26 Feb 2025 04:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tnE6N-0008R6-Um
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tnE6J-0007Yi-KW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lks8VX6LqkJI3MtO7WwNmVr9eoNppgUnst+gRI02Obo=;
 b=hxTcs4jo+tCt/K90BDBgRq6J9zM2kxnwAgxwe8tSC74b1dOLjKdHtYCoyerJhuPAI679Yg
 bwKTg/cLqxJt7rlkIAOut82pkrVA3lOef8zWL+6eTUb0H5qOyuBx68HY2DOStJlKtUoBU4
 R50repKSh2GOnGxKiSTf4yVj6/2lVTk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-TWDsrKz_PKyg4uinWnn1hA-1; Wed, 26 Feb 2025 04:53:06 -0500
X-MC-Unique: TWDsrKz_PKyg4uinWnn1hA-1
X-Mimecast-MFC-AGG-ID: TWDsrKz_PKyg4uinWnn1hA_1740563585
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so33209425e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740563585; x=1741168385;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Lks8VX6LqkJI3MtO7WwNmVr9eoNppgUnst+gRI02Obo=;
 b=DtaSQRse7ctoX1CWcrJ8FSUhFqJxKZjTTOechEiVXJiENCCiWsNK1SP8YCWdVdZ1Tl
 UT2DeqjYocIkVryTdfGn/hY81PEY37RpJYLTNkgaDV7J0JKGqBIh9iM7EJztE2L5lWiY
 hk2+qwX1SnkWRqzH1NHxR6USs0hwaKDxjwtq8lvgwV2BbSFzPvclEUlaax0h5nGoePe0
 vRFVPcgTHlPFJ8sBg9fV+xORK8+sx9EdIlOo2EW6UkZ8NfFvLWIeRgTlAuGl4d6rJXfa
 9JkZ9ObUSylSr7fwG4zVbzEP7qk53RMsjovykxt6kulChxG+Lo8yD06ZsagEZeqZrtZA
 eIBA==
X-Gm-Message-State: AOJu0YwQ6/CGEM/jo3XIltiK01NSQZlaXpwaStNYw73kz6tumuV0S2KU
 SvLp/tXsSi7AYUBpzPo8D5P28cCSdIDhtI18Y+hfnvo/FOlZIFVRRgq/as/snGIOi01IdU+JwsE
 cyfUCTgAX1nmR8MJ6iHohii5F2/SdvAhwrheGvtWhzTYOg4bMGmT2XcmhE1bs
X-Gm-Gg: ASbGncvH4dT4uG41iCNbdqmBdXaKZP4gC/LZ9EW4M8fhoCYMTGCquCazRueHtX2abof
 JaIta0asdgBnBKdDEbv3/1OWTl9ioDGGAWDhhoMKmtHHQe0M3+lYNwfsTX4xPdwFVVENvqPvtRm
 BakLpaStvikM2/MrK7phU1qbx+oez2MeWwY7YzkrZ0nDtVFfWmpC7q3ekgvddowlw8qFUxbYudG
 JHrNRJoHYUq2zoTiU67gbTTQFwN71Fqr3BocVlclfUrDoxVp5l+CA6f1Pp/7g4MtIRwDjZGGvzr
 QSx51AibyPRJqygAsLabQps5AO1gTiZr7I2VVxplO/8cz55IfO1DkaC8yMc41hJGcKR5q1ngvyX
 kSN2aF8zEI7CH0L/M+l8lqC+z+9POB+I4Z4ah7+0G7Kg=
X-Received: by 2002:a05:600c:3104:b0:439:9377:fa22 with SMTP id
 5b1f17b1804b1-43aafab45camr76258105e9.18.1740563585353; 
 Wed, 26 Feb 2025 01:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN8divAzKJ12Pq1FovVGp7nkjy8udpdzIqpfQzoxxgX2NuWNojJVt3ySUEEz6o1SpuSGEntA==
X-Received: by 2002:a05:600c:3104:b0:439:9377:fa22 with SMTP id
 5b1f17b1804b1-43aafab45camr76257805e9.18.1740563584975; 
 Wed, 26 Feb 2025 01:53:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45?
 (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de.
 [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532bb1sm15237405e9.9.2025.02.26.01.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 01:53:03 -0800 (PST)
Message-ID: <ba4c6655-4f69-4001-84fa-2ebfe87c0868@redhat.com>
Date: Wed, 26 Feb 2025 10:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
 <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
 <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
 <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
 <b320f128-3604-40c8-961c-ceb431f82f6d@redhat.com>
 <CADSE00LvNbCR6cn-FuDCVF-vvXULrx7=5SyceMtdgxwpUa3NMw@mail.gmail.com>
 <933cf843-e845-45e0-8c48-a34541ad0afb@redhat.com>
 <CADSE00Lzxt7AuzLe24=T+C1TCOAmV1SkAMqAkSXwLBK+x4NHbA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADSE00Lzxt7AuzLe24=T+C1TCOAmV1SkAMqAkSXwLBK+x4NHbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

>> As commented offline, maybe one would want the option to enable the
>> alternative mode, where such updates (in the SHM region) are not sent to
>> vhost-user devices. In such a configuration, the MEM_READ / MEM_WRITE
>> would be unavoidable.
> 
> At first, I remember we discussed two options, having update messages
> sent to all devices (which was deemed as potentially racy), or using
> MEM_READ / MEM _WRITE messages. With this version of the patch there
> is no option to avoid the mem_table update messages, which brings me
> to my point in the previous message: it may make sense to continue
> with this patch without MEM_READ/WRITE support, and leave that and the
> option to make mem_table updates optional for a followup patch?

IMHO that would work for me.

> 
>>
>> What comes to mind are vhost-user devices with limited number of
>> supported memslots.
>>
>> No idea how relevant that really is, and how many SHM regions we will
>> see in practice.
> 
> In general, from what I see they usually require 1 or 2 regions,
> except for virtio-scmi which requires >256.

1/2 regions are not a problem. Once we're in the hundreds for a single
device, it will likely start being a problem, especially when you have more
such devices.

BUT, it would likely be a problem even with the alternative approach where
we don't communicate these regions to vhost-user: IIRC, vhost-net in
the kernel is usually limited to a maximum of 509 memslots as well as
default. Similarly, older KVM only supports a total of 509 memslots.

See https://virtio-mem.gitlab.io/user-guide/user-guide-qemu.html
"Compatibility with vhost-net and vhost-user".

In libvhost-user, and rust-vmm, we have a similar limit of ~509.


Note that for memory devices (DIMMs, virtio-mem), we'll use up to 256
memslots in case all devices support 509 memslots.
See MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT:

/*
  * Traditionally, KVM/vhost in many setups supported 509 memslots, whereby
  * 253 memslots were "reserved" for boot memory and other devices (such
  * as PCI BARs, which can get mapped dynamically) and 256 memslots were
  * dedicated for DIMMs. These magic numbers worked reliably in the past.
  *
  * Further, using many memslots can negatively affect performance, so setting
  * the soft-limit of memslots used by memory devices to the traditional
  * DIMM limit of 256 sounds reasonable.
  *
  * If we have less than 509 memslots, we will instruct memory devices that
  * support automatically deciding how many memslots to use to only use a single
  * one.
  *
  * Hotplugging vhost devices with at least 509 memslots is not expected to
  * cause problems, not even when devices automatically decided how many memslots
  * to use.
  */
#define MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT 256
#define MEMORY_DEVICES_SAFE_MAX_MEMSLOTS 509


That changes once you have some vhost-user devices consume combined with boot
memory more than 253 memslots.

-- 
Cheers,

David / dhildenb


