Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EA7D2E028
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5c-0000bf-21; Wed, 23 Oct 2024 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5a-0000bN-Np
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5Y-0007y4-O4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOy0M+pZ1YIuEVogD05eeqFI04wZPcBKgTld5bgrEf8=;
 b=KikJ4QwZTomARtROAtI9Cu7Q7H09sMYOq4ZZqGsTyac7cZLMpCZXeixoDWcy6fc8Bj5hEY
 B9iPbavwHov53RLLF6PtC/s+TjmbDCBpIt6CSTd/4fi3DdTeFGBvogcetui+XLQY2WM3F1
 gKHtF/6IrN9tFQu/hjHrp2ZNagKQKaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-qRYT9YIyNV2QugjYBlLWpw-1; Wed,
 23 Oct 2024 04:51:27 -0400
X-MC-Unique: qRYT9YIyNV2QugjYBlLWpw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63A01955EAD; Wed, 23 Oct 2024 08:51:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 683871956056; Wed, 23 Oct 2024 08:51:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 5/8] ebpf: add formal error reporting to all APIs
Date: Wed, 23 Oct 2024 09:51:00 +0100
Message-ID: <20241023085103.1980072-6-berrange@redhat.com>
In-Reply-To: <20241023085103.1980072-1-berrange@redhat.com>
References: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

The eBPF code is currently reporting error messages through trace
events. Trace events are fine for debugging, but they are not to be
considered the primary error reporting mechanism, as their output
is inaccessible to callers.

This adds an "Error **errp" parameter to all methods which have
important error scenarios to report to the caller.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ebpf/ebpf_rss-stub.c |  8 +++---
 ebpf/ebpf_rss.c      | 59 +++++++++++++++++++++++++++++++++++---------
 ebpf/ebpf_rss.h      | 10 +++++---
 hw/net/virtio-net.c  |  7 +++---
 4 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index 8d7fae2ad9..d0e7f99fb9 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -23,19 +23,21 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
     return false;
 }
 
-bool ebpf_rss_load(struct EBPFRSSContext *ctx)
+bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
     return false;
 }
 
 bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
-                       int config_fd, int toeplitz_fd, int table_fd)
+                       int config_fd, int toeplitz_fd, int table_fd,
+                       Error **errp)
 {
     return false;
 }
 
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
-                      uint16_t *indirections_table, uint8_t *toeplitz_key)
+                      uint16_t *indirections_table, uint8_t *toeplitz_key,
+                      Error **errp)
 {
     return false;
 }
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index d39916b368..67cdab197d 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -47,13 +47,14 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
     return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
 }
 
-static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
+static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
 {
     ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_configuration, 0);
     if (ctx->mmap_configuration == MAP_FAILED) {
         trace_ebpf_rss_mmap_error(ctx, "configuration");
+        error_setg(errp, "Unable to map eBPF configuration array");
         return false;
     }
     ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
@@ -61,6 +62,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
                                    ctx->map_toeplitz_key, 0);
     if (ctx->mmap_toeplitz_key == MAP_FAILED) {
         trace_ebpf_rss_mmap_error(ctx, "toeplitz key");
+        error_setg(errp, "Unable to map eBPF toeplitz array");
         goto toeplitz_fail;
     }
     ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
@@ -68,6 +70,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
                                    ctx->map_indirections_table, 0);
     if (ctx->mmap_indirections_table == MAP_FAILED) {
         trace_ebpf_rss_mmap_error(ctx, "indirections table");
+        error_setg(errp, "Unable to map eBPF indirection array");
         goto indirection_fail;
     }
 
@@ -95,7 +98,7 @@ static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
     ctx->mmap_indirections_table = NULL;
 }
 
-bool ebpf_rss_load(struct EBPFRSSContext *ctx)
+bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
     struct rss_bpf *rss_bpf_ctx;
 
@@ -106,6 +109,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
         trace_ebpf_rss_open_error(ctx);
+        error_setg(errp, "Unable to open eBPF RSS object");
         goto error;
     }
 
@@ -113,6 +117,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 
     if (rss_bpf__load(rss_bpf_ctx)) {
         trace_ebpf_rss_load_error(ctx);
+        error_setg(errp, "Unable to load eBPF program");
         goto error;
     }
 
@@ -126,7 +131,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
-    if (!ebpf_rss_mmap(ctx)) {
+    if (!ebpf_rss_mmap(ctx, errp)) {
         goto error;
     }
 
@@ -143,13 +148,28 @@ error:
 }
 
 bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
