Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56FDCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkwR-0002nx-AP; Wed, 17 Jun 2026 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwP-0002nm-OB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:44:05 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wZkwO-0003fS-2x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781682244; x=1813218244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/EdeG20kEJzpkiORgoCE63qhp/Du+TBSDBWc2PyQuis=;
 b=UXYbJPoD0NSl1rOXCQM44A3+sbr8iOvgqASLi3/nBl3fBwNPR3C9j51n
 7cLQ25oxRC2g33JuTQ0GJPDxQept+tsv2JRRjc/ggu/fFzT1Ofm2mbckZ
 FmiShg/Tc/rvf9hTNJeWvqYqUrFlqS3yTVvllDDFuDhwSfzaD5ZKo2s+P
 CKm2g7JxTmkS5D15O63e18hT0DbSsTbB75IN2jS4NXeqJ+JdHGc8+1fIS
 Az4fyLDu6fIUVNZZADdW9+CIagxqjs+JWJiBnj+GzcL3ScxUD7liqRx8p
 UaKABBz1/gtq5HzENNsMIhKVmagPgoDLzqgBD9XFg7dtrFuBi2dyznBYU g==;
X-CSE-ConnectionGUID: 8BHpJ8y2RciyFSpWivt9SA==
X-CSE-MsgGUID: Cobvnr3/Q62mg641XT33hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133624"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93133624"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 00:44:03 -0700
X-CSE-ConnectionGUID: QS8us01VRcSTU+PBtapD8g==
X-CSE-MsgGUID: heGMeiy3SveOyifxnzjMCg==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:59 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>, jic23@kernel.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 7/8] hw/pci: hw/cxl: Wire SVC initialization into port
 realize functions.
Date: Wed, 17 Jun 2026 23:45:19 +0800
Message-ID: <20260617154521.520191-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-8-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <20260609105836.3702787-8-shrihari.s@samsung.com>
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

On Tue,  9 Jun 2026 16:28:35 +0530, Shrihari E S wrote:
> +    pcie_config_uio_svc(d, errp);
>      pcie_cap_arifwd_init(d);
>      pcie_cap_deverr_init(d);
>      pcie_cap_slot_init(d, s);

In rp_realize() (and the two xio3130 ports) pcie_config_uio_svc() runs
before pcie_aer_init().  pcie_svc_cap_init() falls back to offset 0x100
when no extended capability exists yet, so SVC is placed at 0x100 at
this point -- and then pcie_aer_init() puts AER at the same 0x100 and
overwrites it, while dev->exp.svc_cap still points there.

The visible effect is that "-device pcie-root-port,x-uio-svc=on" comes
up with no SVC capability in the extended config space (the chain is
just AER -> ACS), and no error is reported, so the request is silently
dropped.  I reproduced this by walking the extended capability list of
the root port over ECAM: SVC (0x35) never appears, even though the
property was set.

> +    rc = pcie_config_uio_svc(pci_dev, errp);
> +    if (p->flitmode && rc >= 0) {
> +        crp->uio_capable = true;
> +    }

On cxl-rp this runs a second time: cxl_rp_realize() first calls the
parent rp_realize() (which already calls pcie_config_uio_svc() per the
hunk above) and then calls it again directly.  The first call collides
with AER at 0x100 as above; the second runs after the extended caps
exist, so SVC ends up correctly at 0x200.  So cxl-rp happens to work,
but via a double init.

Just moving the call to after pcie_aer_init() isn't quite enough on
its own: the CXL ports (cxl-rp/usp/dsp) build their DVSECs at fixed
offsets and then add SVC themselves at the end, so if the shared
parent rp_realize() also adds SVC before those DVSECs are built, the
cxl-rp ends up with its DVSECs off the chain.

What worked for me was to move the SVC call after the ECAP inits in
the pure-PCIe paths and skip it in the parent when the device is CXL,
letting the CXL realize functions keep adding it last as they already
do:

  - rp_realize(): move pcie_config_uio_svc() to after pcie_acs_init(),
    guarded by if (!pci_is_cxl(d)) so cxl-rp's own call (which runs
    after build_dvsecs()) remains the one that places SVC.
  - xio3130_upstream/downstream realize(): move the call to after
    pcie_aer_init().
  - cxl-rp/usp/dsp: unchanged, they already add it last.

With that, plain pcie-root-port, the xio3130 switch ports and the CXL
ports all come up with SVC at 0x200, and cxl-rp keeps its four DVSECs.

One thing to note is that this only gets the capability enumerated --
I haven't verified the SVC behaviour beyond that.  Looking at
pcie_svc_cap_write_config()/pcie_svc_apply_gating(), writing the SVC
Enable bit just copies ctrl/status into the shadow struct; no VC
Resource Status bit (the per-VC negotiation bit, SVC_VC_NEGO) is ever
set, and the SVC Status register stays zero.  So a guest that enables
SVC and polls for negotiation wouldn't see anything change.  If the
data-plane series on top is expected to drive that, fine -- I just
wanted to flag that as things stand the enable is observationally a
no-op, in case a driver is expected to key off it.

Many thanks,
Junjie

