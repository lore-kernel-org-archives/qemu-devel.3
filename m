Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1509FD41C21
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTegd-0007Qw-Ml; Thu, 11 Dec 2025 06:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTegb-0007O0-Go
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:18:17 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTegY-0003Hl-TU
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765451895; x=1796987895;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/PavwmTPXgf2RFgfCgkbjsWUgrq8AQllM7S/czmU9N0=;
 b=n8cBTnCz0v/eqhxv09I/m1+pGhyC3MRs0B/jktfWvXJG1qGwjpjXzRtc
 0Rm13Gj0BbwOIyplvVoVvfq7l1K9GdSxRJwPc+EiVW8LxQ+fbh7FSPDYS
 wSzO44a364iqFITVIGo6iNEGyZnqaPV67sWB0FRKg8THhFjByQhuXx3zJ
 QBSC/QO+XVxVIlK0RTFVzCSfuUuTKousORrBa5hJHRd/27s2TJcF4UZ6P
 qkLIZ8DHNzIiNDhI3uKoBG1+FRRySKVedL3FYCn/OwKhfsSuxB6/18LK2
 Glf826nH6wjyL4wzatO8VD5sGvi9HQrKrg/160RivYsVDAC4gKWIhn5RM A==;
X-CSE-ConnectionGUID: LLrRCT89Q8m7D788sJM8TA==
X-CSE-MsgGUID: 74/HNoJ8RvShYQD+Ep6WkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78135212"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="78135212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:18:12 -0800
X-CSE-ConnectionGUID: n7oOztxsS0C0JqrUfAh9tQ==
X-CSE-MsgGUID: yNbwLSB4TqaHeCzHM6soxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196384546"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 03:18:10 -0800
Date: Thu, 11 Dec 2025 19:42:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v2 0/9] i386/cpu: Support APX for KVM
Message-ID: <aTquQJkiwKmuqCG2@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
 <16e0fc49-0cdf-4e54-b692-5f58e18c747b@redhat.com>
 <aTqMBtkOxx6mZhn+@intel.com>
 <df96afb2-f99c-48ae-81be-ccadf0fc3496@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df96afb2-f99c-48ae-81be-ccadf0fc3496@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

> No problem, I have done a quick pass with "sed" on the patches and reapplied
> them.  I do ask you to respin the Diamond Rapids series though, on top of
> the for-upstream tag of https://gitlab.com/bonzini/qemu (currently going
> through CI).
> 
> Applied for 11.0!

Thank you!

BTW, could you please have a look at this clean up on outdated SPR
comments:

https://lore.kernel.org/qemu-devel/20251118080837.837505-1-zhao1.liu@intel.com/

I feel it's better to clear SPR comments before DMR touches AMX.

Thanks,
Zhao


