Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF98EE9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdxI-00061I-LP; Mon, 09 Feb 2026 21:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxG-00060p-Ne
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:22 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxF-000463-5c
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692301; x=1802228301;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CWUHty8oWVEh0GsmmVaaCPC+SG+FQrP8WKByiVj3sqs=;
 b=NkKOd1hZqxEZO2d0VPi7bLdvM3AG9pCxEj/LkxBjXkIJtJM2L4koy3p7
 uah3yT+2cLJOldd4lHMDTb6Wl88AGJAg8TnOGTzoA45loPUj2bfjha5t5
 9f5RSKRqJb/K8U93ftz51cNTnluNlHAORDAEV/+pKICkYkiA35ik0aicT
 6Mk11WbkYE88yiHhqbuQSozdCyzruAfl2Z7tObW3Sc7bhHw0CJEISOvuM
 aYvL3zfV30lD3oyDyITSq3MSZXMRER2bYRMOxSu7TpNNipH50mt7tHmgT
 Oexcve2wUYfnO9NDHNypi3ay3KkjYFyNwS0PX2DKY0cJhszkajZdWNr47 w==;
X-CSE-ConnectionGUID: 7bIDi00/QAiQJ7NyvtbLSA==
X-CSE-MsgGUID: Dvh454NER0Cnu3cmPtsRGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71854221"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71854221"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:20 -0800
X-CSE-ConnectionGUID: ormuF/qsTyyK52BYmVAydA==
X-CSE-MsgGUID: QoEjIvx8S4KQ4LtJq64cbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800416"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:14 -0800
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
Subject: [PATCH v2 01/21] qom/object: use BIT macro for ObjectPropertyFlags
Date: Tue, 10 Feb 2026 11:23:28 +0800
Message-Id: <20260210032348.987549-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Standardize the definition of ObjectPropertyFlags by using the BIT()
macro instead of manual bit shifts to improve readability.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b911..6226b88c1eda 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 
 struct TypeImpl;
 typedef struct TypeImpl *Type;
@@ -1841,9 +1842,9 @@ ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
 
 typedef enum {
     /* Automatically add a getter to the property */
-    OBJ_PROP_FLAG_READ = 1 << 0,
+    OBJ_PROP_FLAG_READ = BIT(0),
     /* Automatically add a setter to the property */
-    OBJ_PROP_FLAG_WRITE = 1 << 1,
+    OBJ_PROP_FLAG_WRITE = BIT(1),
     /* Automatically add a getter and a setter to the property */
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
-- 
2.34.1


