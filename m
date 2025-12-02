Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FB9D11712
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTR8-0001E4-5M; Tue, 02 Dec 2025 11:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQl-000103-7c
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:47 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQj-0002BI-NL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693645; x=1796229645;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EJDsM/gh9OJ5qk69Sy+KHH99/lnhQAd7uQZJey2ngdU=;
 b=Gf9DmGOY7SnBOqB1tSNMinwneEJewcQBmN2+AqbOSnEbhI8SpdlD+Tpn
 yBfrZer7zH4mrHmpF/mYlHqgy8YfXS5/RFKss9f4Fs458mNnDyICDLLKu
 tsDfQsIXFu1u0NC+QKJVWHlgZ6JoAI11vC9zcSc4+cPYZADbZuzasODfP
 ZuSUn9wefYLkMYbeqvx4uIcl6QjkL10QhXAOaIuBjL2PJqLaY9npMx5E/
 NA3iqYUocbPkYfpECggxSwUPHloTXjlZ5RqyyOzl44eZTMXhRUvXRWIER
 OKP++LuzVl8OG21BnCiY4KGrLd3Fj+tjeOiEGF5uA9ycFX4YgcGlqHWTp w==;
X-CSE-ConnectionGUID: KvWxagzHSw+G4osywzIMJw==
X-CSE-MsgGUID: acwgExhXScacYVneFgjvyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555338"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555338"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:43 -0800
X-CSE-ConnectionGUID: +pE6H92VRJO5eRRxMlTI4A==
X-CSE-MsgGUID: bgciHmu9QDCeH985Upn5Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751287"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:41 -0800
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
Subject: [RFC 05/10] system/vl: Check property deprecation flag for
 properities of accelerator
Date: Wed,  3 Dec 2025 01:04:57 +0800
Message-Id: <20251202170502.3228625-6-zhao1.liu@intel.com>
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

Now, object_parse_property_opt() is only used for -accel, which would
also have the need to deprecate properties.

So, use object_property_parse_with_check() for -accel.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 5091fe52d925..e1bcd4d713d7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1709,7 +1709,7 @@ static int object_parse_property_opt(Object *obj,
         return 0;
     }
 
-    if (!object_property_parse(obj, name, value, errp)) {
+    if (!object_property_parse_with_check(obj, name, value, errp)) {
         return -1;
     }
 
-- 
2.34.1


