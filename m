Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97746D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPsY-0000iY-Lj; Mon, 26 Jan 2026 11:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPsX-0000gg-6k
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkPsV-0007Sr-Q6
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769446551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bBuNl2PG8WYMyGmaswgduPGATq1Nmd9Go56JN83xTw=;
 b=fAH67hOHdEGf7FKqObyqIONdMf0WgQyX8SUxhFIkb6h2sYR1T2IsEoTyvKYUeHMGkc/cVi
 Ef9Y6RiC+5Jm9M2lObgWLQ1H5al+1hQBTTdWsGJYBMzE15L7bpbhfV6BHCi75GsrKQSSxo
 VjJhKXHzc5SkoPZGSpy/YV2sbYNw5V0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-WgU64vZoMECmE8ttHUgCOQ-1; Mon,
 26 Jan 2026 11:55:47 -0500
X-MC-Unique: WgU64vZoMECmE8ttHUgCOQ-1
X-Mimecast-MFC-AGG-ID: WgU64vZoMECmE8ttHUgCOQ_1769446546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53CEA1944B07; Mon, 26 Jan 2026 16:55:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4B5118001D5; Mon, 26 Jan 2026 16:55:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v6 11/11] hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility
 with older kernels
Date: Mon, 26 Jan 2026 17:53:10 +0100
Message-ID: <20260126165445.3033335-12-eric.auger@redhat.com>
In-Reply-To: <20260126165445.3033335-1-eric.auger@redhat.com>
References: <20260126165445.3033335-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/virt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a01dfb7fb79..f20a8453cbd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3626,9 +3626,16 @@ DEFINE_VIRT_MACHINE(10, 2)
 
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_10_2_options(mc);
     mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
+    arm_virt_compat_register_hidden_reg(vmc, 0x6030000000160003);
+    arm_virt_compat_register_safe_missing_reg(vmc, 0x603000000013c103 /* TCR_EL1 */);
+    arm_virt_compat_register_safe_missing_reg(vmc, 0x603000000013c512 /* PIRE0_EL1 */);
+    arm_virt_compat_register_safe_missing_reg(vmc, 0x603000000013c513 /* PIR_EL1 */);
 }
 DEFINE_VIRT_MACHINE(10, 1)
 
-- 
2.52.0


