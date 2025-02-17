Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEC6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9PG-0001ar-6k; Mon, 17 Feb 2025 17:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9PE-0001aj-T8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:16:01 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9PB-00048i-CQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:16:00 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9P6-00000007PL6-1DSA; Mon, 17 Feb 2025 23:15:52 +0100
Message-ID: <eb6ddaa2-61c6-45c0-8bf0-6c0491d3b7fc@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 23:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/33] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
 <c1d138eb-687c-4158-931a-dfc6400622d7@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <c1d138eb-687c-4158-931a-dfc6400622d7@redhat.com>
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

On 17.02.2025 14:48, Cédric Le Goater wrote:
> On 2/14/25 21:58, Maciej S. Szmigiero wrote:
>> On 12.02.2025 14:47, Cédric Le Goater wrote:
>>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> The multifd received data needs to be reassembled since device state
>>>> packets sent via different multifd channels can arrive out-of-order.
>>>>
>>>> Therefore, each VFIO device state packet carries a header indicating its
>>>> position in the stream.
>>>> The raw device state data is saved into a VFIOStateBuffer for later
>>>> in-order loading into the device.
>>>>
>>>> The last such VFIO device state packet should have
>>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c           | 116 ++++++++++++++++++++++++++++++++++
>>>>   hw/vfio/pci.c                 |   2 +
>>>>   hw/vfio/trace-events          |   1 +
>>>>   include/hw/vfio/vfio-common.h |   1 +
>>>>   4 files changed, 120 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index bcdf204d5cf4..0c0caec1bd64 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -301,6 +301,12 @@ typedef struct VFIOStateBuffer {
>>>>   } VFIOStateBuffer;
>>>>   typedef struct VFIOMultifd {
>>>> +    VFIOStateBuffers load_bufs;
>>>> +    QemuCond load_bufs_buffer_ready_cond;
>>>> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>>> +    uint32_t load_buf_idx;
>>>> +    uint32_t load_buf_idx_last;
>>>> +    uint32_t load_buf_queued_pending_buffers;
>>>>   } VFIOMultifd;
>>>>   static void vfio_state_buffer_clear(gpointer data)
>>>> @@ -346,6 +352,103 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>>>   }
>>> Each routine executed from a migration thread should have a preliminary
>>> comment saying from which context it is called: migration or VFIO
>>
>> Do you mean like whether it is called from the code in qemu/migration/
>> directory or the code in hw/vfio/ directory?
> 
> Threads are spawned from different subsystems: migration callbacks
> (save), and from VFIO (load, well, not load phase, switchover phase).
> It would be good to provide hints to the reader.

There are just two new threads here:
vfio_save_complete_precopy_thread and vfio_load_bufs_thread,
both have name ending in "_thread" to denote a thread entry point
function.

So you want to have a comment that vfio_save_complete_precopy_thread
is launched directly by migration core via SaveVMHandler while
vfio_load_bufs_thread is launched by vfio_switchover_start()
SaveVMHandler, correct?

> I am struggling to understand how this works. Imagine a new comer
> looking at the code and at the git history in 2y time ... Check
> vfio in QEMU 1.3 (one small file) and see what it has become today.
> 
>> What about internal linkage ("static") functions?
> 
> There shouldn't be any static left when all multifd code is moved
> to its own hw/vfio/migration-multifd.c file.

There are 15 static functions in the new hw/vfio/migration-multifd.c:
https://gitlab.com/maciejsszmigiero/qemu/-/blob/622de616178467f2ca968c6f0bd1e67f6249677f/hw/vfio/migration-multifd.c

But if these launching thread comments are to be added to
vfio_save_complete_precopy_thread and vfio_load_bufs_thread then
that's not a problem.

>> Do they need such comment too?  That would actually decrease the readability> of these one-or-two line helpers due to high comment-to-code ratio.
> 
> I meant the higher level routines.
> 
> Tbh, this lacks tons of documentation, under docs, under each file,
> for the properties, etc. This should be addressed before resend.

This series adds a grand total of 3 properties:
x-migration-multifd-transfer, x-migration-load-config-after-iter and
x-migration-max-queued-buffers.

The fist two of these three are already described in the updated
docs/devel/migration/vfio.rst:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/622de616178467f2ca968c6f0bd1e67f6249677f

