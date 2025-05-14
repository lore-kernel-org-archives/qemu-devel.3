Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A66EC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UG-0006z0-T1; Wed, 14 May 2025 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UE-0006q3-MN; Wed, 14 May 2025 04:29:10 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UC-0006Fs-P8; Wed, 14 May 2025 04:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211349; x=1778747349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c1yBPRLNETWRITPW9Cfd7x9/x8g1mHxqhLIAeGQqCAI=;
 b=KUDhpDyY8/bhVHJY0IFk/t7FPBf5afCa18wXvrnrMjfA21RwR8u5zA+8
 xpaP/hIrezG4CEa7D2Fr5ghb5SQdziTxY6yK4qPDndsuS+MQN3bmGAeEu
 4zNuFB5gppp/kh8dlE1OYT69zIDuCGfFBfJKby+ubggNerFoZBtSV0YPs
 pMt+VSaURQ3JMyfk0DBBucqknT8e7ikUdygwhV5n7rYFmS0ZwbLNfga0T
 jzdqG5kTlG1rg2HbgiV1p647cbgnieao/A3arw23xTuCXkHdE9to2Gk27
 QEKyFJZPJmE9VquSDDDPsKP5HHJ9y8x1B1Sp6eBd8HkdYYJKfRka3cuUc w==;
X-CSE-ConnectionGUID: /uQR861FSi2quwZt6cuU+g==
X-CSE-MsgGUID: FoVZ8tLUSGmax5CxGgiA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505596"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:07 -0700
X-CSE-ConnectionGUID: 5FVb5ywfRZ6jyhSgmOXB2A==
X-CSE-MsgGUID: B7UxM+2kSQmVHQsc/0jSBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065834"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:29:03 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 6/9] hw/ppc/pef: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Wed, 14 May 2025 16:49:54 +0800
Message-Id: <20250514084957.2221975-7-zhao1.liu@intel.com>
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

The QOM type of PefGuest is declared by OBJECT_DECLARE_SIMPLE_TYPE,
which means it doesn't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/ppc/pef.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 254f5707876f..1832791ee533 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -20,11 +20,6 @@
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
 
 typedef struct PefGuest PefGuest;
-typedef struct PefGuestClass PefGuestClass;
-
-struct PefGuestClass {
-    ConfidentialGuestSupportClass parent_class;
-};
 
 /**
  * PefGuest:
@@ -121,12 +116,12 @@ static int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
     return kvmppc_svm_off(errp);
 }
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
-                                   pef_guest,
-                                   PEF_GUEST,
-                                   CONFIDENTIAL_GUEST_SUPPORT,
-                                   { TYPE_USER_CREATABLE },
-                                   { NULL })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(PefGuest,
+                                          pef_guest,
+                                          PEF_GUEST,
+                                          CONFIDENTIAL_GUEST_SUPPORT,
+                                          { TYPE_USER_CREATABLE },
+                                          { NULL })
 
 static void pef_guest_class_init(ObjectClass *oc, const void *data)
 {
-- 
2.34.1


