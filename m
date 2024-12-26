Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC5E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 04:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQfUL-0007H3-OL; Wed, 25 Dec 2024 23:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQfUK-0007Gg-92
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:28:44 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQfUH-0001r1-Vj
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735187323; x=1766723323;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TpqQeKz+7ggBjXK1BXiALbEaG7Rw/pPEbndqbbhYDQY=;
 b=hq2sA6KSEmz8aXHfuNJ3Id3fA9pusKabMqyfl7e8gKSYTpS5ClHkCtjb
 4jDdK+RKpeY3tEeFGrRgxkXXdlFwFNr/3/UcN9kS3W67ilwXOlJM8u/oa
 ElDNwFgwC8Gh/JYPz1B2pJEmaMHgb7blXs6RNXQvIG9aIqH4iNwsFWXVx
 mWdYSvKmoyuUL0yzh8kyE/g0KUpwOgPVigR1ZSKG6voq/SmgsaexhcdaX
 /40zCSdhLYd5OtBr8VOPCt6pcXhF/2JAA8A8EfDle9BaKfrOC10c3u8OU
 FQVbET/197gpy58VCfUDhvjS2GayJIrtWd3rork4WgHv4gMyB8coNCM1U g==;
X-CSE-ConnectionGUID: 3c3jD/FrTPebxJO9Uh26/w==
X-CSE-MsgGUID: wHXsA0vHRC+cw57eCpt9Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="53010622"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="53010622"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 20:28:40 -0800
X-CSE-ConnectionGUID: coRkUP5iQUW6zcQNINGmnQ==
X-CSE-MsgGUID: TS5owItfSJGrGo2ru6sJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="99704724"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 25 Dec 2024 20:28:38 -0800
Date: Thu, 26 Dec 2024 12:47:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 09/12] rust: qdev: expose inherited methods to subclasses
 of SysBusDevice
Message-ID: <Z2zf2ZQFq7vL7yJV@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:51PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:51 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/12] rust: qdev: expose inherited methods to subclasses
>  of SysBusDevice
> X-Mailer: git-send-email 2.47.1
> 
> The ObjectDeref trait now provides all the magic that is required to fake
> inheritance.  Replace the "impl SysBusDevice" block of qemu_api::sysbus
> with a trait, so that sysbus_init_irq() can be invoked as "self.init_irq()"
> without any intermediate upcast.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  6 ++----
>  rust/qemu-api/src/irq.rs         |  3 +--
>  rust/qemu-api/src/prelude.rs     |  2 ++
>  rust/qemu-api/src/sysbus.rs      | 17 +++++++++--------
>  4 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


