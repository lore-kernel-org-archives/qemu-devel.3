Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64159E7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLCqY-0005xb-0q; Tue, 10 Dec 2024 21:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCqW-0005xQ-DV
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:53:04 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCqT-0006Ea-2K
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733885581; x=1765421581;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jvTXnFQyJFuI1x1d/dIocobfgD/iUZi9Zxq3/Fz8HRw=;
 b=j+KVCLIJrqlAkyVocJZaV7C8B7Y6YcPGEAMSL0mEEZkdWOLXaszsOoFC
 cDoq6QhEnw0hXFfxF5Ls5j6GXCXqlXCUqI4hgD9xDcmNxtAxnd9YJpCkY
 YyV9s/g/Wov3ledwrZwNM9Ye6RypBiXNbwW8IQkNsAmhLKlnHxt2/H1/3
 ubaAGVtwHDpXbWzJAmsqsQ2CKJbXn1OefrPE5IBmV1pU9gRSyzNFfPnhW
 JRQ+lOuhI0ZoWOvOGZz8hAuHiracuvnyE08Rkeg6qRZvVJ7EA3RAbh0s7
 Ratwzr9F5limpXudx++yO8YvTiM1Cbr2oWFicx+HnnVgSqQv5ykEroliY g==;
X-CSE-ConnectionGUID: BLBQ+81FTpS8hz1vBLuZDA==
X-CSE-MsgGUID: KUqoKH4TR0aBKL4SdlhdhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44921533"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="44921533"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 18:38:14 -0800
X-CSE-ConnectionGUID: LaR84/qRTaqcWveAXPGR9g==
X-CSE-MsgGUID: QcUPusPNRz6CdEGBRugh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="100671139"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 10 Dec 2024 18:38:11 -0800
Date: Wed, 11 Dec 2024 10:56:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 4/4] cpu: Remove nr_cores from struct CPUState
Message-ID: <Z1j/Wjs2ZNam/sBd@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-5-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145716.472456-5-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Thu, Dec 05, 2024 at 09:57:16AM -0500, Xiaoyao Li wrote:
> Date: Thu, 5 Dec 2024 09:57:16 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [RFC PATCH 4/4] cpu: Remove nr_cores from struct CPUState
> X-Mailer: git-send-email 2.34.1
> 
> There is no user of it now, remove it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/core/cpu-common.c  | 1 -
>  hw/i386/x86-common.c  | 2 +-
>  include/hw/core/cpu.h | 2 --
>  system/cpus.c         | 1 -
>  4 files changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


