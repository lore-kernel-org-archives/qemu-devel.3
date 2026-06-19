Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE2CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTgt-0003tl-Fs; Fri, 19 Jun 2026 03:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1waTgj-0003se-U7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:30:57 -0400
Received: from p-east2-cluster5-host1-snip4-2.eps.apple.com ([57.103.79.5]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1waTgi-0000FJ-GX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:30:53 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 7323718005BB; Fri, 19 Jun 2026 07:30:50 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQxYWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcDlsFQwlMAkMOWQZFCFUCQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781854251; x=1784446251; bh=q7/G1vhckPk3ru9Atocd2/3+TuLYRzClUDmYsQ38zOk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=pxSN01jTMczjWdjzxv3sjNr1Xgz6USMauVxxNnalzDV4UCCXsTllO6rMIPsiMalkxsTH0MxYCqThvDcGaKAcFexQjUZ3pkqRCvXGUcxnMdxHbHAjQ/feQ4duY4MjD3RMCMvoqIOom23QFUQE1+wEdj/66WWbo2XVHin+At+E/X5bXOkzrffEmHDkePTKplI1FCKFZsUMmuyzwY1BFgq4lgss3fZJlpw7J3kbzYfxMz1HJ1JjzKEGl/QHzUGP579paXxGOuVUpmyAhGv2nSkWLY0a/uGnOv8FIPfqYY2B7tQVokxph2aWSSOeRckYC8Umv+lk2BVeecraK/svKGXiMQ==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 99D571800BC2; Fri, 19 Jun 2026 07:30:49 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH] target/m68k: handle EXCP_SEMIHOSTING in (non-ColdFire) m68k
Date: Fri, 19 Jun 2026 03:30:41 -0400
Message-ID: <20260619073041.92451-1-mhjacobson@me.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2OCBTYWx0ZWRfX5meYDdi51hv7
 vNLeku8aE8twX9UW+Ke80aJ3fXZWkOQSP3SmrjqdG/2Ww9o3qGxeTZomdoEVNtIztfkLxOd8Ibh
 rkYXpIaHTATx0NAOj1AMI8CniX/TWjwLeYBMDb7zHm5xpF8exBePnZeO3acEhzh33+9Xrj1ziOG
 VlX1hFpqBUkvu4MXml0mQltKyCqGg4iPMrCHxEMa5F+s1HEAi6F0yfiY762r7H1VleAGPX2FSxM
 0NXAalyLHxWMwdXPvqXRiDh6gGiHATrF6loBB9i3vzQwuvX6nXe4Sv7+w76KbHojElK0M9LfF1h
 z/pTFQuwNZLEHidBYrg
X-Proofpoint-ORIG-GUID: tETnOjIcjFc00OrJiuWjPAiKwdtn0FTk
X-Proofpoint-GUID: tETnOjIcjFc00OrJiuWjPAiKwdtn0FTk
Received-SPF: pass client-ip=57.103.79.5; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 0815c228bd1 attempted to enable semihosting support for non-
ColdFire m68k.  But in `do_interrupt_all()`, we take a different path
for regular m68k, and that path did not recognize EXCP_SEMIHOSTING.  Fix
that by adding equivalent code to `m68k_interrupt_all()`.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 target/m68k/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e..be77b8d567 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -305,6 +305,10 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             m68k_rte(env);
             return;
+        case EXCP_SEMIHOSTING:
+            do_m68k_semihosting(env, env->dregs[0]);
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
+            return;
         }
     }
 
-- 
2.54.0


