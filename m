Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F94C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UK-0007EH-Fr; Wed, 14 May 2025 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UJ-0007D0-JD; Wed, 14 May 2025 04:29:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UH-0006H0-PY; Wed, 14 May 2025 04:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211354; x=1778747354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JbnLeHCbjmi5qiZFkBbMgrEGQSATmTL1jzjpabktqpE=;
 b=UgL9mIy1WM++4HQTvgRxa+02aWtbK+FLdFSTfbHs5gJ70eviLUrqThqB
 KCJhNhiIqRA9jV71apdDA43iTTgUwpk8AdgR95IKFQh6fuBtcky7ZoH5G
 A26zto9rW8V1ju71iZWtxBJPZAAm90ButKhyBJXk4rqFi7aWMeWJ0O4nE
 6pIdUWKqLKoZXbGpW6TJbj0hATQp3Q/SvQo7lXXPka/kGua92D5uX/XnP
 qHMKu49ZV3TnGHD25UEMv45O8CvMxOkAsmHG2SyS6q0Puu7ZuXqmtsi0J
 o9SyPkJD6iPCPC6X5E8+jJDviG27cb2LJ5eCJcVtjG06eI0M9EwGv+5jy A==;
X-CSE-ConnectionGUID: B24Rzc/2TXWnedeMwMVyjw==
X-CSE-MsgGUID: OjEEgq2/SQKBQi3bo7jzZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505614"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505614"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:12 -0700
X-CSE-ConnectionGUID: hypJoV7ZQemsAFomVxyWQQ==
X-CSE-MsgGUID: tByd5RQATIuDgh3pTO+SQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065850"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:29:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Wed, 14 May 2025 16:49:56 +0800
Message-Id: <20250514084957.2221975-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The QOM type of S390PVGuest is declared by OBJECT_DECLARE_SIMPLE_TYPE,
which means it doesn't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/s390x/kvm/pv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 2bc916a5455f..a4dbbcef7e08 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -313,12 +313,6 @@ struct S390PVGuest {
     ConfidentialGuestSupport parent_obj;
 };
 
-typedef struct S390PVGuestClass S390PVGuestClass;
-
-struct S390PVGuestClass {
-    ConfidentialGuestSupportClass parent_class;
-};
-
 /*
  * If protected virtualization is enabled, the amount of data that the
  * Read SCP Info Service Call can use is limited to one page. The
@@ -380,12 +374,12 @@ static int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
-                                   s390_pv_guest,
-                                   S390_PV_GUEST,
-                                   CONFIDENTIAL_GUEST_SUPPORT,
-                                   { TYPE_USER_CREATABLE },
-                                   { NULL })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
+                                          s390_pv_guest,
+                                          S390_PV_GUEST,
+                                          CONFIDENTIAL_GUEST_SUPPORT,
+                                          { TYPE_USER_CREATABLE },
+                                          { NULL })
 
 static void s390_pv_guest_class_init(ObjectClass *oc, const void *data)
 {
-- 
2.34.1


