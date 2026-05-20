Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAADCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 00:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPUrN-00065F-Oa; Tue, 19 May 2026 20:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPUrG-00064Y-VJ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 20:32:24 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPUrA-0000CI-Jo
 for qemu-devel@nongnu.org; Tue, 19 May 2026 20:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779237137; x=1810773137;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2Q/B9ClWDAJhEVYD8bt5AtYNEmM9GLCaDY0695OHgms=;
 b=Gr4FfNYNF9oep+TPRkBpbi7RsxYCmOKHcBrGG6M/fh3emltK9Z6YcET0
 47XeuCLK97vF7lc5SN8phRz5qKUUAy2PBqeu9B2ueWw5cm5u5DQwXMwmC
 yZfFy3TcSk4oj5PcEtew+whTcaMPTfnvantSmG/tagTmkWUnDUTFv0N9N
 QKLMKd25y/iXjdMsurKlQUxvcqMNSws7CNODIi4tGyHM1UrZrNQ50VuCG
 XdS9WtNnDKuT+qfX54ythdTjC+iR6vWjag9xkxcr1Nop5YsywvKfSg3hq
 9PegSbkxBO2we0Jok8YtHSbWLEC6vCb1iat2oMz2P2VzXuVvqCxLH56BW g==;
X-CSE-ConnectionGUID: Fy9JO0WBRfiM8NHiqvuGDw==
X-CSE-MsgGUID: s60X1M+yQyulKP0d2HQx/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80303861"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80303861"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 17:32:08 -0700
X-CSE-ConnectionGUID: ymkJT4OCQPWK5As4aUT26w==
X-CSE-MsgGUID: rtPOUH/fQVqmPvcLmZCknA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="233582574"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by fmviesa009.fm.intel.com with ESMTP; 19 May 2026 17:32:07 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Fix focus loss on re-attachment with single VC
Date: Tue, 19 May 2026 17:26:45 -0700
Message-Id: <20260520002645.1910740-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

When QEMU is launched with a single virtual console (e.g., using
--nodefaults), detaching and then closing the detached window leaves
the main window's notebook without an active focus target which makes
keyboard unfunctional on re-attached VC.

Fix this by explicitly calling gtk_widget_grab_focus on the active
VC's focus widget during the window close handler.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 2c61b601f7..8eb1a80377 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1475,6 +1475,11 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
         vc->gfx.ectx = NULL;
     }
 #endif
+
+    if (vc == gd_vc_find_by_menu(s)) {
+        gtk_widget_grab_focus(vc->focus);
+    }
+
     return TRUE;
 }
 
-- 
2.43.0


