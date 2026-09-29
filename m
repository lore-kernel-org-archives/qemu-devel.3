Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F311CA5FAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBOLI-0004td-GJ; Mon, 28 Sep 2026 23:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOLC-0004ju-Pi
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:14 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOLA-0006xB-RH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:14 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0af6f9a1eso289332a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790651831; x=1791256631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8Kp3vM8Ljq0XL28nR8N7dHVd8Qe0r5Xu9im+lwmvww=;
 b=KwcoyJI8/RoTAniQ1m7zRqXKgH0TiHFLBfhEg5AgbdFm2nN4hAI/7lJedhUlbXLWvw
 xBqLpVv/RCvZRfp6vpnmOr94JAlQhR/YH4WU8TeR1M4H7QyTfbmajRnz2wt52xiBdmuT
 nwQ6yPIoJMZ7cVSHkkmVBNoTxazMuMsQlTExNDnifhnO1vZLxvEBAP2FF44OxFLJUfXc
 lgC/61ONE+oso3qwwhofQjthhtJO3Y18xng2y4SEmi1uZXwL+WP6FYtdDq0dxv+088DL
 rUlTIybejGe5VhrPlK2hpIlSCdWfY0DeY08dLf6yL7joPE4EE2abFLzMqAG8X92aFSL7
 jdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651831; x=1791256631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8Kp3vM8Ljq0XL28nR8N7dHVd8Qe0r5Xu9im+lwmvww=;
 b=Krwg51dfpDbmmb095+iUKyliKu3a670oYVx2oUYor58ybLzFmLZKq7c5kvo6/lK94Q
 wryyoYoRfbCcxUWiuXnphEP7dnq6zXCdC/j+mf07EwXB6HIohia3LTHqdZD0yDAPFaDi
 lMZcb9PET0CCzIXMyX966XeapoXpsWPAQ06m93KAYj2imhKALxy75u//0zbHmn6bqkNr
 WufTxEhCcuIuXFtNBWy2ESSLs7YFBp3wrbH9zBxYqCYrpMoX/+GAByLjv/hLUScjW+uF
 Co8884ItDJjJG9FHsEMVn2luqEd9o/7WIieLDKK5xitkIXVVdJvBvlAjVRhFJ6JFEDzq
 Wo1w==
X-Gm-Message-State: AFq9FYLB+pU7mXu0jDa4Kiar4W8YSzMvxOOjJ8PkilqNqNswavl3pwo4
 BYgfO1woocJ59jA3C4Kc4fFqjvFOJUZrKskq5BPszlq3V79+yXyvDpzaVihjHVq+0OO6H25qOBS
 n0VZXxbI=
X-Gm-Gg: AYBFou1JTx5Vlxqi/l4jtTPp1EejHMc/5GZ42EpMobm4DZRPuJiFJ4IZgxbeFIgoNw+
 cMx/c4MirNWTl8jOoa+IKtRr8Sqn2VAMwE/d5QAxqrjuFUBwXrcp2jzmVYaJF6LAL5wRwxZSzhP
 /zj7NdnzKJre4YW3Am5FbTMHp233XHJAirq7dgbwkXsq9PVNarzvJGFpODdmvAk4Gkzrw7DifgK
 2JcK4qjUWnUpFsVQ189tNLauhJ+2qanif/sR2prs3KxYLkL+5HY3kTwvCIdHPg/zc8MNQAB45ET
 sDBHYxF0r6bQqkll6rm4lSjkh1raTmNDCoHsE0Xntg640XPJ7mwX4bIXB3hRec7CHbgS9G27+Cp
 rtfv07L8yCvpV0Na302KLpqejFzeVnqV7PsZPloTSwnwGvD1G4e4j0r+03G3om0JFQKBjPW3U1F
 IyHz2wUr/TSD4fjXt/DdNYrUYWiAV1eq9b1tD4zauaPh+Z7Sxd9jgtp+5pww4SLL/lK4kyvct5s
 sKnJiUbxYoFkRrte+og6+OSudXHul+mj6SiDvYa7nwCK7I=
