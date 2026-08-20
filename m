Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D9C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhl-0006pf-7C; Thu, 20 Aug 2026 06:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhi-0006nz-OQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhg-0008JV-77
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-476a130c138so2273399f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220534; x=1787825334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4OvjEK79iipyYsErass3i3smJBr1fz2J2WXOxSNzKOM=;
 b=cmWNdYDbFq+GPijd2GB+D+QWTcvjyNSjdigt6eVmbg0cqJpdKJfNbBJUEZLtuoZ+ms
 jUYwEhVZmv9yzPgVD0CzqX4N0BcyvsRIR3XZxBHCTK1Llt8ZIMCtD8W24/82PLJ6lYcn
 fi+YAa6nOOWWx0aDcCzrCGep4OrltqLt0OIZRkuxlZT6No4D7mAOK8o8/EGUGyofNeDQ
 T2xUP/uJR4C8XAu1Ml9TVqUSDJYMbLEOCfnlOYU7uDkzVUpymdQ/2pnPSgnmKt9P8oC5
 X4zEt3j4fOUBzwsdHWKGFvzbCE9YAzBAM/sraGZ4X4HbLyhlwb6iSG0JNHTFeL70Heg8
 mCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220534; x=1787825334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4OvjEK79iipyYsErass3i3smJBr1fz2J2WXOxSNzKOM=;
 b=NWbmVmQW/ASHb6DIBR3HZ/2HNoDTKKLzB4IWrFY0NAgT62y7NfTtI8wZfmHS3dveS+
 FoIWITBTQwYP2l1c8FV/1BxLcSpkdY2KpDnru8X/tyYBzPRFwW9j0Hw+0fiLnboV2omh
 ats44ZkDoTCU9NXyHHnQOFP08mXcclBdonApOl3r9olFZ2ZsfdSJqqN6YPjAdvbwMg5v
 bJD+sAlW0sStPzJx9pEFUr4n2T9x2nsOuS8NyYkeT53QSoh7JC3EPmuaoogvdGtgxxt7
 oK/00wdE44f9xWKuCqufQ3RCGd/+TNl25hIU2WR6LrZn3HPoH15/bqvu3/OsLSN1Qji+
 CRsw==
X-Gm-Message-State: AFuF++megy/JrrgXpsWOFLOo5EoU6axMP9mKLfLjeJgyAiR4fk3OTJ4q
 eba91vTEIDLe2rGuDE87jUObhECuDbHZdpiLQ6YdK2dUVSAkxC87LXClzImMwvquOOwSUu35jpT
 /8wHL
X-Gm-Gg: AR+sD12lPP4pKO0BGZYxbOnETkewcE5sJplL/2jHuDFnagd86777eWulyfbzR6QxKEh
 1BfMuY615J+SioK9hVWM+w8oyfvZ2P2NTWlBsiKgSBMoF8koslI7zRsYuHbizNW073SXgAdbZAQ
 ihQEhwBcaVISjSIIIrYbj967c2aPnb0YuJuJlTNkmkM6qnPUgZvEs8eidT0COJ30kBlRLKyLr61
 nY6KzF4+/cguyr/24EXeYMUHaqR2vrxUz6oIW8Cxi/84dMV5/O1pxTt6pCk34850jrXHc2VSIu9
 WaeiM160K+dTgfK+mRYyWLCRduoYOqRlTsou6Fib0YZVQq/cS3rR9Dtu11oTtO+uSQm7f9gmYhA
 ZAV7uht1rmINI4SYzZvZELHZBbAnEPJct2Jhu7kNHbp97mHi+hetfe4+AyzNQ3GTm1VYzoFqMqJ
 O9VUcxJtQ2a5Uwvd20Mn3YaqBsPBXSMA6ufC46S1o8ohFY/1/j1m48ChbDUQ==
X-Received: by 2002:a05:6000:41da:b0:47f:9557:8d77 with SMTP id
 ffacd0b85a97d-482b1e94d3emr21805108f8f.10.1787220534560; 
 Thu, 20 Aug 2026 03:08:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 03/17] tests/qtest/libqos/ahci: allow a count and an
 expected error
Date: Thu, 20 Aug 2026 12:08:30 +0200
Message-ID: <20260820100844.411717-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


