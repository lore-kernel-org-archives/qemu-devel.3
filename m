Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EECE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 03:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQe85-0007Md-9S; Wed, 25 Dec 2024 22:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQe84-0007MM-9a
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 22:01:40 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQe82-0001Bn-46
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 22:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735182098; x=1766718098;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1yYUTFJPIrUSB6nVFXtpXI3qf+jyYkVal3pr8pNy0tI=;
 b=Gpi9Xa1bVF1DA0+Q3Y8VMUlm5lwgIwXYQqFH0B45/CwJw45uJvwDztx3
 HAvZx6Tw5IapXjfbIVoJzD675aLh2WMoyNLC3F4jFXwfdTuqYy5n52dEZ
 9RNgivSHCQOIfFwnxTPMuoLq1rcuX4tONmCQjtraN8juFAvPurhwAkBfW
 MZSHeGa39bPSae+OJM5Tue0eF8FvoOCkOXzic9vz6bsshKX0qAFXuZKSz
 Mo7RqZOe8v4lBN4Tx/QdWIpmePPGfkDJ+SWJZSiU+nt2nysbBWhFcuvJs
 FDzMpUTeDZAs6YthtuGYsO2lvRXmhl9aqaHvicaKU3hM/7rr3bmmMdG/6 A==;
X-CSE-ConnectionGUID: DCvLSo8SRs2ggN4aL3ydHA==
X-CSE-MsgGUID: b3sHlJLFQpCu7Kvlea8/3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="46095072"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="46095072"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 19:01:34 -0800
X-CSE-ConnectionGUID: YUriBYDiTTuTLAvQb8jcLg==
X-CSE-MsgGUID: hs8QJkRNS+m3hr89/Evapw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="104904349"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 25 Dec 2024 19:01:34 -0800
Date: Thu, 26 Dec 2024 11:20:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 07/12] rust: pl011: only leave embedded object
 initialization in instance_init
Message-ID: <Z2zLcGH6IeAOHN0r@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:49PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:49 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/12] rust: pl011: only leave embedded object
>  initialization in instance_init
> X-Mailer: git-send-email 2.47.1
> 
> Leave IRQ and MMIO initialization to instance_post_init.  In Rust the
> two callbacks are more distinct, because only instance_post_init has a
> fully initialized object available.
> 
> While at it, add a wrapper for sysbus_init_mmio so that accesses to
> the SysBusDevice correctly use shared references.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 18 ++++++++++--------
>  rust/qemu-api/src/sysbus.rs      | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


