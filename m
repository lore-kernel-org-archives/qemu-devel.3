Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF5EC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 11:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOb99-0005RG-Kf; Mon, 09 Jun 2025 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uOb96-0005Qo-Tz
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:58:32 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uOb94-00056q-Dx
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749470310; x=1781006310;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=i3Egw/2Ml9/3iJoQJpmV2HVW802GPWUG14pG1oMZymI=;
 b=C66B+21gN1RlBn1xzDTbA52IO7ErH+CJj/6Ibx/8q2ndKJFa0W1OM1he
 HBmtUgTbiJhcUcpjgQfPZN0Ya6MaLOniIBsdxUR3+G+a33F9gYBs8k6fM
 n3xRfBII0TaC4A99ev9eAoaEiXZ5aXxjG6tpQfA/gmO0OUYx7K+biw3is
 q6fGHv+J9HA20XZNdPAc9s3GL3US64XZb4le8FHrYbTyiZc+5GnqnKUIs
 Q8Ucr/ZflDZZWWL4FQ/QjwI+HaRgmpkHSwiY0VYGdnFXZSgd+hBgmsNld
 s+4LMVIRZLW+nd1la42Qd0pRroKkMxs+XgaGxEugPIUuDtLZgmZoFQrXG Q==;
X-CSE-ConnectionGUID: WOxbOULGQsmdAp50Y7SvEg==
X-CSE-MsgGUID: SrbxxTvPTe2QrNsvcgfjWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51687614"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51687614"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:58:25 -0700
X-CSE-ConnectionGUID: FjmNgvFlQw21MddHjbP+Qw==
X-CSE-MsgGUID: 9P8loa3zTzSfVPUo9kXimw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146398855"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:58:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/container: Fix vfio_listener_commit()
Date: Mon,  9 Jun 2025 19:54:33 +0800
Message-Id: <20250609115433.401775-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It's wrong to call into listener_begin callback in vfio_listener_commit().
Currently this impacts vfio-user.

Fixes: d9b7d8b6993b ("vfio/container: pass listener_begin/commit callbacks")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 203ed0314e..735b5f21b7 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -437,7 +437,7 @@ static void vfio_listener_commit(MemoryListener *listener)
                                                  listener);
     void (*listener_commit)(VFIOContainerBase *bcontainer);
 
-    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_commit;
 
     if (listener_commit) {
         listener_commit(bcontainer);
-- 
2.34.1


