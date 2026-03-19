Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD58108E1F7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BiX-0007JI-Dd; Thu, 19 Mar 2026 07:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3BiU-0007Ik-G6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:06 -0400
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3BiR-0004bb-Sn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1773920337; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=G7AZ4K1LApZ83qpc7CCQiivvbVea9ymgYf/d/4iWmjM=;
 b=Jp9Gsz6GP3NynVO96NhxFEMFFE7ynQpb4UA5QeQJF0oan7I6qlQHQo2VafOcXtU+yHTCcG
 nnE40+tFfL6bAbZfhoTlHhyZydzG8+0EZ88pkow7pDbiMwWCrpqRYine6+hJN+aHgJU3q8
 J9E4AtLFScInyZ8V1xbKxS8WLfC/FEi/PrffjZcT5hyN52QIUtyQkX/eGvBh+qsr+3ueeG
 LrhVCPPMB58+Ai6UHUkJCTCnVR4HH61aMGyILXTM0Wxzidov52EfG+jFRILHjiXS0fS9tM
 ifQmNzR0InophUZVgDWkLI/DU/WKmKA2mM+DO+xniNdWPiPTY4sDyyRcaoge8g==
To: <qemu-devel@nongnu.org>
Subject: [RFC v2 1/2] migration: Support ghash migration
In-Reply-To: <20260319113830.53867-1-hongmianquan@bytedance.com>
Mime-Version: 1.0
Cc: <peterx@redhat.com>, <farosas@suse.de>, <mark.kanda@oracle.com>, 
 <bchaney@akamai.com>, "hongmianquan" <hongmianquan@bytedance.com>
X-Lms-Return-Path: <lba+269bbe04f+6297f1+nongnu.org+hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Content-Transfer-Encoding: 7bit
From: "hongmianquan" <hongmianquan@bytedance.com>
Date: Thu, 19 Mar 2026 19:38:29 +0800
Message-Id: <20260319113830.53867-2-hongmianquan@bytedance.com>
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
References: <20260319113830.53867-1-hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=209.127.230.115;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-115.ptr.blmpb.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Refer to commit 9a85e4b8f672016adbf7b7d5beaab2a99b9b5615 to
support for GHashTable migration. A custom save/restore is implemented.
Each item is made of a key and a data. Currently, only pointer-type
keys and values are supported.
On the get() path, ghashtable must be allocated using the proper
key compare, key destroy and value destroy. This must be handled
beforehand, for example in a pre_load method.

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
---
 include/migration/vmstate.h |  22 ++++++
 migration/trace-events      |   5 ++
 migration/vmstate-types.c   | 147 ++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20..cd7893c66a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ghash;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -882,6 +883,27 @@ extern const VMStateInfo vmstate_info_qlist;
     .start        = offsetof(_type, _next),                              \
 }
 
