Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7E1CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraS0-0004Oi-8v; Tue, 02 Apr 2024 05:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rraRv-0004MO-8l
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:28:59 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rraRg-0000QU-6e
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712050124; x=1743586124;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D2wRgy1hf8ubBGm/OJ3N8thzEzZZ0XgLwRc0UyhalkY=;
 b=Kpe+We0Vyc3SiEFMHjfBFhLypxbDPd5a8dXMWnzWCtqHoivBIASMH1b0
 tN8u//UPgmyin6+K6EjT3qyGoOpUqKZzszn2SGORlz2Ja91BWbiDEkbyr
 IN93ipqG642JXtAYXtSzebNJaP6IEKz8rjsVOY3VVd0RdcHVVMwI5Bh2Y
 RDLnIGwRcK64Ocxz7IdrXlg+DRYNby/2PAM5S/nOqCRA4wWVsr5v6Pv4W
 cnpKijuu6sqioIGfY0pc12Uk7EqMQUuBU8JqThVZ934+ODhjBpxS7TjM6
 6WpVX4sIYCwnalDkkqL/1SeLUZt+Hz2nLBQua2BaqqIxqiWn2G4dWPvIT g==;
X-CSE-ConnectionGUID: ALhPzCD+SQCqOpQqXmO/6Q==
X-CSE-MsgGUID: mQ3X9b4ZQbKpwH4HfxWLqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7143293"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7143293"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 02:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="18033687"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.124.226.15])
 ([10.124.226.15])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 02:28:38 -0700
Message-ID: <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com>
Date: Tue, 2 Apr 2024 17:28:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Content-Language: en-US
To: "Wang, Wei W" <wei.w.wang@intel.com>, Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n> <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 4/2/2024 15:25, Wang, Wei W wrote:> On Tuesday, April 2, 2024 2:56 PM, Wang,
Lei4 wrote:
>> On 4/2/2024 0:13, Peter Xu wrote:> On Fri, Mar 29, 2024 at 08:54:07AM +0000,
>> Wang, Wei W wrote:
>>>> On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
>>>>> When using the post-copy preemption feature to perform post-copy
>>>>> live migration, the below scenario could lead to a deadlock and the
>>>>> migration will never finish:
>>>>>
>>>>>  - Source connect() the preemption channel in postcopy_start().
>>>>>  - Source and the destination side TCP stack finished the 3-way handshake
>>>>>    thus the connection is successful.
>>>>>  - The destination side main thread is handling the loading of the bulk
>> RAM
>>>>>    pages thus it doesn't start to handle the pending connection event in the
>>>>>    event loop. and doesn't post the semaphore
>> postcopy_qemufile_dst_done for
>>>>>    the preemption thread.
>>>>>  - The source side sends non-iterative device states, such as the virtio
>>>>>    states.
>>>>>  - The destination main thread starts to receive the virtio states, this
>>>>>    process may lead to a page fault (e.g., virtio_load()->vring_avail_idx()
>>>>>    may trigger a page fault since the avail ring page may not be received
>>>>>    yet).
>>>
>>> Ouch.  Yeah I think this part got overlooked when working on the
>>> preempt channel.
>>>
>>>>>  - The page request is sent back to the source side. Source sends the page
>>>>>    content to the destination side preemption thread.
>>>>>  - Since the event is not arrived and the semaphore
>>>>>    postcopy_qemufile_dst_done is not posted, the preemption thread in
>>>>>    destination side is blocked, and cannot handle receiving the page.
>>>>>  - The QEMU main load thread on the destination side is stuck at the page
>>>>>    fault, and cannot yield and handle the connect() event for the
>>>>>    preemption channel to unblock the preemption thread.
>>>>>  - The postcopy will stuck there forever since this is a deadlock.
>>>>>
>>>>> The key point to reproduce this bug is that the source side is
>>>>> sending pages at a rate faster than the destination handling,
>>>>> otherwise, the qemu_get_be64() in
>>>>> ram_load_precopy() will have a chance to yield since at that time
>>>>> there are no pending data in the buffer to get. This will make this
>>>>> bug harder to be reproduced.
>>>
>>> How hard would this reproduce?
>>
>> We can manually make this easier to reproduce by adding the following code
>> to make the destination busier to load the pages:
>>
>> diff --git a/migration/ram.c b/migration/ram.c index 0ad9fbba48..0b42877e1f
>> 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4232,6 +4232,7 @@ static int ram_load_precopy(QEMUFile *f)  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>      int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
>> +    volatile unsigned long long a;
>>
>>      if (!migrate_compress()) {
>>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE; @@ -4347,6
>> +4348,7 @@ static int ram_load_precopy(QEMUFile *f)
>>              break;
>>
>>          case RAM_SAVE_FLAG_PAGE:
>> +            for (a = 0; a < 100000000; a++);
>>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>>              break;
>>
> 
> Which version of QEMU are you using?
> I tried with the latest upstream QEMU (e.g. v8.2.0 release, 1600b9f46b1bd), it's
> always reproducible without any changes (with local migration tests).

I'm using the latest tip:

	6af9d12c88b9720f209912f6e4b01fefe5906d59

and it cannot be reproduced without the modification.

> 
> 
>>>
>>> I'm thinking whether this should be 9.0 material or 9.1.  It's pretty
>>> late for 9.0 though, but we can still discuss.
>>>
>>>>>
>>>>> Fix this by yielding the load coroutine when receiving
>>>>> MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
>>>>> connection event before loading the non-iterative devices state to
>>>>> avoid the deadlock condition.
>>>>>
>>>>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>>>>
>>>> This seems to be a regression issue caused by this commit:
>>>> 737840e2c6ea (migration: Use the number of transferred bytes
>>>> directly)
>>>>
>>>> Adding qemu_fflush back to migration_rate_exceeded() or
>>>> ram_save_iterate seems to work (might not be a good fix though).
>>>>
>>>>> ---
>>>>>  migration/savevm.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/migration/savevm.c b/migration/savevm.c index
>>>>> e386c5267f..8fd4dc92f2 100644
>>>>> --- a/migration/savevm.c
>>>>> +++ b/migration/savevm.c
>>>>> @@ -2445,6 +2445,11 @@ static int
>> loadvm_process_command(QEMUFile *f)
>>>>>          return loadvm_postcopy_handle_advise(mis, len);
>>>>>
>>>>>      case MIG_CMD_POSTCOPY_LISTEN:
>>>>> +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
>>>>> +            aio_co_schedule(qemu_get_current_aio_context(),
>>>>> +                            qemu_coroutine_self());
>>>>> +            qemu_coroutine_yield();
>>>>> +        }
>>>>
>>>> The above could be moved to loadvm_postcopy_handle_listen().
>>>
>>> I'm not 100% sure such thing (no matter here or moved into it, which
>>> does look cleaner) would work for us.
>>>
>>> The problem is I still don't yet see an ordering restricted on top of
>>> (1)
>>> accept() happens, and (2) receive LISTEN cmd here.  What happens if
>>> the
>>> accept() request is not yet received when reaching LISTEN?  Or is it
>>> always guaranteed the accept(fd) will always be polled here?
>>>
>>> For example, the source QEMU (no matter pre-7.2 or later) will always
>>> setup the preempt channel asynchrounously, then IIUC it can connect()
>>> after sending the whole chunk of packed data which should include this
>>> LISTEN.  I think it means it's not guaranteed this will 100% work, but
>>> maybe further reduce the possibility of the race.
>>
>> I think the following code:
>>
>> postcopy_start() ->
>> 	postcopy_preempt_establish_channel() ->
>> 		qemu_sem_wait(&s->postcopy_qemufile_src_sem);
>>
>> can guarantee that the connect() syscall is successful so the destination side
>> receives the connect() request before it loads the LISTEN command, otherwise
>> it won't post the sem:
>>
>> postcopy_preempt_send_channel_new() ->
>> 	postcopy_preempt_send_channel_done() ->
>>     		qemu_sem_post(&s->postcopy_qemufile_src_sem);
>>
> 
> Yes. But as mentioned in another thread, connect() and accept() are async.
> So in theory accept() could still come later after the LISTEN command.

