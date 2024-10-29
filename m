Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E5ED5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpf-000380-Aw; Tue, 29 Oct 2024 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpd-00035U-Cp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:05 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpb-00083P-Kv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191444; x=1761727444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fPJOO4j7DoNvl7atZ840KrayE9ekf6SO5xM1CH2yL+I=;
 b=UcEC+DbVmUw0Ebha1aLNEZcZZjPnwU6FYxN2fVw3tGdeSw4rf2E/XKKi
 fTPjfu0Rj6lmDVeBDSkX18Ibg+5GIxVQ9B04Jpx+v4fXbmVaLORua2zde
 BAI2YDyFQCdqPlZW/ZggLf2RicPVfJJazTvNBJldTBiF/DLR/UkjgCIQ8
 d8LJOnOlSHHQl5IsHYsqSX6rRtp5Q8nSdaT2mzr09yG1w2CrO8uw6KnT2
 F0WubDaM+rYUWzP70ffKQRC67QEu+QMYq1juIm4hGs4h3qtxb/A1/FUIT
 HjOljvogAJByKZRT7PoKu0uzc2KKn/0dQA8r7irh7bgv4wycB0SYPmJD4 A==;
X-CSE-ConnectionGUID: 2WKNelnESJyhcHFPYvAf0w==
X-CSE-MsgGUID: mIUyw5FGQa6xuypj4JK0yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592833"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592833"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:45 -0700
X-CSE-ConnectionGUID: v+D8dni6R8WYFl2qgxwOHQ==
X-CSE-MsgGUID: CKURs3kJSMOtCom4I8n6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847231"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:44 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 14/16] ui: Replace type_register() with type_register_static()
Date: Tue, 29 Oct 2024 16:59:32 +0800
Message-Id: <20241029085934.2799066-15-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 ui/console-vc.c | 2 +-
 ui/dbus.c       | 2 +-
 ui/gtk.c        | 2 +-
 ui/spice-app.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53fcee88f4ac..fe20579832a5 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1073,6 +1073,6 @@ void qemu_console_early_init(void)
 {
     /* set the default vc driver */
     if (!object_class_by_name(TYPE_CHARDEV_VC)) {
-        type_register(&char_vc_type_info);
+        type_register_static(&char_vc_type_info);
     }
 }
diff --git a/ui/dbus.c b/ui/dbus.c
index 7ecd39e784a9..d60b59cc5462 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -476,7 +476,7 @@ early_dbus_init(DisplayOptions *opts)
 #endif
     }
 
-    type_register(&dbus_vc_type_info);
+    type_register_static(&dbus_vc_type_info);
 }
 
 static void
diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679a1..f9a53ea78ed7 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2540,7 +2540,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
     keycode_map = gd_get_keymap(&keycode_maplen);
 
 #if defined(CONFIG_VTE)
-    type_register(&char_gd_vc_type_info);
+    type_register_static(&char_gd_vc_type_info);
 #endif
 }
 
diff --git a/ui/spice-app.c b/ui/spice-app.c
index a10b4a58fe74..2a93ae591846 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -173,7 +173,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
         exit(1);
     }
 
-    type_register(&char_vc_type_info);
+    type_register_static(&char_vc_type_info);
 
     sock_path = g_strjoin("", app_dir, "/", "spice.sock", NULL);
     qopts = qemu_opts_create(list, NULL, 0, &error_abort);
-- 
2.34.1


