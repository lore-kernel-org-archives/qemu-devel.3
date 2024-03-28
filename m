Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB3AC47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfjF-0002IY-4X; Wed, 27 Mar 2024 22:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfjD-0002IH-Vd; Wed, 27 Mar 2024 22:42:55 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfjC-0003Gd-CZ; Wed, 27 Mar 2024 22:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711593774; x=1743129774;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HSffn8YQu7j6Zw6JEWUgp+Wn9FufzgFL26fHYbA5lM8=;
 b=b8D22WVK6eDTwBoTrU0yrdYoPXx7VuR5/aVA4eA+VYj/NzRnYR1JLnNJ
 PCnTJWKkiCz3nwbXR981J6U/ScO2Hm+K9ynURUZ2Ocd+27xD4TswslStL
 FuFd6Yw1JgJX8ewcyhmJzCIDFPmhGpwHx4ygM1KYCWFpWMSXZMdzU/HjK
 auX4BCaJMVp2ZUshT9eO1X/GbjL9va/mxOlr+KvLegPW+FG8xgGvSCbmW
 ++6FAVXrf98Ss7xbwMwlV/1yYwUurWhUi2nYxX2bwDrryxeV+qngOLrXW
 Qmv3IovV+HQQKSzGe/yiRMYdR23K2VmDY5TC52h6TKfUZwIgk/bqAi4Jq A==;
X-CSE-ConnectionGUID: H9VVb9AfSSavD8giFpffAg==
X-CSE-MsgGUID: ZVlZTS1oSfeF9oYq/5bI2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29208141"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="29208141"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="20970530"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 Mar 2024 19:42:46 -0700
Date: Thu, 28 Mar 2024 10:56:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-9.1 v2 13/21] hw/mem/pc-dimm: Remove legacy_align
 argument from pc_dimm_pre_plug()
Message-ID: <ZgTcanm+V22xCiNV@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-14-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:15AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:15 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 13/21] hw/mem/pc-dimm: Remove legacy_align
>  argument from pc_dimm_pre_plug()
> X-Mailer: git-send-email 2.41.0
> 
> 'legacy_align' is always NULL, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-11-philmd@linaro.org>
> ---
>  include/hw/mem/pc-dimm.h | 3 +--
>  hw/arm/virt.c            | 2 +-
>  hw/i386/pc.c             | 2 +-
>  hw/loongarch/virt.c      | 2 +-
>  hw/mem/pc-dimm.c         | 6 ++----
>  hw/ppc/spapr.c           | 2 +-
>  6 files changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


