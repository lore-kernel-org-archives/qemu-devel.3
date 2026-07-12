Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E1C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiliW-0006KL-7O; Sun, 12 Jul 2026 00:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiliD-00069j-CE; Sun, 12 Jul 2026 00:22:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiliB-0007MD-NE; Sun, 12 Jul 2026 00:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=LUsT4hMutUyFKLtzirU44K1z143A6xYWET/Tns34LWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nh5GTvjf7M8mC/EwOU42Yv9jAQAvA0JOcVmLy7rLkLET1NaO9MPjq1s9xBdluBpen
 jfTwTgjI2pihPaVdgOzvk0iulipiNdvHRSjdkIFAX84i7Rdkzwbp55OjqiZa/C4UFv
 bzJk6Ppio+VExPTd2IlVKbdlKPO76y1zD0gMOCWyQI/NLFpDbbykZvCJGEj6WgSJn+
 BLIeagVqMh2BNMAEjr+NLGRs9O8TNlW3cPSNK05psuKuChWBciVvHsyAxh0pzjPMfh
 hOXHjdNpTjQ784Hn6Se+//jAK1/aR4DVVN55iLx66LuJ4d/vi3aTNckmEhJyDypKvK
 zkGg5QoUXmnyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5CEB61C0C20;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9128F3EB980;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B980013443; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Jim Shu <jim.shu@sifive.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 69/75] hw/riscv: riscv-iommu: Don't look up DDT cache
 in Off and Bare modes
Date: Sun, 12 Jul 2026 07:15:27 +0300
Message-ID: <20260712041539.108341-69-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

According to the RISC-V IOMMU specification:

* When ddtp.iommu_mode is set to Off, there is no DDT look-up, and an "All
  inbound transactions disallowed" fault (cause = 256) is reported for any
  inbound transaction.

* When ddtp.iommu_mode is set to Bare, there is no DDT look-up, and the
  translated address is the same as the IOVA, unless the transaction type
  is disallowed (cause = 260).

In the current implementation, the DDT cache is incorrectly looked up
even when ddtp.iommu_mode is set to Off or Bare. This may result in
unintended cache hits.

Therefore, the DDT cache must not be looked up when ddtp.iommu_mode is
set to Off or Bare. For other modes, software is required to issue cache
invalidation commands before any inbound transactions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Message-ID: <20251028085032.2053569-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 15406cc593a76f075f23e4113b2723190e6a0d1a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 8e649b77752..f11698f02f0 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1404,13 +1404,18 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
         .devid = devid,
         .process_id = process_id,
     };
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
 
     ctx_cache = g_hash_table_ref(s->ctx_cache);
-    ctx = g_hash_table_lookup(ctx_cache, &key);
 
-    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
-        *ref = ctx_cache;
-        return ctx;
+    if (mode != RISCV_IOMMU_DDTP_MODE_OFF &&
+        mode != RISCV_IOMMU_DDTP_MODE_BARE) {
+        ctx = g_hash_table_lookup(ctx_cache, &key);
+
+        if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
+            *ref = ctx_cache;
+            return ctx;
+        }
     }
 
     ctx = g_new0(RISCVIOMMUContext, 1);
-- 
2.47.3


