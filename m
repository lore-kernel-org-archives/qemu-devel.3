Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E061061B08
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0t-0000nN-2N; Mon, 30 Mar 2026 17:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0q-0000mB-D6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:08 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0o-0003iL-LT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 18DFE6013E;
 Mon, 30 Mar 2026 21:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5498C4CEF7;
 Mon, 30 Mar 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905545;
 bh=AuICZFWN7vigdzNA1Ykm1FWkoI02fhhCrYU1xOdsHC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kQY+tSUh+dh26BlgdC1CMLG2grO8iloisB2hci2s0qsjTI0SFCrabm2Cxv3CcrEHz
 erbU63H4/bFAZGZwPL6dN+ixjBSEcbLaMXsOO6PTto7CFIxxGblqFhlOF8gwMGd5rE
 13s0PQANQPgVPzsuTr5nQaOkK2HdRhPai4XQjHTyCPZMFRP+QEBVrfqiu2BEwRnr1e
 aT4SkgcxmF2PIZeBsiE83TPT9R8f7BOWEupo9z1SxkLrdx56K9kRL6ff8FhEEIkF+I
 +iU9SuDsCFmDOwfzwmJ1RVICLzHVwvIBOtrP991I6rjM6pr9YFCPTubnP2ZNAWRwAF
 szpzwfXAWmuCw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 03/11] hw/pci-host/astro: Make astro address arrays accessible
 for other users
Date: Mon, 30 Mar 2026 23:18:50 +0200
Message-ID: <20260330211859.19317-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Move the tables out of astro_realize(). This is needed because follow-up
patches will need those tables.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 59d8007a1a..6a09dc15e7 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -37,6 +37,11 @@
 #include "qom/object.h"
 #include "exec/target_page.h"
 
+static const int elroy_hpa_offsets[ELROY_NUM] = {
+            0x30000, 0x32000, 0x38000, 0x3c000 };
+static const char elroy_rope_nr[ELROY_NUM] = {
+            0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
+
 /*
  * Helper functions
  */
@@ -843,10 +848,6 @@ static void astro_realize(DeviceState *obj, Error **errp)
 
     /* Create Elroys (PCI host bus chips).  */
     for (i = 0; i < ELROY_NUM; i++) {
-        static const int elroy_hpa_offsets[ELROY_NUM] = {
-                    0x30000, 0x32000, 0x38000, 0x3c000 };
-        static const char elroy_rope_nr[ELROY_NUM] = {
-                    0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
         int addr_offset;
         ElroyState *elroy;
         hwaddr map_addr;
-- 
2.53.0


