Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8500CFD37A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNq03-0006a3-6A; Tue, 25 Nov 2025 05:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpzh-0006LN-NF
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vNpzf-0002VV-Uk
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764065395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wmwl8pCep4VryZknq/Qy+pD1J/084HsHyjfcleURQNY=;
 b=flFdS5PsSnxo2cYw+V8cbRsDCRRI+mc55iSGBq9Ayi8+LDckk2p23ZUdQpbhRj+mW+6QPN
 KRbzPWnqTZScnXVwN0VeZAUS69y7bRAxf/mn0WKBhPTH8+FNKQbjPSj+VhIEy4+Y2lEQPg
 Oec+rPDlfJDiCd9kCaQNVOUsdH5cRaA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-SkanSSlnPRWjopLhpUjx8A-1; Tue,
 25 Nov 2025 05:09:52 -0500
X-MC-Unique: SkanSSlnPRWjopLhpUjx8A-1
X-Mimecast-MFC-AGG-ID: SkanSSlnPRWjopLhpUjx8A_1764065391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B7651956063; Tue, 25 Nov 2025 10:09:51 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CB1E18004A3; Tue, 25 Nov 2025 10:09:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v3 09/11] hw/arm/virt: Declare AArch32 DBGDTRTX as safe to
 ignore in incoming stream
Date: Tue, 25 Nov 2025 11:07:58 +0100
Message-ID: <20251125100859.506228-10-eric.auger@redhat.com>
In-Reply-To: <20251125100859.506228-1-eric.auger@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

With the new infrastructure in place it is now feasible to teach
qemu that it is safe to ignore a sysreg in the incoming migration
stream. So with the plan to revert commit 4f2b82f60431 ("target/arm:
Reinstate bogus AArch32 DBGDTRTX register for migration compat) from
qemu 11 onwards, let's add a compat in 10.2 machine options stating
that this reg is safe to ignore. from 11.0 onwards we will not need
that register anymore.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

Theoretically removing that register could also impact other ARM
machines but I don't think we have any compat outside of arm virt,
do we?
---
 hw/arm/virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0af8e6e7..c6a5146c92 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -100,6 +100,14 @@ static GlobalProperty arm_virt_compat_defaults[] = {
 static const size_t arm_virt_compat_defaults_len =
     G_N_ELEMENTS(arm_virt_compat_defaults);
 
+#define DBGDTRTX 0x40200000200e0298
+
+static GlobalProperty arm_virt_compat_10_2[] = {
+    { TYPE_ARM_CPU, "x-mig-safe-missing-regs", stringify(DBGDTRTX)},
+};
+static const size_t arm_virt_compat_10_2_len =
+    G_N_ELEMENTS(arm_virt_compat_10_2);
+
 /*
  * This cannot be called from the virt_machine_class_init() because
  * TYPE_VIRT_MACHINE is abstract and mc->compat_props g_ptr_array_new()
@@ -3536,6 +3544,7 @@ type_init(machvirt_machine_init);
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
+    compat_props_add(mc->compat_props, arm_virt_compat_10_2, arm_virt_compat_10_2_len);
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 
-- 
2.52.0


