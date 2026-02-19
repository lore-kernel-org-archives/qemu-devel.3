Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94552E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57i-0000Ox-LV; Thu, 19 Feb 2026 09:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57c-0000Mr-Jv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:19 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57N-000324-BR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:35:03 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4362c635319so966912f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511699; x=1772116499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBtU3uaEPwuPpRBvsvyPYMG98mE7sqDUzmaB8W9wpLg=;
 b=IfoByRr/u5+unoFB/JOLfdTKk7IJmgkVx0Ag5eRE40zyk499SUVaRX8F21BccADkEi
 TT+mIc4MIVesQp5eU8h6ay2U8hzueZGYVzV4r0DQlg1VymQnbucWkGpT+JR9Ygj1SK/K
 6liKALA5oELBCh+lLF9Jx7Spaj5xtKQTdeTlDssRV+y63hD84bKE37GW48kD6hy+63E8
 kjDGtgdi/9bjBJx2D1XVV9HNHyfBdyMsoL93cdjzGLSxAL7YWnX5N7pObTho+2ECxsJY
 Yv3vv5Duejgs7Sa6F+vpHmhkDq7jJhrQAYfysNvXLRaAI3xJciaL+VuKcePQ2zUE8suB
 UIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511699; x=1772116499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kBtU3uaEPwuPpRBvsvyPYMG98mE7sqDUzmaB8W9wpLg=;
 b=P2SdNYY6Lh6mdDr6T1eZzcHvaZUzVFWEO2O+VapBHvkdMQCej9EgBFT7GnRRGX5hj/
 X4L8OeEOn+3QnyfX3jzzIbnxOKwKuccb+OAAdgbaB/fBBgaCJqvhk3Dog/SeBcZS/PJ1
 F++ij2W6HU8aMHGEh6sKZR5CTlyN1A//t70oZzaluApBWfcqNr0ysturPj/Wk87epmDD
 C9R6LdRKq6n2+9Ul7Sdz+/TIXTD2PpYQ/gkWoGW/Pnt+zkkTLcY3C8qPgNrSvDhOko/z
 viVZDRXvdJrKda/8RYxVWWQRAvBtkxH5+bW/HLgEosnZHHAsuP3IBAa2pPlUmSCLA8qH
 1w9w==
X-Gm-Message-State: AOJu0Yw75xv9o+6Qqq8h+Clgxb5kp1ORBTx+wILh9sjkSef10fwIHptW
 O7zItlq4FB290FdmXDDlz5Onr1fmJ1VjyzWWkGZPPDfPkRzKM4ycoeSzu5QSwkUu
X-Gm-Gg: AZuq6aJx86njk0lpO4Q9ekkZdPCPcd68x6CN1UUIcGng9VoRq3hMxmbkFJn+G8aGNCG
 3F2mAR46LJBPLzXFn0UvHurS8Ffy2S0bGzP2LAdpBWYTaL8b0yDYOEluEFJrjfi+sypOv4qDU0d
 9RJle3LO+U17HBvv2gRr4ypxowU3kuVLMEVg75+3VdQQX13pd8HSe3p+J0fC3o1tN4lyZeJFzTT
 1YuldpNZA7jQxXL+9sxxG2WEXzDHsI/Domt5Si8lRp9yapue01xcUIkbjJBeNC8i0qWcliZ0NgR
 saZQ53r8Kdhl2szTyKzInzJFIcP6gHCmWpqRIuZIJO+zP0daJ+H6DQqldLItUChA7AoM39gM9My
 aHhuVM2YUtHHUPLEyRKc+JDAuxT8dBVhhR6deMe+5zxJq4WiNup7efg8S1bLtAetw+j+gaoHm1v
 fWOTuaddD4ohl9LdZyIs2gZAAsJUPQPrFtnyUBwmPOX9SZ9cxHj5varSZUSFY/RGpri/GZ
