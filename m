Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72610C3ABB6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZMv-0007TJ-UD; Wed, 07 May 2025 03:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCZMo-0007Sr-QY; Wed, 07 May 2025 03:38:59 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCZMm-00088O-1z; Wed, 07 May 2025 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746603536; x=1778139536;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eSdAWIL9QwmGd2sJcWiQDIS/aNUqKJGlmNZtHMw8g5g=;
 b=PjFvk4CKgUyJkT6eqcoy+kfMOBc7RoxGWQ3ypEAOQJkODpQsd3AAk0Cv
 FLoxWI1NsuAX4eA7kpPy9KT3AzuZegPgwlSwj0w8Q0ebRXIqNBJIEM6VZ
 wwi9Thyq6Cxm0FKSAiaVaQ/tjbKbwL5aU4cPCoofIWt0zJBoDFmMdgita
 Urjl+5GzoXFf52U4gjUZ1UPv8FGuQdC3nDbeA+rrFL6Yhqf+9qopy52rR
 asHRSDbwIbY2lFt09BEaa7I59bJ1Bje5EVelSx6wwoTJlx/ocRi5S93AA
 L5S+ysV/3yLRpyjlh6wYCRBGzIzsuXwfUMn0gOslqfDGgJg/ASB94mBC5 g==;
X-CSE-ConnectionGUID: PrrHvwzsT6uKSjKHjlmtgw==
X-CSE-MsgGUID: p0Vb9M46QV+EyHXV43bHpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="65724608"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="65724608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 00:38:51 -0700
X-CSE-ConnectionGUID: 5xgkbUMWSYuibA6qZJP28Q==
X-CSE-MsgGUID: 26B2PJQ8SJW4mYmpQm993A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="136880282"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 07 May 2025 00:38:48 -0700
Date: Wed, 7 May 2025 15:59:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/5] rust: vmstate: use const_refs_to_static
Message-ID: <aBsS9tmqold+tMMu@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <20250505100854.73936-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505100854.73936-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> @@ -998,7 +1000,7 @@ impl ObjectImpl for HPETState {
>              vmstate_of!(HPETState, counter),
>              vmstate_of!(HPETState, num_timers_save).with_version_id(2),
>              vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> -            vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
> +            vmstate_of!(HPETState, timers[0 .. num_timers], HPETState::validate_num_timers).with_version_id(0),
>          })

The unified vmstate_of is indeed clean... it's more concise and easier
to use than the C version.


