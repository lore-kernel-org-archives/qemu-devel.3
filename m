Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF75E9B359
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0eS-000379-OE; Mon, 02 Mar 2026 05:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0eN-00034L-8p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx0eI-0001t0-O6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772447833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyKs2XjxalZIh1rEgOJiZBWSDMGmfe3TX4GJ7G8ZqkQ=;
 b=MlDhAvAdy6achPMpb+W4nJmmeUZJjXoteofvh7zeLI7kV0HL61o+ZK4TskhLwaD4FIhYWm
 KnnaZYVNct5/s90skRkucdIMP3u/Lbi2dcxY9BZSJr7g166oIVMEGt026xfGTAnsU9CfaW
 JAqUfmLp2SkdoyXx/0/JJSmUl/Wdl8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-L--x-rIZOJ-8HCkq0YeSpw-1; Mon,
 02 Mar 2026 05:37:10 -0500
X-MC-Unique: L--x-rIZOJ-8HCkq0YeSpw-1
X-Mimecast-MFC-AGG-ID: L--x-rIZOJ-8HCkq0YeSpw_1772447828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6E3D195609D; Mon,  2 Mar 2026 10:37:08 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBD0B1800666; Mon,  2 Mar 2026 10:37:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v7 6/7] target/arm/helper: Define cpreg migration tolerance
 for DGBDTR_EL0
Date: Mon,  2 Mar 2026 11:35:28 +0100
Message-ID: <20260302103640.1362564-7-eric.auger@redhat.com>
In-Reply-To: <20260302103640.1362564-1-eric.auger@redhat.com>
References: <20260302103640.1362564-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
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


