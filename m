Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3D4CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkwN-0002nJ-O7; Wed, 17 Jun 2026 03:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwM-0002n4-FC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:44:02 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwK-0003e7-Ud
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781682241; x=1813218241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JrQdhu8yn6tpuL6obR8nEfCZia2seXFUvByj6d+tDxg=;
 b=lwBQwESZNSm55wQfVyU9RhB03WBr/i7bNg+ZTWTJfTIBn9xUOezVuVjA
 MCbN8lJpDHQ/tIpPlMKXvlTK7ZClp1cbJbFwM5Tknnk2atM8nO790AJm4
 vre6JsELh2upLauN9e5Ubb6VECFBBkwSWXTwZPzJ9THX0QlAV2n8X1Roy
 TRZEnJgA45cu/O47bz+DJ9y0RzZ3yUEXPV+pRKhQT91pRSG75PH1PDajh
 LfryReUnfBgUGI0/u3qzViDaQGA5uXb1UEXIaNPhxiUATubj4QD85vPZm
 Dzga1TYXX5/c4tA6zJr2L66aAvnqR9BIC/r/jxkHYun0W5zW+Xu6mAVAM w==;
X-CSE-ConnectionGUID: ZVSZCLuzQT6l7dXtx+6gZw==
X-CSE-MsgGUID: JUHtcfGIR92hFus4NyqpiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133616"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93133616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 00:43:57 -0700
X-CSE-ConnectionGUID: r3fPfwH1SKCwalYELaq4LA==
X-CSE-MsgGUID: Q2aD1LAcSAucpuWXhWqVEQ==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:54 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>, jic23@kernel.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Date: Wed, 17 Jun 2026 23:45:18 +0800
Message-ID: <20260617154521.520191-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-7-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-7-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue,  9 Jun 2026 16:28:34 +0530, Shrihari E S wrote:
>      if (flitmode) {
> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
> +        uint32_t pos = dev->exp.exp_cap;
> +
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>                                     PCI_EXP_LNKSTA2_FLIT);
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
> +                                   PCI_EXP_FLAGS_FLIT);

Following up on Jonathan's observation here -- I'd also noticed a
bogus Interrupt Message Number on a plain flit-mode root port, so I
checked what the stray write actually does to the Flags register.
The impact is wider than just UIO:

The first set_mask writes PCI_EXP_LNKSTA2_FLIT (0x0400) into
PCI_EXP_FLAGS (cap offset 0x02) instead of PCI_EXP_LNKSTA2 (0x32).
0x0400 falls in the Interrupt Message Number field (bits 13:9) of the
Flags register, so a flit-mode port ends up reporting a nonzero
Interrupt Message Number (it reads back as 2).

pcie_cap_fill_lnk() runs for every flit-mode port, and x-256b-flit
defaults to on for pcie-root-port, so even a plain
"-device pcie-root-port" comes up with the corrupted field.

The second line (PCI_EXP_FLAGS_FLIT into Flags) looks correct and
should stay.  The first one looks like a typo in the destination
register -- it was PCI_EXP_LNKSTA2 before this series (visible in the
hunk above), so I'd restore it there rather than drop it.
pcie_cap_flit_write_config() does maintain the LNKSTA2 flit bit, but
only on guest LNKCTL writes; it doesn't run at realize/reset, so
dropping the line would leave LNKSTA2 flit status reading 0 at reset
instead of its pre-series value.

Many thanks,
Junjie

