Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C96C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7wZ-0005nt-2u; Fri, 28 Jun 2024 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wX-0005nN-JL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:57 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sN7wV-0005Yc-I2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719567056; x=1751103056;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eCtk3sT3sYL1zlRgK1MJDKojnVFuD7IAxYX3BQAV1zQ=;
 b=FNga582JVurE3xEOUYwQnl+MaYrEwve09OSMTP/BxfazmLFZ0yW0fnG8
 IRPM4Y04k24h9fQSTkiDk4h+Mc5/QGo3au9zLjRhBko0pTS0ZMZMGyea/
 YwWL1OoGWoeG27dOscnkvF7ukosTUKpIqyN2ANUiyliRQoBoXZPlpNUwy
 308QbB4NoU2K7xpz5DZUu2dfhVpl+7PQ/dBgRfZO4eeTu0RrxXpH+yq7W
 l2eckIeNk7eiYwZLmafCI/KHkKm0wI2ugY23c9RzQoEKszM4qWDH26lub
 58Gh1qhuSXpcDeE5FOIjt+eHRiV8gNFOOLAw1QH38m0PWU7gDWTp63xHJ Q==;
X-CSE-ConnectionGUID: 7QLGeluUSNiZaAdr0wc5Ww==
X-CSE-MsgGUID: 3tHRU00YS4af6jmyZMLtQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="28136017"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="28136017"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:50 -0700
X-CSE-ConnectionGUID: awSC6JQSTwih8wDyT2QDcg==
X-CSE-MsgGUID: oz/6aXQoTvarKStQoWYjwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; d="scan'208";a="44677893"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 02:30:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, kraxel@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] Misc fixes on vfio display
Date: Fri, 28 Jun 2024 17:28:13 +0800
Message-Id: <20240628092815.164423-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Zhenzhong Duan (2):
  vfio/display: Fix potential memleak of edid info
  vfio/display: Fix vfio_display_edid_init() error path

 hw/vfio/display.c | 15 +++++++++------
 hw/vfio/helpers.c |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.34.1


