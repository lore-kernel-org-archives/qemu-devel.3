Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35780C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 06:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6yd-0007tC-4N; Fri, 11 Jul 2025 02:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua6yY-0007pq-4C
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:11:14 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua6yT-0006hi-0Y
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752214269; x=1783750269;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qxXkCtpl/y24sU1FPu+473TDguqLVckNPEcZqd/MSDI=;
 b=YexHs1EffSYxz9IFnSC45YB29gMGPh2oNY8Fpu9qtvp3Lng2dwEZy/Wy
 XmwsK8HrstfsxDXzVRLkbP9OvXlGrj+EfU88azdWvkqSPpIGb0aSDeSMf
 1T6KAyetmoUnviTYN3XVIyBPlBmAmcckK3fiadeBXKR1xlYocbdVYNLJn
 R05SBMnOjlR9s96Zthdzv/KaRl9smzNLBcD7n521rDBii2SJwmFkvvoD6
 /hTFSygC3xzGwO8ROVDHz5yUi6I+TpC/eZZNx1YEoMFx7KS26WWOqVKM4
 VKbYaLhhuzo75UuTKgqeNJHSsjprE2mO0Pwbn2KHUEbxn/0/nc89VHXvO g==;
X-CSE-ConnectionGUID: ib+TABjwRfeUSHu/G121Pw==
X-CSE-MsgGUID: ZfUqfepcR86058wZxttflA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58315063"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="58315063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 23:11:06 -0700
X-CSE-ConnectionGUID: THfvMRuxTRiXT0lKFU+2hQ==
X-CSE-MsgGUID: WRoqIScbSBySvtLGXtwVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="156377693"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Jul 2025 23:11:04 -0700
Date: Fri, 11 Jul 2025 14:32:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: Re: [PATCH 4/4] target/i386: move accel_cpu_instance_init to
 .instance_init
Message-ID: <aHCwAXmW0De8ptqK@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711000603.438312-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jul 11, 2025 at 02:06:03AM +0200, Paolo Bonzini wrote:
> Date: Fri, 11 Jul 2025 02:06:03 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/4] target/i386: move accel_cpu_instance_init to
>  .instance_init
> X-Mailer: git-send-email 2.50.0
> 
> With the reordering of instance_post_init callbacks that is new in 10.1
> accel_cpu_instance_init must execute in .instance_init as is already
> the case for RISC-V.  Otherwise, for example, setting the vendor
> property is broken when using KVM or Hypervisor.framework, because
> KVM sets it *after* the user's value is set by DeviceState's
> intance_post_init callback.
> 
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>

no, Intel doesn't deserve this credit. Instead, this bug is reported
from these 2 people:

"Like Xu" <like.xu.linux@gmail.com> - KUT Test
"Dongli Zhang" <dongli.zhang@oracle.com> - PMU Fix

For reference: https://lore.kernel.org/qemu-devel/aFpocfTpBLB34N3l@intel.com/

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


