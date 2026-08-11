Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81285C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOE-0003bo-5d; Tue, 11 Aug 2026 12:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO3-0002qt-Lq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO1-0000qE-G2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LnCEW2auQdJGkvSQ2FNmgFVboxImzb7hpqDK1PAa5A=;
 b=hHcdDZ+ddRW7aChkHzu+J7LOaUBp49VKzoOoL28mW2e6y7Jdlr9IbMARwjSS5qn42sDzi3
 reGVsD/FETGw7VgHqjjFVmdTG4Owf5cLbTPqNrhV6nNSMfyPV+AxxdPs6IH45XxitSL7pc
 xQpGS0bwGHy/9R1BGGStPrnJOniuZs8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-S1S4mngtPvSMBWqSm005tQ-1; Tue,
 11 Aug 2026 12:31:26 -0400
X-MC-Unique: S1S4mngtPvSMBWqSm005tQ-1
X-Mimecast-MFC-AGG-ID: S1S4mngtPvSMBWqSm005tQ_1786465884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3925195604B; Tue, 11 Aug 2026 16:31:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFD91195DF98; Tue, 11 Aug 2026 16:31:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 47/83] tests/qtest: pca9552: test behaviour specific to the LED
 variant
Date: Tue, 11 Aug 2026 18:29:02 +0200
Message-ID: <20260811162938.1403216-48-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The PCA9552 shares its device model with the PCA9535/PCA9555 GPIO
expanders but decodes registers differently. Add tests for the behaviour
that is specific to the LED variant and diverges from the PCA9555:

  - the power-on reset defaults of the prescaler, PWM and LED-selector
    registers;
  - the prescaler/PWM registers (2-5), which are OUTPUT/POLARITY on the
    PCA9555, as plain read/write storage;
  - the auto-increment, which only advances when the AI command bit is set
    and wraps modulo the full 10-register map (rather than toggling bit 0
    within a register pair);
  - the 4-bit command decode, where an out-of-range register reads back
    0xFF instead of aliasing into the register window.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-14-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9552-test.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index 747495769239..3718dfbd2277 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -77,6 +77,76 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0xEF);
 }
 
+/* Verify the power-on reset defaults. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    /* Prescalers, PWM duty cycles and LED selectors (all LEDs off) */
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM0), ==, 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM1), ==, 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS0), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS1), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS2), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS3), ==, 0x55);
+
+    /* All LEDs off, so every pin floats high through its pull-up */
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT1), ==, 0xFF);
+}
+
+/*
+ * The PCA9552 only advances the command pointer when the AI bit is set, and
+ * it wraps modulo the full 10-register map.
+ */
+static void test_autoinc_requires_ai_bit(void *obj, void *data,
+                                         QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t reg;
+    uint8_t resp;
+
+    /*
+     * With the AI bit, reading from LS3 (register 9) rolls over to INPUT0
+     * (register 0), not to a sibling in a register pair. All LEDs are off
+     * after reset so the input ports read 0xFF.
+     */
+    reg = PCA9552_LS3 | PCA9552_AUTOINC;
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, &resp, 1); /* LS3 */
+    g_assert_cmphex(resp, ==, 0x55);
+    qi2c_recv(i2cdev, &resp, 1); /* wraps to INPUT0 */
+    g_assert_cmphex(resp, ==, 0xFF);
+    qi2c_recv(i2cdev, &resp, 1); /* INPUT1 */
+    g_assert_cmphex(resp, ==, 0xFF);
+
+    /*
+     * Without the AI bit the pointer must not advance: repeated reads keep
+     * returning the same register.
+     */
+    i2c_set8(i2cdev, PCA9552_LS0, 0x54);
+    reg = PCA9552_LS0;
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, &resp, 1);
+    g_assert_cmphex(resp, ==, 0x54);
+    qi2c_recv(i2cdev, &resp, 1);
+    g_assert_cmphex(resp, ==, 0x54);
+}
+
+/*
+ * The PCA9552 decodes a 4-bit command and has no register past LS3 (9), so
+ * addressing register 0x0A reads back 0xFF.
+ */
+static void test_command_out_of_range(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, 0x0A), ==, 0xFF);
+}
+
 static void pca9552_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -89,5 +159,11 @@ static void pca9552_register_nodes(void)
 
     qos_add_test("tx-rx", "pca9552", send_and_receive, NULL);
     qos_add_test("rx-autoinc", "pca9552", receive_autoinc, NULL);
+    qos_add_test("reset-defaults", "pca9552", test_reset_defaults, NULL);
+    qos_add_test("autoinc-requires-ai-bit", "pca9552",
+                 test_autoinc_requires_ai_bit, NULL);
+    qos_add_test("command-out-of-range", "pca9552", test_command_out_of_range,
+                 NULL);
 }
+
 libqos_init(pca9552_register_nodes);
-- 
2.55.0


