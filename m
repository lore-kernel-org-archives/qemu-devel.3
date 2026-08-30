Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16814C61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zt6-0002q1-8M; Sun, 30 Aug 2026 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zt5-0002pt-5n
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zt3-0005A9-Kn
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074609; x=1819610609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4NIkVkD5IvKDvnVKdz5knljrEMZIwTM5ZESMN5teC6Y=;
 b=QM+63VNUaX8vnAUiWsdu1D5M84ImwtfZV+k7MahN5+zNY+Jwq8lfdP7X
 c2bcndSY8A/ASxPSOMHqEfONwI0xEZcKJMfqpWOD4uIraFih6SjIv13/6
 3YzwrC1FG5M4AwcZOw/UttShsj+MSPdf1V46xMVX/10FiaxFegA2t8dca
 vpEh1IIMtCBAI3dxg+2vrKD/kjTz6vvDt45uZJ6524RBTVhoNk8svKH5U
 0q5Ing5vpYafWFrtOtjGHUftwjqISf4g6Bxom6XyoX40SVnXBByqzNGe9
 9Puv2dQLT7SesLnWfARPqHAubqVTE29d+w7bGyVwhfBFnAXdQ9LhMTBAa w==;
X-CSE-ConnectionGUID: WKhC/wLoQFiMaXHeuOYnFA==
X-CSE-MsgGUID: akajZRi+SSWwLbQpy+nh6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648966"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="87648966"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:28 -0700
X-CSE-ConnectionGUID: cENpL7x0QM2cnZX38v3x2A==
X-CSE-MsgGUID: Hn8JnOpjTG2OFbJHZZERBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="266710519"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:25 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 09/10] hw/cxl: Wire SVC and Dev3 capability to CXL Type 3
 device
Date: Sun, 30 Aug 2026 15:23:05 +0800
Message-ID: <20260830072305.399573-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
References: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
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

On Wed, 26 Aug 2026 11:04:09 +0530, Shrihari E S wrote:
> +    if (ct3d->svc) {
> +        /* SVC capability of the type3 device */
> +        rc = pcie_svc_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF, errp);
> +        if ((rc >= 0) && ct3d->flitmode && ct3d->uio_comp_capable) {

The cover letter says x-uio depends on x-svc and x-256b-flit, but this
only gates the config space capabilities.  ct3d_reset() passes
ct3d->uio_comp_capable straight to cxl_component_register_init_common(),
so those dependencies don't reach the component registers.  I checked:
a type3 with x-uio=on and neither x-svc nor x-256b-flit boots silently
and its HDM Decoder Capability reads 0x00043b12 -- UIO set, UIO
decoder count filled -- with no SVC or Dev3 capability in config
space, and hdm_decoder_commit() will then latch ct3d->uio_enabled from
the guest write.  Failing realize ("x-uio requires x-svc and
x-256b-flit") would keep the device consistent; alternatively deriving
one uio gate at realize and using it for both the capabilities and the
register init would do the same.

It's asymmetric the other way as well: there's no x-uio on the ports,
and x-256b-flit defaults to on for a cxl-rp, so x-svc=on alone is
enough -- a cxl-rp with just x-svc=on reads 0x00042312 -- while the
type3 has to spell it out.  That assumes root ports keep the bit at
all; see my note on 5/10.

Related: ct3d->uio_enabled, the dev->exp.svc flags and the two
pcie_dev3_*_enabled() helpers are written but never read anywhere in
the series.  Same as on 3/10, I'd land them with the code that consumes
them -- here that's the data-plane series.

With the full docs topology (patch 10's example) the layout itself
looks good: on the type3 device SVC lands at 0x248 behind AER and Dev3
at 0x2bc, chain intact, and Dev3 advertises UIO/14-bit-tag completer
with Segment Captured tracking flit mode.

Many thanks,
Junjie

