Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EC4C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLKR-0007Td-1T; Thu, 16 Jan 2025 03:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYLKO-0007Sq-Q8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYLKN-0005Vt-EL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737016450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n27dYMHHYP8KJ5aV5O/00ZCPe/fSvvQCNytTtLkRnag=;
 b=KQHUrW4sjNyLacbsbbd/V6cHGgRf2qi8Jk/7XDDUfxmwwtiRgD8GuyR/C3zYraL7uRBRJR
 0OcFTLGVIRlRAVF6UEsdQCtji0BpOzT6hlQvRqqgWKwKidqvO5/Dfmcib/0CHDRTvTnAPz
 qkHxnL1JL8jneA+femBcCzt7uqqEvhM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-p_iHrRzGMB6lzzfE1UPaIA-1; Thu,
 16 Jan 2025 03:34:06 -0500
X-MC-Unique: p_iHrRzGMB6lzzfE1UPaIA-1
X-Mimecast-MFC-AGG-ID: p_iHrRzGMB6lzzfE1UPaIA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79B0B1955DCD; Thu, 16 Jan 2025 08:34:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14CC030001BE; Thu, 16 Jan 2025 08:34:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [RFC v4 3/5] target/arm/kvm: Add helper to detect EL2 when using KVM
Date: Thu, 16 Jan 2025 09:32:16 +0100
Message-ID: <20250116083339.674344-4-eric.auger@redhat.com>
In-Reply-To: <20250116083339.674344-1-eric.auger@redhat.com>
References: <20250116083339.674344-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Haibo Xu <haibo.xu@linaro.org>

Introduce query support for KVM_CAP_ARM_EL2.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h | 12 ++++++++++++
 target/arm/kvm.c     |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd4..8c1314da20 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -193,6 +193,13 @@ bool kvm_arm_sve_supported(void);
  */
 bool kvm_arm_mte_supported(void);
 
+/**
+ * kvm_arm_el2_supported:
+ *
+ * Returns true if KVM can enable EL2 and false otherwise.
+ */
+bool kvm_arm_el2_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -247,6 +254,11 @@ static inline bool kvm_arm_mte_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_el2_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a9444a2c7a..43362164eb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1797,6 +1797,11 @@ bool kvm_arm_aarch32_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
 }
 
+bool kvm_arm_el2_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
+}
+
 bool kvm_arm_sve_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
-- 
2.47.1


