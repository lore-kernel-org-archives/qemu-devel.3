Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC60C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KVc-00019S-QB; Tue, 21 May 2024 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s9KVZ-00017s-JW
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s9KVU-0001W8-I4
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOOrhVUxm7DECAA--.1342S3;
 Tue, 21 May 2024 16:05:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcXdVUxm6O8DAA--.1310S3; 
 Tue, 21 May 2024 16:05:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/loongarch: Add loongarch vector property
 unconditionally
Date: Tue, 21 May 2024 16:05:48 +0800
Message-Id: <20240521080549.434197-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521080549.434197-1-maobibo@loongson.cn>
References: <20240521080549.434197-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRcXdVUxm6O8DAA--.1310S3
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

Currently LSX/LASX vector property is decided by the default value.
Instead vector property should be added unconditionally, and it is
irrelative with its default value. If vector is disabled by default,
vector also can be enabled from command line.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a0cad53676..b5c1ec94af 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -645,16 +645,10 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
 
 void loongarch_cpu_post_init(Object *obj)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
-        object_property_add_bool(obj, "lsx", loongarch_get_lsx,
-                                 loongarch_set_lsx);
-    }
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
-        object_property_add_bool(obj, "lasx", loongarch_get_lasx,
-                                 loongarch_set_lasx);
-    }
+    object_property_add_bool(obj, "lsx", loongarch_get_lsx,
+                             loongarch_set_lsx);
+    object_property_add_bool(obj, "lasx", loongarch_get_lasx,
+                             loongarch_set_lasx);
 }
 
 static void loongarch_cpu_init(Object *obj)
-- 
2.39.3


