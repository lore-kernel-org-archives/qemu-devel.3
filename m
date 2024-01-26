Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC3C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQ5M-0008RD-DQ; Fri, 26 Jan 2024 12:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ5B-0008BD-Ec; Fri, 26 Jan 2024 12:33:37 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ58-0001cf-B3; Fri, 26 Jan 2024 12:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=OdxzKrubfC0ZaYycLGHWamGW/MHu3AZpCkbdAJlgMyI=; b=oLyNvxBjpIrjGRRU3R48knb+RJ
 HGX4tMfXsp1iRB4pIZ7NBDTIhTAKm3Wo8Qzxg8b3FXNy6G7bp4/3Q1XhZA1UniQnrDX5a+wRDU7oO
 i2hMEaCbTfbVfs5a2hotsQ/cQ3lhYHtDc8VutRmH0woi0XpvA5OZXZcwfAOsQZS36JeB/nPaSRk8R
 p/dMQqB8K5HxG0sI12RIlxWxy7Dvn6HPOeeAFRlVTUSbyMlAYrtkETpxYLgzemRWOvBEah7v4QXLu
 6tvEyocuOhm7RAexy7qTfKmD0eZBrGjSXZI1q9ZWcVufyRe+Fx7dTOpo5V87/ZEgk/ajitS8bQXGL
 mh3Xldiw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rTQ48-0000000EKUJ-0gas; Fri, 26 Jan 2024 17:32:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rTQ47-00000001elM-0UcP;
 Fri, 26 Jan 2024 17:32:31 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 03/47] net: add qemu_create_nic_bus_devices()
Date: Fri, 26 Jan 2024 17:24:40 +0000
Message-ID: <20240126173228.394202-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126173228.394202-1-dwmw2@infradead.org>
References: <20240126173228.394202-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

This will instantiate any NICs which live on a given bus type. Each bus
is allowed *one* substitution (for PCI it's virtio → virtio-net-pci, for
Xen it's xen → xen-net-device; no point in overengineering it unless we
actually want more).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/net/net.h | 22 ++++++++++++++++++++
 net/net.c         | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index dff1872b4d..728ca965af 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -248,6 +248,28 @@ bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
  */
 DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
                                     const char *alias);
+
+/*
+ * qemu_create_nic_bus_devices: Create configured NIC devices for a given bus
+ * @bus: Bus on which to create devices
+ * @parent_type: Object type for devices to be created (e.g. TYPE_PCI_DEVICE)
+ * @default_model: Object type name for default NIC model (or %NULL)
+ * @alias: Additional model string to replace, for user convenience
+ * @alias_target: Actual object type name to be used in place of @alias
+ *
+ * Instantiate dynamic NICs on a given bus, typically a PCI bus. This scans
+ * for available NIC configurations which either specify a model which is
+ * a child type of @parent_type, or which do not specify a model when
+ * @default_model is non-NULL. Each device is instantiated on the given @bus.
+ *
+ * A single substitution is supported, e.g. "xen" → "xen-net-device" for the
+ * Xen bus, or "virtio" → "virtio-net-pci" for PCI. This allows the user to
+ * specify a more understandable "model=" parameter on the command line, not
+ * only the real object typename.
+ */
+void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
+                                 const char *default_model,
+                                 const char *alias, const char *alias_target);
 void print_net_client(Monitor *mon, NetClientState *nc);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
diff --git a/net/net.c b/net/net.c
index 962904eaef..4651b3f443 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1223,6 +1223,59 @@ DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
     return dev;
 }
 
+void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
+                                 const char *default_model,
+                                 const char *alias, const char *alias_target)
+{
+    GPtrArray *nic_models = qemu_get_nic_models(parent_type);
+    const char *model;
+    DeviceState *dev;
+    NICInfo *nd;
+    int i;
+
+    if (nic_model_help) {
+        if (alias_target) {
+            add_nic_model_help(alias_target, alias);
+        }
+        for (i = 0; i < nic_models->len - 1; i++) {
+            add_nic_model_help(nic_models->pdata[i], NULL);
+        }
+    }
+
+    /* Drop the NULL terminator which would make g_str_equal() unhappy */
+    nic_models->len--;
+
+    for (i = 0; i < nb_nics; i++) {
+        nd = &nd_table[i];
+
+        if (!nd->used || nd->instantiated) {
+            continue;
+        }
+
+        model = nd->model ? nd->model : default_model;
+        if (!model) {
+            continue;
+        }
+
+        /* Each bus type is allowed *one* substitution */
+        if (g_str_equal(model, alias)) {
+            model = alias_target;
+        }
+
+        if (!g_ptr_array_find_with_equal_func(nic_models, model,
+                                              g_str_equal, NULL)) {
+            /* This NIC does not live on this bus. */
+            continue;
+        }
+
+        dev = qdev_new(model);
+        qdev_set_nic_properties(dev, nd);
+        qdev_realize_and_unref(dev, bus, &error_fatal);
+    }
+
+    g_ptr_array_free(nic_models, true);
+}
+
 static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
     const Netdev *netdev,
     const char *name,
-- 
2.43.0


