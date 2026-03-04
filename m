Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE5EB7EB6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjNw-00075e-SZ; Wed, 04 Mar 2026 05:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjNv-00074z-6G
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjNt-0002bx-W5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyKs2XjxalZIh1rEgOJiZBWSDMGmfe3TX4GJ7G8ZqkQ=;
 b=JdL/NYGhBloNeAyTaBkgbb93bKXb0WN9XypZx9OVuOEhipyNpCNlWPFrW1rHgeJUGKGZ/C
 BroiMF5Qet4e+e6XO/xuO4Dm8ySiCaI2PuVU1OK2QSRCqGNOn9FpxRbhbiHYQuc4gOowXn
 EEznLWv91VVojPF4uSmb96pp/G2WlPM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-Lwv7xGk2NTCW-A13lRNpZQ-1; Wed,
 04 Mar 2026 05:23:14 -0500
X-MC-Unique: Lwv7xGk2NTCW-A13lRNpZQ-1
X-Mimecast-MFC-AGG-ID: Lwv7xGk2NTCW-A13lRNpZQ_1772619793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 593DA18002CB; Wed,  4 Mar 2026 10:23:13 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0482F1958DC2; Wed,  4 Mar 2026 10:23:09 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v8 5/6] target/arm/helper: Define cpreg migration tolerance
 for DGBDTR_EL0
Date: Wed,  4 Mar 2026 11:22:09 +0100
Message-ID: <20260304102249.1963784-6-eric.auger@redhat.com>
In-Reply-To: <20260304102249.1963784-1-eric.auger@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

We want to remove AArch32 DBGDTRTX which was erroneously exposed.
This was attempted by 655659a74a36b ("target/arm: Correct encoding
of Debug Communications Channel registers") but it was discovered
that the removal of this debug register broke forward migration on
TCG. Now we have the cpreg migration tolerance infrastructure, we
can declare one for the DBGDTRTX. This allow to revert the reinstate
patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..3cba62705dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6426,9 +6426,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .fgt = FGT_CLIDR_EL1,
             .resetvalue = GET_IDREG(isar, CLIDR)
         };
+        uint64_t dbgtr_el0_kvmidx =
+            cpreg_to_kvm_id(ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0));
+
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
         define_debug_regs(cpu);
+        arm_register_cpreg_mig_tolerance(cpu, dbgtr_el0_kvmidx,
+                                         0, 0, ToleranceNotOnBothEnds);
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
-- 
2.53.0


