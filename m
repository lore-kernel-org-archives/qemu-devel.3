Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB2CC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Kb-0006cQ-7Z; Mon, 17 Aug 2026 16:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KI-0006X0-Gx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006et-0i
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso2297635e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999970; x=1787604770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tV4WIYxXJUBI3Dbou01c42prXSCR/C3ZLm99S9w6d1c=;
 b=jUaWfZQrpWSz8aY3jVcdruh4pfENyAX6RXIkUbSZOOa4DFCFt+EFELpWQKGsPk9364
 VoKqBGL0li2k63GpJ8u/lQf5bk3xe3mY+3Yyy8DYQRnd8IHPnYvqC5gseNH+7jXQYYG5
 qj/uH4TR+QrGP1n68W15Uv2EehhjUnaL8LSAmRplFQxwrBpqqvv5LjKbJi5smJDXAD7C
 3oBaW/4+f8oY7Md/p0+3soNs92AdcmhXCl/JLosU32g3iePDTG9b1/Szh+uWnUvytdPQ
 iviQSwXRiYnTZ3FzHcgfTWJVtiO2kMAMT8ILedCbQqSPsFhirsLLr5GiCbJ3t0oG8JnJ
 v1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999970; x=1787604770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tV4WIYxXJUBI3Dbou01c42prXSCR/C3ZLm99S9w6d1c=;
 b=nukcy2o7RVT3dFS/7RTuTBSZ87eqw9ZtyofRZICKrnbkjYFjJh6Sr+A/6q7y1gBldR
 o2aE/+ky7mMsZ9OSt70nirZ7/loYH7VOB/JtPRbX7qo4G6DBmgrlz+i9QygxqL14How2
 aE+1hItGEj8DzQtpQPBKRr8ApMDQgZnTNCWBQCs0wWw94nb4tCHbcVyrLxc2p5ufqhpS
 oSCAGFVGfGAnu1W/yFAsSJobihZDTa2AI3ZKdMQwjQjH1PuLnm3hXL0yWd5fEnDNXz70
 S9kokyRa27cyOYyht5KFXOKeWTqGoK8RpNkppBKz+56T1WNvYb6MBJLNjI5Gy5jj7aSR
 a8kQ==
X-Gm-Message-State: AOJu0Yx3dwWJ5LDhhAuKKSjUO6O8Wb+RKnU+SokvnCjMgz8MALVkcaL5
 po5MUgCD54nm84Ez3f+JsWd4nZm7plRRlJJYe6mUI6MpMJ4oTQ+Rg7pALp1V9Veb9MHgRjP4ojK
 F/fhb
X-Gm-Gg: AR+sD13WcQfy/d9HSs8dfW71OCujISA2ZB0A8KpcVUp47D12tEL65WdiTaQQXcEh0bP
 1jz4xvn53IEqglb1weHHVEiTx0DeB12gIVsdY5UknP1pthZO/Gb6vX4iylxsglhTS4D8UfiT8MR
 py1m0k4GIZpGT18V7jbtcHhippCPqxmhvzz5Ygwsup78764+82cE8h9Hfnayr1si9jIjBCf9K3N
 7lNPej9V2ZQtFNIQnYHpp6k83Z0H+htyQSfWOCHVDHfPratFBZQ5oP6dbOdal0Sl2FoserYEw7d
 sIvcJG2bFzk4ZJya+SbIBQs5dI0b9bs5vwsH29ZF+yZnw+diRgGWOmp4vTOlffxU4Wa8gbbCVGZ
 3lmiZFHo9wijck3IikvADB7s+rePw4r6+VfrPKLRLwxpCjmqymBfodf18haoiRKWQyBUV5kIdC4
 rDfQcoaW70PB4o6PKBWBb/DLLD9M7vUfaJg62Xsf7UxhYCc/xygQ==
X-Received: by 2002:a05:600c:1394:b0:499:8d9b:832c with SMTP id
 5b1f17b1804b1-499a2060a14mr4684175e9.4.1786999970205; 
 Mon, 17 Aug 2026 13:52:50 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 04/15] tests/qtest/ahci: cover the sector count of INITIALIZE
 DEVICE PARAMETERS
Date: Mon, 17 Aug 2026 22:52:31 +0200
Message-ID: <20260817205242.1199851-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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

From: Denis V. Lunev <den@openvz.org>

The sector count register of a legacy port is eight bits wide, so
ide-test can only reach the lower end of the range the command has to
refuse. A register FIS carries a 16 bit count, which leaves AHCI as the
only way to ask for a translation of 256 sectors per logical track or
more.

Ask for 0, 256 and 65535 sectors and expect each to be aborted, then ask
for 32 and expect it to be accepted, so that the check cannot pass by
refusing everything.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 71d23fe56a..30d7005626 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -905,6 +905,30 @@ static void ahci_test_flush(AHCIQState *ahci)
     ahci_test_nondata(ahci, CMD_FLUSH_CACHE);
 }
 
+static void ahci_test_specify(AHCIQState *ahci, uint16_t sectors,
+                              bool supported)
+{
+    AHCICommand *cmd;
+    uint8_t port;
+
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    cmd = ahci_command_create(CMD_INIT_DP);
+    ahci_command_set_count(cmd, sectors);
+    if (!supported) {
+        ahci_command_expect_error(cmd, ATA_ERR_ABRT);
+    }
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue(ahci, cmd);
+    if (!supported) {
+        ASSERT_BIT_SET(ahci_px_rreg(ahci, port, AHCI_PX_TFD),
+                       AHCI_PX_TFD_STS_ERR);
+    }
+    ahci_command_verify(ahci, cmd);
+    ahci_command_free(cmd);
+}
+
 static void ahci_test_max(AHCIQState *ahci)
 {
     RegD2HFIS *d2h = g_malloc0(0x20);
@@ -1012,6 +1036,21 @@ static void test_identify(void)
     ahci_shutdown(ahci);
 }
 
+static void test_specify(void)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot_and_enable(NULL);
+
+    /* A register FIS carries 16 bits of count, the legacy ports only eight */
+    ahci_test_specify(ahci, 0, false);
+    ahci_test_specify(ahci, 256, false);
+    ahci_test_specify(ahci, 0xffff, false);
+    ahci_test_specify(ahci, 32, true);
+
+    ahci_shutdown(ahci);
+}
+
 /**
  * Fragmented DMA test: Perform a standard 4K DMA read/write
  * test, but make sure the physical regions are fragmented to
@@ -2220,6 +2259,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/migrate/dma/halted", test_migrate_halted_dma);
 
     qtest_add_func("/ahci/max", test_max);
+    qtest_add_func("/ahci/specify", test_specify);
     qtest_add_func("/ahci/reset/simple", test_reset);
     qtest_add_func("/ahci/reset/pending_callback", test_reset_pending_callback);
 
-- 
2.53.0


