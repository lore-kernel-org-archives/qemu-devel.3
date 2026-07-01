Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70A9C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemDR-0000S6-0Y; Wed, 01 Jul 2026 00:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wemDO-0000RX-Kl; Wed, 01 Jul 2026 00:06:22 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wemDN-00054X-6W; Wed, 01 Jul 2026 00:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782878781; x=1814414781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fRZ7pHlnAVjKCeS2GP4dM+BoCl+7vcOaqzEarIPk+5M=;
 b=Bc6xKWpM7QPQ3ICztK7MZ8pVGUSO2Qbx5oTQoGSV783Dh0j2XRGfq5rS
 zMeFi2eSN/uVo3/a00a8sTaIprHFBnHkNguj0tPPoPe7PWAZ9iwoKQ8we
 SxtGl54/bPFQarVDu9uhcWOYU9nBG87qMVbblqRY+tzeh6ZmtXaCs32/E
 FMEucws9uZcWWKoz4HKgODdSFOO7k/eEVbRKgDvy38AbKblbBS/+qUDLd
 iGr/Xbx486kGMWTPbfmHqXD/BPIcaSoN8sAVDrUTDeXfEejs9PhtfubA4
 HsDSP79LDUmDEaAzf8D1zK2AdkejvAVMK938tihKXttvVRE1WrHzJMQ32 Q==;
X-CSE-ConnectionGUID: CaIoi/LRR1Gk+jq7erTG6Q==
X-CSE-MsgGUID: NWpqX1WgSb6UloIkzE6ZPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94253334"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="94253334"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 21:06:18 -0700
X-CSE-ConnectionGUID: npczgYX4RuK4rFM5NjQ+BA==
X-CSE-MsgGUID: zN8YV1SZR2qMi9AaklDj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="249804289"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 21:06:16 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Chad Jablonski <chad@jablonski.xyz>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: Re: [PATCH v2 0/2] hw/display/ati: fix HOST_DATA accumulator overflow
 and bpp==0 crashes
Date: Wed,  1 Jul 2026 11:28:36 +0800
Message-ID: <20260701032836.2076507-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519023937.439077-1-junjie.cao@intel.com>
References: <20260519023937.439077-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi Philippe,

Ping on this v2 series.  It has been ~6 weeks without pickup.
Both patches have:

  Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

These fix two guest-triggerable crashes in the ATI VGA host-data blit
path (heap-buffer-overflow via accumulator index overflow, and SIGFPE
from division by zero when bpp is 0).

Still applies cleanly to current master.

Thanks,
Junjie

