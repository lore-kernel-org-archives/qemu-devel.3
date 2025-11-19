Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2374BCF34DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLkFT-0004Sf-M6; Wed, 19 Nov 2025 10:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLkFR-0004Rr-5c; Wed, 19 Nov 2025 10:37:33 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLkFP-0000EM-DF; Wed, 19 Nov 2025 10:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763566652; x=1795102652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U1Cbs/dBqo8E/y7M+ZKP5CPf3bCsrxw04UQ6VD+I5iU=;
 b=XDEe5mnqB4Wy7vMeSAX95L5Z44UFOoPCE7A5SUR0wErieyQZmP8rngNo
 wJNtAfbgd3gbhegJfDW1jGQVWIMKnWdin/q0KW9EnvmSRvA2dms5PHOkV
 G2byX1uRc09V1o18hhmeHyN31t4FEqJSKAcgUsmoqXRhR7LMVI5z/cSQv
 40vKK8POYfVMux2xU/TfWFth02z56VM7pxVBtXp4rVJZZCO6EdL0ysBg8
 ahB8DToTzJ/3xmZpiGSpqGVuuK4r2KtakA58a+khhwQFjFoUJ1VOukU2f
 0WRI28w2k9EKui37r10eWUlG/7RG81uIJGyXXOlsaiBUiMk8I9aFOOREx g==;
X-CSE-ConnectionGUID: Cp8JAlQlQLOEZ89Cki+aVg==
X-CSE-MsgGUID: PcLKnquqQju02FC1eJn3hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="75939192"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="75939192"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 07:37:28 -0800
X-CSE-ConnectionGUID: SPmAQJjhRaW5H3pF61pHCA==
X-CSE-MsgGUID: 3rVW5UpNS5muPbVbZqwFlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190896620"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2025 07:37:27 -0800
Date: Wed, 19 Nov 2025 23:59:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 0/5] rust/hpet: complete moving state out of HPETTimer
Message-ID: <aR3pcja8gtkH0Eb/@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Nov 17, 2025 at 09:47:47AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Nov 2025 09:47:47 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 0/5] rust/hpet: complete moving state out of HPETTimer
> X-Mailer: git-send-email 2.51.1
> 
> This state continues the cleanups of the HPET state, moving fields out of
> BqlCells and into HPETRegisters and HPETTimerRegisters.  It also restores
> the old migration format and shows an interesting trick: HPETTimer is now
> a very simple object that handles the "unsafe" backreference from the
> timer to the HPETState, but it also implements ToMigrationStateShared
> and is stored in the HPETState as Migratable<[HPETTimer; N]>.  I find
> it pretty cool that the composition works naturally.
> 
> The less beautiful part is that I had to modify Timer::init_full for
> this to compile.  It's probably time to work on the final design for
> initialization, because this is becoming very ad hoc and the differences
> between timer, MemoryRegion and Clock initialization have no real
> justification.

<Just some rough thoughts/understanding>

Yes, Timer requires Pin<> and it seems MemoryRegion also should requires
it because of callback...

MemoryRegion requires MaybeUninitField, but it would be not necessary
for HPET, since HPETTimer has already initialized its other field before
calling init_full(). But as a general interface, MaybeUninitField could
be also useful for Timer, as we can't require how device initialize its
field.

Clock's ParentInit<> is also different. We don't need to require
Timer::init_full must be called in init(). MemoryRegion may also don't
need it And some C device even calls memory_region_init_io() in
realize().

Regards,
Zhao


