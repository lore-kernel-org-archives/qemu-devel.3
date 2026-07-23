Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4019C4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmjOc-0005zS-Jl; Wed, 22 Jul 2026 22:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmjOP-0005zD-7P
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 22:42:38 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmjON-00051T-7S
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 22:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784774555; x=1816310555;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=D75lHRFvWmF9lxanQemdnAMDVuUlBgaMm0WdTtGTIqo=;
 b=K6o7Q0ZN/FTNJDcpfQN/scZyuGqw3hD4mVforkuUleaPcN4YMtyjr/7+
 Z8azT2imGdA0kJKmYOo/uyliRBRF5nn0bvMiiX0zubElDZkQhE/qTBkXS
 NnQzfK38TCxD4+Gb+sI2Ec+zHFXpSkr8vYu0XxdS7Yl0btgIsJokU8yMB
 QymP5JjHTAEKiMNa86astsigmy5pxMqsDFAmm0QzP5UN32AJvix9IjP6L
 Iyom7CymC1fuwt1GnF21lwJrojqQV98Fg8LBCNfjs6jPdx5vp7hReeDwe
 S43wkTZ3+7QDRoHfiXPi5ATQnBW4JzQCphr4KS7p50oVx9nDgONCphZJv g==;
X-CSE-ConnectionGUID: J3h3sJ2KSbS1Ybyc4Meqpw==
X-CSE-MsgGUID: OOBitB1TSnGSpeWwtUkMgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110965147"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="110965147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 19:42:25 -0700
X-CSE-ConnectionGUID: IwmRagy9Qdu6Qmig/O2MtA==
X-CSE-MsgGUID: nhRtksXeSUSsmCY2tNiB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="258962009"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa009.jf.intel.com with ESMTP; 22 Jul 2026 19:42:23 -0700
Date: Thu, 23 Jul 2026 10:42:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <amF/jqXf2oWsFrF2@intel.com>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Thu, 21 May 2026 18:54:51 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
>  gpa2hva callers
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.
> 
> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/system/memory.h | 2 ++
>  target/i386/sev.c       | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


