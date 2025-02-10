Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5ACC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUPk-0002XJ-VS; Mon, 10 Feb 2025 09:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUPO-0002Mp-RT; Mon, 10 Feb 2025 09:05:11 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUPL-0003EJ-Js; Mon, 10 Feb 2025 09:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739196308; x=1770732308;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jlBC11wbQ4UqD1n/hnYNjMIGutLzA21IAe7GQaQaAls=;
 b=NM9ddOAcjxtPGjCoPa1kO6LJYSJ2rJE3kAGLCgiGZJSqcXjtwvJxcgKR
 dnlk6AfI5voB6rdaVSRQP88rDno0dWSlvETxnQ+wH1zOUVGH9Et4SBnQC
 1tObPae6kK6upm33CfhZAuoq78elcdD8AGg4Ydj6tP8noBJABwHz3Be3l
 MionId7/f4KQH3r1y52nk7VPKjUvMEI4EBHYRDmfRFxtc2gGkDqOv6afw
 B7TdZatbVzBV1BfxxSd8JcVEWVmcaSTPWMo/DyFuZcuy9bg0IQxaFrkq7
 PLhwiJTQ/EEvw6gTOnjKNlSkLJMrb7t0Qljv3gS6e6lXIq4ifOVjFRJYr A==;
X-CSE-ConnectionGUID: Ihl9C5SlSdC8B1OyrmBhZQ==
X-CSE-MsgGUID: 43YuBOUlQo69qEqyugFPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="38978798"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="38978798"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 06:05:04 -0800
X-CSE-ConnectionGUID: Lu65BV0rT/qmTV8XL6/OAw==
X-CSE-MsgGUID: RsDoXCutR1meNgSqV0lO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="113077327"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 10 Feb 2025 06:05:02 -0800
Date: Mon, 10 Feb 2025 22:24:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/12] rust: qom: add reference counting functionality
Message-ID: <Z6oMIXLwifxKV6g+@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 07, 2025 at 11:16:12AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:12 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/12] rust: qom: add reference counting functionality
> X-Mailer: git-send-email 2.48.1
> 
> Add a smart pointer that allows to add and remove references from
> QOM objects.  It's important to note that while all QOM objects have a
> reference count, in practice not all of them have their lifetime guarded
> by it.  Embedded objects, specifically, are confined to the lifetime of
> the owner.
> 
> When writing Rust bindings this is important, because embedded objects are
> *never* used through the "Owned<>" smart pointer that is introduced here.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs     | 158 ++++++++++++++++++++++++++++++++++-
>  rust/qemu-api/src/vmstate.rs |   6 +-
>  rust/qemu-api/tests/tests.rs |  10 +++
>  3 files changed, 172 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
> index f50ee371aac..4a2e84c9aed 100644
> --- a/rust/qemu-api/src/qom.rs
> +++ b/rust/qemu-api/src/qom.rs
> @@ -56,6 +56,7 @@
>  use std::{
>      ffi::CStr,
>      fmt,
> +    mem::ManuallyDrop,
>      ops::{Deref, DerefMut},
>      os::raw::c_void,
>      ptr::NonNull,
> @@ -63,7 +64,13 @@
>  
>  pub use bindings::{Object, ObjectClass};
>  
> -use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
> +use crate::{
> +    bindings::{
> +        self, object_dynamic_cast, object_get_class, object_get_typename, object_ref, object_unref,
> +        TypeInfo,
> +    },
> +    cell::bql_locked,
> +};
>  
>  /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
>  /// or indirect parent of `Self`).
> @@ -610,6 +617,148 @@ unsafe impl ObjectType for Object {
>          unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
>  }
>  
> +/// A reference-counted pointer to a QOM object.
> +///
> +/// `Owned<T>` wraps `T` with automatic reference counting.  It increases the
> +/// reference count when created via [`Owned::from`] or cloned, and decreases
> +/// it when dropped.  This ensures that the reference count remains elevated
> +/// as long as any `Owned<T>` references to it exist.
> +///
> +/// `Owned<T>` can be used for two reasons:
> +/// * because the lifetime of the QOM object is unknown and someone else could
> +///   take a reference (similar to `Arc<T>`, for example): in this case, the
> +///   object can escape and outlive the Rust struct that contains the `Owned<T>`
> +///   field;
> +///
> +/// * to ensure that the object stays alive until after `Drop::drop` is called
> +///   on the Rust struct: in this case, the object will always die together with
> +///   the Rust struct that contains the `Owned<T>` field.
> +///
> +/// Child properties are an example of the second case: in C, an object that
> +/// is created with `object_initialize_child` will die *before*
> +/// `instance_finalize` is called, whereas Rust expects the struct to have valid
> +/// contents when `Drop::drop` is called.  Therefore Rust structs that have
> +/// child properties need to keep a reference to the child object.  Right now
> +/// this can be done with `Owned<T>`; in the future one might have a separate
> +/// `Child<'parent, T>` smart pointer that keeps a reference to a `T`, like
> +/// `Owned`, but does not allow cloning.
> +///
> +/// Note that dropping an `Owned<T>` requires the big QEMU lock to be taken.

Nice doc.

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


