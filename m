Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A79CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWxd-000870-4F; Fri, 06 Sep 2024 07:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxC-0006bo-A8; Fri, 06 Sep 2024 07:16:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxA-000847-4Y; Fri, 06 Sep 2024 07:16:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C931D8C493;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D60AE1336FD;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353657 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Subject: [Stable-9.0.3 35/69] net: Reinstate '-net nic,
 model=help' output as documented in man page
Date: Fri,  6 Sep 2024 14:12:44 +0300
Message-Id: <20240906111324.353230-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While refactoring the NIC initialization code, I broke '-net nic,model=help'
which no longer outputs a list of available NIC models.

Fixes: 2cdeca04adab ("net: report list of available models according to platform")
Cc: qemu-stable@nongnu.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 64f75f57f9d2c8c12ac6d9355fa5d3a2af5879ca)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index a2f0c828bb..e6ca2529bb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1150,6 +1150,21 @@ NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
     return NULL;
 }
 
+static bool is_nic_model_help_option(const char *model)
+{
+    if (model && is_help_option(model)) {
+        /*
+         * Trigger the help output by instantiating the hash table which
+         * will gather tha available models as they get registered.
+         */
+        if (!nic_model_help) {
+            nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                                   g_free, NULL);
+        }
+        return true;
+    }
+    return false;
+}
 
 /* "I have created a device. Please configure it if you can" */
 bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
@@ -1733,6 +1748,12 @@ void net_check_clients(void)
 
 static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
 {
+    const char *model = qemu_opt_get_del(opts, "model");
+
+    if (is_nic_model_help_option(model)) {
+        return 0;
+    }
+
     return net_client_init(opts, false, errp);
 }
 
@@ -1789,9 +1810,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     memset(ni, 0, sizeof(*ni));
     ni->model = qemu_opt_get_del(opts, "model");
 
-    if (!nic_model_help && !g_strcmp0(ni->model, "help")) {
-        nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
-                                               g_free, NULL);
+    if (is_nic_model_help_option(ni->model)) {
         return 0;
     }
 
-- 
2.39.2


