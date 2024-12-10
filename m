Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41A3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKvLZ-00059f-Kb; Tue, 10 Dec 2024 03:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvLX-000590-F5; Tue, 10 Dec 2024 03:11:55 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKvLV-0008UF-Bo; Tue, 10 Dec 2024 03:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733818313; x=1765354313;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5qTREOy0DpDU9zBX9wf5A2kBg0ceeViG7NTwjPSpy40=;
 b=c/YGueUnda3nbTUfZbddzkcYEpkOHN+lFaqXlF6Q79K8UyF9Nt3+6HhZ
 UshzrZTF4TKOxE+WgMmBesLWbQau2eaDIaVZoVQ7fAkZTAc5QizhfF8c1
 OI93/zgo5OBea9cQ573g1Ki0ROaHHhJxYPUtl2H0hmPA3IrVFvl5F5K02
 Z32rmLhFW88kzlfkoeir3BZuNzEbeMLqnOtqgUt77wj24W+pZN0pkfaen
 smSjU/YTsvqx/egMYV3iy4RywEeU1vy+5hM6whe0DFFV3RRUyVqge4mgw
 kyYwrxu4FIDnIKujcrLsAh0C5PFT4MBCLA7RN2ilAKbNiEnRRJgoomXr0 w==;
X-CSE-ConnectionGUID: cyxLvl+uRNSFzdfqY7syYQ==
X-CSE-MsgGUID: bUHFxajRT0KjVFNXDai0Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33485174"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="33485174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 00:11:50 -0800
X-CSE-ConnectionGUID: Bg7PaFxgQlCLhlCGFXFTcw==
X-CSE-MsgGUID: RSarD+71RgKz6QsaUQ0Z2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="95780453"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 00:11:49 -0800
Date: Tue, 10 Dec 2024 16:30:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 09/26] rust: qom: convert type_info! macro to an
 associated const
Message-ID: <Z1f8C2OSKet+c+jo@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Dec 09, 2024 at 01:37:00PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:00 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/26] rust: qom: convert type_info! macro to an associated
>  const
> X-Mailer: git-send-email 2.47.1
> 
> type_info! is only used in the definition of ObjectImpl::TYPE_INFO, and
> in fact in all of them.  Pull type_info!'s definition into the ObjectImpl
> trait, thus simplifying the external interface of qemu_api::definitions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  6 ++--
>  rust/qemu-api/src/definitions.rs | 50 ++++++++++++++------------------
>  rust/qemu-api/tests/tests.rs     |  1 -
>  3 files changed, 24 insertions(+), 33 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


