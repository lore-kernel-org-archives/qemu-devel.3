Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2660C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KS-0006a7-II; Mon, 17 Aug 2026 16:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KG-0006W6-BW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006ee-09
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so36202025e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999969; x=1787604769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpkq/G5Q4hMxPZhmoLn1PK51Ug+tQDlDEmy5ber/qUE=;
 b=fH3UVD9xOhBxp3WMCrg8HGL/4gvHrfJtZY7CM9t/3B5v7iUm7UFevpkq9dBk8ExopJ
 aqj1KybeQ7IiAq2YoABdmcjn9gX0soQ1ZuRNI4lEsKehjOvw4qDYannlDY8cXQZ8DuMm
 PBQ0PiPz6n+4q41ik8rEAFtv36REmFIonkldsCJUUwv3b0UZC0QhCJ+t9cp8Wlfxbgds
 bAVaTu+Q4OHaXW9FN1ZKIw8FLtVsD41oRb+dZ4rmEJplENml0n9+ynPipCPwXu9L90l9
 NiDs3+AIJAAKaLZ4ZA3LFY9uWZH1ovultawrvfbHZ0KDByH3nyMnybEnm3G4GdC0s0u6
 VBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999969; x=1787604769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vpkq/G5Q4hMxPZhmoLn1PK51Ug+tQDlDEmy5ber/qUE=;
 b=grHynTp9vIibm5OdoRER4iwpFp+22thM07BFutJSOeXNe2AUUFFJ7wUAGwrhNCbWOW
 piBkjXOpcErSi/9/P6niA0lABTKMPkgyGzPgRTi0ZQjpGNdA9E2Iiuvq+uKAgSqz3vca
 Czu3/nzhyjko7Hfr/WRiNmb41j36J9IBnrCeUQTjvG0mGM2GnbR2GpR9MZlyp0fWDAR1
 PKCkAyQpwR6uw21kLUtBLZXatity50i6TsTdt/5sccj9p6Wqb6dW+Zv/7TcWz1MTHCGQ
 5ULxzl2nsOOsy9XAkK7jELZkmPj3YYtkSvtv9kkrYZhauGOyZnU9u91nF9r5yRoj6CXH
 oo/A==
X-Gm-Message-State: AOJu0YyomInx7HgpphX2p8l3sfDqg/7arhLN4PdselKLVmrcQhby5vn6
 6hDm4u+pHI3W0ilR59s1+z3dnrObWus+0bPn/ctFxrGhRujBxBcPS6cCvRYngWseIyATSyff5lE
 Zj+J5
X-Gm-Gg: AR+sD11ZRKX3jhMOGJEUVbHi45oJU3dPuHifIaLFi78ydfn1d9BYD9lfT02YtLwjHWi
 ztwXSdEwuPL4JkTYDi/U41vvtGNyYqxVy0YKFzqPdC+KTR9o3DNQ6MmoIYFY2CBczjH3E9ML76l
 POC8+qGnlHvm7RdMm2KMHa4FiVzEUzIvEcMIjedXg+F42/6mL1cGY2fJe21F9JbYwn+Zq8x4xi4
 mXVNb7rvnW7WiwrmaG69AVfpK/trvjOZqjErrQTdvnwwUG7gga0KC0/TDLW2dcWNRbUjJTGXmgt
 0nfU8qp6vDDhRwH1X+gU6p2VFDWgoSS2F9D1l8Z2FMISTxxngDsV/+y1WtHPkr5Jfs6NIyvBGAT
 53ipymd7qGDiWjn092EVn7FyVZWAZ7yb4epJ2nNa/717HO2j3lvyPUqgp9adXiI00L9HTVSrSyn
 b534FKiLpGIc+T04e11qbHklWWy4+SOjahB1tbg6pVHNb+LzywXA==
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-49987979c41mr466104425e9.12.1786999969196; 
 Mon, 17 Aug 2026 13:52:49 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:48 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 03/15] tests/qtest/libqos/ahci: allow a count and an expected
 error
