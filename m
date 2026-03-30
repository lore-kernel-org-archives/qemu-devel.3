Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4968CFF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DUH-0005s2-1M; Mon, 30 Mar 2026 10:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7DUB-0005p2-OJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:21:00 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7DU7-0001Lf-HB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880455; x=1806416455;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=22GkSOAtYDFxxAHLYXg5xg2/hA3MQ/7dJYjD3LB6oAE=;
 b=Ta5jgClRwszgllbTlN6xs5CGU/D0H4f2/FcFSF4nhXJ6XR/lY3/zaS2m
 wiArl+11AqjqwXAENkIi1fBhGZvuDOXPs2SZE0biYbdvGKG0EpRCi1AYv
 J4Pew8VEF8c1kwBbsdJarkVJQQc+pJMo9T12Pzqe3igQWB8Of1nNLrRmm
 MEOP4YjVnmUTKm4nC2kqGqU3xKt2oad08W6Ss99DZg/9guEl3HZj8Q94o
 LVBYpfIUusMrD7K2fvyo0VoXBH6qHLS0m2idJTUBLa9lPk7UOxK82/kVf
 7XQJwWCUj+1rXPE0xdpBjArF9UAkE1GyATmLM8V29ZF0mov+8+dvobe9H A==;
X-CSE-ConnectionGUID: jwkr50wfTk+A00KkPTaNiA==
X-CSE-MsgGUID: iVspQ8n+QYSvzKw3sDx3JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86492359"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="86492359"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:20:50 -0700
X-CSE-ConnectionGUID: 6iaOF4yXSNCzgwoqiFSmVA==
X-CSE-MsgGUID: 32h/nnPFTzGf032SMZQANQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="230982557"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 30 Mar 2026 07:20:48 -0700
Date: Mon, 30 Mar 2026 22:47:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
Message-ID: <acqM6oef6t5F7d5g@intel.com>
References: <20260327174701.364328-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327174701.364328-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

On Fri, Mar 27, 2026 at 06:47:01PM +0100, Paolo Bonzini wrote:
> Date: Fri, 27 Mar 2026 18:47:01 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] hpet: fix bounds check for s->timer[]
> X-Mailer: git-send-email 2.53.0
> 
> Fix an off-by-one issue in QEMU's HPET read and write MMIO handlers.
> Both handlers check timer_id > s->num_timers instead of timer_id >=
> s->num_timers, allowing a guest to access one timer beyond the valid
> range.
> 
> The affected slot is initialized properly in hpet_realize, which goes
> through all HPET_MAX_TIMERS elements of the array, so even though
> it is not reset in hpet_reset() the bug does not cause any use of
> uninitialized host memory.  Because of this, and also because (even
> though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
> its MMIO region, the bug has no security implications.
> 
> Commit 869b0afa4fa ("rust/hpet: Drop BqlCell wrapper for num_timers",
> 2025-06-06) silently fixed the same bug in rust/hw/timer/hpet/src/device.rs.
> 
> Reported-by: Yuma Kurogome, Ricerca Security, Inc. <yumak@ricsec.co.jp>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


