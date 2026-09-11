Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8B2C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52QK-0004WA-Oq; Fri, 11 Sep 2026 10:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mu-0002KR-Ho
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mo-0007p3-Qx
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mS2d1sWvkJvfrpBNzSThHFJjRCwDwl0JUnHIN1+hoNI=;
 b=PjaDa0x5436p0iQ+p/xj9mLicQvl6pla5qi+rbIFM2MF82U6u6KzuybqL5CyXGBm95YKjO
 JC0ziKf4xXBkrVn/sRWXrsccLOj/TEfv7OlNUbrdmPvaifWBmN8PU8ImggNUMgBB178zRa
 a8NTNFVGbtT2V8zQ2Jm7Q72bWphhuzg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-jsyPwnXzMwa2-qmFeiK4Mg-1; Fri,
 11 Sep 2026 10:36:36 -0400
X-MC-Unique: jsyPwnXzMwa2-qmFeiK4Mg-1
X-Mimecast-MFC-AGG-ID: jsyPwnXzMwa2-qmFeiK4Mg_1789137395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4400F195399C; Fri, 11 Sep 2026 14:36:35 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52E2B3000229; Fri, 11 Sep 2026 14:36:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/28] accel: mark kvm and xen accelerators as secure
Date: Fri, 11 Sep 2026 15:36:01 +0100
Message-ID: <20260911143627.2743803-3-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

TCG is too complex to be considered to provide a security boundary
for malicious guest workloads. QTest is only used for functional
testing and thus is not relevant to mark secure.

KVM and Xen are servicing virtualization use cases which must
provide security and actively maintained.

While HVF would be in scope conceptually, it is not sufficiently
mature or maintained to claim a security boundary at this time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel-common.c      | 2 ++
 accel/accel-system.c      | 1 +
 accel/kvm/kvm-accel-ops.c | 1 +
 accel/kvm/kvm-all.c       | 1 +
 accel/xen/xen-all.c       | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f..1d993f0ad8 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -125,6 +125,7 @@ static const TypeInfo accel_types[] = {
         .class_size     = sizeof(AccelClass),
         .instance_size  = sizeof(AccelState),
         .abstract       = true,
+        .secure         = true,
     },
 };
 
@@ -137,6 +138,7 @@ static void register_accel_target_type(void)
         .name = name,
         .parent = TYPE_OBJECT,
         .abstract = true,
+        .secure = true,
         .class_size = sizeof(AccelCPUClass),
     };
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 1325b23864..f3f31bc666 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -118,6 +118,7 @@ static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(AccelOpsClass),
     .class_init = accel_ops_class_init,
 };
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c8e7aa3870..f05d41a837 100644
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
index 83cbd120a8..af886aa28c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4328,6 +4328,7 @@ static const TypeInfo kvm_accel_type = {
     .instance_finalize = kvm_accel_finalize,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
+    .secure = true,
 };
 
 static void kvm_type_init(void)
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index bb2d02cb22..937e0e947d 100644
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
2.55.0


