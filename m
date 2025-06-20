Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA70EC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSd35-0004hH-Pe; Fri, 20 Jun 2025 10:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSd33-0004gs-Jp; Fri, 20 Jun 2025 10:48:57 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSd31-0002e9-Mb; Fri, 20 Jun 2025 10:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750430935; x=1781966935;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hzBRiRIv93nZl1GGEvVbRxQPgPeMNr/86iMn9Ox/NZA=;
 b=SZq9b4UoLbMVY8iZuyXdBFPV/mQ2J7EooZHtx+QXQWHLvqbwpRNm3qdB
 5Xoszr/UbtIa3PNDWW/ukYbIR0XgpvhA1WIeRC2UTduWhJ7znbNEqgy8n
 dzvbPRWH03x5m9JRZxRPnhN80RDus21v950u+rqTm70cGs69O5BnALAyZ
 NNgXZhYHOImSRhYgeKMwkq3yKEWQJDzib15g1pQRDT7JWB/rCmnwnSZkf
 k70k3udiCrpF3/U/58g0B3EqjqYtruk+5PM4oY8EVu9ifuDPBAldcJirF
 Ol/6lbXTcqkfZSMHwD8BDytT9w7oTyUYD+bZmQh0ZidVQ3qIXffyCSoF5 g==;
X-CSE-ConnectionGUID: wuFhOcmkTOuYneYHKrlouA==
X-CSE-MsgGUID: hS9qw/irQbi/GArU+6Q/6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52786729"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52786729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 07:48:53 -0700
X-CSE-ConnectionGUID: sSUorJBPQMuz4WfQtYMeRA==
X-CSE-MsgGUID: aqGW1bfMT+Kuo9ZjA4jymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="150422369"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 20 Jun 2025 07:48:52 -0700
Date: Fri, 20 Jun 2025 23:10:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, tanishdesai37@gmail.com
Subject: Re: [PATCH 2/2] rust: move rust.bindgen to qemu-api crate
Message-ID: <aFV507NQPwVISgBD@intel.com>
References: <20250613130249.1225545-1-pbonzini@redhat.com>
 <20250613130249.1225545-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613130249.1225545-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On Fri, Jun 13, 2025 at 03:02:49PM +0200, Paolo Bonzini wrote:
> Date: Fri, 13 Jun 2025 15:02:49 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/2] rust: move rust.bindgen to qemu-api crate
> X-Mailer: git-send-email 2.49.0
> 
> Once qemu-api is split in multiple crates, each of which will have
> its own invocation of bindgen.  There cannot be only one, because
> there are occasional "impl" blocks for the bindgen-generated
> structs (e.g. VMStateFlags or QOM classes) that have to
> reside in the same crate as the bindgen-generated code.
> 
> For now, prepare for this new organization by invoking bindgen
> within the qemu-api crate's build definitions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                   | 41 -----------------------------------
>  rust/{ => qemu-api}/wrapper.h |  0
>  rust/meson.build              |  4 +++-
>  rust/qemu-api/meson.build     | 41 +++++++++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 42 deletions(-)
>  rename rust/{ => qemu-api}/wrapper.h (100%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


