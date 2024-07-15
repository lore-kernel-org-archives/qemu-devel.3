Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D177C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIFt-0002k1-NE; Mon, 15 Jul 2024 05:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFs-0002gu-Qd
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIFr-0005Pt-7I
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721036663; x=1752572663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aEt9NUuwJ/0VTGg32MzuEEaTFlLR/CAGW8RGmGngYGA=;
 b=EtJ/OEmF2q23sjkLtqqJTMnYmyNTIJ1XmLhiVDIiikHb6xoP83R8pWIf
 e+wJryULyM6cGwJ6vJzzuHws2pmIOy/Fz0kSFLf1eZmXlkEbu87XDJl/g
 lmH7WR6NJdquLC7Fp0E/RAA2ByEXO/aoF9dDMlpYelM13l/TTqD2EZl2W
 5pty9IgMNds67SYbYWlm99xcj0leWGT8evlBOXgzLctzQfk0+NUfeRSnZ
 6qYowKNLKd4BRG9ep8NNBk/v5Jl5MV/N8pJrmSVAOIe/4F3fLYNZcSe8j
 9HUIjzJplmTmJoWwgTjAmBwcByhg+i8yjfkydw+VfIJkCqr1T40vdZKqB g==;
X-CSE-ConnectionGUID: b+6awR79Qran8JJyicb3nA==
X-CSE-MsgGUID: PbTrWlJRSGqJt0KB+JaUBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35837080"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="35837080"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 02:44:22 -0700
X-CSE-ConnectionGUID: G+lYKG51TdeS73unNOr37Q==
X-CSE-MsgGUID: PDmVSPx4STywGl14/CU/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="53854615"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2024 02:44:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] qga/commands-posix: Make ga_wait_child() return boolean
Date: Mon, 15 Jul 2024 17:59:39 +0800
Message-Id: <20240715095939.72492-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715095939.72492-1-zhao1.liu@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

As the comment in qapi/error, dereferencing @errp requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
* - It must not be dereferenced, because it may be null.
...
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.
*
* Using it when it's not needed is safe, but please avoid cluttering
* the source with useless code.

Though currently ga_run_command() only gets &local_err instead of NULL
@errp, it's still better to follow the requirement to add the
ERRP_GUARD().

But as error.h suggested, the best practice for callee is to return
something to indicate success / failure.

So make ga_wait_child() return boolean and check the returned boolean in
ga_run_command() instead of dereferencing @errp, which eliminates the
need of ERRP_GUARD().

Cc: Michael Roth <michael.roth@amd.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
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


