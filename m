Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206B0CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSy9-00058K-Ef; Wed, 21 Jan 2026 02:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSy3-0004tF-RO
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSy0-0003YH-GP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768981767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZepwHYUKbovmWr9l3d1myrw/xdtLr/RrktyUMd39Ito=;
 b=XVPMHXWSn1yeZgpgmc9WnkJIXj01UZL47v87JxiUhm0LJtHKoe/pZui9OXdYdLAAJXO00a
 y4E26JvG6jTn/IJ6ta/3qWH6Yo/ug9kI+uxBb+iRCsj1lERZhNzo6XlnCpkEjQooDnKrtF
 TB5Q60jF5MuFsxHqOdIFt8tSssu1SfA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-g5v2UKRlPeyY16rAkPwH-A-1; Wed,
 21 Jan 2026 02:49:23 -0500
X-MC-Unique: g5v2UKRlPeyY16rAkPwH-A-1
X-Mimecast-MFC-AGG-ID: g5v2UKRlPeyY16rAkPwH-A_1768981762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A343E1956063; Wed, 21 Jan 2026 07:49:22 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EECD819560A2; Wed, 21 Jan 2026 07:49:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v5 08/11] hw/arm/virt: Declare AArch32 DBGDTRTX as safe to
 ignore in incoming stream
Date: Wed, 21 Jan 2026 08:46:45 +0100
Message-ID: <20260121074834.1900677-9-eric.auger@redhat.com>
In-Reply-To: <20260121074834.1900677-1-eric.auger@redhat.com>
References: <20260121074834.1900677-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With the new infrastructure in place it is now feasible to teach
qemu that it is safe to ignore a sysreg in the incoming migration
stream. So with the plan to revert commit 4f2b82f60431 ("target/arm:
Reinstate bogus AArch32 DBGDTRTX register for migration compat") from
qemu 11.0 onwards, let's add a compat in 10.2 machine options stating
that this reg is safe to ignore. from 11.0 onwards we will not need
that register anymore.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- rebased on top of latest machine types (Connie)

v3 -> v4:
- add a comment related to DBGDTRTX (Connie)
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index baa4e31aac1..03d5af18f26 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -100,6 +100,15 @@ static GlobalProperty arm_virt_compat_defaults[] = {
 static const size_t arm_virt_compat_defaults_len =
     G_N_ELEMENTS(arm_virt_compat_defaults);
 
+/* Register erronously exposed on 10.2 and earlier */
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
@@ -3552,6 +3561,7 @@ static void virt_machine_10_2_options(MachineClass *mc)
 {
     virt_machine_11_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_2, hw_compat_10_2_len);
+    compat_props_add(mc->compat_props, arm_virt_compat_10_2, arm_virt_compat_10_2_len);
 }
 DEFINE_VIRT_MACHINE(10, 2)
 
-- 
2.52.0


