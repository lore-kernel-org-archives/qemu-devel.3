Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51341C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlQ-0007Py-On; Wed, 06 Mar 2024 04:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlP-0007Pi-Bu
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:39 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlN-00025v-ED
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718037; x=1741254037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Oqv2Y548yUJEQ3jZWHP1266B+OXZuHqGaMfM6j07uY=;
 b=LE6KjFnJvhCeLYt15oMiKTOmSFzo+duvXF+Y++HPKuNJuFT0BDd2oAnW
 xaDqjyNhGKPuikHFVh5u1b+7Z3fmNxXS0xOY/f118UkqJe6lF4FA1CJS2
 BzPRXbvaH6F43ipgZU4x5XHjdQlaUmkDnwPOTzHtZ6OVcCiJPo+2jC9XV
 qfRQflCeXJuuoM2kVFtLMo7XFKxoRmY1hxWrcReFqMvdy4j9v/4XVRvW9
 xtZx9Y4cIGfjH5QeFNoAJE5CBaTuZtzBi8m8c815ZTgfZQb2ARq3A4ZVX
 pTG0m2gmoS94DrMWgBXjrgeuR+BsB8aEwMDBYbG0urI3AJmcGK1JlYLpO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897833"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897833"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854134"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:33 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 03/14] hw/core/machine-smp: Simplify variables' initialization
 in machine_parse_smp_config()
Date: Wed,  6 Mar 2024 17:53:56 +0800
Message-Id: <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

SMPConfiguration initializes its int64_t members as 0 by default.

Therefore, in machine_parse_smp_config(), initialize local topology
variables with SMPConfiguration's members directly.

Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 50a5a40dbc3d..3d9799aef039 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -82,15 +82,15 @@ void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
-    unsigned cpus    = config->has_cpus ? config->cpus : 0;
-    unsigned drawers = config->has_drawers ? config->drawers : 0;
-    unsigned books   = config->has_books ? config->books : 0;
-    unsigned sockets = config->has_sockets ? config->sockets : 0;
-    unsigned dies    = config->has_dies ? config->dies : 0;
-    unsigned clusters = config->has_clusters ? config->clusters : 0;
-    unsigned cores   = config->has_cores ? config->cores : 0;
-    unsigned threads = config->has_threads ? config->threads : 0;
-    unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
+    unsigned cpus     = config->cpus;
+    unsigned drawers  = config->drawers;
+    unsigned books    = config->books;
+    unsigned sockets  = config->sockets;
+    unsigned dies     = config->dies;
+    unsigned clusters = config->clusters;
+    unsigned cores    = config->cores;
+    unsigned threads  = config->threads;
+    unsigned maxcpus  = config->maxcpus;
 
     /*
      * Specified CPU topology parameters must be greater than zero,
-- 
2.34.1


