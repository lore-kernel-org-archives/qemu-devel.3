Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DDDC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taYrM-0005KM-7U; Wed, 22 Jan 2025 06:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taYrI-0005Jb-CV; Wed, 22 Jan 2025 06:25:20 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taYrB-00070L-B7; Wed, 22 Jan 2025 06:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737545113; x=1769081113;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c9VGuQ/HJ+I/lboBeD5qmVCyEqHLF7KJIcnFyr56VRw=;
 b=CvxOYPfUyJ1sJfh2pyO443hF1JGrUtoLPczUaYAjqd/YPz5lIrQHXPBf
 bbq3FQuFTqkAlDzBXZRrGQmXhmHSJOawApkfzGdYNomfm09J5WYrJLvJX
 FrQW11yYk098lYiNqa1+STkrJRyFmwM1MLWmLLexwlcHn5cgJ4M1SO5IM
 dZMsHtVz+8igogoZV8P0+LjYJ+pF2xZV/pZcQiI0yYSdelXT1gVxnpBQ1
 hFqWrxFvnaAA7BBAsUJq7YqUM296N7aE7MlUC6BXRDqb2H5cFSnh573sL
 LZk0DHY4etKZ8VLip0ZF+oBnxS1iFwKrVU5Q5W555fP4Een3OOuJ0HFas A==;
X-CSE-ConnectionGUID: HeVqy595RrucDcILgL5gMg==
X-CSE-MsgGUID: cVA4BUqtTyegmM1li6LWeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37207807"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="37207807"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 03:25:09 -0800
X-CSE-ConnectionGUID: 2sn2VvzuTOCRtWNIwgOxPQ==
X-CSE-MsgGUID: kZi4t8AOS6e4K88hwMNQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="130417410"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2025 03:25:08 -0800
Date: Wed, 22 Jan 2025 19:44:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust: vmstate: add varray support to vmstate_of!
Message-ID: <Z5DaHvM2LARwXxbz@intel.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090046.1045010-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:00:39AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:00:39 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/10] rust: vmstate: add varray support to vmstate_of!
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 42 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

...

> +/// Internal utility function to retrieve a type's `VMStateFlags` when it
> +/// is used as the element count of a `VMSTATE_VARRAY`; used by
> +/// [`vmstate_of!`](crate::vmstate_of).
> +pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField {

A typo? It should return VMStateFlags type.

> +    T::VARRAY_FLAG
> +}
> +

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


