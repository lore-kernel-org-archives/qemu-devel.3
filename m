Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3BC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbAZ-0002kD-3o; Wed, 05 Feb 2025 03:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfbAX-0002jl-Vc; Wed, 05 Feb 2025 03:54:01 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfbAV-00014y-W0; Wed, 05 Feb 2025 03:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738745640; x=1770281640;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IWWAHcSVrzMYLkR/9OBX/FJ6/zwJPQ2ZQSugd41Tpuc=;
 b=HA1oY9TBjqSCgOm6q8Oc0U8wRd4YUiuTpA5bwAUP2g7zVrvw8L3MlmUo
 9hO2FlJy3SvXqv4B076LcLCQIDNVgxoAFTLpbjIinre4KD97OOknlR0ED
 mOKN6umXdhG6VRCc7lrYQmtefmNfcw7XkCnRkPG9XfVkLyhDEfB/5Bs+E
 FJZyjIbx16qK3GLmPgZYSsx5twlLJUBe8xFx63ez57tfzyrILNoHpxmyV
 UPXDoothcO1cVRZRnKudbJjiDRP3paHmK1dNNMEEskv32CLaGcumVO9f2
 t9Ev8CH6HVSAnA3NA0lDliAXHy30ojYiJ8g/IX5eGpiiMfyqDTZ+TCjQ2 A==;
X-CSE-ConnectionGUID: 2BUGaAjbRIaEGly9CIKkBw==
X-CSE-MsgGUID: XREHNBNiQ7y2k7C/OPKYcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38507530"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="38507530"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 00:53:56 -0800
X-CSE-ConnectionGUID: ZsvX12Y7TpuiE6cl+NdHMw==
X-CSE-MsgGUID: k0I1n5GiTG6JXHNw3VqqAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111278749"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 05 Feb 2025 00:53:55 -0800
Date: Wed, 5 Feb 2025 17:13:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z6Mrs4l+fRF7jcay@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
 <Z5c8gVcUn4rzVpID@intel.com>
 <CABgObfbLaHXtoGAkUVW9CUXio-N_1A=Awq0=ZCY3G8sAO+9NXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbLaHXtoGAkUVW9CUXio-N_1A=Awq0=ZCY3G8sAO+9NXQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

> > * The use of from():
> >
> >                 let clk = bindings::qdev_init_clock_in(...)
> >                 Owned::from(&*clk)
> 
> In this case the C side wants to manage the reference that
> qdev_init_clock_in() returns; it is dropped in
> qdev_finalize_clocklist(). So Rust code needs to increase the
> refcount.

Pls forgive me for one more question about qdev_init_clock_in() on the C
side. :-)

qdev_init_clock_in() didn't unref `clk` after object_property_add_child(),
so it is intentional, to make the ref count of `clk` be 2:
 * 1 count is held by clocklist until qdev_finalize_clocklist().
 * another 1 is held by its parent via QOM Child<>.

Am I understanding it correctly?

> > Then the comment "the clock is heap allocated and does not have
> > a reference" sounds like a conflict. I'm sure I'm missing something. :-(
> 
> Changed:
> 
>       // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
>       // does not gift the reference to its caller; so use Owned::from to
>       // add one.  the callback is disabled automatically when the clock
>       // is unparented, which happens before the device is finalized.

LGTM.

Thank you very much for your patience. I think I understand ref count
now.

Regards,
Zhao