+/*
+ * For migrating a GHashTable whose key is a pointer to _key_type and the
+ * value, a pointer to _val_type
+ * The target hashtable must have been properly initialized
+ * _vmsd: Start address of the 2 element array containing the data vmsd
+ *        and the key vmsd, in that order
+ * _key_type: type of the key
+ * _val_type: type of the value
+ */
+#define VMSTATE_GHASH_V(_field, _state, _version, _vmsd,                       \
+                        _key_type, _val_type)                                  \
+{                                                                              \
+    .name         = (stringify(_field)),                                       \
+    .version_id   = (_version),                                                \
+    .vmsd         = (_vmsd),                                                   \
+    .info         = &vmstate_info_ghash,                                       \
+    .start        = sizeof(_key_type),                                         \
+    .size         = sizeof(_val_type),                                         \
+    .offset       = offsetof(_state, _field),                                  \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/migration/trace-events b/migration/trace-events
index 90629f828f..f00f4c3e74 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -86,6 +86,11 @@ get_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 put_qlist(const char *field_name, const char *vmsd_name, int version_id) "%s(%s v%d)"
 put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 
+get_ghash(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
+get_ghash_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
+put_ghash(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
+put_ghash_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
+
 # qemu-file.c
 qemu_file_fclose(void) ""
 qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb211472..e6c3573789 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -942,3 +942,150 @@ const VMStateInfo vmstate_info_qlist = {
     .get  = get_qlist,
     .put  = put_qlist,
 };
+
+struct put_ghash_data {
+    QEMUFile *f;
+    const VMStateDescription *key_vmsd;
+    const VMStateDescription *val_vmsd;
+    JSONWriter *vmdesc;
+    int ret;
+};
+
+static gboolean put_ghash_elem(gpointer key, gpointer value, gpointer data)
+{
+    struct put_ghash_data *capsule = (struct put_ghash_data *)data;
+    QEMUFile *f = capsule->f;
+    int ret;
+    Error *local_err = NULL;
+
+    qemu_put_byte(f, true);
+
+    /* put the key */
+    ret = vmstate_save_state(f, capsule->key_vmsd, key,
+                             capsule->vmdesc, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+        capsule->ret = ret;
+        return false;
+    }
+
+    /* put the data */
+    ret = vmstate_save_state(f, capsule->val_vmsd, value,
+                             capsule->vmdesc, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+        capsule->ret = ret;
+        return false;
+    }
+    return true;
+}
+
+static int put_ghash(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field, JSONWriter *vmdesc)
+{
+    const VMStateDescription *key_vmsd = &field->vmsd[1];
+    const VMStateDescription *val_vmsd = &field->vmsd[0];
+    struct put_ghash_data capsule = {
+        .f = f,
+        .key_vmsd = key_vmsd,
+        .val_vmsd = val_vmsd,
+        .vmdesc = vmdesc,
+        .ret = 0};
+    GHashTable **pval = pv;
+    GHashTable *hash = *pval;
+    GHashTableIter iter;
+    gpointer key, value;
+    uint32_t nnodes = g_hash_table_size(hash);
+    int ret;
+
+    trace_put_ghash(field->name, key_vmsd->name, val_vmsd->name, nnodes);
+    qemu_put_be32(f, nnodes);
+    g_hash_table_iter_init(&iter, hash);
+    while (g_hash_table_iter_next(&iter, &key, &value)) {
+        if (!put_ghash_elem(key, value, (gpointer)&capsule)) {
+            break;
+        }
+    }
+    qemu_put_byte(f, false);
+    ret = capsule.ret;
+    if (ret) {
+        error_report("%s : failed to save ghash (%d)", field->name, ret);
+    }
+    trace_put_ghash_end(field->name, key_vmsd->name, val_vmsd->name, ret);
+    return ret;
+}
+
+static int get_ghash(QEMUFile *f, void *pv, size_t unused_size,
+                     const VMStateField *field)
+{
+    const VMStateDescription *key_vmsd = &field->vmsd[1];
+    const VMStateDescription *val_vmsd = &field->vmsd[0];
+    int version_id = field->version_id;
+    size_t key_size = field->start;
+    size_t val_size = field->size;
+    int nnodes, count = 0;
+    GHashTable **pval = pv;
+    GHashTable *hash = *pval;
+    void *key, *val;
+    int ret = 0;
+    Error *local_err = NULL;
+
+    if (version_id > key_vmsd->version_id) {
+        error_report("%s %s", key_vmsd->name, "too new");
+        return -EINVAL;
+    }
+    if (version_id < key_vmsd->minimum_version_id) {
+        error_report("%s %s", key_vmsd->name, "too old");
+        return -EINVAL;
+    }
+    if (version_id > val_vmsd->version_id) {
+        error_report("%s %s", val_vmsd->name, "too new");
+        return -EINVAL;
+    }
+    if (version_id < val_vmsd->minimum_version_id) {
+        error_report("%s %s", val_vmsd->name, "too old");
+        return -EINVAL;
+    }
+
+    nnodes = qemu_get_be32(f);
+    trace_get_ghash(field->name, key_vmsd->name, val_vmsd->name, nnodes);
+
+    while (qemu_get_byte(f)) {
+        if ((++count) > nnodes) {
+            ret = -EINVAL;
+            break;
+        }
+        key = g_malloc0(key_size);
+        ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            goto key_error;
+        }
+        val = g_malloc0(val_size);
+        ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            goto val_error;
+        }
+        g_hash_table_insert(hash, key, val);
+    }
+    if (count != nnodes) {
+        error_report("%s inconsistent stream when loading the ghash",
+                     field->name);
+        return -EINVAL;
+    }
+    trace_get_ghash_end(field->name, key_vmsd->name, val_vmsd->name, ret);
+    return ret;
+val_error:
+    g_free(val);
+key_error:
+    g_free(key);
+    trace_get_ghash_end(field->name, key_vmsd->name, val_vmsd->name, ret);
+    return ret;
+}
+
+const VMStateInfo vmstate_info_ghash = {
+    .name = "ghash",
+    .get  = get_ghash,
+    .put  = put_ghash,
+};
-- 
2.32.1 (Apple Git-133)

