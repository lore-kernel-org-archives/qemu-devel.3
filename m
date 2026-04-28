Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5C3FF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHXtN-0006e0-Cj; Mon, 27 Apr 2026 22:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXtG-0006cz-IT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:09:38 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXtE-0002l3-KR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777342172; x=1808878172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DGCbDbRJIgLaZaxZYwbCyzY6eyiaOO3GNIes1pkYAn4=;
 b=B5AkD9M3+R1UzxAiXwCntCnzHBe2nJPmzSF5+RSdp91I7lS2eAkBt1dq
 Uce+DgPbj1ibfshTUxxcIhjTiATYpCwuH9bvPszhFULKI9F7YD4yJFvuI
 +vKCxmMDhvZLFSwknL7+UQinWO3c8zyLJ4BNBWna8l7sRiHorYva/D4+4
 tJyRzbCI9S0ZYGW5/FllX4QLCJytVk3c1+PXjm8ucLWY7eh0431EqDT90
 uMJutlsHDYF18i4yuqD/D1P+pCZfscXZFaHTcNl3aa9K/eDm/XQ3o3OrV
 BCvcjMV3Fgqj+AaZZnEGL3vpwX+ojnwW9C0cpv3qLidIOsMJ3GTaxDpUw g==;
X-CSE-ConnectionGUID: KsUOkmbYTjympVG1eAJbdg==
X-CSE-MsgGUID: nKjXggoeREmjk/fv/yxNOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="80818939"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="80818939"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 19:09:30 -0700
X-CSE-ConnectionGUID: nIdSI/4hSXqSH3UQklEqOw==
X-CSE-MsgGUID: vNajt+3iSV690nkqDhu4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="232931815"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa010-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:09:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org,
 balaton@eik.bme.hu, chad@jablonski.xyz, junjie.cao@intel.com
Subject: Re: [PATCH 0/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 ops
Date: Tue, 28 Apr 2026 18:12:11 +0800
Message-ID: <20260428101211.3469935-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410183249.4046456-1-peter.maydell@linaro.org>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 10 Apr 2026 19:32:47 +0100, Peter Maydell wrote:
> Big disclaimer on this: I have no guest images that try to use the
> Cirrus bitblt handling at all, so I have only developed these against
> the reference manual and confirmed that it fixes the UB repro case
> from the bug. If anybody does have test images for these that would be
> good to test...

Confirmed: the qtest reproducer from the linked issue fires on
unpatched master and is clean with both patches applied.  I also
fuzz-tested the patched cirrus-vga (generic-fuzz, ASan + UBSan,
20 workers, ~47M executions / 8 hours) with no new issues.

I have reviewed both patches and they look correct to me.

Junjie

