Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D02EE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57I-0000Bn-U0; Thu, 19 Feb 2026 09:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57G-0000AP-Sj
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57F-0002zH-2C
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so962732f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511691; x=1772116491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p7OUmEJMiBfURYJ4JeOsw/eoH+9F0GGVOCzGcWPVSw=;
 b=IByYDXE4AntdZsLnlphGtcsQ/AdULndKjN53Qt+OnExaoA20+nBZlLVhOIF97EZL7r
 5BrTKlCy3WICV+VnQUwPgr4b8dJ+jO1o2gHCZqIa1ah/FxiCaE5VuuZKr5jLX8+wUHHA
 /6nfHemXfpVlHfnqeXVbWjX04w7XJKghBC01A9aJmiXnwEPhVDiJ/VrvYW3CVv73SDtn
 wXIVV+qGwoLSuy5fZJX4B34wNxAfibYyzz33tI+OAISnbA7HccMF5pMEgFH+S3nZVO72
 2efDrIhazmWeRlYdXWmVKpnNbvXl5jc2iJ95TL9oploTxknVCXLPdfpzDqrNwD5TpkHx
 2VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511691; x=1772116491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8p7OUmEJMiBfURYJ4JeOsw/eoH+9F0GGVOCzGcWPVSw=;
 b=Cp84c2tDUT+Ib2W2nM2Qxh3dJ59COsxPJX9SMUXrvkjvGVwS4hAfAcLBNZFDobzA57
 DtJekQAoHmsov1283Psvar++Uv45eN7byaGp5/uZs7puEPwFuNdHXkQ29pWNdAWVwrk2
 FbeAyulZRkYmDsigqH6jI8f9YchSKWSBEw4Iu0wD12aky7HFWT/ll04XX+ZIiGr2JX5Z
 izYr0zfKPZUe+PD/bSOUQ/eX7qD51QzrKQMspGJnIP4oPvtsYvyuc2bjqMYMaX8vq8NN
 +03XcxO0QSieExrDB0joDU3dC9o7BgIoiO14uATg1lIX6NZuUO+ALuUj2tIt9OjfaWyd
 HGfg==
X-Gm-Message-State: AOJu0YwOUjS6iBr/3G3sHzcGDUeuDbOCuoxxa85WQiAdi+m7f9lrg3MF
 49/UbxisBVCpnRs6DPaD+fkeW9A2zB/durgFnOwwD7Pi3/t60m9o24NxfEA42QPi
X-Gm-Gg: AZuq6aK0IEz7nBWWgY6nxkA0jGuvZlESWN39j+tGBxqpXVp2z65UTGy7n6ITybHD/Y5
 n4gyifh6nI/Wvd5ln+2UWFmQzX3qbGgEjtAECJXhZIIinfzqd/tQUlrsADbbulN1Rh4KgyFYlRT
 hW8qJV/l/LW9VNZ2lgI+Li6R9ivbyJ8qg4MiUIdfrs1Lh48qg6kZVUKWY6A3Uq1rpJsjlV4Ff7M
 mHw5MtPMWEeN7J9/KwBt4jenHXoleAoe66eZ9vHX4LdjorYmr7y3W1YgMXsLE2Z/lpIRGzGg+su
 v0AJMdGy0olcOQM+3zLdOWEBQc1INfj/4kOikT+IEBeeLzZANhrPcQ+7Ko+EIPH4vwAt8p+Suzb
 L6eq5fH/D24tkSsJxQ8ak5rPRt79Aijrrpc6zeflPAz4ZdTu/Bpz0boYEh0x6VJ+CMo4hK7w32U
 37moPLRxJAuPjN/+fBHrPxAuv07J1G3qna4Y+BiKbgFhWH4Dy8syTcFOOLLaELGGMiRXLY
X-Received: by 2002:a05:6000:40dc:b0:437:6839:d5e with SMTP id
 ffacd0b85a97d-43958df370bmr9925523f8f.13.1771511690774; 
 Thu, 19 Feb 2026 06:34:50 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:50 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 10/33] hw/core/fdt_generic_util: initilize qdev properties
 from fdt
Date: Thu, 19 Feb 2026 15:33:09 +0100
Message-ID: <20260219143332.3316679-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x433.google.com
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

The patch adds possibility to read and parse device tree
node properties and set them to newly created object.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 222 +++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 8131511e70..2a3862b9ac 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -40,7 +40,9 @@
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
 #include "qemu/option.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/cpu/cluster.h"
