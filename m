Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CCFC61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zsh-0002U9-RD; Sun, 30 Aug 2026 03:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zsg-0002Pl-S0
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:06 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zsf-00057t-98
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074585; x=1819610585;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FrNiROj+6J8I8WM7tFolDxllzBv4gmwwB5Uq/si5Ugg=;
 b=LJFRrIX0koguZKopSwolpqXkow6s3ENDo83wHzLYFgmnaXRVOrbcngLb
 BhSIQSgRXe5tWA+lwZ2EG970OvSzzC89YmlG4Bdexlz5hO/qt577WZAMR
 3E73j0qDUeYEGMKCr/R3M/gBcup/8iOODWK2sLgIGKBe8npU4b6fCYp96
 8KNEfgzwVf2tDLZ1UvVqcaclD9iQrMOwti9KkbjhfJNUOAvyuKOxJrF0N
 o8p4uPyzpSjI188R92BUghkbObTxvRnrrN570oVAce38m4QZYP4DfhH2r
 t4PP2OJtpC1j+icbxPs4w51XihRgF4G+OtZxEt6Dqhp5Dz30YsBPBT2eF A==;
X-CSE-ConnectionGUID: qVfMzIiAS9qa6VdEBNQZcA==
X-CSE-MsgGUID: E1zJWODhRMeX//hbrWipQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648952"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="87648952"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:03 -0700
X-CSE-ConnectionGUID: g63J9bNCRiGHiIv2jfZGuQ==
X-CSE-MsgGUID: XGzyVKBFQd+G2eGiWHcTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="266710497"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 08/10] hw/pci: Add PCIe Device3 capability support
Date: Sun, 30 Aug 2026 15:22:35 +0800
Message-ID: <20260830072235.399551-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2044366277.121787732104098.JavaMail.epsvc@epcpadp1new>
References: <2044366277.121787732104098.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:08 +0530, Shrihari E S wrote:
> +        /*
> +         * A UIO requester must be able to issue DMA transactions.
> +         * Enable PCI_COMMAND_MASTER in the PCI command register so the
> +         * device's bus master bit is set when the requester capability
> +         * is advertised.
> +         */
> +        pci_set_word(dev->config + PCI_COMMAND,
> +                     pci_get_word(dev->config + PCI_COMMAND) |
> +                     PCI_COMMAND_MASTER);

As posted this is dead code -- the series' only caller, in 09/10,
passes uio_req=false (the type3 is wired as completer only).  If a
requester shows up later, the write still doesn't do what the comment
wants: pci_do_device_reset() clears the writable COMMAND bits, so on
cold boot the machine reset discards it before the guest runs.  On a
hotplug path there is no bus reset, and pci_qdev_realize() ends in
pci_set_power() -> pci_set_enabled() -> pci_set_master(), so there the
write does take effect and the device surfaces with bus mastering
already on.  Bus master enable stays under firmware/OS control; I'd
drop the write.

The Dev3 defines already exist in Linux, and they reached QEMU in
January: 49f6b93d0752 ("linux-headers: Update to Linux v6.19-rc1") put
PCI_EXT_CAP_ID_DEV3 0x2F into
include/standard-headers/linux/pci_regs.h.  The cxl-2026-01-09-draft
base predates that sync, which is why this builds here; on master the
0x2f added to pcie_regs.h redefines it, and pcie.h pulls both headers
into the same TU, so that's a redefinition warning under the default
-Werror.  The register offsets don't collide -- PCI_DEV3_CAP_OFFSET
here against the header's PCI_DEV3_CAP -- so PCI_EXT_CAP_ID_DEV3 is the
one to drop.  SVC is the other case: 0x35 genuinely isn't in the kernel
header yet.

Many thanks,
Junjie

