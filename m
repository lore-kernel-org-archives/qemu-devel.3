Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F0C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjIgf-0000rX-CF; Sun, 10 Mar 2024 08:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjIgD-0000qq-Hm
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 08:53:31 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjIfu-0006W4-JW
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 08:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710075191; x=1741611191;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TYTcQj1A/fM7oNSSxxcY/WHjT95T4Jq6+zVNKfGrpZw=;
 b=KVs3aASMdNBUudzugqWdiyQM2PJu05BLQqK7/YMvEyLRV15vk5xjz5fI
 8JMe1P85ori8xCsLG8DYVXkbmzRa4G6PhFJ65efMo0r8Nq21g0hWY8eoy
 b22PX8yHktqFAdEyI071jER4F2ZJUeJ0yy9GeDR8AMUADKsaNtdSCLdAq
 3KKAAfQldECaJD3guQDTe/qbbdGwymr4iqni6DiCz1DyZd4KyTNWx83qt
 WtN9DUKC1CxNTBnyOWCJqpLtbhke+tdy3awRcTSvVFsp90GMrhJQmlMWr
 EvoPKZUzpQVj2BFEztdzhBF2CjGUYXdtSkk600u/tg9npk6qQSMgvbqoV g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="16151827"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; d="scan'208";a="16151827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 05:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; d="scan'208";a="11348901"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 10 Mar 2024 05:53:03 -0700
Date: Sun, 10 Mar 2024 21:06:51 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
Message-ID: <Ze2wa7YH+eVRyaTL@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <17444096-9602-43e1-9042-2a7ce02b5e79@linaro.org>
 <ZeuyN8Eacq1Twsvg@intel.com>
 <d58b22bb-43b4-42aa-8ed2-1975beb1f31c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58b22bb-43b4-42aa-8ed2-1975beb1f31c@linaro.org>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> I dropped this 4 patches in favor of "Cleanup on SMP and its test"
> v2 (https://lore.kernel.org/qemu-devel/20240308160148.3130837-1-zhao1.liu@linux.intel.com/)
> which seems more important, to get the "parameter=0" deprecation
> in the next release. (Patch 2 diverged).
>

Thanks! This series will continue to be refreshed and rebased on the new
master code base.

Regards,
Zhao


