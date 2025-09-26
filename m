Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A62CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293A-0006ge-V0; Fri, 26 Sep 2025 10:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2935-0006fx-Iw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2932-0004oz-2A
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fE5De4SjYRlCpVLxA+SQVwGwECmyEZ+H53iSXNQLIpI=;
 b=aWtGQ+UZWlHvDyO4EgSL2onJcB30SO+IqDnJN4ypEP7kBUe3I1kLd3QDFRa7OdVd+xD4MN
 XXbhrbJ8W62MPKUNI74IIv0H4+qQiVRbCzccnTDuE6lDyefK5fLcTmEfEzFWDYQ+ayNTeI
 b3d6FW3q6popkqcyn6b2QxcfMwYEpnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-_o3dCpmAMIe2fMKNfYDkuA-1; Fri,
 26 Sep 2025 10:03:35 -0400
X-MC-Unique: _o3dCpmAMIe2fMKNfYDkuA-1
X-Mimecast-MFC-AGG-ID: _o3dCpmAMIe2fMKNfYDkuA_1758895414
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6498C1800451; Fri, 26 Sep 2025 14:03:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B8E81956095; Fri, 26 Sep 2025 14:03:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/32] accel: mark kvm, xen & hvf as secure;
 tcg & qtest as insecure
Date: Fri, 26 Sep 2025 15:01:28 +0100
Message-ID: <20250926140144.1998694-18-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TCG is too complex to be considered to provide a security boundary
for malicious guest workloads. QTest is only used for functional
testing and thus is not relevant to mark secure.

KVM, HVF and Xen, meanwhile are all servicing virtualization use
cases which must provide security.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel-common.c      | 1 +
 accel/accel-system.c      | 1 +
 accel/accel-target.c      | 1 +
 accel/hvf/hvf-accel-ops.c | 1 +
 accel/hvf/hvf-all.c       | 1 +
 accel/kvm/kvm-accel-ops.c | 1 +
 accel/kvm/kvm-all.c       | 1 +
 accel/qtest/qtest.c       | 2 ++
 accel/tcg/tcg-accel-ops.c | 1 +
 accel/tcg/tcg-all.c       | 1 +
 accel/xen/xen-all.c       | 2 ++
 11 files changed, 13 insertions(+)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 850c5ab4b8..cb44315f27 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -138,6 +138,7 @@ static const TypeInfo accel_types[] = {
         .class_size     = sizeof(AccelClass),
         .instance_size  = sizeof(AccelState),
         .abstract       = true,
+        .secure         = true,
     },
 };
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 1e97c64fdc..fbffcccbd6 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -114,6 +114,7 @@ static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(AccelOpsClass),
     .class_init = accel_ops_class_init,
 };
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 7fd392fbc4..6ea9386cb8 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -31,6 +31,7 @@ static const TypeInfo accel_cpu_type = {
     .parent = TYPE_OBJECT,
     .abstract = true,
     .class_size = sizeof(AccelCPUClass),
+    .secure = true,
 };
 
 static void register_accel_types(void)
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8b794c2d41..e807103379 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -397,6 +397,7 @@ static const TypeInfo hvf_accel_ops_type = {
     .parent = TYPE_ACCEL_OPS,
     .class_init = hvf_accel_ops_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static void hvf_accel_ops_register_types(void)
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e83..1d49a59053 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -304,6 +304,7 @@ static const TypeInfo hvf_accel_type = {
     .parent = TYPE_ACCEL,
     .instance_size = sizeof(HVFState),
     .class_init = hvf_accel_class_init,
+    .secure = true,
 };
 
 static void hvf_type_init(void)
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 8ed6945c2f..d4d30c311f 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -119,6 +119,7 @@ static const TypeInfo kvm_accel_ops_type = {
     .parent = TYPE_ACCEL_OPS,
     .class_init = kvm_accel_ops_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static void kvm_accel_ops_register_types(void)
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9060599cd7..67f2172443 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4066,6 +4066,7 @@ static const TypeInfo kvm_accel_type = {
     .instance_init = kvm_accel_instance_init,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
+    .secure = true,
 };
 
 static void kvm_type_init(void)
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 1d4337d698..44649b0ebb 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -58,6 +58,7 @@ static const TypeInfo qtest_accel_type = {
     .name = TYPE_QTEST_ACCEL,
     .parent = TYPE_ACCEL,
     .class_init = qtest_accel_class_init,
+    .secure = false,
 };
 module_obj(TYPE_QTEST_ACCEL);
 
@@ -77,6 +78,7 @@ static const TypeInfo qtest_accel_ops_type = {
     .parent = TYPE_ACCEL_OPS,
     .class_init = qtest_accel_ops_class_init,
     .abstract = true,
+    .secure = false,
 };
 module_obj(ACCEL_OPS_NAME("qtest"));
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd9800504..125017df29 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -239,6 +239,7 @@ static const TypeInfo tcg_accel_ops_type = {
     .parent = TYPE_ACCEL_OPS,
     .class_init = tcg_accel_ops_class_init,
     .abstract = true,
+    .secure = false,
 };
 module_obj(ACCEL_OPS_NAME("tcg"));
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 18ea0c58b0..3aab82b51b 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -296,6 +296,7 @@ static const TypeInfo tcg_accel_type = {
     .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
     .instance_size = sizeof(TCGState),
+    .secure = false,
 };
 module_obj(TYPE_TCG_ACCEL);
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 97377d67d1..754a4099a4 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -147,6 +147,7 @@ static const TypeInfo xen_accel_type = {
     .name = TYPE_XEN_ACCEL,
     .parent = TYPE_ACCEL,
     .class_init = xen_accel_class_init,
+    .secure = true,
 };
 
 static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
@@ -163,6 +164,7 @@ static const TypeInfo xen_accel_ops_type = {
     .parent = TYPE_ACCEL_OPS,
     .class_init = xen_accel_ops_class_init,
     .abstract = true,
+    .secure = true,
 };
 
 static void xen_type_init(void)
-- 
2.50.1