-                       int config_fd, int toeplitz_fd, int table_fd)
+                       int config_fd, int toeplitz_fd, int table_fd,
+                       Error **errp)
 {
     if (ebpf_rss_is_loaded(ctx)) {
+        error_setg(errp, "eBPF program is already loaded");
         return false;
     }
 
-    if (program_fd < 0 || config_fd < 0 || toeplitz_fd < 0 || table_fd < 0) {
+    if (program_fd < 0) {
+        error_setg(errp, "eBPF program FD is not open");
+        return false;
+    }
+    if (config_fd < 0) {
+        error_setg(errp, "eBPF config FD is not open");
+        return false;
+    }
+    if (toeplitz_fd < 0) {
+        error_setg(errp, "eBPF toeplitz FD is not open");
+        return false;
+    }
+    if (table_fd < 0) {
+        error_setg(errp, "eBPF indirection FD is not open");
         return false;
     }
 
@@ -158,7 +178,7 @@ bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
     ctx->map_toeplitz_key = toeplitz_fd;
     ctx->map_indirections_table = table_fd;
 
-    if (!ebpf_rss_mmap(ctx)) {
+    if (!ebpf_rss_mmap(ctx, errp)) {
         ctx->program_fd = -1;
         ctx->map_configuration = -1;
         ctx->map_toeplitz_key = -1;
@@ -177,11 +197,14 @@ static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
 
 static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
-                                            size_t len)
+                                            size_t len,
+                                            Error **errp)
 {
     char *cursor = ctx->mmap_indirections_table;
 
     if (len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        error_setg(errp, "Indirections table length %zu exceeds limit %d",
+                   len, VIRTIO_NET_RSS_MAX_TABLE_LEN);
         return false;
     }
 
@@ -206,17 +229,31 @@ static void ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
 }
 
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
-                      uint16_t *indirections_table, uint8_t *toeplitz_key)
+                      uint16_t *indirections_table, uint8_t *toeplitz_key,
+                      Error **errp)
 {
-    if (!ebpf_rss_is_loaded(ctx) || config == NULL ||
-        indirections_table == NULL || toeplitz_key == NULL) {
+    if (!ebpf_rss_is_loaded(ctx)) {
+        error_setg(errp, "eBPF program is not loaded");
+        return false;
+    }
+    if (config == NULL) {
+        error_setg(errp, "eBPF config table is NULL");
+        return false;
+    }
+    if (indirections_table == NULL) {
+        error_setg(errp, "eBPF indirections table is NULL");
+        return false;
+    }
+    if (toeplitz_key == NULL) {
+        error_setg(errp, "eBPF toeplitz key is NULL");
         return false;
     }
 
     ebpf_rss_set_config(ctx, config);
 
     if (!ebpf_rss_set_indirections_table(ctx, indirections_table,
-                                      config->indirections_len)) {
+                                         config->indirections_len,
+                                         errp)) {
         return false;
     }
 
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index 239242b0d2..86a5787789 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_EBPF_RSS_H
 #define QEMU_EBPF_RSS_H
 
+#include "qapi/error.h"
+
 #define EBPF_RSS_MAX_FDS 4
 
 struct EBPFRSSContext {
@@ -41,13 +43,15 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
-bool ebpf_rss_load(struct EBPFRSSContext *ctx);
+bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp);
 
 bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
-                       int config_fd, int toeplitz_fd, int table_fd);
+                       int config_fd, int toeplitz_fd, int table_fd,
+                       Error **errp);
 
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
-                      uint16_t *indirections_table, uint8_t *toeplitz_key);
+                      uint16_t *indirections_table, uint8_t *toeplitz_key,
+                      Error **errp);
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7c050246ea..289fba8152 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1265,7 +1265,8 @@ static bool virtio_net_attach_ebpf_rss(VirtIONet *n)
     rss_data_to_rss_config(&n->rss_data, &config);
 
     if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
-                          n->rss_data.indirections_table, n->rss_data.key)) {
+                          n->rss_data.indirections_table, n->rss_data.key,
+                          NULL)) {
         return false;
     }
 
@@ -1336,7 +1337,7 @@ static bool virtio_net_load_ebpf_fds(VirtIONet *n)
         }
     }
 
-    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
+    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3], NULL);
 
 exit:
     if (!ret) {
@@ -1354,7 +1355,7 @@ static bool virtio_net_load_ebpf(VirtIONet *n)
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
         if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
-            ret = ebpf_rss_load(&n->ebpf_rss);
+            ret = ebpf_rss_load(&n->ebpf_rss, NULL);
         }
     }
 
-- 
2.46.0


