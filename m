Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED0EB7EA5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjHe-0002Sr-Rd; Wed, 04 Mar 2026 05:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHd-0002SK-31
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHb-0008UR-LP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIGaNKkd3Um45QtvQTiKVKpv/SaTG5SFybo4hElOcHI=;
 b=GpPk9vglSaOTu767rRevPT2tDDbiPD8j7yAv97TZT9gVRzUNIhF0fxF9wndTHfXckhCR/e
 o+rZL10q9w/gLk+ZABTpTOFFA5BXXERIabZ+9RBziLfHU2BSQfDMxTq1kO5xPd4vNBWgFo
 K0uYa1K30Cq8wfCWncczHhqjDtotIZI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-HzjC2kp6NdukpCTS58e_zw-1; Wed,
 04 Mar 2026 05:16:43 -0500
X-MC-Unique: HzjC2kp6NdukpCTS58e_zw-1
X-Mimecast-MFC-AGG-ID: HzjC2kp6NdukpCTS58e_zw_1772619402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FECD1956050; Wed,  4 Mar 2026 10:16:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83A85180035F; Wed,  4 Mar 2026 10:16:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 3/7] target/arm/kvm: Export kvm_print_register_name()
Date: Wed,  4 Mar 2026 11:15:42 +0100
Message-ID: <20260304101625.1962633-4-eric.auger@redhat.com>
In-Reply-To: <20260304101625.1962633-1-eric.auger@redhat.com>
References: <20260304101625.1962633-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We want to use kvm_print_register_name() in machine.c so
let's export the helper and implement a stub when kvm
is not enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v2 -> v3:
- added "The caller must free the string with g_free()."

v1 -> v2:
- add doc comment
- no code after g_assert_not_reached()
- use char * instead of gchar
---
 target/arm/kvm_arm.h  | 9 +++++++++
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 82ac2aae464..e7c40fb003e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -231,4 +231,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
 void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
 
+/*
+ * kvm_print_register_name:
+ * @regidx: register KVM index
+ *
+ * Returns a human-readable string representing this register
+ * The caller must free the string with g_free().
+ */
+char *kvm_print_register_name(uint64_t regidx);
+
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 169ef5f2063..88cbe8d85c4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -114,3 +114,8 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     g_assert_not_reached();
 }
+
+char *kvm_print_register_name(uint64_t regidx)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 555083e7aaf..11f6f2dff09 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -970,7 +970,7 @@ static gchar *kvm_print_sve_register_name(uint64_t regidx)
     }
 }
 
-static gchar *kvm_print_register_name(uint64_t regidx)
+char *kvm_print_register_name(uint64_t regidx)
 {
         switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
         case KVM_REG_ARM_CORE:
-- 
2.53.0


