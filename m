Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A63FF588CA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpHE-000378-Ej; Mon, 20 Apr 2026 10:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGu-00033U-Du
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGr-0001TQ-Lh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtGVpbU9D9A5ZHk/Is/GCfoppgSwhjM/X5KsFFKMQBQ=;
 b=M8wYECN4DLt5N1jIRx+zh1n5PEpvAgqjzVMc/JvMYevYL9C1S7u7Yz2xcokEPzqe+O8QDx
 W1BNVwAAjYOnH1RorVoIVH1oRwx10WL+XGxYy0cMCsiDcEBybY+HMY0ssxl1yEBXGLs6R9
 n87+9PRcSgHvJXDjQjjBRT8TqbCpVv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-fjcJ40SdON-6rFO84lnt4Q-1; Mon,
 20 Apr 2026 10:06:33 -0400
X-MC-Unique: fjcJ40SdON-6rFO84lnt4Q-1
X-Mimecast-MFC-AGG-ID: fjcJ40SdON-6rFO84lnt4Q_1776693991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 904A31800348; Mon, 20 Apr 2026 14:06:31 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D858C180047F; Mon, 20 Apr 2026 14:06:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 7/7] Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat"
Date: Mon, 20 Apr 2026 16:03:57 +0200
Message-ID: <20260420140552.104369-8-eric.auger@redhat.com>
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

This reverts commit 4f2b82f60431 ("target/arm: Reinstate bogus AArch32
DBGDTRTX register for migration compat). We don't need that commit
anymore as the AArch32 DBGDTRTX register is declared to
be safe to ignore in the incoming migration stream.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 352c8e5c8e7..8477ca5def6 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -171,13 +171,6 @@ static void dbgclaimclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.dbgclaim &= ~(value & 0xFF);
 }
 
-static CPAccessResult access_bogus(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   bool isread)
-{
-    /* Always UNDEF, as if this cpreg didn't exist */
-    return CP_ACCESS_UNDEFINED;
-}
-
 static const ARMCPRegInfo debug_cp_reginfo[] = {
     /*
      * DBGDRAR, DBGDSAR: always RAZ since we don't implement memory mapped
@@ -240,28 +233,6 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    /*
-     * This is not a real AArch32 register. We used to incorrectly expose
-     * this due to a QEMU bug; to avoid breaking migration compatibility we
-     * need to continue to provide it so that we don't fail the inbound
-     * migration when it tells us about a sysreg that we don't have.
-     * We set an always-fails .accessfn, which means that the guest doesn't
-     * actually see this register (it will always UNDEF, identically to if
-     * there were no cpreg definition for it other than that we won't print
-     * a LOG_UNIMP message about it), and we set the ARM_CP_NO_GDB flag so the
-     * gdbstub won't see it either.
-     * (We can't just set .access = 0, because add_cpreg_to_hashtable()
-     * helpfully ignores cpregs which aren't accessible to the highest
-     * implemented EL.)
-     *
-     * TODO: implement a system for being able to describe "this register
-     * can be ignored if it appears in the inbound stream"; then we can
-     * remove this temporary hack.
-     */
-    { .name = "BOGUS_DBGDTR_EL0", .state = ARM_CP_STATE_AA32,
-      .cp = 14, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
-      .access = PL0_RW, .accessfn = access_bogus,
-      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.53.0