+#include "qobject/qlist.h"
 
 #ifndef FDT_GENERIC_UTIL_ERR_DEBUG
 #define FDT_GENERIC_UTIL_ERR_DEBUG 3
@@ -342,6 +344,25 @@ static Object *fdt_create_from_compat(const char *compat, char **dev_type)
     return ret;
 }
 
+/*FIXME: roll into device tree functionality */
+
+static inline uint64_t get_int_be(const void *p, int len)
+{
+    switch (len) {
+    case 1:
+        return *((uint8_t *)p);
+    case 2:
+        return be16_to_cpu(*((uint16_t *)p));
+    case 4:
+        return be32_to_cpu(*((uint32_t *)p));
+    case 8:
+        return be32_to_cpu(*((uint64_t *)p));
+    default:
+        fprintf(stderr, "unsupported integer length\n");
+        abort();
+    }
+}
+
 /*
  * Error handler for device creation failure.
  *
@@ -369,10 +390,185 @@ static void fdt_dev_error(FDTMachineInfo *fdti, char *node_path, char *compat)
     }
 }
 
+static void fdt_init_qdev_link_prop(Object *obj, ObjectProperty *p,
+                                    FDTMachineInfo *fdti,
+                                    const char *node_path,
+                                    const QEMUDevtreeProp *prop)
+{
+    int len = prop->len;
+    const void *val = prop->value;
+    const char *propname = prop->name;
+
+    Object *linked_dev, *proxy;
+    char target_node_path[DT_PATH_LENGTH];
+    g_autofree char *propname_target = g_strconcat(propname, "-target", NULL);
+    Error *errp = NULL;
+
+    if (qemu_devtree_get_node_by_phandle(fdti->fdt, target_node_path,
+                                         get_int_be(val, len))) {
+        abort();
+    }
+
+    while (!fdt_init_has_opaque(fdti, target_node_path)) {
+        fdt_init_yield(fdti);
+    }
+    linked_dev = fdt_init_get_opaque(fdti, target_node_path);
+
+    proxy = linked_dev ? object_property_get_link(linked_dev,
+                                                  propname_target,
+                                                  &errp) : NULL;
+    if (!errp && proxy) {
+        DB_PRINT_NP(0, "detected proxy object for %s connection\n", propname);
+        linked_dev = proxy;
+    }
+
+    if (!linked_dev) {
+        linked_dev = object_resolve_link(obj, propname,
+                                         target_node_path, &errp);
+        if (!linked_dev) {
+            return;
+        }
+    }
+
+    errp = NULL;
+    object_property_set_link(obj, propname, linked_dev, &errp);
+    if (errp) {
+        /* Unable to set the property, maybe it is a memory alias? */
+        MemoryRegion *alias_mr;
+        int offset = len / 2;
+        int region = 0;
+
+        if (len > 4) {
+            region = get_int_be(val + offset, len - offset);
+        }
+
+        alias_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(linked_dev), region);
+
+        object_property_set_link(obj, propname, OBJECT(alias_mr), &error_abort);
+
+    }
+
+    DB_PRINT_NP(0, "set link %s\n", propname);
+}
+
+static void fdt_init_qdev_scalar_prop(Object *obj, ObjectProperty *p,
+                                      FDTMachineInfo *fdti,
+                                      const char *node_path,
+                                      const QEMUDevtreeProp *prop)
+{
+    const char *propname = trim_vendor(prop->name);
+    const void *val = prop->value;
+    int len = prop->len;
+
+    /* FIXME: handle generically using accessors and stuff */
+    if (!strncmp(p->type, "link", 4)) {
+        fdt_init_qdev_link_prop(obj, p, fdti, node_path, prop);
+        return;
+    }
+
+    if (!strcmp(p->type, "uint8") || !strcmp(p->type, "uint16") ||
+        !strcmp(p->type, "uint32") || !strcmp(p->type, "uint64") ||
+        !strcmp(p->type, "int8") || !strcmp(p->type, "int16") ||
+        !strcmp(p->type, "int32") || !strcmp(p->type, "int64")) {
+        object_property_set_int(obj, propname,
+                                get_int_be(val, len), &error_abort);
+        DB_PRINT_NP(0, "set property %s to 0x%llx\n", propname,
+                    (unsigned long long)get_int_be(val, len));
+        return;
+    }
+
+    if (!strcmp(p->type, "boolean") || !strcmp(p->type, "bool")) {
+        object_property_set_bool(obj, propname,
+                                 !!get_int_be(val, len), &error_abort);
+        DB_PRINT_NP(0, "set property %s to %s\n", propname,
+                    get_int_be(val, len) ? "true" : "false");
+        return;
+    }
+
+    if (!strcmp(p->type, "string") || !strcmp(p->type, "str")) {
+        object_property_set_str(obj, propname,
+                                (const char *)val, &error_abort);
+        DB_PRINT_NP(0, "set property %s to %s\n", propname, (const char *)val);
+        return;
+    }
+
+    DB_PRINT_NP(0, "WARNING: property is of unknown type\n");
+}
+
+static size_t fdt_array_elem_len(FDTMachineInfo *fdti,
+                                 const char *node_path,
+                                 const char *propname)
+{
+    g_autofree char *elem_cells_propname = NULL;
+    Error *err = NULL;
+    uint32_t elem_cells;
+
+    /*
+     * Default element size to 1 uint32_t cell, unless it is explicitly
+     * given in the same FDT node (not inherited).
+     */
+    elem_cells_propname = g_strconcat("#", propname, "-cells", NULL);
+    elem_cells = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                       elem_cells_propname, 0, &err);
+
+    return (err ? 1 : elem_cells) * 4;
+}
+
+static void fdt_init_qdev_array_prop(Object *obj,
+                                     FDTMachineInfo *fdti,
+                                     const char *node_path,
+                                     QEMUDevtreeProp *prop)
+{
+    const char *propname = trim_vendor(prop->name);
+    int nr = prop->len;
+    uint32_t elem_len;
+    QList *qlist = qlist_new();
+    const char *prop_type;
+    const void *prop_value = prop->value;
+
+    if (!prop->value || !nr) {
+        return;
+    }
+
+    elem_len = fdt_array_elem_len(fdti, node_path, propname);
+    if (nr % elem_len) {
+        return;
+    }
+
+    nr /= elem_len;
+
+    prop_type = qdev_prop_get_array_elem_type(DEVICE(obj), propname);
+    if (!prop_type) {
+        DB_PRINT_NP(0, "fail to get property array elem type\n");
+        return;
+    }
+
+    while (nr--) {
+        if (!strcmp(prop_type, "uint8") || !strcmp(prop_type, "uint16") ||
+            !strcmp(prop_type, "uint32") || !strcmp(prop_type, "uint64") ||
+            !strcmp(prop_type, "int8") || !strcmp(prop_type, "int16") ||
+            !strcmp(prop_type, "int32") || !strcmp(prop_type, "int64")) {
+                qlist_append_int(qlist, get_int_be(prop_value, elem_len));
+        } else if (!strcmp(prop_type, "boolean") || !strcmp(prop_type, "bool")) {
+            qlist_append_bool(qlist, !!get_int_be(prop_value, elem_len));
+        } else if (!strcmp(prop_type, "string") || !strcmp(prop_type, "str")) {
+            qlist_append_str(qlist, (const char *)prop_value);
+        }
+
+        prop_value += elem_len;
+
+        /* TBD: add link type support */
+    }
+
+    qdev_prop_set_array(DEVICE(obj), propname, qlist);
+    DB_PRINT_NP(0, "set property %s propname to <list>\n", propname);
+}
+
 static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
     char *dev_type = NULL;
+    QEMUDevtreeProp *prop, *props;
     char parent_node_path[DT_PATH_LENGTH];
 
     if (!compat) {
@@ -460,7 +656,33 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     }
     fdt_init_set_opaque(fdti, node_path, dev);
 
+    props = qemu_devtree_get_props(fdti->fdt, node_path);
+    for (prop = props; prop->name; prop++) {
+        const char *propname = trim_vendor(prop->name);
+        ObjectProperty *p = NULL;
+
+        p = object_property_find(OBJECT(dev), propname);
+        if (p) {
+            DB_PRINT_NP(1, "matched property: %s of type %s, len %d\n",
+                                            propname, p->type, prop->len);
+        }
+        if (!p) {
+            continue;
+        }
+
+        if (!strcmp(p->type, "list")) {
+            fdt_init_qdev_array_prop(dev, fdti, node_path, prop);
+        }
+
+        if (!strcmp(propname, "type")) {
+            continue;
+        }
+
+        fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
+    }
+
     g_free(dev_type);
+    g_free(props);
 
     return 0;
 }
-- 
2.43.0


