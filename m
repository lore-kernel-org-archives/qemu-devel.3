Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D7BE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 14:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUnr6-0003jv-DD; Mon, 06 Jan 2025 09:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tUnr3-0003jK-VP; Mon, 06 Jan 2025 09:13:18 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tUnr0-0007VF-JD; Mon, 06 Jan 2025 09:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736172795; x=1767708795;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GpXw5G72+cS3odSUoaw2u94izBRazSMCA+VgY3SdFc0=;
 b=cJlK7CIU9qFDB9fAKILpXGAhUPY9ZjscLZuhRCpZ6mhnlVcTVlzkRRmi
 dn1WMSoV+Lg1cqqY9ObZRpU2iRQxg3LBXuNZhPcp33pEc6qBYYJn0Vf+0
 h1NetXoEiuM7nL0HIyS++lihtSW/Kze8BSeDMS34TBpKvbpQ2vHKvgOYX
 /GhnMTO9hZOAniAr9a06SWo4nHoh624TYBA+/duiIImni+gn2Fd3pyM+Y
 qr5GJDOuWyjPzkmBAvkoVlN9gK4EJonvJUHExPzoz5u8iGYli0UBI0E8t
 QYZw66OB4cwPsa3cDR6bPgs4Zvl0Nv3MQkulSh06kTlO/WNQpv7RnLf0p A==;
X-CSE-ConnectionGUID: afs8EDozQHiQM0cKhOYr7Q==
X-CSE-MsgGUID: 1wyPIpv6T92RSo2LUdpY0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47675385"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; d="scan'208";a="47675385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 06:13:10 -0800
X-CSE-ConnectionGUID: WHTrH3oiRWCk3yR1lN1tcg==
X-CSE-MsgGUID: kmqi1yfgRuGV+NzQyls0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; d="scan'208";a="133311758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 06 Jan 2025 06:13:09 -0800
Date: Mon, 6 Jan 2025 22:31:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 4/9] rust: vmstate: implement Zeroable for VMStateField
Message-ID: <Z3vpXJj/XgwbJUiS@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On Tue, Dec 31, 2024 at 01:23:31AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:31 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 4/9] rust: vmstate: implement Zeroable for VMStateField
> X-Mailer: git-send-email 2.47.1
> 
> This shortens a bit the constants.  Do not bother using it
> in the vmstate macros since most of them will go away soon.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs  | 18 +++---------------
>  rust/qemu-api/src/zeroable.rs | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 15 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


