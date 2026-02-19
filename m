Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE5E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57C-00006U-PW; Thu, 19 Feb 2026 09:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt57B-000059-56
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt579-0002xF-IR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:48 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-48374014a77so11194055e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511685; x=1772116485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pJUy/63qhBUwsqcB6OYBXIeWXNm5psLvRgfscs8p7w=;
 b=YOIs7cMC+T+KVKzVzWrh6scejrgf54AiisdUnC/tz4swK6fQOxcI7oOzZYQeiyJb58
 rDscykermByucnaxPytJxyClKMAh0Y0gG5UJB7YOOtXYudn+gE6kQ1us6c98cLdJMAXF
 QJOL3/UV0d2Cgzu9dkUS627LSCVgel3ZJLcbI31C6P0MJ17s/HCAeEtYDzwgWh7uSWdp
 UFiYB458ILvHixKt8ZJJfC+TlvHSYO8vuSAl998poyvrGuFdQ1M0Ol9zLy6x6sFn+dv4
 cMXsEYRuOC4nmIjCqznrCGAzykFn2500kYauwDFiF18cy6LrEZn45CuzsRl9nnznNw7i
 rzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511685; x=1772116485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pJUy/63qhBUwsqcB6OYBXIeWXNm5psLvRgfscs8p7w=;
 b=fM40MqXQaI9S7WPXUYzvIt4iQlMJGitcmIJJ8yVEURCd2t5vPKSBRwd3ZP+KcmX/rw
 kRwyIwHCNKlZvjmbCdOJYnBzskdBfAWLFwXRuR29uQTf5vAMvxa4CmQBeXwS4EYxqIOx
 KDbm+1a3b5hy7rquyxSXNxiqAMbtBkJ5TcWDDiO7UbQh4jME9Q5Nte1MnYGSWWjxnm4Q
 izYzQOFW8jDq6muy+krEYuRJmxZbdhks5evNun3HY4yEr1b8xPVU6oXD1UTJtRgmzWMs
 +Nvk71cj6+R6orQPXzIUdehkMaiwEn/J1z5NOnDPytAi/o/AQdZeBKlnTCrPpDeVCBor
 OoNA==
X-Gm-Message-State: AOJu0Yx/Kat2lOazcjC7/C2utTIa9V9XKZMeBPce8v0CaQZli3Wgimwo
 +Bqi1zmf7AjLwqJWVSEcwOxQcyhQJU4vpOUHiutY+5zWAa4fm7rfh4skRy2FXGT4GLY=
X-Gm-Gg: AZuq6aK+mk3ZoWHYu7wNBJiDBk9JMkX5NmX+71P1p7tSJt6rpljm/cde2+glG1kjjRL
 hfIe16DpZc1qnix2rwXVRV2QI6i6al6HtIGjZ6kMtJIoReNfPUAgL3l8tsnK/+1C9vL/fFcH6h5
 ngrjxOeKjoXkg11Xm+7Zw0knHAKsCjtDTIQLlZQMeWXmbP0i8FdZNQFtJl+EXFjCFLXfv8qPnSG
 QWHTaMyNtZLF8oByAP7rBcnW8O2u4udaDGSw+bt8a/ygCd3oh5g+mU+qpFq5/pukWeKU+OVPj5B
 CLL2jmFSMXSU6B4+5HA+eufFEizfU35aSBFZpkW3q5jO5KHQVhCNR/uIBJgIt9CX4k4QO/yNz3j
 hDTtM+rfPhXFkuw8JgseZ9XB5gC6jUKLJGUTd1g3OUzo2bqDDxjnDgRJmkO5fJtaN37Ta7CxxXg
 x3zCLmdcQRwOu0nAP+2rdmL+W9LFhSuBgc5hsWV0JQnJH61TZ+xZMwYgRSKJDuxcgeeUIo
X-Received: by 2002:a05:600c:4686:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-483739ff981mr371746545e9.3.1771511685011; 
 Thu, 19 Feb 2026 06:34:45 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:44 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 06/33] hw/core/fdt_generic: add cpu clusters management
Date: Thu, 19 Feb 2026 15:33:05 +0100
Message-ID: <20260219143332.3316679-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x344.google.com
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


