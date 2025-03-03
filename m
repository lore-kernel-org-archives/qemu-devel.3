Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039A5C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp76l-00015R-Qi; Mon, 03 Mar 2025 09:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp76Y-0000zx-1Z; Mon, 03 Mar 2025 09:49:15 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp76W-0005vR-0j; Mon, 03 Mar 2025 09:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741013352; x=1772549352;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O7ctNZ99KgdIH9KEiEuaq/SzsbcgsGxJdiMIHhbT1bQ=;
 b=dL6zTA2MwffsiaO9KrEBzVXgqLfTa60ZReDlA5yjptA3oGIjl2h3g7vt
 KITLAgg2XhakHeR/30mG9+8Y/ZrVK9jVItP4SvCEo/tcvDMs1LcXox+wk
 pjk3oL52PJLT4V+AxCy+3JB1OgqiRKQvtTT095QNdj9/ICdmzXL54wCNQ
 IulJeBqwAkeZ4RnA0RwrPq+DXQKjelXJEjYmvk6VCf4D6Tg0U3YEir+vt
 b0yFkOhJf94h5pI0eLTUDK/bXvIb3qtOS/SXveYC31HuMElI3MzoDnHTs
 kif5GI5unMhR0ZQ6k04lBXzCfgGZltWCwrLHnCVv5wnpWr9lr1Wi/6vNe g==;
X-CSE-ConnectionGUID: aiHKn8rVQwa5Sb1BBKctPw==
X-CSE-MsgGUID: 8XTTbEgPTPmzfzjIQomjXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52096071"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="52096071"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 06:49:08 -0800
X-CSE-ConnectionGUID: wU6T4iQzS7+mDegT3ynaCQ==
X-CSE-MsgGUID: v9+S4PomQriCODMb/5dujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="118535305"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 06:49:06 -0800
Date: Mon, 3 Mar 2025 23:09:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/12] rust: hpet: do not access fields of SysBusDevice
Message-ID: <Z8XGGYy2OJ5ZupzU@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Feb 27, 2025 at 03:22:15PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/12] rust: hpet: do not access fields of SysBusDevice
> X-Mailer: git-send-email 2.48.1
> 
> Fields of SysBusDevice must only be accessed with the BQL taken.  Add
> a wrapper that verifies that.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/hpet.rs |  4 +---
>  rust/qemu-api/src/sysbus.rs    | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


