Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4B4C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy4Lo-0007fE-5t; Sun, 23 Aug 2026 05:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4Ll-0007bY-Sd
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:18:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy4Lk-0000iJ-DJ
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 05:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787476724; x=1819012724;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6PT7rVuergyvwcyknrw1osn6+HOn5S0E1P3dvLxa5h0=;
 b=Darz2bazjkJEddspZjaC0tdwXeeHx3plYSmHbwXf0K5BH+BXszzWMBb8
 HOzE9FAon3AkGsboa06Izr+LwgUXvq4eMZZfI00GNphPXei1G6qFTD072
 F71+ecwHe4FA9EAwNwSYfvtZgxPxyDJux3nFSUI+2EeqsnWNhu0dcJ8qq
 xZlfXcCSbApno9Jep/hGqO/OdMKoR4t3bevd6oAN5pzjF/dZcnWPC/kUH
 ygqUfm/dbJPcFUgxN8sMuBisr9FqEiCjD3MSTcMJpWqj6AhPspdU2VAj4
 iACgujegJNwFU6ALUJ8kefS3ph6ZNwVEZROjniHFLjTBqE9teQyGKnarl A==;
X-CSE-ConnectionGUID: /3kytzuBQBqnrhnks2JZKQ==
X-CSE-MsgGUID: uGCbRn2eRPmtZOdETg6w1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="99309098"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="99309098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 02:18:42 -0700
X-CSE-ConnectionGUID: FDGporQuThWjmzNAJScqmw==
X-CSE-MsgGUID: pT3IMHInR4m+vAAJQnqRMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="271949254"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 02:18:40 -0700
Date: Sun, 23 Aug 2026 17:18:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for
 Hygon
Message-ID: <aoq68Lm82kTfEWYN@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-9-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-9-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Mon, Aug 10, 2026 at 04:29:55PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:55 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 8/9] target/i386: Use AMD legacy cache fallback for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
> model.  It selected the AMD legacy cache table only for CPUs with the
> AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
> explicit compatibility path fell back to QEMU's old Intel legacy cache
> table.
> 
> The wrong table is visible through AMD extended cache leaves.  With the
> Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
> 0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
> uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
> extended cache leaves.
> 
> Use the AMD legacy cache table for Hygon in this fallback path when the
> new vendor CPU ABI is enabled.  Keep the old fallback for pc-11.0 and

nit: pc-11.1.

> older machine types through x-hygon-vendor-abi-fixes=false.

Thanks,
Zhao


