Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693C2C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3mG-00008u-Ln; Fri, 28 Mar 2025 03:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ty3mC-00005M-Ue
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:05:13 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ty3m9-0007FX-SN
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743145510; x=1774681510;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3VrD5zHLNmhvqCcMQwahBVO9FyNPlzkMVC74SBwRArE=;
 b=iTECGOCW38ujMtshadGm4bA81C/FsuOIuteel7c+i9j/fPltbrjbawNv
 SyV+E2TrgpboONsw0WQFlRah2HxKl2ODR1c0WSHLYuZ9B94IAVrtMX66+
 x2fZ3Fl/wl5ydG12/MWs0A81HPakOf85+c9a3oDLLwY8szisc1GXbQmrg
 t7cOaV4hffgvkEFV+/FxP90Q+1/2KrNiBKLwJBnVi9cHiRbVSO/9/8wii
 jE0uSV43Fkrh7BNiNVHPgL2GT9WZWSB844G7ycoZ00usri9sR8iMZm0dL
 5a1UQ14VwtMId7DDahxZ7kTfJHsgnEmqxeGAx+YPEnwTI4t3JD3opeVAf A==;
X-CSE-ConnectionGUID: TULHVagQRb+NiaqMHMZkeQ==
X-CSE-MsgGUID: jf8PVQ7ESsa5VAsSB5pBcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43745162"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; d="scan'208";a="43745162"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 00:05:05 -0700
X-CSE-ConnectionGUID: B6JoLXGdTASS06qJH0cDtA==
X-CSE-MsgGUID: 38nDZmjxR1aEBymOqAkQ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; d="scan'208";a="162606902"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 00:05:04 -0700
Message-ID: <7b4d0c5f-eb9e-4fc1-bc85-c08b1e674586@intel.com>
Date: Fri, 28 Mar 2025 15:05:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
To: Steven Sistare <steven.sistare@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
 <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
 <174301860426.2151434.16431559419990134889@amd.com> <87msd7a6td.fsf@suse.de>
 <20250326213443.jl3r77hqh6gy2h4w@amd.com>
 <307f12e8-7de0-42b2-97ab-997c2dc3f39c@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <307f12e8-7de0-42b2-97ab-997c2dc3f39c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.782, RCVD_IN_DNSWL_MED=-2.3,
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

