Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8E6i-0007c9-6g; Fri, 25 Apr 2025 04:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8E6c-0007b5-Q1; Fri, 25 Apr 2025 04:08:20 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8E6Z-00076N-Q5; Fri, 25 Apr 2025 04:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745568496; x=1777104496;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5KRtg0VP7RhePb2K1+43zCTF9YsbA4O/PrqeshZCb4w=;
 b=PK8aNYUoJuEx4LxX7TElVXurQieQYMXXBpZ3RGL36kmUPFlTlYXN4Mha
 HMVqFPQXubFI594kxQ97k+LFMGdCIHDb+Xb/y8ITMc6CJUMRWD74YDUbd
 iW9OWls00TXQpyvBYEcJrBWo7CMsa/2Q5XFn/t2502em5xy8USXgPurWK
 7WsY72cp9g4Eeq7Kzr2Vd6RU6ggLwFgB3Wbc8E7h8HnJI0ezB4QzlP5CL
 wwVmSzAWMROfubCWVicGrSF6QgL0AlEBV2K1X1yQwj87JAJvlidq7xinW
 pW/fOUMix+HS2QJKWLEJtDpj5bRGBLJ9mS0g3QX5To1nBbhbm8RTbhkyQ w==;
X-CSE-ConnectionGUID: du0OzITwRR+C1HZ2bU/X4g==
X-CSE-MsgGUID: e94w0k4vTQm5BU4pp/Z1lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47240146"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47240146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2025 01:08:09 -0700
X-CSE-ConnectionGUID: 2BKS4ujcSP2OGoMmWUBd1w==
X-CSE-MsgGUID: BElnjdbdSySYVUcokWJU+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="163808291"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 01:07:59 -0700
Date: Fri, 25 Apr 2025 16:28:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com,
 kraxel@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v4 01/11] [DO NOT MERGE] i386/cpu: Consolidate the helper
 to get Host's vendor
Message-ID: <aAtHxmpV7ka1lseC@intel.com>
References: <20250416215306.32426-1-dongli.zhang@oracle.com>
 <20250416215306.32426-2-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416215306.32426-2-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Wed, Apr 16, 2025 at 02:52:26PM -0700, Dongli Zhang wrote:
> Date: Wed, 16 Apr 2025 14:52:26 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v4 01/11] [DO NOT MERGE] i386/cpu: Consolidate the helper
>  to get Host's vendor
> X-Mailer: git-send-email 2.43.5
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Extend host_cpu_vendor_fms() to help more cases to get Host's vendor
> information.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> This patch is already queued by Paolo.
> https://lore.kernel.org/all/20250410075619.145792-1-zhao1.liu@intel.com/
> I don't need to add my Signed-off-by.
> 
>  target/i386/host-cpu.c        | 10 ++++++----
>  target/i386/kvm/vmsr_energy.c |  3 +--
>  2 files changed, 7 insertions(+), 6 deletions(-)

Thanks. It has been merged as commit ae39acef49e2916 now.


