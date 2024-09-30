Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF0CDD1A9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svM2N-000587-Sl; Mon, 30 Sep 2024 15:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1svM2I-00057d-Cq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:26:24 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1svM2C-00009V-SD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:26:21 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1svM1y-000000007ik-14F8; Mon, 30 Sep 2024 19:26:02 +0000
Message-ID: <c013f26f-6e55-4426-9ec9-e160e8179a7a@maciej.szmigiero.name>
Date: Mon, 30 Sep 2024 21:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
 <Zt9UjvvbeUZQlGNY@x1n>
 <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
 <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
 <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
 <ZvYCGFnI_68B_w3h@x1n>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ZvYCGFnI_68B_w3h@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 27.09.2024 02:53, Peter Xu wrote:
> On Fri, Sep 27, 2024 at 12:34:31AM +0200, Maciej S. Szmigiero wrote:
>> On 20.09.2024 18:45, Peter Xu wrote:
>>> On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
>>>> On 19.09.2024 23:11, Peter Xu wrote:
>>>>> On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
>>>>>> On 9.09.2024 22:03, Peter Xu wrote:
>>>>>>> On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>
>>>>>>>> load_finish SaveVMHandler allows migration code to poll whether
>>>>>>>> a device-specific asynchronous device state loading operation had finished.
>>>>>>>>
>>>>>>>> In order to avoid calling this handler needlessly the device is supposed
>>>>>>>> to notify the migration code of its possible readiness via a call to
>>>>>>>> qemu_loadvm_load_finish_ready_broadcast() while holding
>>>>>>>> qemu_loadvm_load_finish_ready_lock.
>>>>>>>>
>>>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>>>> ---
>>>>>>>>      include/migration/register.h | 21 +++++++++++++++
>>>>>>>>      migration/migration.c        |  6 +++++
>>>>>>>>      migration/migration.h        |  3 +++
>>>>>>>>      migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
>>>>>>>>      migration/savevm.h           |  4 +++
>>>>>>>>      5 files changed, 86 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>>>>>>> index 4a578f140713..44d8cf5192ae 100644
>>>>>>>> --- a/include/migration/register.h
>>>>>>>> +++ b/include/migration/register.h
>>>>>>>> @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
>>>>>>>>          int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
>>>>>>>>                                   Error **errp);
>>>>>>>> +    /**
>>>>>>>> +     * @load_finish
>>>>>>>> +     *
>>>>>>>> +     * Poll whether all asynchronous device state loading had finished.
>>>>>>>> +     * Not called on the load failure path.
>>>>>>>> +     *
>>>>>>>> +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
>>>>>>>> +     *
>>>>>>>> +     * If this method signals "not ready" then it might not be called
>>>>>>>> +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
>>>>>>>> +     * while holding qemu_loadvm_load_finish_ready_lock.
>>>>>>>
>>>>>>> [1]
>>>>>>>
>>>>>>>> +     *
>>>>>>>> +     * @opaque: data pointer passed to register_savevm_live()
>>>>>>>> +     * @is_finished: whether the loading had finished (output parameter)
>>>>>>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>>>>>>> +     *
>>>>>>>> +     * Returns zero to indicate success and negative for error
>>>>>>>> +     * It's not an error that the loading still hasn't finished.
>>>>>>>> +     */
>>>>>>>> +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
>>>>>>>
>>>>>>> The load_finish() semantics is a bit weird, especially above [1] on "only
>>>>>>> allowed to be called once if ..." and also on the locks.
>>>>>>
>>>>>> The point of this remark is that a driver needs to call
>>>>>> qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
>>>>>> core to call its load_finish handler again.
>>>>>>
>>>>>>> It looks to me vfio_load_finish() also does the final load of the device.
>>>>>>>
>>>>>>> I wonder whether that final load can be done in the threads,
>>>>>>
>>>>>> Here, the problem is that current VFIO VMState has to be loaded from the main
>>>>>> migration thread as it internally calls QEMU core address space modification
>>>>>> methods which explode if called from another thread(s).
>>>>>
>>>>> Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
>>>>> BQL if possible, when that's ready then in your case here IIUC you can
>>>>> simply take BQL in whichever thread that loads it.. but yeah it's not ready
>>>>> at least..
>>>>
>>>> Yeah, long term we might want to work on making these QEMU core address space
>>>> modification methods somehow callable from multiple threads but that's
>>>> definitely not something for the initial patch set.
>>>>
>>>>> Would it be possible vfio_save_complete_precopy_async_thread_config_state()
>>>>> be done in VFIO's save_live_complete_precopy() through the main channel
>>>>> somehow?  IOW, does it rely on iterative data to be fetched first from
>>>>> kernel, or completely separate states?
>>>>
>>>> The device state data needs to be fully loaded first before "activating"
>>>> the device by loading its config state.
>>>>
>>>>> And just curious: how large is it
>>>>> normally (and I suppose this decides whether it's applicable to be sent via
>>>>> the main channel at all..)?
>>>>
>>>> Config data is *much* smaller than device state data - as far as I remember
>>>> it was on order of kilobytes.
>>>>
>>>>>>
>>>>>>> then after
>>>>>>> everything loaded the device post a semaphore telling the main thread to
>>>>>>> continue.  See e.g.:
>>>>>>>
>>>>>>>         if (migrate_switchover_ack()) {
>>>>>>>             qemu_loadvm_state_switchover_ack_needed(mis);
>>>>>>>         }
>>>>>>>
>>>>>>> IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
>>>>>>> when all things are loaded?  We can then get rid of this slightly awkward
>>>>>>> interface.  I had a feeling that things can be simplified (e.g., if the
>>>>>>> thread will take care of loading the final vmstate then the mutex is also
>>>>>>> not needed? etc.).
>>>>>>
>>>>>> With just a single call to switchover_ack_needed per VFIO device it would
>>>>>> need to do a blocking wait for the device buffers and config state load
>>>>>> to finish, therefore blocking other VFIO devices from potentially loading
>>>>>> their config state if they are ready to begin this operation earlier.
>>>>>
>>>>> I am not sure I get you here, loading VFIO device states (I mean, the
>>>>> non-iterable part) will need to be done sequentially IIUC due to what you
>>>>> said and should rely on BQL, so I don't know how that could happen
>>>>> concurrently for now.  But I think indeed BQL is a problem.
>>>> Consider that we have two VFIO devices (A and B), with the following order
>>>> of switchover_ack_needed handler calls for them: first A get this call,
>>>> once the call for A finishes then B gets this call.
>>>>
>>>> Now consider what happens if B had loaded all its buffers (in the loading
>>>> thread) and it is ready for its config load before A finished loading its
>>>> buffers.
>>>>
>>>> B has to wait idle in this situation (even though it could have been already
>>>> loading its config) since the switchover_ack_needed handler for A won't
>>>> return until A is fully done.
>>>
>>> This sounds like a performance concern, and I wonder how much this impacts
>>> the real workload (that you run a test and measure, with/without such
>>> concurrency) when we can save two devices in parallel anyway; I would
>>> expect the real diff is small due to the fact I mentioned that we save >1
>>> VFIO devices concurrently via multifd.
>>>
>>> Do you think we can start with a simpler approach?
>>
>> I don't think introducing a performance/scalability issue like that is
>> a good thing, especially that we already have a design that avoids it.
>>
>> Unfortunately, my current setup does not allow live migrating VMs with
>> more than 4 VFs so I can't benchmark that.
> 
> /me wonders why benchmarking it requires more than 4 VFs.

