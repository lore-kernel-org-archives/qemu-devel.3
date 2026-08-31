Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C96C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0x3z-0003Ij-4u; Mon, 31 Aug 2026 04:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0x3y-0003IU-2G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:08:18 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0x3w-00049y-LF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788163697; x=1819699697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U+TiwCVbbYEWUZQNmeou93WTC+YnHEeVvhuQzlTWlms=;
 b=TYfhBI4kCMwjJD7UImzu7TT/74fuSLO+ih7DSwtexUDLUZIZ08XwCzZl
 Wwdtd8xK/9ZocG4TCfJyg7z5PXJGFOnQD4VyNECa9B/VSvnZMowtOsqr4
 AMuOx/9BLBavQGygc0bHgrZHl/7fRxNPQxNns5kG1PMmWgjFUXFtpMZM+
 Dlkm0Gwz1A3Ggrtkk6/J5G2WXNGZBaFo50lfT5W8mXsLHDvTxXgA79Nbw
 0WPiVFkUYY01JJjxC8DWqy2dYMlhIJh8423LThaYaI9fdH67+iuSedgwD
 DT0BkWL+GH6hNjacPyj7RHsElri4hcgATaJAxzwuqGImOQ9Z2lWEqy1cR Q==;
X-CSE-ConnectionGUID: Uti0Sgp1SV2s15kKcEuImA==
X-CSE-MsgGUID: OJ+O3DySSryUxMgF0tpNgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88588210"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88588210"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:08:13 -0700
X-CSE-ConnectionGUID: OM/f9X1eSR+ilDUacpFdfg==
X-CSE-MsgGUID: tOgbbR3XRYml6IhTeOZkog==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:08:10 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
Date: Mon, 31 Aug 2026 16:08:01 +0800
Message-ID: <20260831080802.410117-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=junjie.cao@intel.com;
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

Hi Jonathan,

Ping -- still applies clean on master, cxl-test passes.  1/7 and 3/7
have Philippe's R-b.

Adding Michael given your note on Haotian's CDAT fix that a staging
tree is a while off.

Many thanks,
Junjie

