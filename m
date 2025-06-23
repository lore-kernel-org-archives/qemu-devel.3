Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E4EC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNs-0005xY-8M; Mon, 23 Jun 2025 06:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNp-0005wS-3K
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:37 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNl-0000l4-VM
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674394; x=1782210394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TC0z9Q1FwXllaKpGPNdMbhIi47tz2jGUovh6tzE2h5w=;
 b=AuZGz5A1nKnTGLUsXEgE85OUcO2tNxFcirPQs+fh2Mt0nDgLZROLfSss
 YmE1vz/6atEqo7IMHUxDAqAJ4ggNCeypFRWJdFzIZGV4svbYOdxZYUWhL
 BFWAmuAT3HYk8fc2saRhhaVQ7DVGUzG0tXwbjf5G6ZMxognx2iMsGGoS6
 zWZAOAxHEm/1R/KNpGgNoQhVu/Nmr9wCX8uxB3op1W4MJNvKUcBZ/KsP3
 gjTK7tsgatcJob1esZAYc0Ol8WfwQwJ16SqGNSUSNJdFYPFLR2kWhlksv
 y30PIJsZi790JlZac98h/DgW6GBPdaYiZOo+Hukzpu8kmFiTsm+DLdmus w==;
X-CSE-ConnectionGUID: Eh/H8FeOTeyWF/zfZ8RG7A==
X-CSE-MsgGUID: ssAOnNHXRCWDKo/wusNEeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63565451"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63565451"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:31 -0700
X-CSE-ConnectionGUID: oZo9Bd+CTFG2X1mhhzNnLw==
X-CSE-MsgGUID: QLsLFPmCRgi1Y2qnxV1G4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182427937"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/4] vfio/container: Fix SIGSEGV when open container file fails
Date: Mon, 23 Jun 2025 18:22:32 +0800
Message-Id: <20250623102235.94877-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623102235.94877-1-zhenzhong.duan@intel.com>
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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

When open /dev/vfio/vfio fails, SIGSEGV triggers because
vfio_listener_unregister() doesn't support a NULL bcontainer
pointer.

Fixes: a1f267a7d4d9 ("vfio/container: reform vfio_container_connect cleanup")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e8d645ebb..2853f6f08b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -710,7 +710,9 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     return true;
 
 fail:
-    vfio_listener_unregister(bcontainer);
+    if (new_container) {
+        vfio_listener_unregister(bcontainer);
+    }
 
     if (group_was_added) {
         vfio_container_group_del(container, group);
-- 
2.34.1


