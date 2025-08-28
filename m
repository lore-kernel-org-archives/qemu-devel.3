Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D2CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIP-0007Gn-KZ; Thu, 28 Aug 2025 13:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1urbhS-00024E-51; Thu, 28 Aug 2025 08:25:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1urbhO-0002jx-S8; Thu, 28 Aug 2025 08:25:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz7_GSrBo3C8EAA--.7252S3;
 Thu, 28 Aug 2025 20:25:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxT+bCSrBoy2RuAA--.14734S4;
 Thu, 28 Aug 2025 20:25:42 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/2] hw/intc/loongarch_pch_pic: Fix ubsan warning and
 endianness issue
Date: Thu, 28 Aug 2025 20:02:18 +0800
Message-Id: <20250828120218.1227427-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250828120218.1227427-1-gaosong@loongson.cn>
References: <20250828120218.1227427-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+bCSrBoy2RuAA--.14734S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When booting the Linux kernel from tests/functional/test_loongarch64_virt.py
with a QEMU that has been compiled with --enable-ubsan, there is
a warning like this:

 .../hw/intc/loongarch_pch_pic.c:171:46: runtime error: index 512 out of
  bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
  .../hw/intc/loongarch_pch_pic.c:171:46
 .../hw/intc/loongarch_pch_pic.c:175:45: runtime error: index 256 out of
  bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
  .../hw/intc/loongarch_pch_pic.c:175:45

It happens because "addr" is added first before substracting the base
(PCH_PIC_HTMSI_VEC or PCH_PIC_ROUTE_ENTRY).
Additionally, this code looks like it is not endianness safe, since
it uses a 64-bit pointer to write values into an array of 8-bit values.

Thus rework the code to use the stq_le_p / ldq_le_p helpers here
and make sure that we do not create pointers with undefined behavior
by accident.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index c4b242dbf4..32f01aabf0 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -110,10 +110,10 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
         val = s->int_polarity;
         break;
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        val = *(uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
+        val = ldq_le_p(&s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC]);
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        val = *(uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
+        val = ldq_le_p(&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY]);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -129,7 +129,8 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset;
-    uint64_t old, mask, data, *ptemp;
+    uint64_t old, mask, data;
+    void *ptemp;
 
     offset = addr & 7;
     addr -= offset;
@@ -168,12 +169,12 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
         s->int_polarity = (s->int_polarity & ~mask) | data;
         break;
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        ptemp = (uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
-        *ptemp = (*ptemp & ~mask) | data;
+        ptemp = &s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC];
+        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        ptemp = (uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
-        *ptemp = (*ptemp & ~mask) | data;
+        ptemp = (uint64_t *)&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY];
+        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.47.0


