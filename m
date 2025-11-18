Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37FFCEE336
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOI2-00032O-3s; Tue, 18 Nov 2025 11:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHd-0002lT-TY
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHa-0005JE-62
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ADEUuflPQQbxhen/vxc1MxXWSLJnEmDVthTlqLv7OY=;
 b=RtApJ5VB4CiRVUq26MYOqpkHyvhQ27BKwwcaCHd2aUADdCB8dbaQlK2TRS3IKMGZmmg2K8
 w2WIF6SXGYZgEXKDsfH7NgAFMBb1CkuUsHdU8QbHejnWRCnI6RC1Q/fMOpxwkaUqDXN68g
 W/Z9rkstKjFKtMtaM8+vbUD8/Y6Yu2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-ilYYCJvhOja6pwZ3WzFF1g-1; Tue,
 18 Nov 2025 11:10:15 -0500
X-MC-Unique: ilYYCJvhOja6pwZ3WzFF1g-1
X-Mimecast-MFC-AGG-ID: ilYYCJvhOja6pwZ3WzFF1g_1763482213
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C766D19560B7; Tue, 18 Nov 2025 16:10:13 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE62519560B2; Tue, 18 Nov 2025 16:10:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 8/8] hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility
 with older kernels
Date: Tue, 18 Nov 2025 17:07:38 +0100
Message-ID: <20251118160920.554809-9-eric.auger@redhat.com>
In-Reply-To: <20251118160920.554809-1-eric.auger@redhat.com>
References: <20251118160920.554809-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is an example on how to use the new CPU options. This catters to
distributions who want machines to be migratable (forward and backward)
accross different host kernel versions in case KVM registers exposed
to qemu vary accross kernels. This patch is not meant to be upstreamed
as it is really kernel dependent. The goal is to illustrate how this
would be used.

In this example, For 10_1 machines types and older we apply the following
host kernel related compats:

1) Make sure the KVM_REG_ARM_VENDOR_HYP_BMAP_2 exposed from v6.15 onwards
   is ignored/hidden.
2) Make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are always seen by qemu
   although not exposed by KVM. They were unconditionnally exposed before
   v6.13 while from v6.13 they are only exposed if supported by the guest.

This will allow 10_1 machines types and older machines to migrate
forward and backward from old downstream kernels that do not feature
those changes to newer kernels (>= v6.15).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab56..fd8cff7a6f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -99,6 +99,23 @@ static GlobalProperty arm_virt_compat[] = {
 };
 static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
 
+/*
+ * if a 10_1 machine type or older is used:
+ * 1) make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are enforced, even if they are not
+ *    exposed by the kernel
+ * 2) hide KVM_REG_ARM_VENDOR_HYP_BMAP_2
+ */
+static GlobalProperty arm_virt_kernel_compat_10_1[] = {
+    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
+    { TYPE_ARM_CPU, "x-mig-hidden-regs", "0x6030000000160003" },
+    /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
+    { TYPE_ARM_CPU, "x-mig-safe-missing-regs",
+      "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
+};
+static const size_t arm_virt_kernel_compat_10_1_len =
+    G_N_ELEMENTS(arm_virt_kernel_compat_10_1);
+
+
 /*
  * This cannot be called from the virt_machine_class_init() because
  * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
@@ -3543,6 +3560,8 @@ static void virt_machine_10_1_options(MachineClass *mc)
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    compat_props_add(mc->compat_props,
+                     arm_virt_kernel_compat_10_1, arm_virt_kernel_compat_10_1_len);
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
-- 
2.51.1


