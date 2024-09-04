Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7FBCD4F30
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxEO-00029L-68; Wed, 04 Sep 2024 17:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxEM-000285-6t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxEK-0003jq-B0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725484073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XVjyvsIgXoNBGvJuwNmKDa84LNL7bOZfTfkE+2mTT/c=;
 b=GAIFovL99dIzsd8dfEVXmiruw6jYxPybEnAsGCdr79doWNCryUXsJ4sNzKuWuOS9lOD/3p
 8LtRM43jideU/kP1nA6HahADd0769mm4ZUJsfTkx690h+tnaVbsyqM8MUb/hEqn2+sA80p
 gYeoSZK3IFSzOQgDZZWInspOHjmAyTg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-4hZsG_6QNgCq3ETDAdX7sA-1; Wed, 04 Sep 2024 17:07:48 -0400
X-MC-Unique: 4hZsG_6QNgCq3ETDAdX7sA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42bbe70c1c2so48740615e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725484066; x=1726088866;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XVjyvsIgXoNBGvJuwNmKDa84LNL7bOZfTfkE+2mTT/c=;
 b=qHOF1aLm+eo1GoWGxn/VFwgFG3v1NBzxoUHqaMfD6M+9k0q3wJTzZqb3oIVxTRA7Y2
 tQupqsS/Cgd29md8knVQ3aWKJ/6OKMGVyy8zYcr/5LZ9OggeHxc3yB91azPIqjPIpoA8
 0EEWjHdY93vc+KyP2y4qIh3tv2mxwR52bG+o+UR1E7JLa87zbcLV6aKupUykWUeQr2F3
 IH62vm2VnL6phx9m6t0NZA7gSm1dPswENWoGFUpESQUisqqyeUQ6dLxtyGHf2MoAYBrM
 Eg6OvmenNc/jiMvUtRY8AlWoBn+K3EsQVrK4RwI61X6dJjYpP604N7a3jpxj064VnUZk
 FUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8mGiaLQK5LBBCN/tf2/MiMNOJsicAvuZW0NognOdgx8Zj8FfVcJupTEiBf8nyyagCAzZAMe5h0dJ@nongnu.org
X-Gm-Message-State: AOJu0Yy84RwJ/xjzA9cZx4eiNioTe1BOVkYWJit5r6FlmJK/24ng+z0f
 O1L3K/XHTA/v3el17L3tvG73aulVNBrlhVFbpW1d+C0/fnC9pyGxNDskInF9Ma1iG8niOzcBbI1
 g7Uk6IG0yuhP6Wx/zynZGADj4VGH+UtXL6cMAyBUMlUW8hp3JInduxa1r6ZFVoW4=
X-Received: by 2002:a05:600c:3596:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42bb0306805mr165940445e9.17.1725484066544; 
 Wed, 04 Sep 2024 14:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEamw/+gOtcFFeRctUAv5nU8lpYq1PRLq5tmtdunyRdZhSE3VVcnSsgQz3Y1Qt92xL7q8jgqA==
X-Received: by 2002:a05:600c:3596:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42bb0306805mr165940225e9.17.1725484065928; 
 Wed, 04 Sep 2024 14:07:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992?
 (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de.
 [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb3efsm215701395e9.6.2024.09.04.14.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 14:07:45 -0700 (PDT)
Message-ID: <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com>
Date: Wed, 4 Sep 2024 23:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240904191635.3045606-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.09.24 21:16, Peter Xu wrote:
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
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Tested-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---



>   {
>       int i;
>   
> -    kml->slots = g_new0(KVMSlot, s->nr_slots_max);
>       kml->as_id = as_id;
>   
> -    for (i = 0; i < s->nr_slots_max; i++) {
> -        kml->slots[i].slot = i;
> -    }
> +    kvm_slots_grow(kml, KVM_MEMSLOTS_NUM_ALLOC_DEFAULT);

I would just keep the static initialization here, and add the additional

	kml->nr_slots_allocated = KVM_MEMSLOTS_NUM_ALLOC_DEFAULT;

here.

Then, you can remove the parameter from kvm_slots_grow() completely and just call it
kvm_slots_double() and simplify a bit:

static bool kvm_slots_double(KVMMemoryListener *kml)
{
     unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
     KVMSlot *slots;

     nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
     if (nr_slots_new == kvm_state->nr_slots_max) {
         /* We reached the maximum */
	return false;
     }

     assert(kml->slots);
     slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
     /*
      * g_renew() doesn't initialize extended buffers, however kvm
      * memslots require fields to be zero-initialized. E.g. pointers,
      * memory_size field, etc.
      */
     memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));

     for (i = cur; i < nr_slots_new; i++) {
         slots[i].slot = i;
     }

     kml->slots = slots;
     kml->nr_slots_allocated = nr_slots_new;
     trace_kvm_slots_grow(cur, nr_slots_new);

     return true;
}


Apart from that looks sane. On the slot freeing/allocation path, there is certainly
more optimization potential :)

I'm surprised this 32k loop wasn't found earlier.

-- 
Cheers,

David / dhildenb


