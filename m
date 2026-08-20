Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B928C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhr-0006tG-CX; Thu, 20 Aug 2026 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhk-0006od-53
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhh-0008K7-LP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so1397877f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220536; x=1787825336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YFE/K/4vNyqzMwiTk1xBUvuX5IsKmMx8aQ0HWwkIsCk=;
 b=srlAXIen+m5G8S1ieKG+avjEfmC5DaMsg+oM7ajDBNhJUHiELaNGvs+QtTpVCa/3ft
 91v0ud6cMcz/YbdmoCQTri3o2p4pG7CbJyCwOgesRVr5gfMbFp4dlZtdRaueLlctTFS9
 ylnL5+/JU9Gm1E34nv/ARlCGDWRCs/WSdO89OKZb9BVThE1c10LU8+QZxUZDswOOeuLf
 QuyPvc8y6SvPxFndfuzbkJyPVtTrUbF/dSxEGyrSwX501dIc6Sj0rIYx76NM6TFhhuUC
 dRu7qW7lIc6GCYVkjZROg3w4QBdgt6PkhbRyBVYuXPw9fyNELCOHcxHEsR3vsYr/S/aL
 HvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220536; x=1787825336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFE/K/4vNyqzMwiTk1xBUvuX5IsKmMx8aQ0HWwkIsCk=;
 b=Ye+JyRjtnnJ0+CaA40Rq3/LyOmFKSO1BxbelSVtPA74LCaLpUeqfhRHrGAdiJ42Tj2
 silBOp5PF2Mp5sTjgAUB1hnHvoYZQ4nxuCbGZoM4KgCxQCtYW98bNbCIH7yg3QqhZVuX
 ZrPomrIIJ1b1A5+cn3mD31LNXgH16n3SIUcPkaKLkczHRyxpn9vOc7ePLNM0cHVnc6NO
 eHQezowsgPK1zYPJ8Oc2o6BpHzn5rENw85Qw3JxjWJ9Wr5zlctxO1VuRd5MxYfXMG15P
 xKw+3ykOiyKQU4GuDtma57MM8gXPe+ndayN7Yjq2CbB2QKsLPH8NLsF2/4Ish9qIZz1U
 Rk0w==
X-Gm-Message-State: AFuF++kTXmJvj0OI5eeNfs49GqNhogVEJ4DK71BGmWETRigP4WYqRJlt
 Udq+NdQfESBzi6IIKUDQQNZmn1QjeXY5zoGnJsg/rEYo64gy6rVFwGJ0uw7nEIlMKR+2s7ACMKa
 M/4aZ
X-Gm-Gg: AR+sD12sApqETts02fKGxv7HaupfGT0m0hra99AXA4nVvnz6ynwmpcPIfecOyyTF4fJ
 qsqxEmDgePoXEINFVxqYS4QZEMJtTmiOsdRDM+lMPyveCOPONvgAcEmWH9mvMMUOq7zUL4GHxHy
 mCf4CbFtBB5iPPpc9Fw4wqF5qzauPV1ekWOqr8OJvhY049cfnMiWX7Yop/56JheD0r4z4vnUgKk
 N/bYYt3EwL+vSp9NsP+ljT61DoCsiXQiXsXXwyC+/EocPJWqmOtq1tD6bvl/ovIMiHD11zgp2oQ
 0TjleXBeeT5gtP4CowhPwnkFn9/YfuJ6vvt8xjqsQqOhzTs3MrV73ZS2pve67IHYUTmNeQjLAwx
 Sc+GoE72r7yv6bS90cWKVQmtouFqQ7tuMLZvv7O2MRwb+u1nVGqNktEfZkbfGZYSpoCk6aXEom3
 UmwmyAnMgw9xvvStZ2YuvGiSU1uActN4oogbE5sztXDCgElLnhWi6gYEKRVw==
X-Received: by 2002:a5d:5c83:0:b0:47f:ec8a:214f with SMTP id
 ffacd0b85a97d-482b1fd4d2amr20898822f8f.15.1787220536145; 
 Thu, 20 Aug 2026 03:08:56 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 04/17] tests/qtest/ahci: cover the sector count of
 INITIALIZE DEVICE PARAMETERS
Date: Thu, 20 Aug 2026 12:08:31 +0200
Message-ID: <20260820100844.411717-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=den@openvz.org; helo=mail-wr1-x42a.google.com
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
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


