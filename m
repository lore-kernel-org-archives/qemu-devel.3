Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9BDC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNvJ-0006df-7B; Mon, 28 Jul 2025 09:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugN8B-0002PX-Hx
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugN86-0003kX-R7
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753706335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n4aYMb4iozdpAOG3u0CUWEZxYcuvCEKw9dIxK0doW9U=;
 b=UVbODusCYjJ6Ai6hiOpuc6SZEKfNe7JwfZLEAU6k6oacDAaJ0T00wlYinxOUO/YTLFCbA1
 Kgi4+vV52ZwKczkLAy2tkDjXNAE/IhFHx87MlQ/NDgEokeB89ocqC/id5FNMr26TmMrUpt
 SFk9Xcnk2WuZ2fbfoChgMxJERZRup+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-h7UQ2b1dMuqky_5gATgKGw-1; Mon, 28 Jul 2025 08:38:53 -0400
X-MC-Unique: h7UQ2b1dMuqky_5gATgKGw-1
X-Mimecast-MFC-AGG-ID: h7UQ2b1dMuqky_5gATgKGw_1753706333
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b7851a096fso917332f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 05:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753706333; x=1754311133;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4aYMb4iozdpAOG3u0CUWEZxYcuvCEKw9dIxK0doW9U=;
 b=emY63CIwoX/Y8Rg2Tnm8laUX/vczc8CGFxTCzJHWrRADRytgsf3+bdNC5o7oDUMANj
 Wz4uN//q8tBzrNFyEOdmaKM4Pz5Vf9yq0L/gx49pn1npydHaIc4YWBdawSjetGOST2qg
 EPgoWQOwwYgwdbPMKAMVUi/LQNljED9QqdE36IxvP30/Kmv4ffaaUTHkp7ME8Lj/uddm
 YrCWdjWYX7g7OOhysCQQEPy4mL2R9ubdoJCfntjt7SrBeCyZO5liDnte7Tsec3YP8g+j
 1xotQ68xZo0oMPUg8nvskJ1//MCvS9cvDAEH8uMZmvIDYzL4+GZOOkGuVmSYQHvGu4Xq
 GV2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvmtikXTL/OqeLm7LvhCk1n9CeIHz3VuW8yT1gN0Uy5hXaitc3vu+hgrEhVDM+kwkn14IiWHqVz3ig@nongnu.org
X-Gm-Message-State: AOJu0Yxp6C9Y9r1q52nAewY9E2lx66HFnrkCvKhLQ02qw2mpXcWaMyy5
 9KH8pF4z+Ag7KUMaHI9m+kRXAQnkn5YfSniMPFahuPda7yZCjTKtnMKkUnZCjcEjmK1EKuNTcz6
 63/g1JyvkcbVGLvQm0mtOuB+0Kv9qHNDCtZQMh/w2MdXgKpXKEathj2Ro
X-Gm-Gg: ASbGncvedNtBM9rnjsD+QRy7N4Ej/ApKD1er/RlwEFKlxXcXjZNFzYVdhmDZrxCZe1b
 a1xYfCrFiM1szLCalriU5Qsc0DNyv1zAfm8VD5QTc5ygQPS+zv4JMgb+TniaSw5BcjSf/S2t16Z
 DE3oKAY+myLavBoi+gcwlIRtbe3LU5lzXzB2yoOpRw0uN1tVlu4nZm8GGx9EZbovRVP0O8Sr7tK
 U4E5d+5Dd9OBoUjPg1exbXifExTCyR/ImW2fL3rMzpWFDDF7c7PxZ1oq1R72yiwOn36q8z40Fls
 RtEV6nqhoYxtcaQy9fRp8XLqlzz5O6cpiKXh3GSGe3Ca/IQIzkiNAakH5V+DQ4aUJtKXkIzDZY1
 jtw==
X-Received: by 2002:a05:6000:2406:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b77667aa69mr9134298f8f.53.1753706332584; 
 Mon, 28 Jul 2025 05:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH49i/qHaMwzYpkcHXwGn6SrpiKQEYrokRJPm6WJYTOz5w7qOXkcOB+EUbGC7JewphD0x+wwg==
X-Received: by 2002:a05:6000:2406:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b77667aa69mr9134261f8f.53.1753706332045; 
 Mon, 28 Jul 2025 05:38:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7819039efsm6942414f8f.11.2025.07.28.05.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 05:38:51 -0700 (PDT)
Message-ID: <eb8f4a1d-aec7-4747-90dd-c869a8dd3a40@redhat.com>
Date: Mon, 28 Jul 2025 14:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
 <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steve,

On 7/21/25 13:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>
>> On 7/16/2025 10:43 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>>>
>>>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>>>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>>>> dropped.  To fix, stop pending new interrupts during cpr save, and pick
>>>> up the pieces.  In more detail:
>>>>
>>>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi -->
>> KVM_IRQFD
>>>> to
>>>> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
>>>> After this call, interrupts fall back to the kernel vfio_msihandler, which
>>>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>>>> eventfd.  When the route is re-established in new QEMU, the kernel tests
>>>> the eventfd and injects an interrupt to KVM if necessary.
>>>
>>> With this patch, producer is detached from the kvm consumer, do we still
>> need to close kvm fd on source QEMU?
>>
>> Good observation!  I tested with this patch, without the kvm close patch,
>> and indeed it works.
> 
> Thanks for confirming.
> 
>>
>> However, I would like to keep the kvm close patch, because it has another
>> benefit:
>> it makes cpr-exec mode faster.  In that mode, old QEMU directly exec's new
>> QEMU,
>> and it is faster because the kernel exec code does not have to traverse and
>> examine
>> kvm page mappings.  That cost is linear with address space size.  I use
>> cpr-exec
>> mode at Oracle, and I plan to submit it for consideration in QEMU 10.2.
> 
> Sure, but I'd like to get clear on the reason.
> What kvm page do you mean, guest memory pages?
> When exec, old kvm_fd is closed with close_no_exec implicitly, I don't understand
> why faster if kvm_fd is closed explicitly.
> 
I would like to send a vfio PR before -rc1 (tomorrow). Could you please
respond to Zhenzhong's comments when you are back (today I think) ?

Thanks,

C.



