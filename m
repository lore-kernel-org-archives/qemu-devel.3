Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B3AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqaG-0003ag-EO; Tue, 27 Feb 2024 01:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqaE-0003aU-J9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:04:54 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqaC-0000h4-Mo
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709013893; x=1740549893;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GiU8CH9Y37TUgvA6fhmv5WWsU1kQwAZzw6OCPKGzisQ=;
 b=IJ+Jwa5TbAVzuhW/QF5VPujSknQdqD7eDrxgcc5qedpbZ40UJcaqVP6/
 qIdQ6C3Bw8NjAE112wIXGRHb5gP+xC1z3RCEN8EZcaElt+l1ztFsM0vs1
 51wAjuc2eRPqbpeZUrq7nMRpklVoy/EDrcKEHbJJBUIz1j709T8mvbsyD
 WMKYLGJ3CHfv+aSuoqWpIUWpC11NzRYuVpX+KQKa04lHC6k6L5ams+3fU
 n0IptV703Dthh4yhEhukHiCV9MdNbytK7sWdirP4+XTa4DWpjgohPZIWG
 0WAnehA+RMGLAX4aJTtwWFU42BOLXgRqfwe4lQgCx1WSXz2GTLL/sqrbK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7124976"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7124976"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7133449"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Feb 2024 22:04:47 -0800
Date: Tue, 27 Feb 2024 14:18:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 08/10] hw/core/reset: Implement qemu_register_reset via
 qemu_register_resettable
Message-ID: <Zd1+tZPGl3q7peFH@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-9-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-9-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 20, 2024 at 04:06:20PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:20 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 08/10] hw/core/reset: Implement qemu_register_reset via
>  qemu_register_resettable
> X-Mailer: git-send-email 2.34.1
> 
> Reimplement qemu_register_reset() via qemu_register_resettable().
> 
> We define a new LegacyReset object which implements Resettable and
> defines its reset hold phase method to call a QEMUResetHandler
> function.  When qemu_register_reset() is called, we create a new
> LegacyReset object and add it to the simulation_reset
> ResettableContainer.  When qemu_unregister_reset() is called, we find
> the LegacyReset object in the container and remove it.
> 
> This implementation of qemu_unregister_reset() means we'll end up
> scanning the ResetContainer's list of child objects twice, once
> to find the LegacyReset object, and once in g_ptr_array_remove().
> In theory we could avoid this by having the ResettableContainer
> interface include a resettable_container_remove_with_equal_func()
> that took a callback method so that we could use
> g_ptr_array_find_with_equal_func() and g_ptr_array_remove_index().
> But we don't expect qemu_unregister_reset() to be called frequently
> or in hot paths, and we expect the simulation_reset container to
> usually not have many children.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The way that a legacy reset function needs to check the ShutdownCause
> and this doesn't line up with the ResetType is a bit awkward; this
> is an area we should come back and clean up, but I didn't want to
> tackle that in this patchset.
> ---
>  include/sysemu/reset.h |   7 ++-
>  hw/core/reset.c        | 137 +++++++++++++++++++++++++++++++----------
>  2 files changed, 110 insertions(+), 34 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


