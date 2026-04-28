Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0DCFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHXsp-0006TI-W9; Mon, 27 Apr 2026 22:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXsn-0006Sz-9M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:09:05 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wHXsl-0002bV-Me
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777342143; x=1808878143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nzVyPNKYcLQk0mvKUJeJCFADI1k8+BLw5KypvjmJhBc=;
 b=eVuNrDFbYNgCoR5E+/PYJUJU09Ltm5kkE8H3oCRhPi6xHCvsstR0Xd4T
 Cp3HWOtkE/Pq1SNJngk4wtLgI1SiEXgGdf4NU1NUX+9LfX9/ubLKFMcwW
 b9SGPlx24UnDsuab54D9XMHxyNs+k4ByXI8JAUjk6sjjqyhMACudMY6CG
 4FEYjsa2jVLe+X4oY3AXIWFvCn77CHtpvN/k8+OE0nLQRuwiMMSggdRGD
 VDX9JZItBAY1ygSoOjoShP55/F2GlZO7zJwKsMJTjSSojIm/GCH8sEK/T
 Ie+F1163yMgmRwJ9nmeJvbRtHBlPecDUw3lkqSTYiern5SgL8oH6C3Sly g==;
X-CSE-ConnectionGUID: rGG9gggaS7+8suBt0FGL9A==
X-CSE-MsgGUID: /LowqJ36SkSjRPlXRNo4GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77944945"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="77944945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 19:09:00 -0700
X-CSE-ConnectionGUID: e1r1uRz2QYK5gqjQk83TaQ==
X-CSE-MsgGUID: nzvT9+JQSFivKOAqpH/ZHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="232804788"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa006-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:08:58 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, philmd@linaro.org,
 balaton@eik.bme.hu, chad@jablonski.xyz, junjie.cao@intel.com
Subject: Re: [PATCH 2/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent copies
Date: Tue, 28 Apr 2026 18:11:46 +0800
Message-ID: <20260428101146.3469921-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410183249.4046456-3-peter.maydell@linaro.org>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
 <20260410183249.4046456-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=junjie.cao@intel.com;
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

On Fri, 10 Apr 2026 19:32:49 +0100, Peter Maydell wrote:
> hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>  copies

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

