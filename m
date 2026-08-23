Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33EC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy3tM-0001Pj-5N; Sun, 23 Aug 2026 04:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3tK-0001Pb-OA
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:49:22 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3tJ-00036P-8s
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787474961; x=1819010961;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KqpTPPlexMgPtEc3la49a5XlMd291GyM/e41GB3+rBI=;
 b=cBQdUn6o5Q9uWK74Zhu655WUYAMoKyJma0UVhY9oTp7dYWJUaQw1+d3B
 GC4+emQFL9Uq82EQqA9B2QcDA478r0prsBSlObtxwxFiLBwWUWfigrKO/
 QTif7SJm/FXayODR4uWGDDXuifHkHPIIRQzoOWiDgzskmQVLwWxheOjJD
 BruElH/qSfS78HOW9d1S547cnoW2avYD5q/anWmIsHZ1eUitYmF3iHebr
 /xA1pyLtsg2Ajy2jwG8f4b7qe4jPC+3yNiBif62cmHOEJc8V6kWyG5NvF
 4bAwePNc7VDUcFyQQxWDLQHflA5G79SBrw7LTyy5ZvmlaUtZuLXJeRVOr g==;
X-CSE-ConnectionGUID: x+XLAPG6RTezCyH+O5cj9w==
X-CSE-MsgGUID: BOddaKsORy61QtSX6129kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="75493246"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="75493246"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 01:49:19 -0700
X-CSE-ConnectionGUID: G+pePID9SfWtrdOLbC2Zxg==
X-CSE-MsgGUID: C7LzF7nRTdO/SnzMNd3avw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="271945344"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 01:49:17 -0700
Date: Sun, 23 Aug 2026 16:49:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 2/9] target/i386: Hide Intel cache CPUID leaves for
 Hygon
Message-ID: <aoq0DKEJTYmfUlAe@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-3-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-3-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Mon, Aug 10, 2026 at 04:29:49PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:49 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
> and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
> information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
> currently skips that filtering and can expose Intel cache leaves together
> with AMD/Hygon extended cache leaves.
> 
> That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
> information through the extended cache leaves, so it should not also
> advertise the Intel cache descriptor and deterministic cache parameter
> leaves.
> 
> Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when the vendor
> CPU ABI compat gate is enabled.  The gate keeps the old CPUID output for
> pc-11.0 and older machine types.

nit: pc-11.1?

Thanks,
Zhao

