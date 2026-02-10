Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D904E94625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyf-0000qU-F1; Mon, 09 Feb 2026 21:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyX-00009z-HJ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:41 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyV-0004En-Tu
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692379; x=1802228379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gbu5Q9ZD3mjjaunJEzsqqpo2xtfMXEg1RIkHam+uUew=;
 b=i8mapXvkmtQCxes2mGytcxTN0rTWPfh7yzymf69VomHGJ6Hun6YvQEX9
 mcTakQEIrOKoY8J64ot6S2QCPzuuthnNc8SHJZQ+nrrUNLh7dCd5hUMqU
 HKoXZ4F9LGZsZcBl6RZjz0RIFW6qLbV6XMZgDqN2kTezLT4u7D/m1+RCF
 uLaLfS8gmlScbrLYJ2XvVgOKEbecjVViAH8rlmp+bBAw7YICwAapD3JcN
 bZEsQqvhTQEiq0PD2FdBId95IpNks1xFtZQuOx7myrtlTzt3TYOyQ7ghy
 qv+GTMpy7vpyhP68iW7rjJANzLqYu/zTM0D1gjDO7ofuOi33n2o+Wy507 A==;
X-CSE-ConnectionGUID: YKnK+DlcSDij65MT1DYbDg==
X-CSE-MsgGUID: 7dKDmAxqTXWb+DhJlXHRHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659991"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659991"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:39 -0800
X-CSE-ConnectionGUID: E4aMS0lPRXqF3lI4A2EYlA==
X-CSE-MsgGUID: kzxe8lcBTXOkgnyCNxwFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800756"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:34 -0800
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
Subject: [PATCH v2 18/21] target/i386: mark x-consistent-cache property as
 internal-only
Date: Tue, 10 Feb 2026 11:23:45 +0800
Message-Id: <20260210032348.987549-19-zhao1.liu@intel.com>
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

x-consistent-cache property is a compatibility option that defaults to
"true". For old machines, it is set to "false" to maintain the (legacy)
inconsistent cache model for Intel CPUs.

In fact, such wrong and inconsistent cache model should be treated as
buggy "hardware", so that there is no valid use case for users to
manually disable this property.

Therefore, mark it as internal-only via OBJ_PROP_FLAG_INTERNAL flag,
and prohibit all external settings.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3766d453157b..c2f99b98014a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10541,7 +10541,8 @@ static const Property x86_cpu_properties[] = {
      * own cache information (see x86_cpu_load_def()).
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
-    DEFINE_PROP_BOOL("x-consistent-cache", X86CPU, consistent_cache, true),
+    DEFINE_PROP_BOOL("x-consistent-cache", X86CPU, consistent_cache, true,
+                     .flags = OBJ_PROP_FLAG_INTERNAL),
     DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
 
-- 
2.34.1


