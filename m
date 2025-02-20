Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0427CC021B0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 07:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl0dm-0007dO-B2; Thu, 20 Feb 2025 02:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0dk-0007d9-0v
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 02:06:32 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0dg-0002Uf-Si
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 02:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740035189; x=1771571189;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AUFh9m8ZBEWzqWlopZsWN5fRrW5zXyvyRa1cAS/IT1s=;
 b=mAELIAhDg4tpza8GNgKvQF8P+mY2Ospbq7/D65lZK92YfMi3qBPhXHYj
 18f68+r1QPUmcbPvMhc02auwfVKDofHLcSJCi40dNi3eXiFYhxqfM+16i
 u5d8GPz+2bL+vO6m24GdR6jD5f4YciCfHJxSpP554OCLyegCub4rze+0v
 tIkCR38z2kB2fazAS+z8ov6a/+3TZYIKXU3nqmL72bhgrM0iSlgDnRVRw
 DARHohESm6oONXunDT1wrl6K+0JSZs1ebs0tHOHjCE0JkOOJKWFE41u8a
 1kN4b46ZQDcfkfJNjAg+GtIEq9l4EMrdOm+5DlxRzVK5uNa4VNqDnoBBx Q==;
X-CSE-ConnectionGUID: Tcnq1mTZSTiqiU8LdCFLpA==
X-CSE-MsgGUID: 5I34GDKIRGu/vug30ScSkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51782760"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="51782760"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 23:06:25 -0800
X-CSE-ConnectionGUID: gmk/y02pRCWI4NfHdLKrUQ==
X-CSE-MsgGUID: GHz1ZgUjS56v8Hil+gkHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="119579689"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2025 23:06:23 -0800
Date: Thu, 20 Feb 2025 15:25:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
Message-ID: <Z7bZBsqO6MxhFKVp@intel.com>
References: <20250220065326.312596-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220065326.312596-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> Date: Thu, 20 Feb 2025 12:23:26 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v2] microvm: do not use the lastest cpu version
> X-Mailer: git-send-email 2.45.2
> 
> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> introduced 'default_cpu_version' for PCMachineClass. This created three
> categories of CPU models:
>  - Most unversioned CPU models would use version 1 by default.
>  - For machines 4.0.1 and older that do not support cpu model aliases, a
>    special default_cpu_version value of CPU_VERSION_LEGACY is used.
>  - It was thought that future machines would use the latest value of cpu
>    versions corresponding to default_cpu_version value of
>    CPU_VERSION_LATEST [1].
> 
> All pc machines still use the default cpu version of 1 for
> unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
> mean that over a period of time, for the same versioned machine type,
> the cpu version would be different depending on what the latest was at that
> time. This would break guests even when they use a constant specific
> versioned machine type.
> Additionally, microvm machines are not versioned anyway and therefore
> there is no requirement to use the latest cpu model by default.
> Let microvms use the non-versioned cpu model and remove all references
> to CPU_VERSION_LATEST as there are no other users (nor we anticipate
> future consumers of CPU_VERSION_LATEST).
> 
> Those users who need spefific cpu versions can use explicit version in
> the QEMU command line to select the specific cpu version desired.
> 
> CI pipline does not break with this change.
> 
> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> 
> CC: imammedo@redhat.com
> CC: zhao1.liu@intel.com
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/microvm.c |  2 +-
>  target/i386/cpu.c | 15 ---------------
>  target/i386/cpu.h |  4 ----
>  3 files changed, 1 insertion(+), 20 deletions(-)
> 
> changelog:
> v2: tags added, more explanation in the commit log.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


