Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E65D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd7-0001cQ-5j; Mon, 26 Jan 2026 12:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcf-0001Jd-EU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:34 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQca-0008Tt-8E
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327555464cso3259024f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449406; x=1770054206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpWtN94Xa+aWszMSoi6aLvSs25LMajBLRGooOPWDaj8=;
 b=QyQK6smXyASpVKovj7huBqIoC3RxawqfVSanRv8SW/vG+G+3uMhXI59gBLcDicBXKe
 DqBpZ+6hV/vM4jzfplHCNFZxr5BjymADpNEXN46dMDJEx7NDOPXVXVvDB2vKj4yQCLZy
 qrZyZpA6isIhylL2mRE4ASUHFQZIN0A872xWcbTbf5+HIFHv8RQEFfIp89eyqqTQt9TP
 8vfLD6mkNXzSeg6R4UIBAEc0EOHm1G0DBLK5cpFZ4XJbtQkFszCKRtZ8jq9ql4JKrrQp
 ykYP/I+b3iwfa/frhcOb5bzGDyCQraO0dNOriwCIVygwKW601/Ri6cWmQNbi6yP2cF+H
 gWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449406; x=1770054206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OpWtN94Xa+aWszMSoi6aLvSs25LMajBLRGooOPWDaj8=;
 b=uOzQO8JQCsfZlzUOM+m9Rn98drjayfcI9/RWJGH2JHMaUpbCajsdf3y6jmekkZGMWw
 NiLqAcnJTpXNOcQg2co4U++xZ/WOvZ54tTttF/se/hqvI876+iSCM74C6WptS644pvWt
 85XnKk8uI9C4392ZnjRbgmOT7Sh0xo7NPIx64ZYMZmvGvcerOjmEEKAU5iYFoEJMD/57
 ccxjdM6oZY5Z5OPjn43rlb1JLLGDI/+E4oPo9tn6vYVbxRzIbbt4VkgorrBP2Xe+4I8Q
 dqHs+CaYbMFV3++cpKr52D3lR5UjkBJlBhE2cxXB5nJZQFTkf0Ht1unwAtYL2C8HzY4a
 tjNQ==
X-Gm-Message-State: AOJu0Yzev/4lb3CtgtavMki+SdianKBl8FmlDCz5tQkCB+ifZDg/KD54
 GgF/c/ZSKXtgI+E0+Ymw/ORu48O5o1CnkoeRzNltORyVJCt7tagMTkB4Tk7M/+lL
X-Gm-Gg: AZuq6aK9qPaMRhi5Wf1O1WHHlTuXCZllJ+vics16KhZzkArAfEzzrQBE0iAVboFY7Nn
 tQ5e8aqDB33JNn20+pMv9EJ+8B8y6Tq46bcD5LCeCb6PbjBJ/EIpc0F2Nt4uVhcKNfvOCf6jIRw
 Rx62WqVbsAq1FvPC5mcOXsCZPLWlm5P2nrpkFNeQ6OnCnsybowVXIri5DmyR4FdpRmsVKtNDbN1
 mpA170n8ss1ejXUWd8qKdZXjyVsQ5jQefx16SExXqJ/o8PK/clAQqT8nDdpYOTnwc1x8MyDqjuk
 jN6AguosaTowsRN9vFa2pgS8Hub/A6qhlE2W5xZ2oYYBJ5Ri1aqFJghSQSHNzt7IkTyQW38zh+L
 OzBlIYCmg790Kr7MugfRFrQrU8zcMpgnyDOzgh2RgBkSoAOhF1JPqe3VViUQq0B6184v2e8XGUU
 wF1JQB9yqFcTJxcus8RP1Oj16m8T/UZQ9nOftDlUC46wX5v7RRetTtQg==
X-Received: by 2002:a05:6000:2289:b0:430:c76b:fadd with SMTP id
 ffacd0b85a97d-435ca16783bmr8977031f8f.28.1769449405904; 
 Mon, 26 Jan 2026 09:43:25 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:25 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 02/27] system/device_tree: add few parsing and traversal
 helpers
Date: Mon, 26 Jan 2026 18:42:48 +0100
Message-ID: <20260126174313.1418150-3-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42f.google.com
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

