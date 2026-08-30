Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A4AC61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ZsO-0002AH-Ry; Sun, 30 Aug 2026 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZsD-00029j-Pn
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:22:39 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZsC-00055o-6W
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074556; x=1819610556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jUegJOR4pPawE5ph/mewC+UoL2k0Lo4ladFvM+3M7vk=;
 b=UIAxTsFfqT3HXGzq0SDs6QVKGdeIf/bqdQOhUO3GeMo1LFteQxNhW6JO
 t48UsqPfHb6zXnA0dhrSUP1v2Sl1OPhQBRg9X9EynInpme3n7nWG5sbWK
 D/rRtyd1jrh/9NLRdDr+SF1HqQv5rRE9i0az8tI1MM4bIXQhr/HVof5iv
 iGWkxFJHt0NH/ruRbmRSVWh44nkpS0UvkKNJUi6XNFmhDTJWGHHQIhJf0
 hkEOod5a8GlclKJrEBzBNoim4aDYeaT/VM/nB8ocoyLYeBJtTsolyHLaO
 gNA5ouwb3/odTVIOPUP2L9OohSfa2C21sqoVXoHjauhEamPDbsK0qqLz7 w==;
X-CSE-ConnectionGUID: U6NnjSzMR9mOWnNGUyIJYQ==
X-CSE-MsgGUID: pwdd+YTcS8iYbFXtaMTeIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="106041837"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="106041837"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:22:34 -0700
X-CSE-ConnectionGUID: 2yD5x09dT5KrKbnDj/aPEQ==
X-CSE-MsgGUID: bKN3jF5FTTCcgMQMy+AIvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="306759943"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:22:31 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 07/10] hw/pci: hw/cxl: Wire SVC initialization into port
 realize functions.
Date: Sun, 30 Aug 2026 15:22:09 +0800
Message-ID: <20260830072209.399529-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <111374580.41787732282793.JavaMail.epsvc@epcpadp2new>
References: <111374580.41787732282793.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=junjie.cao@intel.com;
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

On Wed, 26 Aug 2026 11:04:07 +0530, Shrihari E S wrote:
> +    if (p->svc) {
> +        rc = pcie_svc_cap_init(d, CXL_UPSTREAM_PORT_SVC_OFFSET, errp);
> +        if (p->flitmode && rc >= 0) {
> +            usp->uio_capable = true;
> +        }
> +    }

This gate never opens on cxl-upstream: p->flitmode is the PCIEPort
field, but the USP's x-256b-flit property still targets its own
CXLUpstreamPort::flitmode rather than the field patch 1 moved to
PCIEPort, and nothing sets the PCIEPort one there.  Everything else on
the USP (pcie_cap_fill_link_ep_usp(), the DVSEC status,
latch_registers()) reads usp->flitmode, so the port reports flit active
while uio_capable stays false.  I read the HDM Decoder Capability
register back on the patch-10 example topology with
x-svc=on,x-256b-flit=on everywhere: the USP reads 0x00000382 -- UIO
clear, UIO decoder count 0 -- while cxl-rp reads 0x00042312 with UIO
set.  A switch topology, the case the cover letter leads with, can't
advertise UIO through the USP.  What worked for me was dropping the
CXLUpstreamPort copy so both readers take the PCIEPort field: with
that the USP reads 0x00042382 and nothing else in the topology moves.
I'd put it in 1/10, which left CXLUpstreamPort::flitmode behind while
its message says the refactor "allows all the derived ports ... to
use this property".

rpc->svc_offset is only set by gen_pcie_root_port; ioh3420,
pnv-phb-root-port and aspeed.pcie-root-port leave it 0, so

  qemu-system-x86_64 -M q35 -display none -device ioh3420,x-svc=on

aborts:

  ../hw/pci/pcie.c:1140: pcie_add_capability: Assertion `offset >= PCI_CONFIG_SPACE_SIZE' failed.

I'd either give them svc_offsets or fail realize with a proper error
when svc_offset is 0 and x-svc is set.

Neither of those shows up in make check.  A qtest instantiating
ioh3420,x-svc=on would have caught the abort; the USP gate only shows
up in the component BAR, where I read it in the HDM Decoder Capability
register, so a chain walk wouldn't catch that one.  Worth some
coverage for the two new capabilities.

The v1 SVC/AER collision is fixed -- I walked the extended chains
over ECAM: gen pcie-root-port has SVC at 0x150 after AER/ACS, cxl-rp's
four DVSECs moved out to 0x1c4 with SVC taking 0x150, and usp/dsp have
SVC at 0x148 with SN/DVSEC offsets shifted to match.

The DVSEC moves are unconditional, though.  CXL_ROOT_PORT_DVSEC_OFFSET
and the usp/dsp equivalents are compile-time chains through
PCI_SVC_SIZEOF, so x-svc=off changes nothing: on a topology with no
x-svc anywhere I read cxl-rp DVSECs at 0x1c4 (0x150 on the base
branch), usp DSN at 0x1bc (0x148), dsp DVSEC at 0x1bc (0x148).  That's
a config space change on existing CXL machines with no property to gate
it.  Migration won't notice -- none of the CXL devices carries a
VMStateDescription, so their config space never reaches the stream --
but a guest on an unchanged machine type sees the DVSECs move across
QEMU versions, and there's no knob to hang a hw_compat entry on.

Many thanks,
Junjie

