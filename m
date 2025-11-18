Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0822FCEE334
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOI0-00030j-GZ; Tue, 18 Nov 2025 11:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHa-0002l9-4a
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOHX-0005Gx-D8
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe9X9vrtzuAvfuKIbXQg7zoSn4VcD4HMrEpnSfOuFKg=;
 b=aaUDFUSkPaVAhVJa0DfZ3Q7rdRyNgqpAWQT5/UpoFnHp+hkqWfWRtxjpa0jsTkc71J1S1q
 F4nNjJjqxU7FsPLWlcsUZtIETe3gMecfJ9JCzDZ49cOx/A7cgihq6FyggbbYhblTwG6uVL
 mtz+/HDtU2t0BJOeoxxGYOZ08sn7Ux8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-E3JPMRIzOsevxW9EbuKpBA-1; Tue,
 18 Nov 2025 11:10:09 -0500
X-MC-Unique: E3JPMRIzOsevxW9EbuKpBA-1
X-Mimecast-MFC-AGG-ID: E3JPMRIzOsevxW9EbuKpBA_1763482208
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5986C195607F; Tue, 18 Nov 2025 16:10:08 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF4B519560B2; Tue, 18 Nov 2025 16:10:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 7/8] target/arm/cpu: Expose x-mig-hidden-regs and
 x-mig-safe-missing-regs properties
Date: Tue, 18 Nov 2025 17:07:37 +0100
Message-ID: <20251118160920.554809-8-eric.auger@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allows to set both array properties along with arm cpus. Their "x-" prefix
reminds that those shall be used carefully for distro specific use cases
to garantee cross kernel migration.

This will allow to define such compat machine props like:

    static GlobalProperty arm_virt_kernel_compat_10_1[] = {
        /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
        { TYPE_ARM_CPU, "x-mig-hidden-regs", "0x6030000000160003" },
        { TYPE_ARM_CPU, "x-mig-safe-missing-regs",
          /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
          "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
    }

The first one means KVM_REG_ARM_VENDOR_HYP_BMAP_2 shall always
been hidden for machine types older than 10.1. The second one means
that along with 10.1 machine type we may receive in the incoming
migration stream, 3 registers that are unknown on destination.

Obvioulsy, using the reg index as defined in
linux/Documentation/virt/kvm/api.rst is not user friendly. However
those options, prefixed with "x-" are supposed to be used
rarely by people who know the details.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 066746d76f..c41774cb4c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2248,6 +2248,11 @@ static const Property arm_cpu_properties[] = {
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
     DEFINE_PROP_BOOL("backcompat-pauth-default-use-qarma5", ARMCPU,
                       backcompat_pauth_default_use_qarma5, false),
+    DEFINE_PROP_ARRAY("x-mig-hidden-regs", ARMCPU,
+                      nr_hidden_regs, hidden_regs, qdev_prop_uint64, uint64_t),
+    DEFINE_PROP_ARRAY("x-mig-safe-missing-regs", ARMCPU,
+                      nr_mig_safe_missing_regs, mig_safe_missing_regs,
+                      qdev_prop_uint64, uint64_t),
 };
 
 static const gchar *arm_gdb_arch_name(CPUState *cs)
-- 
2.51.1


