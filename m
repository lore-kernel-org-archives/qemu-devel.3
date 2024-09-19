Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8FFCE8D5D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 08:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srCJz-000382-Ih; Thu, 19 Sep 2024 04:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1srCJx-00035J-M1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 04:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1srCJu-0006AO-NW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 04:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726733721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bJmnKGH02vnYNdXa34A0J9iP5yRg1IU5LNSjdFFs/CA=;
 b=EJMNsmYO35wJWdvG+DFmKaBTkppu05B80FyJneTdqaa7xWeSvMBpb44PtFWhjCGR+uCx+r
 QMq7oiex2zivypVVORVvELPWlK/XZJVq4Oeq9yHlOVxizeNK81n/Eg0fc2b/Mk40bI2f6v
 lJ2befYr6VRyz0IQWEF3X7nK6n5faHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-8ghNktn1NlOsCNfZs6yY3Q-1; Thu, 19 Sep 2024 04:15:18 -0400
X-MC-Unique: 8ghNktn1NlOsCNfZs6yY3Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb115566eso4745355e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 01:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726733717; x=1727338517;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bJmnKGH02vnYNdXa34A0J9iP5yRg1IU5LNSjdFFs/CA=;
 b=xPnUuF6ud/8CBn/2hwvZvj1pr34BvMxdFmqRNtH84mRu4iBJjdyZwyqyc9gyraov97
 xfTIOKvU5O+6ZIqg8vs8BWvWv8VwYNgVdt0esBr/r/Ps3mw6au5yfL9bBt7eB9dHPv8M
 H6pBY/7IVo4G04NJNVoMKvxmNdxICAUtR886UR+WN9oxGLHMJ2KWVOtzbTU4XVjm7Jcc
 XHSAIfuN4GbYOqiGg1+Slswm5oWX7nabm3CsV5p1XikkUInIjbPj0MG8EuUrNVxn3tIS
 0WBEdSHer5IityY4vfeRY5BgtEKJTLuZtkqtbKw7xL+WUehDU1eu1E/g1Jr+FXyWoe4B
 +r+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0bBqvGtTjIqCOv2DIDL/EwIlmCfkTT6Vle4TLBbQQtyXU6mOYeB3M2xIq5y3hVFKXCmpKFP4Z3XsI@nongnu.org
X-Gm-Message-State: AOJu0Yz0p/IIc76ZaFFsZwBvD6Z54BBoYVJ0SPZ6+mSp0fJ7xBtElt2p
 mxqPP7vdqVyRIoMySKat90x4K3jIRf2dBDhL9vHf22KaciDgMvzVfh65DBTYfwADWTjQa4VKG8U
 0X5cVMNqeK7p6ycXh1yYfnBVDLQZvdvAe+Q4wXdzZ2wu9sIsxh5em
X-Received: by 2002:a05:600c:83c6:b0:42c:b220:4769 with SMTP id
 5b1f17b1804b1-42da2bd7679mr176659655e9.32.1726733717019; 
 Thu, 19 Sep 2024 01:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELZTzATS9eCj4TvVTw5NcipBJLousu8FBRwQPfLaXQqUG1sLeG0u06k/YIT0s37X24+ECm3Q==
X-Received: by 2002:a05:600c:83c6:b0:42c:b220:4769 with SMTP id
 5b1f17b1804b1-42da2bd7679mr176659325e9.32.1726733716615; 
 Thu, 19 Sep 2024 01:15:16 -0700 (PDT)
Received: from [10.131.4.59] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e6c718e40sm61104015e9.1.2024.09.19.01.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 01:15:16 -0700 (PDT)
Message-ID: <3ed4ea1f-8646-4a6b-aaee-8177a05f972f@redhat.com>
Date: Thu, 19 Sep 2024 10:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
References: <20240917163835.194664-1-peterx@redhat.com>
 <20240917163835.194664-2-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240917163835.194664-2-peterx@redhat.com>
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

On 17.09.24 18:38, Peter Xu wrote:
> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> was a separate discussion, however during that I found a regression of
> dirty sync slowness when profiling.
> 
> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> statically allocated to be the max supported by the kernel.  However after
> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> the max supported memslots reported now grows to some number large enough
> so that it may not be wise to always statically allocate with the max
> reported.
> 
> What's worse, QEMU kvm code still walks all the allocated memslots entries
> to do any form of lookups.  It can drastically slow down all memslot
> operations because each of such loop can run over 32K times on the new
> kernels.
> 
> Fix this issue by making the memslots to be allocated dynamically.
> 
> Here the initial size was set to 16 because it should cover the basic VM
> usages, so that the hope is the majority VM use case may not even need to
> grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> it'll consume 9 memslots), however not too large to waste memory.
> 
> There can also be even better way to address this, but so far this is the
> simplest and should be already better even than before we grow the max
> supported memslots.  For example, in the case of above issue when VFIO was
> attached on a 32GB system, there are only ~10 memslots used.  So it could
> be good enough as of now.
> 
> In the above VFIO context, measurement shows that the precopy dirty sync
> shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
> to any KVM enabled VM even without VFIO.
> 
> NOTE: we don't have a FIXES tag for this patch because there's no real
> commit that regressed this in QEMU. Such behavior existed for a long time,
> but only start to be a problem when the kernel reports very large
> nr_slots_max value.  However that's pretty common now (the kernel change
> was merged in 2021) so we attached cc:stable because we'll want this change
> to be backported to stable branches.
> 
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Tested-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


