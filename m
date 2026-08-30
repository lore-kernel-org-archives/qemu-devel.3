Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB23BC61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zrq-0001pN-5k; Sun, 30 Aug 2026 03:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zrn-0001oo-Ld
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:22:11 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zrk-00053h-LT
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074528; x=1819610528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0IRzBSt4eT9lZudaOi0rawYsLP13G2f+Dg+z1fvfCy0=;
 b=anDiVqEHWTaOa6sDVipNHgvF2Mn/qrsjcE4w4sUl+CZkbHJjH3bbwHiS
 UD/9ZQjmusLorTx3Ek05vuYb7tb4elYV7DSbCtbZ5RhuFvgUjSlHzRANY
 Zv6NZ3abmSWEpcFlE8RIjFcxEgy+w1yDk5pk/arkvsW+sQzBdzfqgnjWm
 qRXw7rvY84F5kxh03jotmCLtiHWo0Krprr36dpgX3I3Y3rS3VkfPKflVe
 +owW72cG1myfqrshUcKoOz940X9FiK6gi0S1U/u6snZ58Eh3gL+roPe5V
 1z/nC1acHEnO+vC6cymZAhHfj+B/s060u7vKC/trsG5R5ZGjEaB+tUbEY A==;
X-CSE-ConnectionGUID: jPRC7CXYQby3AflLdDyn1w==
X-CSE-MsgGUID: a4u+y55rTM6FnawlSEcs+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648936"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="87648936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:22:07 -0700
X-CSE-ConnectionGUID: woQLyEEFQLauLj2+pTY8lg==
X-CSE-MsgGUID: azVJ2Ex6QNmQrox5/86hyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="266710378"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:22:04 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 06/10] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Date: Sun, 30 Aug 2026 15:21:44 +0800
Message-ID: <20260830072144.399508-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
References: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
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

On Wed, 26 Aug 2026 11:04:06 +0530, Shrihari E S wrote:
> +            /*
> +             * SVC3 is only meant for UIO TLPs and The non-UIO protocol 0000
> +             * should be for VC0 only. Also checking the TC-VC mapping.
> +             */
> +            if ((i == 3) || (res_ctrl & PCI_SVC_VC0_PROTOCOL) ||
> +                 !(res_ctrl & BIT(i))) {
> +                valid = false;
> +            }

PCI_SVC_VC0_PROTOCOL is (0x0 << 8), so "res_ctrl & PCI_SVC_VC0_PROTOCOL"
is always 0 and the protocol-0000 rejection this comment describes can
never fire.  I tested it: wrote 0x80000010 (VC Enable | TC/VC map bit 4,
protocol select = 0000) to the VC4 Resource Control register of a
cxl-rp; the readback keeps VC Enable set (and, going by the code,
pcie_svc_update_map() then marks uio_opt_svc), where per the comment
the write should have been rejected.  Protocol == 0000 needs the
whole field tested, e.g. !(res_ctrl & PCI_SVC_VC_PROTOCOL_SELECTED).

The UIO branch has the same pattern:

> +        if (res_ctrl & SVC_UIO_PROTOCOL_SELECTED) {

Matches any protocol value with bit 9 set -- including the
vendor-defined 1111b -- not just 0010b.  Comparing the extracted 4-bit
field against the expected value in both branches would close that.

Same run: Port Cap1 reads back EVCC=7, but the init loop only populates
sets 0, 3 and 4 -- the rest read VC ID 000b, the same as VC0, which
7.9.29.6 wants unique.  Was EVCC=2 with sets 1/2 carrying 3/4 the shape
you were after?  (Quoting 6.2 throughout -- newest spec I have.)

> +void pcie_svc_cap_reset(PCIDevice *dev)
> +{
[...]
> +    pci_set_long(dev->config + offset + PCI_SVC_CTL_OFFSET, 0);
> +    pci_set_long(dev->config + offset + PCI_SVC_STA_OFFSET, 0);
> +}

The init function sets USE_VC_MFVC and this clears it again, before
a cold-plugged guest ever runs -- SVC status reads 0 on all four port
types at first boot.  0 is the conformant value anyway (7.9.29.5, and
the comment above the set says as much), so I'd drop the set at init
rather than restore the bit here.

The asymmetry does bite for the rest of the state: a guest-set VC
Enable in RES_CTRL(3)/(4) survives a system reset while CTL/STA are
cleared, and the dev->exp.svc shadow flags set by
pcie_svc_update_map() aren't cleared either.

On the register defines: v1 ended with routing these through
pci_regs.h plus a note on when the kernel header picks them up; they
went into QEMU's pcie_regs.h instead.  Still the plan for a later
spin, or intentional?

Many thanks,
Junjie

