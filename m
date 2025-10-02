Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7869CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KWS-0001IS-R0; Thu, 02 Oct 2025 10:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4KWQ-0001IA-2C; Thu, 02 Oct 2025 10:43:06 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4KWI-0003p6-7D; Thu, 02 Oct 2025 10:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759416178; x=1790952178;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PIQW/7dCV76ZqB43MqKVv3Yw3r35T4rFvQT/xBp5Tfg=;
 b=lZw9eD+kE2nUlbgI++8j0JRL+ZYXYFdLDl/YdjvMQz28jF/J3NrumG73
 rLVHTEPXOHyznLyqivRbWvZzQKyQWK3e35/aLYqJR9Fq8CuOsKdtxJWoq
 aS/ozUdRgRfDo846aY4h61UQJth9QI04TRFsKeP5lJI2hJam+BL9BdXtY c=;
X-CSE-ConnectionGUID: AqNT9UY2Rd63r8V+MgYz3g==
X-CSE-MsgGUID: 0xxv6ZU4RI6vApO4v/mMUw==
X-IronPort-AV: E=Sophos;i="6.18,309,1751234400"; 
   d="scan'208";a="3132514"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 02 Oct 2025 16:42:41 +0200
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id 16D4E205A;
 Thu,  2 Oct 2025 16:42:41 +0200 (CEST)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH] system/runstate: remove duplicate in runstate transitions
Date: Thu,  2 Oct 2025 16:41:45 +0200
Message-ID: <20251002144145.209819-1-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove duplicate entry PRELAUNCH->INMIGRATE from runstate_transitions_def.
Move PRELAUNCH->SUSPENDED entry with all the other PRELAUNCH->XXX entries.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
---
 system/runstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..32467aa882 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -76,9 +76,6 @@ typedef struct {
 } RunStateTransition;
 
 static const RunStateTransition runstate_transitions_def[] = {
-    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
-    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
-
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
@@ -118,6 +115,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
     { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
-- 
2.48.1


