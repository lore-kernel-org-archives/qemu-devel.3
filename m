Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A431125893
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLM-0007ax-NJ; Wed, 11 Mar 2026 15:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKz-0007Tw-Vx; Wed, 11 Mar 2026 15:35:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKy-000071-CZ; Wed, 11 Mar 2026 15:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257666; bh=cfcf1z7/JpS4xZDWqSxPZgHSdgbv846o0KdJ0aeJQi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gtdJY8fRMZ46i44DRuu4sCX7bZRHPGKxlKkBfqg54dir/IPZTq3nP6HaL18EQ9Zjw
 CZOfVwZmYCHV+J5yf2egc83yHAUaDjdEn/GC6OQPeDLNHLM5+jCsirxDPOPevcsbTP
 ji6PGAwhgnof+XQdu19QfY1rrfawTDMcQGTaGrBIBHyPjDq4oEAp5FOxpS4YHkTVa8
 YS0Tff/tIzN1Xje1DTqYiUqyxMGeakFSsGcee3jqKwO6bHiwvet8AaPo26fncRhqYB
 PAPYMz9c7HGEUn//viZE8eBMJWAUm0rHgtvKYhWnEPKVLH0yuWajCiBpfo4I3HQCIy
 rkpB3e6LNhNlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91C2C1920EF;
 Wed, 11 Mar 2026 22:34:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4E9B37C454;
 Wed, 11 Mar 2026 22:35:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 07/53] contrib/plugins/hotblocks: Fix off by one error
 in iteration of sorted blocks
Date: Wed, 11 Mar 2026 22:34:00 +0300
Message-ID: <20260311193449.1096110-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Alex Bradbury <asb@igalia.com>

The logic to iterate over the hottest blocks will never reach the last
item in the list, as it checks `it->next != NULL` before entering the
loop. It's hard to trigger this off-by-one error with the default
limit=20, but it is a bug and is problematic if that default is changed
to something larger.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f1ba2e57c6126472c0c8310774009f2455efc370.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit 1c1e45fcd66269f8a6dbd97fd7b8267d8f6f58af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index d3dd23ed9f..cf4d6b8c36 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -82,10 +82,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (sorted_counts) {
-        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-- 
2.47.3


