Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE81C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to7Hu-0003FA-Da; Fri, 28 Feb 2025 15:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1to7Hr-0003Ci-L0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:48:47 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1to7Hp-0005XV-Dd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:48:47 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1to7Hj-00000000ALp-3trj; Fri, 28 Feb 2025 21:48:39 +0100
Message-ID: <4e198591-5d76-41b9-9eb5-1264bf66164d@maciej.szmigiero.name>
Date: Fri, 28 Feb 2025 21:48:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
 <11ecf7fb-55f6-4606-b635-e53dbcc71dbc@redhat.com>
 <cb56e530-9d34-4f17-bee6-0cf28af06215@maciej.szmigiero.name>
 <800e20f0-8568-40f0-ba40-0026f14f5467@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <800e20f0-8568-40f0-ba40-0026f14f5467@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.02.2025 09:53, Cédric Le Goater wrote:
> On 2/27/25 23:01, Maciej S. Szmigiero wrote:
>> On 27.02.2025 07:48, Cédric Le Goater wrote:
>>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Allow capping the maximum count of in-flight VFIO device state buffers
>>>> queued at the destination, otherwise a malicious QEMU source could
>>>> theoretically cause the target QEMU to allocate unlimited amounts of memory
>>>> for buffers-in-flight.
>>>>
>>>> Since this is not expected to be a realistic threat in most of VFIO live
>>>> migration use cases and the right value depends on the particular setup
>>>> disable the limit by default by setting it to UINT64_MAX.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration-multifd.c   | 14 ++++++++++++++
>>>>   hw/vfio/pci.c                 |  2 ++
>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>   3 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>>> index 18a5ff964a37..04aa3f4a6596 100644
>>>> --- a/hw/vfio/migration-multifd.c
>>>> +++ b/hw/vfio/migration-multifd.c
>>>> @@ -53,6 +53,7 @@ typedef struct VFIOMultifd {
>>>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>>>       uint32_t load_buf_idx;
>>>>       uint32_t load_buf_idx_last;
>>>> +    uint32_t load_buf_queued_pending_buffers;
>>>>   } VFIOMultifd;
>>>>   static void vfio_state_buffer_clear(gpointer data)
>>>> @@ -121,6 +122,15 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>>>>       assert(packet->idx >= multifd->load_buf_idx);
>>>> +    multifd->load_buf_queued_pending_buffers++;
>>>> +    if (multifd->load_buf_queued_pending_buffers >
>>>> +        vbasedev->migration_max_queued_buffers) {
>>>> +        error_setg(errp,
>>>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>>>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>>>> +        return false;
>>>> +    }
>>>> +
>>>>       lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>>>>       lb->len = packet_total_size - sizeof(*packet);
>>>>       lb->is_present = true;
>>>> @@ -374,6 +384,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>>>>               goto ret_signal;
>>>>           }
>>>> +        assert(multifd->load_buf_queued_pending_buffers > 0);
>>>> +        multifd->load_buf_queued_pending_buffers--;
>>>> +
>>>>           if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>>>>               trace_vfio_load_state_device_buffer_end(vbasedev->name);
>>>>           }
>>>> @@ -408,6 +421,7 @@ VFIOMultifd *vfio_multifd_new(void)
>>>>       multifd->load_buf_idx = 0;
>>>>       multifd->load_buf_idx_last = UINT32_MAX;
>>>> +    multifd->load_buf_queued_pending_buffers = 0;
>>>>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>>>>       multifd->load_bufs_thread_running = false;
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 9111805ae06c..247418f0fce2 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3383,6 +3383,8 @@ static const Property vfio_pci_dev_properties[] = {
>>>>                   vbasedev.migration_multifd_transfer,
>>>>                   qdev_prop_on_off_auto_mutable, OnOffAuto,
>>>>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>>>> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
>>>> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>>>
>>> UINT64_MAX doesn't make sense to me. What would be a reasonable value ?
>>
>> It's the value that effectively disables this limit.
>>
>>> Have you monitored the max ? Should we collect some statistics on this
>>> value and raise a warning if a high water mark is reached ? I think
>>> this would more useful.
>>
>> It's an additional mechanism, which is not expected to be necessary
>> in most of real-world setups, hence it's disabled by default:
>>> Since this is not expected to be a realistic threat in most of VFIO live
>>> migration use cases and the right value depends on the particular setup
>>> disable the limit by default by setting it to UINT64_MAX.
>>
>> The minimum value that works with particular setup depends on number of
>> multifd channels, probably also the number of NIC queues, etc. so it's
>> not something we should propose hard default to - unless it's a very
>> high default like 100 buffers, but then why have it set by default?.
>>
>> IMHO setting it to UINT64_MAX clearly shows that it is disabled by
>> default since it obviously couldn't be set higher.
> 
> This doesn't convince me that we should take this patch in QEMU 10.0.
> Please keep for now. We will decide in v6.

Okay, let's decide at the v6 time then.

>>>>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>>>                        vbasedev.migration_events, false),
>>>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>
>>>
>>> Please add property documentation in vfio_pci_dev_class_init()
>>>
>>
>> I'm not sure what you mean by that, vfio_pci_dev_class_init() doesn't
>> contain any documentation or even references to either
>> x-migration-max-queued-buffers or x-migration-multifd-transfer:
> 
> Indeed :/ I am trying to fix documentation here :
> 
>    https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com/
> 
> Please do something similar. I will polish the edges when merging
> if necessary.

Ahh, I see now - that patch set of yours isn't merged upstream yet so
that's why I did not know what you had on mind.

> Overall, we should improve VFIO documentation, migration is one sub-feature
> among many.

Sure - I've now added object_class_property_set_description() description
for all 3 newly added parameters:
x-migration-multifd-transfer, x-migration-load-config-after-iter and
x-migration-max-queued-buffers.

> Thanks,
> 
> C.
> 

Thanks,
Maciej


