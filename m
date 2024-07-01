Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1BDC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 01:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO6Bt-0007Bo-QI; Sun, 30 Jun 2024 21:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Br-0007BR-Lt
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:47 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Bp-0002VV-KC
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719798646; x=1751334646;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Cvo81JUYH9t6uCL5tpX36hZU1Hqj238AS+goBTkI8/E=;
 b=eorTncwPc6Hh/jmvs1rX0jVRjKarGaNGQIaqwWshgtRJxPWKqIlgR6GS
 n5P4l4Bi5i2bgkI8Glxhm+rmnB5MXREyc87tJryEt1shr0U0CQ5ti+SQj
 uT74bC6ba33F5Typ19G5drwgNY2CIBRwMBM/8qtUdudetCe+MDMgooq5C
 XB2JJhuENcHNIYLQXy5yrPsKIRLPL89ExwCb0PzyNkNj4Mu8RXWgNfL5y
 0fIjXmt8FhKSR7Ffw2mppBic39w1X2SQqdfwgyrFBosECfN+Sxy5b7Fd+
 BZ5t/v0zn3Vsa1Ikfp6ezkxjUP9owhqRqUfLtRNmcWHsYNNcFNf/Fmy6X w==;
X-CSE-ConnectionGUID: g6cqlmegR0iAoYd7+n4RAA==
X-CSE-MsgGUID: OLY039FJT6qnj7x/SPAbEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="42319508"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="42319508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:43 -0700
X-CSE-ConnectionGUID: EUO8s+6JRQe+XObdGP/rvw==
X-CSE-MsgGUID: SddBhzWHRJirO+UyPdYSaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45331360"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, marcandre.lureau@redhat.com,
 kraxel@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/2] Misc fixes on vfio display
Date: Mon,  1 Jul 2024 09:48:07 +0800
Message-Id: <20240701014809.255682-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This is trying to address an issue Cédric found.
See https://www.mail-archive.com/qemu-devel@nongnu.org/msg1043142.html
While looking into it, also found a potential memory leak.

I'm sorry that I didn't find how to test this fix, because it looks
a GFX card is needed. Any idea on how to test or help test are quite
appreciated.

Thanks
Zhenzhong

v2:
- set dpy->edid_info to NULL in vfio_display_edid_init() err path (Marc-André)
- remove a wrongly added g_free(*info) in vfio_get_dev_region_info() (Marc-André)
- add R-B on patch2


Zhenzhong Duan (2):
  vfio/display: Fix potential memleak of edid info
  vfio/display: Fix vfio_display_edid_init() error path

 hw/vfio/display.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.34.1


