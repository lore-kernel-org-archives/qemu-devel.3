Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A46C112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNW-0004gc-J8; Wed, 11 Mar 2026 15:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNV-0004dJ-0t; Wed, 11 Mar 2026 15:37:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNT-0000V8-30; Wed, 11 Mar 2026 15:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=h/kUl/xQLmRb/S4svpv2ZTc8FHO1O9r77yc2rDjhLuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=orJfXSEZCR2n77QfXbVGqi99JCUy/DX6t6pAe1XbTz/sRlEkqDJvPi4JPvi4Chge3
 2NGkHm1pVNdcRrQJU5sxxL14zHDpTtbvFn2eNHNwidfIUNPXurUZls0VVYPAIQDGCu
 31KSGDrY5CprqHsmef52IQsGKekkdWX3sqENSdEz8Z14WIRX9yeRTsEiGpdD5U+oXl
 DAr0tRstGcgxFb2JcdC9ZKQXLHPc7aG8Q9UqsDiot/52Rv7VrA/qU24vAQXNL3WL8a
 nT/xOdiZQNhFZaPfcLGaSXp+/o1F3oClgblWAEZKsaQ4aFwB6n2bb3/dF+GhbbeLni
 y3NfMstSOrSlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D255F19210A;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1CAD037C46F;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 34/53] hw/net/smc91c111: Don't allow negative-length
 packets
Date: Wed, 11 Mar 2026 22:34:27 +0300
Message-ID: <20260311193449.1096110-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Maydell <peter.maydell@linaro.org>

The smc91c111 data frame format in memory (figure 8-1 in the
datasheet) includes a "byte count" field which is intended to be the
total size of the data frame, including not just the packet data but
also the leading and trailing information like the status word and
the byte count field itself.  It is therefore possible for the guest
to set this to a value so small that the leading and trailing fields
won't fit and the packet has effectively a negative area.

We weren't checking for this, with the result that when we subtract 6
from the length to get the length of the packet proper we end up with
a negative length, which is then inconsistently handled in the
qemu_send_packet() code such that we can try to transmit a very large
amount of data and read off the end of the device's data array.

Treat excessively small length values the same way we do excessively
large values.  As with the oversized case, the datasheet does not
describe what happens for this software error case, and there is no
relevant tx error condition for this, so we just log and drop the
packet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3304
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260226175549.1319476-1-peter.maydell@linaro.org
(cherry picked from commit d8e19f8042dcaff8e077292209c8196acb150bdd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 5cd78e334b..f2c2e22dd0 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -30,6 +30,12 @@
  * LAN91C111 datasheet).
  */
 #define MAX_PACKET_SIZE 2048
+/*
+ * Size of the non-data fields in a data frame: status word,
+ * byte count, control byte, and last data byte; this defines
+ * the smallest value the byte count in the frame can validly be.
+ */
+#define MIN_PACKET_SIZE 6
 
 #define TYPE_SMC91C111 "smc91c111"
 OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
@@ -289,7 +295,7 @@ static void smc91c111_do_tx(smc91c111_state *s)
         *(p++) = 0x40;
         len = *(p++);
         len |= ((int)*(p++)) << 8;
-        if (len > MAX_PACKET_SIZE) {
+        if (len < MIN_PACKET_SIZE || len > MAX_PACKET_SIZE) {
             /*
              * Datasheet doesn't say what to do here, and there is no
              * relevant tx error condition listed. Log, and drop the packet.
@@ -300,7 +306,13 @@ static void smc91c111_do_tx(smc91c111_state *s)
             smc91c111_complete_tx_packet(s, packetnum);
             continue;
         }
-        len -= 6;
+        /*
+         * Convert from size of the data frame to number of bytes of
+         * actual packet data. Whether the "last data byte" field is
+         * included in the packet depends on the ODD bit in the control
+         * byte at the end of the frame.
+         */
+        len -= MIN_PACKET_SIZE;
         control = p[len + 1];
         if (control & 0x20)
             len++;
-- 
2.47.3


