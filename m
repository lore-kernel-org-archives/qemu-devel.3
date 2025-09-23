Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46623CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14Lw-0000J7-7m; Tue, 23 Sep 2025 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v14Lt-0000HB-Uh; Tue, 23 Sep 2025 10:50:45 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v14Lr-0005W1-U4; Tue, 23 Sep 2025 10:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758639044; x=1790175044;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yTy9mhJ0v6U4wFlKJO78ZOgcatDYlofPdRUASbtEN10=;
 b=LbCwSfUtgezRICjCNsWLV8Xkm9fUTBC2zTLjRIkU2dUFQVWlOApHuZD/
 zzb4t5t2WOoBbhWqxBQAXdm9ucqlDopP/FA+gkhXWWkApViEyqxayYboL
 Qk3V0TsnjVauNff5V7pi+si6ApDdva6YzZK/XcuM3/kz/mFRpuPSd3q8m
 PzuyXt5InMwr4U04qwwDQ2w/iN0gEJwpDhmn+QBuVeDGjk2hvi/ao+0z6
 YAl1iY9XJmAm5kGWVfPCVSeoVRreT1wG0xfshP6zZSZOUDkva3BZl7qIo
 jkCO9cHd8OA4vLKaJzWcasx2C09QL9LL9b28zeBDsrurKdrp6mPmMdBYW w==;
X-CSE-ConnectionGUID: BH58yB51Ry6mu36y6R0G/g==
X-CSE-MsgGUID: 9TFkaWb1TvmF9wJ2BRpbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64747654"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64747654"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:50:38 -0700
X-CSE-ConnectionGUID: AZTwWG4PSz+0ZclZ6nk3WQ==
X-CSE-MsgGUID: 6s56t54rRMiQEN8DxMlVXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="200481996"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2025 07:50:36 -0700
Date: Tue, 23 Sep 2025 23:12:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 1/7] rust: bql: add BqlRefCell::get_mut()
Message-ID: <aNK44f/1+VEiOUQs@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Sat, Sep 20, 2025 at 04:29:52PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/7] rust: bql: add BqlRefCell::get_mut()
> X-Mailer: git-send-email 2.51.0
> 
> This method is rarely useful in QEMU due to the pervasiveness of
> shared references, but add it for when a &mut BqlRefCell<> is used.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bql/src/cell.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
> index 24ab294b60d..8a0c8c14ad4 100644
> --- a/rust/bql/src/cell.rs
> +++ b/rust/bql/src/cell.rs
> @@ -580,6 +580,25 @@ pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
>          }
>      }
>  
> +    /// Returns a mutable reference to the underlying data in this cell,
> +    /// while the owner already has a mutable reference to the cell.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use bql::BqlRefCell;
> +    ///
> +    /// let mut c = BqlRefCell::new(5);
> +    ///
> +    /// *c.get_mut() = 10;
> +    /// ```
> +    #[inline]
> +    pub const fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: there cannot be any outstanding borrow,
> +        // since `self` is mutably owned.
> +        unsafe { &mut *self.as_ptr() }

Why not use UnsafeCell::get_mut?

self.value.get_mut()

Regards,
Zhao

