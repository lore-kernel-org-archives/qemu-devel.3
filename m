Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A75FC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 01:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO6Bu-0007CB-5K; Sun, 30 Jun 2024 21:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Br-0007BT-PH
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:48 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO6Bq-0002Vo-5m
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719798646; x=1751334646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QFoo/oW2gy364eaSg+HnP/vfvqJKypfoae1HGt5KJYE=;
 b=KoLQk2MunXUAur89nzaPOKkSiPfKsfnopR4/corg9hR9OhpfEzYBcNIS
 uHJAQ9O5KvjJAksPdvRCgqrOxFwaWdtTqn/Qm+l1Ls399gjroXS78uY5a
 5WvuMHXHUCJtK5FVdttOOMsw9BCzmlc+9Pm8QtgjVFzmhijt5j7Nk534L
 rVB3ug66E/2EVkDLg1o98CTO0Q8F3Q+MzsjEtelH+72zCi3SvlUOoDSN/
 lwejrZ8MFsiDErtBNmFfqGwQKv254i6CflQbmlzWkkDZmoQhNWT+UBLOo
 J3vhsZnZhME/K8kQifZb2RUGx70wvSBzuzMWo2/HVecSLBzKeAnSu3Jpk Q==;
X-CSE-ConnectionGUID: 0TtBveQMQtCyQreiuM+ilQ==
X-CSE-MsgGUID: BBWVckAqT3qlHYINY8l/JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="42319509"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="42319509"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:45 -0700
X-CSE-ConnectionGUID: TtqF1Mw4TXa14+KwDs9ylg==
X-CSE-MsgGUID: +cuiyYa9T3iihRkjHASGOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45331373"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:50:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, marcandre.lureau@redhat.com,
 kraxel@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/2] vfio/display: Fix potential memleak of edid info
Date: Mon,  1 Jul 2024 09:48:08 +0800
Message-Id: <20240701014809.255682-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701014809.255682-1-zhenzhong.duan@intel.com>
References: <20240701014809.255682-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

EDID related device region info is leaked in vfio_display_edid_init()
error path and VFIODisplay destroying path.

Fixes: 08479114b0de ("vfio/display: add edid support.")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 661e921616..9c57fd3888 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -171,7 +171,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
 
 err:
     trace_vfio_display_edid_write_error();
+    g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
+    dpy->edid_info = NULL;
     dpy->edid_regs = NULL;
     return;
 }
@@ -182,6 +184,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
         return;
     }
 
+    g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     g_free(dpy->edid_blob);
     timer_free(dpy->edid_link_timer);
-- 
2.34.1


