Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C1ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1l60-00054i-Bg; Thu, 25 Sep 2025 08:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l5x-00054G-Gw
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l5r-00005q-Ou
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MULB+DIJQhKdzn2/TWpCjrhJkhbPGOGvv2er1hdeWcw=; b=zGgZMSpL7YaR4xxond6UX2Bpmb
 ETT9FeWbQugfA+QxoaSeuiVJ0QPqTXp9dgAY0GKMIfG4BIrRhb3VmlLXCeDrw5a4eEZGeQ50ix02e
 5BWEAwO16FohppUNwaZ72CSZysCMXOa6MQxCkuGBmkYcRnY3+cb3Ccf/RcawE1DRU6FqkIzS/6Mwu
 hprhVtbjFpDFdwOmo72fZaIkIn47sYiWZ6xG7P5W91upefhGk6zlrjPLanx5sqx9MWJg/PKZ0Cbs7
 tcnw3m7NqonbkuN7P2YiMudUOH8uJCRCi7WiztO1+7htcmoc8IqtHnZFKtwaPyKVxdKLN1wauRb8a
 rAUAddW3+4Ev4rb3ssKCB2L52PXw4VEBt6i5l3sU2TmN5TThzy5gQSPWxXgaZqeceAlwBOZiwLvwU
 h8MS1nU5VEZNbCLBqsuXlqQWUQ+b4mRMR+aowdxBdMuMmN2JOdgcWkb1nPDhXpYlUJVqS8sws+PqZ
 te1dfBnCa+X0XkQRETEiR1vXt4pj6IhTtC2WEJksZPd7fd/mf4ids6JFMv+YMtXIV7lQ3Gqetqmay
 C1sBUinS6MLXXukGhuZR2gxACs7PDPQAF09Wv09gCB7xh6DI1qnznkDVRFQJHPJLCffVs1qPgLyqw
 WsO/FHVM7ttlDmf+FEZEOAa8dpi6Hr8xggnr5aJgc=;
Received: from [217.155.175.48] (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1l3h-0008Tc-IT; Thu, 25 Sep 2025 13:26:49 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, farosas@suse.de, lvivier@redhat.com,
 qemu-devel@nongnu.org
Date: Thu, 25 Sep 2025 13:28:46 +0100
Message-Id: <20250925122846.527615-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
References: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/2] qtest/am53c974-test: add additional test for cmdfifo
 overflow
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Based upon the qtest reproducer posted to Gitlab issue #3082 at
https://gitlab.com/qemu-project/qemu/-/issues/3082.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tests/qtest/am53c974-test.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

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
2.39.5


