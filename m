Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D29E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 23:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnJa-00074n-0S; Mon, 09 Dec 2024 18:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJV-00074B-Ut
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:17 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJU-0007E3-Gp
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:17 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 6E8D640E31;
 Tue, 10 Dec 2024 00:37:15 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id lxDOULqeGGsw; Tue, 10 Dec 2024 00:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733787205;
 bh=yLW8IpbgYzCaxyrZWdDzDzRJttkMgWDc27IfUecH8bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T+w2IqBv1bOYs3wcAbnni+43TICkPZ3hemAgA2rnKBGDhSdye9o+hsVqTT9XwUOwf
 tu9Gq6ks4/5Po5NwdU46Cuno5GD0LfnU0BKUoIlzv5VSCRjwi4M3lm6RhEvEjBI2uh
 Dz3HMVybjAvshLn1RQlBJ7Guq/Nua2NFo9lM1xxYDwqRgvanwsBlDuUT0TtHqZjPh4
 XEM3LG/XW/SeHPek5la0GhCysqLe1XNWn8XhPO0WP5pZIpaT2j5iYKVo3wd0YmgVfx
 opw0IDj6KciGiGvJviubcZi9Jbzga+rsqrpf9nPyv8iJxmpQZZjnpxODOCfEbqLyWA
 DxFztgcZT0v+g==
Received: from fel.cvut.cz (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 96AF94097E;
 Tue, 10 Dec 2024 00:33:24 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [RFC 3/3] hw/net/can: WIP CTU CAN FD add parameter to specify IRQ
 controller on command line
Date: Tue, 10 Dec 2024 00:32:53 +0100
Message-Id: <2756d5a4999239f5ba9bd07237ab88230e7b7855.1733783500.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
References: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/net/can/ctucan_mm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/ctucan_mm.c b/hw/net/can/ctucan_mm.c
index 6d6b8aecb8..e599df18be 100644
--- a/hw/net/can/ctucan_mm.c
+++ b/hw/net/can/ctucan_mm.c
@@ -59,7 +59,8 @@ struct CtuCanMmState {
 
     struct {
         uint64_t    iobase;
-        uint32_t    irq;
+        uint32_t    irqnum;
+        char        *irqctrl;
     } cfg;
 
     MemoryRegion    ctucan_io_region;
@@ -144,9 +145,16 @@ static void ctucan_mm_realize(DeviceState *dev, Error **errp)
     if (d->cfg.iobase != 0) {
         sysbus_mmio_map(sbd, 0, d->cfg.iobase);
     }
-    if (d->cfg.irq != 0) {
+    if (d->cfg.irqnum != 0) {
         //const char *id = "/machine/unattached/device[3]/gic";
-        const char *id = "/machine/unattached/device[3]";
+        //const char *id = "/machine/unattached/device[3]";
+        char *id = d->cfg.irqctrl;
+
+        if (!id) {
+            error_setg(errp, "irqctrl object path is mandatory when irqnum is specified");
+            return;
+        }
+
         Object *obj = object_resolve_path_at(container_get(qdev_get_machine(), "/peripheral"), id);
         DeviceState *gicdev;
         if (!obj) {
@@ -158,7 +166,7 @@ static void ctucan_mm_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "%s is not a hotpluggable device", id);
             return;
         }
-        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(gicdev, d->cfg.irq));
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(gicdev, d->cfg.irqnum));
     }
     for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
         ctucan_init(&d->ctucan_state[i], d->irq);
@@ -243,7 +251,8 @@ static Property ctucan_mm_properties[] = {
     //DEFINE_PROP_UNSIGNED_NODEFAULT("base", CtuCanMmState, cfg.base,
     //                               qdev_prop_uint64, uint64_t),
     DEFINE_PROP_UINT64("iobase", CtuCanMmState, cfg.iobase, 0),
-    DEFINE_PROP_UINT32("irq", CtuCanMmState, cfg.irq, 0),
+    DEFINE_PROP_UINT32("irqnum", CtuCanMmState, cfg.irqnum, 0),
+    DEFINE_PROP_STRING("irqctrl", CtuCanMmState, cfg.irqctrl),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.5


