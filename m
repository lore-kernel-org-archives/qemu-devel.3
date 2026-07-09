Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C920C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpkK-00048U-Jn; Thu, 09 Jul 2026 10:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whpkJ-00048L-Gm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:28:59 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whpkF-0008Tc-VF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783607336; x=1815143336;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cP9tGxlPOh7Y7CKW+uVs1uZS9zbeZiko9nbSoqa93lY=;
 b=ZM+bYafwN+RMALLsoCBmWV7XtshMQYijcDCAob7zmPS60YwpVV0EeEdf
 w8dj6prp0hlA8hXyUWMGyrkzteOvc+HPEQethx45HwKy5tHuaExjtt6V3
 HY3ilVoo++Oy0ALFr+RQ+Un5OLsvqui42Ee5Of0cZxByeLOHmXyVf96JC
 dFJE9Uv0L0OLtECuwNew8ipzBA9bMKHoRGxMY3t7BqXg13ZXKvqakjdLo
 iz/MCZhMvwQOiIO79Wkh4Yi0tgkVJd/nuRBNG0BCpVLpGP0Iktos9PTxD
 9mXq361VcH+kINpFKkP9Zfmx+Xk2Zbo1p882vPJfrCu4kMRPIVQNwHt9L Q==;
X-CSE-ConnectionGUID: OB+MeoY2T+2PFRBs/Qgnug==
X-CSE-MsgGUID: 46WUVQm0RnODaD1S7Kf75A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86833784"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="86833784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 07:28:51 -0700
X-CSE-ConnectionGUID: XbLd94ekSNa6e6OCkAp+9w==
X-CSE-MsgGUID: AB00LUzgScCXv6qQ1UHHAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="292796762"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 09 Jul 2026 07:28:50 -0700
Date: Thu, 9 Jul 2026 22:57:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>
Subject: Re: [PATCH] hw/core/machine: fix fdt memory leak
Message-ID: <ak+21HoyBSYx3irf@intel.com>
References: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 09, 2026 at 03:12:49PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Thu,  9 Jul 2026 15:12:49 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH] hw/core/machine: fix fdt memory leak
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The MachineState fdt field is allocated by various machine types via
> create_device_tree(), load_device_tree(), or similar, but was never
> freed in machine_finalize(). Add the missing g_free() call.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/machine.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


