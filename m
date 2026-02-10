Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8244E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdz9-0001vU-MB; Mon, 09 Feb 2026 22:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyl-00019D-GD
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:58 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyi-0004IS-Nh
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692392; x=1802228392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rHQyqSJDlnq8AfY8ZN5U8grBknt55dcxwohK9sGr+K8=;
 b=dJu5EPvych9Y+1rRq3F9zJrkSM50+M/moxNJT9qfh1Dras/gdRI88NfO
 +4A1QJAr6sderusAEDLU1vfWQq1kha0ay16vhaW8Awqf//+oV08K5DbCO
 Sr21HglSGqKkgH0t8QXG+BiMMk2kaoQ+NoqZ/7+ebyY0PSyo/O699JKTZ
 suiXm3LbEj6lUpNy5jZGa0yqJBnTTRJTLtkejZ6WP62iNgKN2ncKisJc0
 Wogq8y9OWXidROm1zDFYb3YqRRVoVMwpoLcDP0KBTWIP1Fe8UjvmfWOuE
 wlKYV04C6pA7riSRz/KxEhv/dE6G++QIws2VMe6PuC8ZSNXb00pdtLcD8 A==;
X-CSE-ConnectionGUID: fEBrZWgiTYSeQjS3D4rH0w==
X-CSE-MsgGUID: 4AuLckFpSxatkAsXfCcGJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75660012"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75660012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:49 -0800
X-CSE-ConnectionGUID: Rj1KXFK3SZip+20rWdxCqQ==
X-CSE-MsgGUID: qeKQ7GTIQkiQ7733GXv+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800809"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:43 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: [PATCH v2 20/21] target/i386: detect user provided lbr-fmt via
 property flag
Date: Tue, 10 Feb 2026 11:23:47 +0800
Message-Id: <20260210032348.987549-21-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At present, QEMU determines if the user has set the "lbr-fmt" property
by checking if its value differs from a special value,
`~PERF_CAP_LBR_FMT` (`~0x3f`).

Relying on such a magic number to distinguish user input from the
default state is implicit and fragile. It also prevents the helper macro
`DEFINE_PROP_UINT64_CHECKMASK` from supporting a *valid* default value,
as initializing the property with a valid default would make it
impossible to distinguish from a user-provided value.

With the introduction of `OBJ_PROP_FLAG_USER_SET`, it's possible to
directly check this flag to determine whether the user has modified the
property, which can help get rid of invalid "sentinel" value.

Therefore, detect user-provided value by checking the USER_SET property
flag in x86_cpu_realizefn(). The invalid initialization value will be
dropped in subsequent work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a594747f0030..a6d943c53a3f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9779,6 +9779,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
     unsigned requested_lbr_fmt;
+    int lbr_fmt_set;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
@@ -9815,7 +9816,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
      * with user-provided setting.
      */
-    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
+    lbr_fmt_set = object_property_check_flags(OBJECT(dev), "lbr-fmt",
+                                              OBJ_PROP_FLAG_USER_SET, errp);
+    if (lbr_fmt_set < 0) {
+        return;
+    } else if (lbr_fmt_set > 0) {
         env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
         env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
     }
-- 
2.34.1


