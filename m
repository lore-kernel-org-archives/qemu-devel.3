Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E812C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNS-0000P9-0S; Tue, 11 Aug 2026 12:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNN-0000Hx-5z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNL-0000fj-7m
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufOlKYvDB40bcwQ0U1VfIshOxC3uJvN4gkjEhDi7DY4=;
 b=OGHUb+Qzc1r7jgb/XAXvt4NXUNLdva2OoxxBGim+ny0yPgPZ9eirwmg0GFTPwVBsYRtc+b
 uel93wbJsSAGvkpyE6JpxHJBh/1HeRSDsD7ki8PsCAA2NGYnU1tgrfY6K6dEKwGwUTz00M
 Fuv6INh9fii3K+x/UcSb8VmHilm9NCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-yCh6SVAPOM-sKwK2lDg_CA-1; Tue,
 11 Aug 2026 12:30:49 -0400
X-MC-Unique: yCh6SVAPOM-sKwK2lDg_CA-1
X-Mimecast-MFC-AGG-ID: yCh6SVAPOM-sKwK2lDg_CA_1786465848
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AD00195609E; Tue, 11 Aug 2026 16:30:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0316195DF91; Tue, 11 Aug 2026 16:30:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/83] tests/qtest: adc128d818: test limit interrupts
Date: Tue, 11 Aug 2026 18:28:45 +0200
Message-ID: <20260811162938.1403216-31-clg@redhat.com>
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

Cover per-channel high- and low-limit interrupt status, the
INT_CLEAR bit gating the monitoring loop, and the temperature
high-limit alarm with hysteresis.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707091609.97759-5-emmanuel.blot@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/adc128d818-test.c | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
index 891189f0bd8c..3e3fabb8d9f1 100644
--- a/tests/qtest/adc128d818-test.c
+++ b/tests/qtest/adc128d818-test.c
@@ -330,6 +330,123 @@ static void test_ext_vref(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(reading, ==, 0x8000);
 }
 
+/* Interrupt status set on limit violation; persists while fault remains */
+static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    g_test_message("Set ch0 high limit = 0x10");
+
+    qmp_adc128d818_set("ain0", 2560);
+    g_test_message("Injected ain0 = 2560 mV (exceeds limit)");
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS = 0x%02x (expect bit 0 set)", status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after re-read = 0x%02x (expect bit 0 still set)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    qmp_adc128d818_set("ain0", 80);
+    g_test_message("Injected ain0 = 80 mV (within limit)");
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after fault cleared = 0x%02x "
+                   "(expect bit 0 clear)", status);
+    g_assert_cmphex(status & 0x01u, ==, 0x00);
+}
+
+/* INT_CLEAR stops the round-robin monitoring loop */
+static void test_int_clear(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    qmp_adc128d818_set("ain0", 2560);
+
+    i2c_set8(dev, REG_CONFIG,
+             CONFIG_START | CONFIG_INT_ENABLE | CONFIG_INT_CLEAR);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS with INT_CLEAR set = 0x%02x (expect 0x00)",
+                   status);
+    g_assert_cmphex(status, ==, 0x00);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after INT_CLEAR cleared = 0x%02x (expect bit 0)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+}
+
+/* Low-limit interrupt triggers correctly */
+static void test_low_limit(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    i2c_set8(dev, REG_LIMIT_BASE + 3u, 0x80);
+    g_test_message("Set ch1 low limit = 0x80");
+
+    i2c_set8(dev, REG_LIMIT_BASE + 5u, 0x80);
+    g_test_message("Set ch2 low limit = 0x80");
+
+    qmp_adc128d818_set("ain1", 640);
+    qmp_adc128d818_set("ain2", 1280);
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS = 0x%02x (expect bits 1 and 2 set)", status);
+    g_assert_cmphex(status & 0x02u, ==, 0x02);
+    g_assert_cmphex(status & 0x04u, ==, 0x04);
+
+    g_assert_cmphex(status & 0x01u, ==, 0x00);
+}
+
+/* Temperature high-limit interrupt with hysteresis */
+static void test_temp_hysteresis(void *obj, void *data,
+                                 QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    i2c_set8(dev, REG_LIMIT_BASE + 7u * 2u, 0x32);
+    i2c_set8(dev, REG_LIMIT_BASE + 7u * 2u + 1u, 0x28);
+
+    qmp_adc128d818_set("temperature", 25000);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("25 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+
+    qmp_adc128d818_set("temperature", 55000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("55 C: INT_STATUS = 0x%02x (temp bit expect set)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 45000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("45 C (hysteresis): INT_STATUS = 0x%02x "
+                   "(temp bit expect set)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 35000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("35 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+}
+
 static void adc128d818_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -354,5 +471,9 @@ static void adc128d818_register_nodes(void)
     qos_add_test("temperature-edges", "adc128d818", test_temperature_edges,
                  NULL);
     qos_add_test("ext-vref", "adc128d818", test_ext_vref, NULL);
+    qos_add_test("interrupt-status", "adc128d818", test_interrupt_status, NULL);
+    qos_add_test("int-clear", "adc128d818", test_int_clear, NULL);
+    qos_add_test("low-limit", "adc128d818", test_low_limit, NULL);
+    qos_add_test("temp-hysteresis", "adc128d818", test_temp_hysteresis, NULL);
 }
 libqos_init(adc128d818_register_nodes);
-- 
2.55.0


