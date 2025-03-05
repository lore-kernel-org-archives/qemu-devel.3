Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07506C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprwU-0004aq-47; Wed, 05 Mar 2025 11:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tprwR-0004TU-0y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:49:55 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tprwO-0005N0-T7
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:49:54 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tprwK-00000000NLb-0FQn; Wed, 05 Mar 2025 17:49:48 +0100
Message-ID: <588bbcf2-5ac2-4bb2-a5f9-581171afb469@maciej.szmigiero.name>
Date: Wed, 5 Mar 2025 17:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/36] migration: postcopy_ram_listen_thread() should
 take BQL for some calls
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <24a7412cc151f8b48d74cd170a3bdc1ce8e6c879.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8hE3ujEKkwsBiJO@x1.local>
 <4aac2a7e-f42e-4e92-8e27-3b0e9a7b6603@maciej.szmigiero.name>
 <Z8h4i3Ima6BhaoBs@x1.local> <1828fd0d-3f97-4488-9a58-ab57de5e5b35@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <1828fd0d-3f97-4488-9a58-ab57de5e5b35@redhat.com>
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

On 5.03.2025 17:37, Cédric Le Goater wrote:
> On 3/5/25 17:15, Peter Xu wrote:
>> On Wed, Mar 05, 2025 at 04:11:30PM +0100, Maciej S. Szmigiero wrote:
>>> On 5.03.2025 13:34, Peter Xu wrote:
>>>> On Tue, Mar 04, 2025 at 11:03:34PM +0100, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> All callers to migration_incoming_state_destroy() other than
>>>>> postcopy_ram_listen_thread() do this call with BQL held.
>>>>>
>>>>> Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
>>>>> SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
>>>>> to always call that function under BQL rather than to have it deal with
>>>>> both cases (with BQL and without BQL).
>>>>> Add the necessary bql_lock() and bql_unlock() to
>>>>> postcopy_ram_listen_thread().
>>>>>
>>>>> qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
>>>>> "load_state" SaveVMHandlers that are expecting BQL to be held.
>>>>>
>>>>> In principle, the only devices that should be arriving on migration
>>>>> channel serviced by postcopy_ram_listen_thread() are those that are
>>>>> postcopiable and whose load handlers are safe to be called without BQL
>>>>> being held.
>>>>>
>>>>> But nothing currently prevents the source from sending data for "unsafe"
>>>>> devices which would cause trouble there.
>>>>> Add a TODO comment there so it's clear that it would be good to improve
>>>>> handling of such (erroneous) case in the future.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>    migration/migration.c | 16 ++++++++++++++++
>>>>>    migration/savevm.c    |  4 ++++
>>>>>    2 files changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index 9e9db26667f1..6b2a8af4231d 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -402,10 +402,26 @@ void migration_incoming_state_destroy(void)
>>>>>        struct MigrationIncomingState *mis = migration_incoming_get_current();
>>>>>        multifd_recv_cleanup();
>>>>> +
>>>>>        /*
>>>>>         * RAM state cleanup needs to happen after multifd cleanup, because
>>>>>         * multifd threads can use some of its states (receivedmap).
>>>>> +     *
>>>>> +     * This call also needs BQL held since it calls all registered
>>>>> +     * load_cleanup SaveVMHandlers and at least the VFIO implementation is
>>>>> +     * BQL-sensitive.
>>>>> +     *
>>>>> +     * In addition to the above, it also performs cleanup of load threads
>>>>> +     * thread pool.
>>>>> +     * This cleanup operation is BQL-sensitive as it requires unlocking BQL
>>>>> +     * so a thread possibly waiting for it could get unblocked and finally
>>>>> +     * exit.
>>>>> +     * The reason why a load thread may need to hold BQL in the first place
>>>>> +     * is because address space modification operations require it.
>>>>
>>>> Hold on...
>>>>
>>>> This almost says exactly why load_cleanup() should _not_ take BQL... rather
>>>> than should..
>>>>
>>>> So I had a closer look at the latest code, it's about this:
>>>>
>>>> static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
>>>> {
>>>>       /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>>>>       bql_unlock();
>>>>       WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>>>>           while (multifd->load_bufs_thread_running) {
>>>>               multifd->load_bufs_thread_want_exit = true;
>>>>
>>>>               qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>>>>               qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
>>>>               qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
>>>>                              &multifd->load_bufs_mutex);
>>>>           }
>>>>       }
>>>>       bql_lock();
>>>> }
>>>>
>>>> It doesn't make much sense to me to take it only because we want to drop it
>>>> unconditionally. Can we guarantee the function not taking BQL instead?  I
>>>> had a quick look on pmem's pmem_persist() (from libpmem, qemu_ram_msync <-
>>>> qemu_ram_block_writeback <- ram_load_cleanup), it looks ok.
>>>>
>>>> So the question is, is it safe to unlock BQL in whatever context (in
>>>> coroutines, or in a bottom half)?
>>>>
>>>> If the answer is yes, we could make migration_incoming_state_destroy()
>>>> always not taking BQL (and assert(!bql_locked()) instead).
>>>
>>> All the other callers of migration_incoming_state_destroy() are holding BQL:
>>> process_incoming_migration_bh(), process_incoming_migration_co() (called on,
>>> failure path only), load_snapshot() and qmp_xen_load_devices_state().
>>>
>>> So AFAIK the safer way is to standardize on holding BQL when calling
>>> that function.
>>>> If the answer is no, then vfio_load_cleanup_load_bufs_thread()'s current
>>>> version may not work either..
>>>
>>> I think the reason for BQL is to serialize access to the QEMU internals
>>> which are not thread-safe.
>>>
>>> So as long as these internals aren't touched when not holding BQL then
>>> we should be safe - I don't see any particular state that's cached
>>> around these BQL calls and would need explicit reloading after re-gaining
>>> it.
>>
>> OK, I checked with misterious force and looks like it's ok.
>>
>> Would you please rephrase the comment, though?  I want to make it crystal
>> clear that what we're looking for is not holding BQL.. Maybe something like
>> this:
>>
>>      /*
>>       * The VFIO load_cleanup() implementation is BQL-sensitive. It requires
>>       * BQL must NOT be taken when recycling load threads, so that it won't
>>       * block the load threads from making progress on address space
>>       * modification operations.
>>       *
>>       * To make it work, we could try to not take BQL for all load_cleanup(),
>>       * or conditionally unlock BQL only if bql_locked() in VFIO.
>>       *
>>       * Since most existing call sites take BQL for load_cleanup(), make
>>       * it simple by taking BQL always as the rule, so that VFIO can unlock
>>       * BQL and retake unconditionally.
>>       */
>>
>> We may also want to update the subject.  Currently:
>>
>>    "migration: postcopy_ram_listen_thread() should take BQL for some calls"
>>
>> It's not accurate anymore, it could be:
>>
>>    "migration: Always take BQL for migration_incoming_state_destroy()"
>>
>> If with all above, please feel free to take:
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>>
>> I'm OK if it'll be touched up when merge too.

@Peter: Updated the comment and patch subject.
Added your review tag.

> Maciej,
> 
> Could you please resend just that patch as a reply to the series ? No need to
> resend the whole series.

@Cedric:
I've sent the updated patch.

I also updated the tree at GitLab with collected review tags and
updated version of this patch.

> Thanks,
> 
> C.
> 
> 

Thanks,
Maciej


