Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7B7CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 16:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uze0G-0004FF-7U; Fri, 19 Sep 2025 12:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uze07-0004D4-N8
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uze00-00011J-Az
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758299407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P/p+nhN9unaN8EVhu60jtRypY5t6ptu7QDlxalhzRL8=;
 b=gy/HHSiqFvWahC+wzEkfZO4XSbaJuu1WXigAeaH+usG9tSbSZzXhf1xGNMmW0nrxT7Y4t0
 JuDiCKmV3uQPlgM1Om+FGVIB1bXuZB5oWNty2PUWrMFD4F6P1pezMf9iYZMQXxE9dsyA0O
 cUoZIFxzNHR0j2E6d38b5fgTuK+Fz2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-4f4Bpp21NP-b7fz2BYIu_Q-1; Fri, 19 Sep 2025 12:30:04 -0400
X-MC-Unique: 4f4Bpp21NP-b7fz2BYIu_Q-1
X-Mimecast-MFC-AGG-ID: 4f4Bpp21NP-b7fz2BYIu_Q_1758299403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f29eb22f8so12145395e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 09:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758299403; x=1758904203;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/p+nhN9unaN8EVhu60jtRypY5t6ptu7QDlxalhzRL8=;
 b=XjTqVXf+KlKzz7eySkFNHz/eUPkwXtt2lDzsfDPXyg0KwfJRTu647vnccQThZX3R7L
 YZlhND88mdIlAllKha7vSLLCsT6BtulijK/TrIb3jpjCDYA7iynEKRgkxLn9MZ3UabUS
 lKeJSnxlBq0Mo0aMRX94ZNsJaWTQ7FYyJHF+kVP3gzABiX65lo7/SLnJCeTm2+OJf5MP
 AW+bjnY1u7M8zBhMz2Oc9+9Prf6w2NovzzcYczF0t18L/1pq587EwqYb5dVpQYemd0/X
 z0RDCWmCCswfX/OUIz9vFca6X/pjrpgy1nKmnN2YJNhTV6PvtJobW+im8RKkB1Yy7x7c
 /tYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJe2k26PddDOv9C+YMRoHc8l3NrnAFVV18BMJEV59eLQAgOdxkBrUCq//+wGLHqwaJcS49pgXocP0n@nongnu.org
X-Gm-Message-State: AOJu0YwftxkU+wS9Pov9xWcJSs/vFB3jtzVe9SN7gipJOMvMQA7YNTU0
 0XT+DepVHOI9LKyUyhQLlWzjsmEyPxIFRScZ0sUiKzN3BCsst411Rp7a8nsgA5+t2onQHaQWxSf
 1z4TuoDeTaw9UaMytrwyv5SGfMbaOyb+coTY3sXM4pC9X8EmA1WY6h7Cs
X-Gm-Gg: ASbGncvf6QLm2qMcGvNYH8RDXxv69nWevPzCar01Xt+Ue0USFZO3Bfwb5Mr7Udnnon0
 Z6K2JxVFKVJ75H53nGPIBDl6bcsqs6pYA6j1iBTv+Rjsff5Nt5q+0+e9w3HWOQLEBNfimBrMbrt
 RFg9HMZ7xd7/YeII+QIoNoJelvKr9n56q8V2B29WfeMkkcE8ifIB9T/0+SpONm+fuFfxmE4kyCB
 h/FjZcPaA9Rivqpns8YhoHurTKCFGX59DNZF9zQaDg3cepLf9CLtWy04z9+3AJFvzdk2Kcwswyz
 H6c5RTgr7W3wjpqcRiS/yUXYjeopHSUBZ7wc/g9NnJcYWSatIhPYwnmHxDrn7tkDHZVvW4c4hrG
 hvnA=
X-Received: by 2002:a05:600c:3b26:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-467e7f7d558mr39864125e9.10.1758299403010; 
 Fri, 19 Sep 2025 09:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsfQHC7gl09hXUH/gvouvsS51eM1QrFLWnBdNVsBAveHhzXVIhUWFrci7ZViGQV/D01wM4SA==
