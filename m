Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8923D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd0-0001Um-By; Mon, 26 Jan 2026 12:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQch-0001K2-Rg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQce-0008Ux-Ba
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso2489739f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449410; x=1770054210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pJUy/63qhBUwsqcB6OYBXIeWXNm5psLvRgfscs8p7w=;
 b=HUhyt+4gc53HZU/8gTHzhsSJnsaH+03OJy8kWPg03XyvrH80sgvgKU/EBQPcVyoNyg
 1wZ7UHrPula1foCpBxaiEy1Px4xp8QnHLjxGvEZkGpEA0wQSf/qsLdbL44Zmqa1jjPDr
 qjq76k3vtR0eMrNkYv6eZvAZF/+BWF94qHm6Ve3uY+z0+yR4XLmYIdS5URjtca78VVXD
 cRHj+hCdytftFzjgQyVNDawNEuPFgCihIuKD9KZXl2mYYekebFDFijzx/ZcVwncilhhe
 QJguBCUZHuDPUrVnYF6OgEjFWtp+38tA5mj/gGPJg9SOWNi4T+48mOt/bnuJI/0b5i+u
 xDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449410; x=1770054210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pJUy/63qhBUwsqcB6OYBXIeWXNm5psLvRgfscs8p7w=;
 b=AtEoLtWVyBiK4ercHV6qlb1MZrzvSnno8bilJZIZGLakQcRLOycl9k3vNIu1oL2KDN
 +9mtadPurqc9UNm4Le+nDAgCbUNLuXlAIGUmEBgzyDUNMp7E+LDPKj0uVuVtaPnUuPGI
 VH7wdf7DS6Yf3XXM1G0n+636D2NCLjUjdSNvrVpCZjFhs6K4pseRdHFuVqAYprSnE3bo
 awNm3+mJ51DuY/mPaH7kbB02i/osjj6r/PBGFyEaDZME1tpuusxNCsezwYDbEA1nCssu
 gW95dW9wMMqx2uL8fD3JwJ4w6SQ7oBQDPyxMNQII9RpAKe4BHp4XtoWJp3ig/MGk5Ta+
 Ff4g==
X-Gm-Message-State: AOJu0YxOFvjltFH8w8d9utbKNzo7DFCj+PyWfE5EdfmjGDqRpnjClF36
 gKQplX4MkJs0jJgFBAfChqAXK/kJZFB/RczbJUgmf1tHt8nmvMlNVX/sDJg83Jl8NZQ=
X-Gm-Gg: AZuq6aIIdMjOcCGL47yTRwNnEq0T6f/GnTXXSiUakWYDOTfSlpziWXdiOfV7DpLAnIY
 sAT4RsBD8eNyK7DaJLQjZgKC0BLw/WgGByOk4gdzu97Pz8X9FplB5COhUOy6h3SUH28i74jKZku
 iI4gbZUg59n8RY+oM6EmdozpT2BQOqaqVvG1btb50mrtaVaXuXDaRlwkIYNjZt8V5f0VC2cDU9f
 4VoexBqBYhxzEjGwscE9+3CHxPCBvFgbvvmgDpzmd4xNyDcwtorDQgIR/IEL0aL8aqn4WkvCcak
 twKxhna7S+Tk+gQyW46f90zANA6APJZ5dbSZIxSKqnSa0bL+BAzBcGq3+lhctDc/EBmU9Np9qxa
 dRAIPBCf54wEwrMi/h3Cq4xi9KgE7xH7g8znoSqt6UuQVrdKVmUaWu+rem5LydM03y96w7vPaGK
 5uHD8wuC3Op0WPz4+41rB5DncLxe9hTwwlMkIgEAbdi2T7sqLTh43gwV3f4oh/9Jt6
X-Received: by 2002:a05:6000:1a87:b0:430:96bd:411b with SMTP id
 ffacd0b85a97d-435ca3a9306mr9195416f8f.58.1769449410136; 
 Mon, 26 Jan 2026 09:43:30 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:29 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 06/27] hw/core/fdt_generic: add cpu clusters management
Date: Mon, 26 Jan 2026 18:42:52 +0100
Message-ID: <20260126174313.1418150-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x441.google.com
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

Add support for grouping CPUs into clusters during
FDT machine instantiation.

The clusters are automatically created if CPU parent
is not already an existing cluster.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic.c         | 77 +++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h | 13 ++++++
 2 files changed, 90 insertions(+)

diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
index b3ef0b7d0a..3c28f42491 100644
--- a/hw/core/fdt_generic.c
+++ b/hw/core/fdt_generic.c
@@ -31,6 +31,7 @@
 #include "migration/vmstate.h"
 #include "qemu/coroutine.h"
 #include "qemu/log.h"
+#include "hw/cpu/cluster.h"
 #include "system/reset.h"
 
 #ifndef FDT_GENERIC_ERR_DEBUG
@@ -175,6 +176,75 @@ int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path)
     return 0;
 }
 
+static int get_next_cpu_cluster_id(void)
+{
+    static int i;
+
+    return i++;
+}
+
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster)
+{
+    int i = get_next_cpu_cluster_id();
+    DeviceState *dev = DEVICE(cluster);
+    FDTCPUCluster *cl;
+
+    qdev_prop_set_uint32(dev, "cluster-id", i);
+
+    cl = g_new0(FDTCPUCluster, 1);
+    cl->cpu_cluster = cluster;
+    cl->next = fdti->clusters;
+    cl->user = true;
+
+    fdti->clusters = cl;
+
+    DB_PRINT(0, "%s: Registered user-defined cpu cluster with id %d\n",
+             object_get_canonical_path(cluster), i);
+}
+
+static void *fdt_init_add_cpu_cluster(FDTMachineInfo *fdti, char *compat)
+{
+    FDTCPUCluster *cl = g_malloc0(sizeof(*cl));
+    int i = get_next_cpu_cluster_id();
+    char *name = g_strdup_printf("cluster%d", i);
+    Object *obj;
+
+    obj = object_new(TYPE_CPU_CLUSTER);
+    object_property_add_child(object_get_root(), name, OBJECT(obj));
+    qdev_prop_set_uint32(DEVICE(obj), "cluster-id", i);
+
+    cl->cpu_type = g_strdup(compat);
+    cl->cpu_cluster = obj;
+    cl->next = fdti->clusters;
+
+    fdti->clusters = cl;
+
+    g_free(name);
+
+    return obj;
+}
+
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent,
+                               char *compat)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    if (object_dynamic_cast(parent, TYPE_CPU_CLUSTER)) {
+        /* The direct parent of this CPU is a CPU cluster. Use it. */
+        return parent;
+    }
+
+    while (cl) {
+        if (!cl->user && !strcmp(compat, cl->cpu_type)) {
+            return cl->cpu_cluster;
+        }
+        cl = cl->next;
+    }
+
+    /* No cluster found so create and return a new one */
+    return fdt_init_add_cpu_cluster(fdti, compat);
+}
+
 void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path)
 {
     FDTDevOpaque *dp;
@@ -199,8 +269,15 @@ FDTMachineInfo *fdt_init_new_fdti(void *fdt)
 
 void fdt_init_destroy_fdti(FDTMachineInfo *fdti)
 {
+    FDTCPUCluster *cl = fdti->clusters;
     FDTDevOpaque *dp;
 
+    while (cl) {
+        FDTCPUCluster *tmp = cl;
+        cl = cl->next;
+        g_free(tmp->cpu_type);
+        g_free(tmp);
+    }
     for (dp = fdti->dev_opaques; dp->node_path; dp++) {
         g_free(dp->node_path);
     }
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index a21e3c2440..46b7dc084b 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -17,6 +17,13 @@ typedef struct FDTDevOpaque {
     void *opaque;
 } FDTDevOpaque;
 
+typedef struct FDTCPUCluster {
+    char *cpu_type;
+    void *cpu_cluster;
+    void *next;
+    bool user;
+} FDTCPUCluster;
+
 typedef struct FDTMachineInfo {
     /* the fdt blob */
     void *fdt;
@@ -26,6 +33,8 @@ typedef struct FDTMachineInfo {
     FDTDevOpaque *dev_opaques;
     /* recheck coroutine queue */
     CoQueue *cq;
+    /* list of all CPU clusters */
+    FDTCPUCluster *clusters;
 } FDTMachineInfo;
 
 /*
@@ -73,6 +82,10 @@ void fdt_init_set_opaque(FDTMachineInfo *fdti, char *node_path, void *opaque);
 int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path);
 void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path);
 
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent,
+                               char *compat);
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster);
+
 /* statically register a FDTInitFn as being associate with a compatibility */
 
 #define fdt_register_compatibility_opaque(function, compat, n, opaque) \
-- 
2.43.0