The patch adds few utility functions for parsing FDT nodes.
The helpers are required for upcoming Hardware device tree
feature.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/device_tree.h |  30 ++++++
 system/device_tree.c         | 203 +++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+)

diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index f34b8b7ef9..458dbb74b4 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -90,6 +90,13 @@ int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
 int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
                              const char *property,
                              const char *target_node_path);
+
+uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
+                                     const char *property, int offset,
+                                     int size, Error **errp);
+const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
+                                    const char *property, int cell,
+                                    bool inherit, Error **errp);
 /**
  * qemu_fdt_getprop: retrieve the value of a given property
  * @fdt: pointer to the device tree blob
@@ -193,9 +200,32 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fdt,
                                                 qdt_tmp);                 \
     })
 
+typedef struct QEMUDevtreeProp {
+    char *name;
+    int len;
+    void *value;
+} QEMUDevtreeProp;
+
+/* node queries */
+
+char *qemu_devtree_get_node_name(void *fdt, const char *node_path);
+int qemu_devtree_get_num_children(void *fdt, const char *node_path, int depth);
+char **qemu_devtree_get_children(void *fdt, const char *node_path, int depth);
+int qemu_devtree_num_props(void *fdt, const char *node_path);
+QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path);
 
+/* node getters */
+
+int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
+                                  const char *cmpname);
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle);
 int qemu_devtree_getparent(void *fdt, char *node_path,
                            const char *current);
+int qemu_devtree_get_root_node(void *fdt, char *node_path);
+
+/* misc */
+
+int devtree_get_num_nodes(void *fdt);
 
 #define DT_PATH_LENGTH 1024
 
diff --git a/system/device_tree.c b/system/device_tree.c
index 41bde0ba5a..7091a4928e 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -451,6 +451,50 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
     return r;
 }
 
+const char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
+                                    const char *property, int cell,
+                                    bool inherit, Error **errp)
+{
+    int len;
+    const void *prop;
+    Error *err = NULL;
+
+    if (!errp) {
+        errp = &err;
+    }
+
+    prop = qemu_fdt_getprop(fdt, node_path, property, &len, inherit, errp);
+    if (*errp) {
+        return NULL;
+    }
+    while (cell) {
+        void *term = memchr(prop, '\0', len);
+        size_t diff;
+
+        if (!term) {
+            error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
+                      node_path, property, fdt_strerror(len));
+            return NULL;
+        }
+        diff = term - prop + 1;
+        len -= diff;
+        assert(len >= 0);
+        prop += diff;
+        cell--;
+    }
+
+    if (!len) {
+        return NULL;
+    }
+
+    if (!*(char *)prop) {
+        error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
+                  node_path, property, fdt_strerror(len));
+        return NULL;
+    }
+    return prop;
+}
+
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
                                const char *property, int offset,
                                bool inherit, Error **errp)
@@ -471,6 +515,22 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
     return be32_to_cpu(p[offset]);
 }
 
+uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
+                                     const char *property, int offset,
+                                     int size, Error **errp)
+{
+    uint64_t ret = 0;
+    for (; size; size--) {
+        ret <<= 32;
+        ret |= qemu_fdt_getprop_cell(fdt, node_path, property, offset++, false,
+                                     errp);
+        if (errp && *errp) {
+            return 0;
+        }
+    }
+    return ret;
+}
+
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
 {
     uint32_t r;
@@ -638,6 +698,117 @@ out:
     return ret;
 }
 
