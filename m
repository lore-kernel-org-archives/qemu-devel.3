Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695E7C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZTd-0000Tr-Ol; Thu, 29 Feb 2024 01:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfZTW-0000SK-2M; Thu, 29 Feb 2024 01:01:01 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfZTU-0001Lg-1Q; Thu, 29 Feb 2024 01:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709186456; x=1740722456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A9e+ujl7YTIuPGXbZJj3fMaZkvIQhsHO8qbu//JANj4=;
 b=a+Dw8k7fd40djz5PFqpTdKMQvHUJ1FA25dicFFhFpXW1GTlL0lljrFlI
 L1ydU/KIkbtfH3CzrpICr8xyCD6/Gaa4Rqd9scmt8jL3ZeMw01dbFPBc3
 tRYXhPBIKv3QqD66weJPyzARGxwwi76ZaF4OsSDX67ReAfjUr/Sv1w1bO
 vH+36OUqL4Y+4VDlocZTEOVI36RKUr+awTp+IEWvSyADWgCGMmbTyL2c0
 kGa9PGP4NwygOEVLPj3cafHbTJWIcqhhRH5P1KqzKynjPqJPRs1EMdV82
 q0jhMZcLTQ3FuPD2caJLnXXI/elZzP9suPO6vcNGvabB0jFzySWlGjYAj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14274153"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="14274153"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8266084"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 28 Feb 2024 22:00:47 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: xiaoyao.li@intel.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 1/4] confidential guest support: Add kvm_init() and
 kvm_reset() in class
Date: Thu, 29 Feb 2024 01:00:35 -0500
Message-Id: <20240229060038.606591-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229060038.606591-1-xiaoyao.li@intel.com>
References: <20240229060038.606591-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Different confidential VMs in different architectures all have the same
needs to do their specific initialization (and maybe resetting) stuffs
with KVM. Currently each of them exposes individual *_kvm_init()
functions and let machine code or kvm code to call it.

To make it more object oriented, add two virtual functions, kvm_init()
and kvm_reset() in ConfidentialGuestSupportClass, and expose two helpers
functions for invodking them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes since rfc v1:
- Drop the NULL check and rely the check from the caller;
---
 include/exec/confidential-guest-support.h | 34 ++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index ba2dd4b5dfc4..e5b188cffbfd 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -23,7 +23,10 @@
 #include "qom/object.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
-OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
+OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
+                    ConfidentialGuestSupportClass,
+                    CONFIDENTIAL_GUEST_SUPPORT)
+
 
 struct ConfidentialGuestSupport {
     Object parent;
@@ -55,8 +58,37 @@ struct ConfidentialGuestSupport {
 
 typedef struct ConfidentialGuestSupportClass {
     ObjectClass parent;
+
+    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
+    int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
 } ConfidentialGuestSupportClass;
 
+static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
+                                              Error **errp)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    if (klass->kvm_init) {
+        return klass->kvm_init(cgs, errp);
+    }
+
+    return 0;
+}
+
+static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
+                                               Error **errp)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    if (klass->kvm_reset) {
+        return klass->kvm_reset(cgs, errp);
+    }
+
+    return 0;
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
-- 
2.34.1