Adding the description of x-migration-max-queued-buffers can be done too.

Looking at the first 5 VFIOPCIDevice properties in QEMU source tree
(excluding "host" and "display" which are too generic to grep):
vf-token, x-pre-copy-dirty-page-tracking, x-device-dirty-page-tracking and xres
are not documented anywhere, sysfsdev is documented only for s390 and
has a short mention in vfio-iommufd.rst.

It's also rare for a function in hw/vfio/migration.c to have any
descriptive comment attached too: out of 41 functions currently in the
upstream QEMU git tree only two have a comment above describing what
they do: vfio_migration_set_state_or_reset() and vfio_migration_realize().

In addition to these, vfio_save_block() has a comment above that
describes the return value - don't know whether this qualifies as a
function description.

>> As far as I can see, pretty much no existing VFIO migration function
>> has such comment.> >>> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>>>> +                                          VFIODeviceStatePacket *packet,
>>>> +                                          size_t packet_total_size,
>>>> +                                          Error **errp)
>>>> +{
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    VFIOMultifd *multifd = migration->multifd;
>>>> +    VFIOStateBuffer *lb;
>>>> +
>>>> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
>>>> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
>>>> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
>>>> +    }
>>>> +
>>>> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
>>>> +    if (lb->is_present) {
>>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>>>> +                   packet->idx);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    assert(packet->idx >= multifd->load_buf_idx);
>>>> +
>>>> +    multifd->load_buf_queued_pending_buffers++;
>>>> +    if (multifd->load_buf_queued_pending_buffers >
>>>> +        vbasedev->migration_max_queued_buffers) {
>>>> +        error_setg(errp,
>>>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>>>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>>>> +        return false;
>>>> +    }
>>>
>>> AFAICT, attributes multifd->load_buf_queued_pending_buffers and
>>> vbasedev->migration_max_queued_buffers are not strictly necessary.
>>> They allow to count buffers and check an arbitrary limit, which
>>> is UINT64_MAX today. It makes me wonder how useful they are.
>>
>> You are right they aren't strictly necessary and in fact they weren't
>> there in early versions of this patch set.
>>
>> It was introduced upon Peter's request since otherwise the source> could theoretically cause the target QEMU to allocate unlimited
>> amounts of memory for buffers-in-flight:
>> https://lore.kernel.org/qemu-devel/9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name/
>> (scroll to the "Risk of OOM on unlimited VFIO buffering" section).
>>
>> If that's an actual risk in someone's use case then that person
>> could lower that limit from UINT64_MAX to, for example, 10 buffers.
>> >> Please introduce them in a separate patch at the end of the series,
>>> adding documentation on the "x-migration-max-queued-buffers" property
>>> and also general documentation on why and how to use it.
>>
>> I can certainly move it to the end of the series - done now.
> 
> Great. Please add the comment above in the commit log. We will decide
> it this is experimental or not.

The description above about the property use case was already
added to the comment log last week:
https://gitlab.com/maciejsszmigiero/qemu/-/commit/15fc96349940b6c2a113753d41e5369f786deb7d

I guess by "i[f] this is experimental or not" you mean whether
this property should be included or not (rather than literally
whether it should be marked with the experimental prefix "x-").

That queuing limit was introduced in v2 in August last year upon
Peter's justified comment to v1 as to give graceful possibility
to avoid target QEMU unbounded memory allocation and OOM.

If you have other ways to achieve that please let me know since
we shouldn't leave this for the very last moment.

The current implementation of this limit is really simple -
it's just a counter that gets incremented when new buffer gets
queued and decremented when a buffer gets consumed (written
into the device), with a max value check on increment.

> 
> Also, I wonder if this should be a global migration property.

It's VFIO migration code that does buffer queuing, not the main
migration code.

(..)
>>
>>>
>>> This sequence is expected to be called to release the vfio thread
>>>
>>>         while (multifd->load_bufs_thread_running) {
>>>              multifd->load_bufs_thread_want_exit = true;
>>>
>>>              qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>>>          ...
>>>         }
>>>
>>> right ?
>>
>> Right, that's a part of the code in vfio_load_cleanup_load_bufs_thread().
> 
> ok. So I think this lacks comments on thread termination points.
> Please try to comment a bit more these areas in the code. I will
> check next version more closely.

Will try to add more comments about thread termination then.

>>> The way the series is presented makes it a bit complex to follow the
>>> proposition, especially regarding the creation and termination of
>>> threads, something the reader should be aware of.
>>>
>>> As an initial step in clarifying the design, I would have preferred
>>> a series of patches introducing the various threads, migration threads
>>> and VFIO threads, without any workload. Once the creation and termination
>>> points are established I would then introduce the work load for each
>>> thread.
>>
>> When I am doing review of anything more complex (though it's not usually
>> in QEMU) I mainly follow the final code flow as an operation is handled
>> since looking just from top to down at individual commits rarely gives
>> enough context to see how every part interacts together.
>>
>> But for this the reviewer needs to see the whole code for the logical
>> operation, rather than just a part of it.
> 
> and this is the very problematic :/ Very very hard to maintain on the
> long run. I also don't have *time* to dig in all the context. So please
> try to keep it as simple as possible.

I definitely try to keep things simple where possible (but not simpler
to not end with a messy code).

For me, looking at the code flow for the whole operation also helps
avoid unnecessary comments/e-mail exchanges that add up to a lot of time.

It also totally makes sense to first ask the submitter about how the
operation code flows (where it is not obvious) or other implementation
details before suggesting changes there.

This helps avoid long discussions about changes which in the end turn out
to be a misunderstanding somewhere.

>> I think that adding the load operation in parts doesn't really
>> help since the reason why things are done such way in earlier patches
>> are only apparent in later patches and the earlier parts doesn't
>> really have much sense on their own.
>> Not to mention extra code churn when rebasing/reworking that increases
>> chance of a typo or a copy-paste mistake happening at some point.
>> > I also see that in comments to a later patch you dislike that
>> a dummy vfio_load_bufs_thread_load_config() gets added in one patch
>> then immediately replaced by the real implementation in the next patch.
>> Previously, you also said that vfio_load_config_after_iter() seems
>> to be unused in the patch that adds it - that's exactly the kind of
>> issues that bringing the complete operation in one patch avoids.
> 
> May be I did. Sorry I switched context may times already and this
> was lost in oblivion. Again, please help the reviewer. Changes
> should be made obvious.
>
>> I agree that, for example, x-migration-load-config-after-iter feature
>> could be a separate patch as it is a relatively simple change.
>>
>> Same goes for x-migration-max-queued-buffers checking/enforcement,
>> compat changes, exporting existing settings (variables) as properties
>> or adding a g_autoptr() cleanup function for an existing type.
>>
>> That's why originally the VFIO part of the series was divided into two
>> parts - receive and send, since these are two separate, yet internally
>> complete operations.
> 
> I am now asking to have a better understanding of how threads are
> created/terminated. It's another sub split of the load part AFAICT.
> If you prefer we can forget about the load thread first, like I
> asked initially iirc. I would very much prefer that for QEMU 10.0.

I think it makes sense to submit both the send and receive parts (or
save and load parts) rather than add code that effectively can't be
used in any meaningful way.

Especially than both send and receive parts need to have common
understanding of the migration bit stream.

As I suggested above, please don't hesitate to ask questions about
the parts that aren't clear.

I will try to explain these ASAP, since explaining things is much
easier than discussing changes (where I am wondering a lot what the
change is really wanting to achieve).

> 
>> I also export the whole series (including the current WiP state, with
>> code moved to migration-multifd.{c,h} files, etc.) as a git tree at
>> https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio
>> since this way it can be easily seen how the QEMU code currently
>> looks after the whole patch set or set of patches there.
> 
> Overall, I think this is making great progress. For such a complex
> work, I would imagine a couple of RFCs first and half dozen normal
> series. So ~10 iterations. We are only at v4. At least two more are
> expected.

As I wrote above, I am trying to integrate changes immediately
after they have been discussed enough for them to be clear to me.

On the other hand, having a lot of versions isn't great either
since with each rebase/rework/update there's a possibility of
accidentally introducing a copy-paste error or a typo somewhere.

Especially changes like moving code between files tend to cause
conflict with every later patch that touches this code or its
neighboring lines so they need quite a bit of (risky) manual
editing.

On the overall note, my plan is to try adding more comments
about threading and general operation flow and post a new
version, hopefully with most small changes discussed in other
recent messages also included.

> 
> Thanks,
> 
> C.

Thanks,
Maciej


