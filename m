Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHya-0007pP-OB; Fri, 09 Aug 2024 01:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scHyY-0007nN-II; Fri, 09 Aug 2024 01:15:42 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scHyW-0003Vw-8y; Fri, 09 Aug 2024 01:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723180541; x=1754716541;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7zC5X+3wT/YG6YfO3WL6oaU7GpvFEdfjp8clX6chuQw=;
 b=MaYospsUGNAd0n0epyAl8uHRmJUAFahRpjsaQYsALCE5dyNVj/kIU7X0
 6tzlK8Zxz3YObvMoQo4QwR7j7oERIdweZKfYmFICQ66I65rmm0wtJ5PfI
 tLEPF6/kqevP7O/ISRMw1KBHZW0YyHqKXlItiVukjtcJq3SSdAnpISlP5
 ImwAPUVsXuZtQY03K/hP1tbfNazCO9wlIREqVoNa0Y6rGw+zrhzSce5DC
 XNLL6NT1jfNrvuLhHu6yxtAJI3HoKGYC3AxzBgTjslICWWREc5a/1xg9j
 ISG/ZXsNwAPPh3nY7sbct2MdEebnVA1Qs/8obVs3TxnQhcb9E+hc7mnDj w==;
X-CSE-ConnectionGUID: Ny/m3lXyRtazZELlZKSnIQ==
X-CSE-MsgGUID: u7hFZhTUT02OMVajaCUAzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21312496"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="21312496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 22:15:37 -0700
X-CSE-ConnectionGUID: yV7O915vSnSqhBA9FQMAoQ==
X-CSE-MsgGUID: s+CAelOOQNCcrseZoelePA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="62095893"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 22:15:34 -0700
Date: Fri, 9 Aug 2024 13:31:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, cfontana@suse.de,
 qemu-trivial@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] kvm: refactor core virtual machine creation into
 its own function
Message-ID: <ZrWprIS6gFhCQFjR@intel.com>
References: <20240809051054.1745641-1-anisinha@redhat.com>
 <20240809051054.1745641-3-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809051054.1745641-3-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, Aug 09, 2024 at 10:40:54AM +0530, Ani Sinha wrote:
> Date: Fri,  9 Aug 2024 10:40:54 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v3 2/2] kvm: refactor core virtual machine creation into
>  its own function
> X-Mailer: git-send-email 2.45.2
> 
> Refactoring the core logic around KVM_CREATE_VM into its own separate function
> so that it can be called from other functions in subsequent patches. There is
> no functional change in this patch.
> 
> CC: pbonzini@redhat.com
> CC: zhao1.liu@intel.com
> CC: cfontana@suse.de
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 86 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 33 deletions(-)
> 
> changelog:
> v2: s/fprintf/warn_report as suggested by zhao
> v3: s/warn_report/error_report. function names adjusted to conform to
> other names. fprintf -> error_report() moved to its own patch.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


