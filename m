Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385D8C25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s977T-0002C2-VM; Mon, 20 May 2024 13:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977Q-0002B7-3M
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:16 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977O-0003ku-6V
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716227294; x=1747763294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QJXh6BRmMMdAUv/q0OwnCX9WbdXcP+WLjiUsGv13T9M=;
 b=Rm2DwSQPr7S/e1eMobie6tlWkzrZoNUzyz6tUZLr3GZPUvnXEsy9BpzS
 Ip62adHACABEoh+EBG/lgRU5fSAIpn17Sbsb7duc6tpZQI2FJvrfIPu6g
 qKon6SZsgIPUbE49BYRCjEbWbv43xs+euePiFkMOMjhbLo+lBhCwXGHcy
 swa1nVUCT638ih+lSL4qFZEOrTcFN1veIGSiorLy9rQQlAFlGTwH4owdg
 wOsz3hNxjIG6L6TCi50LE5rA4qtwq6iDbslFtSJR6u+S2QkCbHpYabBG8
 as/PFdY4bTdpo3aMBFp1/dhYMzdFVSdicfSdt68HX4VM0QYTbvGX7uPFR w==;
X-CSE-ConnectionGUID: 27An84ljQzu00u84Mp9Kyg==
X-CSE-MsgGUID: y4q0A2C1RxWbb3bnJu4ulw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12222090"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="12222090"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:56 -0700
X-CSE-ConnectionGUID: YZBN68fwTaS/of2KMwaXNg==
X-CSE-MsgGUID: MZhaeiBNQBK9Mxzdz5VxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="32746629"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:56 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 1/3] vl: Allow multiple -overcommit commands
Date: Mon, 20 May 2024 10:47:31 -0700
Message-Id: <20240520174733.32979-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520174733.32979-1-zide.chen@intel.com>
References: <20240520174733.32979-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Both cpu-pm and mem-lock are related to system resource overcommit, but
they are separate from each other, in terms of how they are realized,
and of course, they are applied to different system resources.

It's tempting to use separate command lines to specify their behavior.
e.g., in the following example, the cpu-pm command is quietly
overwritten, and it's not easy to notice it without careful inspection.

  --overcommit mem-lock=on
  --overcommit cpu-pm=on

Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 system/vl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index a3eede5fa5b8..ed682643805b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3545,8 +3545,12 @@ void qemu_init(int argc, char **argv)
                 if (!opts) {
                     exit(1);
                 }
-                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", false);
-                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
+
+                /* Don't override the -overcommit option if set */
+                enable_mlock = enable_mlock ||
+                    qemu_opt_get_bool(opts, "mem-lock", false);
+                enable_cpu_pm = enable_cpu_pm ||
+                    qemu_opt_get_bool(opts, "cpu-pm", false);
                 break;
             case QEMU_OPTION_compat:
                 {
-- 
2.34.1


