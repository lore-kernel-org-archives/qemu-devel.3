Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA0D11713
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTQx-00013e-Qq; Tue, 02 Dec 2025 11:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQh-0000yg-NJ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:45 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQg-0002BI-4k
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693642; x=1796229642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eK18Rb0gdGJlNH012rca504qCms7GSkuLIsrlDHKrYU=;
 b=RGV/3sqqS6TZqcUnUF0G8lahcXqYma/xhejRBOGqy1bkIpcrOnMzxs8r
 ZetQsQ0ck6b0p3POgRIECUTFdTgeyeCtCBPjlJP+yGChfl9BZdr7bvDzV
 ZhHOw8yxeCcmHxWe6XL+pH+RAhdDmurDRnsUh7KTsabk6yzSTkFfc5ypk
 EkF1xb67aWwIwClnw0DugQZ8ZIwKaf1lKWLozIyMT26VAC/AOWbh/mBUY
 u/6nUqQ0mf+hQeTl8DdjMikvT5TPzeJ4UloD1bfy08I3XV4hFubWiXBie
 vV+Rsgd/nj5oc5Zj3529QcMJePQZJBOFWPOP5vTyere/lehLDBYi0vaga Q==;
X-CSE-ConnectionGUID: 8IB44/R0Sp6ug5WIP932ag==
X-CSE-MsgGUID: hug7CH7kRee8UAizlkfaKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555328"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555328"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:40 -0800
X-CSE-ConnectionGUID: mousTyneT6+4xI9PexJ6dQ==
X-CSE-MsgGUID: eGnzuLPkRoGYYl3RJSgdVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751270"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:37 -0800
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
Subject: [RFC 04/10] qom: Check property deprecation flag for properities from
 qdict
Date: Wed,  3 Dec 2025 01:04:56 +0800
Message-Id: <20251202170502.3228625-5-zhao1.liu@intel.com>
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

The sources of properities parsed into qdict include:

 1) External ("TYPE_USER_CREATABLE") object:
    * -object command line used for external ("TYPE_USER_CREATABLE")
      object.

 2) External device:
    * -device command line - parsed based on keyval or json.

 3) External machine options:
    * -machine command line - parsed based on keyval.

 4) Internal machine options:
    * Builtin default machine options string:
      MachineClass::default_machine_opts - parsed based on keyval, too.

All of these cases are using object_set_properties_from_qdict() to set
properties. It's necessary to detect and report deprecated properities
for these cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 qom/object_interfaces.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 415cbee8c5cf..b58a24c27ce7 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -53,7 +53,7 @@ static void object_set_properties_from_qdict(Object *obj, const QDict *qdict,
         return;
     }
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-        if (!object_property_set(obj, e->key, v, errp)) {
+        if (!object_property_set_full(obj, e->key, v, true, errp)) {
             goto out;
         }
     }
-- 
2.34.1