IIUC accept() is the callback and will be triggered by the connect() event.

The reason accept() is not called in the destination is the main loop doesn't
get a chance to handle other events (connect()), so if we can guarantee
connect() is before LISTEN, then when handling the LISTEN cmd, we yield to the
main loop and the connect() event is there, then we can handle it by calling the
accept():

qio_net_listener_channel_func
	qio_channel_socket_accept
		qemu_accept
			accept

so it seems the case accept() comes alter after LISTEN is in our expectation?

> 
>>>
>>> One right fix that I can think of is moving the sem_wait(&done) into
>>> the main thread too, so we wait for the sem _before_ reading the
>>> packed data, so there's no chance of fault.  However I don't think
>>> sem_wait() will be smart enough to yield when in a coroutine..  In the
>>> long term run I think we should really make migration loadvm to do
>>> work in the thread rather than the main thread.  I think it means we
>>> have one more example to be listed in this todo so that's preferred..
>>>
>>> https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration
>>> _destination
>>>
>>> I attached such draft patch below, but I'm not sure it'll work.  Let
>>> me know how both of you think about it.
>>
>> Sadly it doesn't work, there is an unknown segfault.
>>
>>>
>>>>
>>>> Another option is to follow the old way (i.e. pre_7_2) to do
>>>> postcopy_preempt_setup in migrate_fd_connect. This can save the above
>>>> overhead of switching to the main thread during the downtime. Seems
>>>> Peter's previous patch already solved the channel disordering issue. Let's
>> see Peter and others' opinions.
>>>
>>> IIUC we still need that pre_7_2 stuff and keep the postponed connect()
>>> to make sure the ordering is done properly.  Wei, could you elaborate
>>> the patch you mentioned?  Maybe I missed some spots.
>>>
>>> You raised a good point that this may introduce higher downtime.  Did
>>> you or Lei tried to measure how large it is?  If that is too high, we
>>> may need to think another solution, e.g., wait the channel connection
>>> before vm stop happens.
>>
>> Per my very simple test, using post-copy preemption to live migrate an 8G VM:
>>
>>     w/o this patch: 121ms in avg in 5 tries
>>     w/ this patch: 115ms in avg in 5 tries
>>
>> So it seems the overhead introduced is not too high (maybe ignorable?).
> 
> You could just measure the time for the added qemu_coroutine_yield() part.
> The time will depend on how many events happen to be there waiting for a dispatch.

Still less than 1ms (0.05ms).

Indeed, that may depends on how many events needs to be handled.

