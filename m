Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E59D2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pBK-0006la-Mo; Fri, 18 Oct 2024 11:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pB8-0006l6-4V
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:46:15 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pB5-0001Mj-Dd
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729266371; x=1760802371;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hQfkC+zqc4rqm0WgktvH7Ig4QCXzV4ltcaLjcR2GE4w=;
 b=G1jdZsBkECHJig9FnLnKUMxm05NFheKZBfjYEgDCpg1kbSpXs8c08Vfh
 maxzN+6Gd3AsWFaC4jdZkqtTW+9j69H8LhLCuAcEGb03sWHwQl+w2a2k7
 ZLHjGZQ5Pc+xUGRzmzb3lG8yVhwVAC9/xZWnId6tGw6RwlQPJDJC5eHOT
 LADST3SEFxxF8edOTdJMUCQzje413BxUKfPasbWSdD5GLQkrS71z6FAgV
 UdIqvEqu1PMycLHNTfq8eqiVCL/g9FzxgbGWbhGFdE7o3bXvLc581YWpZ
 7kpPTiBjNgtCuNh02IoEDnsEE2QtfvHK7Ww+QRCD+wd71V/xcNuBxwxe/ g==;
X-CSE-ConnectionGUID: w6lh6rzeSAqadnBqch9Qjw==
X-CSE-MsgGUID: aBy6cGHqTgiAcFOgq40OBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39346582"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39346582"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:46:09 -0700
X-CSE-ConnectionGUID: Ud+3V9hPQyuDJNIxivkhZA==
X-CSE-MsgGUID: UY6TEBk9S82+AB+uhDxMWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="109726518"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 18 Oct 2024 08:46:08 -0700
Date: Sat, 19 Oct 2024 00:02:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 06/16] rust: do not use OnceLock for properties
Message-ID: <ZxKGj+LVw3I0VdH0@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, Oct 15, 2024 at 03:17:24PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:24 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/16] rust: do not use OnceLock for properties
> X-Mailer: git-send-email 2.46.2
> 
> Properties are initialized lazily but always accessed within the big QEMU lock.
> 
> There is no need to have a OnceLock around them, and also OnceCell/OnceLock
> were only stabilized in 1.70.0; so remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/device_class.rs | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


