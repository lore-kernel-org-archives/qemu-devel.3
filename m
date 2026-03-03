Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7556EC1459
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQuh-0001Xl-UL; Tue, 03 Mar 2026 09:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQud-0001UJ-Bj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxQub-0002Ay-RJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772548789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvWtCfcf5xA5sKzkn7CU5so+nAY8+TITssoqVfCLesM=;
 b=StR5iNUZQ4trSDj4bwIHrPa7TlM8PC6+VqBIo8A/GA0JVs21dWtT5D0PP5vi3+63Poo2Fn
 Dazij9PuZ1m1i6rlt049SptiyTWnX5zp+CUwLgSmsKg6ObfRjoty9MdBQbrqrPG8L9WKLJ
 9uc8fMA5QE0g/RA23yXsjVm8817uK2U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-vMkF1KyxPfi3nJlDiqoAFw-1; Tue,
 03 Mar 2026 09:39:46 -0500
X-MC-Unique: vMkF1KyxPfi3nJlDiqoAFw-1
X-Mimecast-MFC-AGG-ID: vMkF1KyxPfi3nJlDiqoAFw_1772548785
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9920195605C; Tue,  3 Mar 2026 14:39:44 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5062300022A; Tue,  3 Mar 2026 14:39:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 3/7] target/arm/kvm: Export kvm_print_register_name()
Date: Tue,  3 Mar 2026 15:36:35 +0100
Message-ID: <20260303143928.1747116-4-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-1-eric.auger@redhat.com>
References: <20260303143928.1747116-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

---

v1 -> v2:
- add doc comment
- no code after g_assert_not_reached()
- use char * instead of gchar
---
 target/arm/kvm_arm.h  | 8 ++++++++
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cc0b374254e..ca2492c7412 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -266,4 +266,12 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
 void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
 
+/*
+ * kvm_print_register_name:
+ * @regidx: register KVM index
+ *
+ * Returns a human-readable string representing this register
+ */
+char *kvm_print_register_name(uint64_t regidx);
+
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index ea67deea520..047e2291d98 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -129,3 +129,8 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     g_assert_not_reached();
 }
+
+char *kvm_print_register_name(uint64_t regidx)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 12a75f42e07..cfb46015d48 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -913,7 +913,7 @@ static gchar *kvm_print_sve_register_name(uint64_t regidx)
     }
 }
 
-static gchar *kvm_print_register_name(uint64_t regidx)
+char *kvm_print_register_name(uint64_t regidx)
 {
         switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
         case KVM_REG_ARM_CORE:
-- 
2.53.0


