Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A303CD98FE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGzW-0006Ba-A2; Thu, 05 Sep 2024 14:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzO-0005rg-Lc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smGzN-0001II-2T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725560027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gKQxkSU8pAyHZ+WgFRtKo1vyQQVE3H2sHGvZSNk/Hw=;
 b=LHGtOb8mCDZVJs+REb4ZREYHcoHon2xhAjGmmYOCnLxlqcCbt+Vy7LhQIwHu6pyKezjJKM
 TaYk4oPGM32gef4ooOsAx1eHQlwRu/QEf19dblZrM+UBjN28vBhhXIPqH73bMgYv4YROf5
 xJryBBzj1BoNBsizbKrlZQ97aGExVxQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-1noywOAHNGyordMMp29NmA-1; Thu,
 05 Sep 2024 14:13:44 -0400
X-MC-Unique: 1noywOAHNGyordMMp29NmA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98B891955F45; Thu,  5 Sep 2024 18:13:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A51B319560AA; Thu,  5 Sep 2024 18:13:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/7] ebpf: improve error trace events
Date: Thu,  5 Sep 2024 19:13:26 +0100
Message-ID: <20240905181330.3657590-4-berrange@redhat.com>
In-Reply-To: <20240905181330.3657590-1-berrange@redhat.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

A design pattern of

   trace_foo_error("descriptive string")

is undesirable because it does not allow for filtering trace events
based on the error scenario. Split eBPF error trace event into three
separate events to address this filtering need.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ebpf/ebpf_rss.c   | 10 +++++-----
 ebpf/trace-events |  4 +++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index aa7170d997..47186807ad 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -53,21 +53,21 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_configuration, 0);
     if (ctx->mmap_configuration == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        trace_ebpf_rss_mmap_error(ctx, "configuration");
         return false;
     }
     ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_toeplitz_key, 0);
     if (ctx->mmap_toeplitz_key == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        trace_ebpf_rss_mmap_error(ctx, "toeplitz key");
         goto toeplitz_fail;
     }
     ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
                                    PROT_READ | PROT_WRITE, MAP_SHARED,
                                    ctx->map_indirections_table, 0);
     if (ctx->mmap_indirections_table == MAP_FAILED) {
-        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        trace_ebpf_rss_mmap_error(ctx, "indirections table");
         goto indirection_fail;
     }
 
@@ -105,14 +105,14 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
-        trace_ebpf_error("eBPF RSS", "can not open eBPF RSS object");
+        trace_ebpf_rss_open_error(ctx);
         goto error;
     }
 
     bpf_program__set_type(rss_bpf_ctx->progs.tun_rss_steering_prog, BPF_PROG_TYPE_SOCKET_FILTER);
 
     if (rss_bpf__load(rss_bpf_ctx)) {
-        trace_ebpf_error("eBPF RSS", "can not load RSS program");
+        trace_ebpf_rss_load_error(ctx);
         goto error;
     }
 
diff --git a/ebpf/trace-events b/ebpf/trace-events
index b3ad1a35f2..a0f157be37 100644
--- a/ebpf/trace-events
+++ b/ebpf/trace-events
@@ -1,4 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # ebpf-rss.c
-ebpf_error(const char *s1, const char *s2) "error in %s: %s"
+ebpf_rss_load_error(void *ctx) "ctx=%p"
+ebpf_rss_mmap_error(void *ctx, const char *object) "ctx=%p object=%s"
+ebpf_rss_open_error(void *ctx) "ctx=%p"
-- 
2.45.2


