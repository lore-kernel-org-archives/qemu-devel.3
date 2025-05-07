Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9973BC3ABBE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUH8-00063X-Ae; Tue, 06 May 2025 22:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUH6-00061g-Nv; Tue, 06 May 2025 22:12:44 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUH4-0006hE-JU; Tue, 06 May 2025 22:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746583962; x=1778119962;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=r0Mr74Nl3rA+2WbHVVPlTamfJ/ZTjHKX+abJu7YlTPs=;
 b=jxfAxsH+2/ZAqCx74zpLkpLfWiVJqXb9Hu8K8lQuFOFsV/UCjaFk1Fpa
 ZCbu4eLJsf+W0/kIEvJbNusBUAS7SAlQdP8OV4lMMYhjaWKNH+HvAg4nh
 2cGHQahKuKfq78IBlfJmWR6TyiZUHCt29hPr8o/xosq+PE6qnwQRDwYox
 tWkX4XrdNwq80rkTiYlf1AWgiJ2BlGzz3+rPnOdPoObOSELjvzirekGCY
 Mb/jF3KJNE/jVyb0xjWQXD8kX5Uyn9dPeL5a725m+2NF8rcXXHP3pCz/b
 7q+mHBkCUShx/rYPbCgjd7t0QInzSEreM6tUgudI28IlnINn07Ri1XG+Q Q==;
X-CSE-ConnectionGUID: EqpM5O6AS9qOBAMGwkPkTQ==
X-CSE-MsgGUID: n91O+3XiTkudtNTQT9rgiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59680775"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="59680775"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 19:12:39 -0700
X-CSE-ConnectionGUID: VjIreFpJS5uU+Q+iZDQF+g==
X-CSE-MsgGUID: 6NEzYFEHQq6Jz6AFddq56Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="166837587"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 06 May 2025 19:12:34 -0700
Date: Wed, 7 May 2025 10:33:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
Message-ID: <aBrGf4fLK7c74sv1@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:38:48PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:48 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 02/19] hw/i386/pc: Remove
>  PCMachineClass::broken_reserved_end field
> X-Mailer: git-send-email 2.47.1
> 
> The PCMachineClass::broken_reserved_end field was only used
> by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
> Remove it and simplify pc_memory_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/i386/pc.h |  1 -
>  hw/i386/pc.c         | 13 +++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


