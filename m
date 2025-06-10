Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F875C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP276-0001sC-MU; Tue, 10 Jun 2025 12:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uP0wq-0002fT-H6; Tue, 10 Jun 2025 11:31:36 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uP0wn-0005BE-Oh; Tue, 10 Jun 2025 11:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749569494; x=1781105494;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=It+YrbwVuI9eBuKnFA3oEobQsDX3NlffuePwO4Vp+XI=;
 b=VJawCcuufedQa9OF0Phs2RvCR/J+ry9dStg4KACThKnqvoz2d18oDo7c
 WbZxKg10YYoKOqTCOnEGdmJ7NeGeSdl0AVl1AeGRXwvVSu4jzv3tz+PDE
 F7jWHJflw7xroFE3e6M6XFVSsv0A639yzE8/E4zop4wVOf48QxuDnRXUI
 +UDHwNW/2j5t9KbCJ12SancErrU5s1MO4ZcXfG5jI15vDWg4Darl0KBNC
 J3xWbmWvoLX0aQgcYszWHe4LHLA9P6EealLxND63JPUcRFOhlfiqpjy/k
 dyvWDvSgmCa48qNUDsoUz/154c5KsyHEDOy5vqHeT51aP8DW41qgsRqBg Q==;
X-CSE-ConnectionGUID: UYZrNI3QRjyYOjuLI7lQNA==
X-CSE-MsgGUID: ZZtRmLLYRV2nguiG5EbFkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51541788"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="51541788"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 08:31:17 -0700
X-CSE-ConnectionGUID: YGHO3I43TRep38+ZNHlb1w==
X-CSE-MsgGUID: vhFqneW+RDuLAcARoLUf+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="147811907"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Jun 2025 08:31:15 -0700
Date: Tue, 10 Jun 2025 23:52:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org, armbru@redhat.com, mkletzan@redhat.com
Subject: Re: [PATCH 1/3] rust: make TryFrom macro more resilient
Message-ID: <aEhUvj9JATt7TddY@intel.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <20250605101124.367270-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101124.367270-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jun 05, 2025 at 12:11:22PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:11:22 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/3] rust: make TryFrom macro more resilient
> X-Mailer: git-send-email 2.49.0
> 
> If the enum includes values such as "Ok", "Err", or "Error", the TryInto
> macro can cause errors.  Be careful and qualify identifiers with the full
> path, or in the case of TryFrom<>::Error do not use the associated type
> at all.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Though I'm late...

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index 103470785e3..c18bb4e036f 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -203,8 +203,8 @@ fn derive_tryinto_body(
>      Ok(quote! {
>          #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
>          match value {
> -            #(#discriminants => Ok(#name::#discriminants),)*
> -            _ => Err(value),
> +            #(#discriminants => core::result::Result::Ok(#name::#discriminants),)*
> +            _ => core::result::Result::Err(value),

error.rs is using std::result, so I think it's better to use std rather
than core if possible.

But there are many other cases like this where std and core are mixed,
maybe we can clean it up to always prefer the std.


