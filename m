Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13026CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 15:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIqc5-00013k-Ef; Tue, 11 Nov 2025 10:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vIqc2-000101-4A; Tue, 11 Nov 2025 10:48:55 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1vIqc0-0002X5-Sp; Tue, 11 Nov 2025 10:48:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA46760202;
 Tue, 11 Nov 2025 15:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F2C4CEF5;
 Tue, 11 Nov 2025 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762876130;
 bh=xbBFcd3WtQrbKDjuIJt+BYAaHR9+wI9H3P/WY2KMoIw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MunOJHaqy6lAelioP5qJAxPC86W5uTjm55K4HUO/0dOmYc7HLF5uYBTn6VZKRrlIl
 qXldUij7U2etdfMsxpxFN/aNnxLRu16OJJx/tmYAcnyz0w5TTbzHQ/8WII9Hb2KI3n
 d7d5gWjIgF0pZB2ZnWzBfxmeguQjLHgHbaGze03k2QTwnBGUNmXua4BS/HPGwObd0p
 KIP28n+ZUcCnSGghpevzSfCT0VnAHQpLxv0XEONopgeVCNQ3pHq+MS01WjbCg2hvN8
 fgpzY3vnz6oACzkbjM7SiTo7+xaWa86/eI/LbG9on25ptXLXCS0FpRtiTXZ5KVZw3i
 8VfsCSVQyvPkQ==
Message-ID: <45dd6d90-dffb-4261-9d64-769dd1e4b147@kernel.org>
Date: Tue, 11 Nov 2025 16:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Nicholas Miehlbradt
 <nicholas@linux.ibm.com>, richard.henderson@linaro.org, iii@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
 <d5990a22-76dc-4c20-ba38-6179899a3f42@redhat.com>
 <a80fc77e-e565-42ce-9d31-3e09d694c7f2@kernel.org>
 <375dccd4-b7bf-4db2-9998-cbd5b50474b5@linux.ibm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <375dccd4-b7bf-4db2-9998-cbd5b50474b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11.11.25 15:55, Christian Borntraeger wrote:
> 
> Am 11.11.25 um 14:37 schrieb David Hildenbrand (Red Hat):
>>>>>         /*
>>>>>          * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
>>>>> @@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine,
>>>>> ResetType type)
>>>>>         switch (reset_type) {
>>>>>         case S390_RESET_EXTERNAL:
>>>>>         case S390_RESET_REIPL:
>>>>> +    case S390_RESET_REIPL_CLEAR:
>>>>>             /*
>>>>>              * Reset the subsystem which includes a AP reset. If a PV
>>>>>              * guest had APQNs attached the AP reset is a prerequisite to
>>>>> @@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine,
>>>>> ResetType type)
>>>>>                 s390_machine_unprotect(ms);
>>>>>             }
>>>>> +        if (reset_type == S390_RESET_REIPL_CLEAR) {
>>>>> +            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
>>>>> +        }
>>>>> +
>>
>> ...
>>
>>>>
>>>>
>>>>
>>>> Do I see that right that this patch never made it into qemu master? IIRC
>>>> Matt has clarified all concerns?
>>>
>>> I was hoping to see a reply from David that he's fine with the patch now...
>>> David?
>>
>> Staring at this again, one more point regarding userfaultfd: doing the discard on the destination while postcopy is active might be problematic.
>>
>> I don't remember all details, but I think that if we have the following:
>>
>> 1) Migrate page X to dst
>> 2) Discard page X on dst
>> 3) Access page X on dst
>>
>> that postcopy_request_page()->migrate_send_rp_req_pages() would assume that the page was already transferred (marked received in the receive bitmap during 1) ) and essentially never place a fresh zeropage during 3) to be stuck forever.
> 
> Can we have a postcopy running while we are in system reset? 

Yes, that should be possible. Start postcopy and then trigger a system reset on the
destination (e.g., from the guest).

> Or as an alternative can we check for postcopy running and not discard in that case.

Another interaction might be with background snapshots (another form of migration)
running concurrently. If we discard after populating all memory+registering
userfaultfd-wp I think we might not get write events for all changes,
possibly corrupting the snapshot (not 100% sure but that's what I remember).


What virtio-mem does to workaround all that is the following:

static bool virtio_mem_is_busy(void)
{
     /*
      * Postcopy cannot handle concurrent discards and we don't want to migrate
      * pages on-demand with stale content when plugging new blocks.
      *
      * For precopy, we don't want unplugged blocks in our migration stream, and
      * when plugging new blocks, the page content might differ between source
      * and destination (observable by the guest when not initializing pages
      * after plugging them) until we're running on the destination (as we didn't
      * migrate these blocks when they were unplugged).
      */
     return migration_in_incoming_postcopy() || migration_is_running();
}



-- 
Cheers

David

