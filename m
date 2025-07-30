Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4544AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh9VB-0001dZ-FE; Wed, 30 Jul 2025 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh8GX-0006Tw-Cy
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:58:50 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh8GV-0005tw-9o
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753887527; x=1785423527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZKgCRgj2pivBAk6HTuo4+FyFAbQvfptt2LINVrlM3F8=;
 b=fcayMvHD+W3ZlPvvKBXKLCY69PgApBdxAoDWu/mol5adertSfzGPZZQX
 ATQXKx0BFi5NNR7nxAOMx+/duESzP7HgwHvoNqrtWWqJZjydznFKsnlIw
 s28CwNMekGe9RqjNzeTxVudz716MtkcrGeBeIrnroSRbsdOQlPa5qdc/r
 0vkCJhh+up/uiO6DAwPOwkACFPCAFvzvteJ3SgiNYP0zY+TXu4p1k9uQK
 CBHvXScc1bTciM4RUSCUGt9Sn0hiCoivfdJ0ljtATue4aRQ28w2wtqR5R
 hYv5mSYvYdAyTWysAMmFx9iwXSszvCXjZIC9kAdMdywr9qAdTXOWDdfXC A==;
X-CSE-ConnectionGUID: GsiE5eevQTaaRQib/3WW+g==
X-CSE-MsgGUID: /i+nc+HvQ0iQDEWciAswyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="43794908"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="43794908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 07:58:44 -0700
X-CSE-ConnectionGUID: yqqxlFHhRDWJ9a0rFoTatg==
X-CSE-MsgGUID: rDwcskMaSPeMVBxl834b6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="193855421"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 30 Jul 2025 07:58:42 -0700
Date: Wed, 30 Jul 2025 23:20:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Message-ID: <aIo4MxukAiY0OSGE@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com>
 <aInTujVM5hr6/cJw@intel.com>
 <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a28dcb-88b2-4a7e-a782-a06d915e1654@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

> > > +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
> > 
> > It is worth mentioning in the commit message that directly sharing
> > MemoryRegion in CPUAddressSpace is safe.
> 
> It's unnecessary to me. It's common that different Address space share the
> same (root) memory region. e.g., for address space 0 for the cpu, though
> what passed in is cpu->memory, they all point to system_memory.

For cpu->memory, there's the "object_ref(OBJECT(cpu->memory))" in
cpu_exec_initfn().

But this case doesn't need to increase ref count like cpu->memory, since
memory_region_ref() provides protection and it's enough.

This is the difference.

So it sounds like now it's more necessary to clarify this, no?


