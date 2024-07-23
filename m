Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CA3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 22:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWNch-00083t-Sb; Tue, 23 Jul 2024 18:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWNcg-00083A-Po
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:04:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWNcd-0002Cd-N3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721772280; x=1753308280;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2o7EpBrugvip8Wb2QdZuFTyqxUu/ox4on/OQ3lk0LKQ=;
 b=T92C1W7u+eeYPG1cvVx5K79YPwEjRSBa3Pemd/gyNxGAk/N7FX0XbEdQ
 f61RXRaBYaiq0dq3WEIsKSml/GUP2P3qCxCBEvN348+tscktii9YEAzwa
 3z5ft4SN4CvXGMZ8DWqLolv2wwx+8TeBk7n2KKnPUxGc/RLRy4zLkjvzK
 HwzfRpyWLTUqaKIY6EaEk1FzCcWiicQy6CBwJyAKjBnz4Ae5d9KqsaWr1
 pRO/JG9wZ8eCnc3B0M4LbFGIVHrbd8N0GLBK5++2WfNeHonKYvyb0M5rL
 USvaMTcCBBPZye+NLxCAyt1OA2FpRF8/vXVCNMw1oX8GIc0Y1A5rD5TOA Q==;
X-CSE-ConnectionGUID: DN9x6N32Q8mnH4VkxcYjtw==
X-CSE-MsgGUID: LpFT1IzsTCaIwZtuyfPI5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19298441"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="19298441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 15:04:34 -0700
X-CSE-ConnectionGUID: BFFibzbcTI2UZLT0IdHS7w==
X-CSE-MsgGUID: wJQpCdDKTFuWVmxvW92dBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="57198645"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa003.jf.intel.com with ESMTP; 23 Jul 2024 15:04:33 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Consolidate create-sync and create-fence
Date: Tue, 23 Jul 2024 15:02:56 -0700
Message-Id: <20240723220258.3170957-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Dongwon Kim <dongwon.kim@intel.com>

Sync object itself is never used as is so can be removed
from QemuDmaBuf struct. So now sync is only temporarily needed
when creating fence for the object which means what was done in
egl_dmabuf_create_sync can now be a part of egl_dmabuf_create_fence
function. And egl_dmabuf_create_fence returns fence_fd so the
better function name will be egl_dmabuf_create_fence_fd.

v3: create fence only if current QemuDmaBuf->fence_fd = -1
    to make sure there is no fence currently bound to the
    QemuDmaBuf

Dongwon Kim (2):
  ui/egl-helpers: Consolidates create-sync and create-fence
  ui/dmabuf: Remove 'sync' from QemuDmaBuf struct

 include/ui/dmabuf.h      |  2 --
 include/ui/egl-helpers.h |  3 +--
 ui/dmabuf.c              | 14 --------------
 ui/egl-helpers.c         | 24 +++++++++---------------
 ui/gtk-egl.c             | 17 ++++-------------
 ui/gtk-gl-area.c         | 12 +++---------
 6 files changed, 17 insertions(+), 55 deletions(-)

-- 
2.43.0