+char *qemu_devtree_get_node_name(void *fdt, const char *node_path)
+{
+    const char *ret = fdt_get_name(fdt, fdt_path_offset(fdt, node_path), NULL);
+    return ret ? strdup(ret) : NULL;
+}
+
+int qemu_devtree_num_props(void *fdt, const char *node_path)
+{
+    int offset = fdt_path_offset(fdt, node_path);
+    int ret = 0;
+
+    for (offset = fdt_first_property_offset(fdt, offset);
+            offset != -FDT_ERR_NOTFOUND;
+            offset = fdt_next_property_offset(fdt, offset)) {
+        ret++;
+    }
+    return ret;
+}
+
+QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path)
+{
+    QEMUDevtreeProp *ret = g_new0(QEMUDevtreeProp,
+                                    qemu_devtree_num_props(fdt, node_path) + 1);
+    int offset = fdt_path_offset(fdt, node_path);
+    int i = 0;
+
+    for (offset = fdt_first_property_offset(fdt, offset);
+            offset != -FDT_ERR_NOTFOUND;
+            offset = fdt_next_property_offset(fdt, offset)) {
+        const char *propname;
+        const void *val = fdt_getprop_by_offset(fdt, offset, &propname,
+                                                    &ret[i].len);
+
+        ret[i].name = g_strdup(propname);
+        ret[i].value = g_memdup2(val, ret[i].len);
+        i++;
+    }
+    return ret;
+}
+
+static void qemu_devtree_children_info(void *fdt, const char *node_path,
+        int depth, int *num, char **returned_paths) {
+    int offset = fdt_path_offset(fdt, node_path);
+    int root_depth = fdt_node_depth(fdt, offset);
+    int cur_depth = root_depth;
+
+    if (num) {
+        *num = 0;
+    }
+    for (;;) {
+        offset = fdt_next_node(fdt, offset, &cur_depth);
+        if (cur_depth <= root_depth) {
+            break;
+        }
+        if (cur_depth <= root_depth + depth || depth == 0) {
+            if (returned_paths) {
+                returned_paths[*num] = g_malloc0(DT_PATH_LENGTH);
+                fdt_get_path(fdt, offset, returned_paths[*num], DT_PATH_LENGTH);
+            }
+            if (num) {
+                (*num)++;
+            }
+        }
+    }
+}
+
+char **qemu_devtree_get_children(void *fdt, const char *node_path, int depth)
+{
+    int num_children = qemu_devtree_get_num_children(fdt, node_path, depth);
+    char **ret = g_malloc0(sizeof(*ret) * num_children);
+
+    qemu_devtree_children_info(fdt, node_path, depth, &num_children, ret);
+    return ret;
+}
+
+int qemu_devtree_get_num_children(void *fdt, const char *node_path, int depth)
+{
+    int ret;
+
+    qemu_devtree_children_info(fdt, node_path, depth, &ret, NULL);
+    return ret;
+}
+
+int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
+        const char *cmpname) {
+    int offset = 0;
+    char *name = NULL;
+
+    do {
+        char *at;
+
+        offset = fdt_next_node(fdt, offset, NULL);
+        name = (void *)fdt_get_name(fdt, offset, NULL);
+        if (!name) {
+            continue;
+        }
+        at = memchr(name, '@', strlen(name));
+        if (!strncmp(name, cmpname, at ? at - name : strlen(name))) {
+            break;
+        }
+    } while (offset > 0);
+    return offset > 0 ?
+        fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH) : 1;
+}
+
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle)
+{
+    return fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle),
+                            node_path, DT_PATH_LENGTH);
+}
+
 int qemu_devtree_getparent(void *fdt, char *node_path, const char *current)
 {
     int offset = fdt_path_offset(fdt, current);
@@ -648,6 +819,38 @@ int qemu_devtree_getparent(void *fdt, char *node_path, const char *current)
         fdt_get_path(fdt, parent_offset, node_path, DT_PATH_LENGTH) : 1;
 }
 
+int qemu_devtree_get_root_node(void *fdt, char *node_path)
+{
+    return fdt_get_path(fdt, 0, node_path, DT_PATH_LENGTH);
+}
+
+static void devtree_scan(void *fdt, int *num_nodes)
+{
+    int depth = 0, offset = 0;
+
+    if (num_nodes) {
+        *num_nodes = 0;
+    }
+    for (;;) {
+        offset = fdt_next_node(fdt, offset, &depth);
+        if (num_nodes) {
+            (*num_nodes)++;
+        }
+        if (offset <= 0 || depth <= 0) {
+            break;
+        }
+    }
+}
+
+int devtree_get_num_nodes(void *fdt)
+{
+    int ret;
+
+    devtree_scan(fdt, &ret);
+    return ret;
+}
+
+
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
     ERRP_GUARD();
-- 
2.43.0


