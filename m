Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1796C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2um-0006ok-RG; Wed, 20 Mar 2024 16:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2ul-0006oQ-IP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:51:59 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2uj-0004VV-Lk
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710967918; x=1742503918;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TKFwaVe+fY4l7ro+ePlHg0i7gBdTSoLXtY5RRyXH5p8=;
 b=BBgNazR9Cp8jcbAnKeQA3PPT/buINNmfnc8t1Crey7TLQzHlZ3U7ppUW
 oXtR6ELo/+x6HLv0Ym0i5Ka6AdhXFW3QOaEUne2r4CvkXUyayybKWOnVB
 P1jMZJmbDhREeON6ixFYSt1AXEP9GzvzBIK5UjXdbvhpRr8vNqBtknxVP
 Kpinf8kwtCmUgKCOzrrbmJawGAFnHX5x7Vcx+CEB/IObImf+z87KKNAg0
 Tw69rDw5MYVttpRNX4xVD+/TisWQ/WuoVF5MPGX0yZVTjLMV3Wma9bonZ
 +qjhyR/ME//cjvacnImKoNznM7vwFATfoDv8msAHPv8jtkIEFoLFeHwKK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16463562"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="16463562"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14679714"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2024 13:51:54 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 0/3] ui/console: initialize QemuDmaBuf in ui/console
Date: Wed, 20 Mar 2024 13:50:15 -0700
Message-Id: <20240320205018.3351984-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QemuDmaBuf struct is defined and primarily used by ui/console/gl so it is
better to handle its creation, initialization and access within ui/console
rather than within hw modules such as hw/display/virtio-gpu and
hw/vfio/display.

To achieve this, new methods for allocating, initializing the struct, and
accessing certain fields necessary for hardware modules have been introduced
in ui/console.c.
(3rd patch)

Furthermore, modifications have been made to hw/display/virtio-gpu and
hw/vfio/display to utilize these new methods instead of setting up the struct
independently.
(1st and 2nd patches)

Dongwon Kim (3):
  hw/virtio: intialize QemuDmaBuf using the function from ui/console
  hw/vfio: intialize QemuDmaBuf using the function from ui/console
  ui/console: add methods for allocating, intializing and accessing
    QemuDmaBuf

 hw/display/virtio-gpu-udmabuf.c | 27 +++++++---------
 hw/vfio/display.c               | 35 ++++++++++++---------
 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  2 +-
 include/ui/console.h            | 10 ++++++
 ui/console.c                    | 55 +++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 33 deletions(-)

-- 
2.34.1


