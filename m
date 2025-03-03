Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52DC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5Ur-0008Ss-Vv; Mon, 03 Mar 2025 08:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp5UL-0008QV-My; Mon, 03 Mar 2025 08:05:42 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp5UG-0004Qx-3c; Mon, 03 Mar 2025 08:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741007136; x=1772543136;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BupHBMcxndG1/34byelERShPD4ASM2wipL/29vh3UNI=;
 b=NlztvbiIR27uqRtrKsWmUnknjc/LoN0DBzGbaiH9NipL81DVgh+QfJ0L
 rZzyAFpCJYA2ayPfS1z5kwbAqJNCRP1JJynlqnYKAgWViTED1Qoq/vwtX
 /3W87duHgu7ro7v41USyqR4YgcjjcX8+vFI4LvlOJd6ZS7PJsOnc3KwAa
 h3DFEMUWTMjz6LFGFltnJ8xlVi8iJ7e/6ylAD/LHM9ALLHS6gAL4uHocu
 UPtR6JkJqb6oKnvcFCSt6TsmsP3l3LqFoctfFOdV5E4yD5vgHmqx/XVl4
 7ihQbo/1Pdw7Q78JIjanLZYip6bBj5adQy7QUsmd4Bk4OI0uWtksLBSuU A==;
X-CSE-ConnectionGUID: 5mece1QXT7atyR/fffw0AQ==
X-CSE-MsgGUID: UdCTgOKfR6SCKxaeRk3ejg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59428050"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="59428050"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 05:05:32 -0800
X-CSE-ConnectionGUID: fRG56yIMREGGmi8eKvA66w==
X-CSE-MsgGUID: /FOALo9/TyqRmnm3BJMUcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="117993308"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 05:05:30 -0800
Date: Mon, 3 Mar 2025 21:25:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/12] rust: vmstate: add std::pin::Pin as transparent
 wrapper
Message-ID: <Z8Wt0RW/us8jxEoW@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 27, 2025 at 03:22:10PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:10 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/12] rust: vmstate: add std::pin::Pin as transparent
>  wrapper
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


