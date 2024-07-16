Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEADC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkj4-0008F9-5N; Tue, 16 Jul 2024 12:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkj1-00085W-Nq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:08:23 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkiy-0002DB-VY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721146101; x=1752682101;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jdrHZl+5t0J7nAGpopmSrmO15ARJrcpwdsnX0JbfuZk=;
 b=NXVfaSgEOGb90LeZzd+R8HHeE7kxMd+F8njiHPaxFoS0RJ+2a39xLx5o
 /hpROPQh6Hhz9tKl/H0ViO2mshCrMT8C0agAc8sgTmukrPKtgfW2NaoB8
 kw2JsW2uEQkxflcxoEL8YXetzO+s7jfSj6TxetwOlegZc8Kpfa1TM1FY2
 ZuBEmPm2mCbL14iZPSFh4tJ0FFJj1t5ibH5Bv9afZOR/bnRzBROKm8F6I
 +DmzdBQxykhgzS/G8/x3jS4wuZto/rFUgZt10J3d9G/ijMUZBAS1AV+Pr
 g0dri5S2skh+0Rhh/SUYitVfxfEDHIVBE9rOldJEET3c9pGO9CnRo7itc g==;
X-CSE-ConnectionGUID: 2g0zSBhBRwmQ0FnPcYl3+g==
X-CSE-MsgGUID: MGMbemqSRBO6lrAmYxdmnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29189655"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="29189655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 09:08:18 -0700
X-CSE-ConnectionGUID: HdqbjBEXSXe+ou+TnHJ5sA==
X-CSE-MsgGUID: 4vSt+rPbQUyuDQ3bxBY4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50007312"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 16 Jul 2024 09:08:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v2] qga/commands-posix: Make ga_wait_child() return boolean
Date: Wed, 17 Jul 2024 00:23:51 +0800
Message-Id: <20240716162351.270095-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

Make ga_wait_child() return boolean and check the returned boolean
in ga_run_command() instead of dereferencing @errp.

Cc: Michael Roth <michael.roth@amd.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v2:
 * Added Phil's r/b.
 * Used Phil's polished words.
---
 qga/commands-posix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7f05996495a2..64bb0be94479 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -59,7 +59,7 @@
 #endif
 #endif
 
-static void ga_wait_child(pid_t pid, int *status, Error **errp)
+static bool ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
 
@@ -70,10 +70,11 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
     if (rpid == -1) {
         error_setg_errno(errp, errno, "failed to wait for child (pid: %d)",
                          pid);
-        return;
+        return false;
     }
 
     g_assert(rpid == pid);
+    return true;
 }
 
 static ssize_t ga_pipe_read_str(int fd[2], char **str)
@@ -178,8 +179,7 @@ static int ga_run_command(const char *argv[], const char *in_str,
         goto out;
     }
 
-    ga_wait_child(pid, &status, errp);
-    if (*errp) {
+    if (!ga_wait_child(pid, &status, errp)) {
         goto out;
     }
 
-- 
2.34.1


