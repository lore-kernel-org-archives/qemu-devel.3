Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410FDE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfOV-00054o-I5; Thu, 12 Dec 2024 04:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfOO-00054S-Qm; Thu, 12 Dec 2024 04:21:57 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfOL-0003kK-Jm; Thu, 12 Dec 2024 04:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733995313; x=1765531313;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6nxmlxmHHaHgQuB/XpNTlZZFo7Su9xCxjpzwOuZ9G38=;
 b=k/BqryRAA6gJfiKP52Sih2CAs2VXaOjKaSXC/BH4RmOD8kzVLE4v8I24
 sICiu6hXkuU0TIhtM8XeuUjApeKOugtO28GLyDMtfiJn762eWelkOm2OH
 x0H2caST8hRUqrnQ2lnZd4ow4maAXUAIzHWGNrlnvoXCxWAwQ9NZ45IAW
 HgLnElByUTFqeKDpimwA6ceknsoSLKZuSMlF0VaeGmE84UvqlY+XiM22A
 FbgddoWbFHUwRMc1116wP9xmMtOjV+jWG6LrTtP963TllUNWjtXuraVBW
 ERuq1+YXp3CUw+9781QnQ/gS4G9+eXWyvUXk1dFGK3taRHwFFJC70ci9Z Q==;
X-CSE-ConnectionGUID: WQ8k5x9aRkeUML7YNaIvaw==
X-CSE-MsgGUID: HEtU5a1aSBSdy6fPZeaeQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37245017"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="37245017"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 01:21:50 -0800
X-CSE-ConnectionGUID: q1E1lg6xQGu/6D6wRJLDbA==
X-CSE-MsgGUID: 2FwRE8QAQgyaUmjqJTTn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="96716287"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 12 Dec 2024 01:21:49 -0800
Date: Thu, 12 Dec 2024 17:40:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 18/26] rust: qom: add possibility of overriding unparent
Message-ID: <Z1qvdU+oukSRe8I4@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-19-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-19-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Mon, Dec 09, 2024 at 01:37:09PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:09 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 18/26] rust: qom: add possibility of overriding unparent
> X-Mailer: git-send-email 2.47.1
> 
> Add a blanket definition of ClassInitImpl<ObjectClass> that thunks
> ObjectImpl::UNPARENT and overrides it in ObjectClass if it is not
> None.
>
> ClassInitImpl<DeviceClass> can now call its superclass's ClassInitImpl,
> so that the C and Rust hierarchies match more closely.
> 
> This is mostly done as an example of implementing the metaclass
> hierarchy under ClassInitImpl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/definitions.rs  | 44 ++++++++++++++++++++++++++++---
>  rust/qemu-api/src/device_class.rs |  6 +++--
>  2 files changed, 45 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

(with an additional comment below...)

> diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
> index 2429b9f53f0..958ea34decc 100644
> --- a/rust/qemu-api/src/definitions.rs
> +++ b/rust/qemu-api/src/definitions.rs
> @@ -6,7 +6,7 @@
>  
>  use std::{ffi::CStr, os::raw::c_void};
>  
> -use crate::bindings::{Object, ObjectClass, TypeInfo};
> +use crate::bindings::{self, Object, ObjectClass, TypeInfo};
>  
>  unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
>      // SAFETY: obj is an instance of T, since rust_instance_init<T>
> @@ -115,6 +115,9 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
>          class_data: core::ptr::null_mut(),
>          interfaces: core::ptr::null_mut(),
>      };
> +
> +    // methods on ObjectClass
> +    const UNPARENT: Option<fn(&mut Self)> = None;
>  }

Will we change `&mut Self` to an immutable reference in the future?

IIUC, the parent on the C side also has a pointer to current object.
 

