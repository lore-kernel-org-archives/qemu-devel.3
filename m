Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCCCCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYH9-0004SG-Dr; Mon, 25 Aug 2025 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqYH2-0004Qt-Qt
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:34:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqYGr-0001po-U9
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756132447; x=1787668447;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=imi/f3yNw4/LFCttWtHo4cWvZgy9220sGCMMpL2c6gc=;
 b=gg7x/eYwh0bBCIAn0fCNJeGFVs3f8AypJtdFjBMYNDA8+LZNBS/kS0zL
 jujRCNTx5VLlPB/klR8wSUwwLiWxTdGwPj3Y7uqL/yUshisoQe1PihQZV
 nAJBAI9UdcYXEjr+d959BeEsEiZqTuQzSwkAxIRTvtDSAJLwo6OqAnSPX
 dLTR8iB8UpRp9UFT76ufy6m5nR6Z6idrSipOAi0eYCxnV8mMKIcxG6ckn
 M4qt7LZAKFX4iAP2jlN2yZNSkRvuPrecc2737Zw2hdPMxA+RNSGQ4aKdd
 ES8qNZj4TN7b4KKtRCi1eKY+YLfN2iacSeQVr47Xbl9xSjLhIbvjZOxAz w==;
X-CSE-ConnectionGUID: r+pgT9kXTy6Ekt3EPSh8zA==
X-CSE-MsgGUID: LdYqVEKRRDawI/vaMaUgDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69446976"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="69446976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 07:34:00 -0700
X-CSE-ConnectionGUID: IjA/+oOiRUSfWun/5ff1ZA==
X-CSE-MsgGUID: WKl4KgC/Tm24SFmKQ59m1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="168821675"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Aug 2025 07:33:58 -0700
Date: Mon, 25 Aug 2025 22:55:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com
Subject: Re: [PATCH v4 5/8] hpet: make main counter read lock-less
Message-ID: <aKx5b7VH1p0NHxjL@intel.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-6-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814160600.2327672-6-imammedo@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 14, 2025 at 06:05:57PM +0200, Igor Mammedov wrote:
> Date: Thu, 14 Aug 2025 18:05:57 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v4 5/8] hpet: make main counter read lock-less
> 
> Make access to main HPET counter lock-less.
> 
> In unlikely event of an update in progress, readers will busy wait
> untill update is finished.
> 
> As result micro benchmark of concurrent reading of HPET counter
> with large number of vCPU shows over 80% better (less) latency.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
>   * make reader busy wait during update and reuse existing seqlock API
>        Peter Xu <peterx@redhat.com>
> ---
>  hw/timer/hpet.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
 
...

> -    QEMU_LOCK_GUARD(&s->lock);
>      if (addr == HPET_COUNTER) {
> -        if (hpet_enabled(s)) {
> -            cur_tick = hpet_get_ticks(s);
> -        } else {
> -            cur_tick = s->hpet_counter;
> -        }
> +        unsigned version;
> +
> +        /*
> +         * Write update is rare, so busywait here is unlikely to happen
> +         */
> +        do {
> +            version = seqlock_read_begin(&s->state_version);
> +            if (unlikely(!hpet_enabled(s))) {

is there any particular consideration for rearranging the order of the
conditional branches here (and not directly using likely(hpet_enable()))?

> +                cur_tick = s->hpet_counter;
> +            } else {
> +                cur_tick = hpet_get_ticks(s);
> +            }
> +        } while (seqlock_read_retry(&s->state_version, version));
>          trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
>          return cur_tick >> shift;
>      }

Nice imprvoment!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


