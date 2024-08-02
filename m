Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295EEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZiqI-0006b8-RZ; Thu, 01 Aug 2024 23:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZiqG-0006E5-9d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZiq8-0000GQ-P0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AnZaL0zp9IvvGokEEaSQs7FqBYwJkhZko8nE8QpANLI=;
 b=UvCWsrAR7mcqOWcwi4n0iXyYGG7EzxJJAnoOGhgHeHAofPrHVfjReUXpbFx5ZALDWDfBRv
 lyV0i/PPcu3zbGZ8mCfg2f4xYZ8gLVLn3qwDaKpq8bTxPZpfR6FrJCjM0iFwqreG4K770j
 gkJ2GQ1FHjeUABcTD7NKboYPp5YKwsc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-Cndk9v5KPiKDXFAjIHywfw-1; Thu,
 01 Aug 2024 23:20:20 -0400
X-MC-Unique: Cndk9v5KPiKDXFAjIHywfw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF6641955D52; Fri,  2 Aug 2024 03:20:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEE54300018D; Fri,  2 Aug 2024 03:20:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 8/8] net: Reinstate '-net nic,
 model=help' output as documented in man page
Date: Fri,  2 Aug 2024 11:19:29 +0800
Message-ID: <20240802031929.44060-9-jasowang@redhat.com>
In-Reply-To: <20240802031929.44060-1-jasowang@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 net/net.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index 6938da05e0..2eb8bc9c0b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1139,6 +1139,21 @@ NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
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
@@ -1722,6 +1737,12 @@ void net_check_clients(void)
 
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
 
@@ -1778,9 +1799,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     memset(ni, 0, sizeof(*ni));
     ni->model = qemu_opt_get_del(opts, "model");
 
-    if (!nic_model_help && !g_strcmp0(ni->model, "help")) {
-        nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
-                                               g_free, NULL);
+    if (is_nic_model_help_option(ni->model)) {
         return 0;
     }
 
-- 
2.42.0