X-Received: by 2002:a17:90b:48c6:b0:3a0:7d5b:8d3e with SMTP id
 98e67ed59e1d1-3a0b23c0009mr17727947a91.1.1790651831389; 
 Mon, 28 Sep 2026 20:17:11 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a492dfc5absm1563641a91.3.2026.09.28.20.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:17:11 -0700 (PDT)
From: portias@oss.tenstorrent.com
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] hw/riscv/atlantis: Add machine property to select default
 uart
Date: Tue, 29 Sep 2026 13:16:43 +1000
Message-ID: <20260929031644.1016354-5-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The Atlantis SoC has 5 UARTs. This adds a machine property to set
which uart is on the first serial interface. This is the same pattern
that is used by aspeed. The rest of the uart's will be added in
sequential order starting at serial interface 1.

The default value is uart1 which means the Ascalon console will be on
serial interface 0 by default.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++----
 include/hw/riscv/tt_atlantis.h |  1 +
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index d567ec1155..32ba755bbf 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -420,6 +420,29 @@ static void load_fdt(TTAtlantisState *ams)
     create_fdt_memory(ms->fdt, &ams->soc);
 }
 
+static inline int tt_atlantis_uart_index(int uart_dev)
+{
+    return uart_dev - TT_ATL_UART0;
+}
+
+static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState *ams)
+{
+    TTAtlantisSoCState *s = &ams->soc;
+
+    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
+    int uart_index = tt_atlantis_uart_index(uart_chosen);
+
+    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev", serial_hd(0));
+
+    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
+        if (uart == uart_index) {
+            continue;
+        }
+        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev", serial_hd(i++));
+    }
+}
+
+
 static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
     TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
@@ -482,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
                               fdt_load_addr);
 }
 
-static inline int tt_atlantis_uart_index(int uart_dev)
-{
-    return uart_dev - TT_ATL_UART0;
-}
-
 static void tt_atlantis_soc_init(Object *obj)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
@@ -590,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller */
-    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
-                      "chardev", serial_hd(0));
-
     for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
         if (!sysbus_realize(sbd, errp)) {
@@ -661,6 +675,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
                              OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
+
+    /* Map serial interfaces to uart */
+    tt_atlantis_connect_serial_hds_to_uarts(ams);
+
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
@@ -678,6 +696,45 @@ static void tt_atlantis_machine_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
+static char *tt_atlantis_get_console(Object *obj, Error **errp)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
+
+    /* Default to Ascalon console */
+    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
+
+    return g_strdup_printf("uart%d", tt_atlantis_uart_index(uart_chosen));
+}
+
+static void tt_atlantis_set_console(Object *obj, const char *value, Error **errp)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
+
+    int val;
+    int uart_first = tt_atlantis_uart_index(TT_ATL_UART0);
+    int uart_last = tt_atlantis_uart_index(TT_ATL_UART4);
+
+    if (sscanf(value, "uart%d", &val) != 1 || val < 0) {
+        error_setg(errp, "Bad value for \"uart\" property");
+        return;
+    }
+
+    if (val < uart_first || val > uart_last) {
+        error_setg(errp, "\"uart\" should be in range [%d - %d]",
+                   uart_first, uart_last);
+        return;
+    }
+    ams->uart_chosen = val + TT_ATL_UART0;
+}
+
+static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
+{
+    object_class_property_add_str(oc, "console", tt_atlantis_get_console,
+                                  tt_atlantis_set_console);
+    object_class_property_set_description(oc, "console",
+                           "Change the default UART to \"uartX\"");
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -691,6 +748,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->default_ram_id = "tt_atlantis.ram";
+
+    tt_atlantis_machine_class_props_init(oc);
 }
 
 static const TypeInfo tt_atlantis_types[] = {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index b81b7c8abd..7bd46e9c9b 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -56,6 +56,7 @@ struct TTAtlantisState {
 
     MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
+    uint32_t uart_chosen;
 };
 
 enum {
-- 
2.43.0


