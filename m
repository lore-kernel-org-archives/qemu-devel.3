Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CDEC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJp1d-0007wO-C4; Tue, 27 May 2025 03:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJp1O-0007lm-LK
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:46:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJp1H-0000mm-PZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748332004; x=1779868004;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cEjFSRnWVOH0cGVQ0RLmdZ0wEGxA0UKaZ7R4hsYDsYY=;
 b=mLDLZOuF3wlQIGShXaw+ONiGIrvwZewsmJyB7+epLYW95v/b/IjPQAc2
 Wrr+8bAuCXro3MJoBr7/tZqlEnlNZZWu/nsz4JsovLGA/ND+0koZWzBDN
 5D6En1D4vGBoO+9+3YnALs1vU0Ex/wVEGnw7D0iKQz+9zUun7nc9iL1hI
 +ohdmV5LWKuNAmdyaD59nIl3QWXc6aQC+U2uO8borfnUOm3EJP0KKkJPh
 IFiujOsLMA4jjXEmEs0GlqNYKdXNfZw/ZGSF9KNDvRVSpMsnJZy2/7UbT
 4kKjQky5P+I/S/hFTN+Z7UAIpJg92gqin6RQiStgQantDUnEMSkw2QZ5C A==;
X-CSE-ConnectionGUID: gAznJe1+SQO2h4fImU9JuA==
X-CSE-MsgGUID: /BDHhUzfT7ST25qstzOn3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50364148"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="50364148"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 00:46:35 -0700
X-CSE-ConnectionGUID: MF9XvEomSWiJ9jyiC06rHg==
X-CSE-MsgGUID: 7UbHPX81RV+hsSUWwlGklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="147967249"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 00:46:32 -0700
Message-ID: <814eb9a8-3628-4151-81d4-63ac6c445f81@intel.com>
Date: Tue, 27 May 2025 15:46:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/55] QEMU TDX support
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
 <e994b189-d155-44d0-ae7d-78e72f3ae0de@redhat.com>
 <792cbff4-6d25-4f39-8a18-3f7affdfe5cd@intel.com>
 <87a56ywucx.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87a56ywucx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/27/2025 12:27 PM, Markus Armbruster wrote:
> Xiaoyao Li<xiaoyao.li@intel.com> writes:
> 
>> On 5/27/2025 12:12 AM, Paolo Bonzini wrote:
>>> On 5/8/25 16:59, Xiaoyao Li wrote:
>>>> This is the v9 series of TDX QEMU enabling. The series is also available
>>>> at github:
>>>> https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v9
>>>>
>>>> Note, this series has a dependency on
>>>> https://lore.kernel.org/qemu-devel/20241217123932.948789-1-xiaoyao.li@intel.com/
>>>>
>>>> =============
>>>> Changes in v9
>>>>
>>>> Comparing to v8, no big change in v9.
>>>>
>>>> V9 mainly collects Reviewed-by tags from Daniel and Zhao Liu (Thanks to
>>>> their review!) and v9 does some small change according to the review
>>>> feedback of them. Please see the individual patch for the detailed
>>>> change history.
>>> Queued, thanks for your patience - this was a huge effort.
> Started late fall 2023?  That's perseverance!

The RFC v1 was posted Feb 2021 actually.

https://lore.kernel.org/qemu-devel/cover.1613188118.git.isaku.yamahata@intel.com/