On 3/27/2025 8:27 PM, Steven Sistare wrote:
> On 3/26/2025 5:34 PM, Michael Roth wrote:
>> On Wed, Mar 26, 2025 at 05:13:50PM -0300, Fabiano Rosas wrote:
>>> Michael Roth <michael.roth@amd.com> writes:
>>>
>>>> Quoting Tom Lendacky (2025-03-26 14:21:31)
>>>>> On 3/26/25 13:46, Tom Lendacky wrote:
>>>>>> On 3/7/25 12:15, Fabiano Rosas wrote:
>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>
>>>>>>> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile 
>>>>>>> ram blocks
>>>>>>> in the migration stream file and recreate them later, because the 
>>>>>>> physical
>>>>>>> memory for the blocks is pinned and registered for vfio.  Add a 
>>>>>>> blocker
>>>>>>> for volatile ram blocks.
>>>>>>>
>>>>>>> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd 
>>>>>>> may be
>>>>>>> sufficient for CPR, but it has not been tested yet.
>>>>>>>
>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>>> Message-ID: <1740667681-257312-1-git-send-email- 
>>>>>>> steven.sistare@oracle.com>
>>>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>>>> ---
>>>>>>>   include/exec/memory.h   |  3 ++
>>>>>>>   include/exec/ramblock.h |  1 +
>>>>>>>   migration/savevm.c      |  2 ++
>>>>>>>   system/physmem.c        | 66 ++++++++++++++++++++++++++++++++++ 
>>>>>>> +++++++
>>>>>>>   4 files changed, 72 insertions(+)
>>>>>>
>>>>>> This patch breaks booting an SNP guest as it triggers the following
>>>>>> assert:
>>>>>>
>>>>>> qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion 
>>>>>> `*errp == NULL' failed.
>>>>>>
>>>
>>> Usually this means the error has already been set previously, which is
>>> not allowed.
>>>
>>>>>> I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
>>>>>> It looks like the error message is unable to be printed because
>>>>>> rb->cpr_blocker is NULL.
>>>>>>
>>>>>> Adding aux-ram-share=on to the -machine object gets me past the 
>>>>>> error and
>>>>>> therefore the assertion, but isn't that an incompatible change to 
>>>>>> how an
>>>>>> SNP guest has to be started?
>>>>>
>>>>> If I update the err_setg() call to use the errp parameter that is 
>>>>> passed
>>>>> into ram_block_add_cpr_blocker(), I get the following message and then
>>>>> the guest launch terminates:
>>>>>
>>>
>>> The usage at ram_block_add_cpr_blocker() is correct, the cpr_blocker
>>> gets initialized and registered as a migration blocker. The errp only
>>> becomes relevant later when migration starts and the error condition is
>>> met.
>>>
>>>>> qemu-system-x86_64: Memory region pc.bios is not compatible with CPR.
>>>>> share=on is required for memory-backend objects, and aux-ram- 
>>>>> share=on is
>>>>> required.
>>>
>>> Since errp is an &error_fatal, it causes QEMU to exit, so this^ error
>>> message is bogus.
>>>
>>>>>
>>>>> The qemu parameters I used prior to this patch that allowed an SNP 
>>>>> guest
>>>>> to launch were:
>>>>>
>>>>> -machine type=q35,confidential-guest-support=sev0,memory-backend=ram1
>>>>> -object memory-backend- 
>>>>> memfd,id=ram1,size=16G,share=true,prealloc=false
>>>>>
>>>>> With these parameters after this patch, the launch fails.
>>>>
>>>> I think it might be failing because the caller of
>>>> ram_block_add_cpr_blocker() is passing in &error_abort, but if the
>>>> error_setg() is call on a properly initialized cpr_blocker value then
>>>> SNP is still able to boot for me.
>>>> I'm not sure where the best spot is
>>>> to initialize cpr_blocker, it probably needs to be done before either
>>>> ram_block_add_cpr_blocker() or ram_block_del_cpr_blocker() are 
>>>> callable,
>>>> but the following avoids the reported crash at least:
>>>>
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index 44dd129662..bff0fdcaac 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -4176,6 +4176,7 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, 
>>>> Error **errp)
>>>>           return;
>>>>       }
>>>>
>>>> +    rb->cpr_blocker = NULL;
>>>
>>> Could it be the cpr_blocker already got set at ram_block_add() in the
>>> RAM_GUEST_MEMFD path?
>>
>> That seems to be the case: in some cases ram_block_add() sets cpr_blocker
>> when (new_block->flags & RAM_GUEST_MEMFD) is true, and then soon after
>> when ram_block_add_cpr_blocker() is called on the same RAMBlock:
>>
>>    2025-03-26T21:08:15.092427Z qemu-system-x86_64: warning: 
>> ram_block_add: new_block 0x55c247e4c880 new_block->cpr_blocker (nil) 
>> name ram1
>>    2025-03-26T21:08:15.124710Z qemu-system-x86_64: warning: 
>> ram_block_add: new_block 0x55c2480fde00 new_block->cpr_blocker (nil) 
>> name pc.bios
>>    2025-03-26T21:08:15.126190Z qemu-system-x86_64: warning: 
>> ram_block_add_cpr_blocker: rb 0x55c2480fde00 rb->cpr_blocker 
>> 0x55c2480fe050 name pc.bios
>>    2025-03-26T21:08:15.138582Z qemu-system-x86_64: warning: 
>> ram_block_add: new_block 0x55c247e3c1e0 new_block->cpr_blocker (nil) 
>> name pc.rom
>>    2025-03-26T21:08:15.138938Z qemu-system-x86_64: warning: 
>> ram_block_add_cpr_blocker: rb 0x55c247e3c1e0 rb->cpr_blocker 
>> 0x55c247e3c890 name pc.rom
>>    2025-03-26T21:08:16.185577Z qemu-system-x86_64: warning: 
>> ram_block_add_cpr_blocker: rb 0x55c248db9200 rb->cpr_blocker (nil) 
>> name /rom@etc/acpi/tables
>>    2025-03-26T21:08:16.187140Z qemu-system-x86_64: warning: 
>> ram_block_add_cpr_blocker: rb 0x55c248085620 rb->cpr_blocker (nil) 
>> name /rom@etc/table-loader
>>    2025-03-26T21:08:16.188029Z qemu-system-x86_64: warning: 
>> ram_block_add_cpr_blocker: rb 0x55c2480ce220 rb->cpr_blocker (nil) 
>> name /rom@etc/acpi/rsd
> 
> Thanks everyone for debugging this.  To summarize, 
> ram_block_add_cpr_blocker already blocks
> guest_memfd, because rb->fd < 0.  The fix is to delete this redundant 
> code in ram_block_add:
> 
>          error_setg(&new_block->cpr_blocker,
>                     "Memory region %s uses guest_memfd, "
>                     "which is not supported with CPR.",
>                     memory_region_name(new_block->mr));
>          migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>                                    MIG_MODE_CPR_TRANSFER, 
> MIG_MODE_CPR_EXEC,
>                                    -1);

I just encountered the same issue with TDX guest, after rebasing TDX 
code to 10.0.0-rc0.

thank you all for the reporting and quick solution for it.

> I will submit a fix (unless Tom or Michael would prefer to author it).
> 
> - Steve
> 


