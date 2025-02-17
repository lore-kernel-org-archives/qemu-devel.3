Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D8EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1U0-0006qv-Cg; Mon, 17 Feb 2025 08:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk1Tx-0006qU-DA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:48:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk1Tu-00045D-Jb
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739800097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d/D5zvOLrS7llpvA/db2XPmWt/oys07grHEghrAJKE0=;
 b=aAxny90n9nK7ThGQfVlmjvIi3PESuht0FS3viuc0QB0utbgtk+WamdmL+GyEaulxWbrTow
 LfMGIv1FxrHmPX1KLnK8IFb8VDyu+eNnyhA4D5imnLdX5qZJ+G7pcAW6peo66YFRtc0d+A
 aVv8YLe8ZHtPHjz0LH9vmMU31JFoXdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-YM7mVuzwP5eLlcJoSAnIBg-1; Mon, 17 Feb 2025 08:48:14 -0500
X-MC-Unique: YM7mVuzwP5eLlcJoSAnIBg-1
X-Mimecast-MFC-AGG-ID: YM7mVuzwP5eLlcJoSAnIBg_1739800093
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so23614215e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739800093; x=1740404893;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/D5zvOLrS7llpvA/db2XPmWt/oys07grHEghrAJKE0=;
 b=EwAeuJZXFkyJao3HC276+9Zs2La4Xj4Wr8/rs65bd/iT236/ZKydNJg2WzOkoklcfW
 /gwnd+5i6m9dFFChD96xNbGrRvOSCaW3md9vksJEx5R1sK/AIisWt6xxrA9JWPIOu+oA
 tZqnYn+IcJ28fo769SQ3eHhjKiqrZKo6nOv5EaDgJVWpEb5BNoKpE1Gga4OstYaW0KBe
 9TOn72ZSRYp/TZxuLOX1nCPwKOe/KHk8XySN3PTGnt4/W4+NfSzeskGJPf05feRquTzE
 uvbD1FP6mUAtC4Y8zUcbVnBkgaA3leBpYbMbIJ+DROVE9KIx+IiUq09kARL68/GBiidE
 7S5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEtt+8Md4pAdUl0DXNNg/r2GhzKuLUhy4mXSGwZbOtBf3HWRTH+ijpR9avSDO+ZSiMvThrMXPVw4eL@nongnu.org
X-Gm-Message-State: AOJu0YyESGFFeHDtEjUm4l+t7SmhYsPceEthDXeelR+kB3LYCxDBiAVZ
 wv8wBVkhN50tdJvpCHHooz2gMq6b7cjE+tHwqkm54G4fBgiqsmWyqmWdsImv28bCDv3q8d8OhqI
 h06TmpO2YMMpXvh23umDQGyUrslDNVlte9rQsmr6ugel5JmsUV/LH
X-Gm-Gg: ASbGncux3+jDokM0vTQnoAzVimT3jd7PFB9BH5f8rO483yaZKwDHbY0eQaRCgmbYGvy
 3Et+sdPiXa4T79y+gRh4uzO41CPv9GQWzlpr3Xv0iV7LE1hf5ZIspm2BQGkc30In3guhLDyJarD
 aWakiy9MvElwEpWuSzWyFWVeJ1PCgY3OjOwzCa5Q3kJVuoKzQSrvD1NRScgnwP9iNZCJLzuq9JV
 HudQ8iXCpTYrUxRq3b5wB9ZqKt/vkWXL/T6TcqxWXiRgk++jEdjsbBKppqc2R6JPLPOK5iQBqOr
 Hv9SUZyDB6ejIL/sRl4/ic3uOQUmMWeOVlbGLz3C
X-Received: by 2002:a05:600c:4fc9:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-4396e7000bcmr93952855e9.18.1739800092863; 
 Mon, 17 Feb 2025 05:48:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMqMY+OrqhiIIsyqn3ERtaRiJAoMjmooZNezrOpi20gZ+0err8BO+OeAXKNgDUAduNvVep5g==
X-Received: by 2002:a05:600c:4fc9:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-4396e7000bcmr93952405e9.18.1739800092295; 
 Mon, 17 Feb 2025 05:48:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a44264csm15846705e9.25.2025.02.17.05.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:48:11 -0800 (PST)
Message-ID: <c1d138eb-687c-4158-931a-dfc6400622d7@redhat.com>
Date: Mon, 17 Feb 2025 14:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/33] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <74c4bbaaccd81e883504ae478e84394ddd96bbae.1738171076.git.maciej.szmigiero@oracle.com>
 <1b708674-e14d-46c2-8373-a0b12cf08b10@redhat.com>
 <50715039-1eb8-454b-9ab7-fb1490e27841@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <50715039-1eb8-454b-9ab7-fb1490e27841@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/14/25 21:58, Maciej S. Szmigiero wrote:
