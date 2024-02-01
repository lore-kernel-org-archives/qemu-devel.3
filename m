Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD13C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDy-0007nA-7q; Thu, 01 Feb 2024 11:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAq-0002qf-Rg
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAm-0002Sx-9a
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=XmoH6A+nBWef4HqrfR783ZSUxaA8W49f9I7azkQqtOs=; b=L6A48sQWTXEKiDU25DrwNLuuaH
 jz8bG/G9TFXNGvz3VBepCg/8rBwvUsjT47JtVVd2cFzRES5ZmumoHVsGLE2z21yel+9EE32r1YVVF
 9r5LfM2LixUlbf6Z/EZGBYrC6gw2u43xFOJ+Bu/HiW9EcfOQCGEzSgNEhRwTKegm3+jpepdX+RlN6
 KQogDHeHq4fXkIfHsHpdaObkPvgHqWJFPfaY0nY735qxQAm2qa1O2LtfyyqKlKYsRx8gujc8eYXMK
 p0IlFRca+FLZ3AQVIPzRv49Cy/3WSj7p+hjueS80in0TyZG+PcTQ05Xz2CvEDvvIjb798iBve1Kbx
 zbPBoj5A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAg-00000009cLy-0nwC for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003ILu-0U81 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/47] net: report list of available models according to
 platform
Date: Thu,  1 Feb 2024 16:43:27 +0000
Message-ID: <20240201164412.785520-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

By noting the models for which a configuration was requested, we can give
the user an accurate list of which NIC models were actually available on
the platform/configuration that was otherwise chosen.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 net/net.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/net/net.c b/net/net.c
index aeb7f573fc..962904eaef 100644
--- a/net/net.c
+++ b/net/net.c
@@ -75,6 +75,8 @@ typedef QSIMPLEQ_HEAD(, NetdevQueueEntry) NetdevQueue;
 
 static NetdevQueue nd_queue = QSIMPLEQ_HEAD_INITIALIZER(nd_queue);
 
+static GHashTable *nic_model_help;
+
 /***********************************************************/
 /* network device redirectors */
 
@@ -1087,12 +1089,94 @@ static int net_init_nic(const Netdev *netdev, const char *name,
     return idx;
 }
 
+static gboolean add_nic_result(gpointer key, gpointer value, gpointer user_data)
+{
+    GPtrArray *results = user_data;
+    GPtrArray *alias_list = value;
+    const char *model = key;
+    char *result;
+
+    if (!alias_list) {
+        result = g_strdup(model);
+    } else {
+        GString *result_str = g_string_new(model);
+        int i;
+
+        g_string_append(result_str, " (aka ");
+        for (i = 0; i < alias_list->len; i++) {
+            if (i) {
+                g_string_append(result_str, ", ");
+            }
+            g_string_append(result_str, alias_list->pdata[i]);
+        }
+        g_string_append(result_str, ")");
+        result = result_str->str;
+        g_string_free(result_str, false);
+        g_ptr_array_unref(alias_list);
+    }
+    g_ptr_array_add(results, result);
+    return true;
+}
+
+static int model_cmp(char **a, char **b)
+{
+    return strcmp(*a, *b);
+}
+
+static void show_nic_models(void)
+{
+    GPtrArray *results = g_ptr_array_new();
+    int i;
+
+    g_hash_table_foreach_remove(nic_model_help, add_nic_result, results);
+    g_ptr_array_sort(results, (GCompareFunc)model_cmp);
+
+    printf("Available NIC models for this configuration:\n");
+    for (i = 0 ; i < results->len; i++) {
+        printf("%s\n", (char *)results->pdata[i]);
+    }
+    g_hash_table_unref(nic_model_help);
+    nic_model_help = NULL;
+}
+
+static void add_nic_model_help(const char *model, const char *alias)
+{
+    GPtrArray *alias_list = NULL;
+
+    if (g_hash_table_lookup_extended(nic_model_help, model, NULL,
+                                     (gpointer *)&alias_list)) {
+        /* Already exists, no alias to add: return */
+        if (!alias) {
+            return;
+        }
+        if (alias_list) {
+            /* Check if this alias is already in the list. Add if not. */
+            if (!g_ptr_array_find_with_equal_func(alias_list, alias,
+                                                  g_str_equal, NULL)) {
+                g_ptr_array_add(alias_list, g_strdup(alias));
+            }
+            return;
+        }
+    }
+    /* Either this model wasn't in the list already, or a first alias added */
+    if (alias) {
+        alias_list = g_ptr_array_new();
+        g_ptr_array_set_free_func(alias_list, g_free);
+        g_ptr_array_add(alias_list, g_strdup(alias));
+    }
+    g_hash_table_replace(nic_model_help, g_strdup(model), alias_list);
+}
+
 NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
                             const char *alias)
 {
     NICInfo *nd;
     int i;
 
+    if (nic_model_help) {
+        add_nic_model_help(typename, alias);
+    }
+
     for (i = 0; i < nb_nics; i++) {
         nd = &nd_table[i];
 
@@ -1606,6 +1690,10 @@ void net_check_clients(void)
     NetClientState *nc;
     int i;
 
+    if (nic_model_help) {
+        show_nic_models();
+        exit(0);
+    }
     net_hub_check_clients();
 
     QTAILQ_FOREACH(nc, &net_clients, next) {
@@ -1685,6 +1773,12 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     memset(ni, 0, sizeof(*ni));
     ni->model = qemu_opt_get_del(opts, "model");
 
+    if (!nic_model_help && !g_strcmp0(ni->model, "help")) {
+        nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                               g_free, NULL);
+        return 0;
+    }
+
     /* Create an ID if the user did not specify one */
     nd_id = g_strdup(qemu_opts_id(opts));
     if (!nd_id) {
-- 
2.43.0


