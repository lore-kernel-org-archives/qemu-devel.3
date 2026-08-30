Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B29EC61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zqa-0000EB-Ju; Sun, 30 Aug 2026 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZqY-0000BR-KY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:20:54 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZqX-0004v0-4c
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074453; x=1819610453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LdTtOWeM2IupHOESHTlR4fJuKJIE7l5dPUGdYK1waLI=;
 b=e6deKZBx+r0jNKEJnjCygeQO/JC5WbRLD1H3tdzt/djRpmcj8zjsWJaB
 RyccqwFRWmCnTOcjtlKaV0JcNul+RoCaCMOboKVZaykBrd5XSsOWMEWaQ
 CjiRifyjUT7WVf7LJEj/yZAJzF0jxMVQ+G/fvtT75WU2IT1zqlK1bDgat
 n223S/ObtTk/4QWged1BT8Uc2N89OYhdRqlvq4RcflreybZrjcC3Fxtvc
 wuH3EbSi+lwIZvRWQgomTMyp6rS1ZodgkRo3ZEFGQWl9iSdB8WZTDmcRE
 SKuW0PjjX0kki70z2TfbQZGYaVoOGQrXO99ILRrc29rfrO4scVwYuB4yX g==;
X-CSE-ConnectionGUID: 0yti1ZyZQwS5UVLxB0CvYw==
X-CSE-MsgGUID: xAf9QDvURwS0SEBX8sTGgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="105890981"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="105890981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:20:51 -0700
X-CSE-ConnectionGUID: /DlKDPiXRMy5CWLkvaUrrw==
X-CSE-MsgGUID: F28vXvpvRlGJOowH3bxy+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="292017711"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:20:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 02/10] hw/pci: Move 'x-256b-flit' property from
 cxl_root_port to pcie_root_port.
Date: Sun, 30 Aug 2026 15:20:20 +0800
Message-ID: <20260830072020.399442-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
References: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=junjie.cao@intel.com;
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

On Wed, 26 Aug 2026 11:04:02 +0530, Shrihari E S wrote:
> @@ -152,6 +152,7 @@ static const Property rp_props[] = {
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
>  };

This moves the default=true along with the property, so it now applies
to every derived root port (pcie-root-port, ioh3420, pnv-phb-root-port,
aspeed.pcie-root-port), not just cxl-rp.  On an empty port the LNKSTA2
flit status bit flips at this patch alone -- pcie_cap_fill_slot_lnk()
consumes flitmode, and pcie_sync_bridge_lnk() only overwrites it once a
child is plugged -- so "does not impact any existing behavior" doesn't
cover the derived ports; with patch 6's pcie_cap_fill_lnk() additions
the ports also come up with Flit Mode Supported (Flags bit 15) and
LNKCTL bit 13 guest-writable.  I checked "-device pcie-root-port" and
"-device ioh3420" on q35 with the series applied: the Express Flags
read 0x8142 on both; before the series the property didn't exist on
these devices and bit 15 stayed 0.

That's a guest-visible config space change on non-CXL machines with no
compat handling.  Migration already breaks at this patch -- pc-q35-9.2
at both ends, plain "-device pcie-root-port", a build at the series
base on the source and one at 2/10 on the destination:

  get_pci_config_device: Bad config data: i=0x87 read: 0 device: 4 cmask: ff ...
  load of migration failed: ... '0000:00:03.0/pcie-root-port'

0x87 is the high byte of PCI_EXP_LNKSTA2; with the whole series on the
destination the first mismatch comes earlier, at 0x57, PCI_EXP_FLAGS.
Fresh q35 guests see different hardware too.  Was extending the default
beyond cxl-rp intended?  If yes, it needs hw_compat entries for older
machine types.  If not, defaulting to off here and setting flitmode
in a cxl-rp instance_init would preserve current behaviour for
non-CXL ports: a second DEFINE_PROP in a subclass asserts on the
duplicate name, and instance_init still runs before qdev applies
globals, so -global and hw_compat keep working.

Many thanks,
Junjie

