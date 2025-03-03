Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A165DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7N2-0007ky-S5; Mon, 03 Mar 2025 10:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp7MY-0007fP-DZ; Mon, 03 Mar 2025 10:05:48 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp7MV-0000fe-Sl; Mon, 03 Mar 2025 10:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741014344; x=1772550344;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YWu7U2ox8C/kS5IwJ4lG/zzSKqj7UhVgFgx8RBptvjE=;
 b=dIfsAlnSUYBehUdQBeOKRMRxnannHPcJVPfDjtRpmtivP8plq3SyKtXs
 PFQv9xVZU87luIEt9dDOvxkhIfX1BtgpI1Ka8bn4Ml+iQt3GH7Mx8kROu
 knAZq57h+6pSFACcMBPF5LHGwyFObpZ6xd2BSqV3QKtACL3J+tkqnBkwv
 XyoH+1lCX/GKDe29oN2AdFozUWVRQmPhfnvG/H4zUW0kDObpOHCiG3sTM
 CVdBES27TM/6iNwbgBQa4b6A+fOXHu7JnsdnYkxKPn0o15bBt2udEXx16
 ho6ImSGqF7h4hDXDlmPADQfNq48agkU0QMwaCSIf+pwTTEc7ibBYKi71M A==;
X-CSE-ConnectionGUID: 6sFnXdPVRpq9RD6nK5tjZg==
X-CSE-MsgGUID: viYkFKm/QOqMtwxfi38DeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52530058"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208,217";a="52530058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 07:05:40 -0800
X-CSE-ConnectionGUID: c0r33xX1Q8qv9toIUwi6+A==
X-CSE-MsgGUID: b1sqFXykQuKLlSQ4e7KDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="122176351"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 03 Mar 2025 07:05:39 -0800
Date: Mon, 3 Mar 2025 23:25:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/12] rust: memory: wrap MemoryRegion with Opaque<>
Message-ID: <Z8XJ+RwBctFJ6FqW@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 27, 2025 at 03:22:17PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:17 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/12] rust: memory: wrap MemoryRegion with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs |  3 ---
>  rust/qemu-api/src/memory.rs   | 35 +++++++++++++++++++++--------------
>  2 files changed, 21 insertions(+), 17 deletions(-)

...

>  impl MemoryRegion {
>      // inline to ensure that it is not included in tests, which only
> @@ -174,13 +174,20 @@ pub fn init_io<T: IsA<Object>>(
>          size: u64,
>      ) {
>          unsafe {
> -            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
> +            Self::do_init_io(
> +                // self.0.as_mut_ptr() needed because Rust tries to call
> +                // ObjectDeref::as_mut_ptr() on "&mut Self", instead of coercing
> +                // to "&Self" and then calling MemoryRegion::as_mut_ptr().
> +                // Revisit if/when ObjectCastMut is not needed anymore; it is
> +                // only used in a couple places for initialization.
> +                self.0.as_mut_ptr(),
> +                owner.cast::<Object>(),
> +                &ops.0,
> +                name,
> +                size,
> +            );
>          }
>      }

The extra comment is nice, too. :-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


