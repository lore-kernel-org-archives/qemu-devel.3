Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2648CCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4W-0002p1-Td; Fri, 21 Nov 2025 21:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcXq-0002Gy-Mc; Fri, 21 Nov 2025 20:36:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcVo-00020h-4Q; Fri, 21 Nov 2025 20:36:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11A2C16CA50;
 Fri, 21 Nov 2025 21:44:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C096C321C8C;
 Fri, 21 Nov 2025 21:44:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 21/81] qtest/am53c974-test: add additional test for
 cmdfifo overflow
Date: Fri, 21 Nov 2025 21:43:20 +0300
Message-ID: <20251121184424.1137669-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Based upon the qtest reproducer posted to Gitlab issue #3082 at
https://gitlab.com/qemu-project/qemu/-/issues/3082.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250925122846.527615-3-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e9d02b59316fcbc9650d747b06e2755374ab3b70)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/am53c974-test.c b/tests/qtest/am53c974-test.c
index ed3ac7db20..a3667275ac 100644
--- a/tests/qtest/am53c974-test.c
+++ b/tests/qtest/am53c974-test.c
@@ -109,6 +109,44 @@ static void test_cmdfifo_overflow2_ok(void)
     qtest_quit(s);
 }
 
+/* Reported as https://issues.oss-fuzz.com/issues/439878564 */
+static void test_cmdfifo_overflow3_ok(void)
+{
+    QTestState *s = qtest_init(
+        "-device am53c974,id=scsi -device scsi-hd,drive=disk0 "
+        "-drive id=disk0,if=none,file=null-co://,format=raw -nodefaults");
+    qtest_outl(s, 0xcf8, 0x80001010);
+    qtest_outl(s, 0xcfc, 0xc000);
+    qtest_outl(s, 0xcf8, 0x80001004);
+    qtest_outw(s, 0xcfc, 0x01);
+    qtest_outb(s, 0xc00c, 0x43);
+    qtest_outl(s, 0xc00b, 0x9100);
+    qtest_outl(s, 0xc009, 0x02000000);
+    qtest_outl(s, 0xc000, 0x0b);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0xc200);
+    qtest_outl(s, 0xc00b, 0x1000);
+    qtest_outl(s, 0xc00b, 0x9000);
+    qtest_outb(s, 0xc008, 0x00);
+    qtest_outb(s, 0xc008, 0x00);
+    qtest_outl(s, 0xc03f, 0x0300);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outw(s, 0xc00b, 0x4200);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outw(s, 0xc00b, 0x1200);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outb(s, 0xc00c, 0x43);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc00b, 0x1000);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_quit(s);
+}
+
 /* Reported as crash_0900379669 */
 static void test_fifo_pop_buf(void)
 {
@@ -266,6 +304,8 @@ int main(int argc, char **argv)
                        test_cmdfifo_overflow_ok);
         qtest_add_func("am53c974/test_cmdfifo_overflow2_ok",
                        test_cmdfifo_overflow2_ok);
+        qtest_add_func("am53c974/test_cmdfifo_overflow3_ok",
+                       test_cmdfifo_overflow3_ok);
         qtest_add_func("am53c974/test_fifo_pop_buf",
                        test_fifo_pop_buf);
         qtest_add_func("am53c974/test_target_selected_ok",
-- 
2.47.3


