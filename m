Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A5E674B1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgBM-00072n-8L; Mon, 22 Dec 2025 08:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vXgAj-0006Zj-1k
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vXgAg-000278-T0
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766410917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUYMfvmytKifEGZ6TeqJN3l4M1eYVfe44Bc+EphvHi8=;
 b=S5HxGz96Go4zsdjWFAn3a4C7ZxrSREpCwnMt7wq07jLYDcrGax9dtwjjSxMqxxgHeo4Zn3
 JXTu2FQUmEdrXNEz3X72DUtsFgO4t8UlTZ5XjcZ/3d0Q8qMQ+Zd9DL2TJhj1vLNtLgLVlN
 snkl11H2LUc9Okglh8fi4NdecRkkXHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-JQlkWC6BOLGoME_GtbBJsw-1; Mon,
 22 Dec 2025 08:41:54 -0500
X-MC-Unique: JQlkWC6BOLGoME_GtbBJsw-1
X-Mimecast-MFC-AGG-ID: JQlkWC6BOLGoME_GtbBJsw_1766410912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B46AE18005B0; Mon, 22 Dec 2025 13:41:52 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 878681956048; Mon, 22 Dec 2025 13:41:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v4 07/10] target/arm/cpu: Expose x-mig-hidden-regs and
 x-mig-safe-missing-regs properties
Date: Mon, 22 Dec 2025 14:40:04 +0100
Message-ID: <20251222134110.3649287-8-eric.auger@redhat.com>
In-Reply-To: <20251222134110.3649287-1-eric.auger@redhat.com>
References: <20251222134110.3649287-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
to enable cross kernel migration.

This will allow to define such compat machine props like:

    static GlobalProperty arm_virt_kernel_compat_10_1[] = {
        /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
        { TYPE_ARM_CPU, "x-mig-hidden-regs", "0x6030000000160003" },
        { TYPE_ARM_CPU, "x-mig-safe-missing-regs",
          /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
          "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
    }

The first one means KVM_REG_ARM_VENDOR_HYP_BMAP_2 shall always
be hidden for machine types older than 10.1. The second one means
that along with 10.1 machine type we may receive in the incoming
migration stream, 3 registers that are unknown on destination.

Obviously, using the reg index as defined in
linux/Documentation/virt/kvm/api.rst is not user friendly. However
These options are supposed to be used to enable specific, rare cases,
and in general, by people trying to configure distribution defaults
familiar with those specific cases.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- typo and rewording in the commit description (Connie)
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
2.52.0


