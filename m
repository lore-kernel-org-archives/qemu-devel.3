Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91631C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDOn-00011W-2V; Wed, 26 Feb 2025 04:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnDOd-0000uw-9z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:08:03 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnDOa-00012z-9C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740560880; x=1772096880;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Q7yrOEWZYBO+5YQiQdQ8RxUY22I2+Us/YMUUugFJp8c=;
 b=F7zZjL5grU8JjQitYCATg40cOx9zwQCi5dPsmo7KFwJn1EGUTN6su0zU
 xUGt01TGUD3jL/cnjO+MhiGIAivnll5/G/L9UGBcf2ni7xigUzLwdTa9/
 hmowBzyQ9o5Kxan+hgeRBCzWRWjiuLMHsezHpCrJ9+NhhFwIglNTaHxTA
 K1zLIO/X5gpaQbSkycFfB2C6MRSTYRyr7EmYj/GCgHshuEamN5Ff8gLSc
 wUBbTMAp6zTrVLjoeji0bkEut/O9DjfyQavxSDXav3m7aBJT9x3QSILhA
 1uSHJS7mw10iohukXNQo/bLm8M8oeR/Jycd2bnSBoPzfPDvNTzRZOhWmS A==;
X-CSE-ConnectionGUID: /2NGfaR2TuKzphxg3S6XeQ==
X-CSE-MsgGUID: vBab6GPGQreYopGkdScG5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66768418"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="66768418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:07:55 -0800
X-CSE-ConnectionGUID: 550GVI5VSQe9bhVGUE8jjw==
X-CSE-MsgGUID: kleEU+83RlSJNtU1iEbc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147557391"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:07:50 -0800
Message-ID: <3f62c928-d9ee-4ffc-b54d-17e24c943d2d@intel.com>
Date: Wed, 26 Feb 2025 17:07:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/52] i386/tdx: Track mem_ptr for each firmware entry
 of TDVF
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-20-xiaoyao.li@intel.com>
 <71f051114ab5db2a94506b4d8768ebfa79033590.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <71f051114ab5db2a94506b4d8768ebfa79033590.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/2025 7:26 PM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> +static void tdx_finalize_vm(Notifier *notifier, void *unused)
>> +{
>> +    TdxFirmware *tdvf = &tdx_guest->tdvf;
>> +    TdxFirmwareEntry *entry;
>> +
>> +    for_each_tdx_fw_entry(tdvf, entry) {
>> +        switch (entry->type) {
>> +        case TDVF_SECTION_TYPE_BFV:
>> +        case TDVF_SECTION_TYPE_CFV:
>> +            entry->mem_ptr = tdvf->mem_ptr + entry->data_offset;
>> +            break;
>> +        case TDVF_SECTION_TYPE_TD_HOB:
>> +        case TDVF_SECTION_TYPE_TEMP_MEM:
>> +            entry->mem_ptr = qemu_ram_mmap(-1, entry->size,
>> +
>> qemu_real_host_page_size(), 0, 0);
>> +            break;
> 
> Should check for MAP_FAILED return value.

will add the check for it.

>> +        default:
>> +            error_report("Unsupported TDVF section %d", entry-
>>> type);
>> +            exit(1);
> 
> Section entry types have already been checked against valid types in
> tdvf_parse_and_check_section_entry(), no need to check them again here.

I would rather keep it. It does no harm and I help catch issue when 
people adds new type in tdvf_parse_and_check_section_entry but miss this 
place.


