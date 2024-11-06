Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C4D3E781
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 01:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8V0Q-0005Zg-5L; Tue, 05 Nov 2024 20:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8V0N-0005ZI-N4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 20:38:43 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8V0K-0004MZ-Vl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 20:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730857121; x=1762393121;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tPRFNaKPEicvx6Pu2FMYGhCu8omtRaZM7BmqKmrKu/A=;
 b=CT5ZMF7M6Qcm+Wn1I2HuNGFsKyMo/Lx/hINTJT45K01OZDhzMNkVWiA1
 nVLXiW+DBh/q7rfyT3EKXf7IUiKkEPC1aBf5HeAe/uc1iiQCVb0Ezl1CH
 LWkUpg7kWR9JYHj6hQlx3dkPAVJAnKRz2D3KhN8bo5uXTQpEiMPyjl6so
 y3izDAvLxrJPzZhS9MF+oAHYTUnVRax8AdGI/q0FnT+1bUWtxk0vQDSs2
 ZiZn3sF2XuwYRkK3Aoh8kFbZ/1oP8Nn/WsxAvINw6aGeFRKnzh4PmqpnI
 9iobg2fIcXsxXHUNbfMRhWSDclg33JZ15870/SAKf9WbKaLRgztD1jjOQ g==;
X-CSE-ConnectionGUID: sRQ1FtpiTF6V89YzMbM40w==
X-CSE-MsgGUID: ln/QuXkpSXqqoyJ1PufZiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30752124"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="30752124"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 17:38:38 -0800
X-CSE-ConnectionGUID: VtImLotQSI2a516wWfDHcg==
X-CSE-MsgGUID: IzcenzUFR1ih90v0KRtW4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="88815774"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 17:38:32 -0800
Message-ID: <4b28eb7d-e600-4e83-b067-7f4f52691564@intel.com>
Date: Wed, 6 Nov 2024 09:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/60] i386/tdx: Validate TD attributes
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-14-xiaoyao.li@intel.com>
 <1e6cd4c21496452c7dae254ae80fe16a712d0d21.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <1e6cd4c21496452c7dae254ae80fe16a712d0d21.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/6/2024 4:56 AM, Edgecombe, Rick P wrote:
> On Tue, 2024-11-05 at 01:23 -0500, Xiaoyao Li wrote:
>> -static void setup_td_guest_attributes(X86CPU *x86cpu)
>> +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>> +{
>> +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
>> +            error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
>> +                       "(supported: 0x%llx)",
>> +                       tdx->attributes, tdx_caps->supported_attrs);
>> +            return -1;
>> +    }
>> +
>> +    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
> 
> What is going on here? It doesn't look like debug attribute could be set in this
> series, so this is dead code I guess. If there is some concern that attributes
> that need extra qemu support could be set in QEMU somehow, it would be better to
> have a mask of qemu supported attributes and reject any not in the mask.

Good catch and good idea!

Will maintain a mask of supported attributes in QEMU.

>> +        error_setg(errp, "Current QEMU doesn't support attributes.debug[bit 0] "
>> +                         "for TDX VM");
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
> 


