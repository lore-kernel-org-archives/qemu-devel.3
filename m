Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4526BCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 08:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrw60-0006Nb-L4; Wed, 03 Apr 2024 04:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rrw5y-0006NF-Sc
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 04:35:46 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rrw5w-00021a-C2
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 04:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712133344; x=1743669344;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jvs5cxX2DsDzZqEWRNVh2OJJe8l2vy9a3h/YocpJfvQ=;
 b=XmxFGg7JbmbIZO4tvahWW54PHWK6xXJypeTq3V3QeqqVqDHOv6ou0CMw
 /Xlfj4/pKb1WT7ICtQfsIclKRtIyOXlst41FOfXIHFb4Gnmb7icqa9JBI
 npMVjnsD4E+/LI2tRcBYh3vVpBq1MicJFL6RUSHksZ38ronZL5Umhl6hY
 SHV21VAdEuWXN3vB4V0nu5DkD9lDr0cAs0XlE6L9xmlZOxCq5iTtydF4O
 wjWEtJSU0QqqCWR5tkkmI64pc/1EHHmcLFH8Ouw+vjT0I12vJKQvkceNQ
 aUjups4mFs2n9QNQmkRh9B/jExBCQqlkkFqooDD+UmmNFSSxCvjiaenbi Q==;
X-CSE-ConnectionGUID: MLrei6LNT4u/TbCk8bXEsQ==
X-CSE-MsgGUID: w5owivApQXeOU6IIDz2gUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24847274"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="24847274"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 01:35:39 -0700
X-CSE-ConnectionGUID: zm8GQOoZTIikKwYdECz/2Q==
X-CSE-MsgGUID: Byyp6e7MSBeWJqu7pLSHAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="23064224"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.125.241.27])
 ([10.125.241.27])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 01:35:37 -0700
Message-ID: <c0607330-60af-4e0f-819e-4a22a38edd6d@intel.com>
Date: Wed, 3 Apr 2024 16:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n> <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com> <Zgx7DI4LXYrR_dk-@x1n>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <Zgx7DI4LXYrR_dk-@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=lei4.wang@intel.com;
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

On 4/3/2024 5:39, Peter Xu wrote:>>>>>
>>>>> I'm not 100% sure such thing (no matter here or moved into it, which
>>>>> does look cleaner) would work for us.
>>>>>
>>>>> The problem is I still don't yet see an ordering restricted on top of
>>>>> (1)
>>>>> accept() happens, and (2) receive LISTEN cmd here.  What happens if
>>>>> the
>>>>> accept() request is not yet received when reaching LISTEN?  Or is it
>>>>> always guaranteed the accept(fd) will always be polled here?
>>>>>
>>>>> For example, the source QEMU (no matter pre-7.2 or later) will always
>>>>> setup the preempt channel asynchrounously, then IIUC it can connect()
>>>>> after sending the whole chunk of packed data which should include this
>>>>> LISTEN.  I think it means it's not guaranteed this will 100% work, but
>>>>> maybe further reduce the possibility of the race.
>>>>
>>>> I think the following code:
>>>>
>>>> postcopy_start() ->
>>>> 	postcopy_preempt_establish_channel() ->
>>>> 		qemu_sem_wait(&s->postcopy_qemufile_src_sem);
>>>>
>>>> can guarantee that the connect() syscall is successful so the destination side
>>>> receives the connect() request before it loads the LISTEN command, otherwise
>>>> it won't post the sem:
>>>>
>>>> postcopy_preempt_send_channel_new() ->
>>>> 	postcopy_preempt_send_channel_done() ->
>>>>     		qemu_sem_post(&s->postcopy_qemufile_src_sem);
>>>>
>>>
>>> Yes. But as mentioned in another thread, connect() and accept() are async.
>>> So in theory accept() could still come later after the LISTEN command.
>>
>> IIUC accept() is the callback and will be triggered by the connect() event.
>>
>> The reason accept() is not called in the destination is the main loop doesn't
>> get a chance to handle other events (connect()), so if we can guarantee
>> connect() is before LISTEN, then when handling the LISTEN cmd, we yield to the
>> main loop and the connect() event is there, then we can handle it by calling the
>> accept():
>>
>> qio_net_listener_channel_func
>> 	qio_channel_socket_accept
>> 		qemu_accept
>> 			accept
>>
>> so it seems the case accept() comes alter after LISTEN is in our expectation?
> 
> The major thing uncertain to me is "accept() will return with a valid fd"
> on dest host is not guaranteed to order against anything.
> 
> For example, I won't be surprised if a kernel implementation provides an
> async model of "accept()" syscall, so that even if the other side returned
> with "connect()", the "accept()" can still fetch nothing if the async model
> will need a delay for the new channel to be finally delivered to the
> "accept()" thread context.  It just sounds like tricky to rely on such
> thing.
> 
> What I proposed below shouldn't rely on any kernel details on how accept()
> could be implemented, it simply waits for the fd to be created before doing
> anything else (including creating the preempt thread and process packed
> data).

Thanks for the detailed explanation!

> 
>>
>>>
>>>>>
>>>>> One right fix that I can think of is moving the sem_wait(&done) into
>>>>> the main thread too, so we wait for the sem _before_ reading the
>>>>> packed data, so there's no chance of fault.  However I don't think
>>>>> sem_wait() will be smart enough to yield when in a coroutine..  In the
>>>>> long term run I think we should really make migration loadvm to do
>>>>> work in the thread rather than the main thread.  I think it means we
>>>>> have one more example to be listed in this todo so that's preferred..
>>>>>
>>>>> https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration
>>>>> _destination
>>>>>
>>>>> I attached such draft patch below, but I'm not sure it'll work.  Let
>>>>> me know how both of you think about it.
>>>>
>>>> Sadly it doesn't work, there is an unknown segfault.
> 
> Could you paste the stack of the segfault ("(gdb) thread apply all bt")?
> Or help to figure out what is wrong?
> 
> Since I cannot reproduce myself, I may need your help debugging this.  If
> you agree with what I said above and agree on such fix, please also feel
> free to go ahead and fix the segfault.

We should change the following line from

	while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {

to

	while (qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {

After that fix, test passed and no segfault.

Given that the test shows a yield to the main loop won't introduce much overhead
(<1ms), how about first yield unconditionally, then we enter the while loop to
wait for several ms and yield periodically?

