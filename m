Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531CAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnJ-0005CA-K0; Tue, 23 Apr 2024 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn6-0004du-55
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmy-0000Fk-IE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEJ0yKlHrmKhZxiI7OJ9cPT/90ybcJyHoiSWV5zSPBM=;
 b=Ye0Pm3h5JbLXdPS+NiDBwGNI3Hcy4X4qC+eA4tWBbM1+Zx0+7umqDal+Fqfet4h0BI0zy+
 8r4SuSc0z2YirsvTqhaPIeCYE0v80HNns0HeZsVwMK/gbuNQVSs/KsMqh8S28I4nHKWulw
 OmjqCJZoX75rz/en6YelIsuL8qa9cgc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-2kM03ivqPAWWW3f9iaTLzQ-1; Tue,
 23 Apr 2024 11:10:27 -0400
X-MC-Unique: 2kM03ivqPAWWW3f9iaTLzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26AB429AC00A;
 Tue, 23 Apr 2024 15:10:27 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9573B20128F3;
 Tue, 23 Apr 2024 15:10:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 32/63] confidential guest support: Add kvm_init() and
 kvm_reset() in class
Date: Tue, 23 Apr 2024 17:09:20 +0200
Message-ID: <20240423150951.41600-33-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Different confidential VMs in different architectures all have the same
needs to do their specific initialization (and maybe resetting) stuffs
with KVM. Currently each of them exposes individual *_kvm_init()
functions and let machine code or kvm code to call it.

To facilitate the introduction of confidential guest technology from
different x86 vendors, add two virtual functions, kvm_init() and kvm_reset()
in ConfidentialGuestSupportClass, and expose two helpers functions for
invodking them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/confidential-guest-support.h | 34 ++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index ba2dd4b5dfc..e5b188cffbf 100644
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
2.44.0



