Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C651DCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJD-00070z-Kr; Tue, 12 May 2026 17:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJ9-0006l4-BU; Tue, 12 May 2026 17:06:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJ7-0001Lp-6M; Tue, 12 May 2026 17:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=AKuaDRIW6j3SW5LAWBenlZTyf8BzwdYYtuCqvrmpQAA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a+Ci7sQtJqCg5nwD+6MB4AW55xpuYR6Ej15dTCi6/UjO5H1PfuZw4keCUvNkHCMRk
 +Hpg50+M/517ggUhrNGibVDlCSx1xfVjCTQzk2tnremuDDtdzaCkcga+WHKaVHw6UN
 pqhwbljn252QlR6FaWz/UsfW85nUhZpn5KDB+yHnpKvRqSRXz9qQYyrGEOC/3wdhjy
 a4dMobHWBNPBXUqGXYCy2qo/DNHldaJXpTmwf178t1l+1R3DGWMzmx+2sW4/6YBGkr
 Pcng4OlvhoWspap9+Ts6fkhqZvgLxPzq1pMXKCsyAqDVnOs4MH/SRqY3V0F+sIo80f
 /SG4H7A+2p5fw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 216C61AA342;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2E23B3ABCB3;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tao Ding <dingtao0430@163.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 006/117] hw/dma/pl080: Ignore bottom 2 bits of LLI
 register
Date: Tue, 12 May 2026 23:53:08 +0300
Message-ID: <20260512205503.361097-6-mjt@tls.msk.ru>
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

From: Tao Ding <dingtao0430@163.com>

The PL080 channel LLI (linked list item) register has bits [31:2] of
the address of the next LLI in bits [31:2], with bit [1] reserved
and bits [0] the AHB master select. We were incorrectly using the
whole register value as the address, which meant that if the guest
programmed something into the AHB master select bit we would use
an incorrect address, and read incorrect data from memory.

The following reproducer creates a setup which has bit 0 set in
an LLI value:

Configuration
    ../configure --target-list=arm-softmmu --enable-debug
Reproducer
    ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
     -device loader,addr=0x00002000,data=0x00000004,data-len=4 \
     -device loader,addr=0x00002004,data=0x00001004,data-len=4 \
     -device loader,addr=0x00002008,data=0x00000000,data-len=4 \
     -device loader,addr=0x0000200c,data=0x9e4bf001,data-len=4 \
     -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
     -device loader,addr=0x00000004,data=0x88776655,data-len=4 \
     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
     -device loader,addr=0x00001004,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
     -device loader,addr=0x10130108,data=0x00002001,data-len=4 \
     -device loader,addr=0x1013010C,data=0x1e4bf001,data-len=4 \
     -device loader,addr=0x10130110,data=0x0000c001,data-len=4

The correct result with this bug fix:
    (qemu) xp /1wx 0x00001000
     00001000: 0x44332211
    (qemu) xp /1wx 0x00001004
     00001004: 0x88776655

Cc: qemu-stable@nongnu.org
Signed-off-by: Tao Ding <dingtao0430@163.com>
[PMM: Adjusted commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: cb35c1b622674da7a2b70691402132f691933f2c.1773301927.git.dingtao0430@163.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f9b16f791502d912cf07ec040a1a2efb1009f713)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3af50425ef..18f5de3e04 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -102,6 +102,7 @@ static void pl080_run(PL080State *s)
     int size;
     uint8_t buff[4];
     uint32_t req;
+    uint32_t next_lli;
 
     s->tc_mask = 0;
     for (c = 0; c < s->nchannels; c++) {
@@ -198,21 +199,22 @@ again:
             ch->ctrl = (ch->ctrl & 0xfffff000) | size;
             if (size == 0) {
                 /* Transfer complete.  */
-                if (ch->lli) {
+                next_lli = (ch->lli & ~3);
+                if (next_lli) {
                     ch->src = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli,
+                                                   next_lli,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                     ch->dest = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 4,
+                                                    next_lli + 4,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->ctrl = address_space_ldl_le(&s->downstream_as,
-                                                    ch->lli + 12,
+                                                    next_lli + 12,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
                     ch->lli = address_space_ldl_le(&s->downstream_as,
-                                                   ch->lli + 8,
+                                                   next_lli + 8,
                                                    MEMTXATTRS_UNSPECIFIED,
                                                    NULL);
                 } else {
-- 
2.47.3


