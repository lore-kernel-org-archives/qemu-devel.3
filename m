Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75905C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgz-0001Ob-AQ; Tue, 30 Apr 2024 03:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgy-0001Nl-1V
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgw-0008Tl-Gr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUlNiLOE+jPVHXcXzgEHVPWYRipoE14e5TSk0HWDpsw=;
 b=GqA6zOgU+IXR0b3H0RMKyIiqkRIro1uWVlbzACopQwIDEAsTRWd8CW6rRp6TT2O2IqNcxh
 zhX2UvR46cOplZFCuB9HigIVta1naOTQTD6to8LivqvnttMczifF3VPQiY1hWNMmxyj018
 q3xYbgFMyMJr9GXiStGAknJXQ34b0Mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-W6MdsolHPYmh3NHGQEgROw-1; Tue, 30 Apr 2024 03:14:11 -0400
X-MC-Unique: W6MdsolHPYmh3NHGQEgROw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 330CC803505;
 Tue, 30 Apr 2024 07:14:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4F540C6CC1;
 Tue, 30 Apr 2024 07:14:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Lev Kujawski <lkujaw@mailbox.org>
Subject: [PULL 17/19] tests/qtest/ide-test: Verify READ NATIVE MAX ADDRESS is
 not limited
Date: Tue, 30 Apr 2024 09:13:38 +0200
Message-ID: <20240430071340.413305-18-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Lev Kujawski <lkujaw@mailbox.org>

Verify that the ATA command READ NATIVE MAX ADDRESS returns the last
valid CHS tuple for the native device rather than any limit
established by INITIALIZE DEVICE PARAMETERS.

Signed-off-by: Lev Kujawski <lkujaw@mailbox.org>
Message-ID: <20221010085229.2431276-2-lkujaw@mailbox.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/ide-test.c | 47 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index d6b4f6e36a..90ba6b298b 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -34,7 +34,8 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
 
-#define TEST_IMAGE_SIZE 64 * 1024 * 1024
+/* Specified by ATA (physical) CHS geometry for ~64 MiB device.  */
+#define TEST_IMAGE_SIZE ((130 * 16 * 63) * 512)
 
 #define IDE_PCI_DEV     1
 #define IDE_PCI_FUNC    1
@@ -88,11 +89,13 @@ enum {
 enum {
     CMD_DSM         = 0x06,
     CMD_DIAGNOSE    = 0x90,
+    CMD_INIT_DP     = 0x91,  /* INITIALIZE DEVICE PARAMETERS */
     CMD_READ_DMA    = 0xc8,
     CMD_WRITE_DMA   = 0xca,
     CMD_FLUSH_CACHE = 0xe7,
     CMD_IDENTIFY    = 0xec,
     CMD_PACKET      = 0xa0,
+    CMD_READ_NATIVE = 0xf8,  /* READ NATIVE MAX ADDRESS */
 
     CMDF_ABORT      = 0x100,
     CMDF_NO_BM      = 0x200,
@@ -560,6 +563,46 @@ static void string_cpu_to_be16(uint16_t *s, size_t bytes)
     }
 }
 
+static void test_specify(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t cyls;
+    uint8_t heads, spt;
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    /* Initialize drive with zero sectors per track and one head.  */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+
+    /* READ NATIVE MAX ADDRESS (CHS mode).  */
+    qpci_io_writeb(dev, ide_bar, reg_device, 0xa0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_READ_NATIVE);
+
+    heads = qpci_io_readb(dev, ide_bar, reg_device) & 0xf;
+    ++heads;
+    g_assert_cmpint(heads, ==, 16);
+
+    cyls = qpci_io_readb(dev, ide_bar, reg_lba_high) << 8;
+    cyls |= qpci_io_readb(dev, ide_bar, reg_lba_middle);
+    ++cyls;
+    g_assert_cmpint(cyls, ==, 130);
+
+    spt = qpci_io_readb(dev, ide_bar, reg_lba_low);
+    g_assert_cmpint(spt, ==, 63);
+
+    ide_test_quit(qts);
+    free_pci_device(dev);
+}
+
 static void test_identify(void)
 {
     QTestState *qts;
@@ -1077,6 +1120,8 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
+    qtest_add_func("/ide/read_native", test_specify);
+
     qtest_add_func("/ide/identify", test_identify);
 
     qtest_add_func("/ide/diagnostic", test_diagnostic);
-- 
2.44.0


