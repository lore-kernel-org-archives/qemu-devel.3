Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48559C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzVj-0004uA-Hk; Wed, 15 Jul 2026 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjzVh-0004sp-5l; Wed, 15 Jul 2026 09:18:49 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjzVc-0003wD-0n; Wed, 15 Jul 2026 09:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OE
 sWXniuKuS7Dv64452nhmMS0A0cBn43enStB4hf4kg=; b=YUdZh0/V7UwDKWDUs1
 u1TAiLAauf3cBGl0yJRgVm8nMJJ11ZqtP8RG/mow3N5y0IomDjK9jqHCtHAzRliB
 E0ffqXY68QEWkqJisCcDQ6NINrd4GSeHBaqvazRMa2LwLCfTyuQgOt1OBdQlcbSZ
 XEOp21IQ98zTmezjVaGU9wUNw=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3f9ieiFdqI6DwJA--.41397S3; 
 Wed, 15 Jul 2026 21:18:23 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 1/1] hw/char: imx_serial: add missing migration state
Date: Wed, 15 Jul 2026 21:18:19 +0800
Message-ID: <20260715131819.14827-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715131819.14827-1-dingtao0430@163.com>
References: <20260715131819.14827-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f9ieiFdqI6DwJA--.41397S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr43WryxWryDCFWrWF4DJwb_yoW5Jr18pr
 4Utr45KrWkAFn8Aa18Z3W3ur4rKFsY93W7CryxXwnYk3W5tr1Sy342yayI93s3JrWvkw1a
 vFZ2yry2vw1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziPkuxUUUUU=
X-Originating-IP: [119.4.20.225]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4R+592pXiJ-0RwAA3p
Received-SPF: pass client-ip=117.135.210.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add ucr2 from imx_serial to vmstate, and increment the version_id.

Migrating on sabrelite can reproduce this issue:
1. Prepare the U-Boot required for sabrelite. (according to sabrelite.rst)
2. Compile qemu
    $ mkdir build && cd build && ../configure --target-list="arm-softmmu" && make -j4
3. Start sabrelite and prepare for migration
    $ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot
4. Enter qemu monitor after uboot. (ctrl + a + c)
    (qemu) stop
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
    (qemu) migrate -d file:vmstate
    (qemu) q

Load the migrated vmstate, before repairing:

$ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot -incoming file:vmstate

(ctrl + a + c)
    QEMU 11.0.50 monitor - type 'help' for more information
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00000004 0x00000784 0x00008000 0x00000a01
    (qemu) q

It can be found that the data for address 0x021e8084 (register of usr2 in imx_serial of sabrelite) 
is not the data before the migration.

After being repaired:
$ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot -incoming file:vmstate
(ctrl + a + c)
    QEMU 11.0.50 monitor - type 'help' for more information
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/char/imx_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 080b7f6331..fb41ee2ac5 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -43,14 +43,15 @@
 
 static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(rx_fifo, IMXSerialState),
         VMSTATE_TIMER(ageing_timer, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
         VMSTATE_UINT32(ucr1, IMXSerialState),
+        VMSTATE_UINT32(ucr2, IMXSerialState),
         VMSTATE_UINT32(uts1, IMXSerialState),
         VMSTATE_UINT32(onems, IMXSerialState),
         VMSTATE_UINT32(ufcr, IMXSerialState),
-- 
2.43.0


