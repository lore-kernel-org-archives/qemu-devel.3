Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0960C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 01:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJj9v-0005wx-8s; Mon, 26 May 2025 21:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJj9n-0005w8-FT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 21:31:09 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uJj9l-00085H-7S
 for qemu-devel@nongnu.org; Mon, 26 May 2025 21:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748309465; x=1779845465;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4CHpPyApsEzS/X3qk79JB1N8Nzcn1UsPrbhnlZZ587s=;
 b=Fu67yamH0gdFN9/3RpHcGSgQ9dB0q0aO/ENb+g2ldGyX/dXmEj4lk6Qi
 npqOG6ehof3A5drIFfurdzbjbuSh5tv/Ghv58jdRtyqhd00VlvdyKBbAI
 Ks3Y8CroyGFErkQGOxgHoHCxP2l0Ck+vMfGD5E7LeZTn6mqvF4a06VA9+
 Xn9hLnQOkFu0gS9SgaTkyTzobJJm4fAgvG3bf1Ey/p1/2bEeRkuZS+fKE
 hqbaAACUJDuH6QhZj8OZ0gnYQDgn2g3etz5ITbLfpjL1JjYXyam+7gUHm
 urViChaYSCN46DtYQL7/amm+a51Xr0XeKClPexVe72L3cDtWdf+GXq7m2 w==;
X-CSE-ConnectionGUID: i2BJBbm1Sbu718PBUZqFQw==
X-CSE-MsgGUID: OpX4EnF6RVqdk+2ik0lZpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="75675640"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="75675640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 18:31:00 -0700
X-CSE-ConnectionGUID: qpfWMxfQQ++z01pNUrR2PQ==
X-CSE-MsgGUID: /p9csET5T/e2dticvOWiQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="147347854"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 18:30:57 -0700
Message-ID: <792cbff4-6d25-4f39-8a18-3f7affdfe5cd@intel.com>
Date: Tue, 27 May 2025 09:30:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/55] QEMU TDX support
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
 <e994b189-d155-44d0-ae7d-78e72f3ae0de@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <e994b189-d155-44d0-ae7d-78e72f3ae0de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
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

On 5/27/2025 12:12 AM, Paolo Bonzini wrote:
> On 5/8/25 16:59, Xiaoyao Li wrote:
>> This is the v9 series of TDX QEMU enabling. The series is also available
>> at github:
>> https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v9
>>
>> Note, this series has a dependency on
>> https://lore.kernel.org/qemu-devel/20241217123932.948789-1- 
>> xiaoyao.li@intel.com/
>>
>> =============
>> Changes in v9
>>
>> Comparing to v8, no big change in v9.
>>
>> V9 mainly collects Reviewed-by tags from Daniel and Zhao Liu (Thanks to
>> their review!) and v9 does some small change according to the review
>> feedback of them. Please see the individual patch for the detailed
>> change history.
> 
> Queued, thanks for your patience - this was a huge effort.
> 
> I'll wait until the kernel side is picked up and then send the pull 
> request.

Thanks, Paolo!

And thanks to Gerd Hoffmann, Daniel, Markus, Zhao Liu, ... and all the 
people who helped review and provided valuable feedback.

> Paolo
> 


