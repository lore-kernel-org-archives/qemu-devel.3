Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB29E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2Sw-0004zY-PE; Tue, 10 Dec 2024 10:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2St-0004z8-TF; Tue, 10 Dec 2024 10:48:01 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tL2Sq-0002TI-Of; Tue, 10 Dec 2024 10:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733845676; x=1765381676;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7offN8/JfNwDClUFfyhkvwu8lhoE2oldYzuNntURWLU=;
 b=E3pHrQkW0ifiFJy/ohKfLcERs+tkcBN7ABpTcuKK7IhSb7rtgrpWavoV
 D29+JNY9PAFa2iO1Z3AAwmtf2qeqgEafH1UBLR/6yMHkwxtBiDyuU51+H
 tkQ/xWQLFiSxFnlx1JXisVW+QdYAaEBTGlhOO1eELUCtEqVDKJQt3IiCt
 07aOFTYEkSAyZajtrPJzpdpxwXs2KHUoOC+BnCbBqL4kjUvWAKniY+lhC
 dHe0h51qVamhu7JbQqxYfzPr6F+HCUfi6XZLREq5VnJYeGz3pE4bSs9Pq
 YP0WsAj/39gDSzQL8wcyT/VD4Hk0sae151x7SzqgxDHiWFyN3RWIIwJh5 w==;
X-CSE-ConnectionGUID: TUrSQSEcSral4sb0HEK5lQ==
X-CSE-MsgGUID: +e+xUBKXSpWJdmNPNW0QPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51720709"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="51720709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 07:47:54 -0800
X-CSE-ConnectionGUID: 3UyBCnyQSSSn4/R6xaeqOA==
X-CSE-MsgGUID: Q7v4VyWFQsGfIjx3RGY2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; d="scan'208";a="126253835"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2024 07:47:53 -0800
Date: Wed, 11 Dec 2024 00:06:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 11/26] rust: qdev: move device_class_init! body to
 generic function, ClassInitImpl implementation to macro
Message-ID: <Z1hm76XZG3W6ZVH3@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Mon, Dec 09, 2024 at 01:37:02PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:02 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/26] rust: qdev: move device_class_init! body to generic
>  function, ClassInitImpl implementation to macro
> X-Mailer: git-send-email 2.47.1
> 
> Use a trait to access the former parameters to device_class_init!.
> This allows hiding the details of the class_init implementation behind
> a generic function and makes higher-level functionality available from
> qemu_api.
> 
> The implementation of ClassInitImpl is then the same for all devices and
> is easily macroized.  Later on, we can remove the need to implement
> ClassInitImpl by hand for all device types, and stop making
> rust_device_class_init<>() public.
> 
> While at it, document the members of DeviceImpl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       | 34 +++++-----
>  rust/hw/char/pl011/src/device_class.rs |  8 ---
>  rust/qemu-api/src/device_class.rs      | 87 +++++++++++++++++++++-----
>  rust/qemu-api/tests/tests.rs           | 30 ++++-----
>  4 files changed, 103 insertions(+), 56 deletions(-)

Rviewed-by: Zhao Liu <zhao1.liu@intel.com>


