Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8D1CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUQJ-0003T4-GT; Sat, 13 Jun 2026 15:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPX-0001Uw-7D; Sat, 13 Jun 2026 15:52:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUPU-0003oK-7a; Sat, 13 Jun 2026 15:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380259; bh=9cd+qIqqRsoqAEtIChB5CVkGwSasCRBjXO/60eZXsRQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gI8f/Ph7AEMQGxKIPLr/bJjR3+LRnxoUHtrPjiKA7whu54NHiIU0D+cnzSyALyxYj
 F+FUg2Gph3qMHOsAinMXaMJ53Z+yh5OSFl8Atv+BSINm4YIte1AD5I3egI3QhEoZIU
 jGJOCb9qOz7/LmmugDzmJ2+5mGoD/2d08nsj4Jqa7R4J6+Nw0bx5G6HR+udegg/I0h
 gsr/JFDpU4Wj2I1xLvrsnBkwzNhDBc/cuttKoiXdfu0gGVHPuBiEPTYV0B9BCVAg5+
 6MMl7doExxPE1c8WsPV1hgfkgWVMy9r9aRDa/BcPPilLUBZruWDHW5T9kxYExyUUxB
 FRG3VbsyXdNtg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 311BE1B6E23;
 Sat, 13 Jun 2026 22:50:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89EAA3CE89D;
 Sat, 13 Jun 2026 22:51:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Che Kao <skps96g313.cs10@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 20/56] apic: fix delivery bitmask with modified xAPIC
 ids
Date: Sat, 13 Jun 2026 22:50:34 +0300
Message-ID: <20260613195116.1807273-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Self-IPIs (or all-but-self IPIs) in QEMU can cause a out-of-bounds access
to deliver_bitmask, because the access uses the APIC ID register which
is writable by the guest.  However, foreach_apic uses the delivery
bitmask indexes to look up the local_apics[] array, which is indexed
by *initial* APIC id.  Using the right id fixes both a possible heap
write overflow if the modified APIC id is too large for max_apic_words,
and a mis-delivery of both self and all-but-self IPIs.

Reported-by: Wei Che Kao <skps96g313.cs10@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 153dc2fa7bbe0491290d22c4bbb6807074f24260)
(Mjt: fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index b2a2b671b0..108fde5d5f 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -659,13 +659,6 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
     g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
-    uint32_t current_apic_id;
-
-    if (is_x2apic_mode(dev)) {
-        current_apic_id = s->initial_apic_id;
-    } else {
-        current_apic_id = s->id;
-    }
 
     switch (dest_shorthand) {
     case 0:
@@ -673,14 +666,20 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
         break;
     case 1:
         memset(deliver_bitmask, 0x00, deliver_bitmask_size);
-        apic_set_bit(deliver_bitmask, current_apic_id);
+        /*
+         * The self and all-but-self cases do not use apic_match_dest() and
+         * directly fill in deliver_bitmask; the bitmask's indexes in turn
+         * map to local_apics[] slots which are never changed even if the
+         * xAPIC id is modified.  So use s->initial_apic_id instead of s->id.
+         */
+        apic_set_bit(deliver_bitmask, s->initial_apic_id);
         break;
     case 2:
         memset(deliver_bitmask, 0xff, deliver_bitmask_size);
         break;
     case 3:
         memset(deliver_bitmask, 0xff, deliver_bitmask_size);
-        apic_reset_bit(deliver_bitmask, current_apic_id);
+        apic_reset_bit(deliver_bitmask, s->initial_apic_id);
         break;
     }
 
-- 
2.47.3


