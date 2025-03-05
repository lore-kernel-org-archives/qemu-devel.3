Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BEBC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiZB-0007YA-2w; Wed, 05 Mar 2025 01:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpiZ3-0007Wp-NF; Wed, 05 Mar 2025 01:49:11 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpiZ1-0003rM-6x; Wed, 05 Mar 2025 01:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741157347; x=1772693347;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SOXwB4XeqozG7DczD5bix23rl412nb1PnTNe6ImrobM=;
 b=izZcfjRIAcJBYcMjaqjIVcp73l3iS8QQfg5sslTY9batCTyI6d6bD0aW
 239NwE3tpvNXzabM05H5rjiqn8/d6ofcnkCe5yqsTP02uwBko6lhQQUHR
 nYIrhrCiCfh4IWnxVUNOmPVOMdH+h08lans4VZqnnfVu+BIKSc4+LKx3j
 GrPe8rlyP/6BTJDYr8ees74D1PHIoYD7j1Id6DrVA9rNEszX/MH0OCF5g
 V2zcjJDc2y+5aH1hatLlz0udBhpW2/8et5aAdQScouW5IEB4PI13Al0ZH
 EloShHft86cKdEQz/epf3UcviW0JzsEykzAt1ZTUREKK6uVg4B0uQh6ZS g==;
X-CSE-ConnectionGUID: pr8Uoq7DTv61Vg5+EHaSVQ==
X-CSE-MsgGUID: OWtMn8dpQsWLx9gAgur4DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41964415"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208,217";a="41964415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 22:49:03 -0800
X-CSE-ConnectionGUID: fN5gUiCRSHGolkZStEtyIA==
X-CSE-MsgGUID: nNMdWELnS1G7kY/yD1/x7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="155790589"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Mar 2025 22:49:02 -0800
Date: Wed, 5 Mar 2025 15:09:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/12] rust: memory: wrap MemoryRegion with Opaque<>
Message-ID: <Z8f4lXzz9RMI9dXC@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227142219.812270-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

Sorry, when I revisit this patch, I have more thoughts..

> -/// A safe wrapper around [`bindings::MemoryRegion`].  Compared to the
> -/// underlying C struct it is marked as pinned because the QOM tree
> -/// contains a pointer to it.
> -pub struct MemoryRegion {
> -    inner: bindings::MemoryRegion,
> -    _pin: PhantomPinned,
> -}
> +/// A safe wrapper around [`bindings::MemoryRegion`].
> +#[repr(transparent)]
> +#[derive(qemu_api_macros::Wrapper)]
> +pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);

Would MemoryRegionOps also need to be wrapped into Opaque<>?

Currently I understand it's not necessary, because init_io() requires
MemoryRegionOps reference to be static.

    pub fn init_io<T: IsA<Object>>(
        &mut self,
        owner: *mut T,
        ops: &'static MemoryRegionOps<T>,
        name: &'static str,
        size: u64,
    )

But I wonder whether it is the most ideal implementation... or to remove
the static limitation of MemoryRegionOps and consider pin+Opaque instead?

Another thought is for init_io, it's also necessary to ensure MemoryRegion
is pinned, because callbacks also need to access the pointer of MemoryRegion,
just like you did for timer, e.g.,

     pub fn init_io<T: IsA<Object>>(
-        &mut self,
+        self: Pin<&mut Self>,
         owner: *mut T,
         ops: &'static MemoryRegionOps<T>,
         name: &'static str,
         size: u64,
     ) {

(Just disscussion without clarifying the difficulty), if you agree with
this, then I think this would be a main pattern for callback, i.e.,
accepting a pin parameter. Perhaps an ideal option would be to be able
to add the pin limit to the FnCall.

Thanks,
Zhao


