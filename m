Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9j-0001Yh-0n; Mon, 29 Sep 2025 11:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3G9d-0001Ky-33; Mon, 29 Sep 2025 11:51:09 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3G9U-0000iA-KQ; Mon, 29 Sep 2025 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759161061; x=1790697061;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9W74zEoqyUET7A2cUfqGOGYlA5GRpaX5PAiAbi7NmyE=;
 b=CNY8OEWxzizStz5tPxpT67FZIxRgdqtpj6cjiEOLGmzqhk4xRBeYZkVD
 PDWkkikCyKq6ccGVJJso6ofBF1kPiiwfh/eGK4yJ0iE6ajG7YwjkIC0sU
 xEjNSqCvqJPQrZyiZcmYn2P31SAJY50TLltrBGqSt37YrtynhyoP24c4r
 +mtIpwTiVdq7P/IrR8dt6chPsymTeceGWqTo/7GhyysagqPKZraUzQfHY
 4Y9Oe2z1e1mKzC5etd4i28CrpOJmWB9P/EXyOFgf1fWVwiquQ1U+ec7r/
 I0STrAEZB9QwRgEdJ/tCqv2o3t0eHuAOWhWOgQtVZhdqlnaEdY2xAHixC A==;
X-CSE-ConnectionGUID: gvtRRVT6Qu2KnCSLyFjhnA==
X-CSE-MsgGUID: QitGmT2vSnKfvbmusFs9GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="78829376"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="78829376"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:50:51 -0700
X-CSE-ConnectionGUID: hYRn1zx3TVWyDaW6ZgrGgg==
X-CSE-MsgGUID: kOgdylrIQpGeb0HdBDrxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="177519499"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 29 Sep 2025 08:50:49 -0700
Date: Tue, 30 Sep 2025 00:12:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 6/7] rust: migration: implement ToMigrationState for Timer
Message-ID: <aNqwACkjytK3+QQ4@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

On Sat, Sep 20, 2025 at 04:29:57PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:57 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 6/7] rust: migration: implement ToMigrationState for Timer
> X-Mailer: git-send-email 2.51.0
> 
> Timer is a complex struct, allow adding it to a struct that
> uses #[derive(ToMigrationState)]; similar to vmstate_timer, only
> the expiration time has to be preserved.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
> index fa25317eea8..c4ad4f73d5c 100644
> --- a/rust/migration/src/migratable.rs
> +++ b/rust/migration/src/migratable.rs
> @@ -202,6 +202,37 @@ fn restore_migrated_state(
>      ) -> Result<(), InvalidError>;
>  }
>  
> +impl ToMigrationState for util::timer::Timer {
> +    type Migrated = i64;

This converts a Timer to i64, then we don't need vmstate_info_timer
anymore. Good idea.

> +    fn snapshot_migration_state(&self, target: &mut i64) -> Result<(), InvalidError> {
> +        // SAFETY: as_ptr() is unsafe to ensure that the caller reasons about
> +        // the pinning of the data inside the Opaque<>.  Here all we do is
> +        // access a field.
> +        *target = unsafe { &*self.as_ptr() }.expire_time;

C side checks timer_pending(), which ensures when the timer is
inactive, it always saves u64::MAX.

But now we save the expire_time directly in Rust. I think this would be
possible to break the migration from Rust timer to C timer, because at
C side, timer_get() checks whether expire_time is -1 and we can't ensure
expire_time won't store -2 (or other unusual negative values).

So maybe it's better to follow C side behavior to return u64::MAX for
non-pending case?

> +        Ok(())
> +    }
> +
> +    fn restore_migrated_state_mut(
> +        &mut self,
> +        source: Self::Migrated,
> +        version_id: u8,
> +    ) -> Result<(), InvalidError> {
> +        self.restore_migrated_state(source, version_id)
> +    }
> +}
> +
> +impl ToMigrationStateShared for util::timer::Timer {
> +    fn restore_migrated_state(&self, source: i64, _version_id: u8) -> Result<(), InvalidError> {
> +        if source >= 0 {

This can work for the migration cases of C->Rust and Rust->Rust.

Thanks,
Zhao

> +            self.modify(source as u64);
> +        } else {
> +            self.delete();
> +        }
> +        Ok(())
> +    }
> +}
> +
>  impl<T: ToMigrationStateShared, const N: usize> ToMigrationStateShared for [T; N]
>  where
>      [T::Migrated; N]: Default,
> -- 
> 2.51.0
> 

