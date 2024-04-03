Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D6CCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 02:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrpyL-0005sU-NH; Tue, 02 Apr 2024 22:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrpyJ-0005sG-QE
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 22:03:28 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrpyH-0007fn-S3
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 22:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712109806; x=1743645806;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7iHKtIRiKXFs+vsKSPtIXoW5MyoEk3UQR3s6pbNxg4g=;
 b=U1pIi3Fn0WWRX5bJMdkSJ2kewhIYZ4BfVKAAjZfal/0PoRWZBUdDLez+
 eksd6ROY9kdF7bZrVibA+aSCkD/G88gF+C6b3AJb0BEGuKscBPwaZhlO/
 9wD0XvWHS3VQhT3QeVhV2J2qK/lAzK6qYLJ5TxRGhIVwZDo4OIXXRaT1y
 AyVb5aLRhw/fIIEbNqt8arOFnp2U/8PjieDpCQVEigfbxBtV+Vci3DgiT
 8iVM8rLA7I4dkAXZHdBHNKHXJUJXo6qDEwxxnWQvs2BVY4oeQC05Z0oKh
 ovxWO7F+QCX3P096CyimSz0KFTm2+6vGDDQrCj6KmjiEt9cGH+qsuZVk6 A==;
X-CSE-ConnectionGUID: ePkpK0UXS+eORr7CzJFN3Q==
X-CSE-MsgGUID: S77zpHcfTDSiSxMl38tl5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17890748"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; d="scan'208";a="17890748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 19:03:21 -0700
X-CSE-ConnectionGUID: g8qWiQYETqyx0rrbCvFLUA==
X-CSE-MsgGUID: gUnChA9gTtmiUYUh4ey6gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; d="scan'208";a="22961919"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 19:03:19 -0700
Message-ID: <f887c77a-bb8c-46cf-aedc-1637bd7ad08e@intel.com>
Date: Wed, 3 Apr 2024 10:03:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com
References: <20240402082516.2921143-1-xiaoyao.li@intel.com>
 <20240402060109-mutt-send-email-mst@kernel.org>
 <d3a3c9bc-a783-4293-bd1b-b00135ec2685@intel.com>
 <20240402103123-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240402103123-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/2/2024 10:31 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 02, 2024 at 09:18:44PM +0800, Xiaoyao Li wrote:
>> On 4/2/2024 6:02 PM, Michael S. Tsirkin wrote:
>>> On Tue, Apr 02, 2024 at 04:25:16AM -0400, Xiaoyao Li wrote:
>>>> Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>
>>> Please include more info in the commit log:
>>> what is the behaviour you observe, why it is wrong,
>>> how does the patch fix it, what is guest behaviour
>>> before and after.
>>
>> Sorry, I thought it was straightforward.
>>
>> A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
>> also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.
>>
>> When PIC is not enabled for x86 machine, the PCAT_COMPAT bit needs to be
>> cleared. Otherwise, the guest thinks there is a present PIC even it is
>> booted with pic=off on QEMU.
>>
>> (I haven't seen real issue from Linux guest. The user of PIC inside guest
>> seems only the pit calibration. Whether pit calibration is triggered depends
>> on other things. But logically, current code is wrong, we need to fix it
>> anyway.
>>
>> @Isaku, please share more info if you have)
>>

+ Kirill,

It seems to have issue with legacy irqs with PCAT_COMPAT set 1 while no 
PIC on QEMU side. Kirill, could you elaborate it?

> 
> That's sufficient, thanks! Pls put this in commit log and resubmit.
> 
>>> The commit log and the subject should not repeat
>>> what the diff already states.
>>>
>>>> ---
>>>>    hw/i386/acpi-common.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
>>>> index 20f19269da40..0cc2919bb851 100644
>>>> --- a/hw/i386/acpi-common.c
>>>> +++ b/hw/i386/acpi-common.c
>>>> @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>>>>        acpi_table_begin(&table, table_data);
>>>>        /* Local APIC Address */
>>>>        build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
>>>> -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>>>> +    /* Flags. bit 0: PCAT_COMPAT */
>>>> +    build_append_int_noprefix(table_data,
>>>> +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
>>>>        for (i = 0; i < apic_ids->len; i++) {
>>>>            pc_madt_cpu_entry(i, apic_ids, table_data, false);
>>>> -- 
>>>> 2.34.1
>>>
> 