X-Received: by 2002:a05:6000:2f86:b0:437:722d:5c6b with SMTP id
 ffacd0b85a97d-43958df34bbmr8901419f8f.9.1771511699392; 
 Thu, 19 Feb 2026 06:34:59 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:58 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 16/33] hw/core/fdt_generic_util: Connect device irqs
Date: Thu, 19 Feb 2026 15:33:15 +0100
Message-ID: <20260219143332.3316679-17-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements IRQ wiring logic for fdt created
devices.

The wiring performed in two stages. As devices are
created, their IRQs saved in the list.
After all devices processed, fdt_init_all_irqs() goes
through all IRQs and does actual wiring. For IRQs
which have multiple source, shared IRQ handler
allocated.

For interrupt controllers with auto_parent callback
implemented and their fdt node has 'interrupt and
'interrupts-extended' properties empty,
the auto_parent() will be called to connect them
to their interrupt-parent, for example to CPUs.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c    | 154 ++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h |  12 +++
 2 files changed, 166 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 838ed9a85c..63390e2f17 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -75,6 +75,88 @@ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
                                        uint32_t *cells, uint32_t num_cells,
                                        uint32_t max, Error **errp);
 
+typedef struct QEMUIRQSharedState {
+    qemu_irq sink;
+    int num;
+    bool (*merge_fn)(bool *, int);
+/* FIXME: remove artificial limit */
+#define MAX_IRQ_SHARED_INPUTS 256
+    bool inputs[MAX_IRQ_SHARED_INPUTS];
+} QEMUIRQSharedState;
+
+static bool qemu_irq_shared_or_handler(bool *inputs, int n)
+{
+    int i;
+
+    assert(n < MAX_IRQ_SHARED_INPUTS);
+
+    for (i = 0; i < n; ++i) {
+        if (inputs[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void qemu_irq_shared_handler(void *opaque, int n, int level)
+{
+    QEMUIRQSharedState *s = opaque;
+
+    assert(n < MAX_IRQ_SHARED_INPUTS);
+    s->inputs[n] = level;
+    qemu_set_irq(s->sink, s->merge_fn(s->inputs, s->num));
+}
+
+static void fdt_init_all_irqs(FDTMachineInfo *fdti)
+{
+    while (fdti->irqs) {
+        FDTIRQConnection *first = fdti->irqs;
+        qemu_irq sink = first->irq;
+        bool (*merge_fn)(bool *, int) = first->merge_fn;
+        int num_sources = 0;
+        FDTIRQConnection *irq;
+
+        for (irq = first; irq; irq = irq->next) {
+            if (irq->irq == sink) { /* Same sink */
+                num_sources++;
+            }
+        }
+        if (num_sources > 1) {
+            QEMUIRQSharedState *s = g_malloc0(sizeof *s);
+            s->sink = sink;
+            s->merge_fn = merge_fn;
+            qemu_irq *sources = qemu_allocate_irqs(qemu_irq_shared_handler, s,
+                                                   num_sources);
+            for (irq = first; irq; irq = irq->next) {
+                if (irq->irq == sink) {
+                    char *shared_irq_name = g_strdup_printf("shared-irq-%p",
+                                                            *sources);
+
+                    if (irq->merge_fn != merge_fn) {
+                        fprintf(stderr, "ERROR: inconsistent IRQ merge fns\n");
+                        exit(1);
+                    }
+
+                    object_property_add_child(OBJECT(irq->dev), shared_irq_name,
+                                              OBJECT(*sources));
+                    g_free(shared_irq_name);
+                    irq->irq = *(sources++);
+                    s->num++;
+                }
+            }
+        }
+        DB_PRINT(0, "%s: connected to %s irq line %d (%s)\n",
+                 first->sink_info ? first->sink_info : "",
+                 object_get_canonical_path(OBJECT(first->dev)),
+                 first->i, first->name ? first->name : "");
+
+        qdev_connect_gpio_out_named(DEVICE(first->dev), first->name, first->i,
+                                    first->irq);
+        fdti->irqs = first->next;
+        g_free(first);
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     char node_path[DT_PATH_LENGTH];
@@ -90,6 +172,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
         while (qemu_co_enter_next(fdti->cq, NULL)) {
             ;
         }
+        fdt_init_all_irqs(fdti);
         memory_region_transaction_commit();
     } else {
         fprintf(stderr, "FDT: ERROR: cannot get root node from device tree %s\n"
@@ -958,6 +1041,75 @@ exit_reg_parse:
     return;
 }
 
+static void fdt_parse_node_irq_prop(FDTMachineInfo *fdti, char *node_path,
+                            Object *dev)
+{
+    int is_intc;
+    int i, j;
+
+    if (!object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE)) {
+        return;
+    }
+
+    {
+        int len;
+        fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                                "interrupt-controller", &len);
+        is_intc = len >= 0;
+        DB_PRINT_NP(is_intc ? 0 : 1, "is interrupt controller: %c\n",
+                    is_intc ? 'y' : 'n');
+    }
+    /* connect irq */
+    j = 0;
+    for (i = 0;; i++) {
+        char irq_info[6 * 1024];
+        char *irq_info_p = irq_info;
+        bool map_mode;
+        int len = -1;
+        qemu_irq *irqs = fdt_get_irq_info(fdti, node_path, i, irq_info,
+                                            &map_mode);
+        /* INTCs inferr their top level, if no IRQ connection specified */
+        fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                            "interrupts-extended", &len);
+        if (!irqs && is_intc && i == 0 && len <= 0) {
+            FDTGenericIntc *id = (FDTGenericIntc *)object_dynamic_cast(
+                                    dev, TYPE_FDT_GENERIC_INTC);
+            FDTGenericIntcClass *idc = FDT_GENERIC_INTC_GET_CLASS(id);
+            if (id && idc->auto_parent) {
+                Error *err = NULL;
+                idc->auto_parent(id, &err);
+            } else {
+                irqs = fdti->irq_base;
+            }
+        }
+        if (!irqs) {
+            break;
+        }
+        while (*irqs) {
+            FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+            *irq = (FDTIRQConnection) {
+                .dev = DEVICE(dev),
+                .name = SYSBUS_DEVICE_GPIO_IRQ,
+                .merge_fn = qemu_irq_shared_or_handler,
+                .i = j,
+                .irq = *irqs,
+                .sink_info = g_strdup(irq_info_p),
+                .next = fdti->irqs
+            };
+            if (!map_mode) {
+                j++;
+            } else {
+                irq_info_p += strlen(irq_info_p) + 1;
+            }
+            fdti->irqs = irq;
+            irqs++;
+        }
+        if (map_mode) {
+            j++;
+        }
+    }
+}
+
 static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
@@ -1101,6 +1253,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_parse_node_reg_prop(fdti, node_path, dev);
 
+    fdt_parse_node_irq_prop(fdti, node_path, dev);
+
     g_free(dev_type);
     g_free(props);
 
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index 46b7dc084b..ad9e249156 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -24,6 +24,16 @@ typedef struct FDTCPUCluster {
     bool user;
 } FDTCPUCluster;
 
+typedef struct FDTIRQConnection {
+    DeviceState *dev;
+    const char *name;
+    int i;
+    bool (*merge_fn)(bool *, int);
+    qemu_irq irq;
+    char *sink_info; /* Debug only */
+    void *next;
+} FDTIRQConnection;
+
 typedef struct FDTMachineInfo {
     /* the fdt blob */
     void *fdt;
@@ -33,6 +43,8 @@ typedef struct FDTMachineInfo {
     FDTDevOpaque *dev_opaques;
     /* recheck coroutine queue */
     CoQueue *cq;
+    /* list of all IRQ connections */
+    FDTIRQConnection *irqs;
     /* list of all CPU clusters */
     FDTCPUCluster *clusters;
 } FDTMachineInfo;
-- 
2.43.0