Date: Mon, 17 Aug 2026 22:52:30 +0200
Message-ID: <20260817205242.1199851-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A command that transfers no data can still take an argument in the count
register of the register FIS, and a test may well expect such a command
to be aborted. AHCICommand is private to the library, so add two
setters: ahci_command_set_count() writes the count of a non-data
command, and ahci_command_expect_error() records the error register bits
the command is expected to complete with, which is what
ahci_atapi_test_ready() does inline for a sense key today.

INITIALIZE DEVICE PARAMETERS is the first user of both, so describe it
in the command properties table as well.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/libqos/ahci.c | 14 ++++++++++++++
 tests/qtest/libqos/ahci.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index e3019a1eca..50b63239c2 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -74,6 +74,7 @@ AHCICommandProp ahci_command_properties[] = {
     { .cmd = CMD_READ_MAX,       .lba28 = true },
     { .cmd = CMD_READ_MAX_EXT,   .lba48 = true },
     { .cmd = CMD_FLUSH_CACHE,    .data = false },
+    { .cmd = CMD_INIT_DP,        .data = false },
     { .cmd = CMD_PACKET,         .data = true,  .size = 16,
                                  .atapi = true, .pio = true },
     { .cmd = CMD_PACKET_ID,      .data = true,  .pio = true,
@@ -1180,6 +1181,19 @@ void ahci_command_set_prd_size(AHCICommand *cmd, unsigned prd_size)
     ahci_command_set_sizes(cmd, cmd->xbytes, prd_size);
 }
 
+/* For a no-data command, whose count carries an argument of its own */
+void ahci_command_set_count(AHCICommand *cmd, uint16_t count)
+{
+    g_assert(!cmd->props->data);
+    cmd->fis.count = count;
+}
+
+void ahci_command_expect_error(AHCICommand *cmd, uint8_t err)
+{
+    cmd->interrupts |= AHCI_PX_IS_TFES;
+    cmd->errors |= err;
+}
+
 void ahci_command_adjust(AHCICommand *cmd, uint64_t offset, uint64_t buffer,
                          uint64_t xbytes, unsigned prd_size)
 {
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 2a48a7523d..6d861c79ee 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -278,6 +278,7 @@ enum {
     CMD_READ_MAX       = 0xF8,
     CMD_READ_MAX_EXT   = 0x27,
     CMD_FLUSH_CACHE    = 0xE7,
+    CMD_INIT_DP        = 0x91, /* INITIALIZE DEVICE PARAMETERS */
     CMD_IDENTIFY       = 0xEC,
     CMD_PACKET         = 0xA0,
     CMD_PACKET_ID      = 0xA1,
@@ -324,6 +325,9 @@ enum {
 #define ATA_DEVICE_DRIVE 0x10
 #define ATA_DEVICE_HEAD  0x0F
 
+/* ATA error register bits */
+#define ATA_ERR_ABRT     0x04
+
 /*** Structures ***/
 
 typedef struct AHCIPortQState {
@@ -638,6 +642,8 @@ void ahci_command_set_size(AHCICommand *cmd, uint64_t xbytes);
 void ahci_command_set_prd_size(AHCICommand *cmd, unsigned prd_size);
 void ahci_command_set_sizes(AHCICommand *cmd, uint64_t xbytes,
                             unsigned prd_size);
+void ahci_command_set_count(AHCICommand *cmd, uint16_t count);
+void ahci_command_expect_error(AHCICommand *cmd, uint8_t err);
 void ahci_command_set_acmd(AHCICommand *cmd, void *acmd);
 void ahci_command_enable_atapi_dma(AHCICommand *cmd);
 void ahci_command_adjust(AHCICommand *cmd, uint64_t lba_sect, uint64_t gbuffer,
-- 
2.53.0


