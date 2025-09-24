Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A1CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JXB-0005tV-Hl; Wed, 24 Sep 2025 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JX3-0005sO-I7
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:19 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JWw-0001S3-0U
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758697390; x=1790233390;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yZqiSNdpDOmaSmSgKp1gIl/Mh9K7OY1nVmqCALvc5m4=;
 b=F5v5lnd14YgaRUzGXj9jDRCE9vlNYTL/6umvxIISiRljikmHNZVhkkFO
 d1UYImCHCEACZOZs2C0f6uWwZm2t7dBcc8Etd0Agu7q8CkyUAeGND4ncC
 HkHr9W+RQpt4b/6stZVrBJp4fJQJlewEnZ2E9sfgponTY0ZJCIvcvpikH
 C4Z164aMVIwZPD3VOAPKFAwbP7+tR27DdcRQIGh8RvVYlnT9XBI71qfoB
 fpc0UfJcJwL3ZHb/JfFfRdx+ex/6A0MD8tR1iekrQm4DtTEvvoBJsIIJs
 Pz23i/04/y/63ehxAUaSVsjT3w4x0TXAb5WDdBg4RWtuTqGKKqFE7mEDt Q==;
X-CSE-ConnectionGUID: bSGmJa0ZTiy7JBu7LlZ4Nw==
X-CSE-MsgGUID: 2k7IoXFaQuWRjgM64nfsIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86429765"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="86429765"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:03 -0700
X-CSE-ConnectionGUID: 9W6FRImfQLGlotGUhkwuSw==
X-CSE-MsgGUID: 9IxeGwi8TVqbn1KSSo8qbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="180975701"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] Optimize unmap_all with one ioctl()
Date: Wed, 24 Sep 2025 03:02:52 -0400
Message-ID: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently unmap_all is split into two ioctl() with each unmap half of
the whole iova space.

IOMMUFD supports unmap_all ioctl() from beginning, after kernel commit
c19650995374 ("vfio/type1: implement unmap all") added same support
for VFIO type1, the split becomes unnecessary.

So optimize the code to only do one ioctl() to unmap_all for both
backends.

Test:
In order to trigger unmap_all request, made below trick, during emergency
reset in guest, memory region [0xfef00000 - 0xffffffffffffffff] is
deleted, I fake it to be a unmap_all request.

--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -714,8 +714,10 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (try_unmap) {
         bool unmap_all = false;

-        if (int128_eq(llsize, int128_2_64())) {
+        if (int128_eq(llsize, int128_2_64()) ||
+            iova == 0xfef00000) {
             unmap_all = true;
+            iova = 0;
             llsize = int128_zero();
         }

The log shows ioctl() succeed on the whole iova space:

vfio_listener_region_del region_del 0xfef00000 - 0xffffffffffffffff
iommufd_backend_unmap_dma  iommufd=10 ioas=5 iova=0x0 size=0xffffffffffffffff (0)

Same result for legacy VFIO.

Maybe it's easy to trigger unmap_all with other arch, e.g., arm smmu, but for x86,
iommu memory region is split by iommu_ir, unmap_all isn't triggered.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  vfio/container: Support unmap all in one ioctl()
  vfio/iommufd: Support unmap all in one ioctl()

 hw/vfio/container.c | 33 ++++++++++++++++++++-------------
 hw/vfio/iommufd.c   | 16 ++--------------
 2 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.47.1


