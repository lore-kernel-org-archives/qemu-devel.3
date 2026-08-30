Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9AEC61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zq7-00083q-7N; Sun, 30 Aug 2026 03:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zq4-00082g-KW
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:20:24 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zq2-0004t0-HC
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074422; x=1819610422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3NN2t9r2Azkmq9exQ6+3pR2tk3buhw2The2KdTb3xFA=;
 b=CEr5p0IvV/7JlYIAJNeBXJ3cAobEazjZADUwENy1aRDTGP3ZO7a3dc2r
 nVdsvhs+lmiu+sGaJhPl0xMb9JLihqUjSvaMZLVDgJssiDDEhGir/s+15
 th3MwC8b6HwQlQ0bryTs5g+ACLO8X+F9ru5dNk0NSxacntYGTNm5pfy2E
 6cCcYjYlIkaQC4zkXMZ9pe1ygy6l7Fb247hQIegDyD1Hydwgnj5bXX01D
 /Cx3tfVCl2DqjiDLjeW41KD995NgZlpWLKAeTmG4HJ9gk4Vn+LxCOpMMx
 xKaqRTlH0F97e68EiETxJm1iJRE41oKLD/Gqd+0eSVUjg9bLiNESCPxkT Q==;
X-CSE-ConnectionGUID: Y3cyJlpsRhuK/Igd8lO22A==
X-CSE-MsgGUID: XON2D4czTOuh87Rz72c3+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="92380928"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="92380928"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:20:18 -0700
X-CSE-ConnectionGUID: 92CMuN+MSoaG1EOQ7gBxtA==
X-CSE-MsgGUID: LpRICQnqSkCkPUG41hNkIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="298441716"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:20:15 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 0/9] hw/pci: hw/cxl: Add UIO support in CXL and PCIe
 stack.
Date: Sun, 30 Aug 2026 15:19:53 +0800
Message-ID: <20260830071953.399414-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
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

On Wed, 26 Aug 2026 11:04:00 +0530, Shrihari E S wrote:
> This series is written on top of:
>
> Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
> Repository: https://gitlab.com/jic23/qemu
> Branch: cxl-2026-01-09-draft

Applies clean there and builds; x86_64 cxl-test still passes.  I
booted the patch-10 example topology and walked the extended
capability chains and the HDM decoder registers: the v1 SVC/AER
collision is fixed.  Two things are broken, both on 7/10: the
switch USP never advertises HDM UIO -- its uio gate reads a flitmode
field that nothing sets -- so the example topology can't advertise UIO
end to end, and "-device ioh3420,x-svc=on" aborts QEMU.  Per-patch
comments on 2, 3 and 5 through 10.

Testing point 3 looks at whether existing configurations still work;
the compat question is whether they still look the same to a guest.
2/10 moves x-256b-flit onto pcie-root-port with the default left on,
so every pcie-root-port on q35 comes up in flit mode with no compat
entry -- an inbound migration already fails at that patch, I tried
it -- and 7/10 shifts the CXL DVSEC offsets whether or not x-svc is set.

Worth adding the PCI maintainers on v3 -- eight of the ten patches
touch files under their entry, and both new capabilities land in
hw/pci.

I'll re-run the topology once the USP gate is settled.

Many thanks,
Junjie