My point here was that the scalability problem will most likely get more
pronounced with more VFs.

>>
>> But I almost certain that with more VFs the situation with devices being
>> ready out-of-order will get even more likely.
> 
> If the config space is small, why loading it in sequence would be a
> problem?
> 
> Have you measured how much time it needs to load one VF's config space that
> you're using?  I suppose that's vfio_load_device_config_state() alone?

It's not the amount of data to load matters here but that these address
space operations are slow.

The whole config load takes ~70 ms per device - that's time equivalent
of transferring 875 MiB of device state via a 100 GBit/s link.

>>
>>> So what I'm thinking could be very clean is, we just discussed about
>>> MIG_CMD_SWITCHOVER and looks like you also think it's an OK approach.  I
>>> wonder when with it why not we move one step further to have
>>> MIG_CMD_SEND_NON_ITERABE just to mark that "iterable devices all done,
>>> ready to send non-iterable".  It can be controlled by the same migration
>>> property so we only send these two flags in 9.2+ machine types.
>>>
>>> Then IIUC VFIO can send config data through main wire (just like most of
>>> other pci devices! which is IMHO a good fit..) and on destination VFIO
>>> holds off loading them until passing the MIG_CMD_SEND_NON_ITERABE phase.
>>
>> Starting the config load only on MIG_CMD_SEND_NON_ITERABE would (in addition
>> to the considerations above) also delay starting the config load until all
>> iterable devices were read/transferred/loaded and also would complicate
>> future efforts at loading that config data in parallel.
> 
> However I wonder whether we can keep it simple in that VFIO's config space
> is still always saved in vfio_save_state().  I still think it's easier we
> stick with the main channel whenever possible.  For this specific case, if
> the config space is small I think it's tricky you bypass this with:
> 
>      if (migration->multifd_transfer) {
>          /* Emit dummy NOP data */
>          qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>          return;
>      }
> 
> Then squash this as the tail of the iterable data.
> 
> On the src, I think it could use a per-device semaphore, so that iterable
> save() thread will post() only if it finishes dumping all the data, then
> that orders VFIO iterable data v.s. config space save().

In the future we want to not only transfer but also load the config data
in parallel.

So going back to transferring this data serialized via the main migration
channel would be taking a step back here.

By the way, we already have a serialization point in
qemu_savevm_state_complete_precopy_iterable() after iterables have been sent -
waiting for device state sending threads to finish their work.

Whether this thread_pool_wait() operation will be implemented using
semaphores I'm not sure yet - will depend on how well this will fit other
GThreadPool internals.

