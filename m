Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C69CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNl5-0002JZ-19; Wed, 24 Jun 2026 09:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNkw-0001bE-3Z; Wed, 24 Jun 2026 09:35:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNku-0000b0-FQ; Wed, 24 Jun 2026 09:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=WG1eqqDRC0XESaMjrceBdpmpNaVRXVi8x92Ta+mAlxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EfGWzT3I+606jrNcx5IkjA5fX6Qhs/+T2gPLuhIcEd101t8NifcrgVSgIjx+BQd79
 irCcJwOp/2bpcqSesjILxvl/EujH0vmPOtUwoIi47i2k/ayRgB3l1syuPgVz/LxOzF
 gsr7BZu8G5elc/wvBUWdmP0aVK/oPsOPoanDNSwd1EHJJ7Uv0bgQeYuqj4kMf8Gmp1
 nxnftsJUpRc2+y/xNVLpIC7g6sNeTNkKbQe4tS2GZNBdVODFa2zGB59ml2aP6HiY+a
 I1sv75sS3DwWeyRw6oqSaVtJZiqh0VA8KsLXmlDkeq9rSRC475sLegCmIjg6kbjwRN
 M/REJFW4SvFPw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C28E91BA9CA;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 600633DEA19;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Che Kao <skps96g313.cs10@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 024/107] apic: fix delivery bitmask with modified
 xAPIC ids
Date: Wed, 24 Jun 2026 16:30:29 +0300
Message-ID: <20260624133301.403266-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed00b9..ced7df49bd 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -648,13 +648,6 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
     g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
-    uint32_t current_apic_id;
-
-    if (is_x2apic_mode(s)) {
-        current_apic_id = s->initial_apic_id;
-    } else {
-        current_apic_id = s->id;
-    }
 
     switch (dest_shorthand) {
     case 0:
@@ -662,14 +655,20 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
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


