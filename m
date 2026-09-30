Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E92CA5FAB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmJU-0006wD-Cm; Wed, 30 Sep 2026 00:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJS-0006vC-PO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:02 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBmJR-0001ML-2V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 00:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790743981; x=1822279981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ewXxkbe0Gsbub9PB8yI3rmmjueCd7jQf2fr6xKadh2U=;
 b=V/B8rEdqjuBnibrCx+Py02KCipR86pFPfeXQfeAaZtIC91W8nY9gaCLR
 v/jTJqhhk6RVZcOVuCK1rWfgH9ME50X22AlNmUPof55UY2EGGZrmXSDHP
 aR+Ic0tHUwGP/rBXtfRfQ4Ov/y6HV0Y2wHB7JWRuTAtrcE/faIT+28r0A
 j0k7GciX9hcgIpNO8ysIBQJ5omrIGuKYV+hN6qwqy/TZ6UnGQnIacfvX2
 8GnRLAc0jv1qg9Se+5dG3pOVcTZwT1QWxhJReDU+ITboWPPc8J6cynaAG
 dnB8cFeZ6Hq43aS0Zvz7w34K6wERsNuQ3BegRWC6e/x6HsjYe+o8Vr36M w==;
X-CSE-ConnectionGUID: ufPgVXERRneVym1BL1LUKQ==
X-CSE-MsgGUID: BnWbDawYR+KRYGO1Sphg4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93959635"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="93959635"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 21:52:58 -0700
X-CSE-ConnectionGUID: JKH1YjivTuS4qr5tRshOqA==
X-CSE-MsgGUID: RWDytyoUQp+A9PoHcPj9sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="275721211"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2026 21:52:56 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Badari Pulavarty <badari.pulavarty@intel.com>
Subject: [PATCH 3/3] hw/core/machine-smp: allow thread level cache
Date: Wed, 30 Sep 2026 12:52:37 +0800
Message-Id: <20260930045237.784060-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930045237.784060-1-zhao1.liu@intel.com>
References: <20260930045237.784060-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Commit 87ae7ab84fff allowed i386 CPU to configure thread level cache,
However, without support for the cache model, users still need to
configure it through -machine smp-cache.

Remove the thread-level restriction in the smp-cache option.

Reported-by: Badari Pulavarty <badari.pulavarty@intel.com>
Fixes: commit 87ae7ab84fff ("i386/cpu: Allow cache to be shared at thread level")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-smp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index bef04aa2d713..baf06bca2aeb 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -321,13 +321,6 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
 
-        if (props->topology == CPU_TOPOLOGY_LEVEL_THREAD) {
-            error_setg(errp,
-                       "%s level cache not supported by this machine",
-                       CpuTopologyLevel_str(props->topology));
-            return false;
-        }
-
         if (!machine_check_topo_support(ms, props->topology, errp)) {
             return false;
         }
-- 
2.34.1


