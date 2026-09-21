Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA11C982DA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8WI7-0000se-W5; Mon, 21 Sep 2026 01:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1x8WI6-0000sL-30
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:10:10 -0400
Received: from mail-pz2-x14.google.com ([2607:f8b0:4864:3b::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1x8WI4-0007w5-F7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:10:09 -0400
Received: by mail-pz2-x14.google.com with SMTP id
 41be03b00d2f7-cc4d2fe2056so1521125a12.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 22:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789967407; x=1790572207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I4wjmqFESw16ZRfgVBKpX32/Ry6HBE5C3JIoH5S39pE=;
 b=sWfW+CcW7j2BJmVLnIG2pOs/LmH8YgWGqLIJSJCVC5DznbbBun3kUatlBZU/UthIur
 zvBIiyafn5zMiy6OrQajtkM85uIBalvbwN6QM7vZIZJDSrOm6v4+NUhZCNM2tD+mkTqH
 hLfnkpoxxx0jDmt7U18GMIeFLqNMQB8JUVyHzg7pRJDgQ6zEug9z16mHVfnybkbtqHu4
 ofDoZPMQoMOAeAURAX84zNMI+pj2GxK40RxzdSzsdG9m/om5KNTU0vr/2fzia5OPnzBY
 qkXgGR98xkSvM6yfFXDWTvHMFjXii+PQnXzYWuaPbmVGHKPDsfpgVApw+Gwqq/wTKKIH
 pWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789967407; x=1790572207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4wjmqFESw16ZRfgVBKpX32/Ry6HBE5C3JIoH5S39pE=;
 b=myrkb9Aa9O+1VKbv1/zgzQ9eun+NfE7CBjq6VnVAXREEEryQXin10jXFAf8gJIwfma
 4UvK2XFYW/IeHnRzvu/0ECxBvF54JszvEh/PtMmWQirsg0RFOMVX9en9YUBlClLvHRJk
 LXqI74rd7lb8jHW1lTCN4Zvh8t/uP07y6CwPMjAcK06mJ7iSS/dibyk3Y6hu9DYRUBbT
 y3e/sD7KmWSP3EuZhtmV769apbduJebw9xAHm1eGk+la+2RwI7PpQjnBcMSu+BAhztSI
 Y9yIqlPP4otb5fXALJ2q2E3s4tidKYb0BnQti+abe2JfuZQN4k75BhDQt3+G5y80SDsR
 HaNA==
X-Gm-Message-State: AFuF++netalIevZy8Q5pDzRxlLRpRoSmpO5eCh+m1oyyA9Gm/VyE+4XM
 vA502A8sE0g1EtX9OJbZGre5Es6uW2fHzHyalu4CJ9WTq9Wmhn7XhzzlN9KE5Gzd
X-Gm-Gg: AYBFou2WCaWFl362LC4efuWroeTSpfbVcFe+WQMNm5hIclHlHgzgQ7463VbQPl1BmgN
 P1ZMqSfdXjKjydYizr4JoZA42gJXWfCAV3nlvlAycTRyvl6FsTp/JU1bw57AXfOBrriDp9Y91SD
 VMG7j3toXc8xGhBL+j6GSRdF3SjC91AmAUmoZfqkJyybIv9Q+xYDcXATwY4hF+3+RsM0hyD3L82
 2D+rqlwD/cdt8hd/48+FoYnPZJ/e43vfm7IfBmWQAMKWrH3j+Dm/9xa5tGVmMa5glIYuI7RCqLL
 rUPttgcRrS7y3iHwK/xWxxGPrv9W3UfeZGnDY8GUcXxJZLUji2geX/BrNMqtGEt45AuAGje30sO
 bAnV7aPjARhCSAzUlm2/E1G60CekHmmXYUCjac2ESd0wHOhOO8aLHmmxgVbNUOiFlEtbFrO++ND
 zEUbNC02Cj0koW3WwUJvuTIdDuCi6u5FlTD4ZzmqXNXQ1k2gO9D+XsUu2AJ2GOLj3IJ+9cAXTze
 ciz4JipPJcmi0Dj3Q==
X-Received: by 2002:a05:6a20:6a20:b0:3d3:adbf:7777 with SMTP id
 adf61e73a8af0-3dd8c49f29dmr16052707637.19.1789967406541; 
 Sun, 20 Sep 2026 22:10:06 -0700 (PDT)
Received: from jacob-pop23u.lan ([2600:1700:88b2:a50:a9ca:268c:17b3:ded])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d54af4d5sm16625516c88.2.2026.09.20.22.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 22:10:06 -0700 (PDT)
From: Jacob Whitaker Abrams <jwhitakera@gmail.com>
X-Google-Original-From: Jacob Whitaker Abrams <satur9nine@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jacob Whitaker Abrams <satur9nine@gmail.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org (open list:STM32L4x5 SoC Family)
Subject: [PATCH v2] hw/char/stm32l4x5_usart.c: Support 16-bit writes
Date: Sun, 20 Sep 2026 22:09:59 -0700
Message-ID: <20260921050959.1876719-1-satur9nine@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::14;
 envelope-from=jwhitakera@gmail.com; helo=mail-pz2-x14.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Official STM32CubeL4 drivers use and require support for 16-bit writes to
UART registers for proper function despite datasheet claims.

Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
---
v2:
 - Remove all changes other than supporting 16-bit writes UART regs

 hw/char/stm32l4x5_usart.c          |  4 ++--
 tests/qtest/stm32l4x5_usart-test.c | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index dd1b099195..3b9883bb23 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -521,12 +521,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
     .impl = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
 };
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index a72c5a685d..3c6437e75d 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -332,6 +332,26 @@ static void test_ack(void)
     qtest_quit(qts);
 }
 
+static void test_16bit_access(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    /* GTPR is declared uint16_t in the official STM driver. */
+    qtest_writew(qts, USART1_BASE_ADDR + A_GTPR, 0xABCD);
+    uint16_t gtpr16 = qtest_readw(qts, USART1_BASE_ADDR + A_GTPR);
+    g_assert_cmpuint(gtpr16, ==, 0xABCD);
+
+    /* TDR is uint16_t and r/w, register is 9-bits */
+    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0x01CD);
+    uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
+    g_assert_cmpuint(tdr16, ==, 0x01CD);
+
+    /* RDR is uint16_t and read only, register is 9-bits */
+    qtest_writew(qts, USART1_BASE_ADDR + A_RDR, 0x01FA);
+
+    qtest_quit(qts);
+}
+
 static void check_clock(QTestState *qts, const char *path, uint32_t rcc_reg,
                         uint32_t reg_offset)
 {
@@ -370,6 +390,6 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
     qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
+    qtest_add_func("stm32l4x5/usart/16bit_access", test_16bit_access);
     return g_test_run();
 }
-
-- 
2.43.0


