Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC96D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW81b-00061k-CL; Thu, 18 Dec 2025 02:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW81Y-00061G-FM; Thu, 18 Dec 2025 02:02:08 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW81W-0005Ua-Ny; Thu, 18 Dec 2025 02:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766041327; x=1797577327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SVgM/n1v4fzCKsePS0J3ggBaXEGDmRcBzlKaAToDQEk=;
 b=C1CQaCYFwwl899G0eqBn7oXtRVdyuvqlBJtRbQaEStu7jsCDooS7sqmG
 PHGcdH1a1vLtpFU/0iWV69cAJ9lZSEesHNj0IMNkEYv9UTQXVKM0rGtkX
 /l2O86sb1i0J1bRMUBj5u0VkEMqNARuAOIv2wh8U6wX0qHWtJQ24rMke2
 YC0Kz1cLVXtPelYN/cMu1FIS4MOr+CvVY+JHvXpGI1G/9Tm9mi0WowpYs
 gEttlnMg+0u9ofJ/EuSADJtQYzSqiRw9wwKL+oPjlTY0MxXfj3d5gJsKM
 i9+EyZRvmBY2g+o5NQLYYWvicoRbXKsXolYiU7W2uzarDVkYGCa1Jd3bm w==;
X-CSE-ConnectionGUID: UDhoMSTaThWiXBQ1pzr1Fw==
X-CSE-MsgGUID: HVIQKW8FThO8kzJYKN3cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="66985008"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="66985008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 23:02:03 -0800
X-CSE-ConnectionGUID: 0SOkLFsIRGixo+JhvcoTfg==
X-CSE-MsgGUID: Gtsie+lBTvCsnmsxYn6+OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="235918890"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 17 Dec 2025 23:02:00 -0800
Date: Thu, 18 Dec 2025 15:26:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 01/14] target/i386: Remove x86_stl_phys_notdirty() leftover
Message-ID: <aUOsuvGfQbA61n26@intel.com>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217143150.94463-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 17, 2025 at 03:31:37PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 17 Dec 2025 15:31:37 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 01/14] target/i386: Remove x86_stl_phys_notdirty() leftover
> X-Mailer: git-send-email 2.52.0
> 
> Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
> ("target/i386: Use atomic operations for pte updates"), let's remove.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h    |  1 -
>  target/i386/helper.c | 10 ----------
>  2 files changed, 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


