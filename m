Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DABCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpdE-0007J2-4n; Tue, 26 Aug 2025 05:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqpd3-0007H5-EO; Tue, 26 Aug 2025 05:06:09 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqpcr-00049Y-NX; Tue, 26 Aug 2025 05:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756199158; x=1787735158;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VX51ebEyrWm0HdDAd809OGo61vSaBYsgcvkQMbax4Z8=;
 b=IxAeoNIXy1RQMvNaKbFf4oHUFQksegWSFg+BUL30gfochu/qF7Ln/59E
 RA5QfEI66x76Sulizh15gcZq7Z4Y43Y1810P6Scd1SQmCVD8SoDaqY6TM
 GywxXh4g6wbXggg/WhTkcUKNBRNtLoIKY1hKGyhighAs/sSO4POJSB7Rg
 TZWwr38hWyLE8XAtcBHEE9rKi+hoFbH1Bsmei+xA7WhlsbqZbLcU+YV6h
 LFN28ai/bgqzU044Xfv7yc8vb9jcGzithC6jiNWWCToR+I0Q7uVeZAmoo
 dIz18uIL609aLKMQ5vGvy0Hr6c1qvackE/aNzsY+UW6/FW/vKVborltkK Q==;
X-CSE-ConnectionGUID: Ci4VCt2BR0yDVjuch4E4Eg==
X-CSE-MsgGUID: 4a8MVIlyRgm6RdEUhmT57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58483348"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58483348"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:05:50 -0700
X-CSE-ConnectionGUID: NUVChn6JT9e22n0N2AiNYw==
X-CSE-MsgGUID: 7/Vr3fU1RqWA85ZPsXek2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="170346575"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2025 02:05:41 -0700
Date: Tue, 26 Aug 2025 17:27:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 mst@redhat.com, mtosatti@redhat.com, richard.henderson@linaro.org,
 riku.voipio@iki.fi, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, david@redhat.com, jjherne@linux.ibm.com,
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peter.maydell@linaro.org,
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de,
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu,
 reinoud@netbsd.org, sunilmut@microsoft.com, gaosong@loongson.cn,
 laurent@vivier.eu, edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <aK19/6P9325hYBO9@intel.com>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
 <aK1mHGan+n9NSAOk@intel.com> <20250826104731.1440e3ed@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826104731.1440e3ed@fedora>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> > Behind this helper, I mainly considerred the case of multiple writers:
> > 
> >    thread 0      .        thread 1
> >                  .
> > load:  x         .
> > OR:    x | a     .
> >                  .
> >                  .      load:  x
> >                  .      OR:    x | b
> >                  .      store: x | b
> >                  .
> > store: x | a     .      (x | b is missed)
> > 
> > In the above case, "load" means the direct access:
> > cpu->interrupt_request w/o protection, and "store" is done by
> > qatomic_store_release.
> > 
> > The memory order is guaranteed, but the operation result of thread 1
> > seems lost. Only BQL or other mutex could avoid such case.
> > 
> > qatomic_store_release is already a great step to avoid issues outside
> > BQL, so I'm not sure if it's worth going further to ensure atomicity,
> > especifically for multiple writers (my initial understanding is that
> > iothread or callback may have multiple writers, but I'm also a bit
> > unsure.). The overhead is also indeed an issue.
> 
> it looks like we are always holding BQL when setting interrupt.
>
> However currently we also have places that check interrupts
> without BQL but without using any atomics. This patch aims to ensure
> that proper barriers are in place when checking for interrupts
> and introduces release/acquire pair helpers for cpu->interrupt_request,
> to ensure it's don consistently.

I see. this makes sense and qatomic_store_release is enough. 

> While overhead might be issue, it's better to have correcteness 1st.
> (that's why blanket tree wide change to make sure we don't miss places that
> set/test interrupts).
> 
> Then if performance issues were found somewhere, as was suggested
> in previous reviews, we may opencode that place without barriers
> with a mandatory comment/justification why it's okey doing so.
> (well, at least that's the plan)

I agree (and sorry for my misleading words; my initial thought is
qatomic_fetch_or has worse perfermance.)

Thanks,
Zhao


