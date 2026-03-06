Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E21CFCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiR-0006Wb-Ul; Fri, 06 Mar 2026 10:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyWi8-0006AH-8t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyWi6-0003Fb-66
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772809404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eldssNcwL2vzqR/skuruxhEOMx/slaPtYj/2cYe4PG0=;
 b=JE4mOVYsZFrNuMq0geAzbZtNhrWDoXXYYx7CmWJ5B7HUt2e2VV0VlubDFefwyOTNX08xIx
 x8jFB8JXAwtYGReIbxVQRysUoY8m9PriC0fYiyxvn3yCx587A7nLb+mWYOi5r6yqf7ISyi
 rtMvAxNCr8B436hTjDJwaqcnOKhShRc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-gspfo7W7O96rgc5S92frEw-1; Fri,
 06 Mar 2026 10:03:21 -0500
X-MC-Unique: gspfo7W7O96rgc5S92frEw-1
X-Mimecast-MFC-AGG-ID: gspfo7W7O96rgc5S92frEw_1772809400
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28DA18005BA; Fri,  6 Mar 2026 15:03:19 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.126])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3A903003EA4; Fri,  6 Mar 2026 15:03:16 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v9 3/6] target/arm/cpu64: Mitigate migration failures due to
 spurious TCR_EL1, PIRE0_EL1 and PIR_EL1
Date: Fri,  6 Mar 2026 16:02:21 +0100
Message-ID: <20260306150302.203112-4-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-1-eric.auger@redhat.com>
References: <20260306150302.203112-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Before linux v6.13 those registers were erroneously unconditionally
exposed and this was fixed by commits:
- 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace when
                 disabled for guests")
- a68cddbe47ef ("KVM: arm64: Hide S1PIE registers from userspace
                 when disabled for guests")
in v6.13.

This means if we migrate from an old kernel host to a >= 6.13 kernel
host, migration currently fails.

Declare cpreg migration tolerance for those registers.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu64.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d6feba220e8..4cfddc6e8c0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -810,6 +810,31 @@ static void aarch64_a53_initfn(Object *obj)
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
+{
+    /*
+     * Registers that may be in the incoming stream and not exposed
+     * on the destination
+     */
+
+    /*
+     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
+     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
+     * when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+    /*
+     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
+     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
+     * S1PIE registers from userspace when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
+                                     0, 0, ToleranceNotOnBothEnds);
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+}
+
 static void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -822,6 +847,7 @@ static void aarch64_host_initfn(Object *obj)
 #endif
 
 #if defined(CONFIG_KVM)
+    kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
 #elif defined(CONFIG_HVF)
-- 
2.53.0


