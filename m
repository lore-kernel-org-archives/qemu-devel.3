Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE44FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFWmI-0006zx-SF; Thu, 15 May 2025 07:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFWmH-0006z5-1h; Thu, 15 May 2025 07:29:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFWmD-0007Yj-46; Thu, 15 May 2025 07:29:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DF817426D5;
 Thu, 15 May 2025 13:29:14 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de, idryomov@gmail.com
Subject: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
Date: Thu, 15 May 2025 13:29:07 +0200
Message-Id: <20250515112908.383693-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515112908.383693-1-f.ebner@proxmox.com>
References: <20250515112908.383693-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently, most Ceph configuration options are not exposed via QAPI.
While it is possible to specify a dedicated Ceph configuration file,
specialized options are often only required for a selection of images
on the RBD storage, not all of them. To avoid the need to generate a
dedicated Ceph configuration file for each image (or for each required
combination of options), support a selection of key-value pairs via
QAPI.

Initially, this is just 'rbd_cache_policy'. For example, this is
useful with small images used as a pflash for EFI variables. Setting
the 'rbd_cache_policy' to 'writeback' yields a substantial improvement
there [0].

The function qemu_rbd_extract_key_value_pairs() was copied/adapted
from the existing qemu_rbd_extract_encryption_create_options().

[0]: https://bugzilla.proxmox.com/show_bug.cgi?id=3329#c9

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/rbd.c          | 73 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 37 ++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 7446e66659..2924f23093 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -298,6 +298,27 @@ static int qemu_rbd_set_auth(rados_t cluster, BlockdevOptionsRbd *opts,
     return 0;
 }
 
+static int qemu_rbd_set_key_value_pairs(rados_t cluster,
+                                        RbdKeyValuePairs *key_value_pairs,
+                                        Error **errp)
+{
+    if (!key_value_pairs) {
+        return 0;
+    }
+
+    if (key_value_pairs->has_rbd_cache_policy) {
+        RbdCachePolicy value = key_value_pairs->rbd_cache_policy;
+        int r = rados_conf_set(cluster, "rbd_cache_policy",
+                               RbdCachePolicy_str(value));
+        if (r < 0) {
+            error_setg_errno(errp, -r, "could not set 'rbd_cache_policy'");
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
 static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
                                  Error **errp)
 {
@@ -791,6 +812,44 @@ exit:
     return ret;
 }
 
+static int qemu_rbd_extract_key_value_pairs(
+        QemuOpts *opts,
+        RbdKeyValuePairs **key_value_pairs,
+        Error **errp)
+{
+    QDict *opts_qdict;
+    QDict *key_value_pairs_qdict;
+    Visitor *v;
+    int ret = 0;
+
+    opts_qdict = qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &key_value_pairs_qdict,
+                           "key-value-pairs.");
+    qobject_unref(opts_qdict);
+    if (!qdict_size(key_value_pairs_qdict)) {
+        *key_value_pairs = NULL;
+        goto exit;
+    }
+
+    /* Convert options into a QAPI object */
+    v = qobject_input_visitor_new_flat_confused(key_value_pairs_qdict, errp);
+    if (!v) {
+        ret = -EINVAL;
+        goto exit;
+    }
+
+    visit_type_RbdKeyValuePairs(v, NULL, key_value_pairs, errp);
+    visit_free(v);
+    if (!*key_value_pairs) {
+        ret = -EINVAL;
+        goto exit;
+    }
+
+exit:
+    qobject_unref(key_value_pairs_qdict);
+    return ret;
+}
+
 static int coroutine_fn qemu_rbd_co_create_opts(BlockDriver *drv,
                                                 const char *filename,
                                                 QemuOpts *opts,
@@ -800,6 +859,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(BlockDriver *drv,
     BlockdevCreateOptionsRbd *rbd_opts;
     BlockdevOptionsRbd *loc;
     RbdEncryptionCreateOptions *encrypt = NULL;
+    RbdKeyValuePairs *key_value_pairs = NULL;
     Error *local_err = NULL;
     const char *keypairs, *password_secret;
     QDict *options = NULL;
@@ -848,6 +908,13 @@ static int coroutine_fn qemu_rbd_co_create_opts(BlockDriver *drv,
     loc->image       = g_strdup(qdict_get_try_str(options, "image"));
     keypairs         = qdict_get_try_str(options, "=keyvalue-pairs");
 
+    /* These are the key-value pairs coming in via the QAPI. */
+    ret = qemu_rbd_extract_key_value_pairs(opts, &key_value_pairs, errp);
+    if (ret < 0) {
+        goto exit;
+    }
+    loc->key_value_pairs = key_value_pairs;
+
     ret = qemu_rbd_do_create(create_options, keypairs, password_secret, errp);
     if (ret < 0) {
         goto exit;
@@ -937,6 +1004,12 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         goto failed_shutdown;
     }
 
+    /* For the key-value pairs coming via QAPI. */
+    r = qemu_rbd_set_key_value_pairs(*cluster, opts->key_value_pairs, errp);
+    if (r < 0) {
+        goto failed_shutdown;
+    }
+
     if (mon_host) {
         r = rados_conf_set(*cluster, "mon_host", mon_host);
         if (r < 0) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91c70e24a7..4666765e66 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4301,6 +4301,39 @@
   'data': { 'luks': 'RbdEncryptionCreateOptionsLUKS',
             'luks2': 'RbdEncryptionCreateOptionsLUKS2' } }
 
+##
+# @RbdCachePolicy:
+#
+# An enumeration of values for the 'rbd_cache_policy' Ceph
+# configuration setting.  See the Ceph documentation for details.
+#
+# @writearound: cachable writes return immediately, reads are not
+#     served from the cache.
+#
+# @writeback: cachable writes return immediately, reads are served
+#     from the cache.
+#
+# @writethrough: writes return only when the data is on disk for all
+#     replicas, reads are served from the cache.
+#
+# Since 10.1
+##
+{ 'enum' : 'RbdCachePolicy',
+  'data' : [ 'writearound', 'writeback', 'writethrough' ] }
+
+
+##
+# @RbdKeyValuePairs:
+#
+# Key-value pairs for Ceph configuration.
+#
+# @rbd-cache-policy: Ceph configuration option 'rbd_cache_policy'.
+#
+# Since 10.1
+##
+{ 'struct': 'RbdKeyValuePairs',
+  'data': { '*rbd-cache-policy': 'RbdCachePolicy' } }
+
 ##
 # @BlockdevOptionsRbd:
 #
@@ -4327,6 +4360,9 @@
 #     authentication.  This maps to Ceph configuration option "key".
 #     (Since 3.0)
 #
+# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
+#     (Since 10.1)
+#
 # @server: Monitor host address and port.  This maps to the "mon_host"
 #     Ceph option.
 #
@@ -4342,6 +4378,7 @@
             '*user': 'str',
             '*auth-client-required': ['RbdAuthMode'],
             '*key-secret': 'str',
+            '*key-value-pairs' : 'RbdKeyValuePairs',
             '*server': ['InetSocketAddressBase'] } }
 
 ##
-- 
2.39.5



