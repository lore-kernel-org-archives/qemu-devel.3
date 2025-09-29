Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B4CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8D-0003R3-Hf; Mon, 29 Sep 2025 12:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7U-0002qf-NT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7R-0002mA-4o
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vw7RXbm6oXQ19RPoCazwzBKF0I2KryYmUCQShU7ihfc=;
 b=g/JLp3jknO9jtDn0qNi+9YXKuUZCetqNgGhRQyfYIhqbfOSytpiyS79EZUmCIjYy5x35qs
 iZGBnBue362+bhT7PrveJ0ulngl9KYQi3wwZITk+BxYsRoFF7sL25yZXsllq8tNiJArG/E
 gz292cymMzh9+zzIXEd3satr7mQkSaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-LhGk4VMMMlKPcAsIqGoyuQ-1; Mon,
 29 Sep 2025 12:52:50 -0400
X-MC-Unique: LhGk4VMMMlKPcAsIqGoyuQ-1
X-Mimecast-MFC-AGG-ID: LhGk4VMMMlKPcAsIqGoyuQ_1759164769
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D408319560B9; Mon, 29 Sep 2025 16:52:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C38B18019D9; Mon, 29 Sep 2025 16:52:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/32] hw/nvram/aspeed_otp: Add OTP programming semantics and
 tracing
Date: Mon, 29 Sep 2025 18:52:03 +0200
Message-ID: <20250929165230.797471-6-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Implement correct OTP programming behavior for Aspeed OTP:
- Support read-modify-write flow with one-way bit programming:
  * prog_bit uses 0s as the "to-be-programmed" mask.
  * Even-indexed words: 0->1, odd-indexed words: 1->0.
  * Reject non-programmable requests and log conflicts.
- Enable unaligned accesses in MemoryRegionOps.
  Since each OTP address maps to a 1DW (4B) or 2DW (8B) block in the
  backing store, upper-layer accesses may be unaligned to block
  boundaries.

This matches the irreversible, word-parity-dependent programming rules
of Aspeed SoCs and exposes changes via QEMU trace events.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-6-kane_chen@aspeedtech.com
[ clg: Fixed PRIx64 format in aspeed_otp_write() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/nvram/aspeed_otp.c | 80 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvram/trace-events |  5 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index abb37318231b..dcf8ed3917e2 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -12,6 +12,7 @@
 #include "system/block-backend.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/aspeed_otp.h"
+#include "hw/nvram/trace.h"
 
 static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -23,12 +24,87 @@ static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
     return val;
 }
 
+static bool valid_program_data(uint32_t otp_addr,
+                                 uint32_t value, uint32_t prog_bit)
+{
+    uint32_t programmed_bits, has_programmable_bits;
+    bool is_odd = otp_addr & 1;
+
+    /*
+     * prog_bit uses 0s to indicate target bits to program:
+     *   - if OTP word is even-indexed, programmed bits flip 0->1
+     *   - if odd, bits flip 1->0
+     * Bit programming is one-way only and irreversible.
+     */
+    if (is_odd) {
+        programmed_bits = ~value & prog_bit;
+    } else {
+        programmed_bits = value & (~prog_bit);
+    }
+
+    /* If any bit can be programmed, accept the request */
+    has_programmable_bits = value ^ (~prog_bit);
+
+    if (programmed_bits) {
+        trace_aspeed_otp_prog_conflict(otp_addr, programmed_bits);
+        for (int i = 0; i < 32; ++i) {
+            if (programmed_bits & (1U << i)) {
+                trace_aspeed_otp_prog_bit(i);
+            }
+        }
+    }
+
+    return has_programmable_bits != 0;
+}
+
+static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
+                             uint32_t prog_bit, uint32_t *value)
+{
+    AspeedOTPState *s = opaque;
+    bool is_odd = otp_addr & 1;
+    uint32_t otp_offset = otp_addr << 2;
+
+    memcpy(value, s->storage + otp_offset, sizeof(uint32_t));
+
+    if (!valid_program_data(otp_addr, *value, prog_bit)) {
+        return false;
+    }
+
+    if (is_odd) {
+        *value &= ~prog_bit;
+    } else {
+        *value |= ~prog_bit;
+    }
+
+    return true;
+}
+
 static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
                                 uint64_t val, unsigned size)
 {
     AspeedOTPState *s = opaque;
+    uint32_t otp_offset, value;
 
-    memcpy(s->storage + otp_addr, &val, size);
+    if (!program_otpmem_data(s, otp_addr, val, &value)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to program data, value = %x, bit = %"PRIx64"\n",
+                      __func__, value, val);
+        return;
+    }
+
+    otp_offset = otp_addr << 2;
+    memcpy(s->storage + otp_offset, &value, size);
+
+    if (s->blk) {
+        if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to write %x to %x\n",
+                          __func__, value, otp_offset);
+
+            return;
+        }
+    }
+    trace_aspeed_otp_prog(otp_offset, val, value);
 }
 
 static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
@@ -63,6 +139,8 @@ static const MemoryRegionOps aspeed_otp_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
+    .valid.unaligned = true,
+    .impl.unaligned = true
 };
 
 static void aspeed_otp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 5e33b24d47a0..7084bf70d35f 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# aspeed_otp.c
+aspeed_otp_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memory program: addr 0x%" PRIx32 " prog_value 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_otp_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
+aspeed_otp_prog_bit(int bit) "Programmed bit %d"
+
 # ds1225y.c
 nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
 nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"
-- 
2.51.0


