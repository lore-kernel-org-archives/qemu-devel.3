Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC29C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 09:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQGu-0000Jn-1J; Mon, 10 Feb 2025 04:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thQGr-0000BG-J8; Mon, 10 Feb 2025 04:40:05 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thQGp-0002Ah-7p; Mon, 10 Feb 2025 04:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739180403; x=1770716403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KEpqM60UEDmVkI4Vct9fFXrYdtydbPC9PXzd0Slxp3A=;
 b=c3oSE1p/MYiXhzJjHOASP5kv89RaRL5Denw3Cns7aVLBLa47l3KbxADf
 CsJ76GrRcJNMd5io77MDSu/XHAdl9u8+X1/ehV96PNV9LVUvx5R3tXLAz
 ByDETRFq+qjjKfB9xo6CNb6jaRaOICWyCN53n4TiLs8rB0/IQ2YxmSRSV
 fZjdDRH4C6RYQ7U8M8Ir9SIzc35sUOY2Bd97XvpvQFnD+a3His+bGmzoI
 sWlN8r3tKMLbOOjN0RtqkTuRRs8CoQq7v94nsVVph5ymVTV8E4kqoGWf2
 4dX/EtC/VCdgM8QISChuZjRe9GJ+UqsamfZV3U3bfdT/0ToJMCA567dGY Q==;
X-CSE-ConnectionGUID: UHrIuQOQR0mfd8lkbV99YQ==
X-CSE-MsgGUID: qqGSdROOS7iY1W5toumTSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38955839"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="38955839"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 01:39:59 -0800
X-CSE-ConnectionGUID: CEOD1DQxRgei3iDwY6x1AA==
X-CSE-MsgGUID: M9pfKFawTsigl+FsBL6ALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="112366544"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 10 Feb 2025 01:39:58 -0800
Date: Mon, 10 Feb 2025 17:59:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] rust: pl011: convert pl011_create to safe Rust
Message-ID: <Z6nOAftJsjQ7KAiS@intel.com>
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206111514.2134895-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

On Thu, Feb 06, 2025 at 12:15:14PM +0100, Paolo Bonzini wrote:
> Date: Thu,  6 Feb 2025 12:15:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: pl011: convert pl011_create to safe Rust
> X-Mailer: git-send-email 2.48.1
> 
> Not a major change but, as a small but significant step in creating
> qdev bindings, show how pl011_create can be written without "unsafe"
> calls (apart from converting pointers to references).
> 
> This also provides a starting point for creating Error** bindings.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
>  rust/qemu-api/src/sysbus.rs      | 34 +++++++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 23 deletions(-)

...

> +    fn realize(&self) {

What about renaming this as "realize_with_sysbus"?

Elsewhere, the device's own realize method is often used to set
DeviceImpl::REALIZE.

And this realize here is meant to call the realize() method defined on
the C side, so to avoid confusion we can avoid the same name? It's up to
you.

> +        // TODO: return an Error
> +        assert!(bql_locked());
> +        unsafe {
> +            bindings::sysbus_realize(self.as_mut_ptr(), addr_of_mut!(bindings::error_fatal));
> +        }
> +    }

This is a nice patch that shows more about how to use Owned<>!

(BTW, I guess this patch is not the stable material. :-) )

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


