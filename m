Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C047CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 16:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQGM-0001K8-Ni; Thu, 04 Apr 2024 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rsQGI-0001Jq-Ct
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:48:26 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rsQGF-0000UJ-8F
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712249303; x=1743785303;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ejQ1LWaoikNWrt8KCG/4AU7Gv/XPZlMQkn3gGp+IGeM=;
 b=CQLOK1dw+V0OMK6HhcHJhwxGjlU22CFcJSpE6M+9lMS5LDdmfRkX6hv2
 j1TAe4QHy8rhEDXbg38UjTYmmeKckbql9hbtCVOy/cXfStmpLbcwDpULw
 9jR+YhXadfLdCNvt0T+KnKyzSfDvfb0/hlwp5A/AKk1CGNzpAz+xztaYv
 EqdGVssv7HMEtEjZnNFuHAPwfhzOmKCuSWgEzcTNlNQF393b2idnTz9i9
 qxR5hilZJSKuR1HnjSdxYw0q0T7h+IwY7azcaFSpoUwxwAz+9+J29UO2y
 qbdg+Rsu+6YHlpq17t8JY7w82MWxYq1wjGtQAsbfYbOmjhfDxHWg7h+sC g==;
X-CSE-ConnectionGUID: 3FB299IiRGa4W8ab0c1v1w==
X-CSE-MsgGUID: 1ADSUaUTR3iHFFobJTIcWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18109544"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18109544"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 09:48:19 -0700
X-CSE-ConnectionGUID: nZ5fpJRuSB2aTE+xNp3vFg==
X-CSE-MsgGUID: 1ZNnwj+cR+use+BBQWUnEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18945249"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.125.241.27])
 ([10.125.241.27])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 09:48:17 -0700
Message-ID: <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com>
Date: Fri, 5 Apr 2024 00:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
To: "Wang, Wei W" <wei.w.wang@intel.com>, Peter Xu <peterx@redhat.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
 <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=lei4.wang@intel.com;
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

On 4/5/2024 0:25, Wang, Wei W wrote:> On Thursday, April 4, 2024 10:12 PM, Peter
Xu wrote:
>> On Thu, Apr 04, 2024 at 06:05:50PM +0800, Wei Wang wrote:
>>> Before loading the guest states, ensure that the preempt channel has
>>> been ready to use, as some of the states (e.g. via virtio_load) might
>>> trigger page faults that will be handled through the preempt channel.
>>> So yield to the main thread in the case that the channel create event
>>> has been dispatched.
>>>
>>> Originally-by: Lei Wang <lei4.wang@intel.com>
>>> Link:
>>> https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel
>>> .com/T/
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> ---
>>>  migration/savevm.c | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/migration/savevm.c b/migration/savevm.c index
>>> 388d7af7cd..fbc9f2bdd4 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -2342,6 +2342,23 @@ static int
>>> loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>>>
>>>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
>>>
>>> +    /*
>>> +     * Before loading the guest states, ensure that the preempt channel has
>>> +     * been ready to use, as some of the states (e.g. via virtio_load) might
>>> +     * trigger page faults that will be handled through the preempt channel.
>>> +     * So yield to the main thread in the case that the channel create event
>>> +     * has been dispatched.
>>> +     */
>>> +    do {
>>> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
>>> +            mis->postcopy_qemufile_dst) {
>>> +            break;
>>> +        }
>>> +
>>> +        aio_co_schedule(qemu_get_current_aio_context(),
>> qemu_coroutine_self());
>>> +        qemu_coroutine_yield();
>>> +    } while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done,
>>> + 1));
>>
>> I think we need s/!// here, so the same mistake I made?  I think we need to
>> rework the retval of qemu_sem_timedwait() at some point later..
> 
> No. qemu_sem_timedwait returns false when timeout, which means sem isn’t posted yet.
> So it needs to go back to the loop. (the patch was tested)

When timeout, qemu_sem_timedwait() will return -1. I think the patch test passed
may because you will always have at least one yield (the first yield in the do
...while ...) when loadvm_handle_cmd_packaged()?

> 
>>
>> Besides, this patch kept the sem_wait() in postcopy_preempt_thread() so it
>> will wait() on this sem again.  If this qemu_sem_timedwait() accidentally
>> consumed the sem count then I think the other thread can hang forever?
> 
> I can get the issue you mentioned, and seems better to be placed before the creation of
> the preempt thread. Then we probably don’t need to wait_sem in the preempt thread, as the
> channel is guaranteed to be ready when it runs?
> 
> Update will be:
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index eccff499cb..5a70ce4f23 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1254,6 +1254,15 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>      }
> 
>      if (migrate_postcopy_preempt()) {
> +        do {
> +            if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> +                mis->postcopy_qemufile_dst) {
> +                break;
> +            }
> +            aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
> +            qemu_coroutine_yield();
> +        } while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 1));
> +
>          /*
>           * This thread needs to be created after the temp pages because
>           * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
> @@ -1743,12 +1752,6 @@ void *postcopy_preempt_thread(void *opaque)
> 
>      qemu_sem_post(&mis->thread_sync_sem);
> 
> -    /*
> -     * The preempt channel is established in asynchronous way.  Wait
> -     * for its completion.
> -     */
> -    qemu_sem_wait(&mis->postcopy_qemufile_dst_done);
> 
> 
> 
> 
> 
> 
> 

