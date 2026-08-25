Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2978C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn5B-0007wr-5C; Tue, 25 Aug 2026 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn58-0007qt-00; Tue, 25 Aug 2026 05:04:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn56-0003Ho-8h; Tue, 25 Aug 2026 05:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=j6cbDxzaFstVh5z54P8+sUHoYnvvnaED/o6cjwnZ0dA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m91OrL3vv0VJBqS9ZgMCQOZDhdgpDvcwxZ/szlTfmmuyCmBc6gsu0DBNDoMLne6gd
 J9gN8USvnWjA9L7wkQgoq7A2/LAAWPC/pw1pDopgzdx5n2zB860TIkS7xTAPbBv9ho
 QRPEHWF+j6XQlFrk47tkAIYUeIEwkri99ULN2kVI7IfG9CKk38M4/sMb5T2xL1/OiK
 DWvQ4gFI942ZK2pmmvkzVPno8q7z7b8wI5w0PEIJgNhuk8+TIHvO8aZkZIzQ9U4+d5
 k3c7v9vnqcoIKtbci96AcOksInzQIcg9X4+M0ymqHk7JmwyJENqdZjPyHbW+rEx8M6
 kyrjp35Yvlemw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 889921CE3BD;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74D8341617F;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DDE7832563; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 huntr bubble <bubblehuntr@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 179/196] hw/watchdog: Add lower bound check for
 watchdogNumber
Date: Tue, 25 Aug 2026 12:01:36 +0300
Message-ID: <20260825090157.471948-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
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

From: Chinmay Rath <rathc@linux.ibm.com>

Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.

Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260818104551.76023-1-rathc@linux.ibm.com
[harshpb: corrected title prefix to hw/watchdog]
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit eea4de1bd8e8bdaa9a69b130a1a154f7c113979f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 5b3f50de3a1..5a72896066e 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -127,6 +127,12 @@ static void watchdog_expired(void *pw)
     }
 }
 
+static inline bool watchdog_number_valid(target_ulong watchdogNumber,
+                                        SpaprMachineState *spapr)
+{
+    return watchdogNumber >= 1 && watchdogNumber <= ARRAY_SIZE(spapr->wds);
+}
+
 static target_ulong h_watchdog(PowerPCCPU *cpu,
                                SpaprMachineState *spapr,
                                target_ulong opcode, target_ulong *args)
@@ -145,7 +151,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
 
     switch (operation) {
     case PSERIES_WDTF_OP_START:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (!watchdog_number_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         if (timeoutInMs <= WDT_MIN_TIMEOUT) {
@@ -170,11 +176,11 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
     case PSERIES_WDTF_OP_STOP:
         if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
             ret = watchdog_stop_all(spapr);
-        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
+        } else if (!watchdog_number_valid(watchdogNumber, spapr)) {
+            return H_P2;
+        } else {
             ret = watchdog_stop(watchdogNumber,
                                 &spapr->wds[watchdogNumber - 1]);
-        } else {
-            return H_P2;
         }
         break;
     case PSERIES_WDTF_OP_QUERY:
@@ -184,7 +190,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
         trace_spapr_watchdog_query(args[0]);
         break;
     case PSERIES_WDTF_OP_QUERY_LPM:
-        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
+        if (!watchdog_number_valid(watchdogNumber, spapr)) {
             return H_P2;
         }
         args[0] = PSERIES_WDTQL_QUERY_NOT_STOPPED;
-- 
2.47.3


