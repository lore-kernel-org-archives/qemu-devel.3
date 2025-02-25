Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47775C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqiB-0000Vc-Hz; Tue, 25 Feb 2025 03:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqi9-0000VK-9w; Tue, 25 Feb 2025 03:54:41 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmqi5-0000KG-V3; Tue, 25 Feb 2025 03:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740473678; x=1772009678;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RvVJk0NNrN4c4uf/3ac68hzMeHxrBdCOxnxMNny9S3Q=;
 b=ZadlhP0W55s0haFC1V/jZwpRZyd5BZJTaFgVRwdUGrrVk64Wy5Co1RSK
 WuR+Rdoj+SkTmBbLtvqw6FiwZEmIbMQxxbkmv86p+DPfZYZCHwrmLguJF
 TUWNa272fHhrZ0dofODR9up/bQqrPdb+Uv7424wB19vvWRFUYwDsLR3Y0
 Ycq1SFwh9jS3DBeFULBQRZY902wpXNuGOqmhwutKZ4JJZD7w2JfHGZJ95
 Vi697lHJgpYIMLElKLEJi7lmMPNG0ghTtHcMhi605h+k103YVRtMWzrXc
 jTytXq6doEXn1RlwvZogbgzz9RdXevKghLf/HMjt2GpkeuaO/g14eVue5 w==;
X-CSE-ConnectionGUID: ms1pPj4tTgCJusjcofS0oQ==
X-CSE-MsgGUID: 7OSSoWfuRM2VYGH6Ha8fYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51898442"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208,217";a="51898442"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:54:34 -0800
X-CSE-ConnectionGUID: b0ksFBatSLirBH1TIePUVg==
X-CSE-MsgGUID: CcQ3nhiHRAGDFK1XedgIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
 d="scan'208,217";a="116311798"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 25 Feb 2025 00:54:33 -0800
Date: Tue, 25 Feb 2025 17:14:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 13/15] rust: memory: wrap MemoryRegion with Opaque<>
Message-ID: <Z72J4uLSPvFBbpyz@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

>  impl MemoryRegion {
>      // inline to ensure that it is not included in tests, which only
> @@ -174,13 +174,15 @@ pub fn init_io<T: IsA<Object>>(
>          size: u64,
>      ) {
>          unsafe {
> -            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
> +            Self::do_init_io(
> +                self.0.as_mut_ptr(),

I'm not sure why the wrapper doesn't work here.

If I change this to `self.as_mut_ptr()`, then compiler tries to apply
`ObjectDeref::as_mut_ptr` and complains:

the trait `qom::ObjectType` is not implemented for `bindings::MemoryRegion`


But when I modify the function signature to &self like:

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index fdb1ea11fcf9..a82348c4a564 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -167,7 +167,7 @@ unsafe fn do_init_io(
     }

     pub fn init_io<T: IsA<Object>>(
-        &mut self,
+        &self,
         owner: *mut T,
         ops: &'static MemoryRegionOps<T>,
         name: &'static str,

Then the Wrapper's as_mut_ptr() can work.

> +                owner.cast::<Object>(),
> +                &ops.0,
> +                name,
> +                size,
> +            );
>          }
>      }
> -
> -    pub(crate) const fn as_mut_ptr(&self) -> *mut bindings::MemoryRegion {
> -        addr_of!(self.inner) as *mut _
> -    }
>  }
>  
>  unsafe impl ObjectType for MemoryRegion {
> -- 
> 2.48.1
> 
> 

