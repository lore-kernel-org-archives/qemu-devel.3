Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC55BC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtas-000304-97; Tue, 25 Feb 2025 06:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmtaq-0002zs-U3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:59:20 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tmtan-0006DK-W4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740484758; x=1772020758;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mA6pHmi/N+Ky9+mjncvYzVZG397aZLL5f2QGdgF5e7A=;
 b=Ze+HKfPc4tyfyLChoDYEjlIUx6sYIKQnPpma6M50bMDPSteG9+TSJEsY
 nHkutdMr2zJSQghRLD0zt+vCK/UPot+1S9KIdxWsmC8kyUKWk86ZUoGi3
 jMq7udffNSvPa78ewV2PP13NNotIf9z44YRB/RLVm91AZxa1hHfPsbmEJ
 VcloFdarzsIxX8OKi76Vsj8QE80mnU+YE9mRNwqcACYnZowoBPJhE1760
 UiQmaiyDHncn9h2NIAFYqPW7xRbVeup5evJg2o/vdbj7SNVgBxr0yfS5n
 A1GK5IjFeoHiujA2k/KRXnSU/UKjuEGlxOcAx6HJR1NmXQoEhDIBtg5hm g==;
X-CSE-ConnectionGUID: Wd1kDq5uRrGFjLOhAgkZ4w==
X-CSE-MsgGUID: Mi9ORtPjQT635E+HymE2zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52283442"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="52283442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 03:59:14 -0800
X-CSE-ConnectionGUID: fNFZR8OlRwmvMiuJ5BAJSQ==
X-CSE-MsgGUID: Pn2KFix6RoWQfI5zatZD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="116855098"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 03:59:10 -0800
Message-ID: <d21b66b9-2334-42fc-8087-37667bceba99@intel.com>
Date: Tue, 25 Feb 2025 19:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/52] i386/tdvf: Introduce function to parse TDVF
 metadata
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
 <20250124132048.3229049-17-xiaoyao.li@intel.com>
 <7e8ef2dc3958bf9ea68ac3feb68fc216a9107411.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <7e8ef2dc3958bf9ea68ac3feb68fc216a9107411.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
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

On 2/19/2025 6:58 PM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> +int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size)
>> +{
>> +    g_autofree TdvfSectionEntry *sections = NULL;
>> +    TdvfMetadata *metadata;
>> +    ssize_t entries_size;
>> +    int i;
>> +
>> +    metadata = tdvf_get_metadata(flash_ptr, size);
>> +    if (!metadata) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* load and parse metadata entries */
>> +    fw->nr_entries = le32_to_cpu(metadata->NumberOfSectionEntries);
>> +    if (fw->nr_entries < 2) {
>> +        error_report("Invalid number of fw entries (%u) in TDVF
>> Metadata",
>> +                     fw->nr_entries);
>> +        return -EINVAL;
>> +    }
>> +
>> +    entries_size = fw->nr_entries * sizeof(TdvfSectionEntry);
>> +    if (metadata->Length != sizeof(*metadata) + entries_size) {
>> +        error_report("TDVF metadata len (0x%x) mismatch, expected
>> (0x%x)",
>> +                     metadata->Length,
>> +                     (uint32_t)(sizeof(*metadata) + entries_size));
>> +        return -EINVAL;
>> +    }
>> +
>> +    fw->entries = g_new(TdxFirmwareEntry, fw->nr_entries);
>> +    sections = g_new(TdvfSectionEntry, fw->nr_entries);
>> +
>> +    if (!memcpy(sections, (void *)metadata + sizeof(*metadata),
>> entries_size)) {
>> +        error_report("Failed to read TDVF section entries");
> 
> memcpy() cannot fail...
> 

you are right. I will delete the error handling.

