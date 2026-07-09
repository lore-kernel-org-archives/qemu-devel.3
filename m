Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whs8o-0002Dn-8U; Thu, 09 Jul 2026 13:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1whr7G-0003ZZ-Ur
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:56:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1whr7F-00027R-Dl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:56:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so41667f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783612603; x=1784217403; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/xmYhKZn0Bc7nNNZK3nmHGczU4Df7R8ARsnuvrZ+gI=;
 b=KdHbj+hbGXqmj94z6DALbMTM/2SPZmj4o2YlBl9cWdblu7qosDSA9xRqBi0hdQrKeH
 GfIQbwHUoFS16fTuYNgd3T9dAdju+WBCj8RqIfyww8AKUj5jqz2Pu9bA2VjqtXNhlh3+
 Nz0BM7HmLQRvsHrRHuQ5kHpLEQJHx+2BQUGZOH4E7Ggp0jb17tA5npwR+ZnEJXOQtHRn
 OCPz73/DG3Ww6foLMnPeahtM4IqnNwXsZSaXjO+sDlGXx/m7CJGvrp0ONtmLuIsrqgeY
 d6fgRdylRCSjb7qZdNlbnuytqgXj//CnUcEDaSMqcqT9XPAGMeXbeJeamDTahTgaKiYH
 dOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783612603; x=1784217403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/xmYhKZn0Bc7nNNZK3nmHGczU4Df7R8ARsnuvrZ+gI=;
 b=NRBSpC6XK+6cU76YNOVrzq2HbIatoKR08gDSgjq+pmu2YADOUwQ1+0W864N1+lIsRX
 wcDL/z38eMuEzoxAIMBxCAhyL1bKfYw0X58+tZd7gH/YYd0WbNvzPFcEEc/nb55S3gzc
 RVa6KpsWGtZMcIRenjolThjQzeaqAm8gIIeGwkR3ztTcmigss/p35iDziISce4arIFT4
 sWtm7mWAMrBEz98BIKJ6PJIhYwUCWOd6OD4OW4Dl7eE3fSyZIjdXAelzEokm79QyP0Uy
 mgx26LgY8MnyUJa6nLAx6OzUxCOPu/cOu6KngzT5nAqKecWtRWkDLXttlOG9lcacoka2
 +53g==
X-Gm-Message-State: AOJu0YxTyTwSXQeP40GV6LM1dClecdU+gsTTJcsA8edxrbxNPYzu8ZWy
 SqG4rA5e1bp0mDCborfY2Xg09/w3W06qf9S/djiW7mQvbRHYu0CZdQABJN9TWM4eBrI=
X-Gm-Gg: AfdE7cmOxxF6Epdzaxldh2VcPr2RGasOLDTMganG2YMA6BxOdIzVIcecJnx00aHV4xz
 7T0MfGDwnLkZKjaZWVKXnz8DSczJL5d8qxXwCv2QSZQkX061H6mMtRwDwta3ahE9gTgCfKjGp2S
 d46/7/Ae6Snvh9eTQ1fqi48dQd9u/8LyfbmIA/zl5CX7LGOyWZuYvuXCpZALaJqVEqkaX5RpOAs
 OGDWPuv/wuGXLfbK0OMQz64MlgSXLkmdc3ya+DlFH8p7Zak+fnxjxk7ww3uVxqc1Q5gwAcFyxPE
 Xv9sd/T7cC+V2iGcaWWI+D76hwgsC4YZ+lEHCJSsDoHE9UwXxSs/AV/wez02TKWtVH866n8Gvye
 Hg4c4ry/ykyUE1nJ4K6+htJ8o5RPq5AzxXqXqLJfSsSiNokl66JAb59n7wdDgl4GEIG7gLvcjRT
 iymnL5H9Wm0DdMJbePXy33YIlGl4zXj0UwDtfonVqsdoe2E/h/aVmqakRLDxY=
X-Received: by 2002:a05:6000:2997:10b0:47d:fc23:abe8 with SMTP id
 ffacd0b85a97d-47dfc23ac83mr1285265f8f.28.1783612602901; 
 Thu, 09 Jul 2026 08:56:42 -0700 (PDT)
Received: from localhost (89-92-102-124.hfc.dyn.abo.bbox.fr. [89.92.102.124])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm52828362f8f.11.2026.07.09.08.56.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:56:42 -0700 (PDT)
From: Emmanuel Blot <eblot.ml@gmail.com>
X-Google-Original-From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:03 +0200
Subject: [PATCH 11/29] tests/qtest: pca9555: test output-to-input
 reflection and pull-ups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=3988;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=5Z31IGvHoQJpOOVUEtYuqMr4o0UKYDZH+6sdNVkwanU=;
 b=5QLWQXaK+nrzCuL1diD0o7j1Kf/37bBcB+SHcAxAEFpHct+V6wChdTVXBc7CbeWq/6BxssqHa
 VwNRWyp8BoeDadGn8eJpPYyo/QnG9FCrRyF1EkqyYpsP5lAtunkjoP+
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=eblot.ml@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Jul 2026 13:02:15 -0400
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
Message-ID: <20260709152303.2zlvaqYhKvybxtyawg81nNT2kHf_FRQlEiEjzuOFQ04@z>

Add tests covering the pin I/O semantics of the expander: output-driven
pins reflected in the input register, the pull-up seen on input-configured
pins, and the independence of the two 8-bit ports.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9555-test.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 5945c3441e..6b085702c3 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -28,6 +28,77 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
 }
 
+/*
+ * When a pin is configured as output and driven low (output=0, config=0),
+ * the input register should reflect 0 for that pin.
+ * When driven high (output=1, config=0), input should reflect 1.
+ * When configured as input (config=1), PCA5555 pull-up makes it read 1.
+ */
+static void test_output_drives_input(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0xF0);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+}
+
+/*
+ * When all pins are inputs (config=0xFF) and no external driver,
+ * PCA9555 pull-ups should make the input register read all ones.
+ * Switching a pin to output mode with output=0 should drive it low.
+ */
+static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+}
+
+/*
+ * Test that both ports are independent: changing port 0 registers
+ * should not affect port 1 and vice versa.
+ */
+static void test_port_independence(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0xAA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -39,6 +110,10 @@ static void pca9555_register_nodes(void)
     qos_node_consumes("pca9555", "i2c-bus", &opts);
 
     qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
+    qos_add_test("output-drives-input", "pca9555", test_output_drives_input,
+                 NULL);
+    qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
+    qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
 }
 
 libqos_init(pca9555_register_nodes);

-- 
2.50.1


