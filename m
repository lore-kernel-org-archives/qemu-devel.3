Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F376C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsI9-0008Es-T5; Wed, 05 Jun 2024 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEsI7-0008EQ-Eg
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:11:07 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEsI4-00032z-MG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717600265; x=1749136265;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eK7PGkfED7xMeQLHQ3Q1K8XxqcOhykX85hK2F2vJEyE=;
 b=E6/TsWg6VATCWXaxC4ooW6YwEXuz2NbKcD4CMym0E7ilLT8aQ/a/avJ4
 NC+8UVRzIJrCSa1yI0CHqme0Ks4ZTxN30LngHgEl1lO9DQcc39gQlew9Q
 VmgD/7NUhDh0sOhUsm66ndOqDrjBmx01Y+MUqUkRQq6huFzlj/rMgBDwA
 o9PJNKT8DDszUQPoPBnmbEsDXp1zHNsvZdWN/k5PLh+YM1ZjvVmb81Hnw
 bzsPufWlZJOklA8N3MZtos7Kkqlb8A1qtqj11xIIbgnAJhHIbNA1whdIn
 dh0MA5Y8W2QeCM19igiaFLjYXW7jQyYF1Z6UWu7EX/NwaD3cbEQX1LG2V Q==;
X-CSE-ConnectionGUID: tKELU6cJSKWg5aY14iZiGA==
X-CSE-MsgGUID: 6vE4gjDeQZyU/4Y1/aWGTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31762459"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="31762459"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 08:11:01 -0700
X-CSE-ConnectionGUID: CincIMUtQTCeYHcH/aeIrw==
X-CSE-MsgGUID: ueQk3hm9TKuEyzAPoXJjqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="60822544"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 05 Jun 2024 08:11:00 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
Date: Wed,  5 Jun 2024 23:25:49 +0800
Message-Id: <20240605152549.1795762-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Compiling without system, user, tools or guest-agent fails with the
following error message:

./configure --disable-system --disable-user --disable-tools \
--disable-guest-agent

error message:

/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
/media/liuzhao/data/qemu-cook/build/../util/error-report.c:38: undefined reference to `error_vprintf'
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
/media/liuzhao/data/qemu-cook/build/../util/error-report.c:215: undefined reference to `error_vprintf'
collect2: error: ld returned 1 exit status

This is because tests/bench and tests/unit both need qemuutil, which
requires error_vprintf stub when system is disabled.

Add error_vprintf stub into stub_ss for all cases other than disabling
system.

Fixes: 3a15604900c4 ("stubs: include stubs only if needed")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 stubs/meson.build | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 3b9d42023cb2..a99522ab6bbf 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -45,17 +45,10 @@ if have_block or have_ga
   stub_ss.add(files('qmp-quit.c'))
 endif
 
-if have_ga
-  stub_ss.add(files('error-printf.c'))
-endif
-
 if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
   stub_ss.add(files('vmstate.c'))
-
-  # more symbols provided by the monitor
-  stub_ss.add(files('error-printf.c'))
 endif
 
 if have_user
@@ -76,6 +69,9 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+else
+  # more symbols provided by the monitor
+  stub_ss.add(files('error-printf.c'))
 endif
 
 if have_system or have_user
-- 
2.34.1


