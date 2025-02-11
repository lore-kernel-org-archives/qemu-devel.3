Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B93FC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 02:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgRk-0003pO-I2; Mon, 10 Feb 2025 21:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgRe-0003ov-JV; Mon, 10 Feb 2025 21:56:18 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgRb-00055I-Ia; Mon, 10 Feb 2025 21:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739242575; x=1770778575;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L+d/T0S7rwLh/IUVD8rHMGPWi5hJ6U10Pn/4BlpJ8yg=;
 b=NnCRAopTrorWPzXuxmV2w0oUYHjdJqyr5ywSZsEeUb7xU1upzjrRNcMv
 JnhPkx74i0sSOasFnsK2k45K/tiLm9kfsOwkz/pb8Hldhwf3dWiWi3eke
 l43mE2k7YPKuo24YWVjx/O+kHQZyKdfLLXMhVo20CnSEBY+cIQR1qtuFz
 A3ZVQGRzpP/6M7+LjtVeJxIyvspVsPCLngMAH4x71T8bU0e5JAhL72bUV
 xArTBJwk6O/uKRCfFk0rsc0UiunrmIFly+An0d3n1us1va2Jmtt8VOyio
 R6I8m6FuSp0Tg3RJrFSOxqt2WHasq1GzlPwBP+0HMBo7VoWzMd+xhdr8D w==;
X-CSE-ConnectionGUID: B651BPXcSeaX3VvtCk4+mQ==
X-CSE-MsgGUID: mf2/ULZsR3eITZfDm1R6OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39735503"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="39735503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 18:56:02 -0800
X-CSE-ConnectionGUID: DsJdL3LORiaF3Ym5cRusZQ==
X-CSE-MsgGUID: Bk/a7yPSTJCyyDQw1mNvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="112211456"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2025 18:55:52 -0800
Date: Tue, 11 Feb 2025 11:15:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/12] rust: qdev: switch from legacy reset to Resettable
Message-ID: <Z6rAzBIRjDw9N3B6@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:18AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:18 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/12] rust: qdev: switch from legacy reset to Resettable
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                      |   1 +
>  rust/hw/char/pl011/src/device.rs |  10 ++-
>  rust/qemu-api/src/qdev.rs        | 111 ++++++++++++++++++++++++-------
>  rust/qemu-api/tests/tests.rs     |   5 +-
>  4 files changed, 99 insertions(+), 28 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


