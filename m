Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E5C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 20:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAb6J-0002Ir-EF; Fri, 24 May 2024 16:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb63-00025z-2V; Fri, 24 May 2024 16:01:05 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb5v-00051T-BG; Fri, 24 May 2024 16:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716580851; x=1748116851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TxxJnHMBaLnho+/05QzctY86Y8OJz5CyPdX6d6Cev54=;
 b=mpc7+m/xQcJ6WPiCT51isNdMEuCxTL4UxaC0YY3gkwZIx7dvZBul7Yy/
 mTgKbMliNpxJONpwDb3fTlgRAmldT4Mo2f/rghn5FS37TyGq87wKjBdOt
 kc1p9BwCPrWSBeR0BqremjPS+XLPBK3pYjYFeemX5ZeQj2gAfAHTUONxc
 AvdO5O7j5sBMgQQKhA3Qg/h1TdKIZIZELYofw4ZwR+Zutx9lSfjvRpOox
 BM1eSVP35KqBdq7szE5VT5zj1OIAzf/6GX2R9h1PuZidye/P/YWvrUJmn
 WXO1Nobucpd7w9oZmxtoydcKLrlrpWILUx508SrwZSxHtrsyLEMM7l6zC w==;
X-CSE-ConnectionGUID: fDUc9Ub2T8GW/KyPXa54dA==
X-CSE-MsgGUID: TUBMBPzISOm312cGEK8guQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="15918263"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="15918263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:46 -0700
X-CSE-ConnectionGUID: PG9RzVkzT4We7qa5u0gq5A==
X-CSE-MsgGUID: i5LmdFabSFm3uuxpa4R3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="39108906"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:46 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org,
 Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 1/3] vl: Allow multiple -overcommit commands
Date: Fri, 24 May 2024 13:00:15 -0700
Message-Id: <20240524200017.150339-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524200017.150339-1-zide.chen@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
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
---

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


