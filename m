Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81834E9462C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdy3-0007J6-3P; Mon, 09 Feb 2026 21:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxy-0007Dq-LO
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:07 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vpdxv-00049n-Oo
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692343; x=1802228343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kTZTKkz5OV0MVWMUfNYdoNWRrLoBYW4IVLk26W7htvw=;
 b=NXPiR431Pr+SIUjp0kfps7kTEkYy+MyGDkqzwUFp5GXRv3Sj7YlkXITf
 3kfhh+UbaFw4nwEZ21P+d5ZYX7pRoveEy386w8Od2Rba2qgF8PMrx0kBr
 7quoiWWStx8zTAB6w4peckVygzG+iRpeEGEHJjbPJUI9VUrDH74/qP6dV
 QIski4+EHS2p0zVNGrvkpNpStZRrSYcqP8gTAnYJoaKT7Rr6DTsHWhnZF
 mcmHuR3snW5svLLrLZG7w/J2W4FHYb+rVQYqIYBI+6r/YLRXatxyO2pUf
 mAX51O+DIXGo6fV41etDWsjm0994ChBZ5vyTHfDV11yFbhOuIrQGfGJCY g==;
X-CSE-ConnectionGUID: BWxJcyxTQ2ybCo40TOWe0A==
X-CSE-MsgGUID: TMQwLH5RT1Ohwev64DAlnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75659906"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75659906"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:02 -0800
X-CSE-ConnectionGUID: R/ui5AxRQu2dwqso2S/esA==
X-CSE-MsgGUID: /pZSTZ93T52r1bwGh6F/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211800600"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 18:58:58 -0800
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
Subject: [PATCH v2 10/21] qom/qom-hmp-cmd: mark properties set from HMP
 (non-JSON) "qom-set" as USER_SET
Date: Tue, 10 Feb 2026 11:23:37 +0800
Message-Id: <20260210032348.987549-11-zhao1.liu@intel.com>
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

The HMP command - "qom-set" is be used to set object property by
external users, and object_property_parse() is used to parse and handle
property setting for non-JSON case.

Since the property setting is from user, pass "from_user=true" to
object_property_parse() and mark properties set in this case as
USER_SET.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qom/qom-hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 6bdb241e54bd..175091694f5f 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -58,7 +58,7 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
             error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         } else {
-            object_property_parse(obj, property, value, false, &err);
+            object_property_parse(obj, property, value, true, &err);
         }
     } else {
         QObject *obj = qobject_from_json(value, &err);
-- 
2.34.1


