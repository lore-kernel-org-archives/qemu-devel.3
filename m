Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC2C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkY3-0004v1-2t; Tue, 02 Jul 2024 16:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOkY1-0004uJ-Om
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:56:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOkXz-0001EQ-B4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719953779; x=1751489779;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5Pu0+X0mW3eSWd76cLTOnatF+eLmYr+7ew44hAzSYBE=;
 b=O3YIoWKmr01hSjnqw7GbEjnsudIT6yAUMWwyvitk+opxGaVfmbom/3Xe
 OZ/geztC5+ghqE1QlO4VVA3DEjtNiS3nKggZokiYXIfSMUuTVHdD5wxZ1
 KZKyOnp7z1uq2aop0M5xIGLM3Hnn4DxsLSdxBoF2bB71dOZGDa+wrxrXi
 GvLme+eBuAF7RrgLHnPzSCGPxPV78yk/mXCBouLXMXRLwVRHDhLw7FxOJ
 IlxvmAaQMHqrte872teOvyfhShjTTaI/ZJgVaf/sb6Zmv17nP7kqhYs3B
 IFbClMJia4KoT0V3SnHM6T1NHpMTi/+ZK+oMujdt1BoFIw1MIML5z1GtW g==;
X-CSE-ConnectionGUID: cik4Sv1/S3yp5zQyu6lZeQ==
X-CSE-MsgGUID: dmQUgSsCRMWf3sf4uWhQww==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28549751"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; d="scan'208";a="28549751"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 13:56:16 -0700
X-CSE-ConnectionGUID: nJEWdt2IT9CtRVt3nmcuMQ==
X-CSE-MsgGUID: oERP9sOATlmPF0EAJqxULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; d="scan'208";a="46085789"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa010.fm.intel.com with ESMTP; 02 Jul 2024 13:56:16 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Consolidate create-sync and create-fence
Date: Tue,  2 Jul 2024 13:55:01 -0700
Message-Id: <20240702205503.2774745-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

From: Dongwon Kim <dongwon.kim@intel.com>

Sync object itself is never used as is so can be removed
from QemuDmaBuf struct. So now sync is only temporarily needed
when creating fence for the object which means what was done in
egl_dmabuf_create_sync can now be a part of egl_dmabuf_create_fence
function. And egl_dmabuf_create_fence returns fence_fd so the
better function name will be egl_dmabuf_create_fence_fd.

Dongwon Kim (2):
  ui/egl-helpers: Consolidate create-sync and create-fence
  ui/dmabuf: Remove 'sync' from QemuDmaBuf struct

 include/ui/dmabuf.h      |  2 --
 include/ui/egl-helpers.h |  3 +--
 ui/dmabuf.c              | 14 --------------
 ui/egl-helpers.c         | 27 +++++++++++----------------
 ui/gtk-egl.c             | 15 +++------------
 ui/gtk-gl-area.c         | 10 ++--------
 6 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.34.1


