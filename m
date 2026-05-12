Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD62CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLf-0003q5-TG; Tue, 12 May 2026 17:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKs-00013s-9H; Tue, 12 May 2026 17:08:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKo-0002gE-Gn; Tue, 12 May 2026 17:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=6YQO22w3Zwbye/yy8vSPsyzOejOaTOYJPzkrPIetztY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kXDjNdGTbUcHV9qZuIzbUFtc5UNum4UtTkfgXQ8om4lLs1iEw2EzgtW01yjyL4Fcz
 Vdn5tGUbshoFhy1VxEcxLKjmaKVfPrBBwhZM4+UPZNj2QoWHXkS8oqqsoNvBqCTGiL
 eUMSIscCzlaLCZKRQaFXL5R1Zz+gK7wrE4TiX7X7R45rEFtJ93aOBZRL8d/Jj82xOS
 gUGglybBHAay7y3hzOf/EDxOO/OtORU4l7lInJVEUAabUUpwPLnfn9j3xEMaOmm9VM
 hf50EIcJkThirSpmlrzHByWZhyckm+tHZxyusbYlBPgu/22CeySLQLxBQ7ZvYY9ErW
 qEfceXcu2b9Ng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 54A731AA355;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60CCA3ABCC5;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jose Martins <josemartins90@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 024/117] target/arm: fix s2prot not set for two-stage
 PMSA translations
Date: Tue, 12 May 2026 23:53:26 +0300
Message-ID: <20260512205503.361097-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Jose Martins <josemartins90@gmail.com>

Commit a811c5dafb7 ("target/arm: Implement get_S2prot_indirect")
changed get_phys_addr_twostage() to combine stage 1 and stage 2
permissions using the new s2prot field:

  result->f.prot = s1_prot & result->s2prot;

The LPAE stage 2 path sets result->s2prot explicitly, but the PMSA
stage 2 path (get_phys_addr_pmsav8) only sets result->f.prot, leaving
s2prot at zero. This causes the combined permission to be zero,
resulting in addr_read being set to -1 in the TLB entry and triggering
an assertion in atomic_mmu_lookup() when the guest executes an atomic
instruction on a two-stage PMSA platform (e.g. Cortex-R52 with EL2).

Set s2prot from f.prot after the PMSA stage 2 lookup, consistent with
what the LPAE path does.

Cc: qemu-stable@nongnu.org
Fixes: a811c5dafb7 ("target/arm: Implement get_S2prot_indirect")
Signed-off-by: Jose Martins <josemartins90@gmail.com>
[PMM: refer to the right commit in the commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260321231916.2852653-1-josemartins90@gmail.com
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 32ebd6c09c18f860671030060cfedabd94c846fb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e6b149b2d..b2ae00b89e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3210,6 +3210,13 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
 
     ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
+    /*
+     * For two-stage PMSA translations, s2prot holds the stage 2
+     * permissions to be combined with stage 1 in get_phys_addr_twostage().
+     */
+    if (regime_is_stage2(mmu_idx)) {
+        result->s2prot = result->f.prot;
+    }
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
-- 
2.47.3


