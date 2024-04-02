Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AF2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre3a-000205-NM; Tue, 02 Apr 2024 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rre2s-0000B3-4L
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:19:22 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rre2O-0007jp-51
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712063932; x=1743599932;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TicA9JtKJDtY9u7ZOqgBDEcVkJUfXrxPSCy/0YxEBus=;
 b=TZdwEZrkyWl/6Dlg9bDlqZVBbEN2nPOrB7GLKsilSe6YdtynY/2AP4AB
 BCkM+glsGvmbg53JAAfj2ycEeulSUbs6pCVjNn55nhbQdeTjOdYAkGAHd
 lYgrfD6ez1mCGNoCv0dcsfHkRyv9sGkaygLr2C1Iu7vyytzoRre3NKyKK
 0cVHiXrvT+G9VP8SwsN2Ivme5QDCjJQFHChtKSJQprgyEXA+fxnMe+wC4
 3VYngU6q71Rx6jDAcxrs+W0oNQSNlV6xPEH+RGW/XmRnQJIrDluxiPe7R
 +e2nJU1oiZAtOnh8ErfHJRJNPNvA5VsjgyALUxn7uIp8W0sRSQyGlyo5/ w==;
X-CSE-ConnectionGUID: 3/e7it+LRwi+jcXI0WeCiQ==
X-CSE-MsgGUID: 7P5hRb6+TxOPQlNmdEW8Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10195280"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; d="scan'208";a="10195280"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 06:18:49 -0700
X-CSE-ConnectionGUID: XzZmgIRPTN+nLK4v7qQO5A==
X-CSE-MsgGUID: f/xrU3rgTcyjypc/nLFJEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; d="scan'208";a="18097635"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 06:18:47 -0700
Message-ID: <d3a3c9bc-a783-4293-bd1b-b00135ec2685@intel.com>
Date: Tue, 2 Apr 2024 21:18:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com
References: <20240402082516.2921143-1-xiaoyao.li@intel.com>
 <20240402060109-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240402060109-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
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

On 4/2/2024 6:02 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 02, 2024 at 04:25:16AM -0400, Xiaoyao Li wrote:
>> Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Please include more info in the commit log:
> what is the behaviour you observe, why it is wrong,
> how does the patch fix it, what is guest behaviour
> before and after.

Sorry, I thought it was straightforward.

A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system 
also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.

When PIC is not enabled for x86 machine, the PCAT_COMPAT bit needs to be 
cleared. Otherwise, the guest thinks there is a present PIC even it is 
booted with pic=off on QEMU.

(I haven't seen real issue from Linux guest. The user of PIC inside 
guest seems only the pit calibration. Whether pit calibration is 
triggered depends on other things. But logically, current code is wrong, 
we need to fix it anyway.

@Isaku, please share more info if you have)


> The commit log and the subject should not repeat
> what the diff already states.
> 
>> ---
>>   hw/i386/acpi-common.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
>> index 20f19269da40..0cc2919bb851 100644
>> --- a/hw/i386/acpi-common.c
>> +++ b/hw/i386/acpi-common.c
>> @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>>       acpi_table_begin(&table, table_data);
>>       /* Local APIC Address */
>>       build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
>> -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>> +    /* Flags. bit 0: PCAT_COMPAT */
>> +    build_append_int_noprefix(table_data,
>> +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
>>   
>>       for (i = 0; i < apic_ids->len; i++) {
>>           pc_madt_cpu_entry(i, apic_ids, table_data, false);
>> -- 
>> 2.34.1
> 