> On 12.02.2025 14:47, Cédric Le Goater wrote:
>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> The multifd received data needs to be reassembled since device state
>>> packets sent via different multifd channels can arrive out-of-order.
>>>
>>> Therefore, each VFIO device state packet carries a header indicating its
>>> position in the stream.
>>> The raw device state data is saved into a VFIOStateBuffer for later
>>> in-order loading into the device.
>>>
>>> The last such VFIO device state packet should have
>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 116 ++++++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.c                 |   2 +
>>>   hw/vfio/trace-events          |   1 +
>>>   include/hw/vfio/vfio-common.h |   1 +
>>>   4 files changed, 120 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index bcdf204d5cf4..0c0caec1bd64 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -301,6 +301,12 @@ typedef struct VFIOStateBuffer {
>>>   } VFIOStateBuffer;
>>>   typedef struct VFIOMultifd {
>>> +    VFIOStateBuffers load_bufs;
>>> +    QemuCond load_bufs_buffer_ready_cond;
>>> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>> +    uint32_t load_buf_idx;
>>> +    uint32_t load_buf_idx_last;
>>> +    uint32_t load_buf_queued_pending_buffers;
>>>   } VFIOMultifd;
>>>   static void vfio_state_buffer_clear(gpointer data)
>>> @@ -346,6 +352,103 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>>   }
>> Each routine executed from a migration thread should have a preliminary
>> comment saying from which context it is called: migration or VFIO
> 
> Do you mean like whether it is called from the code in qemu/migration/
> directory or the code in hw/vfio/ directory?

Threads are spawned from different subsystems: migration callbacks
(save), and from VFIO (load, well, not load phase, switchover phase).
It would be good to provide hints to the reader.

I am struggling to understand how this works. Imagine a new comer
looking at the code and at the git history in 2y time ... Check
vfio in QEMU 1.3 (one small file) and see what it has become today.

> What about internal linkage ("static") functions?

There shouldn't be any static left when all multifd code is moved
to its own hw/vfio/migration-multifd.c file.

> Do they need such comment too?  That would actually decrease the readability> of these one-or-two line helpers due to high comment-to-code ratio.

I meant the higher level routines.

Tbh, this lacks tons of documentation, under docs, under each file,
for the properties, etc. This should be addressed before resend.

> As far as I can see, pretty much no existing VFIO migration function
> has such comment.> >>> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>>> +                                          VFIODeviceStatePacket *packet,
>>> +                                          size_t packet_total_size,
>>> +                                          Error **errp)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    VFIOStateBuffer *lb;
>>> +
>>> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
>>> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
>>> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
>>> +    if (lb->is_present) {
>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>>> +                   packet->idx);
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(packet->idx >= multifd->load_buf_idx);
>>> +
>>> +    multifd->load_buf_queued_pending_buffers++;
>>> +    if (multifd->load_buf_queued_pending_buffers >
>>> +        vbasedev->migration_max_queued_buffers) {
>>> +        error_setg(errp,
>>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>>> +        return false;
>>> +    }
>>
>> AFAICT, attributes multifd->load_buf_queued_pending_buffers and
>> vbasedev->migration_max_queued_buffers are not strictly necessary.
>> They allow to count buffers and check an arbitrary limit, which
>> is UINT64_MAX today. It makes me wonder how useful they are.
> 
> You are right they aren't strictly necessary and in fact they weren't
> there in early versions of this patch set.
>
> It was introduced upon Peter's request since otherwise the source> could theoretically cause the target QEMU to allocate unlimited
> amounts of memory for buffers-in-flight:
> https://lore.kernel.org/qemu-devel/9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name/
> (scroll to the "Risk of OOM on unlimited VFIO buffering" section).
> 
> If that's an actual risk in someone's use case then that person
> could lower that limit from UINT64_MAX to, for example, 10 buffers.
> >> Please introduce them in a separate patch at the end of the series,
>> adding documentation on the "x-migration-max-queued-buffers" property
>> and also general documentation on why and how to use it.
> 
> I can certainly move it to the end of the series - done now.

Great. Please add the comment above in the commit log. We will decide
it this is experimental or not.

Also, I wonder if this should be a global migration property.
  
>>> +
>>> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>>> +    lb->len = packet_total_size - sizeof(*packet);
>>> +    lb->is_present = true;
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>> +                                   Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>>> +
>>> +    /*
>>> +     * Holding BQL here would violate the lock order and can cause
>>> +     * a deadlock once we attempt to lock load_bufs_mutex below.
>>> +     */
>>> +    assert(!bql_locked());
>>> +
>>> +    if (!migration->multifd_transfer) {
>>> +        error_setg(errp,
>>> +                   "got device state packet but not doing multifd transfer");
>>> +        return false;
>>> +    }
>>> +
>>> +    assert(multifd);
>>> +
>>> +    if (data_size < sizeof(*packet)) {
>>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>>> +                   data_size, sizeof(*packet));
>>> +        return false;
>>> +    }
>>> +
>>> +    if (packet->version != 0) {
>>
>> Please add a define for version, even if 0.
> 
> I've introduced a new define VFIO_DEVICE_STATE_PACKET_VER_CURRENT.
> 
>>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>>> +                   packet->version);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (packet->idx == UINT32_MAX) {
>>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>>> +                   packet->idx);
>>
>> I don't think printing out packet->idx is useful here.
> 
> Yeah, it's unlikely that the value of UINT32_MAX will ever change :)
> 
> Removed now.
> 
>>> +        return false;
>>> +    }
>>> +
>>> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
>>
>> I wonder if we can add thread ids to trace events. It would be useful.
> 
> load_state_buffer is called from multifd channel receive threads
> so passing multifd channel id there would require adding this multifd-specific
> parameter to qemu_loadvm_load_state_buffer() and load_state_buffer
> SaveVMHandler.

