Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A52E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdz7-0001dG-Lj; Mon, 09 Feb 2026 22:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyi-00015v-NP
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:53 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyZ-0004En-Hs
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692383; x=1802228383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7fc/Brd+iTgkhX2nnl5fk6qLcnnHrIhJ0ubwi9AbENI=;
 b=YgXTpv66HHz2DxKa2TrhPxL0OuM4toljeGlStYu7Z+l7uDDEB9hblskq
 vdjPxEztjvSiBnIDXUWwAM5DJ6vsNQdoc9rvi0bKB+ccBBrCObRxdKXda
 9/KUu9BVIv7q+Yn8P17q7+jld1ivyAwVdL9xlyUw3G6K3E3l5fOZkLSwU
 TflDd2j2VsJgH+z4XZWm5I5LhnrwH6axrxhOWeYv6qpKrnWyvMsXSdI02
 kNp5vAhyRATRjOGog9uudUFbBnB3IavyqMYJzsW88cI/tftUM08BQqofP
 Cyyj2I72tAWH4KDBFG2DXFHVy49QIbBvBlFEPYBgO+12P/QKRqdV5pD1R A==;
X-CSE-ConnectionGUID: +HZYu48+R/uILuB7QXnoTQ==
X-CSE-MsgGUID: rXEqbhRfSj+21qIpIiPD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75660005"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75660005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:42 -0800
X-CSE-ConnectionGUID: cHUwYKuURsGKfCLLbCM3sQ==
X-CSE-MsgGUID: /8oG5xduQgmV1dG/be5kFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800786"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:39 -0800
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
Subject: [PATCH v2 19/21] target/i386: remove redundant validation for lbr-fmt
 property
Date: Tue, 10 Feb 2026 11:23:46 +0800
Message-Id: <20260210032348.987549-20-zhao1.liu@intel.com>
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

The 'lbr-fmt' property is defined via DEFINE_PROP_UINT64_CHECKMASK,
utilizing PERF_CAP_LBR_FMT as the validation mask. This mechanism
ensures that the property setter rejects any value attempting to set
bits outside this mask.

So cpu->lbr_fmt is guaranteed to be valid by the time
x86_cpu_realizefn() executes. The manual validation inside the realize
function is therefore redundant.

Remove the unnecessary check.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c2f99b98014a..a594747f0030 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9816,10 +9816,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * with user-provided setting.
      */
     if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
-        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
-            error_setg(errp, "invalid lbr-fmt");
-            return;
-        }
         env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
         env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
     }
-- 
2.34.1


