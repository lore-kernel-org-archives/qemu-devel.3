Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C32C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbz4-0006Fs-4k; Fri, 04 Jul 2025 04:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbz2-0006Fh-8E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:41:24 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbyz-0005Z3-Vp
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751618482; x=1783154482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1QuT+XRSxAhtUr7hKsZ7yJkGE89o5ONGpKD2gpcV/QU=;
 b=KwgaD1XZZIg5PLbyHCvq/g4ewOKdyRexIDcgNSQETWIAaIhoMHnriiZB
 Knk1FcVmuVUqPvNQPdiGHkrlill5xKDG+858eAtex2U+nZTDHCIKnXSxd
 1gM9+2XJ+VmuN28h6jPzd4EW053a7PxIomhg0/xLZD0lNXqjJrcc4/44W
 Zh5o70jrXLDUnykcpciPiWdxtxKNjF7TMcR2b7nSRYzvuBT+CI8PjYz3k
 hD4wGqA/uMTjcMmS6QPZO9hJXcGWc+YoNxsaHqjEkcjV3EqdXTzOZjN0m
 4sxBqD/gJOFDILuV2YqnEExF7EWiCjXwTCfFFtsOyhEghz8QNIGblKBxX g==;
X-CSE-ConnectionGUID: y7ku0q1pRem+1ABh3N6S7g==
X-CSE-MsgGUID: aplz9DkAREC2iO22b/M8fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79390532"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="79390532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 01:41:18 -0700
X-CSE-ConnectionGUID: Rmee1NI+T9S45FFL65lxYA==
X-CSE-MsgGUID: YJNNdulXQM+t6scSwQBLJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="155086915"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 04 Jul 2025 01:41:12 -0700
Date: Fri, 4 Jul 2025 17:02:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 38/39] accel: Extract AccelClass definition to
 'accel/accel-ops.h'
Message-ID: <aGeYrngC+7RX8kEa@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-39-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-39-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 03, 2025 at 07:32:44PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:44 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 38/39] accel: Extract AccelClass definition to
>  'accel/accel-ops.h'
> X-Mailer: git-send-email 2.49.0
> 
> Only accelerator implementations (and the common accelator
> code) need to know about AccelClass internals. Move the
> definition out but forward declare AccelState and AccelClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                 |  2 +-
>  include/accel/accel-ops.h   | 50 +++++++++++++++++++++++++++++++++++++
>  include/qemu/accel.h        | 40 ++---------------------------
>  include/system/hvf_int.h    |  3 ++-
>  include/system/kvm_int.h    |  1 +
>  accel/accel-common.c        |  1 +
>  accel/accel-system.c        |  1 +
>  accel/hvf/hvf-all.c         |  1 +
>  accel/kvm/kvm-all.c         |  1 +
>  accel/qtest/qtest.c         |  1 +
>  accel/tcg/tcg-accel-ops.c   |  1 +
>  accel/tcg/tcg-all.c         |  1 +
>  accel/xen/xen-all.c         |  1 +
>  bsd-user/main.c             |  1 +
>  gdbstub/system.c            |  1 +
>  linux-user/main.c           |  1 +
>  system/memory.c             |  1 +
>  target/i386/nvmm/nvmm-all.c |  1 +
>  target/i386/whpx/whpx-all.c |  1 +
>  19 files changed, 70 insertions(+), 40 deletions(-)
>  create mode 100644 include/accel/accel-ops.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


