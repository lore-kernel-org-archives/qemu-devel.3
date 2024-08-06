Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54E2C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLcn-0001vo-1T; Tue, 06 Aug 2024 10:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbLcl-0001nu-2H
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbLci-0001xt-Ju
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722956235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4dymvc2MOazeFcHCfl7ctCRCuRvQ1KhpacdSK9eASs=;
 b=Vc59GZjFgKV7tcJ12o+U03j4/DHY52vBjd5aw3h3blNz6UOJqTgDtvUnyABi9O1pfFlYI4
 TtlV8GVQba/5yP3jszWf+jY2gl3rG5Q6bc7R3d9oImGRmqUQjHGpH9WZb9aQuKe/O2XYV5
 xetR6DBMlLk6UO/Jq0TwIoxOoSKQcNc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-AAV6wXJmOnCpweQBOdcjQw-1; Tue,
 06 Aug 2024 10:57:13 -0400
X-MC-Unique: AAV6wXJmOnCpweQBOdcjQw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D3E1955D4E; Tue,  6 Aug 2024 14:57:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.106])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9C1019560AE; Tue,  6 Aug 2024 14:57:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/5] ebpf: improve trace event coverage to all key operations
Date: Tue,  6 Aug 2024 15:56:53 +0100
Message-ID: <20240806145653.1632478-6-berrange@redhat.com>
In-Reply-To: <20240806145653.1632478-1-berrange@redhat.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The existing error trace event is renamed to have a name prefix
matching its source file & to remove the redundant first arg that
adds no useful information.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ebpf/ebpf_rss.c   | 29 ++++++++++++++++++++++++-----
 ebpf/trace-events |  6 +++++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 59854c8b51..8c42953475 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -53,7 +53,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_configuration, 0);
     if (ctx->mmap_configuration == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        trace_ebpf_rss_error(ctx, "can not mmap eBPF configuration array");
         error_setg(errp, "Unable to map eBPF configuration array");
         return false;
     }
@@ -61,7 +61,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_toeplitz_key, 0);
     if (ctx->mmap_toeplitz_key == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        trace_ebpf_rss_error(ctx, "can not mmap eBPF toeplitz key");
         error_setg(errp, "Unable to map eBPF toeplitz array");
         goto toeplitz_fail;
     }
@@ -69,11 +69,15 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_indirections_table, 0);
     if (ctx->mmap_indirections_table == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        trace_ebpf_rss_error(ctx, "can not mmap eBPF indirection table");
         error_setg(errp, "Unable to map eBPF indirection array");
         goto indirection_fail;
     }
 
+    trace_ebpf_rss_mmap(ctx,
+                        ctx->mmap_configuration,
+                        ctx->mmap_toeplitz_key,
+                        ctx->mmap_indirections_table);
     return true;
 
 indirection_fail:
@@ -108,7 +112,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
-        trace_ebpf_error("eBPF RSS", "can not open eBPF RSS object");
+        trace_ebpf_rss_error(ctx, "can not open eBPF RSS object");
         error_setg(errp, "Unable to open eBPF RSS object");
         goto error;
     }
@@ -116,7 +120,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
     bpf_program__set_type(rss_bpf_ctx->progs.tun_rss_steering_prog, BPF_PROG_TYPE_SOCKET_FILTER);
 
     if (rss_bpf__load(rss_bpf_ctx)) {
-        trace_ebpf_error("eBPF RSS", "can not load RSS program");
+        trace_ebpf_rss_error(ctx, "can not load RSS program");
         error_setg(errp, "Unable to load eBPF program");
         goto error;
     }
@@ -131,6 +135,11 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
+    trace_ebpf_rss_load(ctx,
+                        ctx->program_fd,
+                        ctx->map_configuration,
+                        ctx->map_indirections_table,
+                        ctx->map_toeplitz_key);
     if (!ebpf_rss_mmap(ctx, errp)) {
         goto error;
     }
@@ -178,6 +187,12 @@ bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
     ctx->map_toeplitz_key = toeplitz_fd;
     ctx->map_indirections_table = table_fd;
 
+    trace_ebpf_rss_load(ctx,
+                        ctx->program_fd,
+                        ctx->map_configuration,
+                        ctx->map_indirections_table,
+                        ctx->map_toeplitz_key);
+
     if (!ebpf_rss_mmap(ctx, errp)) {
         ctx->program_fd = -1;
         ctx->map_configuration = -1;
@@ -259,6 +274,8 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
 
     ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
 
+    trace_ebpf_rss_set_data(ctx, config, indirections_table, toeplitz_key);
+
     return true;
 }
 
@@ -268,6 +285,8 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
         return;
     }
 
+    trace_ebpf_rss_unload(ctx);
+
     ebpf_rss_munmap(ctx);
 
     if (ctx->obj) {
diff --git a/ebpf/trace-events b/ebpf/trace-events
index b3ad1a35f2..0202abd905 100644
--- a/ebpf/trace-events
+++ b/ebpf/trace-events
@@ -1,4 +1,8 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # ebpf-rss.c
-ebpf_error(const char *s1, const char *s2) "error in %s: %s"
+ebpf_rss_error(void *ctx, const char *s) "ctx=%p error=%s"
+ebpf_rss_load(void *ctx, int progfd, int cfgfd, int toepfd, int indirfd) "ctx=%p program-fd=%d config-fd=%d toeplitz-fd=%d indirection-fd=%d"
+ebpf_rss_mmap(void *ctx, void *cfgptr, void *toepptr, void *indirptr) "ctx=%p config-ptr=%p toeplitz-ptr=%p indirection-ptr=%p"
+ebpf_rss_unload(void *ctx) "rss unload ctx=%p"
+ebpf_rss_set_data(void *ctx, void *cfgptr, void *toepptr, void *indirptr) "ctx=%p config-ptr=%p toeplitz-ptr=%p indirection-ptr=%p"
-- 
2.45.2


