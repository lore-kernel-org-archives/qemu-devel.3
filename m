Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFE1CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8DRx-0006eo-Lf; Mon, 13 Oct 2025 03:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8DRw-0006eZ-8t
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:58:32 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8DRl-0002KD-Fh
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 03:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760342301; x=1791878301;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b/S7GYqBvwS3RsYm2rHAGXRviuM3h7DwKBXiXsS/TJs=;
 b=jMs5VPKMrKWvYM7LKNy9datqpabXqFS7ThAnWSAkjTATS9DzQJXfBf+l
 Z6PdR0dgmkm4hLgXV/7jjrx6GwcRCFbsnx0wJ2KmAgj3uiFo41GC7viKG
 KxqEGDOST+OJR2VKpLAS70Z19NT0yO9xmVls/3kQXglVdV6rcaeFg2oZH
 rLYmv3AglOxIz80VCuWcLpH2nUrAQjBVB3aZ+ZJJaRQMiWdD+wQGO9htR
 xjB3ojqzL4QXUuMAgqSms07qeAFZLlSBG8MPREmv+PbTeD1OUmk56xwNv
 oEiUn7zYKOXDKZVj0EHiLQzzu7eCRoQUB5yKUTgezRFnYtq7ec9TXftlb w==;
X-CSE-ConnectionGUID: 5yWsqMFmTA6ItxkvYTvDiA==
X-CSE-MsgGUID: ua3xzvYpTiWEfXybbx1I2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62177854"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="62177854"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:58:13 -0700
X-CSE-ConnectionGUID: 36vpGgDvTIGvR/3/eCyViA==
X-CSE-MsgGUID: ue3YLomgQZmoW0n1K0FfvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="185797542"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2025 00:58:12 -0700
Date: Mon, 13 Oct 2025 16:20:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/11] rust: migration: do not pass raw pointer to
 VMStateDescription::fields
Message-ID: <aOy2QZ6EUZkE0h+U@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 09:52:01AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:01 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/11] rust: migration: do not pass raw pointer to
>  VMStateDescription::fields
> X-Mailer: git-send-email 2.51.0
> 
> Pass a slice instead; a function that accepts a raw pointer should
> arguably be declared as unsafe.
> 
> But since it is now much easier to forget vmstate_fields!, validate the
> value (at least to some extent) before passing it to C.  (Unfortunately,
> doing the same for subsections would require const ptr::is_null(), which
> is only stable in Rust 1.84).
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


