Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B76C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHds-0000P8-9N; Mon, 03 Jun 2024 20:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdp-0000Ng-Ao; Mon, 03 Jun 2024 20:03:05 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdm-0000MV-Ar; Mon, 03 Jun 2024 20:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717459383; x=1748995383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f1jzBUhjmtxORL0/5csTC9hvCz2+IuauIfMm+uVCwmQ=;
 b=VBXkCWXA+Sp2GnHYFv9llRUoeeCUnmx/jW6O7v04Cmx9azAnygTfDKx3
 Iog48GNfQvt5cgnhf97+z90611XBS1sRuYUHm6KGD/eG+CN8tEqGMj/AN
 48XPmECXU354llYPgZ9L13NDNDeCYlGdJAaZJtDU0AhvxaFxye7PHx3yU
 rSMSMw2+VSJbmcQjs94m+ozmAHedcd3HO9NhoNtsgNU7cSvwhFerzrpET
 JESw5XoZl9SesHOrA+Y3OMjejkrk14ASf9C5yr4Wbh7NbmFEuHvl95ty7
 y8dnvIlGBpc7/xSHws0mdyjLrx6Yz/p1/v34TBSFAsTCOm9E9dI3/KgjB A==;
X-CSE-ConnectionGUID: WRrNDh04TU6ONB9stY8Xog==
X-CSE-MsgGUID: OqtLMxmZRPyhXVSi/XNRPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13924788"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="13924788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:03:00 -0700
X-CSE-ConnectionGUID: vSXFwT4rSsq8SaV6IYdZsQ==
X-CSE-MsgGUID: C93EsmjETrGdZ39X0xdrdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="74529678"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:03:00 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org, seanjc@google.com,
 zhao1.liu@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 1/2] vl: Allow multiple -overcommit commands
Date: Mon,  3 Jun 2024 17:02:21 -0700
Message-Id: <20240604000222.75065-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604000222.75065-1-zide.chen@intel.com>
References: <20240604000222.75065-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zide.chen@intel.com;
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

Both cpu-pm and mem-lock are related to system resource overcommit, but
they are separate from each other, in terms of how they are realized,
and of course, they are applied to different system resources.

It's tempting to use separate command lines to specify their behavior.
e.g., in the following example, the cpu-pm command is quietly
overwritten, and it's not easy to notice it without careful inspection.

  --overcommit mem-lock=on
  --overcommit cpu-pm=on

Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

V3: added Reviewed-by

v2:
Thanks to Thomas' suggestion, changed to this better approach, which
is more generic and can handle situations like: "enabled the option in
the config file, and now you'd like to disable it on the command line
again".

 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index a3eede5fa5b8..dfa6cdd9283b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3545,8 +3545,8 @@ void qemu_init(int argc, char **argv)
                 if (!opts) {
                     exit(1);
                 }
-                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", false);
-                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
+                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
+                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
                 break;
             case QEMU_OPTION_compat:
                 {
-- 
2.34.1


