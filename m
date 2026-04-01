Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C341F10F931B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7kpe-0006MT-Ex; Tue, 31 Mar 2026 21:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1w7kpc-0006MG-0B
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 21:57:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1w7kpY-00074u-Gu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 21:57:19 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxjsN3e8xpYKcgAA--.27396S3;
 Wed, 01 Apr 2026 09:57:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxTMJ0e8xpdSliAA--.53961S4;
 Wed, 01 Apr 2026 09:57:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Cornelia Huck <cohuck@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/loongarch/virt: Define versioned virt machine
Date: Wed,  1 Apr 2026 09:57:05 +0800
Message-Id: <20260401015705.3009762-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260401015705.3009762-1-maobibo@loongson.cn>
References: <20260401015705.3009762-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTMJ0e8xpdSliAA--.53961S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add versioned virt machine started from QEMU 11.1

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c134b102c2..f68ccdb12b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1535,9 +1535,41 @@ static void virt_class_init(ObjectClass *oc, const void *data)
                                           "for PCI MMIO");
 }
 
+#define DEFINE_VIRT_MACHINE_VERSION(latest, ...) \
+    static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        const void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " LoongArch Virtual Machine"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        if (latest) { \
+            mc->alias = "virt"; \
+        } \
+    } \
+    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+    { \
+        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
+        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+    }; \
+    static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
+    { \
+        MACHINE_VER_DELETION(__VA_ARGS__); \
+        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
+    } \
+    type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
+
+#define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_VIRT_MACHINE_VERSION(true, major, minor)
+#define DEFINE_VIRT_MACHINE(major, minor) \
+    DEFINE_VIRT_MACHINE_VERSION(false, major, minor)
+
 static const TypeInfo virt_machine_info = {
     .name           = TYPE_LOONGARCH_VIRT_MACHINE,
     .parent         = TYPE_MACHINE,
+    .abstract       = true,
     .instance_size  = sizeof(LoongArchVirtMachineState),
     .class_init     = virt_class_init,
     .instance_init  = virt_initfn,
@@ -1553,3 +1585,8 @@ static void machvirt_machine_init(void)
 }
 
 type_init(machvirt_machine_init);
+
+static void virt_machine_11_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
-- 
2.39.3


