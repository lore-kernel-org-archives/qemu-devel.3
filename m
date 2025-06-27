Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC7C7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 02:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUykX-000377-HN; Thu, 26 Jun 2025 22:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUykR-00036Y-FS
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:23:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUykP-00030H-IC
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750991005; x=1782527005;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=khoZeGPwgU5Hra3XCMmdt3c5kfTHgJq0dsqQgxHsB5o=;
 b=PIzOW8iawE1xLyX9xCS7EAG2q89PzG8bScFh7S0Kls3NzzMT7KkMUjdO
 H8Wz4vBdWf5uLmpISLzzQBmQBvYzTjCSPgCyx8Aj5WGyp6U8NwC/A8buo
 YtYLBLEGe3YSGFI1EzJPeE9Buq0aIaVSG3WYHt+FA3K11wl+GBcTFQ9dC
 dOpOcytYg8yPYIuaRJowBQQvHPQZjxftq3hPBUngyxpTHpr5NNf73wsBe
 pTkycruhocbG3wnOz7LmycpvJGdsLCIn1fVhYesiXJwg817Vm+IKY0+tc
 FYJ0oEQQV/Bu9fGOToIWdmqb2fMgYmIA7AveC+3CrUKppkpnhE9bS5akt w==;
X-CSE-ConnectionGUID: /xdtBlhZTbCEyYKDswU5PA==
X-CSE-MsgGUID: 28XJUPHFSTmzQbQkthGM7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="63560027"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="63560027"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 19:23:19 -0700
X-CSE-ConnectionGUID: GuD71LP5TS6Kmux6WRhQIA==
X-CSE-MsgGUID: Nym2nvKITvO+CD4KyKSRmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="183575212"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 26 Jun 2025 19:23:15 -0700
Date: Fri, 27 Jun 2025 10:44:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Pu Wen <puwen@hygon.cn>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 05/16] i386/cpu: Consolidate CPUID 0x4 leaf
Message-ID: <aF4FlifQciTFxNpv@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-6-zhao1.liu@intel.com>
 <fe3c59c0-446c-4e93-9a8b-32c5314df401@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3c59c0-446c-4e93-9a8b-32c5314df401@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

> > +/* Encode cache info for CPUID[4] */
> 
> Maybe this should be /* Encode cache info for CPUID[2] */ ?
> I'm not sure.

Yep, you're right! The following function is used to encode CPUID[2]
as its name indicates.

> > +static void encode_cache_cpuid2(X86CPU *cpu,
> > +                                uint32_t *eax, uint32_t *ebx,
> > +                                uint32_t *ecx, uint32_t *edx)
> > +{

Thanks,
Zhao


