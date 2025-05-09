Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F642C3ABCD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOJv-0000j6-74; Fri, 09 May 2025 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJ0D-0007w6-D3
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:22:41 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJ08-0003EN-Tz
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746778957; x=1778314957;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SDNBjb+qiPvs2UiFTyIhfPnnekIonyXpduju49LT/Pw=;
 b=NuvxXP/Bvwg8g5I/78JNqXQ4gtqIvh+x6RUyeWa4J6ssxaSfAlqRzZyI
 Oo1NmXchdItuDjr1aiQ9fk6pJOtDGYO75KTViwEv3JPRTfhKdLGvFFKFC
 L53wGBqfzF6pcLyTOyBmHghkQ2lkaNgrErL3Lavho3DtilOe9uFvh4UG5
 TA155Do3bNZQuAiYxsl19TWzYcoJU4BI8ZmzNOWnnl5ZDcGElCg/i4DD+
 hnfJToKH3juAkWg2aWue8cf1/9i/J0dWCnWDZslkUlmIEU1HkNrWkB9sj
 iWat3SPMnODliCmhatL1G7kmtgiTdMZf1IM69sllbX1zOTKOYxAMbrqQQ g==;
X-CSE-ConnectionGUID: j9j7IK8bSpKlX3Yy/5BXrw==
X-CSE-MsgGUID: WEW4MdfSSyq2NkBAcbw+2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48712574"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48712574"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 01:22:33 -0700
X-CSE-ConnectionGUID: qsKt87K1SCG8SqsIHY3Nxg==
X-CSE-MsgGUID: HTL3M13/QR6TTJpBH2OU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="167627611"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.236])
 ([10.124.240.236])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 01:22:29 -0700
Message-ID: <5fcf90b9-dff5-466c-9be5-2b6571a5de8a@linux.intel.com>
Date: Fri, 9 May 2025 16:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 10/13] memory: Change NotifyStateClear() definition to
 return the result
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-11-chenyi.qiang@intel.com>
 <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.14;
 envelope-from=baolu.lu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 May 2025 10:03:20 -0400
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

On 4/27/2025 10:26 AM, Chenyi Qiang wrote:
> Hi David,
> 
> Any thought on patch 10-12, which is to move the change attribute into a
> priority listener. A problem is how to handle the error handling of
> private_to_shared failure. Previously, we thought it would never be able
> to fail, but right now, it is possible in corner cases (e.g. -ENOMEM) in
> set_attribute_private(). At present, I simply raise an assert instead of
> adding any rollback work (see patch 11).

Do the pages need to be pinned when converting them to a shared state
and unpinned when converting to a private state? Or is this handled
within the vfio_state_change_notify callbacks?

Thanks,
baolu

