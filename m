Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B366F588DE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpH1-00034m-8n; Mon, 20 Apr 2026 10:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGr-00031m-TM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGn-0001Qa-27
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT7aqYcG+mYJXqhu2vC1MHijVy5kS5S7OSHT4/LP03E=;
 b=IR9heNT49mXk/sML0ixByv9P3HhU7rcXpJs4f8uJAyEha6G8x559Vpn8HenGBUnXJcr44N
 UkAxnR2xf9DiOEIIdn9UgYt5MlbdqDxQxTHsfwJgewUOgvq/WD/Zm8ISukTSiGDm9W91Rx
 zDLO2V0KyNLEyc+oucnqmuu1kwdvhlc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-gHgHs0kpOi2hVK3pHtnZVg-1; Mon,
 20 Apr 2026 10:06:28 -0400
X-MC-Unique: gHgHs0kpOi2hVK3pHtnZVg-1
X-Mimecast-MFC-AGG-ID: gHgHs0kpOi2hVK3pHtnZVg_1776693987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47C4F1800473; Mon, 20 Apr 2026 14:06:27 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7C2E180047F; Mon, 20 Apr 2026 14:06:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 6/7] target/arm/helper: Define cpreg migration tolerance
 for DGBDTR_EL0
Date: Mon, 20 Apr 2026 16:03:56 +0200
Message-ID: <20260420140552.104369-7-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-1-eric.auger@redhat.com>
References: <20260420140552.104369-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Sebastian Ott <sebott@redhat.com>

---

v9 -> v10
- Adding a comment explaining why we want a migratoin tolerance
  for that cpreg
---
 target/arm/helper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..d80899cd096 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6426,9 +6426,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .fgt = FGT_CLIDR_EL1,
             .resetvalue = GET_IDREG(isar, CLIDR)
         };
+        uint64_t dbgtr_el0_kvmidx =
+            cpreg_to_kvm_id(ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0));
+
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
         define_debug_regs(cpu);
+        /**
+         * AArch32 DBGDTRTX has been introduced with a wrong encoding.
+         * This was fixed by commit 655659a74a36 ("target/arm: Correct
+         * encoding of Debug Communications Channel registers") by the
+         * introduction of correct separate cpreg definitions
+         * for AA64 and AA32 versions. However the old cpreg definition
+         * couldn't be removed without breaking the migration. From qemu 11.1
+         * onwards we can use the migration tolerance infrastructure to
+         * remove it.
+         */
+        arm_register_cpreg_mig_tolerance(cpu, dbgtr_el0_kvmidx,
+                                         0, 0, ToleranceNotOnBothEnds);
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
-- 
2.53.0