X-Received: by 2002:a05:600c:3b26:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-467e7f7d558mr39863805e9.10.1758299402555; 
 Fri, 19 Sep 2025 09:30:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb5e2sm129921195e9.17.2025.09.19.09.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 09:30:02 -0700 (PDT)
Message-ID: <f38b14e7-919f-4f9a-b705-b181b39ec7e6@redhat.com>
Date: Fri, 19 Sep 2025 18:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 9/9] vfio: cpr-exec mode
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-10-git-send-email-steven.sistare@oracle.com>
 <92976018-2b44-4177-a26b-1f5c7a433d11@oracle.com>
 <2bbbca7f-f9a6-4be9-831e-0d0550a18b13@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2bbbca7f-f9a6-4be9-831e-0d0550a18b13@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/19/25 17:35, Steven Sistare wrote:
> This still needs review - steve

Steve,

please CC: us on the whole series next time. I will catch on the
emails next week. That said, I don't see any blocker.

Thanks,

C.



> 
> On 8/14/2025 1:20 PM, Steven Sistare wrote:
>> cc Cedric and Alex.
>>
>> This is the only patch of the series "Live update: cpr-exec" that touches vfio.
>>
>> - Steve
>>
>> On 8/14/2025 1:17 PM, Steve Sistare wrote:
>>> All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/container.c   |  3 ++-
>>>   hw/vfio/cpr-iommufd.c |  3 ++-
>>>   hw/vfio/cpr-legacy.c  |  9 +++++----
>>>   hw/vfio/cpr.c         | 13 +++++++------
>>>   4 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 3e13fea..735b769 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -993,7 +993,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>>           error_setg(&vbasedev->cpr.mdev_blocker,
>>>                      "CPR does not support vfio mdev %s", vbasedev->name);
>>>           if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>>> -                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
>>> +                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>>> +                                      -1) < 0) {
>>>               goto hiod_unref_exit;
>>>           }
>>>       }
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> index 148a06d..e1f1854 100644
>>> --- a/hw/vfio/cpr-iommufd.c
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>>>       if (!vfio_cpr_supported(be, cpr_blocker)) {
>>>           return migrate_add_blocker_modes(cpr_blocker, errp,
>>> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>> +                                         MIG_MODE_CPR_TRANSFER,
>>> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>>>       }
>>>       vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> index 553b203..7c73439 100644
>>> --- a/hw/vfio/cpr-legacy.c
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -176,16 +176,17 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>>       if (!vfio_cpr_supported(container, cpr_blocker)) {
>>>           return migrate_add_blocker_modes(cpr_blocker, errp,
>>> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>> +                                         MIG_MODE_CPR_TRANSFER,
>>> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>>>       }
>>>       vfio_cpr_add_kvm_notifier();
>>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>>> -    migration_add_notifier_mode(&container->cpr.transfer_notifier,
>>> -                                vfio_cpr_fail_notifier,
>>> -                                MIG_MODE_CPR_TRANSFER);
>>> +    migration_add_notifier_modes(&container->cpr.transfer_notifier,
>>> +                                 vfio_cpr_fail_notifier,
>>> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>>>       return true;
>>>   }
>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>> index a831243..a176971 100644
>>> --- a/hw/vfio/cpr.c
>>> +++ b/hw/vfio/cpr.c
>>> @@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
>>>   void vfio_cpr_add_kvm_notifier(void)
>>>   {
>>>       if (!kvm_close_notifier.notify) {
>>> -        migration_add_notifier_mode(&kvm_close_notifier,
>>> -                                    vfio_cpr_kvm_close_notifier,
>>> -                                    MIG_MODE_CPR_TRANSFER);
>>> +        migration_add_notifier_modes(&kvm_close_notifier,
>>> +                                     vfio_cpr_kvm_close_notifier,
>>> +                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>>> +                                     -1);
>>>       }
>>>   }
>>> @@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>>>   void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>>>   {
>>> -    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
>>> -                                vfio_cpr_pci_notifier,
>>> -                                MIG_MODE_CPR_TRANSFER);
>>> +    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
>>> +                                 vfio_cpr_pci_notifier,
>>> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>>>   }
>>>   void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
>>
> 