> On the dst, after a 2nd thought, MIG_CMD_SEND_NON_ITERABE may not work or
> needed indeed, because multifd bypasses the main channel, so if we send
> anything like MIG_CMD_SEND_NON_ITERABE on the main channel it won't
> guarantee multifd load all complete.  However IIUC that can be used in a
> similar way as the src qemu I mentioned above with a per-device semaphore,
> so that only all the iterable data of this device loaded and applied to the
> HW would it post(), before that, vfio_load_state() should wait() on that
> sem waiting for data to ready (while multifd threads will be doing that
> part).  I wonder whether we may reuse the multifd recv thread in the
> initial version, so maybe we don't need any other threads on destination.
> 
> The load_finish() interface is currently not able to be reused right,
> afaict.  Just have a look at its definition:
> 
>      /**
>       * @load_finish
>       *
>       * Poll whether all asynchronous device state loading had finished.
>       * Not called on the load failure path.
>       *
>       * Called while holding the qemu_loadvm_load_finish_ready_lock.
>       *
>       * If this method signals "not ready" then it might not be called
>       * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
>       * while holding qemu_loadvm_load_finish_ready_lock.
>       *
>       * @opaque: data pointer passed to register_savevm_live()
>       * @is_finished: whether the loading had finished (output parameter)
>       * @errp: pointer to Error*, to store an error if it happens.
>       *
>       * Returns zero to indicate success and negative for error
>       * It's not an error that the loading still hasn't finished.
>       */
>      int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> 
> It's over complicated on defining all its details:
> 
>    - Not re-entrant by default.. 

What do you mean by "re-entrant" here?

This handler is called only from single migration thread, so it cannot
be re-entered anyway since the control doesn't return to the migration
code until this handler exits (and obviously the handler won't call
itself recursively).

> this is so weirdly designed so that the
>      caller needs to know which is even the "1st invocation of the
>      function"... It is just weird.

I don't quite understand that - why do you think that caller needs to
know whether this is the "1st invocation of the function"?

The caller only tracks whether all these handlers reported that they
finished their work:
>       bool all_ready = true;
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           bool this_ready;
> 
>           ret = se->ops->load_finish(se->opaque, &this_ready, &local_err);
>           if (ret) {
>           } else if (!this_ready) {
>               all_ready = false;
>           }
>
>       }
>       if (all_ready) {
>             break;
>       }


>    - Requires one more global mutex that non vmstate handler ever requested,

Could you elaborate what do you mean by "that non vmstate handler ever requested"?

>      that I feel like perhaps can be replaced by a sem (then to drop the
>      condvar)?

Once we have ability to load device config state outside main migration
thread replacing "load_finish" handler with a semaphore should indeed be
possible (that's internal migration API so there should be no issue
removing it as not necessary anymore at this point).

But for now, the devices need to have ability to run their config load
code on the main migration thread, and for that they need to be called
from this handler "load_finish".

>    - How qemu_loadvm_load_finish_ready_broadcast() interacts with all
>      above..
> 
> So if you really think it matters to load whatever VFIO device who's
> iterable data is ready first, then let's try come up with some better
> interface..  I can try to think about it too, but please answer me
> questions above so I can understand what I am missing on why that's
> important.  Numbers could help, even if 4 VF and I wonder how much diff
> there can be.  Mostly, I don't know why it's slow right now if it is; I
> thought it should be pretty fast, at least not a concern in VFIO migration
> world (which can take seconds of downtime or more..).
> 
> IOW, it sounds more reasonalbe to me that no matter whether vfio will
> support multifd, it'll be nice we stick with vfio_load_state() /
> vfio_save_state() for config space, and hopefully it's also easier it
> always go via the main channel to everyone.  In these two hooks, VFIO can
> do whatever it wants to sync with other things (on src, sync with
> concurrent thread pool saving iterable data and dumping things to multifd
> channels; on dst, sync with multifd concurrent loads). I think it can
> remove the requirement on the load_finish() interface completely.  Yes,
> this can only load VFIO's pci config space one by one, but I think this is
> much simpler, and I hope it's also not that slow, but I'm not sure.

To be clear, I made a following diagram describing how the patch set
is supposed to work right now, including changing per-device
VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE into a common MIG_CMD_SWITCHOVER.

Time flows on it left to right (->).

----------- DIAGRAM START -----------
Source overall flow:
Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable                                                                          -> non iterable
Multifd channels:                                       \ multifd device state read and queue (1) -> multifd config data read and queue (1) /

Target overall flow:
Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable -> non iterable -> config data load operations
Multifd channels:                                       \ multifd device state (1) -> multifd config data read (1)

Target config data load operations flow:
multifd config data read (1) -> config data load (2)

Notes:
(1): per device threads running in parallel
(2): currently serialized (only one such operation running at a particular time), will hopefully be parallelized in the future
----------- DIAGRAM END -----------

Hope the diagram survived being pasted into an e-mail message.

One can see, that even now there's a bit of "low hanging fruit" of missing
possible parallelism:
It seems that the source could wait for multifd device state + multifd config
data *after* non-iterables are sent rather than before as it is done
currently - so they will be sent in parallel with multifd data.

Since written description is often prone to misunderstanding
could you please annotate that diagram with your proposed new flow?

Thanks,
Maciej

