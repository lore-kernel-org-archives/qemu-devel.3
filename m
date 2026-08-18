Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A84C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGVA-0006um-Us; Tue, 18 Aug 2026 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGV9-0006sV-FB; Tue, 18 Aug 2026 05:52:59 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGV7-0007Jh-QF; Tue, 18 Aug 2026 05:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787046778; x=1818582778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S3sP7fMPTH16OFZFsAh5o4aNHODuDo+ps5H5kgZ/1NA=;
 b=GCiA07uvQDM+bOCnSCjJh1U04NNvWES9oDkMHJVYW3I04zqkPVJVX/qf
 ZlhSAhsSwSpWxOA33zrSGhond/eUyNK8Cd+ABxYdkt1qnS9MFcv0VcvVF
 jLw5fJ7iiR8qLjwXu14AYgGSTU2t/YvHTwFf32mjMtcuhn17BLxcIy94h
 rKRDgxYPtfVdD6ZR7YW8o5HT6miAxU5ClidRBP1RToKRbHDd7ExuC7M7D
 4ndtcXACIQ0YwUty1VSxmvlhX+Hkca+HH1RdmxbsDZJngc+b4Sx22pFNL
 +gEpd1bJ/j6VSmdyLczCVyFuydsJjgru3Xmu0OrXRUHIC/aTr/Orm8I5U w==;
X-CSE-ConnectionGUID: ZZDqyA+WR+u9YHaHNjWa5Q==
X-CSE-MsgGUID: PiGOBZWfSOGcENyl+5+baw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91347103"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="91347103"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:52:56 -0700
X-CSE-ConnectionGUID: +zqWDXgGTQKoXxtm7E9vnA==
X-CSE-MsgGUID: vRSRhhJYQ/+hPIRTNSjZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="295108865"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:52:51 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Date: Tue, 18 Aug 2026 17:52:49 +0800
Message-ID: <20260818095250.252230-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813130623.2499506-8-mhonap@nvidia.com>
References: <20260813130623.2499506-8-mhonap@nvidia.com>
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

On Thu, 13 Aug 2026 18:36:20 +0530, Manish Honap wrote:
> +    switch (le32_to_cpu(cap) & 0xf) {
> +    case 0:  return 1;
> +    case 1:  return 2;
> +    case 2:  return 4;
> +    case 3:  return 6;
> +    case 4:  return 8;
> +    default: return 1;

The encoding continues: 5h = 10 is the most a device may advertise,
and switch/host-bridge encodings go on to Ch = 32 (CXL r3.1
8.2.4.20.1), so a 10-decoder endpoint takes the fallback and "walk
every decoder" becomes "check decoder 0 only". Unreachable while the
kernel gates on a single decoder. cxl_decoder_count_dec() in
hw/cxl/cxl-component-utils.c already carries the full table and this
file already includes its header; reusing it needs a floor of 1 (it
decodes reserved encodings to 0) plus the stub treatment patch 6
gives cxl_get_hb_passthrough().

> + * GPA and never sees the host physical base the kernel shadow holds; the shadow
> + * base and size are not consulted here.

The cover has the guest driving its own virtual decoder, and this
patch handles a decommit. After a decommit, what refuses a re-commit
with a base elsewhere inside an oversized window (patch 6 only warns
on size > need)? The kernel FSM runs on the written shadow, QEMU maps
at the window base regardless, and the virtualized read-back also
reports the window base, so a divergence is silent -- guest accesses
at the base it programmed land in the CFMWS trap instead of the
device memory. If the FSM rejects any base other than the firmware
value, a comment here closes the question; otherwise the write trap
already sees every base write, so checking it against fmws_base on
commit is cheap.

>  static void vfio_cxl_teardown(VFIOPCIDevice *vdev)

Nothing on the unrealize path drops the mapping: the teardown runs at
instance finalize, and the mapping itself blocks finalize, since
adding the region into system memory referenced its owner, the vdev,
and only the unmap drops that reference. An unplug flow that resets
the device escapes through vfio_pci_pre_reset()'s PCI_COMMAND clear;
ACPI hotplug eject unparents with no reset, so the vdev never
finalizes, the VFIO fd stays held, and the guest keeps reading the
removed device's HDM at the window base. Unmapping from vfio_exitfn()
with the rest of the unrealize-time teardown breaks the cycle.

Two notes from reading, no action needed:

The BASE_LOW[31:28]-only substitution is exact: cxl-fmw sizes are
validated as 256MiB multiples (hw/cxl/cxl-host.c) and both machines
hand cxl_fmws_set_memmap() a 256MiB-aligned start (hw/i386/pc.c,
hw/arm/virt.c), so fw->base cannot carry bits below 28.

Migration is blocked today by the auto-mode blocker your patch 3
comment describes, but the destination path already holds for the day
that lifts: vfio_pci_load_config() pushes PCI_COMMAND through
vfio_pci_write_config(), which re-runs the commit scan after the
machine-done notifier has bound the window.

Many thanks,
Junjie