'-msg timestamp=on' should be enough. Having logical thread names would
be nice. It's another topic.

  
>>> +
>>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>>> +
>>> +    /* config state packet should be the last one in the stream */
>>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>>> +        multifd->load_buf_idx_last = packet->idx;
>>> +    }
>>> +
>>> +    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {
>>
>> So the migration thread calling multifd_device_state_recv() will
>> exit 
> 
> The thread is calling multifd_device_state_recv() is a multifd
> channel receive thread.
> 
>> and the vfio thread loading the state into the device will
>> hang until its aborted ?
> 
> In the normal (successful) migration flow the vfio_load_bufs_thread()
> will exit after loading (write()'ing) all buffers into the device
> and then loading its config state.
> 
> In the aborted/error/unsuccessful migration flow it will get
> terminated from vfio_load_cleanup() -> vfio_multifd_free() ->
> vfio_load_cleanup_load_bufs_thread().
> 
> vfio_load_cleanup_load_bufs_thread() will signal
> load_bufs_buffer_ready_cond and load_bufs_iter_done_cond since
> the load thread indeed could be waiting on them.
>
> 
>>
>> This sequence is expected to be called to release the vfio thread
>>
>>         while (multifd->load_bufs_thread_running) {
>>              multifd->load_bufs_thread_want_exit = true;
>>
>>              qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>>          ...
>>         }
>>
>> right ?
> 
> Right, that's a part of the code in vfio_load_cleanup_load_bufs_thread().

ok. So I think this lacks comments on thread termination points.
Please try to comment a bit more these areas in the code. I will
check next version more closely.

>> The way the series is presented makes it a bit complex to follow the
>> proposition, especially regarding the creation and termination of
>> threads, something the reader should be aware of.
>>
>> As an initial step in clarifying the design, I would have preferred
>> a series of patches introducing the various threads, migration threads
>> and VFIO threads, without any workload. Once the creation and termination
>> points are established I would then introduce the work load for each
>> thread.
> 
> When I am doing review of anything more complex (though it's not usually
> in QEMU) I mainly follow the final code flow as an operation is handled
> since looking just from top to down at individual commits rarely gives
> enough context to see how every part interacts together.
> 
> But for this the reviewer needs to see the whole code for the logical
> operation, rather than just a part of it.

and this is the very problematic :/ Very very hard to maintain on the
long run. I also don't have *time* to dig in all the context. So please
try to keep it as simple as possible.

> I think that adding the load operation in parts doesn't really
> help since the reason why things are done such way in earlier patches
> are only apparent in later patches and the earlier parts doesn't
> really have much sense on their own.
> Not to mention extra code churn when rebasing/reworking that increases
> chance of a typo or a copy-paste mistake happening at some point.
> > I also see that in comments to a later patch you dislike that
> a dummy vfio_load_bufs_thread_load_config() gets added in one patch
> then immediately replaced by the real implementation in the next patch.
> Previously, you also said that vfio_load_config_after_iter() seems
> to be unused in the patch that adds it - that's exactly the kind of
> issues that bringing the complete operation in one patch avoids.

May be I did. Sorry I switched context may times already and this
was lost in oblivion. Again, please help the reviewer. Changes
should be made obvious.

> I agree that, for example, x-migration-load-config-after-iter feature
> could be a separate patch as it is a relatively simple change.
> 
> Same goes for x-migration-max-queued-buffers checking/enforcement,
> compat changes, exporting existing settings (variables) as properties
> or adding a g_autoptr() cleanup function for an existing type.
> 
> That's why originally the VFIO part of the series was divided into two
> parts - receive and send, since these are two separate, yet internally
> complete operations.

I am now asking to have a better understanding of how threads are
created/terminated. It's another sub split of the load part AFAICT.
If you prefer we can forget about the load thread first, like I
asked initially iirc. I would very much prefer that for QEMU 10.0.


> I also export the whole series (including the current WiP state, with
> code moved to migration-multifd.{c,h} files, etc.) as a git tree at
> https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio
> since this way it can be easily seen how the QEMU code currently
> looks after the whole patch set or set of patches there.

Overall, I think this is making great progress. For such a complex
work, I would imagine a couple of RFCs first and half dozen normal
series. So ~10 iterations. We are only at v4. At least two more are
expected.


Thanks,

C.



