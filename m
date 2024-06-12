Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD8CC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHKDO-00014g-BZ; Wed, 12 Jun 2024 05:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHKDM-00014Y-Uz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:24:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHKDL-00022j-6Z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718184259; x=1749720259;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ytPB7o3sNt3WkmYesD0N7871LrdUiavykFcGUZgCd3s=;
 b=JP1Ld7ijsXZFrEE9DxG6CluScYjbn6xjtxWovKsdlKXkPc4mRybmdq0f
 Mz4FR9DPveTUqpVi6rhVc9nH+R2kw+FKTOGO5j0WOWkgJvnA6u9UoD2hA
 z+iK9LwenQknf2Zdw5Vxx1QEt/GMp0TBgvhcXL7VzdorRjT6yR1ROj22Y
 R5xDhjKKByQnoKKKR7pQjOClfYDT5BUtmVmVuatp74HlATINPmncdhcbZ
 KiMG3DhuSpNtRlfFSlvXlWV58kDdYHGBArFSYskxq3r99/Hl9ka4J7Hlr
 RYNF6F3HzAvb5GtWNzqmMvUuIanMlSA6VxH5yxYTMileWFnoGT0mY1N4t Q==;
X-CSE-ConnectionGUID: oMMHaSP5TOmRALNJm9DEpw==
X-CSE-MsgGUID: Z4+MdQ7cTY+39f348+OBNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14732146"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; d="scan'208";a="14732146"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 02:24:17 -0700
X-CSE-ConnectionGUID: SWx+sngdQ7iyekGkwC68SA==
X-CSE-MsgGUID: bBfcdBtsTui+Tf8O3iArZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; d="scan'208";a="39839863"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 02:24:11 -0700
Message-ID: <3315d483-cdc0-44cd-af56-9fee612de054@intel.com>
Date: Wed, 12 Jun 2024 17:24:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/65] i386/tdx: Make Intel-PT unsupported for TD guest
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-19-xiaoyao.li@intel.com>
 <59fec569-95e1-9024-77fb-b6d2f89b3951@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <59fec569-95e1-9024-77fb-b6d2f89b3951@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/31/2024 5:27 PM, Duan, Zhenzhong wrote:
> 
> On 2/29/2024 2:36 PM, Xiaoyao Li wrote:
>> Due to the fact that Intel-PT virtualization support has been broken in
>> QEMU since Sapphire Rapids generation[1], below warning is triggered when
>> luanching TD guest:
>>
>>    warning: host doesn't support requested feature: 
>> CPUID.07H:EBX.intel-pt [bit 25]
>>
>> Before Intel-pt is fixed in QEMU, just make Intel-PT unsupported for TD
>> guest, to avoid the confusing warning.
> 
> I guess normal guest has same issue.

yeah, just the bug referenced by [1]

> Thanks
> 
> Zhenzhong
> 
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/20230531084311.3807277-1-xiaoyao.li@intel.com/
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v4:
>>   - newly added patch;
>> ---
>>   target/i386/kvm/tdx.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 85d96140b450..239170142e4f 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -292,6 +292,11 @@ void tdx_get_supported_cpuid(uint32_t function, 
>> uint32_t index, int reg,
>>       if (function == 1 && reg == R_ECX && !enable_cpu_pm) {
>>           *ret &= ~CPUID_EXT_MONITOR;
>>       }
>> +
>> +    /* QEMU Intel-pt support is broken, don't advertise Intel-PT */
>> +    if (function == 7 && reg == R_EBX) {
>> +        *ret &= ~CPUID_7_0_EBX_INTEL_PT;
>> +    }
>>   }
>>   enum tdx_ioctl_level{


