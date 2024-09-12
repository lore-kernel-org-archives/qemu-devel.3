Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BADEEB57D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sogKg-0004QY-VH; Thu, 12 Sep 2024 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sogKV-0004LS-PV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sogKT-0005Sl-38
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726134090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Zr8kufktr1o3Cl+fOU8CGDBtI5DWzJq8O/WDBxYKqM=;
 b=flPktSvxx54yz0ww6k3h6WvBrUwGqn7oo0tNoIxKHaIl3ZYiMMG6Mnen+YdIZGo3IS9Fv1
 3fM8jwB1MEZ3qPFZPRo8TsqkN/zYj9iTkRZ87/hUctKXF5W/dU3cLEh1pH3zorOaEEX1Ac
 j/zYNjEGrskdZVutPUsom6gECrsyvLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-dCiwYCqhOVK0MWxC9T8MHA-1; Thu, 12 Sep 2024 05:41:29 -0400
X-MC-Unique: dCiwYCqhOVK0MWxC9T8MHA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42caf073db8so5664865e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 02:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726134088; x=1726738888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Zr8kufktr1o3Cl+fOU8CGDBtI5DWzJq8O/WDBxYKqM=;
 b=wotpoKM9F9jf0R1kXz1p2jmGw93L/Oh1mX2xnH+aOP2OAiaN7zYsajimXyyyU7JKM2
 0LfBMrtEYm8ifzfz049GZ8F2Xp39r4z6RnF23RgdQsgLVsuexbnLnix/DiWeNEJTFwpm
 5WzTgcgVuDZQAm/+StFQulIL3MkOd21I8cET92AHhmQJfJhOLeW79yv+cR6u/jLYqib8
 O+pJQG8Yt+A2lGgP67qlVErCwOjYq0Qf8f3HCSwtvLONSlxWyHeMlydUA6en79AczSTd
 B2YM1l46OARj4H6nf+ql1+ZXHsnRWCJheVnRj/DtuvZ2zEvAlh9vxSx2XQjBTlJl5yZh
 6ZJA==
X-Gm-Message-State: AOJu0Yw8eo6OdL5gJDZvqSpOhRNx9XBj5IQEAD+lHrataDQzquVRRdcW
 tehFgOqdKjXLifSLA0spTL5BldLsk0t2NF5s7HbAqvtre9DaGY5N5SIH8m2y9iD7BJLotPA+420
 XEf3Aga+IKt7zfKQxXB5N0yp87k53faIX/FIEo/yAyCj3DOHlPKui
X-Received: by 2002:a05:600c:3b88:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-42cdb45d836mr18860665e9.0.1726134088142; 
 Thu, 12 Sep 2024 02:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaBRYP2j6pv6e1yaCpEYNJIPhXnwQzHOkh+mX4XiIqmmh8hKUIN9NBcgVptBl5lWIQ74t/YA==
X-Received: by 2002:a05:600c:3b88:b0:42c:b750:1a1e with SMTP id
 5b1f17b1804b1-42cdb45d836mr18860245e9.0.1726134087563; 
 Thu, 12 Sep 2024 02:41:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb81ac0sm169096755e9.34.2024.09.12.02.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 02:41:27 -0700 (PDT)
Message-ID: <600d8239-3066-4792-a414-0c36761b2beb@redhat.com>
Date: Thu, 12 Sep 2024 11:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
References: <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com> <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com> <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com> <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com> <Ztn5CcxhzYR-SFfE@x1n>
 <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com> <Zt8QKPZiw6BXgh-5@x1n>
 <bc31b6c4-89c8-4e04-b74d-e84422eb9901@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <bc31b6c4-89c8-4e04-b74d-e84422eb9901@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/12/24 10:09, Avihai Horon wrote:
> 
> On 09/09/2024 18:11, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, Sep 09, 2024 at 03:52:39PM +0300, Avihai Horon wrote:
>>> On 05/09/2024 21:31, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
>>>>>> Does it also mean then that the currently reported stop-size - precopy-size
>>>>>> will be very close to the constant non-iterable data size?
>>>>> It's not constant, while the VM is running it can change.
>>>> I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.
>>>>
>>>> I just gave it a quick shot with a busy VM migrating and estimate() is
>>>> invoked only every ~100ms.
>>>>
>>>> VFIO might be different, but I wonder whether we can fetch stop-size in
>>>> estimate() somehow, so it's still a pretty fast estimate() meanwhile we
>>>> avoid the rest of exact() calls (which are destined to be useless without
>>>> VFIO).
>>>>
>>>> IIUC so far the estimate()/exact() was because ram sync is heavy when
>>>> exact().  When idle it's 80+ms now for 32G VM with current master (which
>>>> has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
>>>> think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
>>>> that case maybe we can still try fetching stop-size only for both
>>>> estimate() and exact(), but only sync bitmap in exact().
>>> IIUC, the end goal is to prevent migration thread spinning uselessly in
>>> pre-copy in such scenarios, right?
>>> If eventually we do call get stop-copy-size in estimate(), we will move the
>>> spinning from "exact() -> estimate() -> exact() -> estimate() ..." to
>>> "estimate() -> estimate() -> ...".
>>> If so, what benefit would we get from this? We only move the useless work to
>>> other place.
>> We can avoid exact() calls invoked for other vmstate handlers, e.g. RAM,
>> which can be much heavier and can require BQL during the slow process,
>> which can further block more vcpu operations during migration.
>>
>> And as mentioned previously, VFIO is, AFAIK, the only handler that provide
>> different definitions of estimate() and exact(), which can be confusing,
>> and it's against the "estimate() is the fast-path" logic.
>>
>> But I agree it's not fundamentally changing much..
>>
>>> Shouldn't we directly go for the non precopy-able vs precopy-able report
>>> that you suggested?
>> Yep, I just thought the previous one would be much easier to achieve.
> 
> Yes, though I prefer not to add the get stop-copy-size ioctl in the estimate() flow because: a) it's guaranteed to be called (possibly many times) in every migration (either well configured which is the probable case or misconfigured which spins), and b) because how "heavy" get stop-copy-size is may differ from VFIO device to the other.
> 
> Maybe I am being a bit overcautious here, but let's explore other options first :)
> 
>> And
>> as you said, VFIO is still pretty special that the user will need manual
>> involvements anyway to specify e.g. very large downtimes, so this condition
>> shouldn't be a major case to happen.  Said that, if you have a solid idea
>> on this please feel free to go ahead directly with a complete solution.
> 
> I think it's possible to do it with what we currently have (VFIO uAPI-wise), I will try to think of one.
> 
> BTW, I checked again and I think we should drop this line from vfio_state_pending_exact():
>      *must_precopy += migration->precopy_init_size + migration->precopy_dirty_size;
> 
> I can send a patch for that.

Please do. We can then provide a scratch build for further testing
and experiments with vGPUs.

Thanks,

C.


