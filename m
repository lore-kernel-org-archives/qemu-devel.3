Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9714E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyY-0000FD-CV; Mon, 09 Feb 2026 21:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyF-0007cf-1U
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:24 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdyC-0004Bd-5C
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692360; x=1802228360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZOWK3iyK/6cs1o3p+O8+EgG5X+lzDVxBDR9rbRf94k=;
 b=GP+qhLOmlDcYBG3vtog1FcBvKqZ+byx9azxG0waUaoEmczi2l4QYLGvF
 EkxWxOZE41LqgJm6s9FEdxAA1PIP6kLXz6NeEXZd3cam4aARjhaHhToqi
 k7hGo0afpEAybvdNQSLEHoNYKu6oFybVfKJ9Rlq5Pw9erpwKCxfVUTycu
 7ShT+iNa9MraMNPE4+c5LCeWxMl+hQyEGb1gCmyYZGmG/3J/yjNK3V/16
 ZI4mgmOVmvpKF6WesuAyNCFHAAevtGP2sjqpEUErrg1lXKq/dTvlL0PdD
 bbdQBhjTV7pR/OiXjrKcXpWlhLfwYb/IipGU+/QZslddghqesYGcFfvlY A==;
X-CSE-ConnectionGUID: vKawBHpLTnyPWCuBI3mtXg==
X-CSE-MsgGUID: 1cUIJ90OTMe6d5B80tC6cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659940"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659940"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:15 -0800
X-CSE-ConnectionGUID: 1/i1p0QARLuY05jaVlS/BQ==
X-CSE-MsgGUID: r7CzNyLVRo2uuCCNN7ET7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800677"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:59:11 -0800
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
Subject: [PATCH v2 13/21] system/vl: mark property set in
 object_parse_property_opt() as USER_SET
Date: Tue, 10 Feb 2026 11:23:40 +0800
Message-Id: <20260210032348.987549-14-zhao1.liu@intel.com>
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

At present, object_parse_property_opt() is only used for -accel, which
handles user configurations from CLI.

So, mark the property as USER_SET in object_property_parse().

Also, add a comment to the function to clarify this specific usage
context, and it can serve as a reminder to future callers that
utilizing this function implies the property setting originates from
the external user.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/vl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 6d8167a50006..ef1d4e5d96af 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1700,6 +1700,10 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
     return machine_class;
 }
 
+/*
+ * object_parse_property_opt() is only used for -accel, so mark the
+ * property as USER_SET in object_property_parse().
+ */
 static int object_parse_property_opt(Object *obj,
                                      const char *name, const char *value,
                                      const char *skip, Error **errp)
@@ -1708,7 +1712,7 @@ static int object_parse_property_opt(Object *obj,
         return 0;
     }
 
-    if (!object_property_parse(obj, name, value, false, errp)) {
+    if (!object_property_parse(obj, name, value, true, errp)) {
         return -1;
     }
 
-- 
2.34.1


