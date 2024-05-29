Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382EDC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFse-0005X3-RK; Wed, 29 May 2024 05:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sCFsa-0005QT-F7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sCFsY-0000V5-C4
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716975952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i64/OExMSfzGgZPyUJaN7jtbSypT7uRiIAKENFJP1FE=;
 b=hoRBeNFzWTEIm06r2nltEo13txxNw8bsuU4PI6LbNg0w+45OnCR653OS9QacuHjvYLA3lP
 5VXpCV8Te40R6ezrwuKU3V+1AkKgkT4satFodaxh2KCUfq4WFbbLGX7kauhJ8cPanpbHDV
 HeX52ov5Dt2NaCSydfT9YiW1I38zW5E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-_aNUwsLWNJqhYfefLyC-3g-1; Wed, 29 May 2024 05:45:51 -0400
X-MC-Unique: _aNUwsLWNJqhYfefLyC-3g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43fb02d8204so20980701cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 02:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716975950; x=1717580750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i64/OExMSfzGgZPyUJaN7jtbSypT7uRiIAKENFJP1FE=;
 b=mDmq4lWkSHWNEsCqJJOJwrXSnZVpkJbzvFuQuGZxjMPdQKPDMFO0ZeIbvOKjBfAkzW
 WSLIkBKiU/mqG2zm0okioCGIKUUZqeSBKPJpFNRXjHkegtFtjM1SxECRNK/miCSSgiVM
 v/vRis003VVDblaNvjHG0f5LknDofuOpxTtqg054aTikjQAx9YZPdA07HwHwMY0vitmX
 me7eTLbaRq7zHh+8j63ohtdRR/MZ5Bh7aTAIqm9eB7Gu6ucZxWSZT6k0iWWRN8OfvKpo
 9NGEHwLiZG6g70UirEIv9YureKKsV7CAig+y9D5qnqsRoW1Vy3VAcPMssJ+H2hb7dreT
 5W8Q==
X-Gm-Message-State: AOJu0YyjfyrLoLGQXctEco+qdVKuM3Z3FEdd8qhPs9XQe6oxbBu0vYTs
 Jb3Zpn2veyfG2tBoHe5Mvpy8WQ9aJRQE50qdy4gseILpBQh5QfeZzbT0puERaoWq3D1mVb939xd
 Wu+Pfuls4TZbaC9OiJtDyWjQdDL5ZAJ0zYo95oFMesHSitTHtSPfu
X-Received: by 2002:a05:622a:14a:b0:43a:f2be:6ce with SMTP id
 d75a77b69052e-43fb0f014dcmr205862091cf.60.1716975950509; 
 Wed, 29 May 2024 02:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFljIEGjB3AQaY5Ov4hZqaZs230NUicC0C1NXXGxGCWa0HVgciIKqKWwepDHzrppfC7OoRr4w==
X-Received: by 2002:a05:622a:14a:b0:43a:f2be:6ce with SMTP id
 d75a77b69052e-43fb0f014dcmr205861881cf.60.1716975949998; 
 Wed, 29 May 2024 02:45:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b0e3bsm51771921cf.68.2024.05.29.02.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 02:45:49 -0700 (PDT)
Message-ID: <ba4b4b53-68fb-4d80-9f5d-4e4476447947@redhat.com>
Date: Wed, 29 May 2024 11:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240516124658.850504-1-clg@redhat.com>
 <20240516124658.850504-2-clg@redhat.com> <878qztp20c.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <878qztp20c.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On 5/29/24 08:26, Markus Armbruster wrote:
> I had a look at this before I realized it's already in.  I'm sending
> this out not to demand any change, but only to point out an issue to be
> avoided in future work.
> 
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> We will use the Error object to improve error reporting in the
>> .log_global*() handlers of VFIO. Add documentation while at it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>   hw/vfio/common.c                      |  4 ++--
>>   hw/vfio/container-base.c              |  4 ++--
>>   hw/vfio/container.c                   |  6 +++---
>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>                                          MemoryRegionSection *section);
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start);
>> +                                           bool start, Error **errp);
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                         VFIOBitmap *vbmap,
>>                                         hwaddr iova, hwaddr size);
>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>                            AddressSpace *as, Error **errp);
>>       void (*detach_device)(VFIODevice *vbasedev);
>> +
>>       /* migration feature */
>> +
>> +    /**
>> +     * @set_dirty_page_tracking
>> +     *
>> +     * Start or stop dirty pages tracking on VFIO container
>> +     *
>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>> +     *              page tracking
>> +     * @start: indicates whether to start or stop dirty pages tracking
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>> -                                   bool start);
>> +                                   bool start, Error **errp);
> 
> Note for later: this is always called via
> vfio_container_set_dirty_page_tracking().
> 
>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>                                 VFIOBitmap *vbmap,
>>                                 hwaddr iova, hwaddr size);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>>       }
>>   
>>       if (ret) {
>> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>>       }
>>   
>>       if (ret) {
> 
> Note for later: all callers pass NULL to ignore the new Error.
> 
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>   }
>>   
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start)
>> +                                           bool start, Error **errp)
>>   {
>>       if (!bcontainer->dirty_pages_supported) {
>>           return 0;
>>       }
>>   
>>       g_assert(bcontainer->ops->set_dirty_page_tracking);
>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>>   }
>>   
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>   
>>   static int
>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> -                                    bool start)
>> +                                    bool start, Error **errp)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>       if (ret) {
>>           ret = -errno;
>> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>> -                     dirty.flags, errno);
>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
>> +                         dirty.flags);
> 
> Silent improvement: errno is now reported symbolically (like "Operation
> not permitted") instead of numerically (like "1").  Worth mentioning in
> the commit message.

ok.

> Since the callers pass NULL to ignore the Error, this error condition is
> now silent, I believe.
> 
> I figure you correct this in later patches.  If we accept temporary loss
> of error reporting, the commit message should mention it.  Loss of error
> reporting is easy enough to avoid, though: have the callers pass a
> pointer to a local @err, and on failure report it with
> error_report_err().

Yes. The following patch is changing the NULL to an Error pointer. Indeed,
I could have merged both patches and resend. Seemed overkill at the time
and I preferred the changes to get more exposure too.

I did it the way you propose in some of the other patches. I think the
code of this series was reshuffled a few times and it fell through the
cracks. Let's add some laziness on top of that to be honest.

Thanks,

C.


