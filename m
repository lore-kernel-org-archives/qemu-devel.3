Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69EEC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHzN-0000Yo-49; Fri, 08 Aug 2025 03:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHzJ-0000XJ-RU; Fri, 08 Aug 2025 03:58:05 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHzI-00050v-28; Fri, 08 Aug 2025 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754639884; x=1786175884;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=f17BCqH/n87YEHOn/wUQzGafUtKeGj3M1STeSfJLWAM=;
 b=e/6YdPtbN1ULB3R+kh1p50UHEVfMukwEpFnYgJXltq07UdmkTp9dGg+P
 JFD1H/2D50NgdUbpw0zoALFQQnWQyTVAZuKzw/az/FVylSinGJoNE3jb1
 /Mvsq+JTKIq1cbSyPfnoCep+DY5qQH8u04ORgTt2zBslxkqaPAnZ/Dt68
 qxjOvuu37QdgyFWn7oigkGhbgDacXati2oHn2Ylnl+imb7Jv+hnaYztae
 JQpPTBedPnAEGxcd5rcOQg7DOJlFEA5CBQhtXWUOF2s06PO5tAPbMIPzf
 bhRIhvVWySvuI1PI4cXRME8g/o/VXuzIJqbGpClEaocXfd4JV39NXCeIw w==;
X-CSE-ConnectionGUID: FU3HZwO4Q7qynmwM1w/Tpw==
X-CSE-MsgGUID: WJ3+xd+CRoifOHKnoMmC9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57116937"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="57116937"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 00:57:53 -0700
X-CSE-ConnectionGUID: 9l6oqGecRcmwZdnWDR2Oyg==
X-CSE-MsgGUID: opw0ZfZRQTi8bPUWYgFwZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="164786127"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 08 Aug 2025 00:57:50 -0700
Date: Fri, 8 Aug 2025 16:19:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 12/26] rcu: Make rcu_read_lock & rcu_read_unlock not inline
Message-ID: <aJWzEoIX+MdRuTUK@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-13-zhao1.liu@intel.com>
 <262b5b35-e8f4-4bd7-8e7c-0d2acc2c9742@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262b5b35-e8f4-4bd7-8e7c-0d2acc2c9742@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 07, 2025 at 03:54:06PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:54:06 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 12/26] rcu: Make rcu_read_lock & rcu_read_unlock not
>  inline
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > Make rcu_read_lock & rcu_read_unlock not inline, then bindgen could
> > generate the bindings.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Either this, or keep it inline and add wrappers rust_rcu_read_lock() and
> rust_rcu_read_unlock().

I see, the wrappers are better - we can keep the performance gain from
inline at C side.

Thanks,
Zhao


