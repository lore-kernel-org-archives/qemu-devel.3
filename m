Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5AECD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWvM-0005iE-Qn; Fri, 06 Sep 2024 07:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvH-00057f-RX; Fri, 06 Sep 2024 07:14:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvD-0007kQ-Lc; Fri, 06 Sep 2024 07:14:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FE488C481;
 Fri,  6 Sep 2024 14:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9CD6F1336EB;
 Fri,  6 Sep 2024 14:13:25 +0300 (MSK)
Received: (nullmailer pid 353595 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 17/69] hw/intc/loongson_ipi: Fix resource leak
Date: Fri,  6 Sep 2024 14:12:26 +0300
Message-Id: <20240906111324.353230-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Once initialised, QOM objects can be realized and
unrealized multiple times before being finalized.
Resources allocated in REALIZE must be deallocated
in an equivalent UNREALIZE handler.

Free the CPU array in loongson_ipi_unrealize()
instead of loongson_ipi_finalize().

Cc: qemu-stable@nongnu.org
Fixes: 5e90b8db382 ("hw/loongarch: Set iocsr address space per-board rather than percpu")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240723111405.14208-3-philmd@linaro.org>
(cherry picked from commit 0c2086bc7360565dfb9933181dafaefe2c94cddf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: rename loongson back to longarch for 9.0 due to lack of
 v9.0.0-582-gb4a12dfc2132 "hw/intc/loongarch_ipi: Rename as loongson_ipi")

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 521731342c..c210b51811 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -301,6 +301,13 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_ipi_unrealize(DeviceState *dev)
+{
+    LoongArchIPI *s = LOONGARCH_IPI(dev);
+
+    g_free(s->cpu);
+}
+
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
@@ -336,23 +343,16 @@ static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_ipi_realize;
+    dc->unrealize = loongarch_ipi_unrealize;
     device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongarch_ipi;
 }
 
-static void loongarch_ipi_finalize(Object *obj)
-{
-    LoongArchIPI *s = LOONGARCH_IPI(obj);
-
-    g_free(s->cpu);
-}
-
 static const TypeInfo loongarch_ipi_info = {
     .name          = TYPE_LOONGARCH_IPI,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(LoongArchIPI),
     .class_init    = loongarch_ipi_class_init,
-    .instance_finalize = loongarch_ipi_finalize,
 };
 
 static void loongarch_ipi_register_types(void)
-- 
2.39.2


