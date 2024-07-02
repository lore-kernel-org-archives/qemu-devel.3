Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA30C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYRx-0006Nu-QX; Tue, 02 Jul 2024 04:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOYRi-0006Kb-SQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOYRg-0005cU-Sy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719907258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZRM4BwQ0Q0UUgw6gRy025H1tQH+u6ZlWALPP8h7+VE=;
 b=E0zF1GhiMDkUdjzqBWoM8r5zwJJ26Nq3n10T2HqqY1aRUX8SDjY/75udtqELQKxy07zMWp
 qNPs6OfNZepnZw+e/5jU7lZmtVh5WxtdcvlxmNfsT/5OJQbGhwsCSGiMx6N+qCv6V/fnIp
 gSAjVCEmBAgpVb+eKa4XNna0RuH3eKE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-4UHOWppZNPW-dZnuTgDxSg-1; Tue,
 02 Jul 2024 04:00:54 -0400
X-MC-Unique: 4UHOWppZNPW-dZnuTgDxSg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABF18195608F; Tue,  2 Jul 2024 08:00:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.90])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD79919560AA; Tue,  2 Jul 2024 08:00:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 1/6] hw/gpio/aspeed: Add reg_table_count to AspeedGPIOClass
Date: Tue,  2 Jul 2024 10:00:37 +0200
Message-ID: <20240702080042.464220-2-clg@redhat.com>
In-Reply-To: <20240702080042.464220-1-clg@redhat.com>
References: <20240702080042.464220-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
function. This issue occurred when reading beyond the bounds of the
reg_table.

To enhance the safety and maintainability of the Aspeed GPIO code, this commit
introduces a reg_table_count member to the AspeedGPIOClass structure. This
change ensures that the size of the GPIO register table is explicitly tracked
and initialized, reducing the risk of errors if new register tables are
introduced in the future.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine ast1030-evb -qtest stdio
readq 0x7e780272
EOF

ASAN log indicating the issue:
==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
READ of size 2 at 0x55a5da29e128 thread T0
    #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
    #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:11
    #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
    #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:1426:16
    #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459:9
    #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:2836:18
    #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
    #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2355
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 include/hw/gpio/aspeed_gpio.h |  1 +
 hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
index 904eecf62c4c..90a12ae3182a 100644
--- a/include/hw/gpio/aspeed_gpio.h
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -75,6 +75,7 @@ struct AspeedGPIOClass {
     uint32_t nr_gpio_pins;
     uint32_t nr_gpio_sets;
     const AspeedGPIOReg *reg_table;
+    unsigned reg_table_count;
 };
 
 struct AspeedGPIOState {
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index c1781e2ba36f..6474bb8de5b5 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -559,6 +559,12 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t size)
         return debounce_value;
     }
 
+    if (idx >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
@@ -785,6 +791,12 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
 
+    if (idx >= agc->reg_table_count) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: idx 0x%" PRIx64 " out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+
     reg = &agc->reg_table[idx];
     if (reg->set_idx >= agc->nr_gpio_sets) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
@@ -1117,6 +1129,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 216;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
@@ -1127,6 +1140,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 228;
     agc->nr_gpio_sets = 8;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
@@ -1137,6 +1151,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 208;
     agc->nr_gpio_sets = 7;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
@@ -1147,6 +1162,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 36;
     agc->nr_gpio_sets = 2;
     agc->reg_table = aspeed_1_8v_gpios;
+    agc->reg_table_count = GPIO_1_8V_REG_ARRAY_SIZE;
 }
 
 static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
@@ -1157,6 +1173,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
     agc->nr_gpio_pins = 151;
     agc->nr_gpio_sets = 6;
     agc->reg_table = aspeed_3_3v_gpios;
+    agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
 }
 
 static const TypeInfo aspeed_gpio_info = {
-- 
2.45.2


