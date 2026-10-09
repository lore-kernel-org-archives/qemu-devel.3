Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8D1CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFDQZ-0004r9-5S; Fri, 09 Oct 2026 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xFDQW-0004ow-TY
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:33 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xFDQU-0004qq-GO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 12:26:32 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5ba35c0df4fso4430671e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791563189; x=1792167989; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XgEXRkSo25Y8sk6rBrwjzcOhXbX2A8adbC7bH6qxi6E=;
 b=Rqe3P19XacQgNbrTsq/OCnnwgxTdBcP32jcy1Cas9j+ID3Qc6A7/tj5yMZQ6PE974z
 TkKO7wVeOjsTjCa0GBgLx+KpgV+6d39otmTWQ3jaiINfOIb9XyvPQHy7HlxnAke1vUOs
 IU1DGTIb68BrxURrc/aox9CIP8SItr29LKlEhvp8J69CL0Pk98EJtxIWWNyP6Xrp/CE0
 ayfKsIt1WS51Xrf7oXXcfXmf7TNFk8Bmij+d+yetS/iV/bcjbHzCyZMZpA7LzfjI9JAP
 censP7IgeQFhC3PK7X8bsAD0lST5YebLWY/+9Ym/DqWPfLs2ByC+oPt9B5dYFLx8d994
 Kxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791563189; x=1792167989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XgEXRkSo25Y8sk6rBrwjzcOhXbX2A8adbC7bH6qxi6E=;
 b=DHWORhHO41SmxtT5tiM3iMSVZM+pIZfHChbHLSerpZwS2j7OCGACN36QkTgRdT7Wnu
 A8YZE3qE1XuP2DHvnq8bAMTy1RdFq3+PYFNagRaqtFQpzmqM9hGK5A3XqPv8ZXGFnXdA
 5uSP6Eko/t34KB2O/aTzp5HVSArS97cmsiJnhZISzZDy39/wZ3Ggh2gEO7HSvAUklpit
 AMxoB5yJvbNImMcYa54d8HwOhVDxZZuvl7CKsfrnYs7dTPOm/0FJemH2mewTYJfadY/u
 a2qU4dKJ4fmSdUiL1PXXpEDmElh2aQmhkkxG6TAV37pr8SiqGwBVE9d4u5y4Xh4tsa0c
 WBmg==
X-Gm-Message-State: AFq9FYIyCRVWGy1nasaDD7ygv1Pr+sLXCH/rhiSOxoC5PRwTctbmxG6g
 mDagwoZWQ+Eq+XvsLsnGNxqhHUYvfN5mnLgNDs7YPBioG3HPP4ZlTHtAidgYNnO2
X-Gm-Gg: AYBFou3o9SlluhI929ZiQdXRn/YK9YB8AjFMjELOrEkKkUGs3mWI+dzz/BpVSezBdOU
 Wq/YNrvXhdILC3b0GMFr+zolHdS56Qy41/xgOlLaQR7gsd3T1vituP8hApMxuybTmpGVt6OhS1c
 bL7Yz9/IMaDVRjcMGXWy+381S+vRmRQlaDvMzGpkO7SdNDgB0RIK3XBGxLI7kT6WT9e4ycw8L34
 qK2sppgj3482jZ1k6XTnkckLR7jetj7IsHr/waZafkeLufl3XzPrj5sGhlzbpMhCfoJzdM5YVRH
 ZCCZ88ct88HtYmzjtvOq92HIw+sR4aPGQaJUfhgsDE8pKScNfvTxvJTBnw0N1E7IUBe7bk5vbWp
 Ek/Yxo+t7RhknGeroi9Y1Ghrm98aR7z9JFckQtl2eSeWggC/cWI3AuFQisWf3VlRPWm2uM6/hzN
 aMvg0r84qXWzkzcs89l+DxwAwyMcsUIl7mcd+ZLBK0rvJ+QciW09j4YUUrcOrqP31PKNAAKL8XY
 7ptMg1AWaQDW6ccOy5JFV+CL80xQVSdudcQQDsdkDeh7AAUkxqMfDZM0ro=
X-Received: by 2002:a05:6512:108c:b0:5b6:1a7c:aa1a with SMTP id
 2adb3069b0e04-5bcde8d9f25mr921166e87.50.1791563188529; 
 Fri, 09 Oct 2026 09:26:28 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bce5bce999sm240217e87.79.2026.10.09.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:26:28 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Fri, 09 Oct 2026 18:26:10 +0200
Subject: [PATCH 2/2] tests/qtest: Update Allwinner GPIO test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-allwinner-gpio-eint-v1-2-c55d2958ae0b@gmail.com>
References: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
In-Reply-To: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Fix tests to configure pin to EINT mode instead of input for interrupt
testing.
Also add test the configures pin to input mode and validates that
manipulating input pin changed value in DAT register.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 tests/qtest/allwinner-gpio-test.c | 57 ++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
index c048f0f88b..5c4a148d82 100644
--- a/tests/qtest/allwinner-gpio-test.c
+++ b/tests/qtest/allwinner-gpio-test.c
@@ -238,6 +238,32 @@ static void test_set_input_pins(const void *data)
     qtest_quit(s);
 }
 
+/*
+ * Set pin to input, check that the value is written to DAT register
+ */
+static void test_get_input_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *in_name = portname_in(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, param->pin,
+                     AW_GPIO_LEVEL_LOW);
+    assert_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_LOW);
+
+    /* Change input value */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, param->pin,
+                     AW_GPIO_LEVEL_HIGH);
+    assert_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+
+    qtest_quit(s);
+}
+
 /* Test rising edge interrupt */
 static void test_irq_pin_rising(const void *data)
 {
@@ -251,9 +277,9 @@ static void test_irq_pin_rising(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
@@ -296,9 +322,9 @@ static void test_irq_pin_falling(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin high */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_HIGH);
@@ -341,9 +367,9 @@ static void test_irq_pin_high_level(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
@@ -394,9 +420,9 @@ static void test_irq_pin_low_level(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin high */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin high */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_HIGH);
@@ -447,9 +473,9 @@ static void test_irq_pin_both_edge(const void *data)
 
     qtest_irq_intercept_in(s, "/machine/soc");
 
-    /* Configure as input and set pin low */
-    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
-    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
+    /* Configure as EINT and set pin low */
+    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
+    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_EINT);
     qtest_set_irq_in(s,
                      "/machine/soc/gpio", in_name, port_pin,
                      AW_GPIO_LEVEL_LOW);
@@ -518,6 +544,7 @@ int main(int argc, char **argv)
         const PortPinTestParam *p = &in_out_test_parameters[i];
         add_test("set_output_pins", p, test_set_output_pins);
         add_test("set_input_pins", p, test_set_input_pins);
+        add_test("get_input_pins", p, test_get_input_pins);
     }
     qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
                         test_reset_values);

-- 
2.56.0


