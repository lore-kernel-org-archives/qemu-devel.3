Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E06CF34C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjo1-0007NF-KD; Wed, 19 Nov 2025 10:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLjnz-0007Ls-LH; Wed, 19 Nov 2025 10:09:11 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLjnx-0001Xb-0D; Wed, 19 Nov 2025 10:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763564949; x=1795100949;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cVX6Lue/ibCk9IL1OhzCw2UyYAsUVDE0KQnDCnBkaHA=;
 b=AM4MM3YQCsyuustLIZmD7cOhUNk+mGf1649OUrnjmSt5nU8BX2KSD7fv
 GQymovTTTfbYpFXEIu/eeWrG5ROYbDvJu5WgDnNfeGSVzmVlGUo0eMmf5
 TiekTur/EZ6kfYXJPjA9zz6fVvOw+cEzwkR7/+d5VvUb9szKbqTjfPNVY
 Ut38dpz9zKyoI2a7PmbP4uGznthUtsqJ5IDkS8MW2kf2RYXfAkM/YJacI
 0s8stXbcxFkZ1czBaI0OvC1AB5Mtsqv4W9snMQJHiSJrOVkPUJVhiYZ0y
 v1NtnklE2cRgYPAZP48BGIErDGHjTup4/hPS/16F3swCVgPp3OR7peAHY A==;
X-CSE-ConnectionGUID: zD0b3JXGQ8OBU2BbSNxYaA==
X-CSE-MsgGUID: aOjA1mUlSvOx/wBA/yRX1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64805557"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="64805557"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 07:09:04 -0800
X-CSE-ConnectionGUID: 4rwafDXQTESpPbTI5xmvmA==
X-CSE-MsgGUID: 28Ie5qvuSBe9LYmRooFB+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191878222"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2025 07:09:03 -0800
Date: Wed, 19 Nov 2025 23:31:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 5/5] rust/hpet: Apply Migratable<> wrapper and
 ToMigrationState
Message-ID: <aR3iyyWXDJoBEfMq@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Mon, Nov 17, 2025 at 09:47:52AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Nov 2025 09:47:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/5] rust/hpet: Apply Migratable<> wrapper and
>  ToMigrationState
> X-Mailer: git-send-email 2.51.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Before using Mutex<> to protect HPETRegisters, it's necessary to apply
> Migratable<> wrapper and ToMigrationState first since there's no
> pre-defined VMState for Mutex<>.
> 
> In addition, this allows to move data from HPETTimerRegisters to
> HPETTimer,

Typo? move data from HPETTimerRegisters' vmstate to HPETTimer's vmstate

> so as to preserve the original migration format of the C
> implementation.  To do that, HPETTimer is wrapped with Migratable<>
> as well but the implementation of ToMigrationStateShared is
> hand-written.
> 
> Note that even though the HPETRegistersMigration struct is
> generated by ToMigrationState macro, its VMState still needs to be
> implemented by hand.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Link: https://lore.kernel.org/r/20251113051937.4017675-21-zhao1.liu@intel.com
> [Added HPETTimer implementation and restored compatible migration format. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 139 +++++++++++++++++++++++--------
>  1 file changed, 102 insertions(+), 37 deletions(-)

yes, the fully hand-written ToMigrationStateShared is really powerful -
it can keep the vmstate layout unchanged even when the struct (
HPETTimerRegisters) has such big changes.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



