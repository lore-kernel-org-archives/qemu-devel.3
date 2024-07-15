Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E21C3DA52
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGjw-0003KH-OI; Mon, 15 Jul 2024 04:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGju-0003AU-6p; Mon, 15 Jul 2024 04:07:18 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjr-000480-Aw; Mon, 15 Jul 2024 04:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030835; x=1752566835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZVM8m5lTvskYcDVaIB47aX485qUonoxl/4+eSxCJAec=;
 b=WkGlAoSjdA3J+kRXcgzhy3X8DGEhLRjtBiUOEQhUXwsIMmeCDXIHJb+4
 +M/ea4Ek4Q7SILRWizz6rc8qAsk4BYLJ/ec+D3vXtJ6Ee83rzK6omNpBI
 yUES8USsLFsjWxtz6xI0pZYDXpGey8mMKYm+jlfci+gn+IJEI/YH7aUUx
 s+n4dkHvl/4TFmNIz/Kl3WQA156KWSxUrMjSMWFcekCmv82neF3UayYik
 sJ3+VkqLDx8mqdbHKxsDNMi2EFkIm0LZPfvqvCuv8z4vhxkexrmALsx6W
 cP8jentPrURFUGFfFUT/X+KPXbFevJkFy7WzY6ynRgiGUT9f1phFgspIO w==;
X-CSE-ConnectionGUID: tX4jCJXvRKSqI8kVraRB+g==
X-CSE-MsgGUID: 65SU5QyLREWZph4bv/EyHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935684"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935684"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:46 -0700
X-CSE-ConnectionGUID: YlH62MMRRxiJ14Hvk5ZgqA==
X-CSE-MsgGUID: esDv1OQKSPW76zLsMkw5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512596"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 6/7] backends/iommufd: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:54 +0800
Message-Id: <20240715082155.28771-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open().

Cc: Yi Liu <yi.l.liu@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 backends/iommufd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 84fefbc9ee7a..cabd1b50025d 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -77,9 +77,8 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     int fd;
 
     if (be->owned && !be->users) {
-        fd = qemu_open_old("/dev/iommu", O_RDWR);
+        fd = qemu_open("/dev/iommu", O_RDWR, errp);
         if (fd < 0) {
-            error_setg_errno(errp, errno, "/dev/iommu opening failed");
             return false;
         }
         be->fd = fd;
-- 
2.34.1


