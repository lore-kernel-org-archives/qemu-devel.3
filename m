Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC4C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 03:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u35I9-0001WP-Iv; Thu, 10 Apr 2025 23:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u35Hs-0001US-RW; Thu, 10 Apr 2025 23:42:40 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u35Hq-0000Q8-Aw; Thu, 10 Apr 2025 23:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744342958; x=1775878958;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Unn0HrY1GqhIzLNRhYl27mv1Bs3adfSbtXgW1AwiTPM=;
 b=lfe9MmTl/bUaNMdYXtqQTql/RZ6KHfnUhpsm7fFkCGzJ1GtILFvHdAhp
 UanvYavVfbWH6ArFO41T2bxLRFDS15/0uUtaIobvviNVrp48FO2quq4r/
 /fdlH66e+czUZQZz0CJqY51SSgWXh2OL2zNgSBmD1IdxKehS+E3iOsSeu
 cIGUjrcWaRR7lw5EAc3kvz2x8Vky3zmMUmIwmQSTvP1vHg5wi+fUlCIeB
 WMEcx7z2mWlZIxJE5M+QZyB/mnEm0Jk8078r1z+RU8pZu453hUYt0ssFb
 HqH0ruvQ2VKsYt7MLz2ok1rn5cRgcqbmWcRm9nwD5Riw4P2SnRJDRJINI A==;
X-CSE-ConnectionGUID: /ZXzQEmBRwOALe5Y4QE5fA==
X-CSE-MsgGUID: +8jhTM3pTCKwI9kORgeQ+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="57267122"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="57267122"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 20:42:34 -0700
X-CSE-ConnectionGUID: w7dsJle3QNShfhjz9E7PMQ==
X-CSE-MsgGUID: QRKgM4I6QYGyCZcOaNygPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="152270786"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2025 20:42:31 -0700
Date: Fri, 11 Apr 2025 12:03:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z/iUiEXZj52CbduB@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qo8yu5u.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

Hi Markus

On Thu, Apr 10, 2025 at 04:21:01PM +0200, Markus Armbruster wrote:
> Date: Thu, 10 Apr 2025 16:21:01 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Introduce the kvm-pmu-filter object and support the PMU event with raw
> > format.
> 
> Remind me, what does the kvm-pmu-filter object do, and why would we
> want to use it?

KVM PMU filter allows user space to set PMU event whitelist / blacklist
for Guest. Both ARM and x86's KVMs accept a list of PMU events, and x86
also accpets other formats & fixed counter field.

The earliest version uses custom parsing rules, which is not flexible
enough to scale. So to support such complex configuration in cli, it's
best to define and parse it via QAPI, and it's best to support the JSON
way.

Based on these considerations, I found "object" to be a suitable enough
choice.

Thus kvm-pmu-filter object handles all the complexity of parsing values
from cli, and it can include some checks that QAPI cannot include (such
as the 12-bit limit).

Thanks,
Zhao


