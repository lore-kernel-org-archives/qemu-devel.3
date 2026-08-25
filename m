Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EBC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylHL-0002kq-19; Tue, 25 Aug 2026 03:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHJ-0002YU-09; Tue, 25 Aug 2026 03:09:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHH-0006HZ-7p; Tue, 25 Aug 2026 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=cMPM4SXqtKvFy289cDmkgXeZTgIQAVjZqjhkVipjcTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ojS7eWQc8Wt8HU12xKoKPQknUW62KiGqdcrrB1gA84qCJPviueH+U9tpkTxM6zyjn
 QrC1X47I15ee6WNfeSSQK8+KWPPtvc1O74I7D8zl7wrq2gGMZWpIvWFpSIpXteZax0
 K8UnSqUY9tLnAUrJo+CevNd504Ft+sa36BpJVMdT8VDBoj455EwCkbN+c2LqU+GU8U
 Q8n0VPCdUQFEsqqHKGNtYG5q1QPuRKcw2GhuqSR31m07CK4ZzZBaH0+DzJ6+es7zc+
 QvPGM+EXIPadT4K0T138JfH9QpWSmJ66T8gxJ8CXB+xFMjiRMWUHNZ3FfjKg2QXd2S
 NOlEI1NZcHzFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 664441CE228;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2AFCC415FA3;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AC20132430; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 67/91] whpx: i386: work around Hyper-V FP state
 oddities
Date: Tue, 25 Aug 2026 10:05:39 +0300
Message-ID: <20260825070619.174584-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

On Hyper-V looks like we need to fetch both the legacy
and new state instead of being able to rely on xsave.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 37ce6d8da75754f725db8cc27ae6c82a2e5b930e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2739a80da36..56a8b167497 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -614,9 +614,9 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
         if (whpx_is_xsave_enabled(cpu)) {
             whpx_set_xsave_state(cpu);
-        } else {
-            whpx_set_legacy_fp_registers(cpu, level);
         }
+        whpx_set_legacy_fp_registers(cpu, level);
+
         /* MSRs */
         assert(whpx_register_names[idx] == WHvX64RegisterEfer);
         vcxt.values[idx++].Reg64 = env->efer;
@@ -950,9 +950,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     if (whpx_is_xsave_enabled(cpu)) {
         whpx_get_xsave_state(cpu);
-    } else {
-        whpx_get_legacy_fp_registers(cpu, level);
     }
+    whpx_get_legacy_fp_registers(cpu, level);
 
     /* MSRs */
     assert(whpx_register_names[idx] == WHvX64RegisterEfer);
-- 
2.47.3


