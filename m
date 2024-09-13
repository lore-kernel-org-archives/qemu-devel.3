Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACBCFA3725
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spCxx-0005za-Er; Fri, 13 Sep 2024 16:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCxw-0005w3-8l
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:32:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spCxu-0001NU-MJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:32:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso20937135e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726259545; x=1726864345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MlxndzAhFPdjvUSrYBQQzh6eFUgs9awBJAeoSBt6nbE=;
 b=A3QoqEkVz/I+ryngaC9XyhxzXffvyY48bxCozBDBKiTLDnnpAkxYp8gC2juIP5R/9U
 lGEGAxilvkbAnrZt14LQCerxp1uXhjO4AvGctvAcjSQZmuhBlyijXlICQvU2Hdf1OOB5
 /brBKh1cVsL0zVluQeOZja5OprQickLkAvEzX5DUUhNCuXd1Io4kOnoavo8h0tSJLm4J
 QxM2sbAsjUe8Ncecpxsg0EQ+V9vLPF8jrtPIcvNhRTEwLhP+4cfcqyR8lpdeSY6Zekfa
 zuRP2Iuo/ah3LRNJ4q0th97LgZmlD9HYwMJGjb47xnLF4KDJ7rrgXanTcl6CkyOM9plv
 ZVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726259545; x=1726864345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlxndzAhFPdjvUSrYBQQzh6eFUgs9awBJAeoSBt6nbE=;
 b=Pev1yQiw8EapDfjTBsUeMziCJSodmD24OaBmCo7+gg/dwoTCF+S2cfXIYDHh7wtLU1
 3Ff5SvpbTNCq06/FbfZq7x3Aw2B4Sr9Y9bSQT+RJKmPHnmYmy5ACRcyQ1NsORf1QUeFn
 59GeT63jB1ECgLNL7oWgOQUnpwm3rMFr2jy9bBQkU6/IcZHARNhV9t4O99G/hp4tWZ16
 r27w4gdzLBwzOY86w7GiVmvP6CWSC4Kt09jjZsvMcG4h6U5Lbxznb6NRJON6naR2xIJM
 zhBGqH0kzystjWfy0HnF7zBg0I1qQOmVDc8wG7PG8hLYbBXcO6pleTEJ5vZt5/AVLVxn
 /k8A==
X-Gm-Message-State: AOJu0YwhgQwyveIhslRRjW3PyDUysaPZH4yyH6CshB+QcpCGZhEhpEW+
 QeeF9xiBEX19Fynt8B0weuMf1KcotpliHHpn9gWjUOe78SUHOkcbtK8wI448kuz+dxvQzk1DB8S
 c
X-Google-Smtp-Source: AGHT+IFwwA6BtQ3gcpwSiCWCG3NhlT3vGx8DWAaMzMoYLpRN7qpHWSuyaFKqjQbeh9GNOlvIEidqlg==
X-Received: by 2002:a05:600c:3b99:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-42cdb4fbb08mr52530565e9.4.1726259544587; 
 Fri, 13 Sep 2024 13:32:24 -0700 (PDT)
Received: from m1x-phil.lan (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01a8ee7sm141121765e9.0.2024.09.13.13.32.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Sep 2024 13:32:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 47/60] hw/sensor/tmp105: Lower 4 bit of limit registers are
 always 0
Date: Fri, 13 Sep 2024 22:32:16 +0200
Message-ID: <20240913203216.15265-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913203216.15265-1-philmd@linaro.org>
References: <20240913203216.15265-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Per datasheet, "HIGH AND LOW LIMIT REGISTERS", the lower 4 bit
of the limit registers are unused and always report 0.
The lower 4 bit should not be used for temperature comparisons,
so mask the unused bits before storing the limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20240906154911.86803-6-philmd@linaro.org>
[PMD: Update tests/qtest/ files]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c             | 2 +-
 tests/qtest/bcm2835-i2c-test.c | 2 +-
 tests/qtest/tmp105-test.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index f5101af919..9d7b911f59 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -171,7 +171,7 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
+                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
         }
         tmp105_alarm_update(s, false);
         break;
diff --git a/tests/qtest/bcm2835-i2c-test.c b/tests/qtest/bcm2835-i2c-test.c
index 513ecce61d..1599194926 100644
--- a/tests/qtest/bcm2835-i2c-test.c
+++ b/tests/qtest/bcm2835-i2c-test.c
@@ -81,7 +81,7 @@ static void test_i2c_read_write(gconstpointer data)
     g_assert_cmpint(i2cdata, ==, 0xde);
 
     i2cdata = readl(base_addr + BCM2835_I2C_FIFO);
-    g_assert_cmpint(i2cdata, ==, 0xad);
+    g_assert_cmpint(i2cdata, ==, 0xa0);
 
     /* Clear flags */
     writel(base_addr + BCM2835_I2C_S, BCM2835_I2C_S_DONE | BCM2835_I2C_S_ERR |
diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 3678646df5..85ad4eed85 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -100,9 +100,9 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0x14f0);
 
     i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x1234);
-    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1234);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1230);
     i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x4231);
-    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4231);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4230);
 }
 
 static void tmp105_register_nodes(void)
-- 
2.45.2


