Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A7DCE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 02:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smOZp-000508-Kf; Thu, 05 Sep 2024 22:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1smOZl-0004yZ-K5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 22:19:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1smOZj-0007I0-4f
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 22:19:53 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxXpnBZtpmdwUsAA--.47748S3;
 Fri, 06 Sep 2024 10:19:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_0e_ZtpmK54FAA--.4430S3;
 Fri, 06 Sep 2024 10:19:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] acpi: ged: Add macro for acpi ged sleep register
Date: Fri,  6 Sep 2024 10:19:42 +0800
Message-Id: <20240906021943.150494-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240906021943.150494-1-maobibo@loongson.cn>
References: <20240906021943.150494-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_0e_ZtpmK54FAA--.4430S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Macro definition is added for acpi ged sleep register, so that ged
emulation driver can use this, also it can be used in FDT table if
ged is exposed with FDT table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/acpi/generic_event_device.c         | 6 +++---
 include/hw/acpi/generic_event_device.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf..10a338877c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
 
     switch (addr) {
     case ACPI_GED_REG_SLEEP_CTL:
-        slp_typ = (data >> 2) & 0x07;
-        slp_en  = (data >> 5) & 0x01;
-        if (slp_en && slp_typ == 5) {
+        slp_typ = (data & ACPI_GED_SLP_TYP_MASK) >> ACPI_GED_SLP_TYP_SHIFT;
+        slp_en  = !!(data  & ACPI_GED_SLP_ENABLE);
+        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
         return;
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 40af3550b5..526fea6efe 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -82,7 +82,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_RESET_VALUE       0x42
 
 /* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
+#define ACPI_GED_SLP_TYP_SHIFT     0x02
 #define ACPI_GED_SLP_TYP_S5        0x05
+#define ACPI_GED_SLP_TYP_MASK      0x1C
+#define ACPI_GED_SLP_ENABLE        0x20
 
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
-- 
2.39.3


