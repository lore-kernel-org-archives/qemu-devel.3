Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968E4C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylHG-0002Qg-T0; Tue, 25 Aug 2026 03:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHF-0002QF-QJ; Tue, 25 Aug 2026 03:08:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHE-0006D3-4M; Tue, 25 Aug 2026 03:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=tyfp9u0TQ8Q5yYb517mQhYepguq1pPlz4ukGiaFhGxE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W2CQOWpIKCMopwHe4Z59XExu1tiUwkZA25WR8IGFLrH1WnA+aPpmyW5dakvoNRa+N
 B2hWYwClyITGux6b5hIPIFHTYzqo1kfBEEG+rUd5u766YTCWdo8Vw50JKeHNKR07yH
 iccccOlJGUgKeTQKXfc5cBSjbctolgXWj/QIEwflANDPwxFAFAyWBI99QYchPtBI3M
 RuYETr5z9nuymVEO9LkYmrNdVEEt+2U6daVKBNw9sJ6bxkwFp0Qr3r47oV9XQseM7o
 HSPFmfwhBYQI6t7zDeRz+JpPRHE8ADr3mWvPusVU3PzX0AB3MQGaiEqZqbh3/UAbGE
 4mfieGYOEpVBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5C7EC1CE226;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 210B2415FA1;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A64B73242C; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 65/91] whpx: i386: enable fast hypercall output
Date: Tue, 25 Aug 2026 10:05:37 +0300
Message-ID: <20260825070619.174584-23-mjt@tls.msk.ru>
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

Already enabled on Arm so extending it to x86.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3bfcd8ef6bd26cb80175f40f60e67bc6f42fa0a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d5428219..1800ba8eb19 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3247,6 +3247,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
     synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
-- 
2.47.3


