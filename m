Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C47E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MJ-00041c-Cs; Thu, 19 Feb 2026 09:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Ly-0003lw-3Y
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lr-00086d-V6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:03 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso807252f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512597; x=1772117397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqBa/7C3Zm8WB1y+B8Ti6v5cmf7dq6/wP6QhxHVtEQs=;
 b=Aob3jCOBXfSl+s+hgNsVm3YZ37VW4sAetnUXkzmJu513h4zDoQgIl0Ts14KitStEnI
 7OauYDDssrw+AxfnQiuPmHAmQzBDWQew8rnOlo9FuCsLKI6T/2nrRW+2sQaayevx+9AC
 nV4Osa8JNXoNJ04aO0lpZsPJlWQWBJzLrq3Ywi3xFrmX3cRERN53P6vOzSOietagfnaf
 1lHcDn6SSteS4dyjSkb+i5jq7TMqBdL9qdliVYigWRYcau1Jg4ADZxnYRHejQ+Trt1YO
 4kItzVTTaRCwFKl07eg2KxwU0/9lUv3CWciFVvlrvwMzqf+kUNSkiHi7XAe6/bIM9A1y
 yckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512597; x=1772117397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqBa/7C3Zm8WB1y+B8Ti6v5cmf7dq6/wP6QhxHVtEQs=;
 b=uEO7f38r46XN15MJ5Bzb3+X4e6yJnGGQCJa1EQ2Lzy2cDSLvnLqELcd8saS79d+H0f
 ceUlr1lIqx6/bt9XvQ/3GLn9CK2aHBKamvSxXJdEW1I39TaLErdCTqVpay6veWS3ui1H
 dDfFjoKQgAEWKIoIOuSBh7woYB5ovaOWY21wZ24cmzQdd5Ciuq/Q9FWt/zQ89Kd88aTv
 i0MkLST8Sjxn8QxE9EwHUprwUHw/B54JWqZUjHtu1u5ILV1NHoKR0f4aP2RnzMo3kj8B
 3n+Ii8J9bfmJ7TdFLT0U8Zdz2LD2qK7YzOOUDQOBB+O/n8l11fIYcP4V8Y4+d+ocur03
 d2IQ==
X-Gm-Message-State: AOJu0Yzqi6z8mrZkFmoCl0ztiAtheXkwj+2brc3LgoUKS4nGs8AY+Vua
 AjZPKixDXgSAmz8vE7tm8LbiYi/URkCOHveraFX/Ctj3ugiHWM+3fv4/PGfkt/v3
X-Gm-Gg: AZuq6aIM/pJgHz7zBa8CgRS8qil1j6S4p5ypfSvwvTEh8yOUMmdCmRsMFWTmCdWdLjQ
 6H9yqn3yxZx0nSk7H18i4tw1DtP2Ijk0bEwu2iC6zKk6Fd/OQwuLDWGnwqGpHYOa6JIv9erFHSM
 oeTAR85c6sGWXnYlSekEhvHCZMCRUr8XseY5DqZu49luH+wjPUu3itYcd1DiuFQZIiT9bX4SWrU
 qDZRGFUhqqSE7rkNc4/Qx0JY9Xok7sva66beBoPmpp8N3V6QeHo1v7i05cNFzGj6if4CNgusFyk
 C0PcAlpBQwkqzr2wrhMkjdmnc5DhgFS0HNeSKnD3Zn8qfJg9SOAxhOY3HVrw1r8JUks9X0ojcEQ
 PLUtn6bphqs5QDHn4RlLeUoZzwcK5bcEoHlF6mOYIz6lxzrtC9TRF8NX8J/31cDAX+rIIEsfy62
 KoIvXHGKDFqLFwrNZq2lTCI/+JJ/iMXoZ8L+wJFY33xDlyJ6QCudyU522DPGPlnO2Fe5h5
X-Received: by 2002:a5d:4b09:0:b0:437:6bda:d979 with SMTP id
 ffacd0b85a97d-4396270852bmr2899449f8f.27.1771512597046; 
 Thu, 19 Feb 2026 06:49:57 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:56 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 31/33] hw/core/fdt_generic_util: Add blockdev binding
 support
Date: Thu, 19 Feb 2026 15:48:59 +0100
Message-ID: <20260219144901.3317747-13-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The path add possibility to bind to QEMU block backends
via the blockdev-node-name property.

