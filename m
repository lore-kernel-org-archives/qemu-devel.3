Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ECDC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hmZ-0006DV-1h; Tue, 29 Apr 2025 06:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hmV-00068h-9e
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:01:39 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hmS-0002gb-0S
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920896; x=1777456896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=l7uF9Ubp8bF62r3NRtrZhms4/wPtHAA4ocx2CtWSn24=;
 b=MCtVvwZ51ghVHxg77Mh7NJGvBwQ3LOLYvXe3VpCGA9wdcfmsFM/fk8C6
 chx7KjxRVo+VSF4F5oFwwUaluK0htav03EEXjN3mHwPfpiEbkprK1r597
 8sBytvo2CzcTSxofrloNRmxaUnQzb6XJvDChvbZCDxUWs/wHwd4SSzFyN
 OmeU6EmIZhB9jCvciIsCRVGGb1EwIm/X7nLA6tasJSmuIwT0KB8CQh8zo
 x7URvx+4mUTmYHZ7PcpHMaoJGkNgJQPTlyEFZaPXstrigeUQ8qwBmwS5Q
 iB3mcwSfg7UPudMVwpT2JBRSjVSlbfM8zhgaWedJg2emMvEOgF2HqG4qh g==;
X-CSE-ConnectionGUID: WSIdbSioQMi9csnET2oAmQ==
X-CSE-MsgGUID: gLgmAuKsTcm3YL1Rweqdag==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47545758"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="47545758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 03:01:32 -0700
X-CSE-ConnectionGUID: LvR1YQ0ERKuJfZxV0RMhjg==
X-CSE-MsgGUID: CKXeCByhQ/ivJqjr92tWeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="134091213"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 29 Apr 2025 03:01:28 -0700
Date: Tue, 29 Apr 2025 18:22:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 38/55] i386/tdx: Set and check kernel_irqchip mode for
 TDX
Message-ID: <aBCoYh53h0JgoNeS@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-39-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401130205.2198253-39-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:48AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:48 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 38/55] i386/tdx: Set and check kernel_irqchip mode for
>  TDX
> X-Mailer: git-send-email 2.34.1
> 
> KVM mandates kernel_irqchip to be split mode.
> 
> Set it to split mode automatically when users don't provide an explicit
> value, otherwise check it to be the split mode.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


