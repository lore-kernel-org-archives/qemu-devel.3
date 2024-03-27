Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E60C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQUu-0007lk-SW; Wed, 27 Mar 2024 06:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQUF-0007OO-8v
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:27 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQUC-0007aA-SO
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711535185; x=1743071185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4uBrPQD7j2YTQaH7WlV2kQvQoG/tS0FkvYpS12K77DA=;
 b=UI/4Vz6sBm/rcuaEJKHM5ye+fRUuK3mpCChf6O9zC/O4Xoq+4xiVVeSg
 TeZmROjZz93OjdH/UVYL02PGbusPF/+drADtmpz4UcXM2D92+V9gLQ8aG
 8CLxS1xRx+HA1Ak5D8u5VzEaEYpoSEu/peicKMVhafUwpIYjCmtvaT1Gj
 7/dKDsKQ18ZRIqoevWvbHz7k9UV22jlGH8jw+y3q9S6XjzoYgLNA/8zQ7
 +pndGCY1ck/sMU25o/Qeo6JYQYHy4OrFEUTVhfsvp9qUALh7nOjL85Qya
 SJIf89Yt+eI+eh2sltn3nBje3nYM1GQigvSOySordVThmGTcYxvdn5D19 w==;
X-CSE-ConnectionGUID: xTTVWQA2QYy8YEFGgpb6Ag==
X-CSE-MsgGUID: VmNjVjLKSAC12qJLLP+Daw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6489761"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6489761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 03:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16354481"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 03:26:00 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] target/i386/cpu: Merge the warning and error messages for
 AMD HT check
Date: Wed, 27 Mar 2024 18:39:51 +0800
Message-Id: <20240327103951.3853425-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
References: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Currently, the difference between warn_report_once() and
error_report_once() is the former has the "warning:" prefix, while the
latter does not have a similar level prefix.

At the meantime, considering that there is no error handling logic here,
and the purpose of error_report_once() is only to prompt the user with
an abnormal message, there is no need to use an error-level message here,
and instead we can just use a warning.

Therefore, downgrade the message in error_report_once() to warning, and
merge it into the previous warn_report_once().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0487469d75f3..ec2787197d42 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7454,9 +7454,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
         cs->nr_threads > 1) {
             warn_report_once("This family of AMD CPU doesn't support "
-                             "hyperthreading(%d).", cs->nr_threads);
-            error_report_once("Please configure -smp options properly"
-                              " or try enabling topoext feature.");
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", cs->nr_threads);
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


