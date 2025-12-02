Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67303D11713
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTR4-0001CN-06; Tue, 02 Dec 2025 11:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQq-00010Y-KI
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:53 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQm-0002BI-48
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693648; x=1796229648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0KCmiyIpAB52wYzC4kWIy02+TdGBgkInAHjQESaNq0s=;
 b=Q/870l/lWrQlfqXq9OCepRCh/XwIO2W0cislkOwtUhuC9vtnyzA/xV62
 s5Br4Ll6eEkCoknIFpkIXNejZyH+1xo8jz86EHrbv5Pg8N04Sit66P7jN
 IDXs3sEwpRk5nFvqLZlkSrSFmNzjaG/tDVKIqQlLAY+SJV2BnHGmvI75f
 wr/ymRvQkdX6BSZHzheGw0iDDRY6MH8Zxns5HxLr+Xnihxrx3PWymUOV4
 TtbkkJn84Qz3djqQNjyyjUNOCsiHexlcLdL80OJAbHxCHjGm8mvHvgM1K
 G+EjcJBM/U/1OLcuCNJ3mdIduP9aNISmLOAKrlctmrNrtqcUGAJiR3SUH A==;
X-CSE-ConnectionGUID: EU8spNoAT8+2rCJLlCcBsA==
X-CSE-MsgGUID: go45Yqy8SNSSKmze/UpxpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555347"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555347"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:47 -0800
X-CSE-ConnectionGUID: 6Zgi4yFGTZm3WZ1TGP1L8g==
X-CSE-MsgGUID: j+3EFEyhTOSNAtDmMUVZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751314"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 06/10] qom/qom-hmp-cmd: Check property deprecation flag for
 "qom-set" command
Date: Wed,  3 Dec 2025 01:04:58 +0800
Message-Id: <20251202170502.3228625-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"qom-set" can be used to set object property by external users, so it's
necessary to enable deprecation check for this case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qom/qom-hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index a00a564b1e22..1bfef0837e30 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -58,7 +58,7 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
             error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         } else {
-            object_property_parse(obj, property, value, &err);
+            object_property_parse_with_check(obj, property, value, &err);
         }
     } else {
         QObject *obj = qobject_from_json(value, &err);
-- 
2.34.1


