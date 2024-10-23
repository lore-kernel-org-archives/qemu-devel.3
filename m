Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC684D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X5q-0000cy-G6; Wed, 23 Oct 2024 04:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5o-0000cI-5o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X5m-00083N-Lm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wKf41dLp7c98epQlQNKz9nwJiWUPVqLqX8g/XIo87E=;
 b=Rt9CUSvk8sCS243oz1yzXNNoO3bpJHfecUWxXzgn64dT6T0uvr2pFgcpAV5oxIFQNeLp7C
 KOx7a+Gi2s8KHJniqNY1MCi2attNPBgoTEWawAonr39HGY6LklJpzyuPj+BZ9KImKsCaIL
 1xnhQaAPuhRbuMlSuxD+CuxT3lylxaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-aDdk8np9PBWU-OHDGGn2Pw-1; Wed,
 23 Oct 2024 04:51:35 -0400
X-MC-Unique: aDdk8np9PBWU-OHDGGn2Pw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C96195608B; Wed, 23 Oct 2024 08:51:34 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 341821955EA3; Wed, 23 Oct 2024 08:51:30 +0000 (UTC)
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
Subject: [PATCH v3 7/8] ebpf: improve trace event coverage to all key
 operations
Date: Wed, 23 Oct 2024 09:51:02 +0100
Message-ID: <20241023085103.1980072-8-berrange@redhat.com>
In-Reply-To: <20241023085103.1980072-1-berrange@redhat.com>
References: <20241023085103.1980072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The existing error trace event is renamed to have a name prefix
matching its source file & to remove the redundant first arg that
adds no useful information.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ebpf/ebpf_rss.c   | 19 +++++++++++++++++++
 ebpf/trace-events |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 67cdab197d..e793786c17 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -74,6 +74,10 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
         goto indirection_fail;
     }
 
+    trace_ebpf_rss_mmap(ctx,
+                        ctx->mmap_configuration,
+                        ctx->mmap_toeplitz_key,
+                        ctx->mmap_indirections_table);
     return true;
 
 indirection_fail:
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
index a0f157be37..bf3d9b6451 100644
--- a/ebpf/trace-events
+++ b/ebpf/trace-events
@@ -1,6 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # ebpf-rss.c
+ebpf_rss_load(void *ctx, int progfd, int cfgfd, int toepfd, int indirfd) "ctx=%p program-fd=%d config-fd=%d toeplitz-fd=%d indirection-fd=%d"
 ebpf_rss_load_error(void *ctx) "ctx=%p"
+ebpf_rss_mmap(void *ctx, void *cfgptr, void *toepptr, void *indirptr) "ctx=%p config-ptr=%p toeplitz-ptr=%p indirection-ptr=%p"
 ebpf_rss_mmap_error(void *ctx, const char *object) "ctx=%p object=%s"
 ebpf_rss_open_error(void *ctx) "ctx=%p"
+ebpf_rss_set_data(void *ctx, void *cfgptr, void *toepptr, void *indirptr) "ctx=%p config-ptr=%p toeplitz-ptr=%p indirection-ptr=%p"
+ebpf_rss_unload(void *ctx) "rss unload ctx=%p"
-- 
2.46.0


