Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E8CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFq3M-0004YD-HB; Fri, 16 May 2025 04:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFq3K-0004Xm-Lu; Fri, 16 May 2025 04:04:22 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFq3I-0002FP-AP; Fri, 16 May 2025 04:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747382661; x=1778918661;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7b4nvI1MvB9YZP0pWa1C/UeWUie+EGReQxSWstaRgaM=;
 b=mq5glpraA/XmlmfjrNDVZUgB663fEE9mmRfXMfatt67t8YSSkUPafOrR
 VkF493R0UB0UrHAn6tkj3x51Nrgds2xfkNfNm22sTgRv9oRtF/YGMoLll
 vVQzblFTPhYFT3k4/UQm0dQ9E+OBl1nTOk1WMHH/ho/GAd7iWW9udXry1
 x3Rm7K4zT6vbdSeK8bHLY4EBxd4/HK/j4rzEyW3PugNHDGLcZQiNgqin+
 +o9Al1ETAV6NClzQvCPMTqx17CS06DiNQn4rgo9irfs0tMYqWbSRag0PY
 FiI4DdF4QNVVi37PuarX+EtlLENi3fhstSPX0egI1mlKB43zWftkLOg8W A==;
X-CSE-ConnectionGUID: D4lZNisxRyOmcA4UAWxlMg==
X-CSE-MsgGUID: L80bgw3ESHqV5efwtdUKcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53160437"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="53160437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:04:15 -0700
X-CSE-ConnectionGUID: NnWw16CPQ7ik8k1T9vzn7Q==
X-CSE-MsgGUID: dV/xO8MLRuak0W2uvtOXkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="169556417"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 16 May 2025 01:04:13 -0700
Date: Fri, 16 May 2025 16:25:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped in
 BqlCell
Message-ID: <aCb2bvoJQ2NxCkqz@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-3-zhao1.liu@intel.com>
 <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

> > HPET currently wraps num_timers in BqlCell<>. Although BqlCell<> is not
> > necessary from strictly speaking, it makes sense for vmstate to respect
> > BqlCell.
> 
> Dropping BqlCell<> from num_timers is indeed possible.

Hi Paolo,

I would like to further discuss whether there's any safe issues.

num_timers is a property:

    qemu_api::define_property!(
        c"timers",
        HPETState,
        num_timers,
        unsafe { &qdev_prop_uint8 },
        u8,
        default = HPET_MIN_TIMERS
    ),

Then this means someone could set this property in C side or Rust side
by:

DeviceState *hpet = qdev_new(TYPE_HPET);
qdev_prop_set_uint8(hpet, "timers", 8);

(Though we haven't provide safe interface at Rust side to set property.)

Whatever this happens at C side or Rust side, this depends on QOM core
code (in C) to overwrite the HPETState::num_timers directly.

Then after the call to qdev_prop_set_uint8() starts, all subsequent
processes happen on the C side, so even though the rewriting of num_timers
is runtime, there are no additional safety considerations because it
doesn't cross FFI boundaries. Am I understanding this correctly?

Thanks,
Zhao


