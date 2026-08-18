Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B36DC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGUq-0006Wk-NA; Tue, 18 Aug 2026 05:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGUo-0006Us-QN; Tue, 18 Aug 2026 05:52:39 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGUm-0007F8-Vw; Tue, 18 Aug 2026 05:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787046757; x=1818582757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WCil1czoJQjSs+BSGz2W5eL5i1SSFXPJ/Eexet0K6Y4=;
 b=dY8h4AHKhiCUyWetO9zf92yXurFXNwz7WooEWapptbqjPJix5x935r2Y
 U/Q2C36dmU/eg95V7nbYixolcyjr7330iPcF5INKJqsgbmrDIbOhNx99C
 3tARcC/I8Dr7KFtyI6+PHXTdaBDT73l294gQTsSwKotlPu3wA2ka7nACD
 tswyGnWras/dt7OPkv2oHVnDglQj/aUCTiLnNYzR+5SHV8VXY6zyAAZxz
 FP1Nu2O2VwDbswludrvseHwx417aSJw695hPZkg7LfU2S9EeZvo0acXLO
 iDWkv2Y54W65fXV8BCAP2KTnunMTPhKwZBkKyasgG/tFWOBT326e0fsu6 g==;
X-CSE-ConnectionGUID: JnxjtjpSRDmgpe+WmIufhg==
X-CSE-MsgGUID: Asz8+fJURMmE7SfANFsbEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91347059"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="91347059"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:52:33 -0700
X-CSE-ConnectionGUID: YwFxTxrATvS6M93nFx/INQ==
X-CSE-MsgGUID: nfOVKfRpSLG9GBvAgm6bWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="295108838"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:52:28 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 06/10] hw/vfio/pci: Bind a CXL device to its fixed memory
 window
Date: Tue, 18 Aug 2026 17:52:24 +0800
Message-ID: <20260818095226.252213-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813130623.2499506-7-mhonap@nvidia.com>
References: <20260813130623.2499506-7-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Hi Manish,

On Thu, 13 Aug 2026 18:36:19 +0530, Manish Honap wrote:
> +/*
> + * Cold-plug path: the CFMWS windows are placed at machine init done, so the
> + * binding can only be validated from this notifier. The VM has not run yet, so
> + * a configuration error is fatal to startup. A hotplugged device is validated
> + * in realize instead (see vfio_cxl_setup), where the failure fails device_add
> + * without taking down the running VM.

At this point in the series that isn't true yet: the
DEVICE(vdev)->hotplugged branch only arrives in patch 7, while this
patch registers the notifier unconditionally.
qemu_add_machine_init_done_notifier() invokes the notifier immediately
once the machine has reached PHASE_MACHINE_READY (hw/core/machine.c),
so between patches 6 and 7 a device_add with a bad CFMWS config lands
in vfio_cxl_bind_fmws() and exit(1)s the running VM. Move the hotplug
branch from patch 7 into this patch; then every point of the series
matches the comment.

> +        for (slot = 0; slot < PCI_SLOT_MAX; slot++) {
> +            for (fn = 0; fn < PCI_FUNC_MAX; fn++) {
> +                if (ep_bus->devices[PCI_DEVFN(slot, fn)]) {
> +                    nendpoints++;
> +                    break;

This counts occupied slots, not functions: the inner loop breaks on
the first function of a slot, so two vfio-cxl functions cold-plugged
at slot 0 each pass with nendpoints == 1, bind the same single-target
window, and map at the same base with equal priority -- the aliasing
this check exists to reject. Count devfns instead.

Many thanks,
Junjie

