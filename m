Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE149F3C269
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbOg-0001Pg-TY; Mon, 09 Mar 2026 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzbOe-0001Kz-2E; Mon, 09 Mar 2026 10:15:48 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzbOZ-0001Sl-Az; Mon, 09 Mar 2026 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773065744; x=1804601744;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4Uf0GaIowuI3Reb0WRrR0HQjXNehAdybZkTQ2CN1tgs=;
 b=VUv/Ty7Hvq9LqFJB+fW/3WyALMQdX27dhGJwwdnHTXPatQFbSMkfvgLy
 34sWaNaCw8bTR9KB0K0932wgvWO5H8zcgZ6SH2cJrR23DY3VIIpnXRgBa
 el+APgXgUmr96nOYDXUZtgegFSM5lNqzWiDfD0GMLAFn5X25ZFHV3I60S
 VitAWVIswWhig9xnl0EDHb2hjiuRQe+InQVKp219mXoPkeWsfaGADfllI
 F+D6ws5Pcs0xLIoO7UOEsGld1Mbu54qIZOumXq8B4g3K0rBm3mHCNWnFW
 sGML8ut1MbCRQqJvPXodpyNCxq+4vkhyM5UH6YbqSfsacz9atoftXZ/Xl A==;
X-CSE-ConnectionGUID: gsFM7GoWSGefAgpIQ59hPQ==
X-CSE-MsgGUID: Zzjv+gj9QS+5ohguKIRkzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73966367"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="73966367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 07:15:37 -0700
X-CSE-ConnectionGUID: jeLL88kTROu8Oo1mAr+yPg==
X-CSE-MsgGUID: QUG8YIQ7TMylRehx1jYLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="257688200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 09 Mar 2026 07:15:34 -0700
Date: Mon, 9 Mar 2026 22:41:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH v3 03/18] migration: make .post_save() a void function
Message-ID: <aa7cKDaCVmuZz9Sm@intel.com>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-4-vsementsov@yandex-team.ru>
 <87o6l01r5z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6l01r5z.fsf@suse.de>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> +CC Paolo, Zhao
> 
> This change breaks the rust build:
> https://gitlab.com/farosas/qemu/-/jobs/13393119755
> 
>   error[E0308]: mismatched types
>      --> ../rust/migration/src/vmstate.rs:605:18
>       |
>   605 |             Some(vmstate_no_version_cb::<T, F>)
>       |             ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
>       |             |
>       |             arguments to this enum variant are incorrect
>       |
>       = note: expected fn pointer `unsafe extern "C" fn(_) -> ()`
>                     found fn item `unsafe extern "C" fn(_) -> i32 {vmstate_no_version_cb::<T, F, impl Into<Errno>>}`
> 
> 
> Is something like the following diff the right fix? It'd be nice to get
> an ack so this series doesn't miss the freeze. (CI run:
> https://gitlab.com/farosas/qemu/-/pipelines/2369688593)
> 
> -- >8 --
> From 90a7b53d2b0d53692df1ef2cfe7607b13e4961d8 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Fri, 6 Mar 2026 18:53:14 -0300
> Subject: [PATCH] fixup! migration: make .post_save() a void function
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  rust/migration/src/migratable.rs |  3 +--
>  rust/migration/src/vmstate.rs    | 12 +++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
> index 7748aac2f2..7088c1b156 100644
> --- a/rust/migration/src/migratable.rs
> +++ b/rust/migration/src/migratable.rs
> @@ -406,10 +406,9 @@ fn pre_save(&self) -> Result<(), InvalidError> {
>          Ok(())
>      }
>  
> -    fn post_save(&self) -> Result<(), InvalidError> {
> +    fn post_save(&self) {
>          let state = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
>          drop(state);
> -        Ok(())
>      }

What about this?

fn post_save(&self) {
    let _ = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
}

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



