Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD63C67861
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 02:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtHpI-0008Ip-RD; Sat, 06 Apr 2024 22:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rtHpF-0008If-7U
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 22:00:05 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rtHpC-0001M3-M7
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 22:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712455202; x=1743991202;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5tFvidBWshxgMbIFD482Svk/7uM67hmlcNE3n2fagaE=;
 b=ThBrPkG0rYL/G+seK0RGNO1IgZt23UVcyn3LY6/rdzwebv2zLd4o8a87
 cU0+4eWFtIr+KNYeobTQ5YsHI/HfuSSnxJmPjkRRDDAOCLm32lxe7BVxV
 QIdp9PohHSUBhXJmZcsRPzP74AwMCIv8gjU/2QFnoSKQznCfz8gy7oerm
 WUZNtQuo1bKuLr4JCvEDT/I+x72O9ZJGnQY4Uz4yWhGfxmDG4aGyp2N3g
 ArCEFtXV9fAE5orBPGVTFECjcWCA4hnI4HGp85WtkMoS1rISsJZD4bHku
 hHRqF5Tm3DR6y2uU9eJDbpLEpdC1ouukSa+uBczApGhZ30pXYAuA/rl8/ Q==;
X-CSE-ConnectionGUID: FBIy0of0TLGO/w3L7J4i4w==
X-CSE-MsgGUID: UHI60BsBRDK1MVppGmzp5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="10724519"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; d="scan'208";a="10724519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2024 18:59:58 -0700
X-CSE-ConnectionGUID: 69zAzSovQB2O61I+eDTthg==
X-CSE-MsgGUID: cTq/faqTTiij70uxJR7USA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; d="scan'208";a="24259170"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.125.241.27])
 ([10.125.241.27])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2024 18:59:56 -0700
Message-ID: <39fb6acc-a285-49c8-a7bb-c17abf383f45@intel.com>
Date: Sun, 7 Apr 2024 09:59:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
To: Peter Xu <peterx@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org
References: <20240405034056.23933-1-wei.w.wang@intel.com>
 <ZhByy4YvYl9xLmRP@x1n>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <ZhByy4YvYl9xLmRP@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=lei4.wang@intel.com;
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

On 4/6/2024 5:53, Peter Xu wrote:> On Fri, Apr 05, 2024 at 11:40:56AM +0800, Wei
Wang wrote:
>> Before loading the guest states, ensure that the preempt channel has been
>> ready to use, as some of the states (e.g. via virtio_load) might trigger
>> page faults that will be handled through the preempt channel. So yield to
>> the main thread in the case that the channel create event hasn't been
>> dispatched.
>>
>> Originally-by: Lei Wang <lei4.wang@intel.com>
>> Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
>> Suggested-by: Peter Xu <peterx@redhat.com>
> 
> The current version doesn't have any of my credits. :) Thanks, but I'll
> just drop it to reflect reality, so we keep the credit to the right ones.
> 
>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>  migration/savevm.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 388d7af7cd..63f9991a8a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2342,6 +2342,23 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>>  
>>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
>>  
>> +    /*
>> +     * Before loading the guest states, ensure that the preempt channel has
>> +     * been ready to use, as some of the states (e.g. via virtio_load) might
>> +     * trigger page faults that will be handled through the preempt channel.
>> +     * So yield to the main thread in the case that the channel create event
>> +     * hasn't been dispatched.
> 
> I'll squash below into it.  If any of you disagree please shoot: valid
> until this Sunday.

I'm OK with it.

> 
> +     * TODO: if we can move migration loadvm out of main thread, then we
> +     * won't block main thread from polling the accept() fds.  We can drop
> +     * this as a whole when that is done.
> 
> Huge thanks to both!

Thank you Peter :)

> 
>> +     */
>> +    do {
>> +        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
>> +            mis->postcopy_qemufile_dst) {
>> +            break;
>> +        }
>> +
>> +        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
>> +        qemu_coroutine_yield();
>> +    } while (1);
>> +
>>      ret = qemu_loadvm_state_main(packf, mis);
>>      trace_loadvm_handle_cmd_packaged_main(ret);
>>      qemu_fclose(packf);
>> -- 
>> 2.27.0
>>
> 

