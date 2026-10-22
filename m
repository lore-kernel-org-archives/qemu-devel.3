Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=xhW0Azsy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TR-0000ab-7U; Thu, 22 Oct 2026 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T8-0000SM-DN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from st-2006g-snip6-6.eps.apple.com ([2a01:b747:3001:203::43]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T5-0005pi-2h
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:01 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 5FFFC18001C9; Thu, 22 Oct 2026 21:36:54 +0000 (UTC)
X-ICL-RepId: 01a1658b-aa64-73c7-bf0c-9747f6e506e3
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705014; x=1824241014;
 bh=516LHCjxhYVa/oHYhUBIiplgy+5LCdjkc8AsCFcHAQw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=xhW0AzsymlAaIJxVe1TxzFBllA0N4BQ5+glEJhn7rTjMOsDxcO0Mw9GL6gNr9Hh4rCl/U7ZblkA3G4Qd8NjtK1Gf+1rCdj5Cor3L5EaI1tJLCs4l/xlJbsRApfhytMbV5Yiv6IeAy9XpOgwRKVAZpYk5yiYVBKnbYa5P0zUUzZc/sOchVfKtX7QGqVGoSlyBB9nwhfF9BGpco4izv83djVkl3NvRqipoRQ8R2x8EqDNhZEAYbDbt2zdxDF4ZR7WgvR9q4/U65z2sWlyGrW6ouwcpIJFaWmrS1qPdnKSiqEfbrTbdrtozewrJa91ZCatEh4+/c0SM4gWvchQqY+JWxw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 4BB2218003C3; Thu, 22 Oct 2026 21:36:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
Subject: [PATCH 2/6] target/arm: sync vCPU state after PSCI CPU_ON reset
Date: Thu, 22 Oct 2026 23:36:43 +0200
Message-ID: <20261022213647.21665-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=CaQFJbrl c=1 sm=1 tr=0 ts=6ada81f6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=xwGy2wHAUxiY-1LVAFQA:9
X-Proofpoint-GUID: BysvUsxmZueGDwE3Mj9zfFSvYiw33Gnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfXwHFvQRpgFF8W
 ijVaiy3FwNuHMQy31o3BGA5eQ+JEKSYvJVwU7udhBVWj7py84Ni1OQmRmqzjRCUoSSZtShsjkGh
 FVeqfIlN+trQitngjQkzZteWTgDRFVIa6mDlHwhFWIvqL6N1JF93eiQqVkHOeojOc5LwV5nXgXx
 A6171OAQAFsjvtg/2//8eciPhWshqP4v0+NqG21no+Qdym/TmSMoJxZVWTz2oo0OdnPtroSEKD2
 ZqCfGOm1UX4xIZbtOyLJDdIhKm79A3Xrw1pF4MQ7bJGbHvoJbZ2PCs/Y3xXMC1upVBlgqdY66bi
 DLQPCvKnymPgeeOyRG9E3mJ22IVdXHSe/GzW1zdXhbtd+daAIPpCFv0E+Dnw0A=
X-Proofpoint-ORIG-GUID: BysvUsxmZueGDwE3Mj9zfFSvYiw33Gnk
X-JNJ: AAAAAAABQiQB1O7We96dH4K/xI5f60QhuccLTDXB6+akbhfx5vzjpJFC9opE+mkn5CPkHDLC2Fgrdpl32nnLtr0Rm45mqys4gR1Xx+0d36y6nMzktXoKiRrCFn9ydM7Pc8F7naNqbcVTbr9dRFrLxfvjowi1CNzVPSH07A1e79iZ5h1rkREYRIfT0we1gBe0Yfh9HZx9vOs/WiYWjSBk9XqszJPDh9zl3D+zPloGR6Qh+olxRw7mIw6S3h2he1bEU/WbkKmF+lQ8W02SefsLmS3vQD5ft+t4FmopyBNjZZJcDM/bt4v9epk96RZxkrFijIpKfrKlkmW4L4RIqeJ3piaayMU1ZO2lN67/pJFzwKKKp27M4h5uB4qUoJsZAox5ChorlbKLXIKeR6T6bFIsWVsWi7R4Z0Y99h/QDHWf/sJ0QRMzW7B2d/vD7jemSrR6UcqE4Gsu/2ztHfMyXJ+abP6hN/dxLhY7Op/OetQDQ0kh792krS2dFyqRUT6zvdwZuvBb2TZtUHkj9q/EKjQgIRa9GfBpEfbFG9E++L4VExtISRYJh6bm3TfHOm+x3zaEWfSFwxdHJLDvvcrmv3CPFdv5Wj8zOR5yTdo0FiNh1ECzk1iLC15iwl0YV2oAuS4Vik8zbmbkNWdyT/sHiwn5aj5j+2as30pFMha/Q7KlkqSk7jm7thj41OGb5u83in57d0sfyYTu63+0vVRdzeftZcWTjuROUIyOYCoknenEDuiYR8+/933zZwwBwXE5B2gYDEajXkzyeJuoAu9Ucx2KI1HW/7JEVnRTOiw=
Received-SPF: pass client-ip=2a01:b747:3001:203::43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>

arm_set_cpu_on_async_work() resets the target CPU and sets its entry
point and context ID in CPUARMState, but never tells the accelerator
that the register state changed. TCG reads CPUARMState directly, and
KVM re-pushes state on reset, but HVF only writes CPUARMState back to
the hardware vCPU when cpu->vcpu_dirty is set.

A vCPU that reached PSCI_OFF is left clean: its last hv_vcpu_run() exit
was a WFI or a cancel, and flush_cpu_state() cleared the flag. A later
CPU_ON then resets and re-points only the QEMU-side copy. The vCPU
resumes in its old context, with the old MMU state and vector table, and
never runs the requested entry point.

This shows up when a guest that already onlined and offlined its
secondary CPUs boots another kernel, for example kexec on Apple Silicon:
the new kernel logs "CPUn: failed to come online" for every secondary.
Fresh vCPUs are created dirty and single-CPU guests never issue CPU_ON,
so the ordinary boot path is unaffected.

Call cpu_synchronize_post_reset() after resetting the target, in both
arm_set_cpu_on_async_work() and arm_set_cpu_on_and_reset_async_work().
It is a no-op for TCG.

Signed-off-by: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ef14a1f8a9..e197a0ebda 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "system/tcg.h"
+#include "system/hw_accel.h"
 #include "target/arm/multiprocessing.h"
 #include "trace.h"
 
@@ -80,6 +81,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Start the new CPU at the requested address */
     cpu_set_pc(target_cpu_state, info->entry);
+    cpu_synchronize_post_reset(target_cpu_state);
 
     g_free(info);
 
@@ -189,6 +191,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
+    cpu_synchronize_post_reset(target_cpu_state);
     target_cpu_state->halted = 0;
 
     /* Finally set the power status */
-- 
2.54.0 (Apple Git-157)