This enables support for the modern -blockdev command line option.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 82 ++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 4ed9602d47..68dfeee096 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -75,6 +75,8 @@ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
                                        char *intc_node_path,
                                        uint32_t *cells, uint32_t num_cells,
                                        uint32_t max, Error **errp);
+static bool fdt_attach_blockdev(FDTMachineInfo *fdti,
+                                const char *node_path, Object *dev);
 
 typedef struct QEMUIRQSharedState {
     qemu_irq sink;
@@ -241,6 +243,8 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
     current_machine->smp.cpus = fdt_generic_num_cpus;
     current_machine->smp.max_cpus = fdt_generic_num_cpus;
 
+    bdrv_drain_all();
+
     DB_PRINT(0, "FDT: Device tree scan complete\n");
     return fdti;
 }
@@ -987,6 +991,52 @@ static void fdt_init_qdev_array_prop(Object *obj,
     DB_PRINT_NP(0, "set property %s propname to <list>\n", propname);
 }
 
+/*
+ * Try to attach by matching drive created by '-blockdev node-name=LABEL'
+ * iff the FDT node contains property 'blockdev-node-name=LABEL'.
+ *
+ * Return false unless the given node_path has the property.
+ *
+ * Presence of the property also disables the node from ever attached
+ * to any drive created by the legacy '-drive' QEMU option.
+ *
+ * For more on '-blockdev', see:
+ *   http://events17.linuxfoundation.org/sites/events/files/slides/talk_11.pdf
+ */
+static bool fdt_attach_blockdev(FDTMachineInfo *fdti,
+                                const char *node_path, Object *dev)
+{
+    static const char propname[] = "blockdev-node-name";
+    const char *label;
+
+    /* Inspect FDT node for blockdev-only binding */
+    label = qemu_fdt_getprop(fdti->fdt, node_path, propname,
+                             NULL, NULL);
+
+    /* Skip legacy node */
+    if (!label) {
+        return false;
+    }
+
+    /*
+     * Missing matching bdev is not an error: attachment is optional.
+     *
+     * error_setg() aborts, never returns: 'goto ret' is just sanity.
+     */
+    if (!label[0]) {
+        error_setg(&error_abort, "FDT-node '%s': property '%s' = <empty>",
+                   node_path, propname);
+        return false;
+    }
+
+    if (!bdrv_find_node(label)) {
+        return false;
+    }
+
+    object_property_set_str(OBJECT(dev), "drive", label, NULL);
+    return true;
+}
+
 static void fdt_parse_node_reg_prop(FDTMachineInfo *fdti, char *node_path,
                             Object *dev)
 {
@@ -1173,6 +1223,7 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     char *dev_type = NULL;
     QEMUDevtreeProp *prop, *props;
     char parent_node_path[DT_PATH_LENGTH];
+    bool defer_realize = false;
 
     if (!compat) {
         return 1;
@@ -1289,6 +1340,11 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
             continue;
         }
 
+        if (!strcmp(propname, "drive")) {
+            defer_realize = true;
+            continue;
+        }
+
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
@@ -1307,18 +1363,30 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
              */
             fdt_init_register_user_cpu_cluster(fdti, OBJECT(dev));
         } else {
-            object_property_set_bool(OBJECT(dev), "realized", true,
-                                     &error_fatal);
-            if (dc->legacy_reset) {
-                qemu_register_reset((void (*)(void *))dc->legacy_reset,
-                                    dev);
+            if (defer_realize) {
+                FDTDeferredNode *dnode = g_new0(FDTDeferredNode, 1);
+                *dnode = (FDTDeferredNode) {
+                        .dev = DEVICE(dev),
+                        .node_path = g_strdup(node_path),
+                        .next = fdti->deferred
+                };
+                fdti->deferred = dnode;
+            } else {
+                object_property_set_bool(OBJECT(dev), "realized", true,
+                                        &error_fatal);
+                if (dc->legacy_reset) {
+                    qemu_register_reset((void (*)(void *))dc->legacy_reset,
+                                        dev);
+                }
             }
         }
     }
 
-    fdt_parse_node_reg_prop(fdti, node_path, dev);
+    if (!defer_realize) {
+        fdt_parse_node_reg_prop(fdti, node_path, dev);
 
-    fdt_parse_node_irq_prop(fdti, node_path, dev);
+        fdt_parse_node_irq_prop(fdti, node_path, dev);
+    }
 
     g_free(dev_type);
     g_free(props);
-- 
2.43.0


